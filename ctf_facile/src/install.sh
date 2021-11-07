#!/bin/bash
apt update
#apt install expect

# INSTALLATION DES PAQUETS NECESSAIRES
apt install -y apache2 php

apt install -y postgresql postgresql-client

apt install -y git

#IMPORTATION DU GIT AVEC LES FICHIERS .PHP ET .HTML
git config --global user.email dorian.beaufils@gmail.com
git clone https://github.com/Enzo-hmdy/Projet_secu_INSA2021.git

#DEMARRAGE DU SERVEUR WEB
systemctl start apache2

#DEMARRAGE DE POSTGRESQL
systemctl enable --now postgresql
#su - postgres
psql -c "ALTER USER postgres WITH password 'azerty'"
createdb ctf_facile -O postgresql
psql -U postgres -d ctf_facile -c "CREATE TABLE users (id varchar(25) PRIMARY KEY, password varchar(50);"
psql -U postgres -d ctf_facile -c "COPY users FROM 'FICHIER.CSV' WITH (FORMAT CSV, HEADER, DELIMITER';',QUOTE "");"

#OUVERTURE D'UN PORT SSH ET D'UN PORT HTTP UNIQUEMENT
iptables -F ; iptables -X

iptables -t filter -A INPUT -i lo -j ACCEPT

iptables -t filter -A INPUT -p tcp --dport 22 -j ACCEPT 
iptables -t filter -A OUTPUT -p tcp --sport 22 -j ACCEPT 

iptables -t filter -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --sport 80 -j ACCEPT

#ON JETTE LES AUTRES PAQUETS IP
iptables -t filter -A INPUT -j DROP
iptables -t filter -A OUTPUT -j DROP