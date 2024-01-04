%let route = /home/u63636519/;


%let route = /home/u63636519/hospi;

Libname hospi17 xlsx "&route./Hospi_2017.xlsx";
Libname hospi18 xlsx "&route./Hospi_2018.xlsx";
Libname hospi19 xlsx "&route./Hospi_2019.xlsx";



proc sql;
    create table ChangementsTaille17_18_19 as
    select
        eta19.finess,
        eta19.taille_MCO as taille_MCO_2019,
        eta18.taille_MCO as taille_MCO_2018,
        eta17.taille_MCO as taille_MCO_2017,
        eta19.taille_M as taille_M_2019,
        eta18.taille_M as taille_M_2018,
        eta17.taille_M as taille_M_2017,
        eta19.taille_C as taille_C_2019,
        eta18.taille_C as taille_C_2018,
        eta17.taille_C as taille_C_2017,
        eta19.taille_O as taille_O_2019,
        eta18.taille_O as taille_O_2018,
        eta17.taille_O as taille_O_2017
    from
        hospi19.etablissement as eta19
    left join
        hospi18.etablissement as eta18
    on
        eta19.finess = eta18.finess
    left join
        hospi17.etablissement as eta17
    on
        eta19.finess = eta17.finess
    where
        not (
            (eta19.taille_MCO = eta18.taille_MCO and eta18.taille_MCO = eta17.taille_MCO) and
            (eta19.taille_M = eta18.taille_M and eta18.taille_M = eta17.taille_M) and
            (eta19.taille_C = eta18.taille_C and eta18.taille_C = eta17.taille_C) and
            (eta19.taille_O = eta18.taille_O and eta18.taille_O = eta17.taille_O)
        );
quit;

proc print data=ChangementsTaille17_18_19;
run;




proc sql;
    create table ChangementsActivite17_18_19 as
    select
        eta19.finess,
        eta19.cat as categorie_2019,
        eta18.cat as categorie_2018,
        eta17.cat as categorie_2017
    from
        hospi19.etablissement as eta19
    left join
        hospi18.etablissement as eta18
    on
        eta19.finess = eta18.finess
    left join
        hospi17.etablissement as eta17
    on
        eta19.finess = eta17.finess
    where
        not (
            (eta19.cat = eta18.cat) or (eta18.cat = eta17.cat)
        );
quit;

proc print data=ChangementsActivite17_18_19;
run;