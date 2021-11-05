#!/bin/bash
apt update
#apt install expect

apt install -y apache2 php

apt install -y postgresql postgresql-client

apt install -y git

git config --global user.email dorian.beaufils@gmail.com
git clone https://github.com/Enzo-hmdy/Projet_secu_INSA2021.git

systemctl start apache2


systemctl enable --now postgresql
#su - postgres
psql -c "ALTER USER postgres WITH password 'azerty'"
createdb ctf_facile -O postgresql
psql -U postgres -d ctf_facile -c "CREATE TABLE users (id varchar(25) PRIMARY KEY, password varchar(50);"
psql -U postgres -d ctf_facile -c "COPY users FROM 'FICHIER.CSV' WITH (FORMAT CSV, HEADER, DELIMITER';',QUOTE "");"

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