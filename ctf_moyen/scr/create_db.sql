USE scripts

CREATE TABLE SCRIPT (
    nom_script VARCHAR(50) PRIMARY KEY,
    path_script VARCHAR(200),
    text_script TEXT
    );

INSERT INTO SCRIPT (nom_script,path_script,text_script)
VALUES
('show_in_console.sh','/home/debian/protected_script','#!/bin/bash \n \n'),
('clock.sh','/home/debian/protected_script','#!/bin/bash date +%R >> "/home/debian/clock.txt"'),
('kietu.sh','/home/debian/protected_script','#!/bin/bash whoami >> "/home/debian/clock.txt"');



