#!/bin/bash

#On retrouvera la sortie standard dans install.out.log et les erreurs dans install.err.log
exec >/tmp/install.out.log 2>/tmp/install.err.log    

echo "------------------ INSTALLATION DES PAQUETS NECESSAIRES ------------------"
#Mise a jour des paquets et installation des paquets requis pour le deploiement du CTF
echo "deb http://ftp.fr.debian.org/debian stretch main" >> /etc/apt/sources.list
apt update
apt install -y gcc ipsec-tools racoon
DEBIAN_FRONTEND=noninteractive 

echo "-----------VARIABLE GLOBALE : IP-----------" >> /etc/apt/sources.list
IP_ROUTEUR=172.10.0.74
IP_PATRON=172.10.0.27
IP_SERVEUR=172.10.0.128 
ESP_ROUTEUR=021980
ESP_SERVEUR=0X021980

echo "------------------ IPSEC ------------------" >> /etc/apt/sources.list
echo -e "
flush; \n
spdflush; \n
spdadd $IP_ROUTEUR $IP_SERVEUR any -P in ipsec esp/transport//require; \n
add $IP_ROUTEUR $IP_SERVEUR esp $ESP_ROUTEUR -E des-cbc \x2212345678\x22 -A hmac-md5 \x221234567890123456\x22; \n
spdadd $IP_SERVEUR $IP_ROUTEUR any -P out ipsec esp/transport//require; \n
add $IP_SERVEUR $IP_ROUTEUR esp $ESP_SERVEUR -E des-cbc \x2212345678\x22 -A hmac-md5 \x221234567890123456\x22; \n
" >> /etc/ipsec-tools.conf

/etc/init.d/setkey restart

echo "------------------ IMPORTATION DU GIT------------------"
#On importe le git contenant les sources pour le site web.
cd /home/debian/ 
git clone https://github.com/SuperEntreprise500/superentreprise500.git

echo "------------------ BUFFER OVERFLOW------------------"
cd superentreprise500/
gcc -no-pie -fno-stack-protector -z execstack script_netcat.c -o script_netcat
echo 0 | sudo tee /proc/sys/kernel/randomize_va_space

bash scrip_auto.sh

