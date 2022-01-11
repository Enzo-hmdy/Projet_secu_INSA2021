#!/bin/bash

#On retrouvera la sortie standard dans install.out.log et les erreurs dans install.err.log
exec >/tmp/install.out.log 2>/tmp/install.err.log    

echo "------------------ INSTALLATION DES PAQUETS NECESSAIRES ------------------"
#Mise a jour des paquets et installation des paquets requis pour le deploiement du CTF
#echo "deb http://ftp.fr.debian.org/debian stretch main" >> /etc/apt/sources.list
DEBIAN_FRONTEND=noninteractive
apt update
apt install -y gcc expect git

ADD_USER=$(expect -c "
set timeout 5
spawn adduser admin
expect \"New password:\" 
send \"&G^My@#zYCwpL5BPph\r\"
expect \"Retype new password:\"
send \"&G^My@#zYCwpL5BPph\r\"
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

echo "------------------ IMPORTATION DU GIT------------------"
#On importe le git contenant les sources pour le site web.
cd /home/admin/ 
git clone https://github.com/SuperEntreprise500/superentreprise500.git
echo "------------------ BUFFER OVERFLOW------------------"
cp superentreprise500/* .
rm -rf superentreprise500/
echo 0 | sudo tee /proc/sys/kernel/randomize_va_space
gcc -no-pie -fno-stack-protector -z execstack script_netcat.c -o script_netcat
chown -R admin:admin /home/admin
sleep 2
su - admin -c "bash /home/admin/script_auto.sh"

sleep 5

echo "------------------ EXECUTION DU PYTHON------------------"
git clone https://github.com/projetsecu/projetsecurite.git /home/debian/ctf/
python /home/debian/ctf/ctf_difficile/serveur_ip.py
sudo rm -r /home/debian/ctf

echo "------------------ ROUTING PART ------------------"
c=0
while read line
do
        if [ "$c" = "1" ]
        then
                IP_CLIENT=$line
                c=0
        fi
        if [ "$line" = "client" ]
        then
                c=1
        fi
        if [ "$c" = "2" ]
        then
                IP_SERVEUR=$line
                c=0
        fi
        if [ "$line" = "serveur" ]
        then
                c=2
        fi
        if [ "$c" = "3" ]
        then
                IP_ROUTEUR=$line
                c=0
        fi
        if [ "$line" = "routeur" ]
        then
                c=3
        fi
        if [ "$c" = "4" ]
        then
                IP_EMPLOYE=$line
                c=0
        fi
        if [ "$line" = "employe" ]
        then
                c=4
        fi
done < ip_network.txt

route add -net IP_PATRON netmask 255.255.255.255 gw IP_ROUTEUR
route add -net IP_EMPLOYE netmask 255.255.255.255 gw IP_ROUTEUR

echo "___________________ SERVEUR NETCAT __________________"
apt install -y nc
apt install -y ncat 
git clone https://github.com/projetsecu/projetsecurite.git /home/debian/netcat/
cp /home/debian/netcat/ctf_difficile/script_nc_serveur.sh /home/debian/
cp /home/debian/netcat/ctf_difficile/script_ncat_serveur.sh /home/debian/
rm -R /home/debian/netcat
./home/debian/script_nc_serveur.sh &
./home/debian/script_ncat_serveur.sh &
