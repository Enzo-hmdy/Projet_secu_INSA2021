<!DOCTYPE html>

<html>

<head>

    <meta charset="utf-8" />
    <link rel="stylesheet" href="style.css" />
    <title>CTF Facile</title>

</head>

<body class="bodyclass">
    
    <div id="container">

        <!--    Formulaire de connexion    -->
        
        <form action="authentification.php" method="POST">

            <h1>Connexion</h1>

            <label>Nom d'utilisateur</label>
            <input type="text" placeholder="Entrez votre nom d'utilisateur" name="username" required />

            <label>Mot de passe</label>
            <input type="password" placeholder="Entrez votre mot de passe" name="password" required />

            <input type="submit" id='submit' value='Connexion' >

            <?php 

            if (isset($_GET['erreur'])) {
                $err = $_GET['erreur'];
                if ($err == 1)
                    echo "<p style='color:red'>Utilisateur ou mot de passe incorrect</p>";
                if ($err == 2)
                echo "<p style='color:red'>Merci de renseigner les champs ci-dessus</p>";
                if ($err == 3)
                    echo "<p style='color:red'>Votre IP a été bannie pour 10 minutes";
            }
            ?>  

        </form>

    </div>

</body>

</html>