#!/bin/bash
for file in /home/debian/protected_script/*
do
    chmod +x "$file"
    "$file" 
done