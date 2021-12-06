import sys
from os import close, putenv
from typing import List
from itertools import cycle

def split_string(word):
    return[char for char in word]


def xor(file, key):
    return bytes(a ^ b for a , b in zip(file,cycle(key)))

def cesar_crypt(key,letter):
    if 65 <= ord(letter) <= 90:
        return chr(65 + (ord(letter - 65+key))%26)

def cesar(file, key):
    letter = split_string(key)
    split_file = file.split()

    cpt = 0
    my_list =  []
    for i in range(len(split_file)):
        for y in range(len(split_file[i])):
            my_list.append(letter[cpt%len(letter)],split_file[i][y])
            cpt = cpt + 1

    



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
    key=b'ceciestunecle'
    with open("files;txt",'rb') as encry, open("test.txt",'wb') as decry :
        decry.write(xor(encry.read(),key))
    
if __name__ == "__main__":
    main(sys.argv)
