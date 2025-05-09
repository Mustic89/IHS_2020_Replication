* * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* ####################################################### *
* #                                                     # *
* #       GAMBIA IHS 2020 CONSUMPTION AGGREGATION       # *
* #                                                     # *
* ####################################################### *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
*++++++++++++++++++++++++++++++++++++
*************************************
**       COVERTIONS FACTORS        **       
*************************************
*++++++++++++++++++++++++++++++++++++
                               
*************************************
** INITIALIZATION OF THE WORKSPACE **
*************************************
version 16.1

clear
set more off
cap log close

****************************
** DEFINE THE DIRECTORIES **
****************************
// change the specific file path to your IHS2020 folder here to run the dofile

*++++++++++++++++ CHANGE THIS PATH TO YOUR IHS 2020 FOLDER TO RUN ++++++++*
global path  "C:\Users\Rostand Tchouakam\Desktop\World Bank Group\Welfare Aggregate\GMB\IHS2020"
***************************************************************************

global findata     ${path}\01.Data\Stata
global othdata     ${path}\01.Data\Other
global fintab      ${path}\04.Results\output
global logs        ${path}\04.Results\logfiles
global temp        ${path}\04.Results\temp

log using "$logs\GMB 2020 Coversion Factors.log" , replace
***************************************************************************



****************************
** GENERAL PRICE FIXING   **
****************************

/* GENERATE THE RAW PRICE DATA FROM THE EXCEL FILE
use "$othdata\Just for labels.dta",clear

drop _all // I drop all the observations and variables but I keep the values labels

import excel "C:\Users\Rostand Tchouakam\Desktop\World Bank Group\Welfare Aggregate\GMB\IHS2020\01.Data\Original\Raw Part 3\Price data 2020.xlsx", sheet("stata 1") firstrow 

replace district1 = 10 if inlist(district,10,11,12)
replace district1 = 20 if inlist(district,20,21,22,23,24)

lab val lga LGA
lab val district district
lab val district1 district1 
lab val area  AREA
lab val item_code S1AQ1
lab val a2_non_standard_unit S1AQ3B
lab val a4_standard_unitt S1AQ3B
lab val b2_non_standard_unit S1AQ3B
lab val b4_standard_unit S1AQ3B
lab val c2_non_standard_unit S1AQ3B
lab val c4_standard_unit S1AQ3B

compress
save "$findata\PART C Market Questionnaire 2020.dta",replace
	
*/	
	
use "$findata\PART C Market Questionnaire 2020.dta",clear


replace  a1_non_standard_quantity =1
replace  b1_non_standard_quantity =1
replace  c1_non_standard_quantity =1

sort lga district mkt_month mkt_year item_code

numlabel, add

** Fix prices of items in food basket

*** rice
sum *price if inrange(item_code,1, 5)

gen flag = .

replace flag = 1 if item_code == 4 & b5_price == 12250

replace flag = 1 if item_code == 1 & c5_price == 15000


*** fix
replace b5_price = 1225 if item_code == 4 & b5_price == 12250

replace c5_price = 1500 if item_code == 1 & c5_price == 15000

//gen a2_non_standard_other_unit = 

br if inrange(item_code, 1, 5) & a2_non_standard_unit == 1 & a5_price> 50 & a5_price!=.



bysort item_code: sum *price if item_code < 100

***********************************************
********** Basmatic rice
sum *price if item_code == 5

tab a5_price a2_non_standard_unit if item_code ==5
tab b5_price b2_non_standard_unit if item_code ==5
tab c5_price c2_non_standard_unit if item_code ==5

** > D725, likely to be a bag (10 or 20 kg) and not kilo
replace a2_non_standard_unit = 99 if a2_non_standard_unit == 1 & a5_price == 725 & item_code == 5

replace b2_non_standard_unit = 99 if b2_non_standard_unit == 1 & inrange(b5_price, 600, 750) & item_code == 5

//change grams to kilos
replace b2_non_standard_unit = 1 if b2_non_standard_unit == 2 & item_code == 5

***********************************************
********** Medium grained rice (imported)
sum *price if item_code == 3

tab a5_price a2_non_standard_unit if item_code ==3
tab b5_price b2_non_standard_unit if item_code ==3
tab c5_price c2_non_standard_unit if item_code ==3

** grams should be kg and 1 entry for cup (p = 26) should be kg
replace b2_non_standard_unit = 1 if b2_non_standard_unit == 2 & item_code == 3

replace b2_non_standard_unit = 1 if b2_non_standard_unit == 10 & item_code == 3 & b5_price == 26

***********************************************
********** Small grained rice (imported)
sum *price if item_code == 4

tab a5_price a2_non_standard_unit if item_code ==4
tab b5_price b2_non_standard_unit if item_code ==4
tab c5_price c2_non_standard_unit if item_code ==4

** 50kg in a2 should be cup
replace a2_non_standard_unit = 10 if a2_non_standard_unit == 14 & item_code == 4 & a5_price == 5

** grams should be kg 
replace b2_non_standard_unit = 1 if b2_non_standard_unit == 2 & item_code == 4

********************************
************ bread
sum *price if item_code == 16 | item_code == 17 | item_code == 18 | item_code == 19

br if inrange(item_code, 16, 19) 

*** replace a dozen of bread to piece
replace b5_price = 12 if b5_price == 120 & item_code == 17 & district == 50 & mkt_month == 3 & mkt_year == 2020

replace b2_non_standard_unit = 6 if b5_price == 120 & item_code == 17 & district == 50 & mkt_month == 3 & mkt_year == 2020

*** bag of slice bread errously entered as 150
replace a5_price = 50 if a5_price == 150 & item_code == 19 & district == 10 & mkt_month == 2 & mkt_year == 2020

***dozen senfurr to piece
replace c5_price = 12 if c5_price == 120 & item_code == 17 & district == 55 & mkt_month == 3 & mkt_year == 2020

*** fix all remaining dozens
replace b5_price = 12 if  (item_code == 16 | item_code == 17 | item_code == 18 | item_code == 19) & b5_price== 120

replace b2_non_standard_unit = 6 if  (item_code == 16 | item_code == 17 | item_code == 18 | item_code == 19) & b2_non_standard_unit == 99 & b5_price== 12 

*** dozens valued at 84
replace c5_price = 7 if  (item_code == 16 | item_code == 17 | item_code == 18 | item_code == 19) & c5_price== 84

replace c2_non_standard_unit = 6 if  (item_code == 16 | item_code == 17 | item_code == 18 | item_code == 19) & c2_non_standard_unit == 99 & c5_price== 7 

** dosens valued at 106
replace b2_non_standard_unit = 6 if  (item_code == 16 | item_code == 17 | item_code == 18 | item_code == 19) & b2_non_standard_unit == 99 & b5_price== 106 

replace b5_price = 8.83 if  (item_code == 16 | item_code == 17 | item_code == 18 | item_code == 19) & b5_price== 106


** dosens valued at 96
replace b2_non_standard_unit = 6 if  (item_code == 16 | item_code == 17 | item_code == 18 | item_code == 19) & b2_non_standard_unit == 99 & b5_price== 96 

replace a2_non_standard_unit = 6 if a2_non_standard_unit == 1 & item_code == 16 & mkt_month == 2 & mkt_year == 2020 & district1 == 54

replace b5_price = 8 if  (item_code == 16 | item_code == 17 | item_code == 18 | item_code == 19) & b5_price== 96

** dozens valued at 84 - b5
replace b2_non_standard_unit = 6 if  (item_code == 16 | item_code == 17 | item_code == 18 | item_code == 19) & b2_non_standard_unit == 99 & b5_price== 84 

replace b5_price = 7 if  (item_code == 16 | item_code == 17 | item_code == 18 | item_code == 19) & b5_price== 84

** dozens valued at 72 - b5
replace b2_non_standard_unit = 6 if  (item_code == 16 | item_code == 17 | item_code == 18 | item_code == 19) & b2_non_standard_unit == 99 & b5_price== 72 

replace b5_price = 6 if  (item_code == 16 | item_code == 17 | item_code == 18 | item_code == 19) & b5_price== 72

***** slice bread- packet errorsly called other
replace a2_non_standard_unit = 5 if (a2_non_standard_unit == 99 | a2_non_standard_unit == 6) & item_code == 19 & a5_price!=.

*** fix
***********************************************
********** Tapala
sum *price if item_code == 16

tab a5_price a2_non_standard_unit if item_code ==16
tab b5_price b2_non_standard_unit if item_code ==16
tab c5_price c2_non_standard_unit if item_code ==16

foreach v in a2_non_standard_unit b2_non_standard_unit {
    
	replace `v' = 6 if `v' == 99 & item_code == 16
	
}


****************************************
***************** Beef with bones

sum *price if item_code == 42
br if item_code == 42 & a5_price== 230
br if item_code == 42 //OKAY

sum *price if item_code == 42

tab a5_price a2_non_standard_unit if item_code ==42
tab b5_price b2_non_standard_unit if item_code ==42
tab c5_price c2_non_standard_unit if item_code ==42

replace b2_non_standard_unit = 1 if b2_non_standard_unit == 2 & item_code == 42

****************************************
***************** White sugar
sum *price if item_code == 178

*** 1450 mistakenly entered as 14500
replace c5_price = 1450 if  item_code == 178  & c5_price== 14500

replace c5_price = 1300 if  item_code == 178  & c5_price== 13000
** checking units:

tab b2_non_standard_unit if item_code == 178 & a5_price == 10
tab b2_non_standard_unit if item_code == 178 & b5_price == 10
tab c2_non_standard_unit if item_code == 178 & c5_price == 10

**** change to cup when price = 10:
replace a2_non_standard_unit = 10 if a2_non_standard_unit == 1 & item_code == 178 & a5_price == 10

replace a2_non_standard_unit = 10 if a2_non_standard_unit == 99 & item_code == 178 & a5_price == 10

tab a5_price a2_non_standard_unit if item_code ==178
tab b5_price b2_non_standard_unit if item_code ==178
tab c5_price c2_non_standard_unit if item_code ==178

* D2 for a bottle- is possibly an error:
replace a2_non_standard_unit = . if a2_non_standard_unit ==13 & item_code == 178 & a5_price == 2

replace a5_price = . if a5_price == 2 & item_code == 178

** liter in b2 is likely a kg.
replace b2_non_standard_unit = 1 if b2_non_standard_unit == 3 & item_code == 178

** other and bottle in c2 likely to be full bag
replace c2_non_standard_unit = 14 if (c2_non_standard_unit == 99 | c2_non_standard_unit == 13) & item_code == 178

****************************************
***************** Small grain rice
sum *price if item_code == 4 // ALready fixed


****************************************
***************** Millet

sum *price if item_code == 7 //looks okay
br if item_code == 7

****************************************
***************** Vegetable oil
sum *price if item_code == 105

** change from ml to litre
replace a2_non_standard_unit = 3 if item_code == 105 & a2_non_standard_unit  == 4

replace b2_non_standard_unit = 3 if item_code == 105 & b2_non_standard_unit  == 4

**litre entered as cup
replace a2_non_standard_unit = 3 if item_code == 105 & a2_non_standard_unit  == 10 & a5_price> 20 & a5_price!=.

tab a5_price a2_non_standard_unit if item_code ==105
tab b5_price b2_non_standard_unit if item_code ==105
tab c5_price c2_non_standard_unit if item_code ==105

** kg in a2 and b2 should be liter
foreach v in a2_non_standard_unit b2_non_standard_unit {
    replace `v' = 3 if `v' == 1 & item_code == 105
	
}

** bottle @ p = 13 in a2 should be cup
replace a2_non_standard_unit = 10 if a2_non_standard_unit == 13 & a5_price == 13 & item_code == 105

** bottle @ p = 75 in a2 should be liter
replace a2_non_standard_unit = 3 if a2_non_standard_unit == 13 & a5_price == 75 & item_code == 105
 
** D3 for bottle seems an error - maybe should be 13
replace b2_non_standard_unit = 10 if b2_non_standard_unit == 13 & item_code == 105 & b5_price == 3

* adjust price to 13- more realistic
replace b5_price = 13 if b5_price == 3 & item_code == 105

** remaining bottle should be liter.
replace b2_non_standard_unit = 3 if b2_non_standard_unit == 13 & inrange(b5_price, 75, 80) & item_code == 105

*** c2- bottle should be liter
replace c2_non_standard_unit = 3 if c2_non_standard_unit == 13 & item_code == 105

** c2- bunch should be other
replace c2_non_standard_unit = 99 if c2_non_standard_unit == 11 & item_code == 105

***********************************************
********** Fresh bonga
sum *price if item_code == 59

tab a5_price a2_non_standard_unit if item_code ==59
tab b5_price b2_non_standard_unit if item_code ==59
tab c5_price c2_non_standard_unit if item_code ==59

** other in a2 should be piece
replace a2_non_standard_unit = 6 if a2_non_standard_unit == 99 & item_code == 59

** packet in b2 should be peice
replace b2_non_standard_unit = 6 if b2_non_standard_unit == 5 & item_code == 59

* other in b2 should be bunch
replace b2_non_standard_unit = 11 if b2_non_standard_unit == 99 & item_code == 59


**** Onion
sum *price if item_code == 164 // No prices for onion?

*****************************************
****** green tea
sum *price if item_code == 256 //looks okay

** Price of kg = 150; gross = 75-100 consider gross as packet
tab a5_price if item_code == 256
tab b5_price if item_code == 256
tab c5_price if item_code == 256

tab a5_price a2_non_standard_unit if item_code ==256
tab b5_price b2_non_standard_unit if item_code ==256
tab c5_price c2_non_standard_unit if item_code ==256

** one piece of packet, consider as piece
replace a2_non_standard_unit = 6 if item_code == 256 & a5_price<11
replace b2_non_standard_unit = 6 if item_code == 256 & b5_price<11
replace c2_non_standard_unit = 6 if item_code == 256 & c5_price<11


*** consider gross as packet
replace b2_non_standard_unit = 5 if item_code == 256 & b5_price >10 & b5_price<101

replace c2_non_standard_unit = 5 if item_code == 256 & c5_price >10 & c5_price<101

*** >100 is kg.

** double check:
tab a2_non_standard_unit  if item_code == 256 & a5_price >10 & a5_price<101
 tab a2_non_standard_unit if item_code == 256 & a5_price<11
 tab a2_non_standard_unit if item_code == 256 & a5_price >100 & a5_price!=.
 
tab b2_non_standard_unit  if item_code == 256 & b5_price >10 & b5_price<101
 tab b2_non_standard_unit if item_code == 256 & b5_price<11
 tab b2_non_standard_unit if item_code == 256 & b5_price >100 & b5_price!=.
 
tab c2_non_standard_unit  if item_code == 256 & c5_price >10 & c5_price<101
 tab c2_non_standard_unit if item_code == 256 & c5_price<11
 tab c2_non_standard_unit if item_code == 256 & c5_price >100 & c5_price!=.
 
 
 **** Chicken legs (imported)
** fix a5_price - all entries are kgs
*** one entry miskenly written as 10 unit; and one price written as 225 

replace a2_non_standard_unit = 1 if a2_non_standard_unit == 10 & item_code == 44

replace a5_price = 125 if a5_price == 225 & item_code == 44

** fix b5_price
replace b2_non_standard_unit = 1 if b2_non_standard_unit == 6 & b5_price == 150 & item_code == 44

replace b2_non_standard_unit = 11 if b2_non_standard_unit == 2 & b5_price == 50 & item_code == 44

** when price is >150 treat all as carton i.e packet
replace b2_non_standard_unit = 5 if item_code == 44 & b5_price > 150 & b5_price !=.

sum *price if item_code == 44

tab a5_price a2_non_standard_unit if item_code ==44
tab b5_price b2_non_standard_unit if item_code ==44
tab c5_price c2_non_standard_unit if item_code ==44

**********************************
*** long grain rice (1)
sum *price if item_code == 1
tab a2_non_standard_unit if item_code == 1 & a5_price!=.
tab b2_non_standard_unit if item_code == 1 & b5_price!=.
tab c2_non_standard_unit if item_code == 1 & c5_price!=.

tab a5_price a2_non_standard_unit if item_code ==1
tab b5_price b2_non_standard_unit if item_code ==1
tab c5_price c2_non_standard_unit if item_code ==1

*** fix units in b2 and c2
* grams should be kgs
replace b2_non_standard_unit = 1 if item_code == 1 & b2_non_standard_unit == 2

//bottle and 100kg  should be 50 kg bag in c2
replace c2_non_standard_unit = 14 if item_code == 1 & (c2_non_standard_unit == 13 | c2_non_standard_unit == 15)

** now look at prices versus units
tab a5_price a2_non_standard_unit if item_code ==1
tab b5_price b2_non_standard_unit if item_code ==1
tab c5_price c2_non_standard_unit if item_code ==1


replace b2_non_standard_unit = 1 if item_code == 1 & b2_non_standard_unit == 14 & b5_price< 1000



*************************************************
******** MAIZE
sum *price if item_code == 6

tab a5_price a2_non_standard_unit if item_code ==6
tab b5_price b2_non_standard_unit if item_code ==6
tab c5_price c2_non_standard_unit if item_code ==6

** Fix units:
//Grams should be KG
replace b2_non_standard_unit = 1 if item_code == 6 & b2_non_standard_unit == 2 & inrange(b5_price, 29, 36)

//1750 entered as kg should be other
replace b2_non_standard_unit = 99 if item_code == 6 & b2_non_standard_unit == 1 & b5_price == 1750


**************************************************
******** Peanut Butter
sum *price if item_code == 187

tab a5_price a2_non_standard_unit if item_code == 187
tab b5_price b2_non_standard_unit if item_code == 187
tab c5_price c2_non_standard_unit if item_code == 187

*** bunch and other costing < 15 consider as piece
replace a2_non_standard_unit = 6 if item_code == 187 & inrange(a5,4, 21)

replace b2_non_standard_unit = 6 if item_code == 187 & inrange(b5,4, 21)

replace c2_non_standard_unit = 6 if item_code == 187 & inrange(c5,4, 21)

***********************************************
********** Palm Oil
sum *price if item_code == 104

tab a5_price a2_non_standard_unit if item_code ==104
tab b5_price b2_non_standard_unit if item_code ==104
tab c5_price c2_non_standard_unit if item_code ==104

// change from kg to liter
replace a2_non_standard_unit = 3 if (a2_non_standard_unit == 1 | a2_non_standard_unit == 4)  & item_code == 104

replace b2_non_standard_unit = 3 if (b2_non_standard_unit == 1 | b2_non_standard_unit == 4)  & item_code == 104

/// from bunch to cup:
replace a2_non_standard_unit = 10 if a2_non_standard_unit == 11 & item_code == 104

// gallons as others
replace b2_non_standard_unit = 99 if item_code == 104 & inrange(b5, 1000, 1500)

//cup for 100 GMD or 75 GMD? maybe should be liter
replace a2_non_standard_unit = 3 if a2_non_standard_unit == 10 & item_code == 104 & inrange(a5_price, 74, 100)

***********************************************
********** Life chicken (Local breed)
sum *price if item_code == 37

tab a5_price a2_non_standard_unit if item_code ==37
tab b5_price b2_non_standard_unit if item_code ==37
tab c5_price c2_non_standard_unit if item_code ==37

** all units should be piece- change from other, kg, packet to piece

replace a2_non_standard_unit = 6 if a2_non_standard_unit!=6 & a5_price!=. & item_code == 37

replace b2_non_standard_unit = 6 if b2_non_standard_unit!=6 & b5_price!=. & item_code == 37

replace c2_non_standard_unit = 6 if c2_non_standard_unit!=6 & c5_price!=. & item_code == 37

** outliers in a5_price
replace a5_price = 250 if inrange(a5_price, 1000, 2600) & item_code == 37

***********************************************
********** Big red pepper
sum *price if item_code == 158

tab a5_price a2_non_standard_unit if item_code ==158
tab b5_price b2_non_standard_unit if item_code ==158
tab c5_price c2_non_standard_unit if item_code ==158

** packet likely to piece
replace a2_non_standard_unit = 6 if a2_non_standard_unit == 5 & item_code == 158

*** a5_price = 1000 likely a sticky zero problem
replace a5_price = 100 if a5_price == 1000 & item_code == 158

** tin is likely medium cup
replace a2_non_standard_unit = 8 if a2_non_standard_unit == 12 & item_code == 158

** from bunch to kg when amount is greater than 75
replace a2_non_standard_unit = 1 if a2_non_standard_unit == 11 & item_code == 158 & b5_price == 100

replace b2_non_standard_unit = 1 if b2_non_standard_unit == 11 & item_code == 158 & b5_price == 150

***********************************************
********** Millet flour
sum *price if item_code == 12

tab a5_price a2_non_standard_unit if item_code ==12
tab b5_price b2_non_standard_unit if item_code ==12
tab c5_price c2_non_standard_unit if item_code ==12

** replace other as small cup
replace a2_non_standard_unit = 7 if a2_non_standard_unit == 99 & item_code == 12

replace b2_non_standard_unit = 7 if b2_non_standard_unit == 99 & item_code == 12

replace c2_non_standard_unit = 7 if c2_non_standard_unit == 99 & item_code == 12

***********************************************
********** Bitter tomato
sum *price if item_code == 154

tab a5_price a2_non_standard_unit if item_code ==154
tab b5_price b2_non_standard_unit if item_code ==154
tab c5_price c2_non_standard_unit if item_code ==154

//packet likely to be piece
replace a2_non_standard_unit = 6 if a2_non_standard_unit == 5 & item_code == 154 & a5_price == 5

//tin likely to be bunch
replace b2_non_standard_unit = 11 if b2_non_standard_unit == 12 & item_code == 154 & b5_price == 25

***********************************************
********** Tilapia
sum *price if item_code == 63

tab a5_price a2_non_standard_unit if item_code ==63
tab b5_price b2_non_standard_unit if item_code ==63
tab c5_price c2_non_standard_unit if item_code ==63

**piece instead of packet
replace b2_non_standard_unit = 6 if b2_non_standard_unit == 5 & item_code == 63 & b5_price == 25

** from other to kilo
replace b2_non_standard_unit = 1 if b2_non_standard_unit == 99 & item_code == 63 & b5_price == 50

***********************************************
********** Jumbo
sum *price if item_code == 194

tab a5_price a2_non_standard_unit if item_code ==194
tab b5_price b2_non_standard_unit if item_code ==194
tab c5_price c2_non_standard_unit if item_code ==194
// NO OBSERVATIONS

***********************************************
********** Okra
sum *price if item_code == 156

tab a5_price a2_non_standard_unit if item_code ==156
tab b5_price b2_non_standard_unit if item_code ==156
tab c5_price c2_non_standard_unit if item_code ==156
//looks okay.

***********************************************
********** Raw groundnut powder
sum *price if item_code == 139

tab a5_price a2_non_standard_unit if item_code ==139
tab b5_price b2_non_standard_unit if item_code ==139
tab c5_price c2_non_standard_unit if item_code ==139

** D2 and D3? replace as missing
replace a5_price = . if item_code == 139 & inrange(a5_price, 2, 3)
replace a2_non_standard_unit = . if item_code == 139 & inrange(a5_price, 2, 3)

** Harmonizes units 5-15 small cup; 20-25 medium cup
*** recode accordingly even if in plastic bag
replace a2_non_standard_unit = 7 if item_code == 139 & inrange(a5_price, 5,15)
replace a2_non_standard_unit = 8 if item_code == 139 & inrange(a5_price,20,25)

replace b2_non_standard_unit = 7 if item_code == 139 & inrange(b5_price,5,15)
replace b2_non_standard_unit = 8 if item_code == 139 & inrange(b5_price, 20,25)

replace c2_non_standard_unit = 7 if item_code == 139 & inrange(c5_price,5,15)
replace c2_non_standard_unit = 8 if item_code == 139 & inrange(c5_price, 20,25)

***********************************************
********** Bread senfurr
sum *price if item_code == 17

tab a5_price a2_non_standard_unit if item_code ==17
tab b5_price b2_non_standard_unit if item_code ==17
tab c5_price c2_non_standard_unit if item_code ==17

//other is actually piece
replace a2_non_standard_unit = 6 if a2_non_standard_unit == 99 & item_code == 17

replace c2_non_standard_unit = 6 if c2_non_standard_unit == 99 & item_code == 17

***********************************************
********** Sorrel (Bisap)
sum *price if item_code == 146

tab a5_price a2_non_standard_unit if item_code ==146
tab b5_price b2_non_standard_unit if item_code ==146
tab c5_price c2_non_standard_unit if item_code ==146
// OKAY

***********************************************
********** Smoked Bonga
sum *price if item_code == 70

tab a5_price a2_non_standard_unit if item_code ==70
tab b5_price b2_non_standard_unit if item_code ==70
tab c5_price c2_non_standard_unit if item_code ==70

//Other in a2 is piece-
replace a2_non_standard_unit = 6 if (a2_non_standard_unit == 99 | a2_non_standard_unit == 5 | a2_non_standard_unit == 1) & item_code == 70

***********************************************
********** Cat fish
sum *price if item_code == 60

tab a5_price a2_non_standard_unit if item_code ==60
tab b5_price b2_non_standard_unit if item_code ==60
tab c5_price c2_non_standard_unit if item_code ==60

//1000 is an outlier
replace b5_price = 100 if b5_price == 1000 & item_code == 60

//other is likely to be piece if price is 50
replace b2_non_standard_unit = 6 if b2_non_standard_unit == 99 & item_code == 60 & b5_price == 50

//other is likely to be kg if price is 75
replace b2_non_standard_unit = 6 if b2_non_standard_unit == 99 & item_code == 60 & b5_price == 75

***********************************************
********** Life goat
sum *price if item_code == 34

tab a5_price a2_non_standard_unit if item_code ==34
tab b5_price b2_non_standard_unit if item_code ==34
tab c5_price c2_non_standard_unit if item_code ==34
//NO PRICES

***********************************************
********** Fresh Milk
sum *price if item_code == 84

tab a5_price a2_non_standard_unit if item_code ==84
tab b5_price b2_non_standard_unit if item_code ==84
tab c5_price c2_non_standard_unit if item_code ==84

// change kilogram and militer to liter
replace a2_non_standard_unit = 3 if (a2_non_standard_unit == 1 | a2_non_standard_unit == 4) & item_code == 84

replace b2_non_standard_unit = 3 if (b2_non_standard_unit == 1 | b2_non_standard_unit == 4) & item_code == 84

replace c2_non_standard_unit = 3 if (c2_non_standard_unit == 1 | c2_non_standard_unit == 4) & item_code == 84

//scoop = cup, seperate from gallon
replace a2_non_standard_unit = 10 if a2_non_standard_unit == 99 & item_code == 84 & inrange(a5_price, 5, 30)

replace b2_non_standard_unit = 10 if b2_non_standard_unit == 99 & item_code == 84 & inrange(b5_price, 5, 30)

replace c2_non_standard_unit = 10 if c2_non_standard_unit == 99 & item_code == 84 & inrange(c5_price, 5, 30)

//Tin is other = gallon
replace b2_non_standard_unit = 99 if b2_non_standard_unit == 12 & item_code == 84

***********************************************
********** Cabbage
sum *price if item_code == 143

tab a5_price a2_non_standard_unit if item_code ==143
tab b5_price b2_non_standard_unit if item_code ==143
tab c5_price c2_non_standard_unit if item_code ==143

** other priced > 10 is piece -i.e whole cabbage; <10 = slice
replace a2_non_standard_unit = 6 if a2_non_standard_unit == 99 & item_code == 143 & (a5_price > 10 & a5_price!=.)

replace b2_non_standard_unit = 6 if b2_non_standard_unit == 99 & item_code == 143 & (b5_price > 10 & b5_price!=.)

// bunch likely to be kg- sticky 1 problem
foreach v in a2_non_standard_unit b2_non_standard_unit c2_non_standard_unit {
	
	replace `v' = 1 if `v' == 11 & item_code == 143
}

replace a2_non_standard_unit = 1 if a2_non_standard_unit == 2 & item_code == 143

// replace packet with piece in c2
replace c2_non_standard_unit = 6 if c2_non_standard_unit == 5 & item_code == 143

***********************************************
********** Milk sachet
sum *price if item_code == 94

tab a5_price a2_non_standard_unit if item_code ==94
tab b5_price b2_non_standard_unit if item_code ==94
tab c5_price c2_non_standard_unit if item_code ==94

br if item_code == 94 & a2_non_standard_unit == 99
br if item_code == 94 & b2_non_standard_unit == 99

**Other units should be packet
replace a2_non_standard_unit = 5 if a2_non_standard_unit!=5 & a5_price!=. & item_code == 94

replace b2_non_standard_unit = 5 if b2_non_standard_unit!=5 & b5_price!=. & item_code == 94

*** outliers
replace a5_price = 5 if a5_price == 55 & item_code == 94

replace c5_price = 5 if c5_price == 125 & item_code == 94

***********************************************
********** Tomato fresh
sum *price if item_code == 153

tab a5_price a2_non_standard_unit if item_code ==153
tab b5_price b2_non_standard_unit if item_code ==153
tab c5_price c2_non_standard_unit if item_code ==153

** other and tin in b2 is likely medium cup
replace b2_non_standard_unit = 8 if item_code == 153 & (b2_non_standard_unit == 99 | b2_non_standard_unit == 12)

***********************************************
********** Irish Potato
sum *price if item_code == 168

tab a5_price a2_non_standard_unit if item_code ==168
tab b5_price b2_non_standard_unit if item_code ==168
tab c5_price c2_non_standard_unit if item_code ==168

*** packet in a2 and c2 should be piece
replace a2_non_standard_unit = 6 if a2_non_standard_unit == 5 & item_code == 168

replace c2_non_standard_unit = 6 if c2_non_standard_unit == 5 & item_code == 168

** other should be 50 kg bag.
***** NOTE: Potatoes are in 20 kg NOT 50 kg bags
foreach v in b2_non_standard_unit c2_non_standard_unit {
	
	replace `v' = 14 if `v' == 99 & item_code == 168
}

//outliers
replace c5_price = 650 if c5_price == 1650 & item_code == 168
replace c5_price = 700 if c5_price == 1700 & item_code == 168

***********************************************
********** Garden eggs
sum *price if item_code == 155

tab a5_price a2_non_standard_unit if item_code ==155
tab b5_price b2_non_standard_unit if item_code ==155
tab c5_price c2_non_standard_unit if item_code ==155

** other in a2 should be piece
replace a2_non_standard_unit = 6 if a2_non_standard_unit == 99 & item_code == 155 

* packet in b2 should be piece
replace b2_non_standard_unit = 6 if b2_non_standard_unit == 5 & item_code == 155 

***********************************************
********** Maize flour
sum *price if item_code == 11

tab a5_price a2_non_standard_unit if item_code ==11
tab b5_price b2_non_standard_unit if item_code ==11
tab c5_price c2_non_standard_unit if item_code ==11

** D1 for big tomato? does not look right
replace a5_price = . if a5_price == 1 & item_code == 11

***********************************************
********** Black pepper
sum *price if item_code == 237

tab a5_price a2_non_standard_unit if item_code ==237
tab b5_price b2_non_standard_unit if item_code ==237
tab c5_price c2_non_standard_unit if item_code ==237

** grams in b2 to kg-
replace b2_non_standard_unit = 1 if b2_non_standard_unit == 2 & item_code == 237

** liter in c2 to be kg
replace c2_non_standard_unit = 1 if c2_non_standard_unit == 3 & item_code ==237

//outier in c5 5 instead of 50
replace c5_price = 5 if c5_price == 50 & item_code == 237

*** Move bunch & other (plastic bag) as piece
foreach v in a2_non_standard_unit b2_non_standard_unit c2_non_standard_unit {
	
	replace `v' = 6 if (`v' == 11 | `v' == 99) & item_code == 237
}
replace c2_non_standard_unit = 1 if c2_non_standard_unit == 5 & item_code == 237 & c5_price == 225

****** NOTE piece = plastic bag

***********************************************
********** Fresh Grouper/Lady Fish
sum *price if item_code == 61

tab a5_price a2_non_standard_unit if item_code ==61
tab b5_price b2_non_standard_unit if item_code ==61
tab c5_price c2_non_standard_unit if item_code ==61

** other in b2 likely to be piece
replace b2_non_standard_unit = 6 if b2_non_standard_unit == 99 & item_code == 61

***********************************************
********** Mayonnaise
sum *price if item_code == 230

tab a5_price a2_non_standard_unit if item_code ==230
tab b5_price b2_non_standard_unit if item_code ==230
tab c5_price c2_non_standard_unit if item_code ==230

/*** re-organize : 
- when p = 5 i.e spoon, consider as piece
- when p = 75 - 90 i.e small jar - tin
- when p = 145 - 180 - bigger jar - bottle
- whne p = 350 - 750 - other
*/

replace a2_non_standard_unit = 6 if item_code == 230 & inrange(a5_price, 5, 10)

replace a2_non_standard_unit = 12 if item_code == 230 & inrange(a5_price, 75, 90)

replace a2_non_standard_unit = 13 if item_code == 230 & inrange(a5_price, 145, 180)

replace a2_non_standard_unit = 99 if item_code == 230 & inrange(a5_price, 350, 725)

**b2
replace b2_non_standard_unit = 6 if item_code == 230 & inrange(b5_price, 5, 10)

replace b2_non_standard_unit = 12 if item_code == 230 & inrange(b5_price, 75, 90)

replace b2_non_standard_unit = 13 if item_code == 230 & inrange(b5_price, 145, 180)

replace b2_non_standard_unit = 99 if item_code == 230 & inrange(b5_price, 350, 725)


**c2
replace c2_non_standard_unit = 6 if item_code == 230 & inrange(c5_price, 5, 10)

replace c2_non_standard_unit = 12 if item_code == 230 & inrange(c5_price, 75, 90)

replace c2_non_standard_unit = 13 if item_code == 230 & inrange(c5_price, 145, 180)

replace c2_non_standard_unit = 99 if item_code == 230 & inrange(c5_price, 350, 725)

***********************************************
********** Spagetti
sum *price if item_code == 25

tab a5_price a2_non_standard_unit if item_code ==25
tab b5_price b2_non_standard_unit if item_code ==25
tab c5_price c2_non_standard_unit if item_code ==25

** move from kg to packet
replace a2_non_standard_unit = 5 if (a2_non_standard_unit == 1 | a2_non_standard_unit == 6 | a2_non_standard_unit == 12) & item_code == 25

replace b2_non_standard_unit = 5 if b2_non_standard_unit == 6 & item_code == 25

replace c2_non_standard_unit = 5 if c2_non_standard_unit == 6 & item_code == 25


***********************************************
********** Small pepper
sum *price if item_code == 152

tab a5_price a2_non_standard_unit if item_code ==152
tab b5_price b2_non_standard_unit if item_code ==152
tab c5_price c2_non_standard_unit if item_code ==152

***********************************************
********** Eggs
sum *price if item_code == 102

tab a5_price a2_non_standard_unit if item_code ==102
tab b5_price b2_non_standard_unit if item_code ==102
tab c5_price c2_non_standard_unit if item_code ==102

** 110 for piece- I think it should be 10 for piece
replace a5_price = 10 if a5_price == 110 & item_code == 102

* piece included in other
replace a2_non_standard_unit = 6 if a2_non_standard_unit == 99 & item_code == 102 & a5_price == 5

replace b2_non_standard_unit = 6 if b2_non_standard_unit == 99 & item_code == 102 & b5_price == 8

** replace other as packet
foreach v in a2_non_standard_unit b2_non_standard_unit c2_non_standard_unit {
	
	replace `v' = 5 if `v' == 99 & item_code == 102
}

***********************************************
********** Dried Fish
sum *price if item_code == 69

tab a5_price a2_non_standard_unit if item_code ==69
tab b5_price b2_non_standard_unit if item_code ==69
tab c5_price c2_non_standard_unit if item_code ==69

** 150 for bunch- likely to be 15
replace a5_price = 15 if a5_price == 150 & item_code == 69

** kilo should be piece- 2 enteries
** other should be piece 
replace a2_non_standard_unit = 6 if (a2_non_standard_unit == 1 | a2_non_standard_unit == 99) & item_code == 69

replace b2_non_standard_unit = 6 if (b2_non_standard_unit == 1 | b2_non_standard_unit == 5 | b2_non_standard_unit == 9)  & item_code == 69

replace c2_non_standard_unit = 6 if c2_non_standard_unit == 9 & item_code == 69

***********************************************
********** Evaporated Milk
sum *price if item_code == 92

tab a5_price a2_non_standard_unit if item_code ==92
tab b5_price b2_non_standard_unit if item_code ==92
tab c5_price c2_non_standard_unit if item_code ==92

** bunch? should be tin
replace a2_non_standard_unit = 12 if (a2_non_standard_unit == 11 | a2_non_standard_unit == 13) & item_code == 92


replace c2_non_standard_unit = 12 if c2_non_standard_unit == 15 & item_code == 92

***********************************************
********** Beef without bones
sum *price if item_code == 49

tab a5_price a2_non_standard_unit if item_code ==49
tab b5_price b2_non_standard_unit if item_code ==49
tab c5_price c2_non_standard_unit if item_code ==49

** 50 on beef should be canned beef
**# Bookmark #1
replace item_code = 56 if item_code == 49 & a5_price == 50

** grams and bunch to be replaced to kg
replace a2_non_standard_unit = 1 if (a2_non_standard_unit == 2 | a2_non_standard_unit == 11) & item_code == 49

replace b2_non_standard_unit = 1 if b2_non_standard_unit == 2 & item_code == 49

***********************************************
********** Salt
sum *price if item_code == 226

tab a5_price a2_non_standard_unit if item_code ==226
tab b5_price b2_non_standard_unit if item_code ==226
tab c5_price c2_non_standard_unit if item_code ==226

**1-10 plastic bag - keep as packet
replace a2_non_standard_unit = 5 if item_code == 226 & inrange(a5_price, 1, 10) & (a2_non_standard_unit == 99 | a2_non_standard_unit == 11 | a2_non_standard_unit == 10)

replace b2_non_standard_unit = 5 if item_code == 226 & inrange(b5_price, 1, 10) & (b2_non_standard_unit == 99 | b2_non_standard_unit == 11)

replace c2_non_standard_unit = 5 if item_code == 226 & inrange(c5_price, 1, 10) & c2_non_standard_unit == 99

** replace tin as small cup and cup as medium cup in b2
replace a2_non_standard_unit = 8 if a2_non_standard_unit == 12 & item_code == 226

replace b2_non_standard_unit = 8 if b2_non_standard_unit == 10 & item_code == 226

***********************************************
********** Sardine
sum *price if item_code == 74

tab a5_price a2_non_standard_unit if item_code ==74
tab b5_price b2_non_standard_unit if item_code ==74
tab c5_price c2_non_standard_unit if item_code ==74

***********************************************
********** Cassava
sum *price if item_code == 169

tab a5_price a2_non_standard_unit if item_code ==169
tab b5_price b2_non_standard_unit if item_code ==169
tab c5_price c2_non_standard_unit if item_code ==169

** 55 for a piece should be 5
replace a5_price = 5 if a5_price == 55 & item_code == 169

*** replace other as piece
foreach v in a2_non_standard_unit b2_non_standard_unit c2_non_standard_unit {
	
	replace `v' = 6 if `v' == 99 & item_code == 169
}

***********************************************
********** Spinach
sum *price if item_code == 144

tab a5_price a2_non_standard_unit if item_code ==144
tab b5_price b2_non_standard_unit if item_code ==144
tab c5_price c2_non_standard_unit if item_code ==144

** a2 should be bunch 
replace a2_non_standard_unit = 11 if a2_non_standard_unit!=11 & item_code == 144 & a5_price!=.

***********************************************
********** Chicken (local)
sum *price if item_code == 45

tab a5_price a2_non_standard_unit if item_code ==45
tab b5_price b2_non_standard_unit if item_code ==45
tab c5_price c2_non_standard_unit if item_code ==45

** all units in a2 should be piece-
replace a2_non_standard_unit = 6 if a2_non_standard_unit!=6 & item_code == 45 & a5_price!=.


***********************************************
********** Red Snapper
sum *price if item_code == 64

tab a5_price a2_non_standard_unit if item_code ==64
tab b5_price b2_non_standard_unit if item_code ==64
tab c5_price c2_non_standard_unit if item_code ==64

***********************************************
********** Sour cow milk
sum *price if item_code == 85

tab a5_price a2_non_standard_unit if item_code ==85
tab b5_price b2_non_standard_unit if item_code ==85
tab c5_price c2_non_standard_unit if item_code ==85

**outliers 1750 likely 175; 20010 likely to be 200
replace b5_price = 175 if b5_price == 1750 & item_code == 85
replace c5_price = 200 if c5_price == 20010 & item_code == 85

*kg ml to liter
replace a2_non_standard_unit = 3 if (a2_non_standard_unit == 1 | a2_non_standard_unit == 4 | a2_non_standard_unit == 13) & item_code == 85

replace b2_non_standard_unit = 3 if (b2_non_standard_unit == 1 | b2_non_standard_unit == 4) & item_code == 85

replace c2_non_standard_unit = 3 if c2_non_standard_unit == 4 & item_code == 85
** tin to other
replace b2_non_standard_unit = 99 if b2_non_standard_unit == 12 & item_code == 85
** replace packet to other
replace c2_non_standard_unit = 99 if c2_non_standard_unit == 5 & item_code == 85

*** consider scoop as cup
replace a2_non_standard_unit = 10 if item_code == 85 & inrange(a5_price, 5,10)

replace b2_non_standard_unit = 10 if item_code == 85 & inrange(b5_price, 5,10)

replace c2_non_standard_unit = 10 if item_code == 85 & inrange(c5_price, 5,10)

***********************************************
********** Locust beans (Neetetu)
sum *price if item_code == 238

tab a5_price a2_non_standard_unit if item_code ==238
tab b5_price b2_non_standard_unit if item_code ==238
tab c5_price c2_non_standard_unit if item_code ==238

**kg for D5, likley a bunch
replace a2_non_standard_unit = 11 if a2_non_standard_unit == 1 & item_code == 238

** other with p<10 to be bunch
replace a2_non_standard_unit = 11 if a2_non_standard_unit == 99 & item_code == 238 & a5_price == 5

replace a2_non_standard_unit = 12 if a2_non_standard_unit == 99 & item_code == 238 & a5_price == 10

*b2
replace b2_non_standard_unit = 11 if b2_non_standard_unit == 99 & item_code == 238 & b5_price == 5

replace b2_non_standard_unit = 12 if b2_non_standard_unit == 99 & item_code == 238 & b5_price == 10


***********************************************
********** Sweet Potato
sum *price if item_code == 167

tab a5_price a2_non_standard_unit if item_code ==167
tab b5_price b2_non_standard_unit if item_code ==167
tab c5_price c2_non_standard_unit if item_code ==167

** outlier- 200 likley to be 20
replace b5_price = 20 if b5_price == 200 & item_code == 167

** if other replace as piece
replace a2_non_standard_unit = 6 if a2_non_standard_unit == 99 & item_code == 167

replace b2_non_standard_unit = 6 if (b2_non_standard_unit == 99 | b2_non_standard_unit == 7) & item_code == 167

***********************************************
********** Garlic
sum *price if item_code == 165

tab a5_price a2_non_standard_unit if item_code ==165
tab b5_price b2_non_standard_unit if item_code ==165
tab c5_price c2_non_standard_unit if item_code ==165

replace a2_non_standard_unit = 6 if a2_non_standard_unit == 99 & item_code == 165

replace b2_non_standard_unit = 6 if (b2_non_standard_unit == 99 | b2_non_standard_unit == 5) & item_code == 165

replace c2_non_standard_unit = 6 if c2_non_standard_unit == 99 & item_code == 165 & c5_price == 2

***********************************************
********** Paddy rice
sum *price if item_code == 2

tab a5_price a2_non_standard_unit if item_code ==2
tab b5_price b2_non_standard_unit if item_code ==2
tab c5_price c2_non_standard_unit if item_code ==2
// NO DATA

***********************************************
********** Pumpkin
sum *price if item_code == 157

tab a5_price a2_non_standard_unit if item_code ==157
tab b5_price b2_non_standard_unit if item_code ==157
tab c5_price c2_non_standard_unit if item_code ==157

/** re-organize
 when p<10 it is a cut- keep as other
 if p>10, keep as piece
*/

replace a2_non_standard_unit = 99 if item_code == 157 & a5_price < 11

replace a2_non_standard_unit = 6 if item_code == 157 & a5_price > 10 & a5_price!=.

*b2
replace b2_non_standard_unit = 99 if item_code == 157 & b5_price < 11

replace b2_non_standard_unit = 6 if item_code == 157 & b5_price > 10 & a5_price!=.

*c2
replace c2_non_standard_unit = 99 if item_code == 157 & c5_price < 11

replace c2_non_standard_unit = 6 if item_code == 157 & c5_price > 10 & a5_price!=.

***********************************************
********** Short Macaroni
sum *price if item_code == 24

tab a5_price a2_non_standard_unit if item_code ==24
tab b5_price b2_non_standard_unit if item_code ==24
tab c5_price c2_non_standard_unit if item_code ==24

*** other should be bunch
replace a2_non_standard_unit = 11 if item_code == 24 & inrange(a5_price, 5, 10)

replace b2_non_standard_unit = 11 if item_code == 24 & inrange(b5_price, 5, 10)

replace c2_non_standard_unit = 11 if item_code == 24 & inrange(c5_price, 5, 10)

** remove 250 from bunch to packet
replace a2_non_standard_unit = 5 if a2_non_standard_unit == 11 & item_code == 24 & a5_price == 250

** other should be packet
replace b2_non_standard_unit = 5 if b2_non_standard_unit == 99 & item_code == 24 & b5_price == 260



******************************
** GENERAL USUAL CONVERTIONS
******************************

** KILOGRAMS will stay KILOGRAMS AND LITERS will stay LITERS
replace a3_standard_quantity=1  if  inlist(a2_non_standard_unit,1)
replace a3_standard_quantity=1  if  inlist(a2_non_standard_unit,3)
replace a4_standard_unitt=1 if  inlist(a2_non_standard_unit,1)
replace a4_standard_unitt=3 if  inlist(a2_non_standard_unit,3)

replace b3_standard_quantity=1  if  inlist(b2_non_standard_unit,1)
replace b3_standard_quantity=1  if  inlist(b2_non_standard_unit,3)
replace b4_standard_unit=1  if  inlist(b2_non_standard_unit,1)
replace b4_standard_unit=3  if  inlist(b2_non_standard_unit,3)

replace c3_standard_quantity=1  if  inlist(c2_non_standard_unit,1)
replace c3_standard_quantity=1  if  inlist(c2_non_standard_unit,3)
replace c4_standard_unit=1 if  inlist(c2_non_standard_unit,1)
replace c4_standard_unit=3  if  inlist(c2_non_standard_unit,3)


** GRAMS (g)  to KILOGRAMS (kg)
replace a3_standard_quantity=1/1000  if  inlist(a2_non_standard_unit,2)
replace a4_standard_unitt=1 if  inlist(a2_non_standard_unit,2)

replace b3_standard_quantity=1/1000 if  inlist(b2_non_standard_unit,2)
replace b4_standard_unit=1  if  inlist(b2_non_standard_unit,2)

replace c3_standard_quantity=1/1000  if  inlist(c2_non_standard_unit,2)
replace c4_standard_unit=1 if  inlist(c2_non_standard_unit,2)


** MILLITRES (ml)  to LITRES (l)
replace a3_standard_quantity=1/1000  if  inlist(a2_non_standard_unit,4)
replace a4_standard_unitt=3 if  inlist(a2_non_standard_unit,4)

replace b3_standard_quantity=1/1000 if  inlist(b2_non_standard_unit,4)
replace b4_standard_unit=3  if  inlist(b2_non_standard_unit,4)

replace c3_standard_quantity=1/1000  if  inlist(c2_non_standard_unit,4)
replace c4_standard_unit=3 if  inlist(c2_non_standard_unit,4)


** 50 KG BAG  to KILOGRAMS (kg)
replace a3_standard_quantity=50  if  inlist(a2_non_standard_unit,14)
replace a4_standard_unitt=1 if  inlist(a2_non_standard_unit,14)

replace b3_standard_quantity=50 if  inlist(b2_non_standard_unit,14)
replace b4_standard_unit=1  if  inlist(b2_non_standard_unit,14)

replace c3_standard_quantity=50  if  inlist(c2_non_standard_unit,14)
replace c4_standard_unit=1 if  inlist(c2_non_standard_unit,14)


** 100 KG BAG  to KILOGRAMS (kg)
replace a3_standard_quantity=100  if  inlist(a2_non_standard_unit,15)
replace a4_standard_unitt=1 if  inlist(a2_non_standard_unit,15)

replace b3_standard_quantity=100 if  inlist(b2_non_standard_unit,15)
replace b4_standard_unit=1  if  inlist(b2_non_standard_unit,15)

replace c3_standard_quantity=100  if  inlist(c2_non_standard_unit,15)
replace c4_standard_unit=1 if  inlist(c2_non_standard_unit,15)





***************************************
**  1-Medium-Grained Rice (Imported) (3)      OK       
***************************************	
** 1 KILOGRAMS = 1 Kg
** 1 50 KG BAG = 50 Kg
	   	   		   
** 1 CUP (standard rice cup) = 0.25 Kg
replace a3_standard_quantity=1/4  if a2_non_standard_unit==10 & item_code==3
replace a4_standard_unitt=1 if a2_non_standard_unit==10 & item_code==3

replace b3_standard_quantity=1/4 if b2_non_standard_unit==10 & item_code==3
replace b4_standard_unit=1  if b2_non_standard_unit==10 & item_code==3

replace c3_standard_quantity=1/4  if c2_non_standard_unit==10 & item_code==3
replace c4_standard_unit=1 if c2_non_standard_unit==10 & item_code==3

** OTHER (specify):
*    - 1 25 kg bag  = 25 Kg   
replace c3_standard_quantity=25  if c2_non_standard_unit==99 & item_code==3
replace c4_standard_unit=1 if c2_non_standard_unit==99 & item_code==3
//all the OTHER (specify) are 25 kg bag and are present just in the c colon




***************************
**  3-Beef with bones (42)    OK
***************************
** 1 KILOGRAMS = 1 Kg






***************************
**  2-Bread (tapalapa) (16)      OK
***************************
** 1 PIECE/NUMBER = ?? Kg ------0.4 Kg
replace a3_standard_quantity=0.4  if a2_non_standard_unit==6 & item_code==16
replace a4_standard_unitt=1 if a2_non_standard_unit==6 & item_code==16

replace b3_standard_quantity=0.4  if b2_non_standard_unit==6 & item_code==16
replace b4_standard_unit=1  if b2_non_standard_unit==6 & item_code==16

replace c3_standard_quantity=0.4   if c2_non_standard_unit==6 & item_code==16
replace c4_standard_unit=1 if c2_non_standard_unit==6 & item_code==16



*******************************
** 4- Chicken leg (Imported) (44)   OK
*******************************
** 1 KILOGRAMS = 1 Kg
         
** 1 PIECE/NUMBER = ?? Kg ----0.25 Kg
replace a3_standard_quantity=0.25  if a2_non_standard_unit==6 & item_code==44
replace a4_standard_unitt=1 if a2_non_standard_unit==6 & item_code==44

replace b3_standard_quantity=0.25  if b2_non_standard_unit==6 & item_code==44
replace b4_standard_unit=1  if b2_non_standard_unit==6 & item_code==44

replace c3_standard_quantity=0.25   if c2_non_standard_unit==6 & item_code==44
replace c4_standard_unit=1 if c2_non_standard_unit==6 & item_code==44

** 1 PACKET = ?? Kg ---------------10 Kg
replace a3_standard_quantity=10   if a2_non_standard_unit==5 & item_code==44
replace a4_standard_unitt=1 if a2_non_standard_unit==5 & item_code==44

replace b3_standard_quantity=10   if b2_non_standard_unit==5 & item_code==44
replace b4_standard_unit=1  if b2_non_standard_unit==5 & item_code==44

replace c3_standard_quantity=10    if c2_non_standard_unit==5 & item_code==44
replace c4_standard_unit=1 if c2_non_standard_unit==5 & item_code==44

** 1 BUNCH/HEAP = ?? Kg  ----- 1 Kg 
replace a3_standard_quantity=1  if a2_non_standard_unit==11 & item_code==44
replace a4_standard_unitt=1 if a2_non_standard_unit==11 & item_code==44

replace b3_standard_quantity=1   if b2_non_standard_unit==11 & item_code==44
replace b4_standard_unit=1  if b2_non_standard_unit==11 & item_code==44

replace c3_standard_quantity=1    if c2_non_standard_unit==11 & item_code==44
replace c4_standard_unit=1 if c2_non_standard_unit==11 & item_code==44



********************************
** 5-White Sugar (Powder)  (178)  OK
********************************
** 1 KILOGRAMS = 1 Kg	
** 1 50 KG BAG = 50 Kg


** 1 CUP (standard rice cup) = ?? Kg ------ 0.25 Kg
replace a3_standard_quantity=1/4  if a2_non_standard_unit==10 & item_code==178
replace a4_standard_unitt=1 if a2_non_standard_unit==10 & item_code==178

replace b3_standard_quantity=1/4 if b2_non_standard_unit==10 & item_code==178
replace b4_standard_unit=1  if b2_non_standard_unit==10 & item_code==178

replace c3_standard_quantity=1/4  if c2_non_standard_unit==10 & item_code==178
replace c4_standard_unit=1 if c2_non_standard_unit==10 & item_code==178






**********************
** 6-Onoin  (164)       to fix and append
**********************
** No observations in the 2020 prices data. We should input this.



**************************************
** 7-Small grained rice (imported) (4)   OK
**************************************
** 1 KILOGRAMS = 1 Kg 
** 1 50 KG BAG = 50 Kg


** 1 CUP (standard rice cup) = ?? Kg ----- 0.25 Kg
replace a3_standard_quantity=1/4  if a2_non_standard_unit==10 & item_code==4
replace a4_standard_unitt=1 if a2_non_standard_unit==10 & item_code==4

replace b3_standard_quantity=1/4 if b2_non_standard_unit==10 & item_code==4
replace b4_standard_unit=1  if b2_non_standard_unit==10 & item_code==4

replace c3_standard_quantity=1/4  if c2_non_standard_unit==10 & item_code==4
replace c4_standard_unit=1 if c2_non_standard_unit==10 & item_code==4


** OTHER (specify):
*    - 1 25 kg bag  = 25 Kg   
replace c3_standard_quantity=25  if c2_non_standard_unit==99 & item_code==4
replace c4_standard_unit=1 if c2_non_standard_unit==99 & item_code==4
//all the OTHER (specify) are 25 kg bag and are present just in the c colon



**********************
** 8-Millet (7)            OK
**********************
** 1 KILOGRAMS = 1 Kg
** 1 GRAMS (g) = 0.001 Kg
** 1 50 KG BAG = 50 Kg
** 1 100 KG BAG = 100 Kg  

** 1 BIG TOMATO CUP = 2 kg
replace a3_standard_quantity=2  if a2_non_standard_unit==9 & item_code==7
replace a4_standard_unitt=1 if a2_non_standard_unit==9 & item_code==7

replace b3_standard_quantity=2 if b2_non_standard_unit==9 & item_code==7
replace b4_standard_unit=1  if b2_non_standard_unit==9 & item_code==7

replace c3_standard_quantity=2  if c2_non_standard_unit==9 & item_code==7
replace c4_standard_unit=1 if c2_non_standard_unit==9 & item_code==7

** 1 MEDIUM TOMATO CUP = 1 kg
replace a3_standard_quantity=1  if a2_non_standard_unit==8 & item_code==7
replace a4_standard_unitt=1 if a2_non_standard_unit==8 & item_code==7

replace b3_standard_quantity=1 if b2_non_standard_unit==8 & item_code==7
replace b4_standard_unit=1  if b2_non_standard_unit==8 & item_code==7

replace c3_standard_quantity=1  if c2_non_standard_unit==8 & item_code==7
replace c4_standard_unit=1 if c2_non_standard_unit==8 & item_code==7

** 1 SMALL TOMATO CUP = 0.4 Kg
replace a3_standard_quantity=0.4  if a2_non_standard_unit==7 & item_code==7
replace a4_standard_unitt=1 if a2_non_standard_unit==7 & item_code==7

replace b3_standard_quantity=0.4 if b2_non_standard_unit==7 & item_code==7
replace b4_standard_unit=1  if b2_non_standard_unit==7 & item_code==7

replace c3_standard_quantity=0.4  if c2_non_standard_unit==7 & item_code==7
replace c4_standard_unit=1 if c2_non_standard_unit==7 & item_code==7

** CUP (standard rice cup) = 0.25 Kg
replace a3_standard_quantity=0.25  if a2_non_standard_unit==10 & item_code==7
replace a4_standard_unitt=1 if a2_non_standard_unit==10 & item_code==7

replace b3_standard_quantity=0.25 if b2_non_standard_unit==10 & item_code==7
replace b4_standard_unit=1  if b2_non_standard_unit==10 & item_code==7

replace c3_standard_quantity=0.25  if c2_non_standard_unit==10 & item_code==7
replace c4_standard_unit=1 if c2_non_standard_unit==10 & item_code==7

** OTHER (specify): 
*    - 1  80 kg bag  = 80 Kg 
replace a3_standard_quantity=80  if a2_non_standard_unit==99 & item_code==7
replace a4_standard_unit=1 if a2_non_standard_unit==99 & item_code==7

replace b3_standard_quantity=80  if b2_non_standard_unit==99 & item_code==7
replace b4_standard_unit=1 if b2_non_standard_unit==99 & item_code==7

replace c3_standard_quantity=80  if c2_non_standard_unit==99 & item_code==7
replace c4_standard_unit=1 if c2_non_standard_unit==99 & item_code==7



***************************************
** 9-Vegetable Oil (Sold loose)  (105)     OK
***************************************
** 1 KILOGRAMS = 1 Kg
** 1 LITRES (l) = 1 L
** 1 MILLITRES (ml) = 0.001 L 
         	 
** 1 CUP (standard rice cup) = 1/5 L  
replace a3_standard_quantity=1/5  if a2_non_standard_unit==10 & item_code==105
replace a4_standard_unitt=3 if a2_non_standard_unit==10 & item_code==105

replace b3_standard_quantity=1/5 if b2_non_standard_unit==10 & item_code==105
replace b4_standard_unit=3  if b2_non_standard_unit==10 & item_code==105

replace c3_standard_quantity=1/5  if c2_non_standard_unit==10 & item_code==105
replace c4_standard_unit=3 if c2_non_standard_unit==10 & item_code==105
  

** OTHER (specify): 
*    - 1  20 litres garlon  = 20 L  
replace b3_standard_quantity=20  if b2_non_standard_unit==99 & item_code==105
replace b4_standard_unit=3 if b2_non_standard_unit==99 & item_code==105

replace c3_standard_quantity=20  if c2_non_standard_unit==99 & item_code==105
replace c4_standard_unit=3 if c2_non_standard_unit==99 & item_code==105



***************************
**  10-Fresh Bonga (59)        OK
***************************	
** 1 KILOGRAMS = 1 Kg	
	     
** 1 PIECE/NUMBER = ?? Kg ----- 0.125 kg ?
replace a3_standard_quantity=0.125  if a2_non_standard_unit==6 & item_code==59
replace a4_standard_unitt=1 if a2_non_standard_unit==6 & item_code==59

replace b3_standard_quantity=0.125  if b2_non_standard_unit==6 & item_code==59
replace b4_standard_unit=1  if b2_non_standard_unit==6 & item_code==59

replace c3_standard_quantity=0.125   if c2_non_standard_unit==6 & item_code==59
replace c4_standard_unit=1 if c2_non_standard_unit==6 & item_code==59

** 1 BUNCH/HEAP = 0.55 Kg 
replace a3_standard_quantity=0.55 if a2_non_standard_unit==11 & item_code==59
replace a4_standard_unitt=1 if a2_non_standard_unit==11 & item_code==59

replace b3_standard_quantity=0.55 if b2_non_standard_unit==11 & item_code==59
replace b4_standard_unit=1  if b2_non_standard_unit==11 & item_code==59

replace c3_standard_quantity=0.55  if c2_non_standard_unit==11 & item_code==59
replace c4_standard_unit=1 if c2_non_standard_unit==11 & item_code==59




******************************
** 11-Green Tea(Attaya)  (256)   OK
******************************	
** 1 KILOGRAMS = 1 Kg      
     
** 1 PACKET = ?? Kg When price  = 35 and unit = packet (5), conversion factor should be 100 grams // When price > 35 and unit = packet (5), conversion factor should be 250grams
replace a3_standard_quantity=0.1 if a2_non_standard_unit==5 & item_code==256 & a5_price <= 35
replace a3_standard_quantity=0.25 if a2_non_standard_unit==5 & item_code==256 & a5_price > 35
replace a4_standard_unitt=1 if a2_non_standard_unit==5 & item_code==256

replace b3_standard_quantity=0.1 if b2_non_standard_unit==5 & item_code==256 & b5_price <= 35
replace b3_standard_quantity=0.25 if b2_non_standard_unit==5 & item_code==256 & b5_price > 35
replace b4_standard_unit=1  if b2_non_standard_unit==5 & item_code==256

replace c3_standard_quantity=0.1 if c2_non_standard_unit==5 & item_code==256 & c5_price <= 35
replace c3_standard_quantity=0.25 if c2_non_standard_unit==5 & item_code==256 & c5_price > 35
replace c4_standard_unit=1 if c2_non_standard_unit==5 & item_code==256

** 1 PIECE/NUMBER = ?? Kg ------ 0.025 kg
replace a3_standard_quantity=0.025  if a2_non_standard_unit==6 & item_code==256
replace a4_standard_unitt=1 if a2_non_standard_unit==6 & item_code==256

replace b3_standard_quantity=0.025  if b2_non_standard_unit==6 & item_code==256
replace b4_standard_unit=1  if b2_non_standard_unit==6 & item_code==256

replace c3_standard_quantity=0.025  if c2_non_standard_unit==6 & item_code==256
replace c4_standard_unit=1 if c2_non_standard_unit==6 & item_code==256





**********************
**  12-Maize (6)          OK     
**********************
** 1 KILOGRAMS = 1 Kg  
** 1 50 KG BAG = 50 Kg   

** 1 BIG TOMATO CUP  = 2 kg  
replace a3_standard_quantity=2  if a2_non_standard_unit==9 & item_code==6
replace a4_standard_unitt=1 if a2_non_standard_unit==9 & item_code==6

replace b3_standard_quantity=2 if b2_non_standard_unit==9 & item_code==6
replace b4_standard_unit=1  if b2_non_standard_unit==9 & item_code==6

replace c3_standard_quantity=2  if c2_non_standard_unit==9 & item_code==6
replace c4_standard_unit=1 if c2_non_standard_unit==9 & item_code==6

** 1 MEDIUM TOMATO CUP = 1 Kg 
replace a3_standard_quantity=1  if a2_non_standard_unit==8 & item_code==6
replace a4_standard_unitt=1 if a2_non_standard_unit==8 & item_code==6

replace b3_standard_quantity=1 if b2_non_standard_unit==8 & item_code==6
replace b4_standard_unit=1  if b2_non_standard_unit==8 & item_code==6

replace c3_standard_quantity=1  if c2_non_standard_unit==8 & item_code==6
replace c4_standard_unit=1 if c2_non_standard_unit==8 & item_code==6

** 1 SMALL TOMATO CUP = 0.4 Kg
replace a3_standard_quantity=0.4  if a2_non_standard_unit==7 & item_code==6
replace a4_standard_unitt=1 if a2_non_standard_unit==7 & item_code==6

replace b3_standard_quantity=0.4 if b2_non_standard_unit==7 & item_code==6
replace b4_standard_unit=1  if b2_non_standard_unit==7 & item_code==6

replace c3_standard_quantity=0.4  if c2_non_standard_unit==7 & item_code==6
replace c4_standard_unit=1 if c2_non_standard_unit==7 & item_code==6

** OTHER (specify): 
*    - 1 80 kg  bag = 80 Kg
replace a3_standard_quantity=80  if a2_non_standard_unit==99 & item_code==6
replace a4_standard_unit=1 if a2_non_standard_unit==99 & item_code==6

replace b3_standard_quantity=80  if b2_non_standard_unit==99 & item_code==6
replace b4_standard_unit=1 if b2_non_standard_unit==99 & item_code==6

replace c3_standard_quantity=80  if c2_non_standard_unit==99 & item_code==6
replace c4_standard_unit=1 if c2_non_standard_unit==99 & item_code==6




***************************************
**  13-Long-Grained Rice (Imported) (1)         OK       
***************************************
** 1 KILOGRAMS = 1 Kg
** 1 50 KG BAG = 50 Kg

** 1 CUP (standard rice cup) = 0.25 Kg
replace a3_standard_quantity=1/4  if a2_non_standard_unit==10 & item_code==1
replace a4_standard_unitt=1 if a2_non_standard_unit==10 & item_code==1

replace b3_standard_quantity=1/4 if b2_non_standard_unit==10 & item_code==1
replace b4_standard_unit=1  if b2_non_standard_unit==10 & item_code==1

replace c3_standard_quantity=1/4  if c2_non_standard_unit==10 & item_code==1
replace c4_standard_unit=1 if c2_non_standard_unit==10 & item_code==1




***************************
**  14-Palm Oil  (104)            OK
***************************
** 1 LITRES (l) = 1 L	
        
** 1 CUP (standard rice cup) = ?? L  ------- 0.25 liters 
replace a3_standard_quantity=0.25  if a2_non_standard_unit==10 & item_code==104
replace a4_standard_unitt=3 if a2_non_standard_unit==10 & item_code==104

replace b3_standard_quantity=0.25 if b2_non_standard_unit==10 & item_code==104
replace b4_standard_unit=3  if b2_non_standard_unit==10 & item_code==104

replace c3_standard_quantity=0.25 if c2_non_standard_unit==10 & item_code==104
replace c4_standard_unit=3 if c2_non_standard_unit==10 & item_code==104

** 1 BOTTLE. = 1 L
replace a3_standard_quantity=1 if a2_non_standard_unit==13 & item_code==104
replace a4_standard_unitt=3 if a2_non_standard_unit==13 & item_code==104

replace b3_standard_quantity=1 if b2_non_standard_unit==13 & item_code==104
replace b4_standard_unit=3  if b2_non_standard_unit==13 & item_code==104

replace c3_standard_quantity=1 if c2_non_standard_unit==13 & item_code==104
replace c4_standard_unit=3 if c2_non_standard_unit==13 & item_code==104

** OTHER (specify): 
*    - 1  20 litres garlon  = 20 L 
replace b3_standard_quantity=20  if b2_non_standard_unit==99 & item_code==104
replace b4_standard_unit=3 if b2_non_standard_unit==99 & item_code==104    

replace c3_standard_quantity=20  if c2_non_standard_unit==99 & item_code==104
replace c4_standard_unit=3 if c2_non_standard_unit==99 & item_code==104    




*************************** 
** 15-Peanut Butter  (187)    OK
***************************	
** 1 KILOGRAMS = 1 Kg  
        
** 1 PIECE/NUMBER = ?? Kg ------- if price = 10-15 = 250g
replace a3_standard_quantity=0.25  if a2_non_standard_unit==6 & item_code==187
replace a4_standard_unitt=1 if a2_non_standard_unit==6 & item_code==187

replace b3_standard_quantity=0.25  if b2_non_standard_unit==6 & item_code==187
replace b4_standard_unit=1  if b2_non_standard_unit==6 & item_code==187

replace c3_standard_quantity=0.25  if c2_non_standard_unit==6 & item_code==187
replace c4_standard_unit=1 if c2_non_standard_unit==6 & item_code==187


** OTHER (specify): 
*    - 5 littes gallon = 5 L
replace b3_standard_quantity=5  if b2_non_standard_unit==99 & item_code==187
replace b4_standard_unit=1  if b2_non_standard_unit==99 & item_code==187

replace c3_standard_quantity=5  if c2_non_standard_unit==99 & item_code==187
replace c4_standard_unit=1 if c2_non_standard_unit==99 & item_code==187



**************************************
**  16-Life Chicken(Local Breed) (37)    OK
**************************************
** 1 PIECE/NUMBER = 1 Kg   //pices are in range 200, 225, 275, 300 
replace a3_standard_quantity=1  if a2_non_standard_unit==6 & item_code==37
replace a4_standard_unitt=1 if a2_non_standard_unit==6 & item_code==37

replace b3_standard_quantity=1  if b2_non_standard_unit==6 & item_code==37
replace b4_standard_unit=1  if b2_non_standard_unit==6 & item_code==37

replace c3_standard_quantity=1  if c2_non_standard_unit==6 & item_code==37
replace c4_standard_unit=1 if c2_non_standard_unit==6 & item_code==37



***************************
** 17-Tilapia  (63)                OK
***************************	
** 1 KILOGRAMS = 1 Kg 
            
** 1 BUNCH/HEAP = ?? Kg  ------ when price inrange 25-100- == 1 Kg
replace a3_standard_quantity=1 if a2_non_standard_unit==11 & item_code==63
replace a4_standard_unitt=1 if a2_non_standard_unit==11 & item_code==63

replace b3_standard_quantity=1 if b2_non_standard_unit==11 & item_code==63
replace b4_standard_unit=1  if b2_non_standard_unit==11 & item_code==63

replace c3_standard_quantity=1  if c2_non_standard_unit==11 & item_code==63
replace c4_standard_unit=1 if c2_non_standard_unit==11 & item_code==63	 

** 1 PIECE/NUMBER = ?? Kg  ------- 0.25kg? also when 
replace a3_standard_quantity=0.25 if a2_non_standard_unit==6 & item_code==63
replace a4_standard_unitt=1 if a2_non_standard_unit==6 & item_code==63

replace b3_standard_quantity=0.25  if b2_non_standard_unit==6 & item_code==63
replace b4_standard_unit=1  if b2_non_standard_unit==6 & item_code==63

replace c3_standard_quantity=0.25  if c2_non_standard_unit==6 & item_code==63
replace c4_standard_unit=1 if c2_non_standard_unit==6 & item_code==63





************************
**  18-Millet Flour (12)  OK
************************
** 1 KILOGRAMS = 1 Kg  

** 1 SMALL TOMATO CUP = 400 gm
replace a3_standard_quantity=0.4  if a2_non_standard_unit==7 & item_code==12
replace a4_standard_unitt=1 if a2_non_standard_unit==7 & item_code==12

replace b3_standard_quantity=0.4 if b2_non_standard_unit==7 & item_code==12
replace b4_standard_unit=1  if b2_non_standard_unit==7 & item_code==12

replace c3_standard_quantity=0.4  if c2_non_standard_unit==7 & item_code==12
replace c4_standard_unit=1 if c2_non_standard_unit==7 & item_code==12

** 1 MEDIUM TOMATO CUP =  1 Kg 
 replace a3_standard_quantity=1 if a2_non_standard_unit==8 & item_code==12
replace a4_standard_unitt=1 if a2_non_standard_unit==8 & item_code==12

replace b3_standard_quantity=1 if b2_non_standard_unit==8 & item_code==12
replace b4_standard_unit=1  if b2_non_standard_unit==8 & item_code==12

replace c3_standard_quantity=1  if c2_non_standard_unit==8 & item_code==12
replace c4_standard_unit=1 if c2_non_standard_unit==8 & item_code==12
 
** 1 BIG TOMATO CUP = 2 Kg
replace a3_standard_quantity=2  if a2_non_standard_unit==9 & item_code==12
replace a4_standard_unitt=1 if a2_non_standard_unit==9 & item_code==12

replace b3_standard_quantity=2 if b2_non_standard_unit==9 & item_code==12
replace b4_standard_unit=1  if b2_non_standard_unit==9 & item_code==12

replace c3_standard_quantity=2  if c2_non_standard_unit==9 & item_code==12
replace c4_standard_unit=1 if c2_non_standard_unit==9 & item_code==12




***************************
** 19-Okra  (156)             OK
***************************	
** 1 KILOGRAMS = 1 Kg  // Just one observation    
      
** 1 PIECE/NUMBER = ?? Kg  ----- 5grams? 
replace a3_standard_quantity=0.05  if a2_non_standard_unit==6 & item_code==156
replace a4_standard_unitt=1 if a2_non_standard_unit==6 & item_code==156

replace b3_standard_quantity=0.05  if b2_non_standard_unit==6 & item_code==156
replace b4_standard_unit=1  if b2_non_standard_unit==6 & item_code==156

replace c3_standard_quantity=0.05   if c2_non_standard_unit==6 & item_code==156
replace c4_standard_unit=1 if c2_non_standard_unit==6 & item_code==156

** 1 BUNCH/HEAP = ?? Kg ---- 300-500 grams depending on price
replace a3_standard_quantity=0.5  if a2_non_standard_unit==11 & item_code==156
replace a4_standard_unitt=1 if a2_non_standard_unit==11 & item_code==156

replace b3_standard_quantity=0.5  if b2_non_standard_unit==11 & item_code==156
replace b4_standard_unit=1  if b2_non_standard_unit==11 & item_code==156

replace c3_standard_quantity=0.5   if c2_non_standard_unit==11 & item_code==156
replace c4_standard_unit=1 if c2_non_standard_unit==11 & item_code==156





******************************************
** 20-Eggs of hen Industrial breed  (102)    OK
******************************************         
** 1 PIECE/NUMBER = 50 g 
replace a3_standard_quantity=0.05  if a2_non_standard_unit==6 & item_code==102
replace a4_standard_unitt=1 if a2_non_standard_unit==6 & item_code==102

replace b3_standard_quantity=0.05  if b2_non_standard_unit==6 & item_code==102
replace b4_standard_unit=1  if b2_non_standard_unit==6 & item_code==102

replace c3_standard_quantity=0.05   if c2_non_standard_unit==6 & item_code==102
replace c4_standard_unit=1 if c2_non_standard_unit==6 & item_code==102

** 1 PACKET = ?? Kg --- 1.5kg - 30 eggs per crate/packet
replace a3_standard_quantity=1.5  if a2_non_standard_unit==5 & item_code==102
replace a4_standard_unitt=1 if a2_non_standard_unit==5 & item_code==102

replace b3_standard_quantity=1.5  if b2_non_standard_unit==5 & item_code==102
replace b4_standard_unit=1  if b2_non_standard_unit==5 & item_code==102

replace c3_standard_quantity=1.5   if c2_non_standard_unit==5 & item_code==102
replace c4_standard_unit=1 if c2_non_standard_unit==5 & item_code==102




***************************
**  21-Cat Fish (60)                  OK
***************************			  
** 1 KILOGRAMS = 1 Kg    
         
** 1 PIECE/NUMBER = ?? Kg ------- 0.125 kg
replace a3_standard_quantity=0.125 if a2_non_standard_unit==6 & item_code==60
replace a4_standard_unitt=1 if a2_non_standard_unit==6 & item_code==60

replace b3_standard_quantity=0.125 if b2_non_standard_unit==6 & item_code==60
replace b4_standard_unit=1  if b2_non_standard_unit==6 & item_code==60

replace c3_standard_quantity=0.125 if c2_non_standard_unit==6 & item_code==60
replace c4_standard_unit=1 if c2_non_standard_unit==6 & item_code==60
	  
** 1 BUNCH/HEAP = 900 g
replace a3_standard_quantity=0.9  if a2_non_standard_unit==11 & item_code==60
replace a4_standard_unitt=1 if a2_non_standard_unit==11 & item_code==60

replace b3_standard_quantity=0.9  if b2_non_standard_unit==11 & item_code==60
replace b4_standard_unit=1  if b2_non_standard_unit==11 & item_code==60

replace c3_standard_quantity=0.9   if c2_non_standard_unit==11 & item_code==60
replace c4_standard_unit=1 if c2_non_standard_unit==11 & item_code==60





***************************
** 22-Smoked Bonga  (70)               OK
***************************	
	    
** 1 PIECE/NUMBER = ?? Kg 
replace a3_standard_quantity=0.2 if a2_non_standard_unit==6 & item_code==70
replace a4_standard_unitt=1 if a2_non_standard_unit==6 & item_code==70

replace b3_standard_quantity=0.2 if b2_non_standard_unit==6 & item_code==70
replace b4_standard_unit=1  if b2_non_standard_unit==6 & item_code==70

replace c3_standard_quantity=0.2 if c2_non_standard_unit==6 & item_code==70
replace c4_standard_unit=1 if c2_non_standard_unit==6 & item_code==70
	  
** BUNCH/HEAP = 450 g
replace a3_standard_quantity=0.45  if a2_non_standard_unit==11 & item_code==70
replace a4_standard_unitt=1 if a2_non_standard_unit==11 & item_code==70

replace b3_standard_quantity=0.45  if b2_non_standard_unit==11 & item_code==70
replace b4_standard_unit=1  if b2_non_standard_unit==11 & item_code==70

replace c3_standard_quantity=0.45   if c2_non_standard_unit==11 & item_code==70
replace c4_standard_unit=1 if c2_non_standard_unit==11 & item_code==70





***************************
** 23-Pumpkin  (157)       ++++++++
***************************	           
** 1 PIECE/NUMBER = ?? Kg ----- 1kg
replace a3_standard_quantity=1 if a2_non_standard_unit==6 & item_code==157
replace a4_standard_unitt=1 if a2_non_standard_unit==6 & item_code==157

replace b3_standard_quantity=1 if b2_non_standard_unit==6 & item_code==157
replace b4_standard_unit=1  if b2_non_standard_unit==6 & item_code==157

replace c3_standard_quantity=1 if c2_non_standard_unit==6 & item_code==157
replace c4_standard_unit=1 if c2_non_standard_unit==6 & item_code==157

** 1 BUNCH/HEAP = ?? Kg

** OTHER (specify): 
*    - 1 Cut  = ?? Kg ------ 100 grams
*    - 1 whole  = ?? Kg ------ 1kg
*    - 1 SLICE  == ?? Kg ----- 100 grams



***************************
** 24-Jumbo  (194)         +++++++
***************************
** No observations in the 2020 prices data. We should input this.



***************************
** 25-Bitter Tomato  (154)    OK
***************************	
** 1 KILOGRAMS = 1 Kg    
        
** 1 PIECE/NUMBER = ?? Kg :: 100 g
replace a3_standard_quantity=0.1  if a2_non_standard_unit==6 & item_code==154
replace a4_standard_unitt=1 if a2_non_standard_unit==6 & item_code==154

replace b3_standard_quantity=0.1  if b2_non_standard_unit==6 & item_code==154
replace b4_standard_unit=1  if b2_non_standard_unit==6 & item_code==154

replace c3_standard_quantity=0.1   if c2_non_standard_unit==6 & item_code==154
replace c4_standard_unit=1 if c2_non_standard_unit==6 & item_code==154

** 1 BUNCH/HEAP = ?? Kg :: 200 g
replace a3_standard_quantity=0.4  if a2_non_standard_unit==11 & item_code==154
replace a4_standard_unitt=1 if a2_non_standard_unit==11 & item_code==154

replace b3_standard_quantity=0.4  if b2_non_standard_unit==11 & item_code==154
replace b4_standard_unit=1  if b2_non_standard_unit==11 & item_code==154

replace c3_standard_quantity=0.4   if c2_non_standard_unit==11 & item_code==154
replace c4_standard_unit=1 if c2_non_standard_unit==11 & item_code==154


***************************
** 26-Big Red Pepper  (158)   OK
***************************			 
** 1 KILOGRAMS = 1 Kg  
           
** 1 PIECE/NUMBER = ?? Kg ---- 50 grams
replace a3_standard_quantity=0.05  if a2_non_standard_unit==6 & item_code==158
replace a4_standard_unitt=1 if a2_non_standard_unit==6 & item_code==158

replace b3_standard_quantity=0.05 if b2_non_standard_unit==6 & item_code==158
replace b4_standard_unit=1  if b2_non_standard_unit==6 & item_code==158

replace c3_standard_quantity=0.05  if c2_non_standard_unit==6 & item_code==158
replace c4_standard_unit=1 if c2_non_standard_unit==6 & item_code==158


** 1 BUNCH/HEAP = ?? Kg ---- 300 grams
replace a3_standard_quantity=0.3  if a2_non_standard_unit==11 & item_code==158
replace a4_standard_unitt=1 if a2_non_standard_unit==11 & item_code==158

replace b3_standard_quantity=0.3  if b2_non_standard_unit==11 & item_code==158
replace b4_standard_unit=1  if b2_non_standard_unit==11 & item_code==158

replace c3_standard_quantity=0.3   if c2_non_standard_unit==11 & item_code==158
replace c4_standard_unit=1 if c2_non_standard_unit==11 & item_code==158

** 1 MEDIUM TOMATO CUP = ?? Kg ------- 0.50 kg
replace a3_standard_quantity= 0.50  if a2_non_standard_unit==8 & item_code==158
replace a4_standard_unitt=1 if a2_non_standard_unit==8 & item_code==158

replace b3_standard_quantity= 0.50  if b2_non_standard_unit==8 & item_code==158
replace b4_standard_unit=1  if b2_non_standard_unit==8 & item_code==158

replace c3_standard_quantity= 0.50 if c2_non_standard_unit==8 & item_code==158
replace c4_standard_unit=1 if c2_non_standard_unit==8 & item_code==158

** 1 BIG TOMATO CUP = ?? Kg  ------- 1kg
replace a3_standard_quantity=1  if a2_non_standard_unit==9 & item_code==158
replace a4_standard_unitt=1 if a2_non_standard_unit==9 & item_code==158

replace b3_standard_quantity=1 if b2_non_standard_unit==9 & item_code==158
replace b4_standard_unit=1  if b2_non_standard_unit==9 & item_code==158

replace c3_standard_quantity=1  if c2_non_standard_unit==9 & item_code==158
replace c4_standard_unit=1 if c2_non_standard_unit==9 & item_code==158



***************************
** 27-Sour cow milk  (85)        OK
***************************	
** LITRES (l) = 1 L         
   
** CUP (standard rice cup) = ?? L ---- 0.25L
replace a3_standard_quantity=0.25  if a2_non_standard_unit==10 & item_code==85
replace a4_standard_unitt=3 if a2_non_standard_unit==10 & item_code==85

replace b3_standard_quantity=0.25 if b2_non_standard_unit==10 & item_code==85
replace b4_standard_unit=3  if b2_non_standard_unit==10 & item_code==85

replace c3_standard_quantity=0.25 if c2_non_standard_unit==10 & item_code==85
replace c4_standard_unit=3 if c2_non_standard_unit==10 & item_code==85

** OTHER (specify): 
*    - 1 5 litters galon  = ?? Kg ---- 5 liters
replace a3_standard_quantity=5  if a2_non_standard_unit==99 & item_code==85
replace a4_standard_unit=1  if a2_non_standard_unit==99 & item_code==85

replace b3_standard_quantity=5  if b2_non_standard_unit==99 & item_code==85
replace b4_standard_unit=1  if b2_non_standard_unit==99 & item_code==85

replace c3_standard_quantity=5  if c2_non_standard_unit==99 & item_code==85
replace c4_standard_unit=1 if c2_non_standard_unit==99 & item_code==85


***************************
** 28-Garden Eggs  (155)      OK
***************************	
** 1 KILOGRAMS = 1 Kg   
          
** 1 PIECE/NUMBER = ?? Kg  :: 0.5
replace a3_standard_quantity=0.5  if a2_non_standard_unit==6 & item_code==155
replace a4_standard_unitt=1 if a2_non_standard_unit==6 & item_code==155

replace b3_standard_quantity=0.5  if b2_non_standard_unit==6 & item_code==155
replace b4_standard_unit=1  if b2_non_standard_unit==6 & item_code==155

replace c3_standard_quantity=0.5   if c2_non_standard_unit==6 & item_code==155
replace c4_standard_unit=1 if c2_non_standard_unit==6 & item_code==155

** 1 BUNCH/HEAP = ?? Kg    :: 0.50
replace a3_standard_quantity=0.5  if a2_non_standard_unit==11 & item_code==155
replace a4_standard_unitt=1 if a2_non_standard_unit==11 & item_code==155

replace b3_standard_quantity=0.5  if b2_non_standard_unit==11 & item_code==155
replace b4_standard_unit=1  if b2_non_standard_unit==11 & item_code==155

replace c3_standard_quantity=0.5   if c2_non_standard_unit==11 & item_code==155
replace c4_standard_unit=1 if c2_non_standard_unit==11 & item_code==155




**********************************
** 29-Raw Groundnut Powder  (139)     OK
**********************************			        
** 1 SMALL TOMATO CUP = ?? Kg	---- 0.25 kg
replace a3_standard_quantity=0.25  if a2_non_standard_unit==7 & item_code==139
replace a4_standard_unitt=1 if a2_non_standard_unit==7 & item_code==139

replace b3_standard_quantity=0.25 if b2_non_standard_unit==7 & item_code==139
replace b4_standard_unit=1  if b2_non_standard_unit==7 & item_code==139

replace c3_standard_quantity=0.25  if c2_non_standard_unit==7 & item_code==139
replace c4_standard_unit=1 if c2_non_standard_unit==7 & item_code==139

** 1 MEDIUM TOMATO CUP = ?? Kg  ------- 0.50 kg
replace a3_standard_quantity= 0.50  if a2_non_standard_unit==8 & item_code==139
replace a4_standard_unitt=1 if a2_non_standard_unit==8 & item_code==139

replace b3_standard_quantity= 0.50  if b2_non_standard_unit==8 & item_code==139
replace b4_standard_unit=1  if b2_non_standard_unit==8 & item_code==139

replace c3_standard_quantity= 0.50 if c2_non_standard_unit==8 & item_code==139
replace c4_standard_unit=1 if c2_non_standard_unit==8 & item_code==139

** 1 BUNCH/HEAP = ?? Kg


***************************
** 30-Sorrel(Bisap)  (146)  OK
***************************	
** 1 BUNCH/HEAP = ?? Kg ------ 200grams
replace a3_standard_quantity=0.2 if a2_non_standard_unit==11 & item_code==155
replace a4_standard_unitt=1 if a2_non_standard_unit==11 & item_code==155

replace b3_standard_quantity=0.2 if b2_non_standard_unit==11 & item_code==155
replace b4_standard_unit=1  if b2_non_standard_unit==11 & item_code==155

replace c3_standard_quantity=0.2 if c2_non_standard_unit==11 & item_code==155
replace c4_standard_unit=1 if c2_non_standard_unit==11 & item_code==155


***************************
**  31-Bread (Senfurr) (17)  OK
***************************
** 1 PIECE/NUMBER = ?? Kg ---- 400 grams
replace a3_standard_quantity=0.4  if a2_non_standard_unit==6 & item_code==17
replace a4_standard_unitt=1 if a2_non_standard_unit==6 & item_code==17

replace b3_standard_quantity=0.4  if b2_non_standard_unit==6 & item_code==17
replace b4_standard_unit=1  if b2_non_standard_unit==6 & item_code==17

replace c3_standard_quantity=0.4   if c2_non_standard_unit==6 & item_code==17
replace c4_standard_unit=1 if c2_non_standard_unit==6 & item_code==17


***************************
**  32-Tomatoes-Fresh (153)   OK 
***************************
** 1 KILOGRAMS = 1 Kg  
           
** 1 BUNCH/HEAP = ?? Kg :: 0.2
replace a3_standard_quantity=0.2  if a2_non_standard_unit==11 & item_code==153
replace a4_standard_unitt=1 if a2_non_standard_unit==11 & item_code==153

replace b3_standard_quantity=0.2  if b2_non_standard_unit==11 & item_code==153
replace b4_standard_unit=1  if b2_non_standard_unit==11 & item_code==153

replace c3_standard_quantity=0.2   if c2_non_standard_unit==11 & item_code==153
replace c4_standard_unit=1 if c2_non_standard_unit==11 & item_code==153



***************************
**  33-Fresh Cow Milk (84)   OK
***************************	
** LITRES (l) = 1 L    
        
** CUP (standard rice cup) =  ?? L ---- 0.25L
replace a3_standard_quantity=0.25  if a2_non_standard_unit==10 & item_code==84
replace a4_standard_unitt=3 if a2_non_standard_unit==10 & item_code==84

replace b3_standard_quantity=0.25 if b2_non_standard_unit==10 & item_code==84
replace b4_standard_unit=3  if b2_non_standard_unit==10 & item_code==84

replace c3_standard_quantity=0.25 if c2_non_standard_unit==10 & item_code==84
replace c4_standard_unit=3 if c2_non_standard_unit==10 & item_code==84

** 1 BOTTLE.= ?? L  ---- 1 liter
replace a3_standard_quantity=1 if a2_non_standard_unit==13 & item_code==84
replace a4_standard_unitt=3 if a2_non_standard_unit==13 & item_code==84

replace b3_standard_quantity=1 if b2_non_standard_unit==13 & item_code==84
replace b4_standard_unit=3  if b2_non_standard_unit==13 & item_code==84

replace c3_standard_quantity=1 if c2_non_standard_unit==13 & item_code==84
replace c4_standard_unit=3 if c2_non_standard_unit==13 & item_code==84

** OTHER (specify): 
*    - 1 5 litter gallon  = ?? Kg
replace c3_standard_quantity=5   if c2_non_standard_unit==99 & item_code==84 & !(inlist(c22_non_standard_unit,"SCOOB","scoop"))
replace c4_standard_unit=3 if c2_non_standard_unit==99 & item_code==84 & !(inlist(c22_non_standard_unit,"SCOOB","scoop"))



***************************
**  34-Beef Without bones (49)  OK
***************************
** 1 KILOGRAMS = 1 Kg 




***************************
**  35-Milk sacket (94)           OK
***************************
** 1 PACKET = ?? L or ?? Kg ----- 20grams
replace a3_standard_quantity=0.014  if a2_non_standard_unit==5 & item_code==94 & a5_price < 10
replace a3_standard_quantity=0.016  if a2_non_standard_unit==5 & item_code==94 & a5_price == 10
replace a4_standard_unitt=1 if a2_non_standard_unit==5 & item_code==94

replace b3_standard_quantity=0.014  if b2_non_standard_unit==5 & item_code==94 & b5_price < 10
replace b3_standard_quantity=0.016  if b2_non_standard_unit==5 & item_code==94 & b5_price == 10
replace b4_standard_unit=1  if b2_non_standard_unit==5 & item_code==94

replace c3_standard_quantity=0.014   if c2_non_standard_unit==5 & item_code==94 & c5_price < 10 
replace c3_standard_quantity=0.016   if c2_non_standard_unit==5 & item_code==94 & c5_price == 10 
replace c4_standard_unit=1 if c2_non_standard_unit==5 & item_code==94


***************************
**  36-Goat meat (mutton) (48)   OK
***************************
** 1 KILOGRAMS = 1 Kg 
** 1 GRAMS (g) = 0.001 Kg



***************************
**  37-Cabbages (143)               OK
***************************
** 1 KILOGRAMS = 1 Kg 

** 1 PIECE/NUMBER = ?? Kg    ---- 600 grams
replace a3_standard_quantity=0.6  if a2_non_standard_unit==6 & item_code==143
replace a4_standard_unitt=1 if a2_non_standard_unit==6 & item_code==143

replace b3_standard_quantity=0.6  if b2_non_standard_unit==6 & item_code==143
replace b4_standard_unit=1  if b2_non_standard_unit==6 & item_code==143

replace c3_standard_quantity=0.6   if c2_non_standard_unit==6 & item_code==143
replace c4_standard_unit=1 if c2_non_standard_unit==6 & item_code==143



***************************
**  38-Irish Potato (168)      OK
***************************
** 1 KILOGRAMS = 1 Kg 
** 1 50 KG BAG  = 50 Kg

** 1 PIECE/NUMBER = ?? Kg---- 100 grams
replace a3_standard_quantity=0.1  if a2_non_standard_unit==6 & item_code==168
replace a4_standard_unitt=1 if a2_non_standard_unit==6 & item_code==168

replace b3_standard_quantity=0.1  if b2_non_standard_unit==6 & item_code==168
replace b4_standard_unit=1  if b2_non_standard_unit==6 & item_code==168

replace c3_standard_quantity=0.1  if c2_non_standard_unit==6 & item_code==168
replace c4_standard_unit=1 if c2_non_standard_unit==6 & item_code==168

** 1 BUNCH/HEAP = ?? Kg----- 500 grams
replace a3_standard_quantity=0.5  if a2_non_standard_unit==11 & item_code==168
replace a4_standard_unitt=1 if a2_non_standard_unit==11 & item_code==168

replace b3_standard_quantity=0.5  if b2_non_standard_unit==11 & item_code==168
replace b4_standard_unit=1  if b2_non_standard_unit==11 & item_code==168

replace c3_standard_quantity=0.5  if c2_non_standard_unit==11 & item_code==168
replace c4_standard_unit=1 if c2_non_standard_unit==11 & item_code==168


***********************************
**  39-Black Pepper (Whole Seed) (237)  OK
***********************************
** 1 KILOGRAMS = 1 Kg 

** 1 PIECE/NUMBER = ?? Kg------ 25grams
replace a3_standard_quantity=0.025  if a2_non_standard_unit==6 & item_code==237
replace a4_standard_unitt=1 if a2_non_standard_unit==6 & item_code==237

replace b3_standard_quantity=0.025  if b2_non_standard_unit==6 & item_code==237
replace b4_standard_unit=1  if b2_non_standard_unit==6 & item_code==237

replace c3_standard_quantity=0.025  if c2_non_standard_unit==6 & item_code==237
replace c4_standard_unit=1 if c2_non_standard_unit==6 & item_code==237

** 1 PACKET = ?? Kg----- 50 grams
replace a3_standard_quantity=0.05  if a2_non_standard_unit==5 & item_code==237
replace a4_standard_unitt=1 if a2_non_standard_unit==5 & item_code==237

replace b3_standard_quantity=0.05  if b2_non_standard_unit==5 & item_code==237
replace b4_standard_unit=1  if b2_non_standard_unit==5 & item_code==237

replace c3_standard_quantity=0.05   if c2_non_standard_unit==5 & item_code==237
replace c4_standard_unit=1 if c2_non_standard_unit==5 & item_code==237


***************************
**  40-Maize Flour (11)    OK
***************************
** 1 KILOGRAMS = 1 Kg 
** 1 50 KG BAG  = 50 Kg

** 1 SMALL TOMATO CUP = ?? Kg ---- 0.25 kg
replace a3_standard_quantity=0.25  if a2_non_standard_unit==7 & item_code==11
replace a4_standard_unitt=1 if a2_non_standard_unit==7 & item_code==11

replace b3_standard_quantity=0.25 if b2_non_standard_unit==7 & item_code==11
replace b4_standard_unit=1  if b2_non_standard_unit==7 & item_code==11

replace c3_standard_quantity=0.25  if c2_non_standard_unit==7 & item_code==11
replace c4_standard_unit=1 if c2_non_standard_unit==7 & item_code==11

** 1 MEDIUM TOMATO CUP = ?? Kg ----- 0.50 kg
replace a3_standard_quantity= 0.50  if a2_non_standard_unit==8 & item_code==11
replace a4_standard_unitt=1 if a2_non_standard_unit==8 & item_code==11

replace b3_standard_quantity= 0.50  if b2_non_standard_unit==8 & item_code==11
replace b4_standard_unit=1  if b2_non_standard_unit==8 & item_code==11

replace c3_standard_quantity= 0.50 if c2_non_standard_unit==8 & item_code==11
replace c4_standard_unit=1 if c2_non_standard_unit==8 & item_code==11

** 1 BIG TOMATO CUP = ?? Kg ------- 1kg
replace a3_standard_quantity=1  if a2_non_standard_unit==9 & item_code==11
replace a4_standard_unitt=1 if a2_non_standard_unit==9 & item_code==11

replace b3_standard_quantity=1 if b2_non_standard_unit==9 & item_code==11
replace b4_standard_unit=1  if b2_non_standard_unit==9 & item_code==11

replace c3_standard_quantity=1  if c2_non_standard_unit==9 & item_code==11
replace c4_standard_unit=1 if c2_non_standard_unit==9 & item_code==11



***************************
**  41-Evaporated Milk (92)   OK
***************************
** 1 TIN = ?? Kg  -------- 160ml when price <40 ---- 368ml when price >=40
replace a3_standard_quantity=0.16 if a2_non_standard_unit==12 & item_code==92 & a5_price <40 
replace a3_standard_quantity=0.386 if a2_non_standard_unit==12 & item_code==92 & a5_price >= 40 
replace a4_standard_unitt=1 if a2_non_standard_unit==12 & item_code==92

replace b3_standard_quantity=0.16 if b2_non_standard_unit==12 & item_code==92 & b5_price <40
replace b3_standard_quantity=0.386  if b2_non_standard_unit==12 & item_code==92 & b5_price >= 40  
replace b4_standard_unit=1  if b2_non_standard_unit==12 & item_code==92

replace c3_standard_quantity=0.16 if c2_non_standard_unit==12 & item_code==92 & c5_price <40 
replace c3_standard_quantity=0.386 if c2_non_standard_unit==12 & item_code==92 & c5_price >= 40 
replace c4_standard_unit=1 if c2_non_standard_unit==12 & item_code==92


***************************
**  42-Spaghetti (25)        OK
***************************
** 1 PACKET = ?? Kg ---- 500 grams
replace a3_standard_quantity=0.5  if a2_non_standard_unit==5 & item_code==25
replace a4_standard_unitt=1 if a2_non_standard_unit==5 & item_code==25

replace b3_standard_quantity=0.5  if b2_non_standard_unit==5 & item_code==25
replace b4_standard_unit=1  if b2_non_standard_unit==5 & item_code==25

replace c3_standard_quantity=0.5   if c2_non_standard_unit==5 & item_code==25
replace c4_standard_unit=1 if c2_non_standard_unit==5 & item_code==25


************************************
**  43-Fresh Grouper/Lady Fish (61)      OK
************************************
** 1 KILOGRAMS = 1 Kg 

** 1 PIECE/NUMBER = ?? Kg ----- 0.25 kg
replace a3_standard_quantity=0.25  if a2_non_standard_unit==6 & item_code==61
replace a4_standard_unitt=1 if a2_non_standard_unit==6 & item_code==61

replace b3_standard_quantity=0.25  if b2_non_standard_unit==6 & item_code==61
replace b4_standard_unit=1  if b2_non_standard_unit==6 & item_code==61

replace c3_standard_quantity=0.25  if c2_non_standard_unit==6 & item_code==61
replace c4_standard_unit=1 if c2_non_standard_unit==6 & item_code==61

** 1 BUNCH/HEAP = ?? Kg  ------ 1kg
replace a3_standard_quantity=1  if a2_non_standard_unit==11 & item_code==61
replace a4_standard_unitt=1 if a2_non_standard_unit==11 & item_code==61

replace b3_standard_quantity=1  if b2_non_standard_unit==11 & item_code==61
replace b4_standard_unit=1  if b2_non_standard_unit==11 & item_code==61

replace c3_standard_quantity=1  if c2_non_standard_unit==11 & item_code==61
replace c4_standard_unit=1 if c2_non_standard_unit==11 & item_code==61


*****************************
**  44-Salt sold loose (226)   OK
*****************************
** 1 PACKET = ?? Kg---- 100 grams
replace a3_standard_quantity=0.1  if a2_non_standard_unit==5 & item_code==226
replace a4_standard_unitt=1 if a2_non_standard_unit==5 & item_code==226

replace b3_standard_quantity=0.1  if b2_non_standard_unit==5 & item_code==226
replace b4_standard_unit=1  if b2_non_standard_unit==5 & item_code==226

replace c3_standard_quantity=0.1   if c2_non_standard_unit==5 & item_code==226
replace c4_standard_unit=1 if c2_non_standard_unit==5 & item_code==226

** 1 SMALL TOMATO CUP = ?? Kg ---- 0.25kg
replace a3_standard_quantity=0.25  if a2_non_standard_unit==7 & item_code==226
replace a4_standard_unitt=1 if a2_non_standard_unit==7 & item_code==226

replace b3_standard_quantity=0.25 if b2_non_standard_unit==7 & item_code==226
replace b4_standard_unit=1  if b2_non_standard_unit==7 & item_code==226

replace c3_standard_quantity=0.25  if c2_non_standard_unit==7 & item_code==226
replace c4_standard_unit=1 if c2_non_standard_unit==7 & item_code==226

** 1 MEDIUM TOMATO CUP = ?? Kg ------ 0.50 kg
replace a3_standard_quantity= 0.50  if a2_non_standard_unit==8 & item_code==226
replace a4_standard_unitt=1 if a2_non_standard_unit==8 & item_code==226

replace b3_standard_quantity= 0.50  if b2_non_standard_unit==8 & item_code==226
replace b4_standard_unit=1  if b2_non_standard_unit==8 & item_code==226

replace c3_standard_quantity= 0.50 if c2_non_standard_unit==8 & item_code==226
replace c4_standard_unit=1 if c2_non_standard_unit==8 & item_code==226

** 1 BIG TOMATO CUP = ?? Kg   ---- 1kg
replace a3_standard_quantity=1  if a2_non_standard_unit==9 & item_code==226
replace a4_standard_unitt=1 if a2_non_standard_unit==9 & item_code==226

replace b3_standard_quantity=1 if b2_non_standard_unit==9 & item_code==226
replace b4_standard_unit=1  if b2_non_standard_unit==9 & item_code==226

replace c3_standard_quantity=1  if c2_non_standard_unit==9 & item_code==226
replace c4_standard_unit=1 if c2_non_standard_unit==9 & item_code==226


***************************
**  45-Dried fish (69)        OK
***************************
** 1 PIECE/NUMBER = ?? Kg---- 150 grams
replace a3_standard_quantity=0.15  if a2_non_standard_unit==6 & item_code==69
replace a4_standard_unitt=1 if a2_non_standard_unit==6 & item_code==69

replace b3_standard_quantity=0.15  if b2_non_standard_unit==6 & item_code==69
replace b4_standard_unit=1  if b2_non_standard_unit==6 & item_code==69

replace c3_standard_quantity=0.15 if c2_non_standard_unit==6 & item_code==69
replace c4_standard_unit=1 if c2_non_standard_unit==6 & item_code==69

** 1 BUNCH/HEAP = ?? Kg ----- 500grams
replace a3_standard_quantity=0.5  if a2_non_standard_unit==11 & item_code==69
replace a4_standard_unitt=1 if a2_non_standard_unit==11 & item_code==69

replace b3_standard_quantity=0.5   if b2_non_standard_unit==11 & item_code==69
replace b4_standard_unit=1  if b2_non_standard_unit==11 & item_code==69

replace c3_standard_quantity=0.5   if c2_non_standard_unit==11 & item_code==69
replace c4_standard_unit=1 if c2_non_standard_unit==11 & item_code==69


***************************
**  46-Chicken(Local) (45)     OK
***************************
** 1 PIECE/NUMBER = ?? Kg---- 1000 grams
replace a3_standard_quantity=1  if a2_non_standard_unit==6 & item_code==45
replace a4_standard_unitt=1 if a2_non_standard_unit==6 & item_code==45

replace b3_standard_quantity=1  if b2_non_standard_unit==6 & item_code==45
replace b4_standard_unit=1  if b2_non_standard_unit==6 & item_code==45

replace c3_standard_quantity=1 if c2_non_standard_unit==6 & item_code==45
replace c4_standard_unit=1 if c2_non_standard_unit==6 & item_code==45


***************************
**  47-Onion Leaves (149)    OK
***************************
** 1 KILOGRAMS = 1 Kg
** 1 LITRES (l) = 1 L
** 1 50 KG BAG = 50 Kg 

** 1 PIECE/NUMBER = ?? Kg----- 25 grams
replace a3_standard_quantity=0.025  if a2_non_standard_unit==6 & item_code==149
replace a4_standard_unitt=1 if a2_non_standard_unit==6 & item_code==149

replace b3_standard_quantity=0.025  if b2_non_standard_unit==6 & item_code==149
replace b4_standard_unit=1  if b2_non_standard_unit==6 & item_code==149

replace c3_standard_quantity=0.025  if c2_non_standard_unit==6 & item_code==149
replace c4_standard_unit=1 if c2_non_standard_unit==6 & item_code==149

** 1 BUNCH/HEAP = ?? Kg-------- 100 grams
replace a3_standard_quantity=0.1 if a2_non_standard_unit==11 & item_code==149
replace a4_standard_unitt=1 if a2_non_standard_unit==11 & item_code==149

replace b3_standard_quantity=0.1 if b2_non_standard_unit==11 & item_code==149
replace b4_standard_unit=1  if b2_non_standard_unit==11 & item_code==149

replace c3_standard_quantity=0.1 if c2_non_standard_unit==11 & item_code==149
replace c4_standard_unit=1 if c2_non_standard_unit==11 & item_code==149



*******************************
**  48-Small Pepper-Fresh (152)   OK
*******************************
** 1 BUNCH/HEAP = ?? Kg--- 50 grams
replace a3_standard_quantity=0.05 if a2_non_standard_unit==11 & item_code==152
replace a4_standard_unitt=1 if a2_non_standard_unit==11 & item_code==152

replace b3_standard_quantity=0.05 if b2_non_standard_unit==11 & item_code==152
replace b4_standard_unit=1  if b2_non_standard_unit==11 & item_code==152

replace c3_standard_quantity=0.05 if c2_non_standard_unit==11 & item_code==152
replace c4_standard_unit=1 if c2_non_standard_unit==11 & item_code==152

** CUP (standard rice cup) =  ?? Kg ---- 0.25kg
replace a3_standard_quantity=0.25  if a2_non_standard_unit==10 & item_code==152
replace a4_standard_unitt=3 if a2_non_standard_unit==10 & item_code==152

replace b3_standard_quantity=0.25 if b2_non_standard_unit==10 & item_code==152
replace b4_standard_unit=3  if b2_non_standard_unit==10 & item_code==152

replace c3_standard_quantity=0.25 if c2_non_standard_unit==10 & item_code==152
replace c4_standard_unit=3 if c2_non_standard_unit==10 & item_code==152

** 1 SMALL TOMATO CUP = ?? Kg ----- 0.25kg
replace a3_standard_quantity=0.25  if a2_non_standard_unit==7 & item_code==152
replace a4_standard_unitt=1 if a2_non_standard_unit==7 & item_code==152

replace b3_standard_quantity=0.25 if b2_non_standard_unit==7 & item_code==152
replace b4_standard_unit=1  if b2_non_standard_unit==7 & item_code==152

replace c3_standard_quantity=0.25  if c2_non_standard_unit==7 & item_code==152
replace c4_standard_unit=1 if c2_non_standard_unit==7 & item_code==152

** 1 MEDIUM TOMATO CUP = ?? Kg ------ 0.50kg
replace a3_standard_quantity= 0.50  if a2_non_standard_unit==8 & item_code==152
replace a4_standard_unitt=1 if a2_non_standard_unit==8 & item_code==152

replace b3_standard_quantity= 0.50  if b2_non_standard_unit==8 & item_code==152
replace b4_standard_unit=1  if b2_non_standard_unit==8 & item_code==152

replace c3_standard_quantity= 0.50 if c2_non_standard_unit==8 & item_code==152
replace c4_standard_unit=1 if c2_non_standard_unit==8 & item_code==152

** 1 BIG TOMATO CUP = ?? Kg ------- 1kg
replace a3_standard_quantity=1  if a2_non_standard_unit==9 & item_code==152
replace a4_standard_unitt=1 if a2_non_standard_unit==9 & item_code==152

replace b3_standard_quantity=1 if b2_non_standard_unit==9 & item_code==152
replace b4_standard_unit=1  if b2_non_standard_unit==9 & item_code==152

replace c3_standard_quantity=1  if c2_non_standard_unit==9 & item_code==152
replace c4_standard_unit=1 if c2_non_standard_unit==9 & item_code==152




***************************
**  49-Mayonnaise (230)       OK
***************************
** 1 TIN = ?? Kg -- when price <100 = 500ml
replace a3_standard_quantity=0.5 if a2_non_standard_unit==12 & item_code==230
replace a4_standard_unitt=3 if a2_non_standard_unit==12 & item_code==230

replace b3_standard_quantity=0.5 if b2_non_standard_unit==12 & item_code==230
replace b4_standard_unit=3  if b2_non_standard_unit==12 & item_code==230

replace c3_standard_quantity=0.5 if c2_non_standard_unit==12 & item_code==230
replace c4_standard_unit=3 if c2_non_standard_unit==12 & item_code==230

** 1 PIECE/NUMBER = ?? Kg ----  5grams
replace a3_standard_quantity=0.005  if a2_non_standard_unit==6 & item_code==230
replace a4_standard_unitt=1 if a2_non_standard_unit==6 & item_code==230

replace b3_standard_quantity=0.005  if b2_non_standard_unit==6 & item_code==230
replace b4_standard_unit=1  if b2_non_standard_unit==6 & item_code==230

replace c3_standard_quantity=0.005  if c2_non_standard_unit==6 & item_code==230
replace c4_standard_unit=1 if c2_non_standard_unit==6 & item_code==230

** 1 BOTTLE. = ?? Kg ------   = 1L
replace a3_standard_quantity=1 if a2_non_standard_unit==13 & item_code==230
replace a4_standard_unitt=3 if a2_non_standard_unit==13 & item_code==230

replace b3_standard_quantity=1 if b2_non_standard_unit==13 & item_code==230
replace b4_standard_unit=3  if b2_non_standard_unit==13 & item_code==230

replace c3_standard_quantity=1 if c2_non_standard_unit==13 & item_code==230
replace c4_standard_unit=3 if c2_non_standard_unit==13 & item_code==230



*********************************
**  50-Chicken whole, frozen (50)  OK
*********************************
** 1 KILOGRAMS = 1 Kg

** 1 PACKET = ?? Kg-------   = 1200 grams
replace a3_standard_quantity=1.2  if a2_non_standard_unit==5 & item_code==50
replace a4_standard_unitt=1 if a2_non_standard_unit==5 & item_code==50

replace b3_standard_quantity=1.2  if b2_non_standard_unit==5 & item_code==50
replace b4_standard_unit=1  if b2_non_standard_unit==5 & item_code==50

replace c3_standard_quantity=1.2   if c2_non_standard_unit==5 & item_code==50
replace c4_standard_unit=1 if c2_non_standard_unit==5 & item_code==50


** 1 PIECE/NUMBER = ?? Kg-------   = 1200 grams
replace a3_standard_quantity=1.2  if a2_non_standard_unit==6 & item_code==50
replace a4_standard_unitt=1 if a2_non_standard_unit==6 & item_code==50

replace b3_standard_quantity=1.2  if b2_non_standard_unit==6 & item_code==50
replace b4_standard_unit=1  if b2_non_standard_unit==6 & item_code==50

replace c3_standard_quantity=1.2  if c2_non_standard_unit==6 & item_code==50
replace c4_standard_unit=1 if c2_non_standard_unit==6 & item_code==50



***************************
**  51-Cassava (169)
***************************
** 1 KILOGRAMS = 1 Kg 

** 1 PIECE/NUMBER = 0.25 Kg
replace a3_standard_quantity=0.25  if a2_non_standard_unit==6 & item_code==169
replace a4_standard_unitt=1 if a2_non_standard_unit==6 & item_code==169

replace b3_standard_quantity=0.25  if b2_non_standard_unit==6 & item_code==169
replace b4_standard_unit=1  if b2_non_standard_unit==6 & item_code==169

replace c3_standard_quantity=0.25   if c2_non_standard_unit==6 & item_code==169
replace c4_standard_unit=1 if c2_non_standard_unit==6 & item_code==169

** 1 BUNCH/HEAP = 1 Kg
replace a3_standard_quantity=1  if a2_non_standard_unit==11 & item_code==169
replace a4_standard_unitt=1 if a2_non_standard_unit==11 & item_code==169

replace b3_standard_quantity=1  if b2_non_standard_unit==11 & item_code==169
replace b4_standard_unit=1  if b2_non_standard_unit==11 & item_code==169

replace c3_standard_quantity=1   if c2_non_standard_unit==11 & item_code==169
replace c4_standard_unit=1 if c2_non_standard_unit==11 & item_code==169

** 1 SMALL TOMATO CUP = ?? Kg --------- 0.25kg
replace a3_standard_quantity=0.25  if a2_non_standard_unit==7 & item_code==169
replace a4_standard_unitt=1 if a2_non_standard_unit==7 & item_code==169

replace b3_standard_quantity=0.25 if b2_non_standard_unit==7 & item_code==169
replace b4_standard_unit=1  if b2_non_standard_unit==7 & item_code==169

replace c3_standard_quantity=0.25  if c2_non_standard_unit==7 & item_code==169
replace c4_standard_unit=1 if c2_non_standard_unit==7 & item_code==169


***********************************
**  52-Locust Beans (Neteetu) (238)    OK
***********************************
** 1 TIN = ?? Kg  ---- 0.25kg
replace a3_standard_quantity=0.25 if a2_non_standard_unit==12 & item_code==238
replace a4_standard_unitt=1 if a2_non_standard_unit==12 & item_code==238

replace b3_standard_quantity=0.25 if b2_non_standard_unit==12 & item_code==238
replace b4_standard_unit=1  if b2_non_standard_unit==12 & item_code==238

replace c3_standard_quantity=0.25 if c2_non_standard_unit==12 & item_code==238
replace c4_standard_unit=1 if c2_non_standard_unit==12 & item_code==238

** 1 BUNCH/HEAP = ?? Kg ----25grams
replace a3_standard_quantity=0.025 if a2_non_standard_unit==11 & item_code==238
replace a4_standard_unitt=1 if a2_non_standard_unit==11 & item_code==238

replace b3_standard_quantity=0.025 if b2_non_standard_unit==11 & item_code==238
replace b4_standard_unit=1  if b2_non_standard_unit==11 & item_code==238

replace c3_standard_quantity=0.025 if c2_non_standard_unit==11 & item_code==238
replace c4_standard_unit=1 if c2_non_standard_unit==11 & item_code==238

** 1 SMALL TOMATO CUP = ?? Kg ------ 0.25kg
replace a3_standard_quantity=0.25  if a2_non_standard_unit==7 & item_code==238
replace a4_standard_unitt=1 if a2_non_standard_unit==7 & item_code==238

replace b3_standard_quantity=0.25 if b2_non_standard_unit==7 & item_code==238
replace b4_standard_unit=1  if b2_non_standard_unit==7 & item_code==238

replace c3_standard_quantity=0.25  if c2_non_standard_unit==7 & item_code==238
replace c4_standard_unit=1 if c2_non_standard_unit==7 & item_code==238

** 1 MEDIUM TOMATO CUP = ?? Kg ----- 0.50 kg
replace a3_standard_quantity= 0.50  if a2_non_standard_unit==8 & item_code==238
replace a4_standard_unitt=1 if a2_non_standard_unit==8 & item_code==238

replace b3_standard_quantity= 0.50  if b2_non_standard_unit==8 & item_code==238
replace b4_standard_unit=1  if b2_non_standard_unit==8 & item_code==238

replace c3_standard_quantity= 0.50 if c2_non_standard_unit==8 & item_code==238
replace c4_standard_unit=1 if c2_non_standard_unit==8 & item_code==238

** 1 BIG TOMATO CUP = ?? Kg -------- 1kg
replace a3_standard_quantity=1  if a2_non_standard_unit==9 & item_code==238
replace a4_standard_unitt=1 if a2_non_standard_unit==9 & item_code==238

replace b3_standard_quantity=1 if b2_non_standard_unit==9 & item_code==238
replace b4_standard_unit=1  if b2_non_standard_unit==9 & item_code==238

replace c3_standard_quantity=1  if c2_non_standard_unit==9 & item_code==238
replace c4_standard_unit=1 if c2_non_standard_unit==9 & item_code==238


***************************************
** 53-Sardine Tin in vegetable oil (74)   OK
***************************************
** 1 TIN = ?? Kg  ---- 125 grams
replace a3_standard_quantity=0.125 if a2_non_standard_unit==12 & item_code==74
replace a4_standard_unitt=1 if a2_non_standard_unit==12 & item_code==74

replace b3_standard_quantity=0.125 if b2_non_standard_unit==12 & item_code==74
replace b4_standard_unit=1  if b2_non_standard_unit==12 & item_code==74

replace c3_standard_quantity=0.125 if c2_non_standard_unit==12 & item_code==74
replace c4_standard_unit=1 if c2_non_standard_unit==12 & item_code==74










**********************************
** 29-Raw Groundnut Powder  (139)     OK
**********************************			        
** 1 SMALL TOMATO CUP = ?? Kg	---- 0.25 kg
replace a3_standard_quantity=0.25  if a2_non_standard_unit==7 & item_code==114
replace a4_standard_unitt=1 if a2_non_standard_unit==7 & item_code==114

replace b3_standard_quantity=0.25 if b2_non_standard_unit==7 & item_code==114
replace b4_standard_unit=1  if b2_non_standard_unit==7 & item_code==114

replace c3_standard_quantity=0.25  if c2_non_standard_unit==7 & item_code==114
replace c4_standard_unit=1 if c2_non_standard_unit==7 & item_code==114

** 1 MEDIUM TOMATO CUP = ?? Kg  ------- 0.50 kg
replace a3_standard_quantity= 0.50  if a2_non_standard_unit==8 & item_code==114
replace a4_standard_unitt=1 if a2_non_standard_unit==8 & item_code==114

replace b3_standard_quantity= 0.50  if b2_non_standard_unit==8 & item_code==114
replace b4_standard_unit=1  if b2_non_standard_unit==8 & item_code==114

replace c3_standard_quantity= 0.50 if c2_non_standard_unit==8 & item_code==114
replace c4_standard_unit=1 if c2_non_standard_unit==8 & item_code==114

** 1 BIG TOMATO CUP = ?? Kg  ------- 1 kg
replace a3_standard_quantity= 1 if a2_non_standard_unit==9 & item_code==114
replace a4_standard_unitt=1 if a2_non_standard_unit==9 & item_code==114

replace b3_standard_quantity= 1  if b2_non_standard_unit==9 & item_code==114
replace b4_standard_unit=1  if b2_non_standard_unit==9 & item_code==114

replace c3_standard_quantity= 1 if c2_non_standard_unit==9 & item_code==114
replace c4_standard_unit=1 if c2_non_standard_unit==9 & item_code==114

replace c3_standard_quantity= 50 if c3_standard_quantity==100 & item_code==114





***************************************
**  Log-Grained Rice (Local) (2)      OK       
***************************************	
** 1 KILOGRAMS = 1 Kg
** 1 50 KG BAG = 50 Kg
	   	   		   
** 1 CUP (standard rice cup) = 0.25 Kg
replace a3_standard_quantity=1/4  if a2_non_standard_unit==10 & item_code==2
replace a4_standard_unitt=1 if a2_non_standard_unit==10 & item_code==2

replace b3_standard_quantity=1/4 if b2_non_standard_unit==10 & item_code==2
replace b4_standard_unit=1  if b2_non_standard_unit==10 & item_code==2

replace c3_standard_quantity=1/4  if c2_non_standard_unit==10 & item_code==2
replace c4_standard_unit=1 if c2_non_standard_unit==10 & item_code==2

** OTHER (specify):
*    - 1 25 kg bag  = 25 Kg   
replace c3_standard_quantity=25  if c2_non_standard_unit==99 & item_code==2
replace c4_standard_unit=1 if c2_non_standard_unit==99 & item_code==2
//all the OTHER (specify) are 25 kg bag and are present just in the c colon




***************************
** Corn Flakes  (21)
***************************         
            
** PACKET
replace a3_standard_quantity=0.35  if a2_non_standard_unit==5 & item_code==21
replace a4_standard_unitt=1 if a2_non_standard_unit==5 & item_code==21

replace b3_standard_quantity=0.35 if b2_non_standard_unit==5 & item_code==21
replace b4_standard_unit=1  if b2_non_standard_unit==5 & item_code==21

replace c3_standard_quantity=0.35  if c2_non_standard_unit==5 & item_code==21
replace c4_standard_unit=1 if c2_non_standard_unit==5 & item_code==21

** PIECE/NUMBER 


***************************
**  Oats Meal (22)
***************************
           
** PACKET
replace a3_standard_quantity=0.5  if a2_non_standard_unit==5 & item_code==22
replace a4_standard_unitt=1 if a2_non_standard_unit==5 & item_code==22

replace b3_standard_quantity=0.5 if b2_non_standard_unit==5 & item_code==22
replace b4_standard_unit=1  if b2_non_standard_unit==5 & item_code==22

replace c3_standard_quantity=0.5  if c2_non_standard_unit==5 & item_code==22
replace c4_standard_unit=1 if c2_non_standard_unit==5 & item_code==22

** PIECE/NUMBER 
** TIN


***************************
**  Short pasta(Macaroni) (24)
***************************
           
** PACKET 
replace a3_standard_quantity=0.5  if a2_non_standard_unit==5 & item_code==24
replace a4_standard_unitt=1 if a2_non_standard_unit==5 & item_code==24

replace b3_standard_quantity=0.5 if b2_non_standard_unit==5 & item_code==24
replace b4_standard_unit=1  if b2_non_standard_unit==5 & item_code==24

replace c3_standard_quantity=0.5  if c2_non_standard_unit==5 & item_code==24
replace c4_standard_unit=1 if c2_non_standard_unit==5 & item_code==24


** PIECE/NUMBER 
** TIN
	
	
***************************
**  Spaghetti (25)
***************************
       
** PACKET
replace a3_standard_quantity=0.25  if a2_non_standard_unit==5 & item_code==25
replace a4_standard_unitt=1 if a2_non_standard_unit==5 & item_code==25

replace b3_standard_quantity=0.25 if b2_non_standard_unit==5 & item_code==25
replace b4_standard_unit=1  if b2_non_standard_unit==5 & item_code==25

replace c3_standard_quantity=0.25  if c2_non_standard_unit==5 & item_code==25
replace c4_standard_unit=1 if c2_non_standard_unit==5 & item_code==25

** PIECE/NUMBER 
** TIN


***************************
**  Vermisel (26)
***************************
            
** PACKET 
replace a3_standard_quantity=0.5  if a2_non_standard_unit==5 & item_code==26
replace a4_standard_unitt=1 if a2_non_standard_unit==5 & item_code==26

replace b3_standard_quantity=0.5 if b2_non_standard_unit==5 & item_code==26
replace b4_standard_unit=1  if b2_non_standard_unit==5 & item_code==26

replace c3_standard_quantity=0.5  if c2_non_standard_unit==5 & item_code==26
replace c4_standard_unit=1 if c2_non_standard_unit==5 & item_code==26

** PIECE/NUMBER 
** CUP (standard rice cup) 
** BUNCH/HEAP
** BIG TOMATO CUP 


***************************
**  Couscous (27)
***************************
            
** PACKET 
replace a3_standard_quantity=0.5  if a2_non_standard_unit==5 & item_code==27
replace a4_standard_unitt=1 if a2_non_standard_unit==5 & item_code==27

replace b3_standard_quantity=0.5 if b2_non_standard_unit==5 & item_code==27
replace b4_standard_unit=1  if b2_non_standard_unit==5 & item_code==27

replace c3_standard_quantity=0.5  if c2_non_standard_unit==5 & item_code==27
replace c4_standard_unit=1 if c2_non_standard_unit==5 & item_code==27

** PIECE/NUMBER 


***************************
**  Instant Noodles (28)
***************************
            
** PACKET
replace a3_standard_quantity=0.5  if a2_non_standard_unit==5 & item_code==28
replace a4_standard_unitt=1 if a2_non_standard_unit==5 & item_code==28

replace b3_standard_quantity=0.5 if b2_non_standard_unit==5 & item_code==28
replace b4_standard_unit=1  if b2_non_standard_unit==5 & item_code==28

replace c3_standard_quantity=0.5  if c2_non_standard_unit==5 & item_code==28
replace c4_standard_unit=1 if c2_non_standard_unit==5 & item_code==28
** PIECE/NUMBER


***************************
**  Pop Corn (30)
***************************
           
** PACKET 
replace a3_standard_quantity=0.5  if a2_non_standard_unit==5 & item_code==30
replace a4_standard_unitt=1 if a2_non_standard_unit==5 & item_code==30

replace b3_standard_quantity=0.5 if b2_non_standard_unit==5 & item_code==30
replace b4_standard_unit=1  if b2_non_standard_unit==5 & item_code==30

replace c3_standard_quantity=0.5  if c2_non_standard_unit==5 & item_code==30
replace c4_standard_unit=1 if c2_non_standard_unit==5 & item_code==30

** BUNCH/HEAP
	
	
***************************
**  Chips (31)
***************************		  
            
** PACKET
replace a3_standard_quantity=0.141  if a2_non_standard_unit==5 & item_code==31
replace a4_standard_unitt=1 if a2_non_standard_unit==5 & item_code==31

replace b3_standard_quantity=0.141 if b2_non_standard_unit==5 & item_code==31
replace b4_standard_unit=1  if b2_non_standard_unit==5 & item_code==31

replace c3_standard_quantity=0.141  if c2_non_standard_unit==5 & item_code==31
replace c4_standard_unit=1 if c2_non_standard_unit==5 & item_code==31


** PIECE/NUMBER




**********************************
**  Chicken Wings (Imported)  (47)
***************************	******  
            
** PACKET
replace a3_standard_quantity=1  if a2_non_standard_unit==5 & item_code==47
replace a4_standard_unitt=1 if a2_non_standard_unit==5 & item_code==47

replace b3_standard_quantity=1 if b2_non_standard_unit==5 & item_code==47
replace b4_standard_unit=1  if b2_non_standard_unit==5 & item_code==47

replace c3_standard_quantity=1  if c2_non_standard_unit==5 & item_code==47
replace c4_standard_unit=1 if c2_non_standard_unit==5 & item_code==47


** BUNCH/HEAP


***************************
**  Canned Meat (55)
***************************
            
** PIECE/NUMBER
** TIN 
replace a3_standard_quantity=0.2  if a2_non_standard_unit==12 & item_code==55
replace a4_standard_unitt=1 if a2_non_standard_unit==12 & item_code==55

replace b3_standard_quantity=0.2 if b2_non_standard_unit==12 & item_code==55
replace b4_standard_unit=1  if b2_non_standard_unit==12 & item_code==55

replace c3_standard_quantity=0.2  if c2_non_standard_unit==12 & item_code==55
replace c4_standard_unit=1 if c2_non_standard_unit==12 & item_code==55

	
***************************
**  Corned beef (56)
***************************	
            
** TIN
replace a3_standard_quantity=0.34 if a2_non_standard_unit==12 & item_code==56
replace a4_standard_unitt=1 if a2_non_standard_unit==12 & item_code==56

replace b3_standard_quantity=0.34 if b2_non_standard_unit==12 & item_code==56
replace b4_standard_unit=1  if b2_non_standard_unit==12 & item_code==56

replace c3_standard_quantity=0.34  if c2_non_standard_unit==12 & item_code==56
replace c4_standard_unit=1 if c2_non_standard_unit==12 & item_code==56

** BOTTLE.
** CUP (standard rice cup) 


***************************
** sausages  (57)
***************************	
            
** PACKET
replace a3_standard_quantity=0.35 if a2_non_standard_unit==5 & item_code==57
replace a4_standard_unitt=1 if a2_non_standard_unit==5 & item_code==57

replace b3_standard_quantity=0.35 if b2_non_standard_unit==5 & item_code==57
replace b4_standard_unit=1  if b2_non_standard_unit==5 & item_code==57

replace c3_standard_quantity=0.35  if c2_non_standard_unit==5 & item_code==57
replace c4_standard_unit=1 if c2_non_standard_unit==5 & item_code==57

** PIECE/NUMBER         
** TIN 
** BOTTLE.





***************************
**  Cat Fish (60)
***************************			  
            
** PIECE/NUMBER		  
** BUNCH/HEAP	
replace a3_standard_quantity=0.9 if a2_non_standard_unit==11 & item_code==60
replace a4_standard_unitt=1 if a2_non_standard_unit==11 & item_code==60

replace b3_standard_quantity=0.9 if b2_non_standard_unit==11 & item_code==60
replace b4_standard_unit=1  if b2_non_standard_unit==11 & item_code==60

replace c3_standard_quantity=0.9  if c2_non_standard_unit==11 & item_code==60
replace c4_standard_unit=1 if c2_non_standard_unit==11 & item_code==60

 

save "$findata\PART C Market Questionnaire 2020_clean.dta",replace




**********		 
*  END
**********

	 






















