import sys
from os import close, putenv
from typing import List
from itertools import cycle


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
    letter = split_string(key)
    split_file = file.split()

    cpt = 0
    my_list = []
    for i in range(len(split_file)):
        for y in range(len(split_file[i])):
            my_list.append(cesar_crypt(letter[cpt % len(letter)], split_file[i][y]))

        cpt = cpt + 1
    return my_list


def vigenere(file, key):
    letter = split_string(key)
    split_file = file.split()

    cpt = 0
    my_list = []
    for i in range(len(split_file)):
        for y in range(len(split_file[i])):
            my_list.append(cesar_crypt(letter[cpt % len(letter)], split_file[i][y]))
            cpt = cpt + 1

    return my_list


def enigma(file, key):
    pass


def DES(file, key):
    pass


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
