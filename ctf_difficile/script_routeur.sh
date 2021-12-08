#!/bin/bash
echo "deb http://ftp.fr.debian.org/debian stretch main" >> /etc/apt/sources.list
sudo apt-get update >> /tmp/install.log
apt-get install -y ipsec-tools >> /tmp/install.log
apt-get install racoon >> /tmp/install.log
DEBIAN_FRONTEND=noninteractive apt-get install racoon >> /tmp/install.log
echo "-----------INSTALL RACOON IPSEC-TOOLS-----------" >> /tmp/install.log

IP_ROUTEUR=172.10.0.74
IP_PATRON=172.10.0.27
IP_SERVEUR=172.10.0.128 
echo "-----------VARIABLE GLOBALE : IP-----------" >> /tmp/install.log

echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf 
iptables -t nat -A POSTROUTING -o ethx # -j MASQUERADE (a voir si on active le masquerade)
echo "-----------ROUTAGE-----------" >> /tmp/install.log

#/etc/init.d/setkey restart