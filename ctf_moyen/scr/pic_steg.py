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
    """ convert a string in

    Args:
        msg ([type]): [description]

    Returns:
        [type]: [description]
    """

    return ''.join(["{:08b}".format(ord(x)) for x in msg])


def stegano(input_pic1, input_pic2, output_file):

    img1 = Image.open(input_pic1)
    img2 = Image.open(input_pic2)

    width_pic1, height_pic1 = img1.size
    width_pic2, height_pic2 = img2.size

    img_data1 = np.array(img1)
    img_data1 = np.reshape(img_data1, width_pic1*height_pic1*4)

    img_data2 = np.array(img2)
    print(img_data2)
    img_data2 = np.reshape(img_data2, width_pic2*height_pic2*4)

    bin_string_img_data2 = ""
    for i in range(len(img_data2)):
        bin_string_img_data2 = bin_string_img_data2 + (bin(i)[2:])

    assert(len(img_data1)*4 > len(img_data2))

    for i in range(width_pic2):
        for j in range(height_pic2):

            pass
    """

    for i in range(len(bin_string_img_data2[i])):

        if(bin_string_img_data2[i] and not img_data1[i] % 2):
            img_data1[i] = img_data1[i] - 1
        if((bin_string_img_data2[i] == '0') and (img_data1[i] % 2)):
            img_data1[i] = img_data1[i] - 1
    """

    img_data1 = np.reshape(img_data1, (height_pic1, width_pic1, 4))

    new_img = Image.fromarray(img_data1)
    new_img.save(output_file)


def main(argv):
    message = ""
    msh_lenght = len(argv) - 3
    for i in range(3, len(argv)):
        message = message + argv[i]
    stegano(argv[1], argv[2], argv[3])


if __name__ == "__main__":
    main(sys.argv)
