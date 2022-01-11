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


def ooo0oOoooOOO0(word):
    return [char for char in word]


def oOO0OoOoo000(file, key):
    return bytes(a ^ b for a, b in zip(file, cycle(key)))


def iii111(key, letter):
    if 65 <= ord(letter) <= 90:
        return chr(65 + (ord(letter) - 65 + ord(key)) % 26)
    elif 97 <= ord(letter) <= 122:
        return chr(97 + (ord(letter) - 97 + ord(key)) % 26)
    elif 48 <= ord(letter) <= 57:
        return chr(48 + (ord(letter) - 48 + ord(key)) % 10)
    else:
        return str(letter)


def I1i1Ii(in_file, key, o_file):
    Ooo0OO = 0
    ii1Ii1I = ""
    oo0 = ooo0oOoooOOO0(key)
    for OOO in in_file:
        for iII1II11iI1 in OOO:
            ii1Ii1I += iii111(oo0[Ooo0OO % len(oo0)], iII1II11iI1)
        Ooo0OO = Ooo0OO + 1
    o_file.write(ii1Ii1I)


def OO0o0O0o0(in_file, key, o_file):
    Ooo0OO = 0
    ii1Ii1I = ""
    oo0 = ooo0oOoooOOO0(key)
    for OOO in in_file:
        for iII1II11iI1 in OOO:
            ii1Ii1I += iii111(oo0[Ooo0OO % len(oo0)], iII1II11iI1)
            Ooo0OO = Ooo0OO + 1
    o_file.write(ii1Ii1I)


def oOoOOO0ooooO0(file, key, path):
    iII = des()
    bytes = iII.encrypt(key, file)
    path.write(bytes)


def IIIIi(file, key, o_file):
    O0O0oOo00oO0 = md5(key.encode("ascii")).digest()
    I1II1ii111i = DES3.adjust_key_parity(O0O0oOo00oO0)
    I1i1iI1I1Ii1 = DES3.new(I1II1ii111i, DES3.MODE_EAX, nonce=b"0")
    OO = file.read()
    bytes = I1i1iI1I1Ii1.encrypt(OO)
    o_file.write(bytes)


def o0oO00OO(i_file, key, o_file, path_name, size=64 * 1024):
    O0OO0OOOOoo0o = os.urandom(16)
    O0O0oOo00oO0 = sha256(key.encode("ascii")).digest()
    I11i1IIII1I = AES.new(O0O0oOo00oO0, AES.MODE_CBC, O0OO0OOOOoo0o)
    I11IIiiI1 = os.path.getsize(path_name)
    o_file.write(struct.pack("<Q", I11IIiiI1))
    o_file.write(O0OO0OOOOoo0o)
    while True:
        o0O0OO00O = i_file.read(size)
        if len(o0O0OO00O) == 0:
            break
        elif len(o0O0OO00O) % 16 != 0:
            o0O0OO00O += b" " * (16 - len(o0O0OO00O) % 16)
        o_file.write(I11i1IIII1I.encrypt(o0O0OO00O))


def O0O0(argv):
    if len(sys.argv) != 7:
        print("Usage : ./name file k1 k2 k3 k4 k5")
        sys.exit()
    OO0oOoOOOoO0, Iii1I1I1, oO0oO, Oo0, i1i1Ii = (
        sys.argv[2],
        sys.argv[3],
        sys.argv[4],
        sys.argv[5],
        bytes(sys.argv[6], "utf8"),
    )
    iII1Ii = sys.argv[1]
    O00OoO0OOO0 = "test1.txt"
    Iioo0Oo0oO0 = os.path.abspath(iII1Ii)
    with open(
        Iioo0Oo0oO0,
        "r",
    ) as O0O0oO00OO0, open(O00OoO0OOO0, "w+") as ooo00Oo0oOo:
        I1i1Ii(O0O0oO00OO0, OO0oOoOOOoO0, ooo00Oo0oOo)
    os.remove(iII1Ii)
    os.rename(O00OoO0OOO0, iII1Ii)
    with open(
        Iioo0Oo0oO0,
        "r",
    ) as O0O0oO00OO0, open(O00OoO0OOO0, "w+") as ooo00Oo0oOo:
        OO0o0O0o0(O0O0oO00OO0, Iii1I1I1, ooo00Oo0oOo)
    os.remove(iII1Ii)
    os.rename(O00OoO0OOO0, iII1Ii)
    with open(
        Iioo0Oo0oO0,
        "rb",
    ) as O0O0oO00OO0, open(O00OoO0OOO0, "wb") as ooo00Oo0oOo:
        o0oO00OO(
            O0O0oO00OO0,
            oO0oO,
            ooo00Oo0oOo,
            Iioo0Oo0oO0,
        )
    os.remove(iII1Ii)
    os.rename(O00OoO0OOO0, iII1Ii)
    with open(
        Iioo0Oo0oO0,
        "rb",
    ) as O0O0oO00OO0, open(O00OoO0OOO0, "wb") as ooo00Oo0oOo:
        IIIIi(
            O0O0oO00OO0,
            Oo0,
            ooo00Oo0oOo,
        )
    os.remove(iII1Ii)
    os.rename(O00OoO0OOO0, iII1Ii)
    with open(
        Iioo0Oo0oO0,
        "rb",
    ) as O0O0oO00OO0, open(O00OoO0OOO0, "wb") as ooo00Oo0oOo:
        ooo00Oo0oOo.write(oOO0OoOoo000(O0O0oO00OO0.read(), i1i1Ii))
    os.remove(iII1Ii)
    os.rename(O00OoO0OOO0, iII1Ii)


if __name__ == "__main__":
    O0O0(sys.argv)
