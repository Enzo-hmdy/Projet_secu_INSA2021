#!/bin/bash
#On retrouvera la sortie standard dans install.out.log et les erreurs dans install.err.log
exec >/tmp/install.out.log 2>/tmp/install.err.log    

#echo "deb http://ftp.fr.debian.org/debian stretch main" >> /etc/apt/sources.list
DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install git

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
echo "-----------ROUTAGE-----------" 

iptables -I INPUT -p tcp --dport 22 -i eth0 -m state --state NEW -m recent --set 
echo "-----------IPTABLES CREATE RULE----------" 

iptables -I INPUT -p tcp --dport 22 -i eth0 -m state --state NEW -m recent  --update --seconds 300 --hitcount 10 -j DROP 
echo "-----------IPTABLES SET RULE-----------" 


#mkdir Bureau Documents Images Modèles Musiques Téléchargements Vidéos 




echo "__________________ CLIENT NETCAT __________________"

apt install -y nc
apt install -y ncat
git clone https://github.com/projetsecu/projetsecurite.git /home/debian/netcat/
cp /home/debian/netcat/ctf_difficile/script_patron_nc.sh /home/debian/
rm -R /home/debian/netcat

#Utilisation de Cron pour exécuter script_patron_nc.sh toutes les minutes