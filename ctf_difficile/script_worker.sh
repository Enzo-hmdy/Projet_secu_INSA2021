#!/bin/bash

#On retrouvera la sortie standard dans install.out.log et les erreurs dans install.err.log
exec >/tmp/install.out.log 2>/tmp/install.err.log    

#Mise a jour des paquets et installation des paquets requis pour le deploiement du CTF
apt update
apt install -y firefox-esr
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

su prestaextformation
firefox -headless&
cd /home/prestaextformation/.mozilla/firefox
FILE=$(find . -type d -name '*.default-esr')
#touch /root/.mozilla/firefox/$FILE/logins.json
echo -e "{
    \"nextId\": 2,
    \"logins\": [
        {
            \"id\": 1,
            \"hostname\": \"https://monmail.com\",
            \"httpRealm\": null,
            \"formSubmitURL\": \",
            \"usernameField\": \"SuperBoss\",
            \"passwordField\": \"@H#6nw69yC\",
            \"encryptedUsername\": \"\",
            \"encryptedPassword\": \"\",
            \"guid\": \"{332384e9-7828-4765-92b3-2f5db786e29c}\",
            \"encType\": 1,
            \"timeCreated\": 1640788481938,
            \"timeLastUsed\": 1640788481938,
            \"timePasswordChanged\": 1640788481938,
            \"timesUsed\": 1
        }
    ],
    \"potentiallyVulnerablePasswords\": [],
    \"dismissedBreachAlertsByLoginGUID\": {},
    \"version\": 3
}" >> /home/prestaextformation/.mozilla/firefox/$FILE/logins.json

iptables -I INPUT -p tcp --dport 22 -i eth0 -m state --state NEW -m recent --set >> /tmp/install.log
echo "-----------IPTABLES CREATE RULE----------" >> /tmp/install.log

iptables -I INPUT -p tcp --dport 22 -i eth0 -m state --state NEW -m recent  --update --seconds 300 --hitcount 10 -j DROP  >> /tmp/install.log
echo "-----------IPTABLES SET RULE-----------" >> /tmp/install.log

mkdir Bureau Documents Images Modèles Musiques Téléchargements Vidéos 
