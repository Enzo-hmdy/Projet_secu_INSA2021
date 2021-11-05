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
            if($_SESSION['username'] !== ""){
                $user = $_SESSION['username'];
                // afficher un message
                echo "Bonjour $user, vous êtes connecté";
            }
        ?>

        <button class="recherche" type="button" onclick="lancer_recherche_users()">Afficher la base des utilisateurs</button>

        <?php

        $connexionString = "host=localhost dbname=ctf_facile user=admin password=azerty";
        $db = pg_connect($connexionString)
            or die('Connexion impossible : ' . pg_last_error());

        $query = "SELECT * FROM users;";

        $res = pg_query($db, $query) or die('Échec de la requête : ' . pg_last_error());

        echo "fjeif";

        while ($row = pg_fetch_row($res)) {
            $tab[] = $row;
        }

        echo "ouesh";

        echo "<table id='recherche_users'>";
        echo "<caption id='caption_users'>Liste des utilisateurs du site</caption>";
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
            echo "'</tr>";
        }
        echo "</table>";


        ?>
            
    </div>

    <script src='https://ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min.js'></script>
    <script src="script.js"></script>

</body>

</html>