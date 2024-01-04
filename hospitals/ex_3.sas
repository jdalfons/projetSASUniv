%let route = /home/u63636519/;


PROC IMPORT OUT=work.hospi_all_etablissement
    DATAFILE="&route./full_datasets/hospi_all_etablissement.csv"
    DBMS=CSV REPLACE;
RUN;



/* Trier les données par 'finess' et 'year' */
PROC SORT DATA=work.hospi_all_etablissement;
    BY finess year;
RUN;

/* Créer une table avec les établissements présents en 2019 mais pas en 2018 ou 2017 */

PROC SQL;
CREATE TABLE new_in_2019 AS 
SELECT 
    t1.finess,
    t1.year
FROM 
    work.hospi_all_etablissement AS t1
WHERE 
    t1.year = 2019 AND
    t1.finess NOT IN (
        SELECT 
            t2.finess
        FROM 
            work.hospi_all_etablissement AS t2
        WHERE 
            t2.year = 2017  or t2.year = 2018;
    );
QUIT;
