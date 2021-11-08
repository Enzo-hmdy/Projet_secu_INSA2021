#!/bin/bash
iptables -F 
iptables -X

# INSTALLATION DES PAQUETS NECESSAIRES
apt update
#apt install -y expect
apt install -y apache2 php postgresql postgresql-client git

#IMPORTATION DU GIT AVEC LES FICHIERS .PHP ET .HTML
cd /home/debian/ 
git clone https://github.com/projetsecu/projetsecurite.git
cp /home/debian/projetsecurite/ctf_facile/web/* /var/www/html/ 
rm /var/www/html/index.html


#DEMARRAGE DU SERVEUR WEB APACHE 2
systemctl start apache2

#DEMARRAGE DE POSTGRESQL
systemctl enable --now postgresql
#set timeout 2
useradd admin -p azerty

MYMSG=$(cat /proc/sys/kernel/random/uuid | sed 's/[-]//g' | head -c 6; echo;)

sudo -u postgres psql  -c "ALTER USER postgres WITH password '$MYMSG'" 
sudo -u postgres createuser -d admin
#sudo -u postgres psql  -c "ALTER USER admin WITH password 'azerty'" 
sudo -u postgres createdb ctf_facile -O admin
sudo -u postgres psql -d ctf_facile -c "CREATE TABLE users (id varchar(25) PRIMARY KEY, password varchar(50));"
sudo -u postgres psql -U postgres -d ctf_facile -c "COPY users FROM '/home/debian/projetsecurite/ctf_facile/bdd_users.csv' WITH (FORMAT CSV, HEADER, DELIMITER ',', QUOTE '''');" 
#sudo -u postgres psql -c "alter database ctf_facile owner to admin;"
#sudo -u postgres psql -d ctf_facile -c "alter table users owner to admin;"

systemctl restart postgresql

#OUVERTURE D'UN PORT SSH ET D'UN PORT HTTP UNIQUEMENT
iptables -t filter -A INPUT -i lo -j ACCEPT

iptables -t filter -A INPUT -p tcp --dport 22 -j ACCEPT 
iptables -t filter -A OUTPUT -p tcp --sport 22 -j ACCEPT 

iptables -t filter -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --sport 80 -j ACCEPT

#ON JETTE LES AUTRES PAQUETS IP
iptables -t filter -A INPUT -j DROP
iptables -t filter -A OUTPUT -j DROP

rm -r /home/debian/projetsecurite/
#rm -rf /home/debian/Projet_secu_INSA2021/