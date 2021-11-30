#!/bin/bash
for file in /var/lib/mysql/scripts
do
    mv "$file" /home/debian/protected_script
done