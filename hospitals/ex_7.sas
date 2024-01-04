%let route = /home/u63636519/;




Libname hospi17 xlsx "&route./hospi/Hospi_2017.xlsx";
Libname hospi18 xlsx "&route./hospi/Hospi_2018.xlsx";
Libname hospi19 xlsx "&route./hospi/Hospi_2019.xlsx";


/*
7   Les  deux  premiers  caractères  du  N°  finess  correspondent  au  département.  Indiquez  le  nombre
d’établissement par catégorie (cat) par région.
*/

proc sql;
	create table exo7_2017 as
		select 
			distinct cat as cat,
			substr(finess, 1, 2) as region,  
			count(finess) as  nombre
		from hospi17.etablissement
		
		group by 
			cat,
			region
         ;
run;

proc sql;
	create table exo7_2018 as
		select 
			distinct cat as cat,
			substr(finess, 1, 2) as region,  
			count(finess) as  nombre
		from hospi18.etablissement
		
		group by 
			cat,
			region
         ;
run;

proc sql;
	create table exo7_2019 as
		select 
			distinct cat as cat,
			substr(finess, 1, 2) as region,  
			count(finess) as  nombre
		from hospi19.etablissement
		
		group by 
			cat,
			region
         ;
run;