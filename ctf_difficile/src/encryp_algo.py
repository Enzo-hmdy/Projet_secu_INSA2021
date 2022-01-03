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
    return bytes(a ^ b for a, b in zip(file, cycle(key)))


def cesar_crypt(key, letter):
    if 65 <= ord(letter) <= 90:
        return chr(65 + (ord(letter) - 65 + ord(key)) % 26)
    elif 97 <= ord(letter) <= 122:
        return chr(97 + (ord(letter) - 97 + ord(key)) % 26)
    elif 48 <= ord(letter) <= 57:
        return chr(48 + (ord(letter) - 48 + ord(key)) % 10)
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
        for character in word:
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


def ency_AES(i_file, key, o_file, path_name, size=64 * 1024):
    iv = os.urandom(16)
    hash_key = sha256(key.encode("ascii")).digest()
    # AES_KEY = AES.adjust_key_parity(hash_key)
    encryptor = AES.new(hash_key, AES.MODE_CBC, iv)
    filesize = os.path.getsize(path_name)

    o_file.write(struct.pack("<Q", filesize))
    o_file.write(iv)
    while True:
        chunk = i_file.read(size)
        if len(chunk) == 0:
            break
        elif len(chunk) % 16 != 0:
            chunk += b" " * (16 - len(chunk) % 16)

        o_file.write(encryptor.encrypt(chunk))


"""
Ordre de chiffrage : césar vigenère xor enigma des aes 

"""


def main(argv):
    key = b"ceciestunecle"
    relative_path = sys.argv[1]
    full_path = os.path.abspath(relative_path)
    print("relatif : ", relative_path," full ", full_path)
    with open(
        full_path,
        "r",
    ) as encry, open("test1.txt", "w+") as o_file:
        cesar(encry, "ouai", o_file)
    os.remove(relative_path)
    os.rename("test1.txt", relative_path)

    with open(
        full_path,
        "r",
    ) as encry, open("test1.txt", "w+") as o_file:
        vigenere(encry, "ouai", o_file)
    os.remove(relative_path)
    os.rename("test1.txt", relative_path)
    with open(
        full_path,
        "rb",
    ) as encry, open("test1.txt", "wb") as o_file:
        ency_AES(
            encry,
            "key",
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
            "key",
            o_file,
        )
    os.remove(relative_path)
    os.rename("test1.txt", relative_path)
    with open(
        full_path,
        "rb",
    ) as encry, open("test1.txt", "wb") as o_file:
        o_file.write(xor(encry.read(), key))
        
    os.remove(relative_path)
    os.rename("test1.txt", relative_path)
    
    


if __name__ == "__main__":
    main(sys.argv)
