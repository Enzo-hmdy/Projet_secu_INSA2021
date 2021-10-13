"""
This programs aims to convert insert in a png or jpeg file a message using lsg of each byte

usage python3 encrypt input_file output_file message


"""

from PIL import Image
import numpy as np


def convert_msg_to_binary(msg):

    return ''.join(["{:08b}".format(ord(x)) for x in msg])


def stegano(input_file, output_file, msg):

    img = Image.open(input_file)

    weight, height = img.size


def main():
    print(convert_msg_to_binary("*£"))


main()
