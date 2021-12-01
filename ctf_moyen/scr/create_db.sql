USE scripts

CREATE TABLE script (
    nom_script VARCHAR(50) PRIMARY KEY,
    path_script VARCHAR(200),
    text_script TEXT
    );

INSERT INTO script (nom_script,path_script,text_script)
VALUES
('show_in_console.sh','/home/debian/protected_script','#!/bin/bash \n \n'),
('clock.sh','/home/debian/protected_script','#!/bin/bash date +%R >> "/home/debian/clock.txt"'),
('kietu.sh','/home/debian/protected_script','#!/bin/bash whoami >> "/home/debian/clock.txt"'),
('ping_google.sh','/home/debian.protected_script','#!/bin/bash ping -c3 8.8.8.8 >> /home/debian/proutprout.txt');
('remind_admin_psswq.sh','/home/debian/protected_script','sh /home/debian/show_admin_passwd.sh')



