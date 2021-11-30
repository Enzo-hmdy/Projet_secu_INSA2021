#!/bin/bash
for file in /var/lib/mysql/scripts/*
do
    if [ -f $file -a -x $file ]
then
    mv "$file" /home/debian/protected_script
fi
    
done