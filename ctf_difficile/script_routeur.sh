#!/bin/bash
echo "deb http://ftp.fr.debian.org/debian stretch main" >> /etc/apt/sources.list
sudo apt-get update >> /tmp/install.log
apt-get install -y ipsec-tools >> /tmp/install.log
apt-get install racoon >> /tmp/install.log
DEBIAN_FRONTEND=noninteractive apt-get install racoon >> /tmp/install.log
echo "-----------INSTALL RACOON IPSEC-TOOLS-----------" >> /tmp/install.log

ESP_ROUTEUR=021980
ESP_SERVEUR=0X021980
echo "-----------VARIABLE GLOBALE : IP-----------" >> /tmp/install.log

echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf 
iptables -t nat -A POSTROUTING -o ethx # -j MASQUERADE (a voir si on active le masquerade)
echo "-----------ROUTAGE-----------" >> /tmp/install.log

echo "------------------ EXECUTION DU PYTHON------------------"
git clone https://github.com/projetsecu/projetsecurite.git /home/debian/ctf/
python /home/debian/ctf/ctf_difficile/routeur_ip.py
sudo rm -r /home/debian/ctf

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
done < ip_network.txt

#IPSEC
# sudo echo -e "
# flush; \n
# spdflush; \n
# spdadd $IP_ROUTEUR $IP_SERVEUR any -P out ipsec esp/transport//require; \n
# add $IP_ROUTEUR $IP_SERVEUR esp $ESP_ROUTEUR -E des-cbc \x2212345678\x22 -A hmac-md5 \x221234567890123456\x22; \n
# spdadd $IP_SERVEUR $IP_ROUTEUR any -P in ipsec esp/transport//require; \n
# add $IP_SERVEUR $IP_ROUTEUR esp $ESP_SERVEUR -E des-cbc \x2212345678\x22 -A hmac-md5 \x221234567890123456\x22; \n
# " >> sudo /etc/ipsec-tools.conf
#\042
/etc/init.d/setkey restart

