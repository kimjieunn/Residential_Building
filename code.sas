/*데이터 불러오기*/
proc import datafile="C:\Users\stat_21\Desktop\Residential Building.csv"
dbms=csv
out=Residential
replace;
getnames=yes;
run;

/*변수명 확인*/
proc contents data=Residential;
run;

/*기술통계량*/
proc means data=Residential;
run;

/*산점도*/
proc sgscatter data=Residential;
	matrix V_1 V_2 V_3 V_4 V_5 V_6 V_7 V_8 V_10;
run;

/*상관계수*/
proc corr data=Residential
	nosimple;
	var V_1 V_2 V_3 V_4 V_5 V_6 V_7 V_8 V_10 ;
run;

/*회귀분석 */
proc reg data=Residential outest=est ;
	model V_10 = V_3 V_8  / vif collin dw;
		output out=result
		cookd = cookd_reg
		dffits = dffits_reg
		covratio = covratio_reg;
	plot rstudent.* pred. / vaxis = -2.5 to 2.5 by 0.5; /*선형성*/
	plot rstudent.*nqq. / noline; /*정규확률그림*/
run;
quit;

proc reg data=Residential outest=est ;
	model V_10 = V_3 V_5 V_8  / vif collin dw;
		output out=result
		cookd = cookd_reg
		dffits = dffits_reg
		covratio = covratio_reg;
	plot rstudent.* pred. / vaxis = -2.5 to 2.5 by 0.5; /*선형성*/
	plot rstudent.*nqq. / noline; /*정규확률그림*/
run;
quit;

proc reg data=Residential outest=est ;
	model V_10 = V_1 V_3 V_5 V_8  / vif collin dw
		output out=result
		cookd = cookd_reg
		dffits = dffits_reg
		covratio = covratio_reg;
	plot rstudent.* pred. / vaxis = -2.5 to 2.5 by 0.5; /*선형성*/
	plot rstudent.*nqq. / noline; /*정규확률그림*/
run;
quit;
