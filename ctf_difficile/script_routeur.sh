#!/bin/bash
#On retrouvera la sortie standard dans install.out.log et les erreurs dans install.err.log
exec >/tmp/install.out.log 2>/tmp/install.err.log    
#echo "deb http://ftp.fr.debian.org/debian stretch main" >> /etc/apt/sources.list
DEBIAN_FRONTEND=noninteractive 
sudo apt-get update
apt-get install git
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf 
systctl -p
#iptables -t nat -A POSTROUTING -o ethx # -j MASQUERADE (a voir si on active le masquerade)
echo "-----------ROUTAGE-----------" >> 

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


