<!DOCTYPE html>

<html>

<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="stylepredictions.css" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <title>Prédictions</title>
</head>


<body class="predictions" id="body_id">

    <div class="retour_haut_page">
        <a href="#ancrehautpage"><img src="images/to_top.png" /></a>
    </div>

    <nav role="navigation">
        <div id="menuToggle">

            <input type="checkbox" id="checkbox_burger" onclick="menu_deroulant_bloquant()" />

            <span></span>
            <span></span>
            <span></span>

            <ul id="menu">
                <a href="index.html">
                    <li>Accueil</li>
                </a><br>
                <a href="predictions.php">
                    <li>IA de prédiction</li>
                </a><br>
                <a href="actualites.html">
                    <li>Actualités</li>
                </a><br>
                <a href="projet.html">
                    <li>Le projet</li>
                </a><br>
                <a href="equipe.html">
                    <li>L'équipe</li>
                </a><br>
                <a href="contact.html">
                    <li>Contact</li>
                </a>

                <p id="copyright">© STI'LECTION, 2021 - Tous droits réservés</p>
            </ul>

    </nav>



    <div>
        <p id="texte_choix_echelle">Choisissez les éléctions qui vous intéressent :</p>
    </div>



    <div class="images_map">
        <img class="dep" id="img_dep" src="images/dep_nb.png" onmouseover="this.src='images/dep_couleur.png'"
            onmouseout="this.src='images/dep_nb.png'" onclick="afficherDeroulantDep()" alt="Images département">
        <img class="reg" id="img_reg" src="images/reg_nb.png" onmouseover="this.src='images/reg_couleur.png'"
            onmouseout="this.src='images/reg_nb.png'" onclick="afficherDeroulantReg()" alt="Images région">
        <img class="fr" id="img_fr" src="images/fr_nb.png" onmouseover="this.src='images/fr_couleur.png'"
            onmouseout="this.src='images/fr_nb.png'" onclick="afficherDeroulantFr()" alt="Images france">
    </div>

    <div class="section_departement" id="section_departement">

        <div class="label_deroulant_dep_annee">
            <label for="dep_annee_choix"> Sélectionner une année :</label>
        </div>

        <div class="deroulant_dep_annee">
            <select name="dep_annee" id="dep_annee_choix" onchange="recuperer_departement_annee()">
                <option value="Default"> --- Année --- </option>
                <option value="2008">2008</option>
                <option value="2011">2011</option>
                <option value="2015">2015</option>
                <option value="2021">2021</option>
            </select>
        </div>

        <div class="label_deroulant_dep">
            <label for="dep_choix"> Sélectionner un département :</label>
        </div>

        <div class="deroulant_dep">
            <select name="dep" id="dep_choix" onchange="recuperer_departement()">
                <option value="Default"> --- Département --- </option>
                <option value="1">1 - Ain</option>
                <option value="2">2 - Aisne</option>
                <option value="3">3 - Allier</option>
                <option value="4">4 - Alpes-de-Haute-Provence</option>
                <option value="5">5 - Hautes-Alpes</option>
                <option value="6">6 - Alpes-Maritimes</option>
                <option value="7">7 - Ardèche</option>
                <option value="8">8 - Ardennes</option>
                <option value="9">9 - Ariège</option>
                <option value="10">10 - Aube</option>
                <option value="11">11 - Aude</option>
                <option value="12">12 - Aveyron</option>
                <option value="13">13 - Bouches-du-Rhône</option>
                <option value="14">14 - Calvados</option>
                <option value="15">15 - Cantal</option>
                <option value="16">16 - Charente</option>
                <option value="17">17 - Charente-Maritime</option>
                <option value="18">18 - Cher</option>
                <option value="19">19 - Corrèze</option>
                <option value="21">21 - Côte-d'Or</option>
                <option value="22">22 - Côtes-d'Armor</option>
                <option value="23">23 - Creuse</option>
                <option value="24">24 - Dordogne</option>
                <option value="25">25 - Doubs</option>
                <option value="26">26 - Drôme</option>
                <option value="27">27 - Eure</option>
                <option value="28">28 - Eure-et-Loir</option>
                <option value="29">29 - Finistère</option>
                <option value="2A">2A - Corse-du-Sud</option>
                <option value="2B">2B - Haute-Corse</option>
                <option value="30">30 - Gard</option>
                <option value="31">31 - Haute-Garonne</option>
                <option value="32">32 - Gers</option>
                <option value="33">33 - Gironde</option>
                <option value="34">34 - Hérault</option>
                <option value="35">35 - Ille-et-Vilaine</option>
                <option value="36">36 - Indre</option>
                <option value="37">37 - Indre-et-Loire</option>
                <option value="38">38 - Isère</option>
                <option value="39">39 - Jura</option>
                <option value="40">40 - Landes</option>
                <option value="41">41 - Loir-et-Cher</option>
                <option value="42">42 - Loire</option>
                <option value="43">43 - Haute-Loire</option>
                <option value="44">44 - Loire-Atlantique</option>
                <option value="45">45 - Loiret</option>
                <option value="46">46 - Lot</option>
                <option value="47">47 - Lot-et-Garonne</option>
                <option value="48">48 - Lozère</option>
                <option value="49">49 - Maine-et-Loire</option>
                <option value="50">50 - Manche</option>
                <option value="51">51 - Marne</option>
                <option value="52">52 - Haute-Marne</option>
                <option value="53">53 - Mayenne</option>
                <option value="54">54 - Meurthe-et-Moselle</option>
                <option value="55">55 - Meuse</option>
                <option value="56">56 - Morbihan</option>
                <option value="57">57 - Moselle</option>
                <option value="58">58 - Nièvre</option>
                <option value="59">59 - Nord</option>
                <option value="60">60 - Oise</option>
                <option value="61">61 - Orne</option>
                <option value="62">62 - Pas-de-Calais</option>
                <option value="63">63 - Puy-de-Dôme</option>
                <option value="64">64 - Pyrénées-Atlantiques</option>
                <option value="65">65 - Hautes-Pyrénées</option>
                <option value="66">66 - Pyrénées-Orientales</option>
                <option value="67">67 - Bas-Rhin</option>
                <option value="68">68 - Haut-Rhin</option>
                <option value="69">69 - Rhône</option>
                <option value="70">70 - Haute-Saône</option>
                <option value="71">71 - Saône-et-Loire</option>
                <option value="72">72 - Sarthe</option>
                <option value="73">73 - Savoie</option>
                <option value="74">74 - Haute-Savoie</option>
                <option value="75">75 - Paris</option>
                <option value="76">76 - Seine-Maritime</option>
                <option value="77">77 - Seine-et-Marne</option>
                <option value="78">78 - Yvelines</option>
                <option value="79">79 - Deux-Sèvres</option>
                <option value="80">80 - Somme</option>
                <option value="81">81 - Tarn</option>
                <option value="82">82 - Tarn-et-Garonne</option>
                <option value="83">83 - Var</option>
                <option value="84">84 - Vaucluse</option>
                <option value="85">85 - Vendée</option>
                <option value="86">86 - Vienne</option>
                <option value="87">87 - Haute-Vienne</option>
                <option value="88">88 - Vosges</option>
                <option value="89">89 - Yonne</option>
                <option value="90">90 - Territoire de Belfort</option>
                <option value="91">91 - Essonne</option>
                <option value="92">92 - Hauts-de-Seine</option>
                <option value="93">93 - Seine-Saint-Denis</option>
                <option value="94">94 - Val-de-Marne</option>
                <option value="95">95 - Val-d'Oise</option>
                <option value="ZA">ZA - Guadeloupe</option>
                <option value="ZD">ZD - La Réunion</option>
                <option value="ZM">ZM - Mayotte</option>
            </select>
        </div>

        <button class="button_dep" type="button" onclick="lancer_recherche_dep()">Lancez la recherche</button>
        <div id="loader"></div>


        <div id="graph_dep">
            <h2> Graphe élections départementales</h2>
        </div>
        
        <div id="graphe_t1"></div>
        <div id="graphe_t2"></div>
        <div id="tour_1"></div>
        <div id="tour_2"></div>
        

    </div>

    <div class="section_region" id="section_region">

        <div class="label_deroulant_reg_annee">
            <label for="reg_annee_choix"> Sélectionner une année :</label>
        </div>

        <div class="deroulant_reg_annee">
            <select name="reg_annee" id="reg_annee_choix" onchange="recuperer_region_annee()">
                <option value="Default"> --- Année --- </option>
                <option value="1998">1998</option>
                <option value="2004">2004</option>
                <option value="2010">2010</option>
                <option value="2015">2015</option>
            </select>
        </div>


        <div class="label_deroulant_reg">
            <label for="reg_choix"> Sélectionner une région :</label>
        </div>

        <div class="deroulant_reg">
            <select name="reg" id="reg_choix" onchange="recuperer_region()">
                <option value="Default"> --- Région --- </option>
                <option value="1">Auvergne-Rhône-Alpes</option>
                <option value="2">Bourgogne-Franche-Comté</option>
                <option value="3">Bretagne</option>
                <option value="4">Centre-Val de Loire</option>
                <option value="5">Corse</option>
                <option value="6">Grand Est</option>
                <option value="7">Hauts-de-France</option>
                <option value="8">Ile-de-France</option>
                <option value="9">Normandie</option>
                <option value="10">Nouvelle-Aquitaine</option>
                <option value="11">Occitanie</option>
                <option value="12">Pays de la Loire</option>
                <option value="13">Provences-Alpes-Côte d'Azur</option>
            </select>
        </div>

        <button class="button_reg" type="button" onclick="lancer_recherche_reg()">Lancez la recherche</button>

        <div id="graph_reg">
            <h2> Graphe élections régionales</h1>
        </div>

        <h2 id="graph_reg_dev" style="margin-top : 15%;">en développement...</h1>

    </div>

    <div class="section_france" id="section_france">
        <div>
            <br><br><br><br><br><br><br><br><br><br>
            <h2 id="graph_fr">en développement...</h1>
        </div>
    </div>
    

    <div class='prediction_ia' style='display: none;'>
        <div id="graph_reg">
            <h2> Prédictions</h2>
        </div>

        <div class="details_ia">
            <label class="label_ia">Evolution de l'erreur et la précision du modèle au cours de l'entraînement</label>
            <img id="image_ia" src="" alt="Evolution de l'erreur et la précision du modèle au cours de l'entraînement">
        </div>

        <table>
            <tr>
                <td>
                    <div class="resultats_ia" style='display: none;'>
                        <label class="label_ia">Prédictions de nos modèles</label>
                    </div>                                        
                </td>
                <td style="border-left: 1px solid black;">
                    <label class="label_ia" for="deroulant_modele">Sélectionner un canton et le modèle d'IA à utiliser :</label>

                    <div class="form_ia_line">
                        <label id="label_dep">Département</label>
                        <select name="deroulant_canton" id="model_canton">
                            <option value="default">--- Canton ---</option>
                        </select>
                        <select name="deroulant_modele" id="model_name">
                            <option value="default">Modèle 2015 (automatique)</option>
                        </select>

                        <button class="button_dep" type="button" onclick="lancer_prediction()">Prédire</button>
                    </div>
                </td>
            </tr>
        </table>
    </div>



    
    <script src="script_accueil.js"></script>
    <script src='https://ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min.js'></script>
    <script src="boutonremonter.js"></script>
    <script src="ia.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@2.0.0/dist/tf.min.js"></script>
    <script src="script_predictions.js"></script>
    
    

</body>

</html>
