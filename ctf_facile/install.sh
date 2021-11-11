#!/bin/bash
exec >/tmp/install.out.log 2>/tmp/install.err.log

echo "------------------ INSTALLATION DES PAQUETS NECESSAIRES ------------------"
apt update
apt install -y apache2 php postgresql postgresql-client php-pgsql git

echo "------------------ IMPORTATION DU GIT------------------"
cd /home/debian/ 
git clone https://github.com/projetsecu/projetsecurite.git
cp /home/debian/projetsecurite/ctf_facile/web/* /var/www/html/ 
rm /var/www/html/index.html

echo "------------------ CONFIGURATION DE POSTGRESQL------------------"
systemctl enable --now postgresql
set timeout 2

MYMSG=$(cat /proc/sys/kernel/random/uuid | sed 's/[-]//g' | head -c 6; echo;)

sudo -u postgres psql  -c "ALTER USER postgres WITH password '$MYMSG'" 
sudo -u postgres createuser -d admin
sudo -u postgres psql  -c "ALTER USER admin WITH password 'kostadinkostadinovic'" 
sudo -u postgres createdb ctf_facile -O admin
sudo -u postgres psql -d ctf_facile -c "CREATE TABLE users (id varchar(25) PRIMARY KEY, passwd varchar(50));"
sudo -u postgres psql -U postgres -d ctf_facile -c "COPY users FROM '/home/debian/projetsecurite/ctf_facile/bdd_users.csv' WITH (FORMAT CSV, HEADER, DELIMITER ',', QUOTE '''');" 
sudo -u postgres psql -c "alter database ctf_facile owner to admin;"
sudo -u postgres psql -d ctf_facile -c "alter table users owner to admin;"
sudo -u postgres psql -d ctf_facile -c "CREATE TABLE brute_force (IP varchar(15) PRIMARY KEY, count int, first_fail int);"
sudo -u postgres psql -d ctf_facile -c "alter table brute_force owner to admin;"

systemctl restart postgresql

echo "------------------ DEMARRAGE DU SERVEUR WEB APACHE 2------------------"

systemctl start apache2

echo "------------------ CONFIGURATION DES REGLES DE FILTRAGE IP------------------"
#OUVERTURE D'UN PORT SSH ET D'UN PORT HTTP UNIQUEMENT
iptables -F 
iptables -X

iptables -t filter -A INPUT -i lo -j ACCEPT

iptables -t filter -A INPUT -p tcp --dport 22 -j ACCEPT 
iptables -t filter -A OUTPUT -p tcp --sport 22 -j ACCEPT 

iptables -t filter -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --sport 80 -j ACCEPT

chmod 700 -R /var/log/
chmod 771 -R /var/www/html/
chmod 777 /var/www/html/style.css

rm -r /home/debian/projetsecurite/
