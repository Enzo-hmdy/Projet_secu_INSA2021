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
ESP_ROUTEUR=021980
ESP_SERVEUR=0X021980
echo "-----------VARIABLE GLOBALE : IP-----------" >> /tmp/install.log

echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf 
iptables -t nat -A POSTROUTING -o ethx # -j MASQUERADE (a voir si on active le masquerade)
echo "-----------ROUTAGE-----------" >> /tmp/install.log

#IPSEC
sudo echo -e "
flush; \n
spdflush; \n
spdadd $IP_ROUTEUR $IP_SERVEUR any -P out ipsec esp/transport//require; \n
add $IP_ROUTEUR $IP_SERVEUR esp $ESP_ROUTEUR -E des-cbc \x2212345678\x22 -A hmac-md5 \x221234567890123456\x22; \n
spdadd $IP_SERVEUR $IP_ROUTEUR any -P in ipsec esp/transport//require; \n
add $IP_SERVEUR $IP_ROUTEUR esp $ESP_SERVEUR -E des-cbc \x2212345678\x22 -A hmac-md5 \x221234567890123456\x22; \n
" >> sudo /etc/ipsec-tools.conf
#\042
/etc/init.d/setkey restart

