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
        $password = hash("md5",$_POST['password'], false);
        $requete = "SELECT id,passwd FROM users WHERE 
              id='$username' AND passwd='$password';";
        $exec_requete = pg_query($db,$requete);
        $reponse      = pg_num_rows($exec_requete);
        if($reponse == 1) // nom d'utilisateur et mot de passe corrects
        {
           $_SESSION['username'] = $username;
           $_SESSION['password'] = $_POST['password'];
           header('Location: home.php');
        }
        else
        {
           header('Location: index.php?erreur=1'); // utilisateur ou mot de passe incorrect
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