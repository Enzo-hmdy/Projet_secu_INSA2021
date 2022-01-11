#!/bin/bash

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
done < ip_network.txt

echo "$IP_CLIENT" > send.txt
echo "kali" >> send.txt

nc -w 1 $IP_SERVEUR 2020 < send.txt

ack=$(nc -lnp 3095)

date >> ack.txt
echo $ack >> ack.txt

rm send.txt
