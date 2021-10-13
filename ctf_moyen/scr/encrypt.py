"""
This programs aims to convert insert in a png or jpeg file a message using lsg of each byte

usage python3 encrypt input_file output_file message


"""

from PIL import Image
import numpy as np
import sys
import getopt


def convert_msg_to_binary(msg):

    return ''.join(["{:08b}".format(ord(x)) for x in msg])


def stegano(input_file, output_file, msg):

    img = Image.open(input_file)
    bin_msg_lenght = len(convert_msg_to_binary(msg))
    width, height = img.size
    img_data = np.array(img)
    img_data = np.reshape(img_data, width*height*3)
    # data[:b_message_lenght] = data[:b_message_lenght] & ~1 | b_message
    img_data[:bin_msg_lenght] = img_data[:bin_msg_lenght] & ~1 | convert_msg_to_binary(
        msg)
    img_data = np.reshape(img_data, (height, width, 3))

    new_img = Image.fromarray(img_data)
    new_img.save(output_file)


def main(argv):
    msh_lenght = len(argv) - 3
    stegano(argv[1], argv[2], "message")
    print(msh_lenght)


main(sys.argv)
