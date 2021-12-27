<?php

session_start();

$bad_login_limit = 5;
$lockout_time = 600;

if(isset($_POST['username']) && isset($_POST['password']))
{
    // connexion à la base de données

    $connexionString = "host=localhost dbname=ctf_facile user=admin password=kostadinkostadinovic";
    $db = pg_connect($connexionString)
           or die('Connexion impossible : ' . pg_last_error());

    $ip = $_SERVER['REMOTE_ADDR'];

    $test_ip_requete = pg_query($db, "select IP from brute_force where IP='".$ip."';") or die('Connexion impossible (test_ip_requete) : ' . pg_last_error());
    $test_ip = pg_num_rows($test_ip_requete);

    if($test_ip == 0){
       pg_query($db, "insert into brute_force values ('".$ip."', 0, NULL);") or die('Connexion impossible (test_ip=0) : ' . pg_last_error());
    }
    
    $brute_array = pg_query($db, "select * from brute_force where IP='".$ip."';") or die('Connexion impossible (brute) : ' . pg_last_error());

    $brute = pg_fetch_array($brute_array, NULL, PGSQL_ASSOC);

    $count = $brute['count'];
    $first_fail_time = $brute['first_fail'];

    if($_POST['username'] !== "" && $_POST['password'] !== "")
    {
       if($count >= $bad_login_limit && time()-$first_fail_time < $lockout_time){
          header('Location: index.php?erreur=3');
       }
       else
       {
        $_SESSION['login'] = false;
        $username = $_POST['username'];
        $password = hash("md5",$_POST['password'], false);
        $requete = "SELECT id,passwd FROM users WHERE 
              id='$username' AND passwd='$password';";
        $exec_requete = pg_query($db,$requete);
        $reponse      = pg_num_rows($exec_requete);
        if($reponse == 1) // nom d'utilisateur et mot de passe corrects
        {
           $_SESSION['username'] = pg_fetch_array(pg_query($db, "SELECT id FROM users WHERE id='$username';" ))[0];
           $_SESSION['password'] = $_POST['password'];
           $_SESSION['login'] = true;
           header('Location: home.php');
        }
        else
        {
           if(time()-$first_fail_time > $lockout_time){
              $first_fail_time = time();
              $count = 1;
              pg_query($db, "update brute_force set first_fail=".$first_fail_time."where IP='".$ip."';");
              pg_query($db, "update brute_force set count=".$count."where IP='".$ip."';");
           }
           else{
               pg_query($db, "update brute_force set count=count+1 where IP='".$ip."';");
           }
           header ('Location: index.php?erreur=1'); // utilisateur ou mot de passe incorrect
        }
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