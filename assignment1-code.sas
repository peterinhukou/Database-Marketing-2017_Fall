/* The Proc Import statement that follows
reads an excel file from the location that you specify
so that YOU DON'T HAVE TO IMPORT THE DATA FILE!
*/

PROC IMPORT OUT= WORK.real
DATAFILE= "H:\path-name\realestate"
DBMS=EXCEL2000 REPLACE;
GETNAMES=YES;
RUN;

/* Q1: Regression of price on all attributes of the house */

proc reg data=work.real;
model price = section Lotsize Bed Bath Other Stories Fireplaces Cars Pool Fence Age;
run;


/* Q2: Data Reduction with Factor analysis */
proc factor data=work.real method = prinit rotate=v corr msa scree residuals preplot plot;
var section Lotsize Bed Bath Other Stories Fireplaces Pool Cars Fence Age;
run;

/* Q3: Regression of price on factors */

proc factor data=work.real method = prinit nfactors = 4 out=facout rotate=v corr msa scree residuals preplot plot;
var section Lotsize Bed Bath Other Stories Fireplaces Cars Pool Fence Age;
run;

proc reg data=facout;
model price = factor1-factor4;
run;
