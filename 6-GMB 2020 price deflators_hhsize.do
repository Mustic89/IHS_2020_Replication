* * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* ####################################################### *
* #                                                     # *
* #           GAMBIA IHS 2020 PRICE DEFLATORS           # *
* #                                                     # *
* ####################################################### *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 

*************************************
** INITIALIZATION OF THE WORKSPACE **
*************************************
version 16

clear
set more off
cap log close

****************************
** DEFINE THE DIRECTORIES **
****************************
// change the specific file path to your IHS2020 folder here to run the dofile

*++++++++++++++++ CHANGE THIS PATH TO YOUR IHS 2020 FOLDER TO RUN ++++++++*
global path  "C:\Users\tchou\Desktop\IHS2020"
********************************************************************************

global findata     ${path}\01.Data\Stata
global othdata     ${path}\01.Data\Other
global fintab      ${path}\04.Results\output
global logs        ${path}\04.Results\logfiles
global temp        ${path}\04.Results\temp


log using "$logs\6-GMB 2020 price deflators_hhsize.log" , replace
*******************************************************************************

****************************
*** PRICE FILE PREPARATIONS
****************************
use "$findata\PART C Market Questionnaire 2020_clean.dta",clear


*lab def mois 1 "January" 2 "February" 3 "March" 4 "April" 5 "Mai" 6 "June" 7 "July" 8 "Agust"  9 "September" 10 "October" 11 "November" 12 "December"

*lab val mkt_month mois

gen s1aq1=item_code
lab val s1aq1 S1AQ1 

drop if a5_price==. & b5_price==. & c5_price==.

egen  sumprice = rowtotal(a5_price b5_price c5_price )

gen p1 = !(a5_price==.)
gen p2 = !(b5_price==.)
gen p3 = !(c5_price==.)

gen denominator = (p1 + p2 + p3)

gen price = sumprice/denominator
drop p1 p2 p3 denominator


egen sumquantity = rowtotal(a3_standard_quantity b3_standard_quantity c3_standard_quantity)
gen p1 = !(a3_standard_quantity==.)
gen p2 = !(b3_standard_quantity==.)
gen p3 = !(c3_standard_quantity==.)
gen denominator = (p1 + p2 + p3)


gen standard_quantity_m = sumquantity/denominator


drop b1_non_standard_quantity b2_non_standard_unit b3_standard_quantity b4_standard_unit c1_non_standard_quantity c2_non_standard_unit c3_standard_quantity c4_standard_unit
rename (a1_non_standard_quantity a2_non_standard_unit a3_standard_quantity a4_standard_unitt ) (non_standard_quantity non_standard_unit standard_quantity standard_unit)

drop if standard_unit ==. | non_standard_unit ==.

gen kl_quantity = standard_quantity_m            if inlist(standard_unit,1,3)
*replace kl_quantity  = standard_quantity_m/1000  if inlist(standard_unit,2,4)
label var kl_quantity "kilo-litre equivalent quantity" 

 
gen kl_uprice = .
replace kl_uprice =  price / kl_quantity
label var kl_uprice "klio-litre equivalent price" 
 

 *outlier detection - replacing prices with the national median if >2.5sd from the national mean. 

levelsof s1aq1 , local (items) 
levelsof lga, local(lga)

foreach lga of local lga{

foreach k of local items {

qui su kl_uprice if s1aq1==`k' & lga==`lga' & !mi(kl_uprice) , d

local median_`lga' = r(p50)
local mean_`lga' = r(mean)

local sd_`lga' = r(sd)

replace kl_uprice = `median_`lga''   if kl_uprice > (`mean_`lga'' + 2.5*(`sd_`lga'')) & s1aq1==`k' & !mi(kl_uprice) & lga==`lga'

}
}
 
*
collapse (mean)mean_kl_uprice=kl_uprice  (median) p50_kl_uprice=kl_uprice  (min)min_kl_uprice=kl_uprice  (max)max_kl_uprice=kl_uprice (count)N_kl_uprice=kl_uprice , by (district1 s1aq1 mkt_month)

bysort district1 s1aq1: egen median_produc=median(p50_kl_uprice)
bysort district1 s1aq1: egen mean_produc=mean(p50_kl_uprice)
bysort district1 s1aq1: egen sd_produc=sd(p50_kl_uprice)

gen score = (p50_kl_uprice-mean_produc)/sd_produc
gen score_abs = abs(score)

replace p50_kl_uprice= median_produc if score_abs>=3.5 & score_abs !=.

drop median_produc mean_produc sd_produc score score_abs

reshape wide mean_kl_uprice p50_kl_uprice min_kl_uprice max_kl_uprice N_kl_uprice  , i(district1 s1aq1) j(mkt_month)
 
ren (*e1 *e2 *3 *4 *5 *6 *7 *8 *9 *10 *11 *12 ) (*e_jan2021 *e_feb2020 *_mar2020 *_apr2020 *_may2020 *_jun2020 *_jul2020 *_aug2020 *_sep2020 *_oct2020 *_nov2020 *_dec2020)

order district1 s1aq1 *e_jan2021 *e_feb2020 *_mar2020 *_apr2020 *_may2020 *_jun2020 *_jul2020 *_aug2020 *_sep2020 *_oct2020 *_nov2020 *_dec2020

drop mean_* min_* max_* N_*

ren p50_kl_uprice_*  *


compress
saveold "$fintab\GMB IHS Price data 2020-21.dta",replace


**************************************************
*** Table 8: PRICE DEFLATORS 
**************************************************
**drop foods that calories cannot be derived as well missing prices.

use "$fintab\GMB IHS Price data 2020-21.dta",clear

foreach stats in feb mar apr may jun jul aug sep  oct nov dec {
replace `stats'2020 =. if `stats'2020==0
}
replace jan2021 =. if jan2021==0


/*
replace feb2020=41.63  if s1aq1==16
replace mar2020=41.00  if s1aq1==16
replace apr2020=40.32  if s1aq1==16
replace may2020=40.10  if s1aq1==16
replace jun2020=40.62  if s1aq1==16
replace jul2020=39.36  if s1aq1==16
replace aug2020=42.39  if s1aq1==16
replace sep2020=41.94  if s1aq1==16
replace oct2020=39.79  if s1aq1==16
replace nov2020=41.48  if s1aq1==16
replace dec2020=40.88  if s1aq1==16
replace jan2021=40.66  if s1aq1==16


replace feb2020=43.57  if s1aq1==25
replace mar2020=43.93  if s1aq1==25
replace apr2020=47.76  if s1aq1==25
replace may2020=50.37  if s1aq1==25
replace jun2020=50.02  if s1aq1==25
replace jul2020=49.65  if s1aq1==25
replace aug2020=47.45  if s1aq1==25
replace sep2020=47.99  if s1aq1==25
replace oct2020=49.05  if s1aq1==25
replace nov2020=51.36  if s1aq1==25
replace dec2020=50.86  if s1aq1==25
replace jan2021=50.90  if s1aq1==25


replace feb2020=195.76  if s1aq1==45
replace mar2020=153.70  if s1aq1==45
replace apr2020=169.39  if s1aq1==45
replace may2020=157.92  if s1aq1==45
replace jun2020=168.53  if s1aq1==45
replace jul2020=163.06  if s1aq1==45
replace aug2020=145.42  if s1aq1==45
replace sep2020=162.78  if s1aq1==45
replace oct2020=155.50  if s1aq1==45
replace nov2020=176.87  if s1aq1==45
replace dec2020=183.47  if s1aq1==45
replace jan2021=189.28  if s1aq1==45


replace feb2020=202.74  if s1aq1==94
replace mar2020=237.84  if s1aq1==94
replace apr2020=228.36  if s1aq1==94
replace may2020=210.61  if s1aq1==94
replace jun2020=200.87  if s1aq1==94
replace jul2020=200.87  if s1aq1==94
replace aug2020=202.62  if s1aq1==94
replace sep2020=202.62  if s1aq1==94
replace oct2020=202.62  if s1aq1==94
replace nov2020=200.00  if s1aq1==94
replace dec2020=201.31  if s1aq1==94
replace jan2021=200.00  if s1aq1==94


replace feb2020=43.18  if s1aq1==153
replace mar2020=35.90  if s1aq1==153
replace apr2020=47.21  if s1aq1==153
replace may2020=50.20  if s1aq1==153
replace jun2020=57.95  if s1aq1==153
replace jul2020=64.07  if s1aq1==153
replace aug2020=58.30  if s1aq1==153
replace sep2020=79.21  if s1aq1==153
replace oct2020=79.21  if s1aq1==153
replace nov2020=63.56  if s1aq1==153
replace dec2020=63.56  if s1aq1==153
replace jan2021=59.74  if s1aq1==153

    
replace feb2020=57.37  if s1aq1==154
replace mar2020=47.03  if s1aq1==154
replace apr2020=48.49  if s1aq1==154
replace may2020=44.43  if s1aq1==154
replace jun2020=46.45  if s1aq1==154
replace jul2020=51.72  if s1aq1==154
replace aug2020=53.46  if s1aq1==154
replace sep2020=49.12  if s1aq1==154
replace oct2020=49.12  if s1aq1==154
replace nov2020=54.31  if s1aq1==154
replace dec2020=54.31  if s1aq1==154
replace jan2021=45.53  if s1aq1==154


replace feb2020=33.42  if s1aq1==155
replace mar2020=33.01  if s1aq1==155
replace apr2020=33.02  if s1aq1==155
replace may2020=31.72  if s1aq1==155
replace jun2020=33.15  if s1aq1==155
replace jul2020=36.92  if s1aq1==155
replace aug2020=35.11  if s1aq1==155
replace sep2020=36.10  if s1aq1==155
replace oct2020=36.10  if s1aq1==155
replace nov2020=33.68  if s1aq1==155
replace dec2020=33.68  if s1aq1==155
replace jan2021=35.18  if s1aq1==155


replace feb2020=161.21  if s1aq1==158
replace mar2020=119.33  if s1aq1==158
replace apr2020=102.86  if s1aq1==158
replace may2020=113.41  if s1aq1==158
replace jun2020=116.80  if s1aq1==158
replace jul2020=97.63   if s1aq1==158
replace aug2020=122.37  if s1aq1==158
replace sep2020=125.32  if s1aq1==158
replace oct2020=125.32  if s1aq1==158
replace nov2020=154.54  if s1aq1==158
replace dec2020=154.54  if s1aq1==158
replace jan2021=138.52  if s1aq1==158


replace feb2020=120.93  if s1aq1==238
replace mar2020=121.90  if s1aq1==238
replace apr2020=117.71  if s1aq1==238
replace may2020=113.18  if s1aq1==238
replace jun2020=113.18  if s1aq1==238
replace jul2020=113.18  if s1aq1==238
replace aug2020=113.18  if s1aq1==238
replace sep2020=113.18  if s1aq1==238
replace oct2020=113.18  if s1aq1==238
replace nov2020=113.18  if s1aq1==238
replace dec2020=113.18  if s1aq1==238
replace jan2021=174.69  if s1aq1==238
*/




/*
replace oct2015=100    			if district1>=30 & district1<=38 & s1aq1==221
replace oct2015=184.5714    	if district1==34 & s1aq1==145
replace oct2015=120    			if district1==34 & s1aq1==211
replace oct2015=60    			if district1==34 & s1aq1==217
replace sep2015=60    			if district1==34 & s1aq1==217
replace aug2015=60    			if district1==34 & s1aq1==217
replace oct2015=490.90	    	if district1==63 & s1aq1==155
replace sep2015=280   			if s1aq1==189 & (district1<=20)
replace sep2015=30   			if s1aq1==121 & district1==62
replace jul2015=30   			if s1aq1==121 & district1==62
replace nov2015=42   			if s1aq1==121 & district1==62
replace feb2016=25   			if s1aq1==121 & district1==62
replace sep2015=200   			if s1aq1==204 & district1==75
replace oct2015=200   			if s1aq1==204 & district1==75
replace oct2015=440   			if s1aq1==159 & district1==61
replace oct2015=60   			if s1aq1==256 & district1==61
replace feb2016=100   			if s1aq1==256 & district1==61
recode may2015 jun2015 jul2015 aug2015 sep2015 oct2015 nov2015 dec2015 jan2016 feb2016 mar2016 apr2016  (900 600=300)  if district1==62 & s1aq1==240
replace sep2015=1573.3333		if s1aq1==248 & district1==62
replace oct2015=120				if s1aq1==242 & district1==62
replace sep2015=125				if s1aq1==242 & district1==62
replace jan2016=120				if s1aq1==242 & district1==62
replace oct2015=66.60			if s1aq1==147 & district1==75
replace oct2015=30				if s1aq1==147 & district1==75
replace oct2015=25				if s1aq1==241 & district1==75
replace oct2015=214				if s1aq1==238 & district1==63
replace dec2015=dec2015*100		if s1aq1==238 & district1==63
replace jan2016=jan2016*100		if s1aq1==238 & district1==63
replace feb2016=feb2016*100		if s1aq1==238 & district1==63
replace sep2015=142.5			if s1aq1==211 & district1==73
replace oct2015=126  			if s1aq1==221 & (district1==53 | district1==54 | district1==55)
replace sep2015=200				if s1aq1==221 & district1==64
replace sep2015=200				if s1aq1==221 & district1==64
replace jul2015=200				if s1aq1==221 & district1==64
replace dec2015=126  			if s1aq1==221 & (district1==70 | district1==71 | district1==72)
replace oct2015=200				if s1aq1==221 & district1==84
replace jun2015=300				if s1aq1==238 & district1==75
replace may2015=493.75			if s1aq1==155 & district1==63
replace oct2015=400   			if s1aq1==242 & district1==73
replace feb2016=400   			if s1aq1==242 & district1==73
replace dec2015=150   			if s1aq1==242 & district1==61

gen diff= jun2015-may2015
ta diff
recode may2015 jul2015 aug2015 sep2015 oct2015	dec2015	feb2016 (else=350)  if s1aq1==242 & district1==63
recode jun2015 aug2015 (else=300)	if s1aq1==242 & district1==64
replace oct2015=388   if s1aq1==242 & district1==64
replace dec2015=300   if s1aq1==242 & district1==64
replace feb2016=275   if s1aq1==242 & district1==64
replace jan2016=250   if s1aq1==242 & district1==70
replace may2015=25    if s1aq1==241 & district1==62
replace jan2016=25    if s1aq1==241 & district1==70
replace may2015=400   if s1aq1==251 & district1==75
replace may2015=460   if s1aq1==249 & district1==62
drop diff

gen diff=jul2015-jun2015
ta diff
replace jul2015=400   if s1aq1==189 & district1==75
replace jul2015=40    if s1aq1==207 & district1==75
replace jul2015=350   if s1aq1==238 & district1==64
replace dec2015=333   if s1aq1==238 & district1==64
recode dec2015 jan2016 feb2016 (else=333)   if s1aq1==238 & district1==63
recode sep2015 oct2015         (else=314)   if s1aq1==238 & district1==60
replace nov2015=384   if s1aq1==238 & district1==60
drop diff
 
gen diff=aug2015-jul2015
ta diff
replace aug2015=475  if s1aq1==160 & district1==56
replace aug2015=124  if s1aq1==173 & district1==43
replace aug2015=124  if s1aq1==173 & district1==45
replace aug2015=124  if s1aq1==173 & district1==73
replace aug2015=124  if s1aq1==173 & district1==74
replace aug2015=500  if s1aq1==160 & district1==63
replace aug2015=500  if s1aq1==240 & district1==61
drop diff
 
gen diff=sep2015-aug2015
ta diff
recode may2015 jun2015 aug2015 (else=300) 	if s1aq1==240 & district1==64
replace dec2015=333		if s1aq1==240 & district1==64
replace sep2015=25  	if s1aq1==241 & district1==75
drop diff
 
gen diff=oct2015-sep2015
ta diff
recode dec2015 mar2016 apr2016 (else=600)   if s1aq1==240 & district1==61
drop diff
 
gen diff=nov2015-oct2015
ta diff
recode nov2015 (else=600)   if s1aq1==240 & district1==63
replace oct2015=25		    if s1aq1==171 & district1==75
replace nov2015=142.3		if s1aq1==154 & district1==60
replace nov2015=142.3		if s1aq1==154 & district1==61
replace oct2015=466.6		if s1aq1==189 & district1==73
drop diff
 
gen diff=dec2015-nov2015
ta diff
drop diff
 
gen diff=jan2016-dec2015
ta diff
replace jan2016=1500   		if s1aq1==248 & jan2016==1100  
recode may2015-apr2016 (else=1500)  if s1aq1==248 & district1==75 
recode may2015-apr2016 (else=1500)  if s1aq1==248 & district1==40
replace jan2016=400   		if s1aq1==238 & district1==70 
replace jan2016=1000   		if s1aq1==240 & district1==70 
replace jan2016=360   		if s1aq1==251 & district1==72 
replace feb2016=327.2 		if s1aq1==251 & district1==72 
replace mar2016=340   		if s1aq1==251 & district1==72 
replace jan2016=36   		if s1aq1==250 & district1==72 
replace feb2016=33   		if s1aq1==250 & district1==72 
replace mar2016=32   		if s1aq1==250 & district1==72 
recode jan2016 feb2016 mar2016 (else=56.66666)		if s1aq1==252 & district1==72 
replace jan2016=133.33  	if s1aq1==190 & (district1>=80 & district1<=85)  
replace mar2016=537   		if s1aq1==228 & district1==61 
replace jan2016=160   		if s1aq1==242 & district1==10 
replace jan2016=160   		if s1aq1==242 & district1==20 
replace jan2016=560   		if s1aq1==155 & district1==73 
replace jan2016=940   		if s1aq1==240 & district1==10 
replace jan2016=940   		if s1aq1==240 & district1==20 
replace jan2016=800   		if s1aq1==240 & district1==40 
drop diff
 
gen diff=feb2016-jan2016
ta diff
replace jan2016=500   		if s1aq1==249 & district1==72
replace feb2016=500   		if s1aq1==155 & district1==61
replace feb2016=100   		if s1aq1==192 & district1==75
drop diff
 
gen diff=mar2016-feb2016 
ta diff
replace mar2016=1550   		if s1aq1==248 & district1==61
replace mar2016=525   		if s1aq1==249 & district1==61
replace mar2016=900   		if s1aq1==240 & district1==73
replace feb2016=130   		if s1aq1==239 & district1==73
replace mar2016=360   		if s1aq1==115 & district1==55
replace mar2016=176.47058	if s1aq1==154 & district1==73
replace jan2016=176.47058	if s1aq1==154 & district1==73
replace mar2016=81.28    	if s1aq1==192 & district1==73
drop diff
 
gen diff=apr2016-mar2016 
ta diff
drop diff
*/

drop if s1aq1==9 | s1aq1==13 | s1aq1==20 | s1aq1==23 | s1aq1==29 | s1aq1==32 |   ///
	s1aq1==41 | s1aq1==51 | s1aq1==54 | s1aq1==58 | s1aq1==68| s1aq1==73 |   ///
	s1aq1==78 | s1aq1==83 | s1aq1==90 | s1aq1==96 | s1aq1==100 | ///
s1aq1==103 | s1aq1==108 | s1aq1==111 | s1aq1==113 | s1aq1==126 | ///
s1aq1==132 | s1aq1==135 | s1aq1==137 | s1aq1==142 | s1aq1==151|  ///
s1aq1==160 | s1aq1==162 | s1aq1==166 | s1aq1==170 | s1aq1==181 | ///
s1aq1==186 | s1aq1==188 | s1aq1==191 | s1aq1==195 | s1aq1==199|  ///
s1aq1==203 | s1aq1==209 | s1aq1==215 | s1aq1==217 | s1aq1==220 | ///
s1aq1==225 | s1aq1==228 | s1aq1==234 | s1aq1==239 | s1aq1==242|  ///
s1aq1==250 | s1aq1==253 | s1aq1==255 | s1aq1==257 | s1aq1==260 | ///
s1aq1==265 | s1aq1==267 | s1aq1==271 | s1aq1==275 | s1aq1==279|  ///
s1aq1==284 | s1aq1==288 | s1aq1==292 
	//food classified as other

tab district1

tab s1aq1

su

	
compress
saveold "$temp\GMB IHS Price data 2020-21-1.dta",replace


**********************************************************
**make sure all states have equal food item codes.

use "$temp\GMB IHS Price data 2020-21-1.dta",clear

drop if district1==.
/*
local np1 = _N + 1
set obs `np1'
replace s1aq1 = 124  		if s1aq1==.	 
replace district1 = 10 	 	if district1==.

local np1 = _N + 1
set obs `np1'
replace s1aq1 = 213 		if s1aq1==.	 
replace district1 = 10 		if district1==.	 

gen v=1
fillin district1 s1aq1
*/

gen lga=.
replace lga=1  if district==10
replace lga=2  if district==20
replace lga=3  if district>=30 & district1<=38
replace lga=4  if district>=40 & district1<=45
replace lga=5  if district>=50 & district1<=56
replace lga=6  if district>=60 & district1<=64
replace lga=7  if district>=70 & district1<=75
replace lga=8  if district>=80 & district1<=86
la define lga 1 "Banjul"  2 "Kanifing"  3 "Brikama"  4 "Mansakonko"  5 "Kerewan"   ///
	6 "Kuntaur"  7 "Janjangbureh"  8 "Basse", replace
la val lga lga
lab var lga "Local Governemnt Area"

egen quater1 = rowmean(feb2020 mar2020 apr2020)
egen quater2 = rowmean(may2020 jun2020 jul2020)
egen quater3 = rowmean(aug2020 sep2020 oct2020)
egen quater4 = rowmean(nov2020 dec2020 jan2021)

replace feb2020 = quater1 if feb2020==.
replace mar2020 = quater1 if mar2020==.
replace apr2020 = quater1 if apr2020==.

replace may2020 = quater2 if may2020==.
replace jun2020 = quater2 if jun2020==.
replace jul2020 = quater2 if jul2020==.


replace aug2020 = quater3 if aug2020==.
replace sep2020 = quater3 if sep2020==.
replace oct2020 = quater3 if oct2020==.

replace nov2020 = quater4 if nov2020==.
replace dec2020 = quater4 if dec2020==.
replace jan2021 = quater4 if jan2021==.

/*
replace may2015=19.95535714   	if may2015==. & s1aq1==213  //national CPI data
replace jun2015=19.95535714		if jun2015==. & s1aq1==213
replace jul2015=19.95535714		if jul2015==. & s1aq1==213
replace aug2015=19.95535714		if aug2015==. & s1aq1==213
replace sep2015=19.95535714		if sep2015==. & s1aq1==213
replace oct2015=20.19345238		if oct2015==. & s1aq1==213
replace nov2015=20.19345238		if nov2015==. & s1aq1==213
replace dec2015=20.19345238		if dec2015==. & s1aq1==213
replace jan2016=20.19345238		if jan2016==. & s1aq1==213
replace feb2016=20.19345238		if feb2016==. & s1aq1==213
replace mar2016=20.19345238		if mar2016==. & s1aq1==213
replace apr2016=20.9077381		if apr2016==. & s1aq1==213
*/

/*
foreach vari of varlist may2015 jun2015 jul2015 aug2015 sep2015 oct2015 nov2015 dec2015 jan2016 feb2016 mar2016 apr2016 {
gen asd_`vari'=`vari'*.80    if s1aq1==123
bys district: egen asd1_`vari'=max(asd_`vari')
replace `vari'=asd1_`vari'   if s1aq1==124

}


gen asd=may2015*.80    if s1aq1==123   //NSO stated that imported chicken is cheaper by about 20%.
bys district: egen asd1=max(asd)
replace may2015=asd1   if s1aq1==124

*/

global X "feb2020 mar2020 apr2020 may2020 jun2020 jul2020 aug2020 sep2020 oct2020 nov2020 dec2020 jan2021"

/*
forvalues k = 10/86{
foreach vari of varlist may2015 jun2015 jul2015 aug2015 sep2015 oct2015 nov2015 dec2015 jan2016 feb2016 mar2016 apr2016 {
gen asd_`vari'_`k' = `vari' if s1aq1==124 & district1==`k'

replace `vari'=.80*asd1	if s1aq1==124 & district1==`k'

}

}

drop v _fillin asd*
*/
order lga

sort district s1aq1

compress
saveold "$fintab\GMB IHS Price data 2020-21 final-1_hhsize.dta",replace


*replace missing prices with region-specific prices.

use "$fintab\GMB IHS Price data 2020-21 final-1_hhsize.dta",clear


bys lga s1aq1: egen feb_20mean=median(feb2020)
bys lga s1aq1: egen mar_20mean=median(mar2020)
bys lga s1aq1: egen apr_20mean=median(apr2020)
bys lga s1aq1: egen may_20mean=median(may2020)
bys lga s1aq1: egen jun_20mean=median(jun2020)
bys lga s1aq1: egen jul_20mean=median(jul2020)
bys lga s1aq1: egen aug_20mean=median(aug2020)
bys lga s1aq1: egen sep_20mean=median(sep2020)
bys lga s1aq1: egen oct_20mean=median(oct2020)
bys lga s1aq1: egen nov_20mean=median(nov2020)
bys lga s1aq1: egen dec_20mean=median(dec2020)
bys lga s1aq1: egen jan_21mean=median(jan2021)

replace feb2020=feb_20mean   if feb2020==.
replace mar2020=mar_20mean   if mar2020==.
replace apr2020=apr_20mean   if apr2020==.
replace may2020=may_20mean   if may2020==.
replace jun2020=jun_20mean   if jun2020==.
replace jul2020=jul_20mean   if jul2020==.
replace aug2020=aug_20mean   if aug2020==.
replace sep2020=sep_20mean   if sep2020==.
replace oct2020=oct_20mean   if oct2020==.
replace nov2020=nov_20mean   if nov2020==.
replace dec2020=dec_20mean   if dec2020==.
replace jan2021=jan_21mean   if jan2021==.

drop feb_20mean mar_20mean apr_20mean may_20mean jun_20mean  jul_20mean  aug_20mean sep_20mean oct_20mean nov_20mean dec_20mean jan_21mean  
	
	
count if feb2020==.
count if mar2020==.
count if apr2020==.
count if may2020==.
count if jun2020==.
count if jul2020==.
count if aug2020==.
count if sep2020==.
count if oct2020==.
count if nov2020==.
count if dec2020==.
count if jan2021==.

*replace missing prices with national prices.

bys s1aq1: egen feb_20mean=median(feb2020)
bys s1aq1: egen mar_20mean=median(mar2020)
bys s1aq1: egen apr_20mean=median(apr2020)
bys s1aq1: egen may_20mean=median(may2020)
bys s1aq1: egen jun_20mean=median(jun2020)
bys s1aq1: egen jul_20mean=median(jul2020)
bys s1aq1: egen aug_20mean=median(aug2020)
bys s1aq1: egen sep_20mean=median(sep2020)
bys s1aq1: egen oct_20mean=median(oct2020)
bys s1aq1: egen nov_20mean=median(nov2020)
bys s1aq1: egen dec_20mean=median(dec2020)
bys s1aq1: egen jan_21mean=median(jan2021)

replace feb2020=feb_20mean   if feb2020==.
replace mar2020=mar_20mean   if mar2020==.
replace apr2020=apr_20mean   if apr2020==.
replace may2020=may_20mean   if may2020==.
replace jun2020=jun_20mean   if jun2020==.
replace jul2020=jul_20mean   if jul2020==.
replace aug2020=aug_20mean   if aug2020==.
replace sep2020=sep_20mean   if sep2020==.
replace oct2020=oct_20mean   if oct2020==.


egen  mean_value = rowmean(feb2020 mar2020 apr2020 may2020 jun2020 jul2020 aug2020 sep2020 oct2020 nov2020 dec2020 jan2021)

replace feb2020=mean_value  if feb2020==.
replace mar2020=mean_value   if mar2020==.
replace apr2020=mean_value   if apr2020==.
replace may2020=mean_value   if may2020==.
replace jun2020=mean_value   if jun2020==.
replace jul2020=mean_value   if jul2020==.
replace aug2020=mean_value   if aug2020==.
replace sep2020=mean_value   if sep2020==.
replace oct2020=mean_value   if oct2020==.
replace nov2020=mean_value   if nov2020==.
replace dec2020=mean_value   if dec2020==.
replace jan2021=mean_value   if jan2021==.


count if feb2020==.
count if mar2020==.
count if apr2020==.
count if may2020==.
count if jun2020==.
count if jul2020==.
count if aug2020==.
count if sep2020==.
count if oct2020==.
count if nov2020==.
count if dec2020==.
count if jan2021==.

/*
foreach stats in feb mar apr may jun jul aug sep  oct nov dec {
gen `stats'_lnprice=log(`stats'2020)
bys district1 s1aq1 : egen `stats'_price_md=median(`stats'_lnprice)   if `stats'2020~=. 
bys district1 s1aq1 : egen `stats'_price_mn=mean(`stats'_lnprice)     if `stats'2020~=. 
bys district1 s1aq1 : egen `stats'_price_sd=sd(`stats'_lnprice)       if `stats'2020~=.  
gen `stats'_zscore=abs((`stats'_lnprice-`stats'_price_mn)/`stats'_price_sd)
count if `stats'_zscore>2.5 & `stats'_zscore!=.
tab s1aq1 if `stats'_zscore>2.5 & `stats'_zscore!=.

gen `stats'_priced=exp(`stats'_price_md)

replace `stats'2020=`stats'_priced  if `stats'_zscore>2.5 & `stats'_zscore!=.
}

gen jan_lnprice=log(jan2021)
bys district1 s1aq1 : egen jan_price_md=median(jan_lnprice)   if jan2021~=. 
bys district1 s1aq1 : egen jan_price_mn=mean(jan_lnprice)     if jan2021~=. 
bys district1 s1aq1 : egen jan_price_sd=sd(jan_lnprice)       if jan2021~=.  
gen jan_zscore=abs((jan_lnprice-jan_price_mn)/jan_price_sd)
count if jan_zscore>2.5 & jan_zscore!=.
tab s1aq1 if jan_zscore>2.5 & jan_zscore!=.

gen jan_priced=exp(jan_price_md)

replace jan2021=jan_priced  if jan_zscore>2.5 & jan_zscore!=.
*/

foreach stats in feb mar apr may jun jul aug sep  oct nov dec {
drop if `stats'2020 > 1000
}

/*
drop if s1aq1==221 &  district1==10
drop if s1aq1==57 &  district1==10
drop if s1aq1==270 &  district1==10
drop if s1aq1==218 &  district1==10
drop if s1aq1==112 &  district1==10
drop if s1aq1==229 &  district1==10
drop if s1aq1==221 &  district1==10
drop if s1aq1==219 &  district1==10
drop if s1aq1==222 &  district1==10
drop if s1aq1==223 &  district1==10

drop if s1aq1==270 &  district1==20
drop if s1aq1==172 &  district1==20
drop if s1aq1==171 &  district1==20
drop if s1aq1==112 &  district1==20
drop if s1aq1==95 &  district1==20
drop if s1aq1==109 &  district1==20

drop if s1aq1==287 &  district1==30
drop if s1aq1==106 &  district1==30
drop if s1aq1==192 &  district1==30
drop if s1aq1==107 &  district1==30
drop if s1aq1==184 &  district1==30

*/

compress
saveold "$fintab\GMB IHS Price data 2020-21 final-valid_hhsize.dta",replace


**********************************************************
**select survey period of survey.

use "$fintab\GMB IHS Price data 2020-21 final-valid_hhsize.dta",clear

**add population distribution by region.

sort district1 
merge m:m district1 using "$temp\district pop.dta"
tab  _m
drop _m


**reference will be national price.
*reference will be national price.
*chose base period (May 2011).
*assumes that population share affects the national price.
*otherwise one can chose any month as the reference base price.

gen wtprice=(district_pop/tot_pop)*jul2020                  //weighted price share
				//region_pop is population by each region
				//tot_pop is total population for entire country
				
bys s1aq1: egen natprice=total(wtprice)         //derives national price by item.

gen def_Feb_20=feb2020/natprice
gen def_Mar_20=mar2020/natprice
gen def_Apr_20=apr2020/natprice
gen def_May_20=may2020/natprice
gen def_Jun_20=jun2020/natprice
gen def_Jul_20=jul2020/natprice
gen def_Aug_20=aug2020/natprice
gen def_Sep_20=sep2020/natprice
gen def_Oct_20=oct2020/natprice
gen def_Nov_20=nov2020/natprice
gen def_Dec_20=dec2020/natprice
gen def_Jan_21=jan2021/natprice


**make sure item code between price survey and consumption same
*insert food shares which were derived from GMB2020 basket (see code .
*var=wtratio which is already a percentage.

sort s1aq1
merge m:1 s1aq1 using "$fintab\Food basket_National-final_hhsize-3055.dta"
tab _m
keep if _m==3
drop _m

bys district1: egen totwtshare=total(wtshare)



**Laspyres
gen lasp_Feb_20=def_Feb_20*wtshare/100
gen lasp_Mar_20=def_Mar_20*wtshare/100
gen lasp_Apr_20=def_Apr_20*wtshare/100
gen lasp_May_20=def_May_20*wtshare/100
gen lasp_Jun_20=def_Jun_20*wtshare/100
gen lasp_Jul_20=def_Jul_20*wtshare/100
gen lasp_Aug_20=def_Aug_20*wtshare/100
gen lasp_Sep_20=def_Sep_20*wtshare/100
gen lasp_Oct_20=def_Oct_20*wtshare/100
gen lasp_Nov_20=def_Nov_20*wtshare/100
gen lasp_Dec_20=def_Dec_20*wtshare/100
gen lasp_Jan_21=def_Jan_21*wtshare/100


**Paasche
gen l_def_Feb_20=ln(feb2020/natprice)
gen l_def_Mar_20=ln(mar2020/natprice)
gen l_def_Apr_20=ln(apr2020/natprice)
gen l_def_May_20=ln(may2020/natprice)
gen l_def_Jun_20=ln(jun2020/natprice)
gen l_def_Jul_20=ln(jul2020/natprice)
gen l_def_Aug_20=ln(aug2020/natprice)
gen l_def_Sep_20=ln(sep2020/natprice)
gen l_def_Oct_20=ln(oct2020/natprice)
gen l_def_Nov_20=ln(nov2020/natprice)
gen l_def_Dec_20=ln(dec2020/natprice)
gen l_def_Jan_21=ln(jan2021/natprice)

gen paas_Feb_20=(wtshare/100)*l_def_Feb_20
gen paas_Mar_20=(wtshare/100)*l_def_Mar_20
gen paas_Apr_20=(wtshare/100)*l_def_Apr_20
gen paas_May_20=(wtshare/100)*l_def_May_20
gen paas_Jun_20=(wtshare/100)*l_def_Jun_20
gen paas_Jul_20=(wtshare/100)*l_def_Jul_20
gen paas_Aug_20=(wtshare/100)*l_def_Aug_20
gen paas_Sep_20=(wtshare/100)*l_def_Sep_20
gen paas_Oct_20=(wtshare/100)*l_def_Oct_20
gen paas_Nov_20=(wtshare/100)*l_def_Nov_20
gen paas_Dec_20=(wtshare/100)*l_def_Dec_20
gen paas_Jan_21=(wtshare/100)*l_def_Jan_21

sort district1 s1aq1

compress
saveold "$temp\average district prices_hhsize.dta", replace  


collapse natprice,by(s1aq1)

sort s1aq1

order s1aq1 natprice

compress
saveold "$fintab\GMB_IHS2020-21 average district prices complete_hhsize.dta", replace              //national prices to use for food poverty line derivation.

export excel s1aq1 natprice using "$fintab\Z-output.xls", sheet("national prices-pcap") sheetreplace firstrow(variables) nolabel


**********************************************************

use "$temp\average district prices_hhsize.dta", clear

collapse (sum) lasp_* paas_*, by(district1)

replace paas_Feb_20=exp(paas_Feb_20)
replace paas_Mar_20=exp(paas_Mar_20)
replace paas_Apr_20=exp(paas_Apr_20)
replace paas_May_20=exp(paas_May_20)
replace paas_Jun_20=exp(paas_Jun_20)
replace paas_Jul_20=exp(paas_Jul_20)
replace paas_Aug_20=exp(paas_Aug_20)
replace paas_Sep_20=exp(paas_Sep_20)
replace paas_Oct_20=exp(paas_Oct_20)
replace paas_Nov_20=exp(paas_Nov_20)
replace paas_Dec_20=exp(paas_Dec_20)
replace paas_Jan_21=exp(paas_Jan_21)

gen fisher_Feb_20=sqrt(lasp_Feb_20*paas_Feb_20)
gen fisher_Mar_20=sqrt(lasp_Mar_20*paas_Mar_20)
gen fisher_Apr_20=sqrt(lasp_Apr_20*paas_Apr_20)
gen fisher_May_20=sqrt(lasp_May_20*paas_May_20)
gen fisher_Jun_20=sqrt(lasp_Jun_20*paas_Jun_20)
gen fisher_Jul_20=sqrt(lasp_Jul_20*paas_Jul_20)
gen fisher_Aug_20=sqrt(lasp_Aug_20*paas_Aug_20)
gen fisher_Sep_20=sqrt(lasp_Sep_20*paas_Sep_20)
gen fisher_Oct_20=sqrt(lasp_Oct_20*paas_Oct_20)
gen fisher_Nov_20=sqrt(lasp_Nov_20*paas_Nov_20)
gen fisher_Dec_20=sqrt(lasp_Dec_20*paas_Dec_20)
gen fisher_Jan_21=sqrt(lasp_Jan_21*paas_Jan_21)


*drop if inlist(district1,33,35,36,37,38,40,41,42,44,70,71)

preserve
keep if district1>=50 & district1<=56
gen asd=1   	if district1>=50 & district1<=56

collapse lasp_* paas_* fisher_*,by(asd)
rename asd district1

replace district1=51   if district1==1   //NSO agreed to this imputation as they look for the actual prices for these 7 districts.  
		//perusing the data, this look OK as district variation is low
compress
saveold "$temp/missing price index", replace
restore

/*
preserve
keep if district1>=31 & district1<=38
gen asd=1   	if district1>=31 & district1<=38

collapse lasp_* paas_* fisher_*,by(asd)
rename asd district1

replace district1=30   if district1==1  
compress
saveold "$temp/missing price index2", replace
restore
*/
/*
preserve
keep if district1>=10 & district1<=86
gen asd=1   	if district1>=10 & district1<=86

collapse lasp_* paas_* fisher_*,by(asd)


replace district1=36 if asd==1  
replace district1=37  if asd==1  
replace district1=38  if asd==1  
replace district1=40  if asd==1  
replace district1=41  if asd==1   
replace district1=42  if asd==1  
replace district1=44  if asd==1  
compress
saveold "$temp/missing price index3", replace
restore

*/


append using "$temp/missing price index"
*append using "$temp/missing price index2"
*append using "$temp/missing price index3"

sort district1

compress
saveold "$fintab\Module 9 food pricedeflators_hhsize.dta", replace


export excel district1-fisher_Jan_21 using "$fintab\Z-output.xls", sheet("price deflators-pcap") sheetreplace firstrow(variables) nolabel




/*
use "C:\Users\Rostand Tchouakam\Desktop\World Bank Group\Welfare Aggregate\GMB\IHS2015\output\Consumption\Module 9 food pricedeflators_hhsize.dta",clear

rename *_May_15 *_Feb_20
rename *_Jun_15 *_Mar_20
rename *_Jul_15 *_Apr_20
rename *_Aug_15 *_May_20
rename *_Sep_15 *_Jun_20
rename *_Oct_15 *_Jul_20
rename *_Nov_15 *_Aug_20
rename *_Dec_15 *_Sep_20
rename *_Jan_16 *_Oct_20
rename *_Feb_16 *_Nov_20
rename *_Mar_16 *_Dec_20
rename *_Apr_16 *_Jan_21

sort district1

compress
saveold "$fintab\Module 9 food pricedeflators_hhsize.dta", replace


export excel district1-fisher_Jan_21 using "$fintab\Z-output.xls", sheet("price deflators-pcap") sheetreplace firstrow(variables) nolabel
*/

*****************************
*** THE END
*****************************

