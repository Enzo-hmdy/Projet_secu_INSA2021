#!/bin/bash
iptables -F 
iptables -X

apt update

GITUSERNAME=Nyzix69
GITPASSWORD=y4Du%&mjZz#G
# INSTALLATION DES PAQUETS NECESSAIRES
apt install -y expect
apt install -y apache2 php
apt install -y postgresql postgresql-client
apt install -y git



#IMPORTATION DU GIT AVEC LES FICHIERS .PHP ET .HTML
cd /home/debian/ 

git clone https://github.com/projetsecu/projetsecurite.git





#DEMARRAGE DU SERVEUR WEB APACHE 2
systemctl start apache2

#DEMARRAGE DE POSTGRESQL
systemctl enable --now postgresql
#su - postgres
psql -c "ALTER USER postgres WITH password 'azerty'" #A CHANGER
createdb ctf_facile -O postgresql
psql -U postgres -d ctf_facile -c "CREATE TABLE users (id varchar(25) PRIMARY KEY, password varchar(50);"
psql -U postgres -d ctf_facile -c "COPY users FROM 'CHEMIN/VERS/FICHIER.CSV' WITH (FORMAT CSV, HEADER, DELIMITER';',QUOTE "");" #TODO

cp /home/debian/projetsecu/ctf_facile/web/* /var/www/html/ 

#OUVERTURE D'UN PORT SSH ET D'UN PORT HTTP UNIQUEMENT


iptables -t filter -A INPUT -i lo -j ACCEPT

iptables -t filter -A INPUT -p tcp --dport 22 -j ACCEPT 
iptables -t filter -A OUTPUT -p tcp --sport 22 -j ACCEPT 

iptables -t filter -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --sport 80 -j ACCEPT

#ON JETTE LES AUTRES PAQUETS IP
iptables -t filter -A INPUT -j DROP
iptables -t filter -A OUTPUT -j DROP

#rm -rf /home/debian/Projet_secu_INSA2021/