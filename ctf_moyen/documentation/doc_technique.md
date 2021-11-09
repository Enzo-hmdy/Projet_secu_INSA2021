# Documentation Technique

## Liste package necessaire :



## Service utilisés :
<br>

1. ### MariaDB 10.5.12

    1. Fichier Configuration

Fichier configuration  /etc/mysql/mariadb.conf.d/50-server.cnf Modifier la ligne 

```s
bind-address            = 127.0.0.1
```

en 

```s
bind-address           = 0.0.0.0
```

Afin d'autoriser la connexion en remote venant de toutes les ip distantes. 


    1. Fichier Configuration



