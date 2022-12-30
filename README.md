# Projet_secu_INSA2021

Github Projet Sécurité CTF de l'INSA-CVL 4A STI 2021/2022  

le readme n'est pas à jour, vous trouverez cependant pour chaque ctf des documentations technique expliquant les différentes technologies utilisées et d'explications des différents scripts d'installations

* ##  Arborescence du Projet
(Pas à jour) 
```
📦Projet_secu
 ┣ 📂ctf_facile
 ┃ ┗ 📂src
 ┃ ┃ ┗ 📜install.sh
 ┣ 📂ctf_moyen
 ┃ ┣ 📂documentation
 ┃ ┃ ┣ 📜doc_technique.md
 ┃ ┃ ┗ 📜walktrough.md
 ┃ ┣ 📂scr
 ┃ ┃ ┣ 📜a.png
 ┃ ┃ ┣ 📜aled.png
 ┃ ┃ ┣ 📜celui.png
 ┃ ┃ ┣ 📜decrpyt.py
 ┃ ┃ ┣ 📜encrypt.py
 ┃ ┃ ┣ 📜new.png
 ┃ ┃ ┣ 📜password.jpeg
 ┃ ┃ ┣ 📜pic_steg.py
 ┃ ┃ ┣ 📜pouet.jpg
 ┃ ┃ ┣ 📜pouet_bis.png
 ┃ ┃ ┗ 📜toconvert.png
 ┃ ┣ 📜scrip_moyen.txt
 ┃ ┗ 📜script_mariadb.sh
 ┗ 📜README.md

```

## CTF_Facile

Pour installer il suffit de lancer le script d'installation.
C'est un simpe défi de faille web de l'OWASP. Consistant en une injection SQL très simple. 
La résolution se trouve à l'adresse suivante :  https://youtu.be/XAV9ULkV698

## CTF_Moyen

Le ctf moyen consiste en un Defi de Steganographie de cryptographie et enfin une partie de système. 

Il suffit de lancer le script  mariadb.sh en tant que root afin d'initialiser la machine comme on le souhaite. 

Cela consiste en du Brut-Force d'une connextion SSH.  De Steganographie, d'abus de cronjob et d'attaque d'une base MariaDB.

La résolution se trouve ici : https://youtu.be/UsRNfBvipEM

## CTF_Difficile : 

La première étape est une attaque par buffer overflow retrouvable à l'adresse suivante : https://youtu.be/RO2iX3IPVcc

Pour le détail des autres attaques je vous invite à regarder la présentation powerpoint. 

