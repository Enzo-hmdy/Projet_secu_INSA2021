#!/bin/bash

handler()
{
	kill -9 $PIDr1
	kill -9 $PIDr2
	kill -9 $PIDr3
	rm r1 && rm r2 && rm r3
	kill -9 $PID
}

nc -lnp 2020 > r1 &
PIDr1=$!
PID=$(($PIDr1-1))

while true
do
	r1=$(cat r1)
	if [ ! -z "$r1" ] ; then
        	c=0
		while read line
        	do
                	if [ "$c" -eq "1" ] ; then
                        	info="$line"
                        	c=$(($c+1))
                	fi
                	if [ "$c" -eq "0" ] ; then
                        	IP_CLIENT="$line"
                        	c=$(($c+1))
                	fi
       		done < r1
		info=$(echo -n "$info" | sha256sum)
		ret=1
		while read line
		do
			if [ "$line" == "$info" ] ; then
				ret=0
				sleep 1
				echo "success" | nc -w 1 "$IP_CLIENT" 3095
			fi
		done < test_auth.txt
		if [ $ret != 0 ] ; then
			sleep 1
			echo "error" | nc -w 1 "$IP_CLIENT" 3095
		fi
		rm r1
		nc -lnp 2020 > r1 &
		PIDr1=$!
	fi
	trap handler SIGINT
done

