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
// change the specific file path to your IHS2020 folder here to run the dofile

*+++++++++ CHANGE THIS PATH TO YOUR IHS 2020 FOLDER TO RUN ++++++++*
global path  "C:\Users\tchou\Desktop\IHS2020"
***************************************************************************

global findata     ${path}\01.Data\Stata
global othdata     ${path}\01.Data\Other
global fintab      ${path}\04.Results\output
global logs        ${path}\04.Results\logfiles
global temp        ${path}\04.Results\temp


log using "$logs\8-GMB 2020 poverty lines-national hhsize.log" , replace


**************************************************
** BASIC FILE PREPARATION FOR POVERTY LINES - ALL
**************************************************

** select key basic charcteristics.

use "$fintab\Module 10 deflated consagg_hhsize.dta", clear

gen pcfd       =(fdtexp/12)/hhsize
gen totfood_mth=(fdtexp/12)
lab var pcfd "Per capita monthly food"
lab var totfood_mth "Monthly food expenditure"

egen pophh=total(wta_pop_c)
lab var pophh "Total population"

egen popcadq=total(wta_cadq_c)
lab var popcadq "Adult equivalent total population"
format pophh popcadq %12.2f

*takes into account area of residence (rural or urban).
*percentiles (100 equal groups) weighted by population for rural and urban respectively.

xtile prur = pc_hh  if rururb==0 [pweight=wta_pop_c], nq(100) 
xtile purb = pc_hh  if rururb==1 [pweight=wta_pop_c], nq(100) 
gen percentile    =prur
replace percentile=purb if percentile==.
label var prur        "Rural undeflated percentile by PCEXP"
label var purb        "Urban undeflated percentile by PCEXP"
label var percentile  "Undeflated percentile by RURURB and PCEXP"

*national percentile groupings by population distribution 
*does not take into account area of residence (rural or urban).

xtile npercentile=pc_hh[aw=wta_pop_c],nq(100)
label var npercentile  "National undeflated percentile by PCEXP"

keep lga district1 rururb hid hhsize ctry_adq wta_hh_c wta_pop_c wta_cadq_c ///
	fdtexp nfdtexp hhtexp pc_hh int_month int_year year_mth pc_fd totfood_mth  ///
	prur purb percentile npercentile 
	
sort hid

compress
saveold "$temp\R_basic infor_hhsize.dta", replace


**********************************************************
**import calories file into STATA

clear
import excel "$othdata\GMB food tables calories-2020.xlsx", sheet("Sheet Final") firstrow clear

sort s1aq1

drop if  s1aq1==.

compress
saveold "$fintab\GMB 2020-21 calories per 100g.dta",replace


**********************************************************

use "$fintab\GMB 2020-21 calories per 100g.dta",clear

tab s1aq1,missing
drop if s1aq1==.
count

sort s1aq1

merge m:1 s1aq1 using "$fintab\GMB_IHS2020-21 average district prices complete_hhsize.dta"
tab _m
drop _m


* natprice fixing by using the 2015 prices

replace natprice = 24.70945*1.38 if s1aq1==3 
replace natprice = 28.76176*1.38 if s1aq1==2
replace natprice = 158.6782*1.38 if s1aq1==42
replace natprice = 38.94098*1.38 if s1aq1==16
replace natprice = 29.8689*1.38 if s1aq1==178
replace natprice = 107.0463*1.38 if s1aq1==44
replace natprice = 23.58274*1.38 if s1aq1==7
replace natprice = 33.44817*1.38 if s1aq1==164		
replace natprice = 50.48387*1.38 if s1aq1==105	
replace natprice = 23.40079*1.38 if s1aq1==4	
replace natprice = 309.5482*1.38 if s1aq1==256
replace natprice = 24.40543*1.38 if s1aq1==6
replace natprice = 24.81005*1.38 if s1aq1==59		
replace natprice = 147.3057*1.38 if s1aq1==187	
replace natprice = 30.06379*1.38 if s1aq1==1
replace natprice = 166.7616*1.38 if s1aq1==37
replace natprice = 77.48427*1.38 if s1aq1==104
replace natprice = 75.0466*1.38 if s1aq1==63	
replace natprice = 36.79683*1.38 if s1aq1==85
replace natprice = 90.42477*1.38 if s1aq1==60
replace natprice = 180.5684*1.38  if s1aq1==94 	// assign evaporeted Milk
replace natprice = 43.10871*1.38 if s1aq1==12	
replace natprice = 73.17047*1.38 if s1aq1==156
replace natprice = 118.7096*1.38 if s1aq1==158
replace natprice = 35.25886*1.38 if s1aq1==154
replace natprice = 27.60555*1.38 if s1aq1==155	
*replace natprice =   if s1aq1==194 // Jumbo
replace natprice = 41.24491*1.38 if s1aq1==70
replace natprice = 180.5684*1.38 if s1aq1==92
replace natprice = 41.20817*1.38 if s1aq1==153
replace natprice = 81.06326*1.38 if s1aq1==139	
replace natprice = 158.6782*1.38 if s1aq1==49
replace natprice = 19.0035*1.38  if s1aq1==146
replace natprice = 37.41165*1.38 if s1aq1==84	
replace natprice = 63.64049*1.38 if s1aq1==143
replace natprice = 210.856*1.38  if s1aq1==258
replace natprice = 41.61391*1.38 if s1aq1==168
replace natprice = 41.50032*1.38 if s1aq1==11
replace natprice = 148.2736*1.38 if s1aq1==102	
replace natprice = 898.4148*1.38 if s1aq1==237
replace natprice = 200.0396*1.38 if s1aq1==48
replace natprice = 45.96567*1.38 if s1aq1==25
replace natprice = 38.94098*1.38 if s1aq1==17
replace natprice = 158.6782*1.38 if s1aq1==56
replace natprice = 10.83752*1.38 if s1aq1==226
replace natprice = 61.07838*1.38 if s1aq1==69
replace natprice = 166.7616*1.38 if s1aq1==45
replace natprice = 141.5911*1.38 if s1aq1==230
replace natprice = 109.2724*1.38 if s1aq1==61
*replace natprice =.  if s1aq1==74
replace natprice = 474.6829*1.38 if s1aq1==91
replace natprice = 180.5684*1.38 if s1aq1==93 // assign evaporeted Milk
replace natprice = 17.58443*1.38 if s1aq1==150	
replace natprice = 31.27989*1.38 if s1aq1==157
replace natprice = 124.6004*1.38 if s1aq1==152	
replace natprice = 38.42655*1.38 if s1aq1==169
replace natprice = 22.67132*1.38 if s1aq1==167
replace natprice = 104.1208*1.38 if s1aq1==62
replace natprice = 100.7164*1.38 if s1aq1==238
replace natprice = 45.68981*1.38 if s1aq1==115
*replace natprice =   if s1aq1==34  // Life Goat
replace natprice = 31.23993*1.38 if s1aq1==144
*replace natprice =   if s1aq1==194 // Red snapper
replace natprice = 124.0413*1.38 if s1aq1==165
replace natprice = 46.77922*1.38 if s1aq1==114
replace natprice = 45.96567*1.38 if s1aq1==24



*natprice fixing by using the 2020 prices from GBoS
/*
replace natprice = 26.80  if s1aq1==3 
replace natprice = 198.39 if s1aq1==42
replace natprice = 40.93  if s1aq1==16
replace natprice = 35.59  if s1aq1==178
replace natprice = 88.35  if s1aq1==44
replace natprice = 25.59  if s1aq1==7
replace natprice = 44.76  if s1aq1==164		
replace natprice = 58.81  if s1aq1==105	
replace natprice = 27.09  if s1aq1==4	
*replace natprice = 309.5482*1.38 if s1aq1==256
replace natprice =  26.21 if s1aq1==6
replace natprice = 45.81  if s1aq1==59		
replace natprice = 66.62  if s1aq1==187	
replace natprice = 33.85  if s1aq1==1
*replace natprice = 168.47 if s1aq1==37
replace natprice = 79.26  if s1aq1==104
replace natprice = 67.30  if s1aq1==63	
*replace natprice = 49.21 if s1aq1==85
replace natprice = 138.36 if s1aq1==60
*replace natprice =.  if s1aq1==94 	
replace natprice = 45.48  if s1aq1==12	
replace natprice = 102.59 if s1aq1==156
replace natprice = 127.76 if s1aq1==158
replace natprice = 50.54  if s1aq1==154
replace natprice = 34.11  if s1aq1==155	
*replace natprice =.  if s1aq1==194 
replace natprice = 65.54  if s1aq1==70
*replace natprice = 32.51 if s1aq1==92
replace natprice = 56.59  if s1aq1==153
replace natprice = 63.79  if s1aq1==139	
replace natprice = 198.39 if s1aq1==49
replace natprice = 45.60  if s1aq1==146
replace natprice = 48.16  if s1aq1==84	
replace natprice = 60.21  if s1aq1==143
*replace natprice = 49.84  if s1aq1==258
replace natprice = 48.80  if s1aq1==168
*replace natprice = 41.50032*1.38 if s1aq1==11
*replace natprice = 148.2736*1.38 if s1aq1==102	
replace natprice = 453.57 if s1aq1==237
*replace natprice = 200.0396*1.38 if s1aq1==48
replace natprice = 47.46  if s1aq1==25
replace natprice = 40.93  if s1aq1==17
*replace natprice = 158.6782*1.38 if s1aq1==56
replace natprice =  11.40 if s1aq1==226
replace natprice = 81.04  if s1aq1==69
replace natprice = 168.81 if s1aq1==45
replace natprice = 156.86 if s1aq1==230
replace natprice = 136.54 if s1aq1==61
replace natprice = 200.13 if s1aq1==74
*replace natprice = 474.6829*1.38 if s1aq1==91
*replace natprice = 180.5684*1.38 if s1aq1==93 // assign evaporeted Milk
*replace natprice = 17.58443*1.38 if s1aq1==150	
replace natprice = 33.54  if s1aq1==157
replace natprice = 156.15 if s1aq1==152	
replace natprice = 39.76  if s1aq1==169
replace natprice = 32.66  if s1aq1==167
*replace natprice = 104.1208*1.38 if s1aq1==62
replace natprice = 115.83 if s1aq1==238
replace natprice = 34.11  if s1aq1==115
*/

/*
drop if s1aq1==116 | s1aq1==122 | s1aq1==127 | s1aq1==133 | s1aq1==151 | s1aq1==161 |   ///
	s1aq1==170 | s1aq1==196 | s1aq1==201 | s1aq1==203 | s1aq1==225 | s1aq1==234 |   ///
	s1aq1==245 | s1aq1==247 | s1aq1==257 | s1aq1==265 
*/

drop if natprice==.

keep s1aq1 WA_Energy_cal Edible_conv valid_cal natprice

sort s1aq1

compress
saveold "$fintab\GMB 2020-21 prices to use for poverty lines_hhsize.dta",replace



**************************************************************************************************************************
**NATIONAL POVERTY LINES - per adult equivalent measures
**************************************************************************************************************************

use "$fintab\GMB 2020-21 prices to use for poverty lines_hhsize.dta",clear

gen valid=1
sort s1aq1
merge s1aq1 using "$fintab\Food basket_National-final_hhsize-3055.dta"
tab _m
keep if _m==3
drop  _merge 

keep if valid==1
drop valid  

ren valid_cal calper100g
ren WA_Energy_cal WA_calper100g
 
lab var calper100g "Calories from the FAO food tables per 100g"

order fdrank s1aq1 wtshare calper100g WA_calper100g natprice  
	
sort s1aq1
	
compress
saveold "$temp\prices-calories_N_hhsize.dta", replace


**********************************************************

use  "$temp\food item expenditure equal items.dta" , clear

sort s1aq1

merge m:1 s1aq1 using "$temp\prices-calories_N_hhsize.dta"
tab _m
drop _m

sort hid 
merge m:1 hid using "$temp\R_basic infor_hhsize.dta"
tab _m
drop _m

gen inbasket=1 if calper100g!=.

compress
saveold "$temp\all basket_N_hhsize.dta", replace


***********************************************************************************
****food poverty line.
*per capita poverty lines will be derived because in 2010 this was what was done by updating the previous line by CPI.
*Source (page XIV) 2010 report: In absence of national nutritional data, we could not analyze this dimension but analysis should be done by Adult Equivalent Units (AEU) in future. 
*                               The national food-poverty lines could also be developed.
*cost of a calorie using expenditures and calorie intake of reference population
*quantity (variable: Qi) is obtained by dividing expenditure by market prices, 
*Expenditure is also annual and is household weighted.
*Need to obtain per capita values. Note that quantity variable from survey is unreliable, 
*so have to obtain quantity (Qi) using expenditure and market prices.
*the items that are found in the food basket are identified as inbasket

use "$temp\all basket_N_hhsize.dta", clear

keep if inbasket==1 & (npercentile>=30 & npercentile<=55)

*expenditure here is weighted by household (it is a household level variable), but quantity is obtained by population weights

collapse (sum) sumexp=itemexp (mean) natprice calper100g WA_calper100g wta_hh_c hhsize ctry_adq, by(hid s1aq1)

gen hhcount=1
collapse (sum) Yi=sumexp Mi=hhsize Ni=ctry_adq nhhds=hhcount (mean) natprice calper100g WA_calper100g [pw=wta_hh_c], by(s1aq1)
format Yi  %18.2f
format Mi  %14.2f
format Ni  %14.2f
lab var Yi  "Sum of all expenditurs for all HHs by item"
lab var Mi  "Population consumption by item"
lab var Ni  "Adult equivalent population consumption by item"

*derive annual per adult equivalent quantities from expenditure and market price.

gen Qi=Yi/(Mi*natprice)
lab var Qi  "Quantity"

*price quantity.

gen PiQi=Qi*natprice
lab var PiQi  "Total cost of quantity"

*derive calories by item consumed.

gen QiCi=Qi*calper100g
gen QiCi_WA=Qi*WA_calper100g

*generate per capita expenditure from expenditure data (not derived quantities and prices - should be the same)

*sum of cost of all basket items
egen SPiQi=sum(PiQi) 
*sum of all item calories per kg/litre     
egen SQiCi=sum(QiCi)     
egen SQiCi_WA=sum(QiCi_WA) 

gen calperday=SQiCi/365*10   //check if this gives reasonable calories per day.  
			//If high, then it means basket selection is not ideal.
gen calperday_WA=SQiCi_WA/365*10 
sum calperday calperday_WA  //insignificant difference


*30.4 (365/12) month is one month. 0.1 is calories per 100 grams.
gen foodpline =(SPiQi/SQiCi)*2100*30.4*0.1    
gen foodpline1=(SPiQi/SQiCi)*2200*30.4*0.1
gen foodpline2=(SPiQi/SQiCi)*2400*30.4*0.1
gen foodpline3=(SPiQi/SQiCi)*2700*30.4*0.1

gen fddelete=1

preserve
collapse (first) calper100g (first) WA_calper100g,by(s1aq1)
saveold "$temp\food basket sum of calories.dta",replace
restore

collapse (first) pl_fd2100=foodpline pl_fd2200=foodpline1 pl_fd2400=foodpline2 pl_fd2700=foodpline3, by(fddelete)
label var pl_fd2100  "Food poverty line 2020-21 for 2100 calories per day"
label var pl_fd2200  "Food poverty line 2020-21 for 2200 calories per day"
label var pl_fd2400  "Food poverty line 2020-21 for 2400 calories per day"
label var pl_fd2700  "Food poverty line 2020-21 for 2700 calories per day"

compress
saveold "$temp\food poverty line_N_hhsize.dta", replace



**********************************************************
**********************************************************
****absolute/overall line for 2100 calories.
*Now bring the food poverty data and full data to obtain the absolute poverty line 

***METHOD 1: regression method

use "$fintab\Module 10 deflated consagg_hhsize.dta", clear

gen fddelete=1
sort hid fddelete

sort fddelete
merge m:1 fddelete using "$temp\food poverty line_N_hhsize.dta"
tab _m
drop _m fddelete

sort hid

sum pl_fd2100 [aw=wta_pop_c]

gen pcexp1   =(hhtexp/12)/hhsize
gen pcfdcons =(fdtexp/12)/hhsize
gen pcnfdcons=(nfdtexp/12)/hhsize
lab var pcexp1     "Monthly per capita consumption expenditure"
lab var pcfdcons   "Monthly per capita food"
lab var pcnfdcons  "Monthly per capita non-food"

gen padqexp    =(hhtexp/12)/ctry_adq
gen padqfdcons =(fdtexp/12)/ctry_adq
gen padqnfdcons=(nfdtexp/12)/ctry_adq
lab var padqexp      "Monthly per adult equivalent consumption expenditure"
lab var padqfdcons   "Monthly per adult equivalent  food"
lab var padqnfdcons  "Monthly per adult equivalent  non-food"

gen expratio=pcexp1/pl_fd2100

*Logs of the regression variables.
*pcexp+1 to avoid log of zero.
*log zero not defined.
*however this should never arise for all HHs must have per capita expenditure.

gen logcons     =log(pcexp1+1)
gen logfdpovline=log(pl_fd2100+1)
gen lnxpratio   =log(expratio)
gen lnxpratsq   =lnxpratio*lnxpratio
gen lhhsize     =log(hhsize)
gen lctry_adq   =log(ctry_adq)

gen fdshare =fdtexp/hhtexp
gen nfdshare=nfdtexp/hhtexp
lab var fdshare  "Food share to total consumption expenditure"
lab var nfdshare "Non-food share to total consumption expenditure"

regress fdshare lnxpratio lnxpratsq
gen alpha=_b[_cons]

*obtain full poverty lines.

gen pl_absREG2015=pl_fd2100 + (1-alpha)*pl_fd2100
label var pl_absREG2015 "Absolute poverty line using food poverty line"


***METHOD 2: food share (Engel's).
*Estimating Engel's coefficient directly.

bysort district: gen upbands1=(1.10)*pl_fd2100 
bysort district: gen lbands1 =(0.9)*pl_fd2100 

*obtain food share for povline .

egen engcoeff=mean(nfdshare) if pcexp1>=lbands & pcexp1<=upbands
egen mengcof =mean(engcoeff)
gen pl_absENG2015=(2-mengcof)*pl_fd2100
label var  pl_absENG2015  "Absolute poverty line using food poverty line and Engel non-food share"


***METHOD 3: non-parametric (Ravallion).
*Idea: obtain average total per capita consumption for households whose 
*food consumption is 1 percent (plus/minus) food poverty line
*repeat for hhds around plus/minus 2 percent and so on until plus/minus 10
*then take average of all averages. That becomes absolute poverty line

**This is the UPPER poverty line (Non-parametric).

foreach x of numlist 1 2 3 4 5 6 7 8 9 10 {
egen m`x'=mean(pcexp1) if pcfdcons>=(1-(`x'/100))*pl_fd2100 & pcfdcons<=(1+(`x'/100))*pl_fd2100
}
egen mnpline1 =rowmean(m1-m10)
egen mnpline11=mean(mnpline1)     //applies national mean to all HHs.
drop mnpline1
rename mnpline11 mnpline
drop m1-m10

gen plu_absRAV2015=pl_fd2100 + mnpline
label var  plu_absRAV2015 "Absolute poverty line using food poverty line and Ravallion method (upper bound)"


**This is the LOWER poverty line (Non-parametric).

foreach z of numlist 1 2 3 4 5 6 7 8 9 10 {
egen m`z'=mean(pcnfdcons) if pcfdcons>=(1-(`z'/100))*pl_fd2100 & pcfdcons<=(1+(`z'/100))*pl_fd2100
}
egen mnpline3 =rowmean(m1-m10)
egen mnpline33=mean(mnpline3)     //applies national mean to all HHs.
drop mnpline3
rename mnpline33 mnpline3
drop m1-m10

gen pll_absRAV2015=pl_fd2100 + mnpline3
label var  pll_absRAV2015 "Absolute poverty line using food poverty line and Ravallion method (lower bound)"


**METHOD 4 - Ravallion-Bidani 1994 WBER, p.88 (Lower Ravallion)**

gen pcfdshare=pcfdcons/pcexp1
foreach y of numlist 1 2 3 4 5 6 7 8 9 10 {
egen m`y'=mean(pcfdshare) if pcexp1>=(1-(`y'/100))*pl_fd2100 & pcexp<=(1+(`y'/100))*pl_fd2100
}
egen mnpline4=rowmean(m1-m10)
egen mnpline44=mean(mnpline4)
drop mnpline4
rename mnpline44 mnpline4
drop m1-m10

sum mnpline4

gen pll_absRAVBID2015=pl_fd2100*(2-mnpline4)
label var  pll_absRAVBID2015 "Absolute poverty line using food poverty line and Ravallion-Bidani 1994 WBER, p.88 (Lower bound)"


keep hid pl_fd2100  pl_fd2200  pl_fd2400  pl_fd2700  pl_absREG2015  pl_absENG2015  plu_absRAV2015  pll_absRAV2015  pll_absRAVBID2015
sum      pl_fd2100  pl_fd2200  pl_fd2400  pl_fd2700  pl_absREG2015  pl_absENG2015  plu_absRAV2015  pll_absRAV2015  pll_absRAVBID2015

gen method=2100

d
sort hid

compress
saveold "$temp\poverty lines2100_N_hhsize.dta", replace


**********************************************************
**********************************************************
****absolute/overall line for 2200 calories.
*Now bring the food poverty data and full data to obtain the absolute poverty line 

***METHOD 1: regression method

use "$fintab\Module 10 deflated consagg_hhsize.dta", clear

gen fddelete=1
sort hid fddelete

sort fddelete
merge m:1 fddelete using "$temp\food poverty line_N_hhsize.dta"
tab _m
drop _m fddelete

sort hid

sum pl_fd2200 [aw=wta_pop_c]

gen pcexp1   =(hhtexp/12)/hhsize
gen pcfdcons =(fdtexp/12)/hhsize
gen pcnfdcons=(nfdtexp/12)/hhsize
lab var pcexp1     "Monthly per capita consumption expenditure"
lab var pcfdcons   "Monthly per capita food"
lab var pcnfdcons  "Monthly per capita non-food"

gen padqexp    =(hhtexp/12)/ctry_adq
gen padqfdcons =(fdtexp/12)/ctry_adq
gen padqnfdcons=(nfdtexp/12)/ctry_adq
lab var padqexp      "Monthly per adult equivalent consumption expenditure"
lab var padqfdcons   "Monthly per adult equivalent  food"
lab var padqnfdcons  "Monthly per adult equivalent  non-food"

gen expratio=pcexp1/pl_fd2200

*Logs of the regression variables.
*pcexp+1 to avoid log of zero.
*log zero not defined.
*however this should never arise for all HHs must have per capita expenditure.

gen logcons     =log(pcexp1+1)
gen logfdpovline=log(pl_fd2200+1)
gen lnxpratio   =log(expratio)
gen lnxpratsq   =lnxpratio*lnxpratio
gen lhhsize     =log(hhsize)
gen lctry_adq   =log(ctry_adq)

gen fdshare =fdtexp/hhtexp
gen nfdshare=nfdtexp/hhtexp
lab var fdshare  "Food share to total consumption expenditure"
lab var nfdshare "Non-food share to total consumption expenditure"

regress fdshare lnxpratio lnxpratsq
gen alpha=_b[_cons]

*obtain full poverty lines.

gen pl_absREG2015=pl_fd2200 + (1-alpha)*pl_fd2200
label var pl_absREG2015 "Absolute poverty line using food poverty line"


***METHOD 2: food share (Engel's).
*Estimating Engel's coefficient directly.

bysort district: gen upbands1=(1.10)*pl_fd2200 
bysort district: gen lbands1=(0.9)*pl_fd2200 

*obtain food share for povline .

egen engcoeff=mean(nfdshare) if pcexp1>=lbands & pcexp1<=upbands
egen mengcof =mean(engcoeff)
gen pl_absENG2015=(2-mengcof)*pl_fd2200
label var  pl_absENG2015  "Absolute poverty line using food poverty line and Engel non-food share"


***METHOD 3: non-parametric (Ravallion).
*Idea: obtain average total per capita consumption for households whose 
*food consumption is 1 percent (plus/minus) food poverty line
*repeat for hhds around plus/minus 2 percent and so on until plus/minus 10
*then take average of all averages. That becomes absolute poverty line

**This is the UPPER poverty line (Non-parametric).

foreach x of numlist 1 2 3 4 5 6 7 8 9 10 {
egen m`x'=mean(pcexp1) if pcfdcons>=(1-(`x'/100))*pl_fd2200 & pcfdcons<=(1+(`x'/100))*pl_fd2200
}
egen mnpline1 =rowmean(m1-m10)
egen mnpline11=mean(mnpline1)     //applies national mean to all HHs.
drop mnpline1
rename mnpline11 mnpline
drop m1-m10

gen plu_absRAV2015=pl_fd2200 + mnpline
label var  plu_absRAV2015 "Absolute poverty line using food poverty line and Ravallion method (upper bound)"


**This is the LOWER poverty line (Non-parametric).

foreach z of numlist 1 2 3 4 5 6 7 8 9 10 {
egen m`z'=mean(pcnfdcons) if pcfdcons>=(1-(`z'/100))*pl_fd2200 & pcfdcons<=(1+(`z'/100))*pl_fd2200
}
egen mnpline3 =rowmean(m1-m10)
egen mnpline33=mean(mnpline3)     //applies national mean to all HHs.
drop mnpline3
rename mnpline33 mnpline3
drop m1-m10

gen pll_absRAV2015=pl_fd2200 + mnpline3
label var  pll_absRAV2015 "Absolute poverty line using food poverty line and Ravallion method (lower bound)"


**METHOD 4 - Ravallion-Bidani 1994 WBER, p.88 (Lower Ravallion)**

gen pcfdshare=pcfdcons/pcexp1
foreach y of numlist 1 2 3 4 5 6 7 8 9 10 {
egen m`y'=mean(pcfdshare) if pcexp1>=(1-(`y'/100))*pl_fd2200 & pcexp<=(1+(`y'/100))*pl_fd2200
}
egen mnpline4=rowmean(m1-m10)
egen mnpline44=mean(mnpline4)
drop mnpline4
rename mnpline44 mnpline4
drop m1-m10

sum mnpline4

gen pll_absRAVBID2015=pl_fd2200*(2-mnpline4)
label var  pll_absRAVBID2015 "Absolute poverty line using food poverty line and Ravallion-Bidani 1994 WBER, p.88 (Lower bound)"


keep hid pl_fd2100  pl_fd2200  pl_fd2400  pl_fd2700  pl_absREG2015  pl_absENG2015  plu_absRAV2015  pll_absRAV2015  pll_absRAVBID2015
sum      pl_fd2100  pl_fd2200  pl_fd2400  pl_fd2700  pl_absREG2015  pl_absENG2015  plu_absRAV2015  pll_absRAV2015  pll_absRAVBID2015

gen method=2200

d
sort hid

compress
saveold "$temp\poverty lines2200_N_hhsize.dta", replace


**********************************************************
**********************************************************
****absolute/overall line for 2400 calories.
*Now bring the food poverty data and full data to obtain the absolute poverty line 

***METHOD 1: regression method

use "$fintab\Module 10 deflated consagg_hhsize.dta", clear

gen fddelete=1
sort hid fddelete

sort fddelete
merge m:1 fddelete using "$temp\food poverty line_N_hhsize.dta"
tab _m
drop _m fddelete

sort hid

sum pl_fd2400 [aw=wta_pop_c]

gen pcexp1   =(hhtexp/12)/hhsize
gen pcfdcons =(fdtexp/12)/hhsize
gen pcnfdcons=(nfdtexp/12)/hhsize
lab var pcexp1     "Monthly per capita consumption expenditure"
lab var pcfdcons   "Monthly per capita food"
lab var pcnfdcons  "Monthly per capita non-food"

gen padqexp    =(hhtexp/12)/ctry_adq
gen padqfdcons =(fdtexp/12)/ctry_adq
gen padqnfdcons=(nfdtexp/12)/ctry_adq
lab var padqexp      "Monthly per adult equivalent consumption expenditure"
lab var padqfdcons   "Monthly per adult equivalent  food"
lab var padqnfdcons  "Monthly per adult equivalent  non-food"

gen expratio=pcexp1/pl_fd2400

*Logs of the regression variables.
*pcexp+1 to avoid log of zero.
*log zero not defined.
*however this should never arise for all HHs must have per capita expenditure.

gen logcons     =log(pcexp1+1)
gen logfdpovline=log(pl_fd2400+1)
gen lnxpratio   =log(expratio)
gen lnxpratsq   =lnxpratio*lnxpratio
gen lhhsize     =log(hhsize)
gen lctry_adq   =log(ctry_adq)

gen fdshare =fdtexp/hhtexp
gen nfdshare=nfdtexp/hhtexp
lab var fdshare  "Food share to total consumption expenditure"
lab var nfdshare "Non-food share to total consumption expenditure"

regress fdshare lnxpratio lnxpratsq
gen alpha=_b[_cons]

*obtain full poverty lines.

gen pl_absREG2015=pl_fd2400 + (1-alpha)*pl_fd2400
label var pl_absREG2015 "Absolute poverty line using food poverty line"


***METHOD 2: food share (Engel's).
*Estimating Engel's coefficient directly.

bysort district: gen upbands1=(1.10)*pl_fd2400 
bysort district: gen lbands1=(0.9)*pl_fd2400 

*obtain food share for povline .

egen engcoeff=mean(nfdshare) if pcexp1>=lbands & pcexp1<=upbands
egen mengcof =mean(engcoeff)
gen pl_absENG2015=(2-mengcof)*pl_fd2400
label var  pl_absENG2015  "Absolute poverty line using food poverty line and Engel non-food share"


***METHOD 3: non-parametric (Ravallion).
*Idea: obtain average total per capita consumption for households whose 
*food consumption is 1 percent (plus/minus) food poverty line
*repeat for hhds around plus/minus 2 percent and so on until plus/minus 10
*then take average of all averages. That becomes absolute poverty line

**This is the UPPER poverty line (Non-parametric).

foreach x of numlist 1 2 3 4 5 6 7 8 9 10 {
egen m`x'=mean(pcexp1) if pcfdcons>=(1-(`x'/100))*pl_fd2400 & pcfdcons<=(1+(`x'/100))*pl_fd2400
}
egen mnpline1 =rowmean(m1-m10)
egen mnpline11=mean(mnpline1)     //applies national mean to all HHs.
drop mnpline1
rename mnpline11 mnpline
drop m1-m10

gen plu_absRAV2015=pl_fd2400 + mnpline
label var  plu_absRAV2015 "Absolute poverty line using food poverty line and Ravallion method (upper bound)"


**This is the LOWER poverty line (Non-parametric).

foreach z of numlist 1 2 3 4 5 6 7 8 9 10 {
egen m`z'=mean(pcnfdcons) if pcfdcons>=(1-(`z'/100))*pl_fd2400 & pcfdcons<=(1+(`z'/100))*pl_fd2400
}
egen mnpline3 =rowmean(m1-m10)
egen mnpline33=mean(mnpline3)     //applies national mean to all HHs.
drop mnpline3
rename mnpline33 mnpline3
drop m1-m10

gen pll_absRAV2015=pl_fd2400 + mnpline3
label var  pll_absRAV2015 "Absolute poverty line using food poverty line and Ravallion method (lower bound)"


**METHOD 4 - Ravallion-Bidani 1994 WBER, p.88 (Lower Ravallion)**

gen pcfdshare=pcfdcons/pcexp1
foreach y of numlist 1 2 3 4 5 6 7 8 9 10 {
egen m`y'=mean(pcfdshare) if pcexp1>=(1-(`y'/100))*pl_fd2400 & pcexp<=(1+(`y'/100))*pl_fd2400
}
egen mnpline4=rowmean(m1-m10)
egen mnpline44=mean(mnpline4)
drop mnpline4
rename mnpline44 mnpline4
drop m1-m10

sum mnpline4

gen pll_absRAVBID2015=pl_fd2400*(2-mnpline4)
label var  pll_absRAVBID2015 "Absolute poverty line using food poverty line and Ravallion-Bidani 1994 WBER, p.88 (Lower bound)"


keep hid pl_fd2100  pl_fd2200  pl_fd2400  pl_fd2700  pl_absREG2015  pl_absENG2015  plu_absRAV2015  pll_absRAV2015  pll_absRAVBID2015
sum      pl_fd2100  pl_fd2200  pl_fd2400  pl_fd2700  pl_absREG2015  pl_absENG2015  plu_absRAV2015  pll_absRAV2015  pll_absRAVBID2015


gen method=2400

d
sort hid

compress
saveold "$temp\poverty lines2400_N_hhsize.dta", replace


**********************************************************
**********************************************************
****absolute/overall line for 2700 calories.
*Now bring the food poverty data and full data to obtain the absolute poverty line 

***METHOD 1: regression method

use "$fintab\Module 10 deflated consagg_hhsize.dta", clear

gen fddelete=1
sort hid fddelete

sort fddelete
merge m:1 fddelete using "$temp\food poverty line_N_hhsize.dta"
tab _m
drop _m fddelete

sort hid

sum pl_fd2700 [aw=wta_pop_c]

gen pcexp1   =(hhtexp/12)/hhsize
gen pcfdcons =(fdtexp/12)/hhsize
gen pcnfdcons=(nfdtexp/12)/hhsize
lab var pcexp1     "Monthly per capita consumption expenditure"
lab var pcfdcons   "Monthly per capita food"
lab var pcnfdcons  "Monthly per capita non-food"

gen padqexp    =(hhtexp/12)/ctry_adq
gen padqfdcons =(fdtexp/12)/ctry_adq
gen padqnfdcons=(nfdtexp/12)/ctry_adq
lab var padqexp      "Monthly per adult equivalent consumption expenditure"
lab var padqfdcons   "Monthly per adult equivalent  food"
lab var padqnfdcons  "Monthly per adult equivalent  non-food"

gen expratio=pcexp1/pl_fd2700

*Logs of the regression variables.
*pcexp+1 to avoid log of zero.
*log zero not defined.
*however this should never arise for all HHs must have per capita expenditure.

gen logcons     =log(pcexp1+1)
gen logfdpovline=log(pl_fd2700+1)
gen lnxpratio   =log(expratio)
gen lnxpratsq   =lnxpratio*lnxpratio
gen lhhsize     =log(hhsize)
gen lctry_adq   =log(ctry_adq)

gen fdshare =fdtexp/hhtexp
gen nfdshare=nfdtexp/hhtexp
lab var fdshare  "Food share to total consumption expenditure"
lab var nfdshare "Non-food share to total consumption expenditure"

regress fdshare lnxpratio lnxpratsq
gen alpha=_b[_cons]

*obtain full poverty lines.

gen pl_absREG2015=pl_fd2700 + (1-alpha)*pl_fd2700
label var pl_absREG2015 "Absolute poverty line using food poverty line"


***METHOD 2: food share (Engel's).
*Estimating Engel's coefficient directly.

bysort district: gen upbands1=(1.10)*pl_fd2700 
bysort district: gen lbands1=(0.9)*pl_fd2700 

*obtain food share for povline .

egen engcoeff=mean(nfdshare) if pcexp1>=lbands & pcexp1<=upbands
egen mengcof =mean(engcoeff)
gen pl_absENG2015=(2-mengcof)*pl_fd2700
label var  pl_absENG2015  "Absolute poverty line using food poverty line and Engel non-food share"


***METHOD 3: non-parametric (Ravallion).
*Idea: obtain average total per capita consumption for households whose 
*food consumption is 1 percent (plus/minus) food poverty line
*repeat for hhds around plus/minus 2 percent and so on until plus/minus 10
*then take average of all averages. That becomes absolute poverty line

**This is the UPPER poverty line (Non-parametric).

foreach x of numlist 1 2 3 4 5 6 7 8 9 10 {
egen m`x'=mean(pcexp1) if pcfdcons>=(1-(`x'/100))*pl_fd2700 & pcfdcons<=(1+(`x'/100))*pl_fd2700
}
egen mnpline1 =rowmean(m1-m10)
egen mnpline11=mean(mnpline1)     //applies national mean to all HHs.
drop mnpline1
rename mnpline11 mnpline
drop m1-m10

gen plu_absRAV2015=pl_fd2700 + mnpline
label var  plu_absRAV2015 "Absolute poverty line using food poverty line and Ravallion method (upper bound)"


**This is the LOWER poverty line (Non-parametric).

foreach z of numlist 1 2 3 4 5 6 7 8 9 10 {
egen m`z'=mean(pcnfdcons) if pcfdcons>=(1-(`z'/100))*pl_fd2700 & pcfdcons<=(1+(`z'/100))*pl_fd2700
}
egen mnpline3 =rowmean(m1-m10)
egen mnpline33=mean(mnpline3)     //applies national mean to all HHs.
drop mnpline3
rename mnpline33 mnpline3
drop m1-m10

gen pll_absRAV2015=pl_fd2700 + mnpline3
label var  pll_absRAV2015 "Absolute poverty line using food poverty line and Ravallion method (lower bound)"


**METHOD 4 - Ravallion-Bidani 1994 WBER, p.88 (Lower Ravallion)**

gen pcfdshare=pcfdcons/pcexp1
foreach y of numlist 1 2 3 4 5 6 7 8 9 10 {
egen m`y'=mean(pcfdshare) if pcexp1>=(1-(`y'/100))*pl_fd2700 & pcexp<=(1+(`y'/100))*pl_fd2700
}
egen mnpline4=rowmean(m1-m10)
egen mnpline44=mean(mnpline4)
drop mnpline4
rename mnpline44 mnpline4
drop m1-m10

sum mnpline4

gen pll_absRAVBID2015=pl_fd2700*(2-mnpline4)
label var  pll_absRAVBID2015 "Absolute poverty line using food poverty line and Ravallion-Bidani 1994 WBER, p.88 (Lower bound)"


keep hid pl_fd2100  pl_fd2200  pl_fd2400  pl_fd2700  pl_absREG2015  pl_absENG2015  plu_absRAV2015  pll_absRAV2015  pll_absRAVBID2015
sum      pl_fd2100  pl_fd2200  pl_fd2400  pl_fd2700  pl_absREG2015  pl_absENG2015  plu_absRAV2015  pll_absRAV2015  pll_absRAVBID2015


gen method=2700

d
sort hid

compress
saveold "$temp\poverty lines2700_N_hhsize.dta", replace


**********************************************************
***merge files to peruse poverty lines derived by the different calories.

use "$temp\poverty lines2100_N_hhsize.dta",clear
append using "$temp\poverty lines2200_N_hhsize.dta"
append using "$temp\poverty lines2400_N_hhsize.dta"
append using "$temp\poverty lines2700_N_hhsize.dta"

collapse (mean) pl_fd2100 pl_fd2200 pl_fd2400 pl_fd2700 pl_absREG2015 pl_absENG2015  plu_absRAV2015 pll_absRAV2015  pll_absRAVBID2015,by( method)

list method pl_fd2100 pl_fd2200 pl_fd2400 pl_fd2700 pl_absREG2015 pl_absENG2015 plu_absRAV2015 pll_absRAV2015 pll_absRAVBID2015

compress
saveold "$fintab\Poverty lines all calories_N_hhsize.dta",replace


export excel method-pll_absRAVBID2015 using "$fintab\Z-output.xls", sheet("poverty lines-pcap") sheetreplace firstrow(variables) nolabel


**********************************************************
**create separate poverty files to merge in 2015 data.

use "$fintab\Poverty lines all calories_N_hhsize.dta",clear
keep if method==2100
compress
saveold "$temp\poverty lines2100_N_new_hhsize.dta",replace


use "$fintab\Poverty lines all calories_N_hhsize.dta",clear
keep if method==2200
compress
saveold "$temp\poverty lines2200_N_new_hhsize.dta",replace


use "$fintab\Poverty lines all calories_N_hhsize.dta",clear
keep if method==2400
compress
saveold "$temp\poverty lines2400_N_new_hhsize.dta",replace


use "$fintab\Poverty lines all calories_N_hhsize.dta",clear
keep if method==2700
compress
saveold "$temp\poverty lines2700_N_new_hhsize.dta",replace


**************************************************************************************************************************
**TESTING POVERTY MEASURES BY DIFFERENT LINES - per capita measure
**************************************************************************************************************************

**2100 calories

use "$fintab\Module 10 deflated consagg_hhsize.dta", clear

gen method=2100
merge m:1 method using "$temp\poverty lines2100_N_new_hhsize.dta"
tab _m

gen pl_fd2015  =pl_fd2100*12
gen pl_ext2015 =pl_fd2015
gen plu_abs2015=plu_absRAV2015*12
gen pll_abs2015=pll_absRAV2015*12
gen plBID_abs2015=pll_absRAVBID2015*12
label var  pl_fd2015    	"Food poverty line 2015-16 (annual)"
label var  pl_ext2015   	"Extreme poverty line 2015-16 (annual)"
label var  plu_abs2015  	"Absolute poverty line 2015-16, lower (annual)"
label var  pll_abs2015  	"Absolute poverty line 2015-16, upper (annual)"
label var  plBID_abs2015 	"Absolute poverty line 2015-16, lower Rav-Biden (annual)"

svyset eanum [pweight=wta_pop_c]

sepov pc_fddr  [w=wta_pop_c], p(pl_fd2015)     
sepov pc_hhdr  [w=wta_pop_c], p(plu_abs2015)
sepov pc_hhdr  [w=wta_pop_c], p(pll_abs2015)     
sepov pc_hhdr  [w=wta_pop_c], p(plBID_abs2015)     
sepov pc_hhdr  [w=wta_pop_c], p(pl_ext)  



**2200 calories

use "$fintab\Module 10 deflated consagg_hhsize.dta", clear

gen method=2200
merge m:1 method using "$temp\poverty lines2200_N_new_hhsize.dta"
tab _m

gen pl_fd2015  	 =pl_fd2200*12
gen pl_ext2015 	 =pl_fd2015
gen plu_abs2015	 =plu_absRAV2015*12
gen pll_abs2015	 =pll_absRAV2015*12
gen plBID_abs2015=pll_absRAVBID2015*12
label var  pl_fd2015    	"Food poverty line 2015-16 (annual)"
label var  pl_ext2015   	"Extreme poverty line 2015-16 (annual)"
label var  plu_abs2015  	"Absolute poverty line 2015-16, lower (annual)"
label var  pll_abs2015  	"Absolute poverty line 2015-16, upper (annual)"
label var  plBID_abs2015 	"Absolute poverty line 2015-16, lower Rav-Biden (annual)"

svyset eanum [pweight=wta_pop_c]

sepov pc_fddr  [w=wta_pop_c], p(pl_fd2015)     
sepov pc_hhdr  [w=wta_pop_c], p(plu_abs2015)
sepov pc_hhdr  [w=wta_pop_c], p(pll_abs2015)     
sepov pc_hhdr  [w=wta_pop_c], p(plBID_abs2015)     
sepov pc_hhdr  [w=wta_pop_c], p(pl_ext) 


**2400 calories

use "$fintab\Module 10 deflated consagg_hhsize.dta", clear

gen method=2400
merge m:1 method using "$temp\poverty lines2400_N_new_hhsize.dta"
tab _m

gen pl_fd2015    =pl_fd2400*12
gen pl_ext2015   =pl_fd2015
gen plu_abs2015  =plu_absRAV2015*12
gen pll_abs2015	 =pll_absRAV2015*12
gen plBID_abs2015=pll_absRAVBID2015*12
label var  pl_fd2015    	"Food poverty line 2015-16 (annual)"
label var  pl_ext2015   	"Extreme poverty line 2015-16 (annual)"
label var  plu_abs2015  	"Absolute poverty line 2015-16, lower (annual)"
label var  pll_abs2015  	"Absolute poverty line 2015-16, upper (annual)"
label var  plBID_abs2015 	"Absolute poverty line 2015-16, lower Rav-Biden (annual)"

replace pl_fd2015 = 11794.66*1.4
replace plu_abs2015 = 18039.95*1.4

svyset eanum [pweight=wta_pop_c]


/*
sepov pc_fddr  [w=wta_pop_c], p(pl_fd2015)     
sepov pc_hhdr  [w=wta_pop_c], p(plu_abs2015)
sepov pc_hhdr  [w=wta_pop_c], p(pll_abs2015)     
sepov pc_hhdr  [w=wta_pop_c], p(plBID_abs2015)     
sepov pc_hhdr  [w=wta_pop_c], p(pl_ext) 
*/

sepov pc_fddr1  [w=wta_pop_c], p(pl_fd2015)     
sepov pc_hhdr1  [w=wta_pop_c], p(plu_abs2015)
sepov pc_hhdr1 [w=wta_pop_c], p(pll_abs2015)     
sepov pc_hhdr1  [w=wta_pop_c], p(plBID_abs2015)     
sepov pc_hhdr1  [w=wta_pop_c], p(pl_ext) 



**2700 calories

use "$fintab\Module 10 deflated consagg_hhsize.dta", clear

gen method=2700
merge m:1 method using "$temp\poverty lines2700_N_new_hhsize.dta"
tab _m

gen pl_fd2015    =pl_fd2700*12
gen pl_ext2015   =pl_fd2015
gen plu_abs2015  =plu_absRAV2015*12
gen pll_abs2015	 =pll_absRAV2015*12
gen plBID_abs2015=pll_absRAVBID2015*12
label var  pl_fd2015    	"Food poverty line 2015-16 (annual)"
label var  pl_ext2015   	"Extreme poverty line 2015-16 (annual)"
label var  plu_abs2015  	"Absolute poverty line 2015-16, lower (annual)"
label var  pll_abs2015  	"Absolute poverty line 2015-16, upper (annual)"
label var  plBID_abs2015 	"Absolute poverty line 2015-16, lower Rav-Biden (annual)"

svyset eanum [pweight=wta_pop_c]

sepov pc_fddr  [w=wta_pop_c], p(pl_fd2015)     
sepov pc_hhdr  [w=wta_pop_c], p(plu_abs2015)
sepov pc_hhdr  [w=wta_pop_c], p(pll_abs2015) 
sepov pc_hhdr  [w=wta_pop_c], p(plBID_abs2015)     
sepov pc_hhdr  [w=wta_pop_c], p(pl_ext) 


**************************************************************************************************************************
**IMPACT OF ADJUSTING ABSOLUTE POVERTY LINE BY 5%, 10% AND 15% 
**************************************************************************************************************************

use "$fintab\Module 10 deflated consagg_hhsize.dta", clear

gen method=2400
merge m:1 method using "$temp\poverty lines2400_N_new_hhsize.dta"
tab _m

gen pl_fd  	 =pl_fd2400*12
gen pl_ext 	 =pl_fd
gen pl_abs	 =pll_absRAV2015*12
label var  pl_fd   "Food poverty line 2014 (annual)"
label var  pl_abs  "Absolute poverty line 2014 (annual)"
label var  pl_ext  "Extreme poverty line 2014 (annual)"
sum pl_fd  pl_abs

svyset eanum [pweight=wta_pop_c]

sepov pc_hhdr [w=wta_pop_c], p(pl_abs)  
sepov pc_hhdr [w=wta_pop_c], p(pl_abs)  by(rururb)

*poverty line reductions
gen pl0095=pl_abs*0.95
sepov pc_hhdr [w=wta_pop_c], p(pl0095)
sepov pc_hhdr [w=wta_pop_c], p(pl0095) by(rururb)

gen pl0090=pl_abs*0.90
sepov pc_hhdr [w=wta_pop_c], p(pl0090)
sepov pc_hhdr [w=wta_pop_c], p(pl0090) by(rururb)

gen pl0085=pl_abs*0.85
sepov pc_hhdr [w=wta_pop_c], p(pl0085)
sepov pc_hhdr [w=wta_pop_c], p(pl0085) by(rururb)

gen pl0080=pl_abs*0.80
sepov pc_hhdr [w=wta_pop_c], p(pl0080)
sepov pc_hhdr [w=wta_pop_c], p(pl0080) by(rururb)

*poverty line increase

gen pl0005=pl_abs*1.05
sepov pc_hhdr [w=wta_pop_c], p(pl0005)
sepov pc_hhdr [w=wta_pop_c], p(pl0005) by(rururb)

gen pl0010=pl_abs*1.10
sepov pc_hhdr [w=wta_pop_c], p(pl0010)
sepov pc_hhdr [w=wta_pop_c], p(pl0010) by(rururb)

gen pl0015=pl_abs*1.15
sepov pc_hhdr [w=wta_pop_c], p(pl0015)
sepov pc_hhdr [w=wta_pop_c], p(pl0015) by(rururb)

gen pl0020=pl_abs*1.20
sepov pc_hhdr [w=wta_pop_c], p(pl0020)
sepov pc_hhdr [w=wta_pop_c], p(pl0020) by(rururb)


sum pl0095 pl0090 pl0085 pl0080 pl_abs pl0005 pl0010 pl0015 pl0020



**************************************************************************************************************************
**MERGE IN POVERTY LINES and FINALIZE WELFARE MEASURE FILE
**************************************************************************************************************************
**Note: per capita poverty lines

use "$fintab\Module 10 deflated consagg_hhsize.dta", clear

gen method=2400
merge m:1 method using "$temp\poverty lines2400_N_new_hhsize.dta"
tab _m

gen pl_fd  =pl_fd2400*12
gen pl_ext =pl_fd 
gen pl_abs =pll_absRAV2015*12
label var  pl_fd    "Food poverty line 2020-21 (annual)"
label var  pl_abs   "Absolute poverty line 2020-21(annual)"
*the extreme line shows that even if household spent all they had on food, they cannot satisfy the basic food minimum needs.
label var  pl_ext   "Extreme poverty line 2020-21 (annual)"


**********************************************************
**create poor or non-poor variable.

gen poor_fd = (pc_fddr<pl_fd)
lab var poor_fd  "Food poor"
lab define poor_fd 1 "Poor" 0 "Non-poor"
lab val poor_fd poor_fd

gen poor_abs = (pc_hhdr<pl_abs)
lab var poor_abs  "Absolute poor"
lab define poor_abs 1 "Poor" 0 "Non-poor"
lab val poor_abs poor_abs

gen poor_ext =(pc_hhdr<pl_ext)
lab var poor_ext  "Extreme poor"
lab define poor_ext 1 "Poor" 0 "Non-poor"
lab val poor_ext poor_ext 

tab poor_abs
tab poor_abs [aw=wta_pop_c]


**********************************************************
*finalize welfare file

drop method-_merge month

d

sort hid

compress
save "$fintab\GMB_IHS2020_E_hhsize.dta",replace


**********************************************************
*extract quintile file which can be emerged with other files.

use "$fintab\GMB_IHS2020_E_hhsize.dta", clear

keep  hid wta_hh_c wta_pop_c hhsize pc_fd pc_fd pc_hh padq_fd padq_hh quintile nquintil ndecil   ///
	pc_fddr pc_hhdr padq_fddr padq_hhdr dfquin ndfquin ndfdecil   ///
	pl_fd pl_abs pl_ext poor_fd poor_abs poor_ext  
	
order hid wta_hh_c wta_pop_c hhsize pc_fd pc_fd pc_hh padq_fd padq_hh quintile nquintil ndecil   ///
	pc_fddr pc_hhdr padq_fddr padq_hhdr dfquin ndfquin ndfdecil   ///
	pl_fd pl_abs pl_ext poor_fd poor_abs poor_ext 

sort hid

compress
saveold "$fintab\GMB_IHS2020_E quintiles_hhsize.dta", replace

tabstat poor_abs  [weight=wta_pop_c]

tabstat poor_fd [weight=wta_pop_c]

**************
** THE END
**************


merge 1:1 hid using "$temp\hhsize.dta"
keep if _m==3
drop _m

tabstat poor_abs  [weight=wta_pop_c],by(quarter)
tabstat poor_abs  [weight=wta_pop_c],by(rururb)
tabstat poor_abs  [weight=wta_pop_c],by(lga)