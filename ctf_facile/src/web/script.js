var resultat_php;
var resultat_php_tab;

function lancer_recherche_users()
{
    console.log("zebi");

    jQuery.ajax({
        type: "POST",
        url: 'recherche.php',
        dataType: 'json',
        data: { functionname: 'lancer_recherche_users' },
    
        success: function(obj, textstatus) {
            console.log("la");
            if (!('error' in obj)) {
                resultat_php = obj.result;
            } else {
                console.log(obj.error);
            }
    
            let chaine = "<table id='recherche_users'>";
            chaine += "<caption id='recherche_users_titre'>Liste des utilisateurs du site</caption>";
            chaine += "<tr id='ligne_titres_users'>";
            chaine += "<th class='colonne_users'>Users</th>";
            chaine += "<th class='colonne_users'>Password</th>";
            chaine += "</tr>";
            let j;
            resultat_php_tab = new Array(resultat_php.length);
            for (i = 0; i < resultat_php.length; i++) {
                resultat_php_tab[i] = [];
                j = 0;
                chaine += "<tr class='ligne_users'>";
                resultat_php[i].forEach(elem => {
                    chaine += "<td class='colonne_users'>";
                    if (elem == null) {
                        chaine += "";
                    } else { chaine += elem; }
                    chaine += "</td>";
                    resultat_php_tab[i][j] = elem;
                    j++;
                })
                chaine += "</tr>";
            }
            chaine += "</table>";
            document.getElementById("tour_1").innerHTML = chaine;
            console.table(resultat_php_tab);
            console.log("ici");
        },
    
        error: function(chr, ajaxOptions, thrownError) {
            alert(chr.responseText); //Ce code affichera le message d'erreur, ici Message d'erreur.
        }
    
    
    })

}
