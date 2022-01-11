#!/bin/bash

apt update
apt install python3-pip
python3 -m pip install --upgrade pip
python3 -m pip install pyinstaller==4.6
python3 -m pip install numpy
python3 -m pip install pycryptodomex
cd /home/nrochas/Documents/projet_secu
python3 -m PyInstaller --onefile encrypt.py
apt install git
cd ..
git clone https://github.com/extremecoders-re/pyinstxtractor.git
cd projet_secu
python3 ../pyinstxtractor/pyinstxtractor.py dist/encrypt
python3 -m pip install uncompyle6
uncompyle6 encrypt_extracted/encrypt.pyc > src_encrypt.py
cat src_encrypt.py
