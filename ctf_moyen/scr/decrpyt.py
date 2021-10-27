
"""
This programs aims to find a text message hiden in a picture, only work for lsb hiden text

usage python3 decrypt file


"""

from os import putenv
from PIL import Image
import numpy as np
import sys


def get_msg(input_file):
    img = Image.open(input_file)
    width, height = img.size
    data = np.array(img)

    data = np.reshape(data, width*height*4)
    # On ne regarde que le LSB de chaque pixel
    data = data & 1
    # On transoorme le tout en string de 8 bit de binaire

    """packbit function (from numpy doc)

    Packs the elements of a binary-valued array into bits in a uint8 array.

    The result is padded to full bytes by inserting zero bits at the end.
    """
    data = np.packbits(data)

    # On lit le tout et on convertit en acii jusqu'a qu'on tombe sur un caractère non pritable
    for x in data:
        l = chr(x)
        if not l.isprintable():
            break
        print(l, end='')


def main(argv):
    get_msg(argv[1])


if __name__ == "__main__":
    main(sys.argv)


"""
def bin_to_text(bin_string):

    return [format(i, "08b") for i in bin_string]


def find_text(input_file):

    pass
"""
