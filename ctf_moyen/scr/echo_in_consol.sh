#!/bin/bash
CONSOLE0=/dev/pts/0
CONSOLE1=/dev/pts/1
CONSOLE2=/dev/pts/2
CONSOLE3=/dev/pts/3

if test -e "$CONSOLE0"; then
    {echo il est actuellement : ; date +%R ; } >/dev/pts/0 
fi 

if test -e "$CONSOLE1"; then
    {echo il est actuellement : ; date +%R ; } >/dev/pts/1 
fi 

if test -e "$CONSOLE2"; then
    {echo il est actuellement : ; date +%R ; } >/dev/pts/2 
fi 

if test -e "$CONSOLE3"; then
    {echo il est actuellement : ; date +%R ; } >/dev/pts/3 
fi 