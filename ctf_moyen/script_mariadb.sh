#!/bin/bash

sudo apt-get update >> /tmp/install.log
apt-get -y install expect >> /tmp/install.log
sudo apt -y install mariadb-server mariadb-client  >> /tmp/install.log
MYSQL_ROOT_PASSWORD=azerty  >> /tmp/install.log
MYMSG=$(cat /proc/sys/kernel/random/uuid | sed 's/[-]//g' | head -c 6; echo;) >> /tmp/install.log
MYSQL_INSTAL=$(expect -c "  

set timeout 5
spawn mysql_secure_installation
expect \"Enter current password for root:\"
send \"$MYMSG\r\"
expect \"Would you like to setup VALIDATE PASSWORD plugin?\"
send \"n\r\" 
expect \"Change the password for root ?\"
send \"n\r\"
expect \"Remove anonymous users?\"
send \"y\r\"
expect \"Disallow root login remotely?\"
send \"n\r\"
expect \"Remove test database and access to it?\"
send \"y\r\"
expect \"Reload privilege tables now?\"
send \"y\r\"
expect eof
")  

echo "$MYSQL_INSTAL" >> /tmp/install.log
apt-get -y install ufw  >> /tmp/install.log
echo "-----------INSTALL UFW -----------" >> /tmp/install.log
ufw allow from 0.0.0.0 to any port 3306 >> /tmp/install.log
iptables -A INPUT -p tcp --dport 3306 -j ACCEPT >> /tmp/install.log
echo "-----------OPEN PORT SQL -----------" >> /tmp/install.log
service iptables save >> /tmp/install.log
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root';" >> /tmp/install.log
sed -i -e 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf  >> /tmp/install.log
echo "-----------MODIF MARIADB CNF-----------" >> /tmp/install.log
systemctl restart mysql >> /tmp/install.log
systemctl restart mariadb >> /tmp/install.log
echo "-----------MARIADB RESTART -----------" >> /tmp/install.log
apt-get -y install git >> /tmp/install.log
sudo apt-get -y install python3-pip
python -m pip install -U --force-reinstall pip
python3 -m pip install Pillow >> /tmp/install.log
python3 -m pip install numpy >> /tmp/install.log
echo "-----------INSTALL PYTHON -----------" >> /tmp/install.log


git clone https://github.com/projetsecu/projetsecurite.git /home/debian/ctf/
echo "-----------GIT CLONE -----------" >> /tmp/install.log

python3 /home/debian/ctf/ encrypt.py a.png picture.png $MYMSG >> /tmp/install.log
echo "-----------ENCRYPT PYTHON-----------" >> /tmp/install.log
cp ctf/ctf_moyen/picture.png . >> /tmp/install.log
rm -r ctf/ >> /tmp/install.log
echo "-----------RM DIRECTORY-----------" >> /tmp/install.log

iptables -I INPUT -p tcp --dport 3306 -i ens33 -m state --state NEW -m recent --set >> /tmp/install.log
echo "-----------IPTABLES CREATE RULE----------" >> /tmp/install.log

iptables -I INPUT -p tcp --dport 3306 -i ens33 -m state --state NEW -m recent  --update --seconds 300 --hitcount 4 -j DROP  >> /tmp/install.log
echo "-----------IPTABLES SET RULE-----------" >> /tmp/install.log

