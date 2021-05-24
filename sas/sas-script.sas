
libname project '/home/u58199936/sas_project';
DATA project.festivals_entries;
 INFILE '/home/u58199936/sas_project/festivals.txt' dsd;
 INPUT FEST_ID FEST_NAME $ FEST_LOC $ TICKET_PRICE;
RUN;

proc print data=project.festivals_entries;
title 'Festivals';
run;

libname project '/home/u58199936/sas_project';
DATA project.changed_festivals;
 SET project.festivals_entries;
 IF TICKET_PRICE<=100 THEN TICKET_PRICE_CATEGORY='NORMAL';
 ELSE IF TICKET_PRICE>100 AND TICKET_PRICE<250 THEN TICKET_PRICE_CATEGORY='EXPENSIVE';
 ELSE IF TICKET_PRICE>250 THEN TICKET_PRICE_CATEGORY='HIGH-END';
RUN;


proc print data=project.changed_festivals;
title 'Changed';
run;


proc format;
value $FEST_LOC 'EU'='Europe'
'US'='United States'
'OTH'='Other Location';
run;

proc print data=project.changed_festivals;
title 'User_Defined';
var FEST_ID FEST_NAME FEST_LOC TICKET_PRICE;
format FEST_LOC $FEST_LOC.;
run;


ods graphics / reset width=20cm height=15cm imagemap;

proc sgplot data=PROJECT.CHANGED_FESTIVALS;
	title height=14pt "Ticket Prices";
	vbar FEST_NAME / response=TICKET_PRICE fillattrs=(color=CXfd003a) datalabel;
	yaxis grid;
run;

ods graphics / reset;
title;

ods noproctitle;
ods graphics / imagemap=on;

proc means data=PROJECT.CHANGED_FESTIVALS chartype mean std min max n vardef=df;
	var TICKET_PRICE;
run;ods noproctitle;
ods graphics / imagemap=on;

proc SQL;
CREATE TABLE query as
SELECT FEST_NAME,TICKET_PRICE from PROJECT.festivals_entries where FEST_LOC='EU';
QUIT;


PROC PRINT data=query;
run;




 

