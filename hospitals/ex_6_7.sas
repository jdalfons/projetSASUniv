%let route = /home/u63636519/;

Libname hospi17 xlsx "&route./hospi/Hospi_2017.xlsx";
Libname hospi18 xlsx "&route./hospi/Hospi_2018.xlsx";
Libname hospi19 xlsx "&route./hospi/Hospi_2019.xlsx";



PROC TRANSPOSE DATA=exo6
	OUT=exo6T;
	VAR valeur17 valeur18 valeur19;
	by finess cat;
	ID Indicateur;
RUN;
/* on groupe par medecine obstretique et chirurgie*/
proc sql;
	create table exo6Final as
		select ex.finess,/* t._NAME_,*/
			sum(input(ex.CI_AC1, comma9.), input(ex.CI_AC5, comma9.)) as medecine,
			sum(input(ex.CI_AC6, comma9.), input(ex.CI_AC7, comma9.)) as chirurgie,
			sum(input(ex.CI_AC8, comma9.), input(ex.CI_AC9, comma9.)) as obstétrique
		from exo6T as ex group by ex.cat;
run;

