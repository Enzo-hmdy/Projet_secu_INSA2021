"""
This programs aims to convert insert in a png or jpeg file a message using lsg of each byte

usage python3 encrypt input_file output_file message


"""

from os import putenv
from PIL import Image
import numpy as np
import sys
import getopt


def convert_msg_to_binary(msg):

    return ''.join(["{:08b}".format(ord(x)) for x in msg])


def stegano(input_file, output_file, msg):

    img = Image.open(input_file)
    bin_msg = convert_msg_to_binary(msg)
    print(bin_msg)
    bin_msg_lenght = len(convert_msg_to_binary(msg))
    width, height = img.size
    img_data = np.array(img)
    img_data = np.reshape(img_data, width*height*3)
    print(img_data)
    # data[:b_message_lenght] = data[:b_message_lenght] & ~1 | b_message

    for i in range(len(bin_msg)):
        print("Avant : ", img_data[i])
        print("bin :", bin_msg[i])

        if(bin_msg[i] and not img_data[i] % 2):
            print("eee")
            img_data[i] = img_data[i] - 1

        else:

            print(bin_msg[i] == bin(0), "et", img_data[i] % 2)
            print(bin(0))

        if((bin_msg[i] == bin(0)) and (img_data[i] % 2)):
            print("poouet")
            img_data[i] = img_data[i] + 1

        print("Après : ", img_data[i])

    """img_data[:bin_msg_lenght] = img_data[:bin_msg_lenght] & ~1 | convert_msg_to_binary(
        msg)
    img_data = np.reshape(img_data, (height, width, 3))

    new_img = Image.fromarray(img_data)
    new_img.save(output_file)"""


def main(argv):
    msh_lenght = len(argv) - 3
    stegano(argv[1], argv[2], "mellier ce gros bg de la street")


main(sys.argv)
