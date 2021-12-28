import sys
from os import close, putenv
from typing import List
from itertools import cycle
from des import des
from Crypto.Cipher import DES3
from hashlib import md5


def split_string(word):
    return [char for char in word]


def xor(file, key):
    return bytes(a ^ b for a, b in zip(file, cycle(key)))


def cesar_crypt(key, letter):
    if 65 <= ord(letter) <= 90:
        return chr(65 + (ord(letter - 65 + key)) % 26)
    elif 97 <= ord(letter) <= 122:
        return chr(97 + (ord(letter) - 97 + key) % 26)
    else:
        return chr(ord(letter))


def plain_to_base64(data):
    pass


def plain_to_base32(data):
    pass


def plain_to_hexa(data):
    pass


def plain_to_bin(data):
    pass


def cesar(file, key):
    cpt = 0
    ciphertext = ""
    cesar_letter = split_string(key)

    with open(file, "rb") as in_file:
        for word in in_file:
            for character in word:
                ciphertext += cesar_crypt(
                    cesar_letter[cpt % len(cesar_letter)], character
                )

            cpt = cpt + 1

            with open("cesar.txt", "w") as o_file:
                o_file.write(ciphertext)


def vigenere(file, key):
    cpt = 0
    ciphertext = ""
    cesar_letter = split_string(key)

    with open(file, "rb") as in_file:
        for word in in_file:
            for character in word:
                ciphertext += cesar_crypt(
                    cesar_letter[cpt % len(cesar_letter)], character
                )

                cpt = cpt + 1

            with open("vigenere.txt", "w") as o_file:
                o_file.write(ciphertext)


def enigma(file, key):
    pass


def DES(file, key):
    d = des()
    bytes = d.encrypt(key, file)
    path = ""
    with open(path, "wb") as o_file:
        o_file.write(bytes)


def TRIPLE_DES(file, key):
    hash_key = md5(key.encode("ascii")).digest()
    TDES_key = DES3.adjust_key_parity(hash_key)
    encrypted = DES3.new(TDES_key, DES3.MODE_CBC, nonce=b"0")
    path = ""
    myfile = file.read()
    bytes = encrypted.encrypt(myfile)

    with open(path, "wb") as o_file:
        o_file.write(bytes)


def AES(file, key):
    pass


"""
Ordre de chiffrage : césar vigenère xor enigma des aes 

"""


def encryption(key):
    pass


def main(argv):
    key = b"ceciestunecle"
    with open(
        "/home/enzo/Documents/Projet_secu/Projet_secu_INSA2021/ctf_difficile/src/test.txt",
        "rb",
    ) as encry, open("test2.txt", "wb") as decry:
        decry.write(xor(encry.read(), key))


if __name__ == "__main__":
    main(sys.argv)
