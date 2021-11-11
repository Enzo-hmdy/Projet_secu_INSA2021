<!DOCTYPE html>

<html>

<head>

    <meta charset="utf-8" />
    <link rel="stylesheet" href="style.css" />
    <title>Espace utilisateur</title>

</head>

<body>
    <div id="content">
        <!-- tester si l'utilisateur est connecté -->
        <?php
            session_start();
            if (!$_SESSION['login']) 
            {
                header("Location: index.php");
                die();
            }
            if($_SESSION['username'] !== ""){
                $user = $_SESSION['username'];
                // afficher un message
                echo "<h1>Bonjour $user, vous êtes connecté</h1>";
            }
        ?>

        <br />
        <br />
        <br />
        <br />

        <?php

        $connexionString = "host=localhost dbname=ctf_facile user=admin password=kostadinkostadinovic";
        $db = pg_connect($connexionString)
            or die('Connexion impossible : ' . pg_last_error());

        if($_SESSION['username'] == "admin")
        {
            $query = "SELECT * FROM users;";
        }
        else $query = "SELECT * FROM users WHERE id='".$_SESSION['username']."';";

        $res = pg_query($db, $query) or die('Échec de la requête : ' . pg_last_error());

        while ($row = pg_fetch_row($res)) {
            $tab[] = $row;
        }

        echo "<table id='recherche_users'>";
        echo "<caption id='caption_users'><h2>Liste des utilisateurs du site</h2></caption>";
        echo "<tr id='ligne_titres_users'>";
        echo "<th class='colonne_users'>User</th>";
        echo "<th class='colonne_users'>Password</th>";
        echo "</tr>";
        $i=0;
        $j=0;
        for($i=0; $i < sizeof($tab); $i++){
            $j=0;
            echo "<tr class='ligne_users'>";
            for($j=0; $j<2; $j++){
                echo "<td class='colonne_users'>".$tab[$i][$j]."</td>";
            }
            echo "</tr>";
        }
        echo "</table>";
        
        session_destroy();

        ?>

        <style>

            #recherche_users {
                width: 80%;
                border-collapse: collapse;
                margin: 0 auto;
                margin-bottom: 3%;
                margin-top: 3%;
                position: relative;
                text-align: center;
                font-size: 250%;
            }

            #caption_users {
                font-family: 'Exo', sans-serif;
                position: relative;
                margin-bottom: 1%;
                text-align: center;
                color: rgb(60, 60, 60);
                font-size: 100%;
            }

            #ligne_titres_users {
                background-color: rgba(82, 255, 0, 0.5);
            }

            .colonne_users {
                border: 1px solid black;
            }

            .ligne_users {
                background-color: rgba(82, 255, 0, 0.3);
            }

            .ligne_users:hover {
                background-color: rgba(82, 255, 0, 0.5);
            }

        </style>
            
    </div>

</body>

</html>