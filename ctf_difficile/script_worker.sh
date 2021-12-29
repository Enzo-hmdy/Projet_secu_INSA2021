#!/bin/bash

#On retrouvera la sortie standard dans install.out.log et les erreurs dans install.err.log
exec >/tmp/install.out.log 2>/tmp/install.err.log    

#Mise a jour des paquets et installation des paquets requis pour le deploiement du CTF
apt update
apt install -y firefox-esr

firefox -headless&

touch /root/.mozilla/firefox/*.default-esr/logins.json
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
            \"encryptedUsername\": \",
            \"encryptedPassword\": \",
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
}" >> /root/.mozilla/firefox/*.default-esr/logins.json