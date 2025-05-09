*************************************************************************************************************************************
*************************************************************************************************************************************
******** GAMBIA IHS 2015/16 File merging for all quarters
******** Prepared by Gambia Bureau of Statistics
******** Technical assistance provided by World Bank
******** Funding provided by UNDP, World Bank, UNICEF, FAO,  
*************************************************************************************************************************************
*************************************************************************************************************************************

clear
set more off
cap log close


***define the directory

gl drive		C:\Users\wb102942\OneDrive - WBG\Desktop\hhdbase\GMB\IHS2020       // Drive and folder directory.  Change as needed

gl data     	${drive}\Data
gl do	     	${drive}\dofile
gl log	     	${drive}\logfile
gl temp     	${drive}\temp
gl fintab     	${drive}\output\consumption


cap log 1d GMB 2020 food file organization
log using "$log\1d GMB 2020 food file organization food.log" , replace


********************************************************************************************************************************************************
********************************************************************************************************************************************************
******************* PART B FOOD *******************
********************************************************************************************************************************************************
********************************************************************************************************************************************************
**merge all the food edits by various Teams 

use "$temp\PART B Section 1A-Food_consumption expenditure-portion1_editted.dta", clear 

append using "$temp\PART B Section 1A-Food_consumption expenditure-portion2_editted.dta"

drop hhsize-tot_consumed

sort hid s1aq1

compress 
save "$data\Stata\PART B Section 1A-Food_consumption expenditure.dta", replace


*********************************************************************************
** Sect 1B - Food away from home
use "$data\Original\Raw PART 2\SECT01BQ1Q2 - FOOD DRINKS AWAY FROM HOME.dta" , clear 
*use "C:\Users\wb102942\OneDrive - WBG\SECT01BQ1Q2 - FOOD DRINKS AWAY FROM HOME.dta" , clear 
count 
renvars,l
duplicates drop

ta s1bq1,m
ta s1bq2,m

sort settlement eanum select_hhold s1bq1

clonevar select_hhold_dup  = select_hhold
//Household head name: MODOU BOYE
replace select_hhold = 100 if eanum == 63229 & select_hhold_dup == 11 & intervdate == 12022020
//Household head name: FARAMBA SANYANG
replace select_hhold = 100 if eanum == 75104 & select_hhold_dup == 85 & intervdate == 15072020
//Household head name: MALANG NJIE
replace select_hhold = 111 if eanum == 75104 & select_hhold_dup == 91 & intervdate == 18082020

replace settlement=35125  if settlement==1    & lga==3 & eanum==35115
replace settlement=75101  if settlement==12   & lga==7 & eanum==75106
replace settlement=70109  if settlement==70   & lga==7 & eanum==70113
replace settlement=41210  if settlement==4012 & lga==4 & eanum==41204
replace settlement=43115  if settlement==4311 & lga==4 & eanum==43108

ta s1bq1,m
duplicates tag (settlement eanum select_hhold s1bq1),gen(dup)
ta dup  //44 obs
bys settlement eanum select_hhold s1bq1: gen countdup=_n
ta countdup 
drop if s1bq2==3 & s1bq3==. & dup==1 & countdup==2  //20 obs
drop dup 
duplicates tag (settlement eanum select_hhold s1bq1),gen(dup)
ta dup  //4 duplicates 
br settlement eanum select_hhold s1bq1 s1bq2 s1bq1_os s1bq3 if dup==1
drop if dup==1 & s1bq2==3
drop dup 
duplicates tag (settlement eanum select_hhold s1bq1),gen(dup)
ta dup  //2 duplicates 

renvars lga lga_name quarter district name_distr settlmnt_name area intervdate intervday intervmonth intervyear / lga1 lga_name1 quarter1 district2 name_distr1 settlmnt_name1 area1 intervdate1 intervday1 intervmonth1 intervyear1 

merge m:1 settlement eanum select_hhold using "$data\Stata\PART A Date of interview.dta"
ta _m 
ta s1bq1  if dup==1
drop dup 
drop if _m==1

la var s1bq1_os "S1BQ1 - OTHER Specify"

gen PT2_Sect_1="PART 2 Section 1B"
la var PT2_Sect_1 "PART 2 Section 1B"

la var eanum    "EA number"

drop lga1 lga_name1 quarter1 district2 name_distr1 settlmnt_name1 area1 intervdate1 intervday1 intervmonth1 intervyear1 intervcode intervname field_supervisor field_supervisor_name hhold_name telephon1 telephon2 telephon3 interview_date interview_start_time interview_start_hours interview_start_minutes interview_end_time interview_end_hours interview_end_minutes interview_status b_food_drinks_away_from_home select_hhold_dup countdup int_day int_month int_year yearmth year_mth _merge

ta s1bq1,m
tab1 s1bq2-s1bq3 if s1bq1==.
drop if s1bq1==.  //about 209 HHs had no food expenditure

 foreach i of numlist 3 4 6 7 8 {
  replace  s1aq`i'b =. if s1aq`i'a ==0
  recode  s1aq`i'a (0 =.)
  }
  
order hid lga quarter district district1 area settlement settlement_name eanum select_hhold PT2_Sect_1

sort hid s1bq1

compress 
save "$data\Stata\PART B Section 1B-Food outside.dta", replace


********************************************************************************************************************************************************
********************************************************************************************************************************************************
