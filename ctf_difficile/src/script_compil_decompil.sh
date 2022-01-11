#!/bin/bash

apt update
apt install python3-pip
python3 -m pip install --upgrade pip
python3 -m pip install pyinstaller==4.6
python3 -m pip install numpy
cd /home/nrochas/Documents/projet_secu
python3 -m PyInstaller --onefile test.py
apt install git
cd ..
git clone https://github.com/extremecoders-re/pyinstxtractor.git
cd projet_secu
python3 ../pyinstxtractor/pyinstxtractor.py dist/test
python3 -m pip install uncompyle6
uncompyle6 test_extracted/test.pyc > test_src.py
cat test_src.py
