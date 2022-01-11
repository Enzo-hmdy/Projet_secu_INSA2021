#!/bin/bash

sudo apt-get update 
apt-get -y install expect 
sudo apt -y install mariadb-server mariadb-client  
MYSQL_ROOT_PASSWORD=azerty  
SUPER_USER_PSW=Cl3m3ntM3li3erF3AT3nZoHoummady
MYMSG=Fl4gForu
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

ADD_USER=$(expect -c "
set timeout 5
spawn adduser user
expect \"New password:\" 
send \"azerty\r\"
expect \"Retype new password:\"
send \"azerty\r\"
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

ADD_SUPERUSER=$(expect -c "
set timeout 5
spawn adduser admin
expect \"New password:\" 
send \"$SUPER_USER_PSW\r\"
expect \"Retype new password:\"
send \"$SUPER_USER_PSW\r\"
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
echo "$MYSQL_INSTAL" 
echo "$ADD_USER" 
echo "$ADD_SUPERUSER" 
echo "-----------ADD USER -----------"

apt-get -y install ufw  
echo "-----------INSTALL UFW -----------" 
ufw allow from 0.0.0.0 to any port 3306 
iptables -A INPUT -p tcp --dport 3306 -j ACCEPT
echo "-----------OPEN PORT SQL -----------"
service iptables save
mysql -u root -p$MYMSG -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYMSG';" 
sed -i -e 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf  
echo "-----------MODIF MARIADB CNF-----------" 
systemctl restart mysql 
systemctl restart mariadb 
echo "-----------MARIADB RESTART -----------" 
apt-get -y install git 
sudo apt-get update
sudo apt-get -y install python3-pip
python3 -m pip install --upgrade pip

python3 -m pip install Pillow 
python3 -m pip install --upgrade pillow
python3 -m pip install numpy 
echo "-----------INSTALL PYTHON -----------" 


git clone https://github.com/projetsecu/projetsecurite.git /home/debian/ctf/
echo "-----------GIT CLONE -----------" 

mkdir /home/debian/protected_script 
chmod 750 /home/debian/protected_script 
echo "-----------PROTECTED SCRIPTS-----------" 

cp /home/debian/ctf/ctf_moyen/mv_files.sh /home/debian
cp /home/debian/ctf/ctf_moyen/exec_all_files.sh /home/debian
cp /home/debian/ctf/ctf_moyen/create_db.sql /home/debian
cp /home/debian/ctf/ctf_moyen/echo_in_consol.sh /home/debian/protected_script
cp /home/debian/ctf/ctf_moyen/show_admin_passwd.sh /home/debian/
echo "-----------COPY FILES-----------" 

chmod 777 /home/debian/ctf/ctf_moyen/encrypt.py
sudo python3 /home/debian/ctf/ctf_moyen/encrypt.py /home/debian/ctf/ctf_moyen/a.png /home/debian/picture.png $MYMSG
sudo mv /home/debian/picture.png /home/user
echo "-----------ENCRYPT PYTHON-----------" 
chmod -R 777 ctf/
sudo rm -r /home/debian/ctf
echo "-----------RM DIRECTORY-----------" 

iptables -I INPUT -p tcp --dport 3306 -i eth0 -m state --state NEW -m recent --set 
echo "-----------IPTABLES CREATE RULE----------" 

iptables -I INPUT -p tcp --dport 3306 -i eth0 -m state --state NEW -m recent  --update --seconds 300 --hitcount 4 -j DROP  
echo "-----------IPTABLES SET RULE-----------" 

sudo apt-get install whois

chmod +x /home/debian/exec_all_files.sh
chmod +x /home/debian/mv_files.sh
chmod +x /home/debian/show_admin_passwd.sh
chmod +x /home/debian/protected_script/echo_in_consol.sh
chmod 750 /home/debian
chmod 750 /home/admin
echo "-----------MANAGING RIGHTS-----------" 

(crontab -l 2>/dev/null; echo "* * * * * /home/debian/mv_files.sh") | crontab -
(crontab -l 2>/dev/null; echo "* * * * * /home/debian/exec_all_files.sh") | crontab -
(crontab -l 2>/dev/null; echo " ") | crontab -

# touch /var/spool/cron/crontabs/root 
# chmod +x /var/spool/cron/crontabs/root
# echo "#!/bin/bash" >> /var/spool/cron/crontabs/root
# echo "* * * * * /home/debian/mv_files.sh" >> /var/spool/cron/crontabs/root
# echo "* * * * * /home/debian/exec_all_files.sh" >> /var/spool/cron/crontabs/root
# echo " " >> /var/spool/cron/crontabs/root
# Dec  2 20:52:01 etudiant4-moyen-test cron[4165]: (root) RELOAD (crontabs/root)
echo "-----------CRON SET UP-----------" 

#UPDATE mysql.user SET File_priv = 'Y' WHERE user='my_user' AND host='localhost'; APRES CA FAUT REBOOT et utiliser cette commande sans utilsier de bdd vant 
# A mettre dans le crontab toute les minutes :  echo "il est actuellement" && date +%R 

# Création database mysql
mysql -e "CREATE DATABASE scripts" 
mysql scripts < /home/debian/create_db.sql 
echo "-----------CREATE DATABASE-----------" 
echo "Cl3m3ntM3li3erF3AT3nZoHoummady" >> /home/debian/passwd.txt


echo "{W3ll_Done_B0ys Welcome to L33T of H4ck3rs}" >> /home/admin/flag.txt

rm /tmp/install.log
#TODO
#DELETE ALL LOGS
#PREVENT USER >FROM USING SUDO

# commande sql à realiser
# SELECT text_script FROM script WHERE nom_script='show_in_console5.sh' INTO OUTFILE 'joie.sh' LINES TERMINATED BY '\n';