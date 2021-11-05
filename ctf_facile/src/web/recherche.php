<?php

    function lancer_recherche_users() {

    $connString = "host=localhost dbname=ctf_facile user=admin password=azerty";

    $result = array();

    // Connexion, sélection de la base de données
    $dbconn = pg_connect($connString)
    or die('Connexion impossible : ' . pg_last_error());
    
    $query = "SELECT * FROM users;";

    $res = pg_query($dbconn, $query) or die('Échec de la requête : ' . pg_last_error());

    // Ferme la connexion
    pg_close($dbconn);

    while ($row = pg_fetch_row($res)) {
        $result[] = $row;
    }

    //On retourne la requête
    return $result;
    }

?>