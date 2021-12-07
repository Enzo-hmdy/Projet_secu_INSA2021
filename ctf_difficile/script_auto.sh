#!/usr/bin/sh
exec > /tmp/auto.out.log

while true
do
  /home/debian/script_netcat
  sleep 10
done