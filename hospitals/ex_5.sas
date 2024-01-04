%let route = /home/u63636519/;


%let route = /home/u63636519/hospi;

Libname hospi17 xlsx "&route./Hospi_2017.xlsx";
Libname hospi18 xlsx "&route./Hospi_2018.xlsx";
Libname hospi19 xlsx "&route./Hospi_2019.xlsx";


proc sort data=hospi17."lits et places"n;
	by finess;
run;
PROC TRANSPOSE DATA=hospi17."lits et places"n
	OUT=hospiLit;
	VAR Valeur;
	by finess;
	ID Indicateur;
RUN;

proc sql;
	create table exo5  as
	select lit.finess,
		sum(input(lit.CI_AC1, comma9.) ) as taillem,
		eta.taille_M,
		sum(input(lit.CI_AC6, comma9.) ) as taillec,
		eta.taille_C,
		sum(input(lit.CI_AC8, comma9.) ) as tailleo,
		eta.taille_O
	from hospiLit as lit  inner join hospi17.etablissement as eta on lit.finess=eta.finess
    group  by  lit.finess;
run;


/*  les seuils de taille_M  medecine*/

proc sql;
	create table exo5Medecine as
	select lit.finess,
		sum(input(lit.CI_AC1, comma9.)) as medecine,
		eta.taille_M
    from hospiLit as lit  inner join hospi17.etablissement as eta on lit.finess=eta.finess
    group  by  lit.finess;
run;

proc sql;
	select taille_M, min(medecine) as min, max(medecine) as max from exo5Medecine
	group by taille_M
	;
run;


/*  les seuils de taille_C chirurgie */
proc sql;
	create table exo5Chirurgie as
	select lit.finess,
		sum(input(lit.CI_AC6, comma9.) ) as  chirurgie,
		eta.taille_C
	from hospiLit as lit  inner join hospi17.etablissement as eta on lit.finess=eta.finess
    group  by  lit.finess;
run;

proc sql;
	select taille_C, min(chirurgie) as min, max(chirurgie) as max from  exo5Chirurgie
	group by taille_C
	;
run;

/*  les seuils de taille_O obstetrique */

proc sql;
	create table exo5Obstetrique as
	select lit.finess,
		sum(input(lit.CI_AC8, comma9.) ) as obstetrique,
		eta.taille_O
	from hospiLit as lit  inner join hospi17.etablissement as eta on lit.finess=eta.finess
    group  by  lit.finess;
run;

proc sql;
	select taille_O, min(obstetrique) as min, max(obstetrique) as max from exo5Obstetrique
	group by taille_O
	;
run;

