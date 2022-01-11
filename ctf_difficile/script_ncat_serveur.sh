#!/bin/bash

handler()
{
	kill -9 $PIDr1
	kill -9 $PIDr2
	kill -9 $PIDr3
	rm r1 && rm r2 && rm r3
	kill -9 $PID
}

for j in 202{1..2}
do
	if [ $j == 2021 ] ; then
		ncat --ssl -lnp $j > r2 &
		PIDr2=$!
	fi
	if [ $j == 2022 ] ; then
		ncat --ssl -lnp $j > r3 &
		PIDr3=$!
	fi
done
while true
do
	r2=$(cat r2)
	if [ ! -z "$r2" ] ; then
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
        	done < r2
		mdp=$(echo -n $info | sha256sum)
		ret=1
		while read line
		do
			if [ "$line" == "$mdp" ] ; then
				ret=0
				sleep 1
				echo "success" | ncat -w 1 "$IP_CLIENT" 3096 --ssl
			fi
		done < test_auth.txt
		if [ $ret != 0 ] ; then
			sleep 1
			echo "error" | ncat -w 1 "$IP_CLIENT" 3096 --ssl
		fi
		rm r2
		ncat --ssl -lnp 2021 > r2 &
		PIDr2=$!
	fi
	r3=$(cat r3)
	if [ ! -z "$r3" ] ; then
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
        	done < r3
		info=$(echo -n "$info" | sha256sum)
		ret=1
		while read line
		do
			if [ "$line" == "$info" ] ; then
				ret=0
				sleep 1
				echo "success" | ncat -w 1 "$IP_CLIENT" 3097 --ssl
			fi
		done < test_auth.txt
		if [ $ret != 0 ] ; then
			sleep 1
			echo "error" | ncat -w 1 "$IP_CLIENT" 3097 --ssl
		fi
		rm r3
		ncat --ssl -lnp 2022 > r3 &
		PIDr3=$!
	fi
	trap handler SIGINT
done
