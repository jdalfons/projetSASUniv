/* 1-
Importez les données et familiarisez-vous avec les données.
 */

%let route = /home/u63636519/;


/* Procesus d'importation des données pour etablissement */
/* Importer les données de chaque fichier Excel dans des tables SAS */
PROC IMPORT OUT=work.hospi17_etablissement
            DATAFILE="&route./hospi/Hospi_2017.xlsx" 
            DBMS=xlsx REPLACE;
            SHEET = Etablissement; 
RUN;

PROC IMPORT OUT=work.hospi18_etablissement
            DATAFILE="&route./hospi/Hospi_2018.xlsx" 
            DBMS=xlsx REPLACE; 
            SHEET = Etablissement; 
RUN;

PROC IMPORT OUT=work.hospi19_etablissement
            DATAFILE="&route./hospi/Hospi_2019.xlsx" 
            DBMS=xlsx REPLACE; 
            SHEET = Etablissement; 
RUN;

/* Joindre les tables */
/* Ajouter une colonne 'year' à chaque table */
DATA hospi17_etablissement; SET hospi17_etablissement; year = 2017; RUN;
DATA hospi18_etablissement; SET hospi18_etablissement; year = 2018; RUN;
DATA hospi19_etablissement; SET hospi19_etablissement; year = 2019; RUN;

/* Joindre les tables */
PROC SQL;
    CREATE TABLE hospi_all_etablissement AS 
    SELECT 
        COALESCE(t1.finess, t2.finess, t3.finess) as finess,
        COALESCE(t1.year, t2.year, t3.year) as year,
        t1.*,
        t2.*,
        t3.*
    FROM 
        hospi17_etablissement AS t1
    FULL JOIN
        hospi18_etablissement AS t2
    ON 
        t1.finess = t2.finess AND t1.year = t2.year
    FULL JOIN
        hospi19_etablissement AS t3
    ON 
        t1.finess = t3.finess AND t1.year = t3.year;
QUIT;

/* Enregistrer les données dans un fichier */
PROC EXPORT DATA=hospi_all_etablissement
    OUTFILE="&route./full_datasets/hospi_all_etablissement.csv"
    DBMS=CSV REPLACE;
RUN;

/* Charger les données à partir du fichier */
PROC IMPORT OUT=work.hospi_all_etablissement_imported
    DATAFILE="&route./full_datasets/hospi_all_etablissement.csv"
    DBMS=CSV REPLACE;
RUN;



/* Procesus d'importation des données pour list et places */

/* Importer les données de chaque fichier Excel dans des tables SAS */
PROC IMPORT OUT=work.hospi17_list_et_places
            DATAFILE="&route./hospi/Hospi_2017.xlsx" 
            DBMS=xlsx REPLACE;
            SHEET = "Lits et Places"; 
RUN;

PROC IMPORT OUT=work.hospi18_list_et_places
            DATAFILE="&route./hospi/Hospi_2018.xlsx" 
            DBMS=xlsx REPLACE; 
            SHEET = "Lits et Places"; 
RUN;

PROC IMPORT OUT=work.hospi19_list_et_places
            DATAFILE="&route./hospi/Hospi_2019.xlsx" 
            DBMS=xlsx REPLACE; 
            SHEET = "Lits et Places"; 
RUN;

/* Ajouter une colonne 'year' à chaque table */
DATA hospi17_list_et_places; SET hospi17_list_et_places; year = 2017; RUN;
DATA hospi18_list_et_places; SET hospi18_list_et_places; year = 2018; RUN;
DATA hospi19_list_et_places; SET hospi19_list_et_places; year = 2019; RUN;



/* Joindre les tables */
PROC SQL;
    CREATE TABLE hospi_all_list_et_places AS 
    SELECT 
        COALESCE(t1.finess, t2.finess, t3.finess) as finess,
        COALESCE(t1.year, t2.year, t3.year) as year,
        t1.*,
        t2.*,
        t3.*
    FROM 
        hospi17_list_et_places AS t1
    FULL JOIN
        hospi18_list_et_places AS t2
    ON 
        t1.finess = t2.finess AND t1.year = t2.year
    FULL JOIN
        hospi19_list_et_places AS t3
    ON 
        t1.finess = t3.finess AND t1.year = t3.year;
QUIT;

/* Enregistrer les données dans un fichier */
PROC EXPORT DATA=hospi_all_list_et_places
    OUTFILE="&route./full_datasets/hospi_all_list_et_places.csv"
    DBMS=CSV REPLACE;
RUN;

/* Charger les données à partir du fichier */

PROC IMPORT OUT=work.hospi_all_list_et_places_imported
    DATAFILE="&route./full_datasets/hospi_all_list_et_places.csv"
    DBMS=CSV REPLACE;
RUN;


/* Procesus d'importation des données pour activité gobale */

PROC IMPORT OUT=work.hospi17_activite_globale
            DATAFILE="&route./hospi/Hospi_2017.xlsx" 
            DBMS=xlsx REPLACE;
            SHEET = "Activité Globale"; 
RUN;

PROC IMPORT OUT=work.hospi18_activite_globale
            DATAFILE="&route./hospi/Hospi_2018.xlsx" 
            DBMS=xlsx REPLACE; 
            SHEET = "Activité Globale"; 
RUN;

PROC IMPORT OUT=work.hospi19_activite_globale
            DATAFILE="&route./hospi/Hospi_2019.xlsx" 
            DBMS=xlsx REPLACE; 
            SHEET = "Activité Globale"; 
RUN;

/* Ajouter une colonne 'year' à chaque table */
DATA hospi17_activite_globale; SET hospi17_activite_globale; year = 2017; RUN;
DATA hospi18_activite_globale; SET hospi18_activite_globale; year = 2018; RUN;
DATA hospi19_activite_globale; SET hospi19_activite_globale; year = 2019; RUN;


/* Joindre les tables */
PROC SQL;
    CREATE TABLE hospi_all_activite_globale AS 
    SELECT 
        COALESCE(t1.finess, t2.finess, t3.finess) as finess,
        COALESCE(t1.year, t2.year, t3.year) as year,
        t1.*,
        t2.*,
        t3.*
    FROM 
        hospi17_activite_globale AS t1
    FULL JOIN
        hospi18_activite_globale AS t2
    ON 
        t1.finess = t2.finess AND t1.year = t2.year
    FULL JOIN
        hospi19_activite_globale AS t3
    ON 
        t1.finess = t3.finess AND t1.year = t3.year;
QUIT;


PROC EXPORT DATA=hospi_all_activite_globale
    OUTFILE="&route./full_datasets/hospi_all_activite_globale.csv"
    DBMS=CSV REPLACE;
RUN;

/* Charger les données à partir du fichier */

PROC IMPORT OUT=work.hospi_all_activite_globale_imported
    DATAFILE="&route./full_datasets/hospi_all_activite_globale.csv"
    DBMS=CSV REPLACE;
RUN;
