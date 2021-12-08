#!/bin/bash
echo "deb http://ftp.fr.debian.org/debian stretch main" >> /etc/apt/sources.list
sudo apt-get update
apt-get install -y racoon ipsec-tools

IP_ROUTEUR=172.10.0.74
IP_PATRON=172.10.0.27
IP_SERVEUR=172.10.0.128 
echo "-----------VARIABLE GLOBALE : IP-----------" >> /tmp/install.log


route add -net 172.10.0.128 netmask 255.255.255.255 gw 172.10.0.74
echo "-----------ROUTAGE-----------" >> /tmp/install.log

# echo "
# flush;
# spdflush;
# spdadd $IP_PATRON $IP_SERVEUR any -P out ipsec esp/tunnel/$IP_ROUTEUR/require;
# add $IP_ROUTEUR esp 1 -m tunnel -E des-cbc "12345678" -A hmac-md5 "1234567890123456";

# spdadd $IP_SERVEUR $IP_PATRON  any -P in ipsec esp/tunnel/$IP_ROUTEUR/require;
# add $IP_ROUTEUR esp 1 -m tunnel -E des-cbc "12345678" -A hmac-md5 "1234567890123456";
# " >> /etc/ipsec-tools.conf

# /etc/init.d/setkey restart
# echo "-----------IPSEC-----------" >> /tmp/install.log
