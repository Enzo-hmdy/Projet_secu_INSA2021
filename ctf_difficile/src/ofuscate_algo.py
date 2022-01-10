import os
import sys
import struct
from os import close , putenv , urandom
from typing import List
from itertools import cycle , islice
from des import des
from Cryptodome . Cipher import DES3 , AES
from hashlib import md5 , sha256
import functools
import operator
import random
def ooo0oOoooOOO0 ( word ) :
 return [ char for char in word ]
def oOO0OoOoo000 ( file , key ) :
 return bytes ( a ^ b for a , b in zip ( file , cycle ( key ) ) )
def iii111 ( key , letter ) :
 if 65 <= ord ( letter ) <= 90 :
  return chr ( 65 + ( ord ( letter ) - 65 + ord ( key ) ) % 26 )
 elif 97 <= ord ( letter ) <= 122 :
  return chr ( 97 + ( ord ( letter ) - 97 + ord ( key ) ) % 26 )
 elif 48 <= ord ( letter ) <= 57 :
  return chr ( 48 + ( ord ( letter ) - 48 + ord ( key ) ) % 10 )
 else :
  return str ( letter )
def oOo0O00O0ooo ( in_file , key , o_file ) :
 i11iIii = 0
 OO = ""
 iiI1I11iiiiI = ooo0oOoooOOO0 ( key )
 for iII11iIi1iIiI in in_file :
  for oOoO00 in iII11iIi1iIiI :
   OO += iii111 ( iiI1I11iiiiI [ i11iIii % len ( iiI1I11iiiiI ) ] , oOoO00 )
  i11iIii = i11iIii + 1
 o_file . write ( OO )
def iiI1111II ( in_file , key , o_file ) :
 i11iIii = 0
 OO = ""
 iiI1I11iiiiI = ooo0oOoooOOO0 ( key )
 for iII11iIi1iIiI in in_file :
  for oOoO00 in iII11iIi1iIiI :
   OO += iii111 ( iiI1I11iiiiI [ i11iIii % len ( iiI1I11iiiiI ) ] , oOoO00 )
   i11iIii = i11iIii + 1
 o_file . write ( OO )
def OoOo00 ( file , key , path ) :
 I1i1i = des ( )
 bytes = I1i1i . encrypt ( key , file )
 path . write ( bytes )
def iI1i ( file , key , o_file ) :
 IIIi1111iiIi1 = md5 ( key . encode ( "ascii" ) ) . digest ( )
 iI11i1iI1I1Ii = DES3 . adjust_key_parity ( IIIi1111iiIi1 )
 oOoOO0O0 = DES3 . new ( iI11i1iI1I1Ii , DES3 . MODE_EAX , nonce = b"0" )
 ooOo00o = file . read ( )
 bytes = oOoOO0O0 . encrypt ( ooOo00o )
 o_file . write ( bytes )
def o00ooo0Oooo ( i_file , key , o_file , path_name , size = 64 * 1024 ) :
 oOOOO0OO00 = os . urandom ( 16 )
 IIIi1111iiIi1 = sha256 ( key . encode ( "ascii" ) ) . digest ( )
 iIOooO0O = AES . new ( IIIi1111iiIi1 , AES . MODE_CBC , oOOOO0OO00 )
 i1i1iI1i1Iii = os . path . getsize ( path_name )
 o_file . write ( struct . pack ( "<Q" , i1i1iI1i1Iii ) )
 o_file . write ( oOOOO0OO00 )
 while True :
  iII1Ii = i_file . read ( size )
  if len ( iII1Ii ) == 0 :
   break
  elif len ( iII1Ii ) % 16 != 0 :
   iII1Ii += b" " * ( 16 - len ( iII1Ii ) % 16 )
  o_file . write ( iIOooO0O . encrypt ( iII1Ii ) )
def ooO0ooOOO00O0 ( argv ) :
 i11Ii , I11 , I1Ii , II , Ooo0O00o = sys . argv [ 2 ] , sys . argv [ 3 ] , sys . argv [ 4 ] , sys . argv [ 5 ] , bytes ( sys . argv [ 6 ] , "utf8" )
 OO0OOOoOOooO = sys . argv [ 1 ]
 OOo0OOo000o00 = "test1.txt"
 O0 = os . path . abspath ( OO0OOOoOOooO )
 with open (
 O0 ,
 "r" ,
 ) as i11I1IiIiI1i , open ( OOo0OOo000o00 , "w+" ) as O00O0O0Oo0oO :
  oOo0O00O0ooo ( i11I1IiIiI1i , i11Ii , O00O0O0Oo0oO )
 os . remove ( OO0OOOoOOooO )
 os . rename ( OOo0OOo000o00 , OO0OOOoOOooO )
 with open (
 O0 ,
 "r" ,
 ) as i11I1IiIiI1i , open ( OOo0OOo000o00 , "w+" ) as O00O0O0Oo0oO :
  iiI1111II ( i11I1IiIiI1i , I11 , O00O0O0Oo0oO )
 os . remove ( OO0OOOoOOooO )
 os . rename ( OOo0OOo000o00 , OO0OOOoOOooO )
 with open (
 O0 ,
 "rb" ,
 ) as i11I1IiIiI1i , open ( OOo0OOo000o00 , "wb" ) as O00O0O0Oo0oO :
  o00ooo0Oooo (
 i11I1IiIiI1i ,
 I1Ii ,
 O00O0O0Oo0oO ,
 O0 ,
 )
 os . remove ( OO0OOOoOOooO )
 os . rename ( OOo0OOo000o00 , OO0OOOoOOooO )
 with open (
 O0 ,
 "rb" ,
 ) as i11I1IiIiI1i , open ( OOo0OOo000o00 , "wb" ) as O00O0O0Oo0oO :
  iI1i (
 i11I1IiIiI1i ,
 II ,
 O00O0O0Oo0oO ,
 )
 os . remove ( OO0OOOoOOooO )
 os . rename ( OOo0OOo000o00 , OO0OOOoOOooO )
 with open (
 O0 ,
 "rb" ,
 ) as i11I1IiIiI1i , open ( OOo0OOo000o00 , "wb" ) as O00O0O0Oo0oO :
  O00O0O0Oo0oO . write ( oOO0OoOoo000 ( i11I1IiIiI1i . read ( ) , Ooo0O00o ) )
 os . remove ( OO0OOOoOOooO )
 os . rename ( OOo0OOo000o00 , OO0OOOoOOooO )
if __name__ == "__main__" :
 ooO0ooOOO00O0 ( sys . argv )
# dd678faae9ac167bc83abf78e5cb2f3f0688d3a3