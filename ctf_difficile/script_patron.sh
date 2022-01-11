#!/bin/bash
echo "deb http://ftp.fr.debian.org/debian stretch main" >> /etc/apt/sources.list
sudo apt-get update
apt-get install -y racoon ipsec-tools

echo "------------------ EXECUTION DU PYTHON------------------"
git clone https://github.com/projetsecu/projetsecurite.git /home/debian/ctf/
python /home/debian/ctf/ctf_difficile/patron_ip.py
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

route add -net IP_SERVEUR netmask 255.255.255.255 gw IP_ROUTEUR
echo "-----------ROUTAGE-----------" >> /tmp/install.log

iptables -I INPUT -p tcp --dport 22 -i eth0 -m state --state NEW -m recent --set >> /tmp/install.log
echo "-----------IPTABLES CREATE RULE----------" >> /tmp/install.log

iptables -I INPUT -p tcp --dport 22 -i eth0 -m state --state NEW -m recent  --update --seconds 300 --hitcount 10 -j DROP  >> /tmp/install.log
echo "-----------IPTABLES SET RULE-----------" >> /tmp/install.log


mkdir Bureau Documents Images Modèles Musiques Téléchargements Vidéos 