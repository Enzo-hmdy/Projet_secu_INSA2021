import sys
from os import putenv
from typing import List


def xor(file, key):
    xor_list = List()

    for i in range(0, len(file)):
        xor_list.append(file[i] ^ key[i % 8])

    return xor_list


def cesar(file, key):
    pass


def vigenere(file, key):
    pass


def enigma(file, key):
    pass


def DES(file, key):
    pass


def AES(file, key):
    pass


def encryption(key):
    pass


def main(argv):
    pass


if __name__ == "__main__":
    main(sys.argv)
