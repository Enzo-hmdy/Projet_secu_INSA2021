"""
This programs aims to convert insert in a png or jpeg file a message using lsg of each byte

usage python3 encrypt input_file output_file message


"""

from os import putenv
from PIL import Image
import numpy as np
import sys
import hashlib


def convert_msg_to_binary(msg):

    return ''.join(["{:08b}".format(ord(x)) for x in msg])


def hashage(msg):
    hash = hashlib.sha1(msg.encode())
    hex_hash = hash.hexdigest()
    return hex_hash


def stegano(input_file, output_file, msg):

    img = Image.open(input_file)
    bin_msg = convert_msg_to_binary(msg)
    print(bin_msg)
    bin_msg_lenght = len(convert_msg_to_binary(msg))
    width, height = img.size
    img_data = np.array(img)
    img_data = np.reshape(img_data, width*height*4)
    print(img_data)
    # data[:b_message_lenght] = data[:b_message_lenght] & ~1 | b_message

    for i in range(len(bin_msg)):

        if(bin_msg[i] and not img_data[i] % 2):
            img_data[i] = img_data[i] - 1
        if((bin_msg[i] == '0') and (img_data[i] % 2)):
            img_data[i] = img_data[i] - 1

    img_data = np.reshape(img_data, (height, width, 4))

    new_img = Image.fromarray(img_data)
    new_img.save(output_file)


def main(argv):
    message = ""
    msh_lenght = len(argv) - 3
    for i in range(3, len(argv)):
        message = message + argv[i] + " "
    stegano(argv[1], argv[2], hashage(message))


if __name__ == "__main__":
    main(sys.argv)
