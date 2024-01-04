%let route = /home/u63636519/hospi;

Libname hospi17 xlsx "&route./Hospi_2017.xlsx";
Libname hospi18 xlsx "&route./Hospi_2018.xlsx";
Libname hospi19 xlsx "&route./Hospi_2019.xlsx";


/*
8 Indiquez dans un tableau le nombre d’accouchement, le nombre de lit d’obstétrique par catégorie
d’établissement (cat) et par  niveau  de  maternité.  Quels  sont  les  5 établissements  avec  la  plus  forte
activité d’obstétrique ?
*/

/* Pour 2017 */
proc sql;
    create table exo8_2017 as
        select 
        	ag.finess as finess,
        	substr(ag.finess, 1, 2) as region,
        	2017 as year, 
        	eta.cat as cat, 
        	eta.rs as nom,
            input(ag.CI_A11, comma9.) as nb_accouchement,
            input(lit.valeur, comma9.) as nb_litObstetrique
        from hospi17."activité globale"n as ag
            inner join hospi17."lits et places"n as lit on ag.finess = lit.finess
            inner join hospi17.etablissement as eta on lit.finess = eta.finess
        where lit.indicateur = "CI_AC8"
        group by cat
        order by nb_litObstetrique DESC;
quit;


/* Pour 2018 */
proc sql;
    create table exo8_2018 as
        select 
        	ag.finess as finess,
        	substr(ag.finess, 1, 2) as region,
        	2018 as year, 
        	eta.cat as cat, 
        	eta.rs as nom,
            input(ag.CI_A11, comma9.) as nb_accouchement,
            input(lit.valeur, comma9.) as nb_litObstetrique
        from hospi18."activité globale"n as ag
            inner join hospi18."lits et places"n as lit on ag.finess = lit.finess
            inner join hospi18.etablissement as eta on lit.finess = eta.finess
        where lit.indicateur = "CI_AC8"
        group by cat
        order by nb_litObstetrique DESC;
quit;


/* Pour 2019 */
proc sql;
    create table exo8_2019 as
        select 
        	ag.finess as finess,
        	substr(ag.finess, 1, 2) as region,
        	2019 as year, 
        	eta.cat as cat, 
        	eta.rs as nom,
            input(ag.CI_A11, comma9.) as nb_accouchement,
            input(lit.valeur, comma9.) as nb_litObstetrique
        from hospi19."activité globale"n as ag
            inner join hospi19."lits et places"n as lit on ag.finess = lit.finess
            inner join hospi19.etablissement as eta on lit.finess = eta.finess
        where lit.indicateur = "CI_AC8"
        group by cat
        order by nb_litObstetrique DESC;
quit;


/*  2017 */

/* Trier les données par 'finess' et 'year' */
PROC SORT DATA=exo8_2017_5;
    BY nb_litObstetrique year;
RUN;

/*  5 établissements  avec  la  plus  forte  activité d’obstétrique ? */
data exo8_2017_5;
    set exo8_2017;
    if _N_ <= 5;
run;

/*  2018 */
/* Trier les données par 'finess' et 'year' */
PROC SORT DATA=exo8_2018_5;
    BY nb_litObstetrique year;
RUN;
/*  5 établissements  avec  la  plus  forte  activité d’obstétrique ? */
data exo8_2018_5;
    set exo8_2018;
    if _N_ <= 5;
run;


/*  2019 */
/* Trier les données par 'finess' et 'year' */
PROC SORT DATA=exo8_2019_5;
    BY nb_litObstetrique year;
RUN;
/*  5 établissements  avec  la  plus  forte  activité d’obstétrique ? */
data exo8_2019_5;
    set exo8_2019;
    if _N_ <= 5;
run;



/*
9 Résumez  les  indicateurs  de  la  question  8  par  région.  Indiquez  également  le  nombre  min  et  max
d’accouchement.

*/
/*2017*/
proc sql;
	create table exo9_2017 as
		select 
			region,
			min(nb_accouchement) as min_accouchement, 
			max(nb_accouchement) as max_accouchement
		from exo8_2017
        group by region;
 quit;
run;


/*2018*/
proc sql;
	create table exo9_2018 as
		select 
			region,
			min(nb_accouchement) as min_accouchement, 
			max(nb_accouchement) as max_accouchement
		from exo8_2018
        group by region;
 quit;
run;

/*2019*/
proc sql;
	create table exo9_2019 as
		select 
			region,
			min(nb_accouchement) as min_accouchement, 
			max(nb_accouchement) as max_accouchement
		from exo8_2019
        group by region;
 quit;
run;


/*
10 A l’aide de variables présentes dans le fichier essayez de calculer un score de « qualité » pour les
accouchements  (obstétrique)  afin  de  classer  les  établissements.  Justifiez  le  calcul  de  votre  score  et
proposez une interprétation de votre score.
*/
/* Calculer le score pour chaque établissement par chaque année */

/* 2017 */

/* Calculer la moyenne d'accouchements total et litObstetrique */
proc sql;
    select mean(nb_accouchement) into :mean_acc from exo8_2017;
quit;

proc sql;
	select mean(nb_litObstetrique) into :mean_Obs from exo8_2017;
quit;


/* Calculer le nombre d’accouchements divisé par la moyenne d’accouchements total pour chaque établissement */
proc sql;
    create table score_2017 as
    select 
    finess,
    nom, 
    avg(((nb_litObstetrique * 0.5/ &mean_Obs)+(nb_accouchement * 0.5 / &mean_acc))/2)  as score
    from exo8_2017
    group by finess, nom;
quit;


proc sql;
    create table scores_separed_2017 as
    select 
    finess,
    nom, 
    avg(nb_accouchement * 0.5 / &mean_acc)  as score_acc,
    avg(nb_litObstetrique * 0.5/ &mean_Obs) as score_obs
    from exo8_2017
    group by finess, nom;
quit;

proc sgplot data=scores_separed_2017;
    scatter x=score_acc y=score_obs / markerattrs=(symbol=circlefilled);
    xaxis label='score_acc';
    yaxis label='score_obs';
    title 'Nuage de points : Score par établissement 2017';
run;


/* 2018 */

proc sql;
    select mean(nb_accouchement) into :mean_acc from exo8_2018;
quit;

proc sql;
	select mean(nb_litObstetrique) into :mean_Obs from exo8_2018;
quit;


/* Calculer le nombre d’accouchements divisé par la moyenne d’accouchements total pour chaque établissement */
proc sql;
    create table score_2019 as
    select 
    finess,
    nom, 
    avg(((nb_litObstetrique * 0.5/ &mean_Obs)+(nb_accouchement * 0.5 / &mean_acc))/2)  as score
    from exo8_2019
    group by finess, nom;
quit;

proc sql;
    create table scores_separed_2018 as
    select 
    finess,
    nom, 
    avg(nb_accouchement * 0.5 / &mean_acc)  as score_acc,
    avg(nb_litObstetrique * 0.5/ &mean_Obs) as score_obs
    from exo8_2018
    group by finess, nom;
quit;

proc sgplot data=scores_separed_2018;
    scatter x=score_acc y=score_obs / markerattrs=(symbol=circlefilled);
    xaxis label='score_acc';
    yaxis label='score_obs';
    title 'Nuage de points : Score par établissement 2018';
run;

/* 2019 */

proc sql;
    select mean(nb_accouchement) into :mean_acc from exo8_2019;
quit;

proc sql;
	select mean(nb_litObstetrique) into :mean_Obs from exo8_2019;
quit;


/* Calculer le nombre d’accouchements divisé par la moyenne d’accouchements total pour chaque établissement */
proc sql;
    create table score_2019 as
    select 
    finess,
    nom, 
    avg(((nb_litObstetrique * 0.5/ &mean_Obs)+(nb_accouchement * 0.5 / &mean_acc))/2)  as score
    from exo8_2019
    group by finess, nom;
quit;

proc sql;
    create table scores_separed_2019 as
    select 
    finess,
    nom, 
    avg(nb_accouchement * 0.5 / &mean_acc)  as score_acc,
    avg(nb_litObstetrique * 0.5/ &mean_Obs) as score_obs
    from exo8_2019
    group by finess, nom;
quit;

proc sgplot data=scores_separed_2019;
    scatter x=score_acc y=score_obs / markerattrs=(symbol=circlefilled);
    xaxis label='score_acc';
    yaxis label='score_obs';
    title 'Nuage de points : Score par établissement 2019';
run;


/* 11 */

/* Calculer le nombre d’accouchements divisé par la moyenne d’accouchements total pour chaque établissement */
proc sql;

	create table scores_differences as
		SELECT
		  t1.finess,
		  t1.score AS valor_ano1,
		  t2.score AS valor_ano2,
		  t3.score AS valor_ano3,
		  t2.score - t1.score AS diferencia_ano2018_ano2017,
		  t3.score - t2.score AS diferencia_ano2019_ano2018
	    FROM
		  score_2017 t1
		JOIN
		  score_2018 t2 ON t1.finess = t2.finess
		JOIN
		  score_2019 t3 ON t1.finess = t3.finess;
quit;
