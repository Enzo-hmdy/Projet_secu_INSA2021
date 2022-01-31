# Write up ctf facile 1 

## Etape 1 :  Analyser Réseau

Premièrement on effecture une analyse du réseau de la machine afin de voir quels ports sont ouverts : 

```bash
nmap 172.30.150.47
```

Résultat :

![Resultat nmap](1.PNG)

On constaste qu'il y a le port ssh d'ouvert et un service web, allons voir de ce coté ! 

INSERER IMAGE 2 

On constate que c'est la page par défaut de appache, nous allons voir si il n'y a pas des fichier ou des redirections cachées avec l'outil ` gobuster `

```sh
gobuster dir -u http://172.30.150.47/ -w /usr/share/wordliste/dirbuster/directory-list-2.3-medium.txt -x .php,.html -t 40
```

| Paramètre | Signification |
|------------|---------------|
| -u          |   url du site          |
| -w          |   liste de mot à utiliser             |
| -x          |  extension de fichier à regarder              |


Il y a 3 url possible et accessible /uploads/ qui est un répertoire, /upload.php, et /index.html sur le quel nous somme déjà, allons voir du coté du /upload.php 

INSERER IMAGE 3 


Nous arrivons sur une page basique où nous pouvons uploads des fichiers, on va voir si il accepte des script php où fait attention à l'extension du fichier. 


INSERER IMAGE 4 