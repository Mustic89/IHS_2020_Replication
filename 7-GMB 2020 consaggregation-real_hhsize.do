* * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* ####################################################### *
* #                                                     # *
* #           GAMBIA IHS REAL WELFARE AGGREGATE         # *
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
//change the specific file path to your IHS2020 folder here to run the dofile

*+++++++ CHANGE THIS PATH TO YOUR IHS 2020 FOLDER TO RUN ++++++++*
global path  "C:\Users\tchou\Desktop\IHS2020"
********************************************************************************

global findata     ${path}\01.Data\Stata
global othdata     ${path}\01.Data\Other
global fintab      ${path}\04.Results\output
global logs        ${path}\04.Results\logfiles
global temp        ${path}\04.Results\temp

log using "$logs\7-GMB 2020 consaggregation-real_hhsize.log" , replace
********************************************************************************


***********************************
** FINALIZE CONSUMPTION AGGREGATE
***********************************

use "$fintab\Module 8 nominal consagg.dta", clear

keep if wta_hh_c~=.  //making sure that not missing

sort district1

gen month=int_month 
*replace month=5   		if int_month==4 & int_year==2015  //very few obs as survey started towards end month

merge m:1 district1 using "$fintab\Module 9 food pricedeflators_hhsize.dta"
tab _merge
keep if _m==3
drop _merge


gen fdpindex=.
/*
replace fdpindex=fisher_Feb_20  	if (month==2 & int_year==2020)	
replace fdpindex=fisher_Mar_20  	if (month==3 & int_year==2020)	
replace fdpindex=fisher_Apr_20  	if (month==4 & int_year==2020)	
replace fdpindex=fisher_May_20  	if (month==5 & int_year==2020)	
replace fdpindex=fisher_Jun_20  	if (month==6 & int_year==2020)	
replace fdpindex=fisher_Jul_20  	if (month==7 & int_year==2020)	
replace fdpindex=fisher_Aug_20  	if (month==8 & int_year==2020)	
replace fdpindex=fisher_Sep_20  	if (month==9 & int_year==2020)	
replace fdpindex=fisher_Oct_20  	if (month==10 & int_year==2020)	
replace fdpindex=fisher_Nov_20  	if (month==11 & int_year==2020)	
replace fdpindex=fisher_Dec_20  	if (month==12 & int_year==2020)	
replace fdpindex=fisher_Jan_21  	if (month==1 & int_year==2021)
*/
* cpi 
/*
replace fdpindex=0.980124  	if (month==2 & int_year==2020)	
replace fdpindex=0.982384  	if (month==3 & int_year==2020)	
replace fdpindex=0.976776  	if (month==4 & int_year==2020)	
replace fdpindex=0.984032 	if (month==5 & int_year==2020)	
replace fdpindex=0.985938 	if (month==6 & int_year==2020)	
replace fdpindex=0.987755  	if (month==7 & int_year==2020)	
replace fdpindex=1.000587  	if (month==8 & int_year==2020)	
replace fdpindex=1.003619  	if (month==9 & int_year==2020)	
replace fdpindex=1.011919  	if (month==10 & int_year==2020)	
replace fdpindex=1.018827  	if (month==11 & int_year==2020)	
replace fdpindex=1.024276  	if (month==12 & int_year==2020)	
replace fdpindex=1.043763  	if (month==1 & int_year==2021)	
*/
replace fdpindex=0.977829  	if (month==2 & int_year==2020)	
replace fdpindex=0.997559  	if (month==3 & int_year==2020)	
replace fdpindex=0.995627  	if (month==4 & int_year==2020)	
replace fdpindex=0.998968 	if (month==5 & int_year==2020)	
replace fdpindex=0.998896 	if (month==6 & int_year==2020)	
replace fdpindex=1.000000  	if (month==7 & int_year==2020)	
replace fdpindex=1.026036  	if (month==8 & int_year==2020)	
replace fdpindex=1.026308  	if (month==9 & int_year==2020)	
replace fdpindex=1.034304  	if (month==10 & int_year==2020)	
replace fdpindex=1.039230  	if (month==11 & int_year==2020)	
replace fdpindex=1.049363  	if (month==12 & int_year==2020)	
replace fdpindex=1.077191  	if (month==1 & int_year==2021)	


/*
replace fdpindex=0.98  	if (month==2 & int_year==2020)	
replace fdpindex=0.98  	if (month==3 & int_year==2020)	
replace fdpindex=0.98 	if (month==4 & int_year==2020)	
replace fdpindex=0.98	if (month==5 & int_year==2020)	
replace fdpindex=0.99 	if (month==6 & int_year==2020)	
replace fdpindex=0.99  	if (month==7 & int_year==2020)	
replace fdpindex=1.00  	if (month==8 & int_year==2020)	
replace fdpindex=1.00  	if (month==9 & int_year==2020)	
replace fdpindex=1.01  	if (month==10 & int_year==2020)	
replace fdpindex=1.02  	if (month==11 & int_year==2020)	
replace fdpindex=1.02  	if (month==12 & int_year==2020)	
replace fdpindex=1.04  	if (month==1 & int_year==2021)
*/

*deriving price index for nonfood difficult as many items lack standard units.
*therefore it is assumed that nonfood price variation is similar to that for food.
*known fact that this may not be so.
*secondly other argument is that this may not vary if there is a monopolistic non-food market so nonfood price variation may be insignificant.
gen nfdpindex=fdpindex
/*
replace nfdpindex  =1.00256434656781	if (month==2 & int_year==2020)		
replace nfdpindex=	0.985691313218237 if (month==3 & int_year==2020)		
replace nfdpindex=	0.975931541300246 if (month==4 & int_year==2020)		
replace nfdpindex= 0.987635757829338 if (month==5 & int_year==2020)		
replace nfdpindex=	0.991752192509306 if (month==6 & int_year==2020)		
replace nfdpindex=	0.994391180880028 if (month==7 & int_year==2020)		
replace nfdpindex=	0.992994070818808 if (month==8 & int_year==2020)		
replace nfdpindex=	0.999118310430216 if (month==9 & int_year==2020)		
replace nfdpindex=	1.00792430619312 if (month==10 & int_year==2020)		
replace nfdpindex=	1.01680711589087 if (month==11 & int_year==2020)		
replace nfdpindex=	1.01722725175834 if (month==12 & int_year==2020)		
replace nfdpindex=	1.02796261260368 if (month==1 & int_year==2021)	
*/

replace nfdpindex=1.008219266  if (month==2 & int_year==2020)		
replace nfdpindex=0.991251061  if (month==3 & int_year==2020)		
replace nfdpindex=0.98143624   if (month==4 & int_year==2020)		
replace nfdpindex=0.993206473  if (month==5 & int_year==2020)		
replace nfdpindex=0.997346127  if (month==6 & int_year==2020)		
replace nfdpindex=1.000000000  if (month==7 & int_year==2020)		
replace nfdpindex=0.99859501   if (month==8 & int_year==2020)		
replace nfdpindex=1.004753793  if (month==9 & int_year==2020)		
replace nfdpindex=1.013609458  if (month==10 & int_year==2020)		
replace nfdpindex=1.022542371  if (month==11 & int_year==2020)		
replace nfdpindex=1.022964877  if (month==12 & int_year==2020)		
replace nfdpindex=1.03376079   if (month==1 & int_year==2021)	




lab var fdpindex   "Food price index"
lab var nfdpindex  "Non-food price index"


*deflated food and non-food expenditure
gen fdtexpdr = fdtexp/fdpindex
lab var fdtexpdr "Total purchased and auto-consumption food expenditure in regionally deflated prices"

gen nfdtexpdr = nfdtexp/nfdpindex
lab var nfdtexpdr "Total non-food consumption expenditure in regionally deflated prices"

egen hhtexpdr = rowtotal(fdtexpdr nfdtexpdr)
lab var hhtexpdr "Total household food and non-food consumption expenditure in regionally deflated prices"

*deflated per capita and per adult equivalent expenditure
gen pc_fddr = fdtexpdr/hhsize
lab var pc_fddr "Per capita total household food consumption expenditure in regionally deflated prices"

gen pc_hhdr = hhtexpdr/hhsize
lab var pc_hhdr "Per capita total household food and non-food consumption expenditure in regionally deflated prices"

gen padq_fddr = fdtexpdr/ctry_adq
lab var padq_fddr "Per adult equivalent total household food consumption expenditure in regionally deflated prices"

gen padq_hhdr = hhtexpdr/ctry_adq
lab var padq_hhdr "Per adult equivalent total household food and non-food consumption expenditure in regionally deflated prices"


**********************************************************
**apply food index based on food price survey and nonfood apply nonfood CPI

gen nfdpindex1  =1.00256434656781	if (month==2 & int_year==2020)		
replace nfdpindex1=	0.985691313218237 if (month==3 & int_year==2020)		
replace nfdpindex1=	0.975931541300246 if (month==4 & int_year==2020)		
replace nfdpindex1= 0.987635757829338 if (month==5 & int_year==2020)		
replace nfdpindex1=	0.991752192509306 if (month==6 & int_year==2020)		
replace nfdpindex1=	0.994391180880028 if (month==7 & int_year==2020)		
replace nfdpindex1=	0.992994070818808 if (month==8 & int_year==2020)		
replace nfdpindex1=	0.999118310430216 if (month==9 & int_year==2020)		
replace nfdpindex1=	1.00792430619312 if (month==10 & int_year==2020)		
replace nfdpindex1=	1.01680711589087 if (month==11 & int_year==2020)		
replace nfdpindex1=	1.01722725175834 if (month==12 & int_year==2020)		
replace nfdpindex1=	1.02796261260368 if (month==1 & int_year==2021)		
		

		
*deflate food and non-food expenditure

gen fdtexpdr1 = fdtexp/fdpindex
lab var fdtexpdr1 "Total purchased and auto-consumption food expenditure in regionally deflated prices"

gen nfdtexpdr1 = nfdtexp/nfdpindex1
lab var nfdtexpdr1 "Total non-food consumption expenditure in regionally deflated prices"

egen hhtexpdr1 = rowtotal(fdtexpdr1 nfdtexpdr1)
lab var hhtexpdr1 "Total household food and non-food consumption expenditure in regionally deflated prices"

*deflated per capita and per adult equivalent expenditure
gen pc_fddr1 = fdtexpdr1/hhsize
lab var pc_fddr1 "Per capita total household food consumption expenditure in regionally deflated prices"

gen pc_hhdr1 = hhtexpdr1/hhsize
lab var pc_hhdr1 "Per capita total household food and non-food consumption expenditure in regionally deflated prices"

gen padq_fddr1 = fdtexpdr1/ctry_adq
lab var padq_fddr1 "Per adult equivalent total household food consumption expenditure in regionally deflated prices"

gen padq_hhdr1 = hhtexpdr1/ctry_adq
lab var padq_hhdr1 "Per adult equivalent total household food and non-food consumption expenditure in regionally deflated prices"


**********************************************************
**deflate food only and nonfood stays nominal 
gen fdtexpdr2 = fdtexp/fdpindex
lab var fdtexpdr2 "Total purchased and auto-consumption food expenditure in regionally deflated prices"

gen nfdtexpdr2 = nfdtexp
lab var nfdtexpdr2 "Total non-food consumption expenditure in regionally deflated prices"

egen hhtexpdr2 = rowtotal(fdtexpdr2 nfdtexpdr2)
lab var hhtexpdr2 "Total household food and non-food consumption expenditure in regionally deflated prices"

*deflated per capita and per adult equivalent expenditure
gen pc_fddr2 = fdtexpdr2/hhsize
lab var pc_fddr2 "Per capita total household food consumption expenditure in regionally deflated prices"

gen pc_hhdr2 = hhtexpdr2/hhsize
lab var pc_hhdr2 "Per capita total household food and non-food consumption expenditure in regionally deflated prices"

gen padq_fddr2 = fdtexpdr2/ctry_adq
lab var padq_fddr2 "Per adult equivalent total household food consumption expenditure in regionally deflated prices"

gen padq_hhdr2 = hhtexpdr2/ctry_adq
lab var padq_hhdr2 "Per adult equivalent total household food and non-food consumption expenditure in regionally deflated prices"


*erase "$fintab\Z-output 2-deflated_exp_hhsize.xls"

*deflated expenditures
foreach var of varlist lga district1 rururb econzone  year_mth{
tabout `var' [aw=wta_hh] using "${fintab}\Z-output 2-deflated_exp_hhsize.xls", sum c(mean hhsize mean fdtexpdr   ///
	mean nfdtexpdr mean hhtexpdr mean nfdtexpdr1 mean hhtexpdr1 mean nfdtexpdr2 mean hhtexpdr2  ///
	mean pc_hhdr mean pc_hhdr1 mean pc_hhdr2 mean padq_hhdr mean padq_hhdr1 mean padq_hhdr2) append
}
*

**********************************************************
**compare
*summary: Deaton page 91 says food price index is therefore used as a proxy for all

ttest pc_hhdr == pc_hhdr1, unpaired unequal welch
ttest pc_hhdr == pc_hhdr1

ttest pc_hhdr == pc_hhdr2, unpaired unequal welch
ttest pc_hhdr == pc_hhdr2

twoway (histogram pc_hhdr  if pc_hhdr<=150000,  color(green)) ///
       (histogram pc_hhdr1 if pc_hhdr1<=150000, color(orange)) ///
	   (histogram pc_hhdr2 if pc_hhdr2<=150000,  ///
	   fcolor(none) lcolor(black)), legend(order(1 "Food index to all" 2 "Food index/nonfood CPI" 3 "Food index to food/nonfood as is"))
graph save Graph "$fintab\Z-output Graph-expenditure comparisons.gph", replace


**********************************************************
**deflated quintile groupings by area of residence and population distribution and deflated per capita expenditure.
*takes into account area of residence (rural or urban).

xtile rurdfquin = pc_hhdr   if rururb==0 [pweight=wta_pop_c], nq(5) 
lab var rurdfquin "Deflated rural quintile by PC_HHDR (5 groups)"

xtile urbdfquin = pc_hhdr   if rururb==1 [pweight=wta_pop_c], nq(5) 
lab var urbdfquin "Deflated urban quintile by PC_HHDR (5 groups)"

gen dfquin=rurdfquin
replace dfquin=urbdfquin    if dfquin==.
lab var dfquin "Deflated quintile by RURURB and PC_HHDR (5 groups)"

**deflated quintile groupings by annual per capita expenditure (adjusted for price)
*does not take into account area of residence (rural or urban).

xtile ndfquin = pc_hhdr [aw=wta_pop_c],nq(5)
lab var ndfquin "National deflated quintile by PC_HHDR (5 groups)"

**deflated decile groupings by annual per capita expenditure (adjusted for price)
*does not take into account area of residence (rural or urban).

xtile ndfdecil = pc_hhdr [aw=wta_pop_c],nq(10)
lab var ndfdecil "National deflated decile by PC_HHDR (10 groups)"

*drop qrur qurb lasp_Feb_20-fisher_Jan_21 nfdpindex1-padq_hhdr2

sort hid

compress
saveold "$fintab\Module 10 deflated consagg_hhsize.dta",replace


**********************************************************
**derive consumption/shares by broad groups.

use "$fintab\Module 10 deflated consagg_hhsize.dta",clear 

gen fdtotbydr_m	= (fdtotby/fdpindex)/12
gen fdtotprdr_m	= (fdtotpr/fdpindex)/12
gen fdtexpdr_m 	= fdtexpdr/12
gen fdtotbyshr 	= 100*(fdtotbydr_m/fdtexpdr_m)
gen fdtotprshr 	= 100*(fdtotprdr_m/fdtexpdr_m)
gen nfdtexpdr_m	= nfdtexpdr/12
gen hhtexpdr_m 	= hhtexpdr/12
gen padq_fddr_m	= padq_fddr/12
gen pc_fddr_m  	= pc_fddr/12
gen padq_hhdr_m	= padq_hhdr/12
gen pc_hhdr_m  	= pc_hhdr/12
gen fdshr	   	= (fdtexpdr/hhtexpdr)*100
gen nfdshr     	= (nfdtexpdr/hhtexpdr)*100
gen edshr  	   	= 100*((edtexp/nfdpindex)/hhtexpdr)
gen hlshr      	= 100*((hltexp/nfdpindex)/hhtexpdr)
gen rntshr     	= 100*((nfdrnthh/nfdpindex)/hhtexpdr)
gen rd1		   	= rdr_hh/hhsize
gen rd2			= rdr_hh_a/hhsize
gen rd3			= rdr_hh_ctry/hhsize
gen fdtotpurc_m	= (fdtotpurc/fdpindex)/12
gen fdtotgift_m	= (fdtotgift/fdpindex)/12
gen fdrestby_m 	= (fdrestby/fdpindex)/12
gen fdpurcshr	= 100*(fdtotpurc_m/fdtexpdr_m)
gen fdgiftshr	= 100*(fdtotgift_m/fdtexpdr_m)
gen fdrestshr	= 100*(fdrestby_m/fdtexpdr_m)

lab var fdtotbydr_m   "Deflated monthly food purchase"
lab var fdtotprdr_m   "Deflated monthly food own production"
lab var fdtexpdr_m    "Deflated monthly total food (purchase and own production)"
lab var fdtotbyshr    "Food purchase share to total food consumption expenditure"
lab var fdtotprshr    "Food autoconsumption share to total food consumption expenditure"
lab var nfdtexpdr_m   "Deflated monthly total non-food"
lab var hhtexpdr_m    "Deflated monthly total food and non-food consumption expenditure"
lab var fdshr         "Food (purchase and own production) share to total household consumption expenditure"
lab var nfdshr        "Non-food (incl education, health etc) share to total household consumption expenditure"
lab var edshr         "Education share to total household consumption expenditure"
lab var edshr         "Health share to total household consumption expenditure"
lab var rntshr        "Rent share to total household consumption expenditure"
lab var rd1           "Per capita daily required calories for moderate activity"
lab var rd2           "Per capita daily required calories for moderate activity (urban) and rural (moderate-heavy)"
lab var rd3           "Per capita daily required calories (country)"
lab var fdpurcshr     "Food purchase share to total food consumption expenditure"
lab var fdgiftshr     "Food gift share to total food consumption expenditure"
lab var fdrestshr     "Food in restaurant share to total food consumption expenditure"
lab var fdtotpurc_m   "Deflated monthly food purchase"
lab var fdtotgift_m   "Deflated monthly food gifts"
lab var fdrestby_m    "Deflated monthly food in restaurants"


*erase "$fintab\Z-output 2a-deflated_exp_hhsize.xls"
*erase "$fintab\Z-output 2b-expenditure shares_hhsize.xls"
*erase "$fintab\Z-output 2c-food expenditure_shares_hhsize.xls"


*deflated expenditures
foreach var of varlist lga district1 rururb econzone dfquin rurdfquin urbdfquin ndfquin ndfdecil year_mth{
tabout `var' [aw=wta_hh] using "${fintab}\Z-output 2a-deflated_exp_hhsize.xls", sum c(mean hhsize mean fdtotbydr_m   ///
	mean fdtotprdr_m mean fdtexpdr_m mean nfdtexpdr_m mean hhtexpdr_m mean pc_fddr_m mean padq_fddr_m mean pc_hhdr mean padq_hhdr_m   ///
	mean fdtotpurc_m mean fdtotgift_m mean fdrestby_m) append
}
*

*shares 
foreach var of varlist lga district1 rururb econzone dfquin rurdfquin urbdfquin ndfquin ndfdecil year_mth{
tabout `var' [aw=wta_hh] using "${fintab}\Z-output 2b-expenditure shares_hhsize.xls", sum c(mean rd1 mean rd2 mean fdtotbyshr  ///
	mean fdtotprshr mean fdshr mean edshr mean hlshr mean rntshr mean nfdshr mean rd3 median rd1 median rd2 median rd3) append
}
*
*food expenditures and shares

foreach var of varlist lga district1 rururb econzone dfquin rurdfquin urbdfquin ndfquin ndfdecil year_mth{
tabout `var' [aw=wta_hh] using "${fintab}\Z-output 2c-food expenditure_shares_hhsize.xls", sum c(mean fdtotpurc_m  ///
	mean fdtotgift_m  mean fdrestby_m mean fdtotbydr_m mean fdtotprdr_m mean fdtexpdr_m mean fdpurcshr mean fdgiftshr  ///
	mean fdrestshr mean fdtotbyshr mean fdtotprshr) append
}


****************
***THE END
****************
