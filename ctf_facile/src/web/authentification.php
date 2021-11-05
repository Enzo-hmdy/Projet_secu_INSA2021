<?php

session_start();

if(isset($_POST['username']) && isset($_POST['password']))
{
    // connexion à la base de données

    $connexionString = "host=localhost dbname=ctf_facile user=admin password=azerty";
    $db = pg_connect($connexionString)
           or die('Connexion impossible : ' . pg_last_error());

    if($_POST['username'] !== "" && $_POST['password'] !== "")
    {
        $username = $_POST['username'];
        $password = $_POST['password'];
        $requete = "SELECT id, passwd FROM users WHERE 
              id='$username' AND passwd='$password';";
        echo "requete".$requete;
        $exec_requete = pg_query($db,$requete);
        $reponse      = pg_fetch_row($exec_requete);
        echo "reponse : ".$reponse[0]." et ".$reponse[1];
        if($count!=0) // nom d'utilisateur et mot de passe corrects
        {
           $_SESSION['username'] = $_POST['username'];
           echo('Location: home.php');
        }
        else
        {
           echo('Location: index.php?erreur=1'); // utilisateur ou mot de passe incorrect
        }
    }
    else
    {
       header('Location: index.php?erreur=2'); // utilisateur ou mot de passe vide
    }
}

else
{
   header('Location: index.php');
}
pg_close($db); // fermer la connexion

?>