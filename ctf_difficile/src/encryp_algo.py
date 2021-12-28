import sys
from os import close, putenv
from typing import List
from itertools import cycle, islice
from des import des
from Cryptodome.Cipher import DES3
from hashlib import md5
import functools
import operator


def split_string(word):
    return [char for char in word]


def xor(file, key):
    return bytes(a ^ b for a, b in zip(file, cycle(key)))


def cesar_crypt(key, letter):
    if 65 <= ord(letter) <= 90:
        return chr(65 + (ord(letter) - 65 + ord(key)) % 26)
    elif 97 <= ord(letter) <= 122:
        return chr(97 + (ord(letter) - 97 + ord(key)) % 26)
    else:

        return str(letter)


def plain_to_base64(data):
    pass


def plain_to_base32(data):
    pass


def plain_to_hexa(data):
    pass


def plain_to_bin(data):
    pass


def cesar(in_file, key, o_file):
    cpt = 0
    ciphertext = ""
    cesar_letter = split_string(key)
    for word in in_file:
        print(word)

        for character in word:
            print(character)
            ciphertext += cesar_crypt(cesar_letter[cpt % len(cesar_letter)], character)

        cpt = cpt + 1

    o_file.write(ciphertext)


def vigenere(in_file, key, o_file):
    cpt = 0
    ciphertext = ""
    cesar_letter = split_string(key)
    for word in in_file:
        print(word)

        for character in word:
            print(character)
            ciphertext += cesar_crypt(cesar_letter[cpt % len(cesar_letter)], character)

            cpt = cpt + 1

    o_file.write(ciphertext)


def enigma(file, key):
    pass


def DES(file, key, path):
    d = des()
    bytes = d.encrypt(key, file)
    path.write(bytes)


def TRIPLE_DES(file, key, path):
    hash_key = md5(key.encode("ascii")).digest()
    TDES_key = DES3.adjust_key_parity(hash_key)
    encrypted = DES3.new(TDES_key, DES3.MODE_EAX, nonce=b"0")
    myfile = file.read()
    bytes = encrypted.encrypt(myfile)

    path.write(bytes)


def AES(file, key):
    pass


"""
Ordre de chiffrage : césar vigenère xor enigma des aes 

"""


def main(argv):
    key = b"ceciestunecle"
    with open(
        "/home/enzo/Documents/Projet_secu/Projet_secu_INSA2021/ctf_difficile/src/test.txt",
        "r",
    ) as encry, open("test8.txt", "w") as o_file:
        vigenere(encry, "ouai", o_file)

        #
        # decry.write(xor(encry.read(), key))


if __name__ == "__main__":
    main(sys.argv)
