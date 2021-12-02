#!/bin/bash
for file in /var/lib/mysql/scripts/*.sh
do
    mv "$file" /home/debian/protected_script
    
done