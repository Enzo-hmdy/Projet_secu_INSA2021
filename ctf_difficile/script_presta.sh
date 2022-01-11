#!/bin/bash

apt-get install -y expect

ADD_USER=$(expect -c "
set timeout 5
spawn adduser prestaextformation
expect \"New password:\" 
send \"akdTpneJ2022\r\"
expect \"Retype new password:\"
send \"akdTpneJ2022\r\"
expect \"Full name []:\" 
send \"\r\"
expect \"Room Number []:\" 
send \"\r\"
expect \"Work Phone []:\" 
send \"\r\"
expect \"Home Phone []:\"
send \"\r\"
expect \"Other []\"
send \"\r\"
expect \"Is the information correct? []\"
send \"Y\r\"
expect eof
")
echo "$ADD_USER"

apt update
apt install python3-pip
python3 -m pip install --upgrade pip
python3 -m pip install pycryptodomex
