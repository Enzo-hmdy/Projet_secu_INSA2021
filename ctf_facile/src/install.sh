#!/bin/bash
apt update
#apt install expect
apt install -y apache2 php
systemctl start apache2
apt install -y postgresql-12

#Ouverture d'un port ssh et d'un port http uniquement 

iptables -F ; iptables -X

iptables -t filter -A INPUT -i lo -j ACCEPT

iptables -t filter -A INPUT -p tcp --dport 22 -j ACCEPT 
iptables -t filter -A OUTPUT -p tcp --sport 22 -j ACCEPT 

iptables -t filter -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --sport 80 -j ACCEPT

#On rejette tout le reste
iptables -t filter -A INPUT -j DROP
iptables -t filter -A OUTPUT -j DROP

apt install -y git

git config --global user.email dorian.beaufils@gmail.com
git clone https://github.com/Enzo-hmdy/Projet_secu_INSA2021.git

