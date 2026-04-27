#set page(columns: 2)
#set heading(numbering: "I.1.a")
#show raw: block.with(
  // fill: yellow,
  inset: 5pt,
  stroke: 0.5pt
)

#text(size: 30pt, [Data Warehouse])

= chapitre 1: Intro
== les systemes d'informations classics
- *ont des donnes:*
  - distribuees et heterogenes.
  - detaillees donc sont peu adaptees a l'analyse.
  - volatile donc mal/non historisees.

== systeme d'information decisionnel
=== definition

- *une collection de donnees:*
  - orientees sujet
  - Intergrees
  - Non volatile
  - Historisees

- *mieux organisees pour le/la:*
  - prise de decision
  - collecte
  - stockage
  - analyse
  - presentation
  - transformation de la donnees en information utile

== architechture d'un entrepot de donnees
=== zone de preparation
stockage temporaire
- processsus ETL (Extraction, Transformation, Chargement)

=== zone de stockage
stockage permanent
- data mart
- metadonnes

=== zone de presentation
Outils d’analyse programmés

= chapitre 2: Modelisation Multidimensionnelle
Le modèle entité/association (MCD) est trop complet et inadapté à l’analyse décisionnelle.

== principes de modelisation dimensionnelle
deux types de tables:
- tables de faits (ce qu'on mesure)
- tables de dimensions (axes d'analyse)

== Tables de Faits
table principale du modele
- *fait* = sujet d'analyse
- *contient*:
  - des mesures
  - des clefs etrangeres vers les tables de dimensions

== Aditives des mesures
- Mesures additives
- Mesures semi additives
- Mesures non additives

== Tables de Dimensions
- dimension = axe d'analyse
- peut contenir des hierarchies

== Granularite
niveau de detail de la dimension,
granularite fine = grand niveau de detail

== Evolution des dimesions
=== Dimensions à évolution lente
solutions:
- Écrasement de l'ancienne valeur
- Versionnement
- Valeur d'origine / valeur courante

=== Dimensions à évolution rapide
Solution: isoler les attributs qui changent rapidement

== modeles conceptuels
=== En etoile
#image("./etoile.png")
- *Aventages:* simple, rapide et peu de jointures
- *Inconvenients:* redondance dans les dimensions

=== En flocon de neige
#image("./flocon.png")
- *Avantages:* économie d’espace, suppression des redondances.
- *Inconvénients:* plus complexe, plus de jointures, performances moindres.

=== En constelation
#image("./constelation.png")
plusieurs tables de faits partages des tables de dimensions

== Golfarelli
#image("./golfarelli.png")

= Chapiter 3: Méthode de Conception des entrepôts de données

== Etapes de modelisation
1. *Choisir le processsus metier a modeliser*
+ *Definir la granularite de chaque processsus*
+ *choisir les dimensions*
+ *Identifier les faits numeriques*

== Approche de realisation
=== Approche Descendante (top-down / inmon)
Concevoir tous les faits et toutes les dimensions avant implémentation.

- *Etapes:*
  1. Collecte des données
    - requetes types:
      - Analyser ...
      - En fonction ...
      - Pour ...
    - questionaires
    - regle de gestion

  + Spécification des besoins
    - Construire la matrice des besoins
  #image("./tableau.png")
    - Simplifier la matrice
  #image("tableau_simplifie.png")

  + Formalisation des besoins
    - Définition des faits
    - Définition des dimensions
    - Définition des hiérarchies
- *Avantages:*
  - Architecture intégrée, vision claire.
  - éutilisation des données, pas de redondance.

- * Inconvénients:*
  - Méthode lourde et rigide.
  - Longue et coûteuse.

=== Approche Ascendante (bottom-up / kimball)
Créer des datamarts indépendants, puis les intégrer progressivement en un entrepôt.
- *Sources possibles:*
  - Diagramme E/R, base de données objet.
  - Diagramme UML, documents XML.

- *Etapes (à partir d’un diagramme E/R):*
1. *Définition des faits*
  - Analyse du schéma de la source globale.
  - Détection des classes représentatives.
    -`Une classe représentative decrit un evenement qui se produit a un instant donne, et contient les mesures d'analyse `
  - Choix des mesures d'activités à analyser

+ *Définition des dimensions*
  - Détection des classes déterminantes des classes représentatives
   `Une classe Ci est déterminante d'une classe CR si :
> CR est relié à Ci par un lien de dépendance fonctionnelle directement ou indirectement.
> Cela signifie que Ci fournit un contexte ou une perspective pour analyser CR. `
  - *Choix des paramètres d'analyse*
    - Les attributs des classes déterminantes qui seront utilisés comme dimensions
  - *Définition de la dimension temporelle*

+ *Définition de la granularité*

+ *Hiérarchisation des dimensions*

- *Avantages:* Simple, résultats rapides, efficace à court terme.

- *Inconvénients:*
  - Risque de redondances.
  - Intégration difficile à long terme.

=== Approche Hybride (Middle-out)
Combiner les deux approches – conception intégrale suivie d’un affinage par les besoins utilisateurs.
- *Etapes*:
1. Obtenir un ensemble de modèles multidimensionnels à partir d'un diagramme de classes UML

  1. Identification des faits
    `Une classe H est classée comme une classe de fait si :
> Elle a au moins un attribut numérique non clé
> Elle est liée à au moins à une classe E1 avec une cardinalité (un à plusieurs)`
    - Effectuer des interviews avec un nombre d'utilisateurs pour établir une liste de processus
  + Definition des dimensions et des hiérarchies
      `Un processus contient un ensemble des besoins (exigences) des utilisateurs`
    - Analyser les processus pour choisir et affiner les modèles multidimensionnels en flocon établit.
      `Évaluer le modèle multidimensionnel obtenu avec les exigences des utilisateurs.`
+ Affiner le modèle multidimensionnel par les besoins des utilisateurs
- *Avantages:*
  - Prendre le meilleur des 2 approches
  - Développement d'un modèle de données d'entreprise de manière itérative
  - Développement d'une infrastructure lourde qu'en cas de nécessité

- *Inconvénients:*
  - Implique, parfois, des compromis de découpage (dupliquer des dimensions identiques pour des besoins pratiques).
