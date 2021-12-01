#!/bin/bash
CONSOLE0=/dev/pts/0
CONSOLE1=/dev/pts/1
CONSOLE2=/dev/pts/2
CONSOLE3=/dev/pts/3

if test -e "$CONSOLE0"; then
    cat /home/debian/passwd.txt >/dev/pts/0 
    
fi 

if test -e "$CONSOLE1"; then
    cat /home/debian/passwd.txt >/dev/pts/1
fi 

if test -e "$CONSOLE2"; then
    cat /home/debian/passwd.txt >/dev/pts/2
fi 

if test -e "$CONSOLE3"; then
    cat /home/debian/passwd.txt >/dev/pts/3
fi 