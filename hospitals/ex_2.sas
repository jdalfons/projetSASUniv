%let route = /home/u63636519/;


PROC IMPORT OUT=work.hospi_all_list_et_places
    DATAFILE="&route./full_datasets/hospi_all_list_et_places.csv"
    DBMS=CSV REPLACE;
RUN;


PROC IMPORT OUT=work.hospi_all_etablissement
    DATAFILE="&route./full_datasets/hospi_all_etablissement.csv"
    DBMS=CSV REPLACE;
RUN;


PROC IMPORT OUT=work.hospi_all_activite_globale
    DATAFILE="&route./full_datasets/hospi_all_activite_globale.csv"
    DBMS=CSV REPLACE;
RUN;


/* Stats list et places */

DATA work.hospi_all_list_et_places;
    SET work.hospi_all_list_et_places;
    valeur_int = FLOOR(valeur); /* ou ROUND(valeur) */
RUN;


PROC SORT DATA=work.hospi_all_list_et_places;
    BY year;
RUN;


PROC UNIVARIATE DATA=work.hospi_all_list_et_places PLOT;
    VAR valeur_int;
RUN;



PROC MEANS DATA=work.hospi_all_list_et_places;
    VAR valeur_int;
RUN;

PROC FREQ DATA=work.hospi_all_list_et_places;
    TABLES valeur_int;
RUN;


PROC BOXPLOT DATA=work.hospi_all_list_et_places;
    PLOT valeur_int*year;
RUN;

/* Stats list et places */

DATA work.hospi_all_activite_globale;
    SET work.hospi_all_list_et_places;
		A7=INPUT(A7, BEST32.);
		A8=INPUT(A8, BEST32.);
		A9=INPUT(A9, BEST32.);
		A10=INPUT(A10, BEST32.);
		A11=INPUT(A11, BEST32.);
		A12=INPUT(A12, BEST32.);
		A13=INPUT(A13, BEST32.);
		A14=INPUT(A14, BEST32.);
		A15=INPUT(A15, BEST32.);
		CI_A1=INPUT(CI_A1, BEST32.);
		CI_A2=INPUT(CI_A2, BEST32.);
		CI_A3=INPUT(CI_A3, BEST32.);
		CI_A4=INPUT(CI_A4, BEST32.);
		CI_A5=INPUT(CI_A5, BEST32.);
		CI_A6=INPUT(CI_A6, BEST32.);
		CI_A7=INPUT(CI_A7, BEST32.);
		CI_A8=INPUT(CI_A8, BEST32.);
		CI_A9=INPUT(CI_A9, BEST32.);
		CI_A10=INPUT(CI_A10, BEST32.);
		CI_A11=INPUT(CI_A11, BEST32.);
		CI_A12=INPUT(CI_A12, BEST32.);
		CI_A13=INPUT(CI_A13, BEST32.);
		CI_A14=INPUT(CI_A14, BEST32.);
		CI_A15=INPUT(CI_A15, BEST32.);
		CI_E1=INPUT(CI_E1, BEST32.);
		CI_E2=INPUT(CI_E2, BEST32.);
		CI_E3=INPUT(CI_E3, BEST32.);
		CI_E4_v2=INPUT(CI_E4_v2, BEST32.);
		CI_E5=INPUT(CI_E5, BEST32.);
		CI_E6=INPUT(CI_E6, BEST32.);
		CI_E7_v2=INPUT(CI_E7_v2, BEST32.);
		CI_A16_1=INPUT(CI_A16_1, BEST32.);
		CI_A16_2=INPUT(CI_A16_2, BEST32.);
		CI_A16_3=INPUT(CI_A16_3, BEST32.);
		CI_A16_4=INPUT(CI_A16_4, BEST32.);
		CI_RH1=INPUT(CI_RH1, BEST32.);
		CI_RH2=INPUT(CI_RH2, BEST32.);
		CI_RH3=INPUT(CI_RH3, BEST32.);
		CI_RH4=INPUT(CI_RH4, BEST32.);
		CI_RH5=INPUT(CI_RH5, BEST32.);
		CI_RH6=INPUT(CI_RH6, BEST32.);
		CI_RH7=INPUT(CI_RH7, BEST32.);
		CI_RH8=INPUT(CI_RH8, BEST32.);
		CI_RH9=INPUT(CI_RH9, BEST32.);
		CI_RH10=INPUT(CI_RH10, BEST32.);
		CI_RH11=INPUT(CI_RH11, BEST32.);
		P1=INPUT(P1, BEST32.);
		P2=INPUT(P2, BEST32.);
		P3=INPUT(P3, BEST32.);
		P4=INPUT(P4, BEST32.);
		P5=INPUT(P5, BEST32.);
		P6=INPUT(P6, BEST32.);
		P7=INPUT(P7, BEST32.);
		P8=INPUT(P8, BEST32.);
		P9=INPUT(P9, BEST32.);
		P10=INPUT(P10, BEST32.);
		P11=INPUT(P11, BEST32.);
		P12=INPUT(P12, BEST32.);
		P12_bis=INPUT(P12_bis, BEST32.);
		P13=INPUT(P13, BEST32.);
		P14=INPUT(P14, BEST32.);
		P15=INPUT(P15, BEST32.);
		P16=INPUT(P16, BEST32.);
		RH1=INPUT(RH1, BEST32.);
		RH2=INPUT(RH2, BEST32.);
		RH3=INPUT(RH3, BEST32.);
		RH4=INPUT(RH4, BEST32.);
		RH5=INPUT(RH5, BEST32.);
		RH6=INPUT(RH6, BEST32.);
		RH7=INPUT(RH7, BEST32.);
		RH8=INPUT(RH8, BEST32.);
		RH9=INPUT(RH9, BEST32.);
		RH10=INPUT(RH10, BEST32.);	
RUN;


PROC SORT DATA=work.hospi_all_activite_globale;
    BY year;
RUN;

PROC UNIVARIATE DATA=work.hospi_all_list_et_places PLOT;
    VAR _NUMERIC_;
RUN;