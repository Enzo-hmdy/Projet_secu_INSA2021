import os
import sys
import struct
from os import close, putenv, urandom
from typing import List
from itertools import cycle, islice
from des import des
from Cryptodome.Cipher import DES3, AES
from hashlib import md5, sha256
import functools
import operator
import random


def split_string(word):
    return [char for char in word]


def xor(file, key):
    """Réalise un xor entre un fichier entrée et une clé

    Args:
        file (File object): Fichier lu sous forme de caractères 
        key (String): Clée de chiffrement

    Returns:
        bytes: Chaine d'octet obtenue après le xor 
    """

    return bytes(a ^ b for a, b in zip(file, cycle(key)))


def cesar_crypt(key, letter):
    """Réalise le décalage de césar/vigenère 

    Args:
        key (String):  Clé de chiffrement 
        letter (String): Un caractère quelconque 

    Returns:
        String: Nouveau caractère après le shift
    """
    if 65 <= ord(letter) <= 90:  # Gestion des majuscules 
        return chr(65 + (ord(letter) - 65 + ord(key)) % 26) # ord renvoit la valeur ascii d'un caractère
    elif 97 <= ord(letter) <= 122: # Gestion minuscules 
        return chr(97 + (ord(letter) - 97 + ord(key)) % 26) # Chr renvoit le caractères associé à une valeur ascii
    elif 48 <= ord(letter) <= 57: # Gestion Chiffres 
        return chr(48 + (ord(letter) - 48 + ord(key)) % 10)
    else:  # Pour le reste on revoit le caractères 
        return str(letter)


def cesar(in_file, key, o_file):
    """Réalise le chiffrement de césar, mais change de clé, pour chaque ligne du fichier afin de limiter
    les possibilites de brute force

    Args:
        in_file (File object): Fichier qu'on est en train de lire 
        key String: Clé de chiffrement
        o_file (File object ): Fichier dans lequel on va écrire
    """
    cpt = 0 # Initialisation compteur 
    ciphertext = "" # On créer un texte chiffré qui n'a aucun caractère au début
    cesar_letter = split_string(key) # On sépart la clée afin d'avoir chaque caractère séparer dans une liste
    for word in in_file: # On lit chaque ligne du fichier 

        for character in word: # On regarde chaque caractères pour chaque ligne 
            ciphertext += cesar_crypt(cesar_letter[cpt % len(cesar_letter)], character)
            # Pour chaque caractère on ajoute au texte brouillé, la nouvelle lettre après le décalage 

        cpt = cpt + 1 # Incrémentation du compteur a chaque nouvelle ligne pour changé la clée

    o_file.write(ciphertext) # On écrit dans le fichier le texte chiffré


def vigenere(in_file, key, o_file):
    """Réaliste le chiffrement de vigenère

    Args:
        in_file (File object): Fichier qu'on est en train de lire 
        key String: Clé de chiffrement
        o_file (File object ): Fichier dans lequel on va écrire
    """
    cpt = 0 #Initalisation du compteur à 0 
    ciphertext = ""  #On créer un texte chiffré qui n'a aucun caractère au début
    cesar_letter = split_string(key)# On sépart la clée afin d'avoir chaque caractère séparer dans une liste
    for word in in_file: # On lit chaque ligne du fichier 
        for character in word: # On regarde chaque caractères pour chaque ligne 
            ciphertext += cesar_crypt(cesar_letter[cpt % len(cesar_letter)], character)
            # On réaliste le décalage selon la lettre de la clé et la lettre du fichier 
            cpt = cpt + 1 # On incrémente le compteur pour changer la lettre avec lequel on effectue  le décalage pour chaque caractères 

    o_file.write(ciphertext) # on écrit le fichier 


def DES(file, key, path):
    d = des()
    bytes = d.encrypt(key, file)
    path.write(bytes)


def TRIPLE_DES(file, key, o_file):
    """triple DES Algorithme

    Args:
        file (File object: Fichier que l'on veut chiffré
        key (String): Clée avec lequel on va chiffré 
        o_file (File object): Fichier dans lequel on va écrire 
    """
    hash_key = md5(key.encode("ascii")).digest() # On récupère sous forme d'octet la clée
    # On obient alors une clée de longueur 16 ce qui est necessaire pour le triple DES 
    TDES_key = DES3.adjust_key_parity(hash_key) # On ajuste la parité de la clée necessaire pour que cela fonctionne
    encrypted = DES3.new(TDES_key, DES3.MODE_EAX, nonce=b"0")
    # On créer un object DES3, avec comme paramètre la clée de longueur 16 dont on a ajuster la parité
    # On précise le mode necessaire ici le choix de du mode de chiffrage ici le choix de EAX (encrypt-then-authenticate-then-translate) a été fait
    # On set le nonce (Chiffre choisit arbitrairement ) utilisé dans le chiffrage pour empécher des attaques par rejeu
    # Dans le cas où certaines communications seraient interceptées 
    myfile = file.read() # On lit le fichier en entrée 
    bytes = encrypted.encrypt(myfile) # On créer une grande chaines d'octet correspondant au chiffrement de l'objet 3DES
    # Qui a eu en entrée le fichier que l'on veut chiffré

    o_file.write(bytes) # On écrit dans le fichier de sortie 


def ency_AES(i_file, key, o_file, path_name, size=64 * 1024):
    """ Implémentation du chiffrement AES avec la bibliothèque cryptodome

    Args:
        i_file (File object): fichier que l'on va lire et chiffré
        key (String ): Clée de chiffrement 
        o_file (file object): Fichier dans lequel on a écrire 
        path_name (String):  Path absolue du fichier que l'on va 
        size (int), optional): Taille des bloc qu'on va lire doit être un multiple de 16 . Defaults to 64*1024.
    """
    iv = os.urandom(16) # Création du vecteur d'intialisation d'une taille de 16 octets
    # Cela est necessaire pour pour mettre le chiffremment en mode CBC du premier bloc
    hash_key = sha256(key.encode("ascii")).digest() #On transforme la clée en une chaine d'octet de taille 16 
    encryptor = AES.new(hash_key, AES.MODE_CBC, iv) #  Création de l'objet AES
    # En entrée La clée "hashé", le mode de chiffrement ici CBC (avantage : confusion totale ), et notre vecteur d'initialisation

    filesize = os.path.getsize(path_name) #On récupère la taille du fichier que l'on va lire 

    o_file.write(struct.pack("<Q", filesize)) # On écrit dans le fichier de sortie la taille du fichier originale
    # En utilisant le package struct permettant la manupilation de bit mais sous forme d'octet 
    o_file.write(iv) # On écrit au début du fichier le vecteur d'initilisation (necessaire pour le déchiffrement par la suite )
    while True: # On lit tout le fichier 
        bloc = i_file.read(size) # On lit le bloc de la taille qu'on a passé en entrée 
        if len(bloc) == 0: #Si On a finnit de lire on quitte la boucle
            break
        elif len(bloc) % 16 != 0: # Sinon on continue
            bloc += b" " * (16 - len(bloc) % 16) # On fait du padding avec des espaces  pour remplir la fin du fichier pour que cela devienne un multiple de 16 

        o_file.write(encryptor.encrypt(bloc)) # On écrit dans le fichier 



def main(argv):

    key1 , key2,key3,key4,key5  = sys.argv[2],sys.argv[3],sys.argv[4],sys.argv[5],bytes(sys.argv[6],"utf8")
    #On lit ce que l'utilisation a mis comme clée lors de l'éxécution du script

    # On récupère le path du fichié que l'on veut récupérer 
    relative_path = sys.argv[1]

    # On transforme ce chemin relatif en chemin absolue
    full_path = os.path.abspath(relative_path)

    
    with open(
        full_path,
        "r",
    ) as encry, open("test1.txt", "w+") as o_file:
        cesar(encry, key1, o_file)
    os.remove(relative_path)
    os.rename("test1.txt", relative_path)

    with open(
        full_path,
        "r",
    ) as encry, open("test1.txt", "w+") as o_file:
        vigenere(encry, key2, o_file)
    os.remove(relative_path)
    os.rename("test1.txt", relative_path)
    
    with open(
        full_path,
        "rb",
    ) as encry, open("test1.txt", "wb") as o_file:
        ency_AES(
            encry,
            key3,
            o_file,
            full_path,
        )
    os.remove(relative_path)
    os.rename("test1.txt", relative_path)
    
    
    with open(
        full_path,
        "rb",
    ) as encry, open("test1.txt", "wb") as o_file:
        TRIPLE_DES(
            encry,
            key4,
            o_file,
        )
    os.remove(relative_path)
    os.rename("test1.txt", relative_path)
    
    
    
    with open(
        full_path,
        "rb",
    ) as encry, open("test1.txt", "wb") as o_file:
        o_file.write(xor(encry.read(), key5))
        
    os.remove(relative_path)
    os.rename("test1.txt", relative_path)



if __name__ == "__main__":
    main(sys.argv)
