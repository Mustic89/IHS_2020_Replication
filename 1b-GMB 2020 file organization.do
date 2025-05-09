*************************************************************************************************************************************
*************************************************************************************************************************************
******** GAMBIA IHS 2015/16 File merging for all quarters
******** Prepared by Gambia Bureau of Statistics
******** Technical assistance provided by World Bank
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


cap log 1b GMB 2020 file organization food 
log using "$log\1b GMB 2020 file organization food.log" , replace


********************************************************************************************************************************************************
********************************************************************************************************************************************************
******************* PART B FOOD *******************
********************************************************************************************************************************************************
********************************************************************************************************************************************************
** Merge all quarters for each Section
** perform some basic checks to allow merging
* if don't know = assign .d
* if missing    = assign .m
* if refusal    = assign .r
* if outlier    = assign .o

********************************************************************************
*** SECTION 1 - FOOD CONSUMPTION EXPENDITURE 

** Sect 1A - Food consumption expenditure

use "$data\Original\Raw PART 2\SECT01AQ1Q2 -FOOD EXPENDITURE.dta" , clear 
*use "C:\Users\wb102942\OneDrive - WBG\GBoS data\SECT01AQ1Q2 -FOOD EXPENDITURE.dta" ,clear
count 
renvars,l
duplicates drop

drop del15 del16 intervname field_supervisor field_supervisor_name hhold_name telephon1 telephon2 telephon3 interview_date interview_start_time interview_start_hours interview_start_minutes interview_end_time interview_end_hours interview_end_minutes interview_status section_1a_food_consumption_expe intervcode

sort settlement eanum select_hhold s1aq1

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

ta s1aq1,m
duplicates tag (settlement eanum select_hhold s1aq1),gen(dup)
ta dup  //584 obs
bys settlement eanum select_hhold s1aq1: gen countdup=_n
ta countdup
drop if s1aq2==2 & s1aq3a==. & s1aq3b==. & s1aq4a==. & s1aq4b==. & s1aq5==. & s1aq6a==. & s1aq6b==. & s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==. & dup==1 & countdup==2  //265 obs drop 
drop dup 
duplicates tag (settlement eanum select_hhold s1aq1),gen(dup)
ta dup  //54 obs

renvars lga lga_name quarter district name_distr settlmnt_name area intervdate intervday intervmonth intervyear / lga1 lga_name1 quarter1 district2 name_distr1 settlmnt_name1 area1 intervdate1 intervday1 intervmonth1 intervyear1 

ta s1aq2,m 
drop if s1aq2==. 

merge m:1 settlement eanum select_hhold using "$data\Stata\PART A Date of interview.dta"
ta _m 
ta s1aq1  if dup==1
br hid s1aq1 intervmonth1 intervyear1 int_month int_year dup if dup==1
drop if dup==1 & intervmonth1==2 & int_year==2020  //27 obs dropped.  Dropped due to month difference for same HH  
drop dup 
drop if _m==1
drop _m 
gen valid=1

recode s1aq4a s1aq6a (else=5)  if hid=="1110111112004" & s1aq1==164
recode s1aq4b s1aq6b (else=6)  if hid=="1110111112004" & s1aq1==164
replace s1aq5=s1aq5/10  if hid=="1110111112004" & s1aq1==164
 
merge m:1 hid using "$temp\hhsize.dta"
ta _merge
drop if valid==. 
drop valid 
drop _m 

duplicates tag (settlement eanum select_hhold s1aq1),gen(dup)
ta dup

drop lga1 lga_name1 quarter1 district2 name_distr1 settlmnt_name1 area1 intervdate1 intervday1 intervmonth1 intervyear1 

numlabel, add 

recode s1aq3a s1aq3b (0=.)  if s1aq3a==0  & s1aq3b==0  //if consumption/expenditure==0 and unit==0 make as missing
recode s1aq4a s1aq4b (0=.)  if s1aq4a==0  & s1aq4b==0
recode s1aq6a s1aq6b (0=.)  if s1aq6a==0  & s1aq6b==0  
recode s1aq7a s1aq7b (0=.)  if s1aq7a==0  & s1aq7b==0
recode s1aq8a s1aq8b (0=.)  if s1aq8a==0  & s1aq8b==0
replace s1aq5=.  if s1aq5==0 & s1aq4a==0  & s1aq4b==0
replace s1aq5=.  if s1aq5==0 & s1aq4a==.  & s1aq4b==.

replace s1aq6a=.  if s1aq6a==0 
replace s1aq6b=.  if s1aq6a==.
replace s1aq7a=.  if s1aq7a==0 
replace s1aq7b=.  if s1aq7a==.
replace s1aq8a=.  if s1aq8a==0 
replace s1aq8b=.  if s1aq8a==.
replace s1aq5=.   if s1aq5==0

order settlement-select_hhold s1aq1_os s1aq2,last
order hid hhsize 

compress 
save "$temp\food_1A.dta",replace   //call file, keep if s1aq2==2 and merge with the below



keep if s1aq2==2 
compress 
save "$temp\food_1A_notconsumed.dta",replace  //merge back after the edits


***keep small file for manageabilty and merge later.
use "$temp\food_1A.dta",clear
ta s1aq2
keep if s1aq2==1
compress 
save "$temp\food_1A_consumed.dta",replace 



use "$temp\food_1A_consumed.dta",clear 

sort hid s1aq1 

gen valid=1    if s1aq3a==s1aq4a & s1aq3a==s1aq6a & s1aq7a==. & s1aq8a==.
gen valid1=1   if valid==1 & (s1aq3b==s1aq4b & s1aq3b==s1aq6b & s1aq7b==. & s1aq8b==.)
gen validHH=1  if valid==1 & valid1==1  
ta validHH //262K

gen err=1  if valid==. & s1aq3a>s1aq6a  
ta err  //about 3K obs

gen dfg=1   if s1aq4a==0 & s1aq6a~=.
br if dfg==1 & s1aq1<=5
gen dfg1=1  if dfg==1 & s1aq1<=5
replace s1aq4a=1   if dfg1==1 & s1aq5~=.
recode s1aq4a s1aq4b (else=.)  if dfg1==1 & s1aq4a==0
replace s1aq7a=s1aq3a   if dfg1==1 & s1aq4a==. & s1aq6a~=. & s1aq8a==. 
replace s1aq7b=s1aq3b   if dfg1==1 & s1aq4a==. & s1aq6b~=. & s1aq8b==.
recode s1aq6a s1aq6b (else=.)  if dfg1==1 & s1aq5==.
gen checked=1     if dfg1==1
drop dfg1 
br if dfg==1 & checked==. 
replace s1aq4a=s1aq3a  if dfg==1 & s1aq1==16 & hid=="8610586109013" 
replace s1aq3a=6       if dfg==1 & s1aq1==158 & hid=="6121661217015" 
drop dfg 
gen dfg=1   if s1aq4a==0 & s1aq6a~=.
recode s1aq4a-s1aq6b (else=.)  if dfg==1 & s1aq7a~=.
recode s1aq4a-s1aq7b (else=.)  if dfg==1 & s1aq8a~=.
replace s1aq7a=s1aq3a  if dfg==1 & s1aq3a==s1aq6a & s1aq8a==. & s1aq8b==. 
replace s1aq7b=s1aq3b  if dfg==1 & s1aq3a==s1aq6a & s1aq8a==. & s1aq8b==. 
recode s1aq4a-s1aq6b (else=.)  if dfg==1 & s1aq5==.
replace s1aq8a=s1aq3a   if dfg==1 & s1aq8a~=.
replace s1aq8b=s1aq3b   if dfg==1 & s1aq8b~=.
replace s1aq7a=s1aq3a   if dfg==1 & s1aq7a~=.
replace s1aq7b=s1aq3b   if dfg==1 & s1aq7b~=.
recode s1aq4a-s1aq6b (else=.)  if dfg==1
replace s1aq7a=s1aq3a   if dfg==1 & (s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==.)
replace s1aq7b=s1aq3b   if dfg==1 & (s1aq7a~=. & s1aq7b==. & s1aq8a==. & s1aq8b==.)
replace checked=1  if dfg==1 & checked==.
recode s1aq4a s1aq4b s1aq6a s1aq6b (else=.)  if hid=="4110341105010" & s1aq1==37 

gen hjk=1    if s1aq1==157 & s1aq3a>=21 & s1aq3a~=.
replace s1aq3a=s1aq4a  	 if hjk==1 & s1aq1==157 & hid=="3240832455014" 
replace s1aq7a=s1aq3a    if hjk==1 & s1aq5==.
replace s1aq7b=s1aq3b    if hjk==1 & s1aq5==.
recode s1aq4a-s1aq6b (else=.)  if hjk==1 & s1aq5==.
recode s1aq3a s1aq7a (68=6)  if hjk==1 & hid=="6121661217015"
replace checked=1     if checked==. & hjk==1
drop hjk 

gen hjk=1  if s1aq1==157 & s1aq3b==0
recode s1aq4a s1aq4b (else=.)   if hjk==1 & s1aq5==.
replace s1aq3a=s1aq8a  if hjk==1 & s1aq8a~=. 
replace s1aq3b=s1aq8b  if hjk==1 & s1aq8b~=. 
replace s1aq3b=6  if hjk==1  
replace checked=1     if checked==. & hjk==1
drop hjk 

ta s1aq3b if s1aq1==157
gen hjk=1  if s1aq1==157 & (s1aq3b<6 | s1aq3b==10)
replace s1aq6b=6   if hjk==1 & s1aq6b==0
replace s1aq6b=6   if hjk==1 & s1aq6b==2
replace s1aq6b=6   if hjk==1 & s1aq6b==5
replace s1aq5=30  if hjk==1 & s1aq5==1 
replace s1aq3a=s1aq6a  if hjk==1 & s1aq6a~=. 
replace s1aq3b=s1aq6b  if hjk==1 & s1aq6b~=.  
recode s1aq8a-s1aq8b (else=.)  if hjk==1
replace s1aq7b=6  if hjk==1 & s1aq7b~=.
replace s1aq3a=s1aq7a  if hjk==1 & s1aq7a~=. 
replace s1aq3b=s1aq7b  if hjk==1 & s1aq7b~=.  
recode s1aq4a-s1aq4b (else=.)  if hjk==1 & s1aq5==.
replace s1aq4b=s1aq3b  if hjk==1 & s1aq4b~=.  
drop hjk 

ta s1aq4b if s1aq1==157
gen hjk=1  if s1aq1==157 & s1aq4b<6
recode s1aq4a-s1aq4b (else=.)  if hjk==1 & s1aq5==.
replace s1aq7a=s1aq3a  if hjk==1 & s1aq5==. 
replace s1aq7b=s1aq3b  if hjk==1 & s1aq5==. 
replace s1aq4a=s1aq3a  if hjk==1 & s1aq4a~=. 
replace s1aq4b=s1aq3b  if hjk==1 & s1aq4b~=. 
replace checked=1       if checked==. & hjk==1
drop hjk 

ta s1aq6b if s1aq1==157
gen hjk=1   if s1aq1==157 & (s1aq6b<6 | s1aq6b==7 | s1aq6b==14)
recode s1aq3b s1aq4b s1aq6b (else=1) if hjk==1 & hid=="8511285124012"
replace s1aq6a=s1aq3a  if hjk==1 & s1aq6a~=. 
replace s1aq6b=s1aq3b  if hjk==1 & s1aq6b~=. 
recode s1aq7a-s1aq7b (else=.)   if hjk==1
replace checked=1       if checked==. & hjk==1
drop hjk 

ta s1aq7b if s1aq1==157
gen hjk=1   if s1aq1==157 & s1aq7b<6
replace s1aq7a=s1aq3a  if hjk==1 & s1aq7a~=. 
replace s1aq7b=s1aq3b  if hjk==1 & s1aq7b~=. 
recode s1aq7a-s1aq8b (else=.)   if hjk==1 & s1aq5~=.
recode s1aq4a-s1aq6b (else=.)   if hjk==1 & s1aq5==.
replace checked=1       if checked==. & hjk==1
drop hjk 

ta s1aq8b if s1aq1==157
gen hjk=1   if s1aq1==157 & (s1aq8b<6 | s1aq8b==9)
replace s1aq8a=s1aq3a  if hjk==1 & s1aq8a~=. 
replace s1aq8b=s1aq3b  if hjk==1 & s1aq8b~=. 
recode s1aq8a-s1aq8b (else=.)   if hjk==1 & s1aq5~=.
recode s1aq4a-s1aq6b (else=.)   if hjk==1 & s1aq5==.
replace checked=1       if checked==. & hjk==1
drop hjk 
replace checked=1       if checked==. & s1aq1==157
replace checked=1       if checked==. & dfg==1 
*drop dfg

gen ghj=1  if s1aq1==158 & s1aq3a>40 & s1aq3a~=.
replace s1aq6a=s1aq5  if ghj==1 & hid=="3060530638008" 
replace s1aq5=s1aq4a  if ghj==1 & hid=="3060530638008"
recode s1aq7a s1aq7b (else=.)  if ghj==1 & s1aq1==158 & hid=="3060530638008"
replace s1aq5=s1aq4a  if ghj==1 & hid=="3060530638008"
replace s1aq4a=s1aq6a  if ghj==1 & hid=="3060530638008" 
replace s1aq3a=s1aq6a  if ghj==1 & s1aq6a~=. 
replace s1aq3b=99      if ghj==1 & s1aq3a==98 
replace s1aq3a=6       if ghj==1 & s1aq3a==98 
replace s1aq7b=99      if ghj==1 & s1aq7a==98 
replace s1aq7a=6       if ghj==1 & s1aq7a==98 
replace s1aq8b=99      if ghj==1 & s1aq8a==98 
replace s1aq8a=6       if ghj==1 & s1aq8a==98 
replace s1aq5=s1aq4a   if ghj==1 & hid=="4311543111015"
recode s1aq3a s1aq4a s1aq6a (42=7)  if ghj==1 & hid=="4311543111015"
replace checked=1  if checked==. & ghj==1

ta s1aq3a if s1aq1==158
recode s1aq3b s1aq4b s1aq6b (6=1)  if s1aq1==158 & s1aq3a<1
replace checked=1  if checked==. & s1aq1==158 & s1aq3a<1
replace s1aq6a=s1aq3a   if s1aq1==158 & s1aq3a==1.5
replace s1aq6b=s1aq3b   if s1aq1==158 & s1aq3a==1.5
recode s1aq7a s1aq7b (else=.)  if hid=="8420184207014" & s1aq1==158 
replace checked=1  if hid=="8420184207014" & s1aq1==158 
drop ghj

recode s1aq4a s1aq4b (else=.)  if s1aq1==158 & s1aq3a>30 & s1aq5==.
replace checked=1    if s1aq1==158 & (s1aq3a>30 & s1aq3a~=.)

count if  s1aq1==158 & s1aq4a==. & s1aq4b==. & s1aq5~=.  //17 obs
gen ghj=1  if  s1aq1==158 & s1aq4a==. & s1aq4b==. & s1aq5~=. 
replace s1aq5=.  if ghj==1 & s1aq7a~=. 
replace s1aq4a=s1aq3a  if ghj==1 & s1aq5~=.
replace s1aq4b=s1aq3b  if ghj==1 & s1aq5~=. 
replace s1aq6a=s1aq3a  if ghj==1 & s1aq5~=.
replace s1aq6b=s1aq3b  if ghj==1 & s1aq5~=.
replace checked=1  if checked==. & ghj==1 
drop ghj 

gen ghj=1  if s1aq1==158 & s1aq5==. & s1aq4a~=.
recode s1aq4a s1aq4b (else=.)  if ghj==1 & s1aq5==.
replace s1aq7a=s1aq3a  if ghj==1 & s1aq5==. & s1aq8a==. 
replace s1aq7b=s1aq3b  if ghj==1 & s1aq5==. & s1aq8b==. 
recode s1aq6a s1aq6b (else=.)  if ghj==1 & s1aq5==.
replace checked=1  if checked==. & ghj==1 
drop ghj 

gen ghj=1  if s1aq3b==0 & s1aq1==158
recode s1aq6a s1aq6b (else=.)  if ghj==1 & s1aq5==.
replace s1aq3b=s1aq4b  if ghj==1 & s1aq4b~=. 
replace s1aq3b=s1aq6b  if ghj==1 & s1aq6b~=. 
replace s1aq3b=s1aq7b  if ghj==1 & s1aq3b==0 & s1aq7b~=. 
recode s1aq3b s1aq7b (else=11)   if ghj==1 & s1aq3b==0
replace s1aq7b=s1aq3b  if s1aq1==158 & s1aq7b==0
drop ghj 

gen hjk=1  if s1aq1==158 & s1aq3b==2
recode s1aq4a-s1aq6b (else=.)  if hid=="5023050213011" & s1aq1==158 
replace s1aq3b=11  if hjk==1 
replace s1aq4b=11  if hjk==1 & s1aq4b~=.
replace s1aq6b=11  if hjk==1 & s1aq6b~=. 
replace s1aq7b=11  if hjk==1 & s1aq7b~=.
replace s1aq5=20    if hjk==1 & hid=="2230122330012"
replace s1aq4a=s1aq3a   if hjk==1 & hid=="2230122330012" 
replace s1aq6a=s1aq3a   if hjk==1 & hid=="2230122330012" 
recode s1aq7a s1aq7b (else=.)  if hjk==1 & hid=="2230122330012"  
replace checked=1  if checked==. & hjk==1
drop hjk 

gen hjk=1  if s1aq1==158 & (s1aq3b==3 | s1aq3b==4) 
replace s1aq5=s1aq4a  if hjk==1
replace s1aq3b=11  if hjk==1 
replace s1aq4b=11  if hjk==1 & s1aq4b~=.
replace s1aq6b=11  if hjk==1 & s1aq6b~=. 
replace s1aq7b=11  if hjk==1 & s1aq7b~=.
recode s1aq7a s1aq7b (else=.)  if hjk==1  
replace s1aq4a=s1aq3a   if hjk==1 & s1aq4a~=.
replace s1aq6a=s1aq3a   if hjk==1 & s1aq4a~=.
replace s1aq7a=s1aq3a  if hjk==1 & (hid=="7440574420012" | hid=="8210382110015")
replace s1aq7b=s1aq3b  if hjk==1 & (hid=="7440574420012" | hid=="8210382110015")
recode s1aq4a-s1aq6b (else=.)   if hjk==1 & (hid=="7440574420012" | hid=="8210382110015")
replace checked=1  if checked==. & hjk==1
drop hjk 
 
replace s1aq3b=11  if s1aq3b==12 & s1aq1==158
replace s1aq4b=11  if s1aq4b==12 & s1aq1==158
replace s1aq6b=11  if s1aq6b==12 & s1aq1==158
replace s1aq3b=6   if s1aq3b==5 & s1aq1==158
replace s1aq4b=6   if s1aq4b==5 & s1aq1==158
replace s1aq6b=6   if s1aq6b==5 & s1aq1==158


gen hjk=1  if s1aq1==158 & s1aq3b==14
replace s1aq3b=11  if hjk==1 
replace s1aq4b=11  if hjk==1 & s1aq4b~=.
replace s1aq6b=11  if hjk==1 & s1aq6b~=. 
replace s1aq7b=6  if hjk==1 & s1aq7b~=.
replace s1aq6a=s1aq5/7  if hjk==1
replace s1aq3a=s1aq6a  if hjk==1 & s1aq6a~=.
replace s1aq4a=s1aq6a  if hjk==1
recode s1aq7a s1aq7b (else=.)  if hjk==1 & (hid=="5220952204012" | hid=="5222152223013")
replace checked=1  if checked==. & hjk==1

drop hjk

replace s1aq4b=s1aq6b  if s1aq1==158 & s1aq4b==3 
replace s1aq4b=s1aq6b  if s1aq1==158 & s1aq4b==4 

gen hjk=1  if s1aq1==158 & s1aq6b==0
replace s1aq6a=s1aq3a  if hjk==1
replace s1aq6b=s1aq3b  if hjk==1
drop hjk

replace s1aq6b=s1aq4b  if s1aq1==158 & (s1aq6b>=2 & s1aq6b<=4)

recode s1aq7a-s1aq8b (else=.)  if s1aq1==158 & hid=="3810438110012" 
recode s1aq7a-s1aq8b (else=.)  if s1aq1==158 & hid=="8110881184010" 
recode s1aq3b s1aq4b s1aq6b (else=6)  if s1aq1==158 & hid=="6430764305006" 
replace s1aq5=s1aq4a   if s1aq1==158 & hid=="6430764305006" 
recode s1aq3a s1aq4a s1aq6a (else=11)  if s1aq1==158 & hid=="6430764305006" 
recode s1aq7a s1aq7b (else=.)  if s1aq1==158 & hid=="6430764305006" 

ta s1aq8b   if s1aq1==158 
gen hjk=1   if s1aq8b<6 & s1aq1==158 
recode s1aq7a s1aq7b (else=.) if hjk==1
replace s1aq8b=.   if hjk==1 
replace s1aq8a=.   if hjk==1 & s1aq8b==.
replace s1aq8a=s1aq3a  if hjk==1 & s1aq5==.
replace s1aq8b=s1aq3b  if hjk==1 & s1aq5==.
drop hjk

gen hjk=1  if s1aq1==158 & (s1aq8b>6 & s1aq8b<11)
drop hjk
/*
gen ghj=1  if dfg==1 & s1aq8a~=. & checked==.
replace s1aq8a=s1aq3a   if ghj==1
replace s1aq8b=s1aq3b   if ghj==1
recode s1aq4a s1aq4b s1aq6a s1aq6b (else=.)  if ghj==1
replace checked=1  if ghj==1
drop ghj 

gen dfg1=1   if dfg==1 & (s1aq6a~=. & s1aq6b~=. & s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==.)
replace s1aq4a=.  if s1aq4a==0
replace s1aq4b=.  if s1aq4a==.
drop dfg1 

gen dfg1=1   if dfg==1 & s1aq5==. & (s1aq6a~=. & s1aq6b~=. & s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==.)
replace s1aq7a=s1aq3a  if dfg1==1 
replace s1aq7b=s1aq3b  if dfg1==1 
replace s1aq6a=.       if dfg1==1 
replace s1aq6b=.       if dfg1==1 
replace checked=1      if checked==. & dfg1==1
drop dfg1 
 */
/*gen asd=1   if s1aq4a==0 & s1aq4b==14
br if s1aq4a==0 & s1aq4b==14
gen asd==1  if s1aq4a>1000 & s1aq5~=.


replace s1aq4a=1  if asd==1 & (s1aq5>1000 & s1aq5<2000) 
recode s1aq4a s1aq4b (else=.)  if asd==1 & s1aq5==.
*/
drop dfg 
gen dfg=1  if s1aq1<5 & (s1aq4a==. & s1aq5==. & s1aq6a==. & s1aq6b==. & s1aq7a==. & s1aq7b==. & s1aq8a~=.)
replace s1aq3a=s1aq8a   if dfg==1 & hid=="3134331356005"
replace s1aq8a=s1aq3a   if dfg==1
replace s1aq8b=s1aq3b   if dfg==1
replace s1aq3b=10  if dfg==1 & s1aq3b==0
replace s1aq8b=10  if dfg==1 & s1aq8b==0
replace checked=1  if checked==. & dfg==1
drop dfg 

/*run tis when checking item
replace s1aq7a=s1aq3a   if s1aq1==164 & hid=="5411654115009"
replace s1aq3b=1		if s1aq1==164 & hid=="5411654115009"
replace s1aq7b=s1aq3b   if s1aq1==164 & hid=="5411654115009"

replace s1aq7a=s1aq3a   if s1aq1==164 & hid=="8620386216002"
replace s1aq3b=1		if s1aq1==164 & hid=="8620386216002"
replace s1aq7b=s1aq3b   if s1aq1==164 & hid=="8620386216002"

replace s1aq7a=s1aq3a   if s1aq1==164 & hid=="8620386216003"
replace s1aq3b=1		if s1aq1==164 & hid=="8620386216003"
replace s1aq7b=s1aq3b   if s1aq1==164 & hid=="8620386216003"

replace s1aq7a=s1aq3a   if s1aq1==164 & hid=="6430764302008"
replace s1aq3b=1		if s1aq1==164 & hid=="6430764302008"
replace s1aq7b=s1aq3b   if s1aq1==164 & hid=="6430764302008"

replace s1aq7a=s1aq3a   if s1aq1==178 & hid=="6410764121003"
replace s1aq3b=1		if s1aq1==178 & hid=="6410764121003"
replace s1aq7b=s1aq3b   if s1aq1==178 & hid=="6410764121003"

replace s1aq3b=1		if s1aq1==178 & hid=="6311163120008"
replace s1aq8b=s1aq3b   if s1aq1==178 & hid=="6311163120008"

replace s1aq4b=s1aq3b  if s1aq1==178 & hid=="6210262113007"
recode s1aq3b s1aq6b (14=10)    if s1aq1==3 & hid=="3050330585011"
replace s1aq4b=1   if s1aq1==3 & hid=="3050330585011"
recode s1aq3b s1aq6b (6=10)    if s1aq1==3 & hid=="3311633110008"
*/
count if (s1aq3b!=s1aq4b & s1aq3b!=. & s1aq4b!=.) | (s1aq3b!= s1aq6b & s1aq3b!=. & s1aq6b!=.) | (s1aq3b != s1aq7b & s1aq3b!=. & s1aq7b!=.) | (s1aq3b!= s1aq8b & s1aq3b!=. & s1aq8b!=.) | (s1aq4b!= s1aq6b & s1aq4b!=. & s1aq6b!=.)| (s1aq4b != s1aq7b & s1aq4b!=. & s1aq7b!=.) | (s1aq4b != s1aq8b & s1aq4b!=. & s1aq8b!=.)| (s1aq6b!= s1aq7b & s1aq6b!=. & s1aq7b!=.)| (s1aq6b != s1aq8b & s1aq6b!=. & s1aq8b!=.) | (s1aq7b != s1aq8b & s1aq7b!=. & s1aq8b!=.)
gen asd=1 if (s1aq3b!=s1aq4b & s1aq3b!=. & s1aq4b!=.) | (s1aq3b != s1aq6b & s1aq3b!=. & s1aq6b!=.) | (s1aq3b != s1aq7b & s1aq3b!=. & s1aq7b!=.) | (s1aq3b!= s1aq8b & s1aq3b!=. & s1aq8b!=.) | (s1aq4b != s1aq6b & s1aq4b!=. & s1aq6b!=.)| (s1aq4b != s1aq7b & s1aq4b!=. & s1aq7b!=.) | (s1aq4b!= s1aq8b & s1aq4b!=. & s1aq8b!=.) | (s1aq6b!= s1aq7b & s1aq6b!=. & s1aq7b!=.)| (s1aq6b != s1aq8b & s1aq6b!=. & s1aq8b!=.) | (s1aq7b!= s1aq8b & s1aq7b!=. & s1aq8b!=.)

sort hid s1aq1 

/*br if asd==1 & s1aq4b==14
gen dfg=1  if asd==1 & s1aq4b==14 & (s1aq4a>=1000 & s1aq4a!=.) & s1aq4a==s1aq5
ta dfg  //14 observations
replace s1aq4a=1   if dfg==1
drop dfg 
*/
gen dfg=1  if s1aq4b==14 & s1aq4a<1000 & s1aq4a==s1aq5

gen cork=s1aq5
replace s1aq5=s1aq6a   if dfg==1 & ((hid=="5111951130005" & s1aq1==169) | (hid=="6312063123016"& s1aq1==194) | (hid=="6320963209016" & s1aq1==256) | (hid=="8510485131001" & s1aq1==256))
recode s1aq3a s1aq4a s1aq6a (else=28)  if dfg==1 & hid=="3410334101004"
recode s1aq3b s1aq4b s1aq6b (else=10)  if dfg==1 & s1aq1==4 & hid=="3050230506012"
recode s1aq3b s1aq4b s1aq6b (else=6)   if dfg==1 & s1aq1==259 & hid=="4210242107011"
recode s1aq3b s1aq4b s1aq6b (else=6)   if dfg==1 & s1aq1==169 & hid=="5111951130005"
recode s1aq3b s1aq4b s1aq6b (else=6)   if dfg==1 & s1aq1==194 & hid=="6312063123016"
recode s1aq3b s1aq4b s1aq6b (else=5)   if dfg==1 & s1aq1==256 & (hid=="6320963209016" | hid=="8510485131001")
replace s1aq4a=s1aq3a  if dfg==1
replace s1aq4b=s1aq3b  if dfg==1
replace s1aq6a=s1aq3a  if dfg==1
replace s1aq6b=s1aq3b  if dfg==1
recode s1aq7a s1aq7b (else=.) if dfg==1
replace checked=1      if checked==. & dfg==1
drop dfg 

gen asdd=1  if s1aq4b==14 & s1aq1>=270
recode s1aq8a s1aq8b (else=.)  if asdd==1
replace s1aq3b=13   if asdd==1 & s1aq1==273 
replace s1aq4b=s1aq3b    if asdd==1
replace s1aq6b=s1aq4b    if asdd==1
replace checked=1      if checked==. & asdd==1
drop asdd  
 
ta s1aq3b if s1aq1>=268
gen asdd=1  if s1aq3b==1 & s1aq1>=268
recode s1aq4a-s1aq6b (else=.)  if asdd==1 & (hid=="4210242105013" | hid=="5220152222015" | hid=="6411864118011")
recode s1aq4a-s1aq6b (else=.)  if asdd==1 & s1aq5==.

recode s1aq3b s1aq4b s1aq6b (else=12)   if asdd==1 & s1aq1==272 
recode s1aq3b s1aq4b s1aq6b (else=13)   if asdd==1 & (s1aq1==268 | s1aq1==273 | s1aq1==268 | s1aq1==286 | s1aq1==287)
recode s1aq3b s1aq4b s1aq6b (else=6)    if asdd==1 & s1aq1==269 
replace s1aq4b=s1aq3b   if asdd==1 & s1aq4b~=.
replace s1aq6b=s1aq3b   if asdd==1 & s1aq6b~=.
replace s1aq7b=s1aq3b   if asdd==1 & s1aq7b~=.
replace s1aq8b=s1aq3b   if asdd==1 & s1aq8b~=.
replace s1aq6a=s1aq3a   if asdd==1 
recode s1aq4a-s1aq6b (else=.)  if asdd==1 & s1aq5==.
replace checked=1      if checked==. & asdd==1 
drop asdd 

gen asdd=1  if s1aq1>=268 & s1aq3b<3
replace s1aq5=.  if asdd==1 & s1aq5<20
recode s1aq3b s1aq4b s1aq6b (else=3)    if asdd==1 & s1aq1==281
recode s1aq3b s1aq4b s1aq6b (else=6)    if asdd==1 & s1aq1==279
recode s1aq3b s1aq4b s1aq6b (else=12)   if asdd==1 & s1aq1==272 
recode s1aq3b s1aq4b s1aq6b (else=13)   if asdd==1 & (s1aq1==268 | s1aq1==273 | s1aq1==278 | s1aq1==280 | s1aq1==282 | s1aq1==283 | s1aq1==284 | s1aq1==286 | s1aq1==287 | s1aq1==289 | s1aq1==291 | s1aq1==290)
recode s1aq3b s1aq4b s1aq6b (else=6)    if asdd==1 & (s1aq1==269 | s1aq1==271) 
recode s1aq4a-s1aq6b (else=.)  if asdd==1 & s1aq5==.
replace s1aq8a=s1aq3a   if asdd==1 & s1aq8a~=.
replace s1aq8b=s1aq3b   if asdd==1 & s1aq8b~=.
replace s1aq8a=s1aq3a   if asdd==1 & (s1aq4a==. & s1aq4b==. & s1aq5==. & s1aq6a==. & s1aq6b==. & s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==.)
replace s1aq8b=s1aq3b   if asdd==1 & (s1aq4a==. & s1aq4b==. & s1aq5==. & s1aq6a==. & s1aq6b==. & s1aq7a==. & s1aq7b==. & s1aq8a~=. & s1aq8b==.)
replace checked=1      if checked==. & asdd==1  
drop asdd


gen asdd=1  if s1aq1>=268 & s1aq3b<3
drop asdd 

gen asdd=1  if s1aq1>=268 & s1aq3b==10
recode s1aq3b s1aq4b s1aq6b (10=3)  if asdd==1 & s1aq1==287 
recode s1aq3b s1aq4b s1aq6b (10=6)  if asdd==1 & (s1aq1==269 | s1aq1==271)
recode s1aq4a-s1aq6b (else=.)  if asdd==1 & s1aq5==.
replace s1aq8a=s1aq3a   if asdd==1 & (s1aq4a==. & s1aq4b==. & s1aq5==. & s1aq6a==. & s1aq6b==. & s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==.)
replace s1aq8b=s1aq3b   if asdd==1 & (s1aq4a==. & s1aq4b==. & s1aq5==. & s1aq6a==. & s1aq6b==. & s1aq7a==. & s1aq7b==. & s1aq8a~=. & s1aq8b==.)
drop asdd 

replace s1aq6a=s1aq3a   if s1aq1==272 & hid=="3810138105011"
replace s1aq6b=s1aq3b   if s1aq1==272 & hid=="3810138105011"
replace checked=1       if checked==. & (s1aq1==272 & hid=="3810138105011")
 
gen asdd=1  if s1aq1>=268 & s1aq4b<3
replace s1aq5=s1aq4a   if asdd==1 & s1aq1==272 & hid=="4021340214005"
replace s1aq4a=s1aq3a   if asdd==1 & s1aq1==272 & hid=="4021340214005"
replace s1aq6b=s1aq3b   if asdd==1 & s1aq1==272 & hid=="4021340214005"
replace s1aq4a=s1aq3a   if asdd==1 & s1aq1==272 & hid=="4021340214005"
recode s1aq4a-s1aq6b (else=.)  if asdd==1 & s1aq5==.
replace s1aq8a=s1aq3a   if asdd==1 & (s1aq4a==. & s1aq4b==. & s1aq5==. & s1aq6a==. & s1aq6b==. & s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==.)
replace s1aq8b=s1aq3b   if asdd==1 & (s1aq4a==. & s1aq4b==. & s1aq5==. & s1aq6a==. & s1aq6b==. & s1aq7a==. & s1aq7b==. & s1aq8a~=. & s1aq8b==.)
replace checked=1       if checked==. & asdd==1 
drop asdd 

gen asdd=1  if s1aq1>=268 & s1aq6b<3
replace s1aq5=70  if asdd==1 & s1aq5==707
replace s1aq5=210       if asdd==1 & s1aq1==270 & hid=="4210442101009" 
replace s1aq6b=s1aq3b   if asdd==1 & s1aq1==270 & hid=="4210442101009" 
replace s1aq4a=s1aq6a   if asdd==1 & s1aq1==270 & hid=="4210442101009" 
recode s1aq8a s1aq8b (else=.)  if asdd==1 & (hid=="5612056108003")
recode s1aq4a-s1aq6b (else=.)  if asdd==1 & s1aq5==.
replace s1aq8a=2     if asd==1 & hid=="5012550139009"
replace s1aq4b=s1aq3b   if asdd==1 & s1aq4b~=.
replace s1aq6b=s1aq3b   if asdd==1 & s1aq6b~=.
replace s1aq7b=s1aq3b   if asdd==1 & s1aq7b~=.
replace s1aq8b=s1aq3b   if asdd==1 & s1aq8b~=.
replace s1aq8a=s1aq3a   if asdd==1 & (s1aq4a==. & s1aq4b==. & s1aq5==. & s1aq6a==. & s1aq6b==. & s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==.)
replace s1aq8b=s1aq3b   if asdd==1 & (s1aq4a==. & s1aq4b==. & s1aq5==. & s1aq6a==. & s1aq6b==. & s1aq7a==. & s1aq7b==. & s1aq8a~=. & s1aq8b==.)
replace checked=1       if checked==. & asdd==1 
drop asdd 

gen asdd=1  if s1aq1==269 & s1aq3b==4
recode s1aq3b s1aq4b s1aq6b s1aq7b s1aq8b (4=3)  if asdd==1 & (s1aq3b~=. | s1aq4b~=. | s1aq6b~=. | s1aq7b~=. | s1aq8b~=.)
replace s1aq6b=s1aq3b   if asdd==1 & s1aq1==269 & hid=="4110241106002"
replace checked=1       if checked==. & asdd==1 
drop asdd 

gen asd1=1 if (s1aq3b!=s1aq4b & s1aq3b!=. & s1aq4b!=.) | (s1aq3b != s1aq6b & s1aq3b!=. & s1aq6b!=.) | (s1aq3b != s1aq7b & s1aq3b!=. & s1aq7b!=.) | (s1aq3b!= s1aq8b & s1aq3b!=. & s1aq8b!=.) | (s1aq4b != s1aq6b & s1aq4b!=. & s1aq6b!=.)| (s1aq4b != s1aq7b & s1aq4b!=. & s1aq7b!=.) | (s1aq4b!= s1aq8b & s1aq4b!=. & s1aq8b!=.) | (s1aq6b!= s1aq7b & s1aq6b!=. & s1aq7b!=.)| (s1aq6b != s1aq8b & s1aq6b!=. & s1aq8b!=.) | (s1aq7b!= s1aq8b & s1aq7b!=. & s1aq8b!=.)  
//about 13K obs with issues.  Fix the easy ones first

br if s1aq4a==50 & s1aq4b==14
gen dfg=1   if s1aq4a==50 & s1aq4b==14
//166 obs.  2-step fixing 
replace s1aq5=.   if dfg==1
replace s1aq3b=6   if dfg==1 & (s1aq1==154 | s1aq1==164) & s1aq3b==14
replace s1aq3b=10   if dfg==1 & s1aq3b==14
replace s1aq3b=10   if dfg==1 & s1aq1==1 &  hid=="7440674410013"
replace s1aq7a=s1aq3a  if dfg==1 & s1aq5==.
replace s1aq7b=s1aq3b  if dfg==1 & s1aq5==.
recode s1aq4a-s1aq6b (else=.)  if dfg==1 & s1aq5==.
replace checked=1       if checked==. & dfg==1 
drop dfg 

br if s1aq4b==14 & (s1aq4a>=2 & s1aq4a~=.)
gen dfg=1   if s1aq4b==14 & (s1aq4a>=2 & s1aq4a~=.)
gen dfg1=1  if dfg==1 & (s1aq1==16 | s1aq1==17)
recode s1aq4a-s1aq6b (else=.)  if dfg1==1 & (hid=="3821338206003" | hid=="6411764109007")
recode s1aq3b s1aq4b s1aq6b (else=6)  if dfg1==1 & (s1aq3b~=. | s1aq4b~=. | s1aq6b~=. | s1aq7b~=. | s1aq8b~=.)
recode s1aq4a-s1aq6b (else=.)  if dfg==1 & s1aq5==.
recode s1aq7a-s1aq8b (else=.)  if dfg==1 & s1aq5~=.
replace s1aq7a=s1aq3a  if dfg1==1 & s1aq5==.
replace s1aq7b=s1aq3b  if dfg1==1 & s1aq5==.
replace checked=1       if checked==. & dfg1==1 
drop dfg dfg1 

gen dfg=1   if s1aq4b==14 & (s1aq4a>=2 & s1aq4a~=.)
gen dfg1=1  if dfg==1 & (s1aq1>=226)
replace s1aq5=s1aq4a   if dfg1==1 & s1aq1==257 & hid=="6411764109001"
replace s1aq4a=s1aq3a  if dfg1==1 & s1aq1==257 & hid=="6411764109001"
replace s1aq5=s1aq4a   if dfg1==1 & s1aq1==260 & hid=="3090230919016"
replace s1aq4a=s1aq3a  if dfg1==1 & s1aq1==260 & hid=="3090230919016"
replace s1aq3b=6    if dfg1==1 & s1aq1==258 & s1aq3b==14
replace s1aq3b=99   if dfg1==1 & s1aq1==226 & s1aq3b==14
replace s1aq3b=6    if dfg1==1 & s1aq1==256 & s1aq3b==14
replace s1aq6a=s1aq3a  if dfg1==1  
replace s1aq6b=s1aq3b  if dfg1==1 
replace s1aq4a=s1aq3a  if dfg1==1 & s1aq1~=226
replace s1aq4b=s1aq3b  if dfg1==1 & s1aq1~=226 
replace s1aq3a=1   if s1aq1==226 & hid=="4011140114016" 
replace checked=1       if checked==. & dfg1==1 
gen dfg0=1   if s1aq1==226
drop dfg1

gen dfg1=1  if s1aq4b==14 & ((s1aq4a>=2 & s1aq4a~=.) & s1aq1<=5)
replace s1aq3a=s1aq6a  if dfg1==1 & s1aq1==1 & hid=="3211032132004"
replace checked=1       if checked==. & dfg1==1 

gen dfg2=1   if dfg1==1 & s1aq5<500
replace s1aq5=s1aq4a   if dfg2==1 & (s1aq4a==147 | s1aq4a==1250)
replace s1aq5=s1aq4a*1250   if dfg2==1 & s1aq4a==5
replace s1aq6a=s1aq3a  if dfg2==1
replace s1aq6b=s1aq3b  if dfg2==1
replace s1aq4b=s1aq3b   if dfg2==1 & s1aq4a==147
replace s1aq4a=s1aq3a   if dfg2==1 & s1aq4a==147
replace s1aq4a=1  if dfg2==1 & s1aq4a==1250
replace dfg1=.  if dfg2==1 
replace checked=1       if checked==. & dfg2==1 
drop dfg2 
gen dfg2=1   if dfg1==1 & s1aq5<1000
recode s1aq3b s1aq6b (14=10)  if dfg2==1
replace s1aq4b=0.5  if dfg2==1
replace dfg1=.  if dfg2==1 
drop dfg2 
gen dfg2=1   if dfg1==1 & s1aq5<1250
replace s1aq6a=s1aq3a  if dfg1==1 & (s1aq1==4 & hid=="3110231139016" | s1aq1==3 & hid=="4220442209001")
replace s1aq6b=s1aq3b  if dfg1==1 & (s1aq1==4 & hid=="3110231139016" | s1aq1==3 & hid=="4220442209001")
recode s1aq3b s1aq6b (13 14=10)  if dfg2==1
replace s1aq4a=1  if dfg2==1 
replace dfg1=.  if dfg2==1 
replace checked=1       if checked==. & dfg2==1 
drop dfg2 
gen dfg2=1   if dfg1==1 & s1aq4a>1000
replace s1aq3a=s1aq4b  if dfg2==1 & s1aq3b==14
replace s1aq4a=1  if dfg2==1
replace s1aq6a=s1aq3a if dfg2==1
replace s1aq6b=s1aq3b if dfg2==1
replace dfg1=.  if dfg2==1 
replace checked=1       if checked==. & dfg2==1 
drop dfg2 
gen dfg2=1   if dfg1==1 & s1aq3a==s1aq4a & s1aq4a==s1aq6a 
recode s1aq3a s1aq6a (364=36) if dfg1==1 & hid=="6311563111006"
replace s1aq3b=1  if dfg2==1 & s1aq1==1 & (hid=="2340123460003" | hid=="4410644110011")
replace s1aq3b=10  if dfg2==1 & s1aq3b==14
replace s1aq3b=14  if dfg2==1 & (hid=="8020480214001" | hid=="8020480214002" | hid=="8020480214003")
replace s1aq6b=s1aq3b  if dfg2==1
replace s1aq5=1250  if dfg2==1 & s1aq5==11250 
replace s1aq4a=1  if dfg2==1 & s1aq5<2000
replace s1aq4a=2  if dfg2==1 & (s1aq5>2000 & s1aq5<3500)
replace s1aq4a=3  if dfg2==1 & (s1aq5>3500 & s1aq5<4500)
replace dfg1=.  if dfg2==1 
replace checked=1       if checked==. & dfg2==1 
drop dfg2 
replace s1aq3b=10 if dfg1==1 & s1aq1==1 & hid=="4520145212002"
replace s1aq3b=10  if dfg1==1 & s1aq3b==14 
replace s1aq6b=s1aq3b  if dfg1==1
replace s1aq4a=1  if dfg1==1 & s1aq5<2000 & s1aq4a~=1 
replace s1aq6a=s1aq3a if dfg1==1
replace s1aq6b=s1aq3b if dfg1==1
replace checked=1       if checked==. & dfg==1 
drop dfg1 

gen asdd=1  if s1aq4b==14 & (s1aq4a>=2 & s1aq4a~=.) & (s1aq5>=1000 & s1aq5~=.) & s1aq4a>6
replace s1aq4a=1  if asdd==1  
replace s1aq3b=s1aq6b  if asdd==1 & s1aq1==12 & hid=="8611386125003"
replace s1aq3b=10  if asdd==1 & s1aq3b==14
replace s1aq6b=s1aq3b  if asdd==1
replace checked=1  if checked==. & asdd==1
drop asdd 

gen asdd=1  if s1aq4b==14 & (s1aq4a>=2 & s1aq4a~=.) & (s1aq5>=1000 & s1aq5~=.)
gen asdd1=1  if asdd==1 & s1aq3b==14
recode s1aq3b s1aq6b (14=9) if asdd1==1 & s1aq1==114
recode s1aq4a-s1aq6b (else=.) if asdd1==1 & s1aq1==114
replace s1aq7a=s1aq3a  if asdd1==1 & s1aq1==114 
replace s1aq7b=s1aq3b  if asdd1==1 & s1aq1==114
recode s1aq3b s1aq6b (14=11) if asdd1==1 & s1aq1==164
recode s1aq4a-s1aq6b (else=.) if asdd1==1 & s1aq1==164
replace s1aq7a=s1aq3a  if asdd1==1 & s1aq1==164 
replace s1aq7b=s1aq3b  if asdd1==1 & s1aq1==164
recode s1aq3b (14=1)  if asdd1==1 & (s1aq1==6 | s1aq1==7) 
replace s1aq6b=s1aq3b if asdd1==1 & s1aq6b~=.
replace checked=1  if checked==. & asdd==1
drop asdd1

gen asdd1=1  if asdd==1 & s1aq5<=2500
//all good 
replace checked=1  if checked==. & asdd1==1

gen asdd2=1  if asdd==1 & s1aq5<2500
drop asdd asdd1 asdd2   

gen asdd=1  if (s1aq4a>=1000 & s1aq4a~=.) & s1aq1<=8  //17 cases
replace s1aq4a=.  if asdd==1 & (s1aq4a>1500 & s1aq4a~=.) 
replace s1aq5=s1aq4a  if asdd==1 & s1aq5==.
replace s1aq4a=s1aq3a  if asdd==1 & s1aq5<400
replace s1aq4b=s1aq3b  if asdd==1 & s1aq5<400
replace s1aq3a=s1aq6a  if asdd==1 & s1aq1==6 & hid=="5530155311012"
replace s1aq3b=s1aq6b  if asdd==1 & s1aq1==6 & hid=="5530155311012"
replace s1aq4a=1  if asdd==1 & s1aq4a>=1000
replace s1aq4b=14 if asdd==1 & s1aq5>=1000
replace s1aq6a=s1aq3a if asdd==1 & s1aq6a~=.
replace s1aq6b=s1aq3b if asdd==1 & s1aq6b~=.
replace s1aq6a=s1aq3a if asdd==1 & s1aq6a==. & s1aq5~=.
replace s1aq6b=s1aq3b if asdd==1 & s1aq6b==. & s1aq5~=.
recode s1aq4a-s1aq6b (else=.)  if asdd==1 & (hid=="5022350219001" | hid=="8020580242004")
recode s1aq7a-s1aq7b (else=.)  if asdd==1 & hid=="5530155311012"
replace s1aq7a=s1aq3a if asdd==1 & s1aq7a==. & s1aq5==.
replace s1aq7b=s1aq3b if asdd==1 & s1aq7b==. & s1aq5==.
replace checked=1      if checked==. & asdd==1 
drop asdd 
 
replace s1aq4a=s1aq3a  if hid=="6430364311009" & s1aq5==s1aq4a & s1aq5~=. 
replace s1aq6a=s1aq3a  if hid=="6430364311009" & s1aq5~=. & s1aq6a==. 
replace s1aq6b=s1aq3b  if hid=="6430364311009" & s1aq5~=. & s1aq6b==. 
replace s1aq7a=s1aq3a  if hid=="6430364311009" & s1aq5==. & s1aq7a==. & s1aq8a==. 
replace s1aq7b=s1aq3b  if hid=="6430364311009" & s1aq5==. & s1aq6b==. & s1aq8a==.  
replace checked=1      if checked==. & hid=="6430364311009" 

ta s1aq3b  if s1aq1<=4
gen asds=1  if s1aq1<=4 & s1aq3b==15
replace s1aq5=s1aq3a  if s1aq3a>1000
replace s1aq4b=14  if asds==1 
replace s1aq4a=1   if asds==1 
replace s1aq3a=s1aq6a  if asds==1
replace s1aq3b=s1aq6b  if asds==1
replace checked=1      if checked==. & asds==1 
drop asds 

gen asds=1  if s1aq1<=4 & s1aq3b==2
replace s1aq5=1230   if asds==1 & s1aq5==12130
replace s1aq4a=1  if asds==1 & (s1aq5>1000 & s1aq5~=.) 
replace s1aq4b=14  if asds==1 & (s1aq5>1000 & s1aq5~=.) 
recode s1aq3b s1aq6b (else=10)   if asds==1 & s1aq3b==2 & (s1aq3a>=10 & s1aq3a~=.)
recode s1aq3b s1aq6b (else=1)    if asds==1 & s1aq3b==2 & s1aq3a<10
recode s1aq4a-s1aq6b (else=.) if asds==1 & (s1aq5==. | s1aq5<10)
replace s1aq8b=1  if asds==1 & s1aq8b~=.
replace s1aq7a=s1aq3a  if asds==1 & s1aq5==. & s1aq8a==.
replace s1aq7b=s1aq3b  if asds==1 & s1aq7a~=.
replace checked=1      if checked==. & asds==1  
drop asds 

gen asds=1  if s1aq1<=4 & s1aq3b==.  //2 obs no infor
replace s1aq2=2    if s1aq2==1 & asds==1
drop asds 

gen asds=1  if s1aq1<=4 & s1aq3b==0
replace s1aq3b=s1aq6b   if asds==1 & s1aq6a~=0 & s1aq3a==s1aq6a
replace s1aq3b=s1aq7b   if asds==1 & s1aq7a~=0 & s1aq3a==s1aq7a
recode s1aq4a-s1aq6b (else=.)  if asds==1 & s1aq5==.
recode s1aq4a-s1aq6b (else=.)  if asds==1 & s1aq1==3 & hid=="4021340217003"
replace s1aq5=.  if asds==1 & s1aq4b==.
recode s1aq3b s1aq4b s1aq6b s1aq7b s1aq8b (11=10) if asds==1   //Mohammed suggested this change
recode s1aq3b s1aq4b s1aq6b s1aq7b s1aq8b (12=10) if asds==1   //Mohammed suggested this change 
replace s1aq3a=9  if asds==1 & s1aq1==1 & hid=="6420364203008"
replace s1aq3b=10  if asds==1 & s1aq3b==0
replace s1aq4b=10  if asds==1 & s1aq4b==0
replace s1aq6b=10  if asds==1 & s1aq6b==0
replace s1aq7b=10  if asds==1 & s1aq7b==0
replace s1aq8b=10  if asds==1 & s1aq8b==0
replace s1aq7a=s1aq3a       if asds==1 & (s1aq4a==. & s1aq6a==. & s1aq7a==. & s1aq8a==.) 
replace s1aq7b=s1aq3b  if asds==1 & s1aq7a~=. & s1aq7b==. 
replace checked=1      if checked==. & asds==1  
drop asds

gen asds=1  if s1aq1<=4 & s1aq3b==99
*replace s1aq6a=s1aq3a  if asds==1 & s1aq6b==1 
*replace s1aq6b=s1aq3b  if asds==1 & s1aq6b==1 
*replace s1aq3b=s1aq6b  if asds==1 & s1aq6b~=99 & s1aq3a==s1aq6a 
replace s1aq4a=1   if asds==1 & (s1aq5>=1000 & s1aq5<2000)
replace s1aq4a=2   if asds==1 & (s1aq5>=2000 & s1aq5<3000)
replace s1aq4b=14  if asds==1 & (s1aq5>=1000 & s1aq5~=.)
recode s1aq4a-s1aq6b (else=.)  if asds==1 & s1aq5==.
recode s1aq8a s1aq8b (else=.)  if asds==1 & s1aq8a==s1aq3a & s1aq5~=. 
replace s1aq6a=s1aq3a  if asds==1 & (s1aq6a==. & s1aq7a==. & s1aq8a==.) 
replace s1aq6b=s1aq3b  if asds==1 & s1aq6a~=. & s1aq6b==. 
replace s1aq7a=s1aq3a   if asds==1  & (s1aq4a==. & s1aq6a==. & s1aq7a==. & s1aq8a==.) 
replace s1aq7b=s1aq3b  if asds==1 & s1aq7a~=. & s1aq7b==. 
replace s1aq5=.  if asds==1 & s1aq4a==.
replace checked=1      if checked==. & asds==1  
drop asds 

replace s1aq3b=s1aq6b  if s1aq1==3 & hid=="3211032132005"
replace s1aq4a=1       if s1aq1==3 & hid=="3211032132005"
replace s1aq4b=14      if s1aq1==3 & hid=="3211032132005"
replace s1aq3b=s1aq6b    if s1aq1==105 & hid=="6311963128001"

count if s1aq4a==. & s1aq4b==. & s1aq5~=.  //2777 obs
*br if s1aq4a==. & s1aq4b==. & s1aq5~=.
gen asds=1   if s1aq4a==. & s1aq4b==. & s1aq5~=.
replace s1aq5=.  if asds==1 & s1aq5==s1aq6a
recode s1aq4a-s1aq6b (else=.) if asds==1 & s1aq7a~=. 
gen asds1=1  if asds==1 & s1aq3a~=s1aq7a & s1aq7a~=.
replace s1aq3a=s1aq7a   if asds1==1 & s1aq3a==1000
replace s1aq3a=s1aq7a  if asds1==1 & s1aq1==156 & hid=="8210382110016"
replace s1aq3b=s1aq7b  if asds1==1 & s1aq1==156 & hid=="8210382110016"
replace s1aq3a=s1aq7a  if asds1==1 & s1aq1==187 & hid=="8610986122006"
replace s1aq3b=s1aq7b  if asds1==1 & s1aq1==187 & hid=="8610986122006"
replace s1aq7a=s1aq3a   if asds1==1
replace s1aq7b=s1aq3b   if asds1==1 
drop asds1 
gen asds1=1  if asds==1 & s1aq3b~=s1aq7b & s1aq7b~=.
replace s1aq3b=10   if asds1==1 & s1aq3b==0
replace s1aq7a=s1aq3a   if asds1==1
replace s1aq7b=s1aq3b   if asds1==1
drop asds1 
gen asds1=1  if asds==1 & s1aq3a~=s1aq8a & s1aq8a~=.
replace s1aq3a=s1aq8a   if asds1==1 & s1aq3a==1010
replace s1aq3b=6   if asds==1 & s1aq1==256 & hid=="8621986204014"
replace s1aq3b=10  if asds==1 & s1aq1==178 & hid=="5211152102010"
replace s1aq8a=s1aq3a   if asds1==1
replace s1aq8b=s1aq3b   if asds1==1 
drop asds1 
gen asds1=1  if asds==1 & s1aq3b~=s1aq8b & s1aq8b~=.
replace s1aq3b=s1aq8b   if asds==1 & s1aq1==150 & hid=="4410244105001"
replace s1aq3b=s1aq8b  if asds==1 & s1aq1==105 & hid=="4510345114011"
replace s1aq8b=s1aq3b   if asds1==1
drop asds1
gen asds1=1  if asds==1 & s1aq5~=. & s1aq4a==. & s1aq6a~=.  //358 obs.  For rice easy fix (118 obs). Others too much work and will move them to s1aq7a 
ge asds2=1  if asds1==1 & s1aq1<5 
recode s1aq4a-s1aq6b (else=.)  if asds2==1 & s1aq5==s1aq3a & s1aq5<100
replace s1aq4a=1   if asds2==1 & (s1aq5>=1000 & s1aq5<2000)
replace s1aq4a=2   if asds2==1 & (s1aq5>=2000 & s1aq5<3000)
replace s1aq4b=14  if asds2==1 & (s1aq5>=1000 & s1aq5~=.)
replace s1aq4a=.5  if asds2==1 & s1aq5==650
replace s1aq4b=14  if asds2==1 & s1aq5==650 
replace s1aq4a=s1aq3a  if asds2==1 & s1aq3b==1 & s1aq4b~=14
replace s1aq4b=s1aq3b  if asds==1 & s1aq3b==1 & s1aq4b~=14
replace s1aq5=.  if asds2==1 & s1aq4a==.
gen asds3=1  if asds2==1 & s1aq3b==14
replace s1aq3a=s1aq6a   if asds3==1
replace s1aq3b=s1aq6b   if asds3==1
drop asds3 
replace s1aq3a=s1aq6a  if asds2==1 & s1aq1==4 & hid=="8622086232001" 
replace s1aq7a=s1aq3a  if asds2==1 & s1aq5==. & s1aq8a==.
replace s1aq7b=s1aq3b  if asds2==1 & s1aq5==. & s1aq8b==.
recode s1aq4a-s1aq6b (else=.)  if asds2==1 & s1aq5==.
replace s1aq6a=s1aq3a  if asds2==1 & s1aq5~=. 
replace s1aq6b=s1aq3b  if asds2==1 & s1aq5~=. 
replace checked=1  if checked==. & asds2==1
replace asds1=.  if asds2==1 
drop asds2 
replace s1aq5=210   if s1aq1==42 & hid=="1010110106005"
recode s1aq7a-s1aq8b (else=.)  if s1aq1==42 & s1aq5~=. & s1aq7b==0
recode s1aq7a-s1aq8b (else=.)  if s1aq1==42 & s1aq5~=. & s1aq8b==0
ren asds1 rethink

gen asds1=1   if s1aq1<=4 & s1aq5~=. & s1aq4a==.
replace s1aq3a=20   if asds1==1 & s1aq3a==2028
replace s1aq5=.    if asds1==1 & s1aq5==s1aq3a 
replace s1aq5=.    if asds1==1 & s1aq5<10
replace s1aq5=s1aq5/10   if asds1==1 & s1aq5>=10000
replace s1aq5=.  if asds1==1 
recode s1aq4a-s1aq6b (else=.)  if asds1==1 & s1aq5==.
replace s1aq7a=s1aq3a  if asds1==1 & (s1aq6a==. & s1aq6b==. & s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==.)
replace s1aq7b=s1aq3b  if asds1==1 & s1aq7a~=.

br if asds1==1 & (s1aq1==1 & hid=="5222152223003") | (s1aq1==4 & hid=="5222252205013") | (s1aq1==3 & hid=="6021660218010")
replace s1aq4a=50  if s1aq1==3 & hid=="6021660218010"
replace s1aq3b=10  if s1aq1==3 & hid=="6021660218010"
replace s1aq6a=s1aq3a  if s1aq1==3 & hid=="6021660218010"
replace s1aq6b=s1aq3b  if s1aq1==3 & hid=="6021660218010"

gen Mohammed=1   if s1aq1>=33 & s1aq1<=103 | s1aq1>=143 & s1aq1<=166  //meat, fish, eggs and vegetables
compress 
save "$temp\food_1A_consumed_editted.dta", replace 
//save file and select for Mohammed. See below.


keep if Mohammed==1
drop valid-Mohammed
compress
save "$temp\Food_1A_consumed_Mohammed_to_edit.dta", replace 



********************************************************************************
********************************************************************************
use "$temp\food_1A_consumed_editted.dta",clear
drop if Mohammed==1 

drop asd- Mohammed
 
ta s1aq1  if s1aq3b==14
 
gen asd=1  if s1aq3b==14 & s1aq1<=4  //80 obs 
recode s1aq3b s1aq4b s1aq6b s1aq7b s1aq8b (0=.)  if asd==1 
*recode s1aq8a s1aq8b (else=.)  if asd==1
replace s1aq3a=s1aq6a   if asd==1 & s1aq6b==10
replace s1aq3b=s1aq6b   if asd==1 & s1aq6b==10
recode s1aq4a-s1aq6b (else=.) if asd==1 & s1aq5==.
gen asd1=1  if asd==1 & s1aq3b==14 
replace s1aq3a=1  if asd==1 & s1aq3a==s1aq5 
replace s1aq3a=s1aq4a  if asd1==1 & (s1aq4b==10 | s1aq4b==9)
replace s1aq3b=s1aq4b  if asd1==1 & (s1aq4b==10 | s1aq4b==9)
replace s1aq3b=10  if asd1==1 & s1aq3b==14 & s1aq3a>3 & hhsize<58 
replace s1aq3a=s1aq6a  if asd1==1 & s1aq1==4 & hid=="5210652125002"
replace s1aq3a=100   if asd1==1 & s1aq1==4 & hid=="5210652125002"
replace s1aq3b=10    if asd1==1 & s1aq1==4 & hid=="5210652125002"
replace s1aq6a=s1aq3a  if asd1==1 & s1aq1==4 & hid=="5210652125002"
replace s1aq6b=s1aq3b  if asd1==1 & s1aq1==4 & hid=="5210652125002"
replace s1aq8b=s1aq3b if asd1==1 & s1aq8b+. & s1aq8a==s1aq3a & s1aq5==. 
replace s1aq8a=.  if asd1==1 & s1aq7a==s1aq8a 
replace s1aq8b=.  if asd1==1 & s1aq8a==.
recode s1aq3b s1aq8b (14=1)  if asd1==1 & s1aq1==4 & hid=="3810438110010"
replace s1aq4a=1   if asd1==1 & s1aq3a==s1aq4a & s1aq4b==10
replace s1aq4b=14  if asd1==1 & s1aq4b==10 & (s1aq5>1000 & s1aq5<=2000)
replace s1aq4a=1   if asd1==1 & s1aq3a==s1aq4a & s1aq4b==9
replace s1aq4b=14  if asd1==1 & s1aq4b==9 & (s1aq5>1000 & s1aq5<=2000)
replace s1aq4a=1   if asd1==1 & s1aq3a==s1aq4a & s1aq4b==1
replace s1aq4b=14  if asd1==1 & s1aq4b==1 & (s1aq5>1000 & s1aq5<=2000)
replace s1aq6a=s1aq3a  if asd1==1 & s1aq5~=.
replace s1aq6b=s1aq3b  if asd1==1 & s1aq5~=.
recode s1aq4a-s1aq6b (else=.) if asd==1 & s1aq5==.
replace s1aq8a=.  if asd1==1 & s1aq1==3 & hid=="5023050213004"
recode s1aq3a s1aq4a s1aq6a (else=1)  if asd==1 & s1aq1==1 & hid=="5530155356010"
recode s1aq3b s1aq6b (else=1)  if asd==1 & s1aq1==1 & hid=="5530155356010"
replace s1aq4b=14  if asd==1 & s1aq1==1 & hid=="5530155356010"
replace s1aq6a=s1aq3a  if hid=="5530155356010"
replace s1aq6b=s1aq3b  if hid=="5530155356010"
recode s1aq7a-s1aq8b (else=.) if hid=="5530155356010"
replace s1aq7a=s1aq3a  if asd==1 & s1aq5==. & s1aq7a==. & s1aq8a==.
replace s1aq7b=s1aq3b  if asd==1 & s1aq5==. & s1aq7b==. & s1aq8b==.
replace checked=1  if asd1==1 & checked==.
replace asd=.  if asd1==1
drop asd1 
recode s1aq8a-s1aq8b (else=.)  if asd==1 & s1aq8a==s1aq3a & s1aq5~=.
replace s1aq8a=s1aq3a   if asd==1 & s1aq5==. & s1aq8a~=.
replace s1aq8b=s1aq3b   if asd==1 & s1aq5==. & s1aq8b~=.
replace s1aq4a=1   if asd==1 & (s1aq5>1000 & s1aq5<2000) & s1aq3a==s1aq4a 
replace s1aq4b=14  if asd==1 & (s1aq5>1000 & s1aq5<2000) & s1aq4b==10

/*gen asd2=1   if s1aq5~=. & (s1aq6a==. & s1aq6b==. & s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==.)
replace s1aq6a=correct   if asd2==1
replace s1aq6b=correctb  if asd2==1
drop asd2 

gen asd2=1    if asd==1 & s1aq5==.
replace s1aq7a=s1aq3a   if asd2==1 & s1aq8a==.
replace s1aq7b=s1aq3b   if asd2==1 & s1aq8b==.
recode s1aq8a s1aq8b (else=.)  if asd2==1 & hid=="3230632325012"
recode s1aq6a s1aq6b (else=.)  if asd2==1
drop asd2 
 
gen asd2=1  if asd==1 & s1aq6a~=. & (s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==.)
replace s1aq6a=correct   if asd2==1
replace s1aq6b=correctb  if asd2==1
drop asd2 

gen asd2=1  if asd==1 & (s1aq4a==. & s1aq4b==. & s1aq5==. & s1aq6a==. & s1aq6b==. & s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==.)
replace s1aq7a=correct   if asd2==1
replace s1aq7b=correctb  if asd2==1
drop asd2 
*/
*replace checked=1      if checked==. & asd==1  
drop asd* 


gen asd=1   if s1aq1==7 & s1aq4b==14
gen asd1=1  if asd==1 & s1aq3b==14
replace s1aq3a=s1aq6a  if asd1==1 & s1aq6b~=14
replace s1aq3b=s1aq6b  if asd1==1 & s1aq6b~=14
drop asd1 
replace s1aq6a=s1aq3a  if asd==1 & s1aq6a==. 
replace s1aq6b=s1aq3b  if asd==1 & s1aq6b==. 
recode s1aq7a s1aq7b (else=.)  if asd==1 & s1aq6a~=.
replace checked=1  if checked==. & asd==1 
replace s1aq4a=s1aq3a  if asd==1 & s1aq5<200
replace s1aq4b=s1aq3b  if asd==1 & s1aq5<200
gen asd2=1   if asd==1 & s1aq4b==14 & (s1aq4a>=2 & s1aq4a~=.) & (s1aq5>=1000 & s1aq5~=.) & s1aq1>4 
replace s1aq4a=1    if asd2==1 & s1aq5<=1500
drop asd2 
gen asd2=1  if asd==1 & s1aq3a==s1aq6a & s1aq3b~=s1aq6b & s1aq6b==14
recode s1aq3b s1aq6b (else=1)  if asd2==1 
drop asd2 
replace checked=1      if checked==. & asd==1  
drop asd* 

gen asd=1   if s1aq1==6 & s1aq4b==14
recode s1aq7a s1aq7b (else=.)  if asd==1
recode s1aq4a s1aq4b s1aq6a s1aq6b (else=.)  if asd==1 & s1aq5==.
replace s1aq7b=s1aq3b  if s1aq1==7 & hid=="5121851236001"
recode s1aq4a-s1aq6b (else=.) if s1aq5==. & hid=="5121851236001"
gen asd2=1  if asd==1 & (s1aq4a==. & s1aq4b==. & s1aq5==. & s1aq6a==. & s1aq6b==. & s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==.)
replace s1aq7a=s1aq3a   if asd2==1
replace s1aq7b=s1aq3b   if asd2==1
drop asd2 
gen asd2=1  if asd==1 & (s1aq6a==. & s1aq6b==. & s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==.)
replace s1aq6a=s1aq3a   if asd2==1
replace s1aq6b=s1aq3b   if asd2==1
drop asd2 
gen asd2=1  if asd==1 & s1aq3a==s1aq6a & s1aq3b~=s1aq6b & s1aq6b==14
replace s1aq6a=s1aq3a   if asd2==1
replace s1aq6b=s1aq3b   if asd2==1
drop asd2 
gen asd2=1  if asd==1 & s1aq3b~=s1aq6b  
replace s1aq6a=s1aq3a   if asd2==1 & hid=="6320363219003"
replace s1aq6b=s1aq3b   if asd2==1 & hid=="6320363219003" 
replace checked=1      if checked==. & asd==1  
drop asd2 asd 

gen asd=1  if s1aq3a==0
replace s1aq3a=0.5    if asd==1 & hid=="3520735220016"
replace s1aq3b=13     if asd==1 & hid=="3520735220016"
replace s1aq3a=40     if asd==1 & hid=="5110551108003"
replace s1aq3a=2      if asd==1 & hid=="5530155311016"
replace s1aq4a=10     if asd==1 & hid=="5530155311016"
replace s1aq3a=.5     if asd==1 & hid=="6021660218011"
recode s1aq3b s1aq4b (2=1)  if asd==1 & hid=="6021660218011" 
replace s1aq3a=2      if asd==1 & hid=="6121661217011"
replace s1aq3a=.5     if asd==1 & hid=="8422084224010"
replace s1aq6a=s1aq3a   if asd==1 & s1aq5~=.
replace s1aq6b=s1aq3b   if asd==1 & s1aq5~=.
replace s1aq7a=s1aq3a   if asd==1 & s1aq5==.
replace s1aq7b=s1aq3b   if asd==1 & s1aq5==.
recode s1aq4a-s1aq6b (else=.)  if asd==1 & s1aq5==.
replace checked=1      if checked==. & asd==1  
drop asd 

gen asd=1  if s1aq3b==0
gen asd2=1  if asd==1 & s1aq7a~=. & s1aq7a~=0 
recode s1aq4a s1aq4b s1aq6a s1aq6b (else=.)  if asd2==1 & s1aq5==. 
drop asd2 
gen asd2=1  if asd==1 & s1aq7a~=. & s1aq7b~=0 
gen asd3=1  if asd2==1 & (s1aq7b==14 | s1aq7b==15)
replace s1aq7b=10  if asd3==1 & s1aq1==7
replace s1aq8b=10  if asd3==1 & s1aq1==7 & s1aq8b~=.
replace s1aq7b=9  if asd3==1 & s1aq1==114
replace s1aq8b=9  if asd3==1 & s1aq1==114 & s1aq8b~=.
replace s1aq7b=6  if asd3==1 & s1aq1==118
replace s1aq8b=6  if asd3==1 & s1aq1==118 & s1aq8b~=.
replace s1aq7b=8  if asd3==1 & s1aq1==172
replace s1aq8b=8  if asd3==1 & s1aq1==172 & s1aq8b~=.
replace s1aq7b=99 if asd3==1 & s1aq1==226
replace s1aq8b=99 if asd3==1 & s1aq1==226 & s1aq8b~=.
replace s1aq7b=11 if asd3==1 & s1aq1==263
replace s1aq8b=11 if asd3==1 & s1aq1==263 & s1aq8b~=.
replace s1aq3b=s1aq7b  if asd3==1 & s1aq3b==0
replace checked=1      if checked==. & asd3==1 
replace asd2=.  if asd3==1
replace s1aq3b=s1aq7b  if asd2==1 
replace s1aq4a=s1aq7a  if asd2==1 & s1aq5~=.
replace s1aq6a=s1aq3a   if asd2==1 & s1aq5~=.
replace s1aq6b=s1aq3b   if asd2==1 & s1aq5~=.
recode s1aq7a-s1aq7b (else=.) if asd2==1 & s1aq5~=.
replace checked=1      if checked==. & asd2==1 
replace asd=.  if asd2==1
drop asd2 asd3 
gen asd2=1  if asd==1 & s1aq4a~=. & s1aq4b~=0 
gen asd3=1  if asd2==1 & s1aq3a==s1aq4a 
replace s1aq3b=s1aq4b  if asd3==1 
replace s1aq6b=s1aq4b  if asd3==1 
replace s1aq7a=s1aq3a  if asd3==1 & s1aq5==. & s1aq8a==.
replace s1aq7b=s1aq3b  if asd3==1 & s1aq5==. & s1aq8b==.
recode s1aq4a-s1aq6b (else=.) if asd3==1 & s1aq5==. & s1aq8a==. 
replace s1aq8b=s1aq3b  if asd3==1 & s1aq5==. & s1aq8b~=.
recode s1aq4a-s1aq6b (else=.) if asd3==1 & s1aq5==. & s1aq8a~=. 
replace checked=1      if checked==. & asd3==1
replace asd2=.  if asd3==1
drop asd3 
gen asd3=1  if asd2==1 & s1aq3a==s1aq6a 
replace s1aq3b=s1aq6b  if asd3==1 & hid=="5320953205016" & s1aq1==105
replace s1aq4a=s1aq6a  if asd3==1 & s1aq4a==714 
recode s1aq3b s1aq6b (else=99)  if asd3==1 & (s1aq1==109 | s1aq1==226  | s1aq1==230 | s1aq1==232)
recode s1aq3b s1aq6b (else=99)  if asd3==1 & s1aq1==264
replace checked=1      if checked==. & asd3==1
replace asd2=.  if asd3==1
drop asd3 
gen asd3=1  if asd2==1 & s1aq3a==s1aq7a 
drop asd3 

gen asd3=1  if asd2==1 & s1aq3a==s1aq8a 
recode s1aq3b s1aq8b (else=11)  if asd3==1
recode s1aq4a-s1aq6b (else=.)   if asd3==1
replace checked=1      if checked==. & asd3==1
replace asd2=.  if asd3==1
drop asd3 
recode s1aq3b s1aq8b (else=11)  if asd2==1
recode s1aq4a-s1aq6b (else=.)   if asd2==1
replace checked=1      if checked==. & asd2==1
drop asd2

gen asd2=1  if asd==1 & s1aq7a~=. & s1aq7b==0 
recode s1aq3b s1aq7b (0=10)  if asd2==1 & (s1aq1<5 | s1aq1==171 | s1aq1==172) 
recode s1aq3b s1aq7b (0=11)  if asd2==1 & (s1aq1==10 | s1aq1==140 | s1aq1==263 | s1aq1==238 | s1aq1==265)
recode s1aq3b s1aq7b (0=9)   if asd2==1 & (s1aq1==6 | s1aq1==7 | s1aq1>=11 & s1aq1<=13 | s1aq1==141) 
recode s1aq3b s1aq7b (0=99)  if asd2==1 & (s1aq1==187 | s1aq1==226 | s1aq1==248)
recode s1aq3b s1aq7b (0=9)   if asd2==1 & s1aq1==114
recode s1aq3b s1aq7b (0=8)   if asd2==1 & s1aq1==139
recode s1aq3b s1aq7b (0=13)  if asd2==1 & s1aq1==243
recode s1aq3b s1aq7b (0=5)   if asd2==1 & (s1aq1==244 | s1aq1==245 | s1aq1==246 | s1aq1==247 | s1aq1==249 | s1aq1==250)
recode s1aq3b s1aq7b (0=6)  if asd2==1 & (s1aq1==117 | s1aq1==118 | s1aq1==128 | s1aq1==129 | s1aq1==167) 
recode s1aq4a s1aq4b s1aq5 s1aq8a s1aq8b (else=.)  if asd2==1
replace checked=1      if checked==. & asd2==1
replace asd=.  if asd2==1
drop asd2 asd

gen asd=1  if s1aq3b==0
gen asd2=1  if asd==1 & s1aq5~=.
replace s1aq3a=s1aq4a   if asd2==1 & s1aq3a==710 
replace s1aq3a=s1aq6a   if asd2==1 & (s1aq3a~=s1aq6a & s1aq6a~=.)
replace s1aq3b=s1aq6b   if asd2==1 & (s1aq6b~=0 & s1aq6b~=.)
replace s1aq6a=s1aq3a   if asd2==1 & s1aq6a==.
replace s1aq6b=s1aq3b   if asd2==1 & s1aq6b==.
drop asd asd2 

**meals eaten away from home.
gen asdaq=1  if (s1aq1>=201 & s1aq1<=217)
ta s1aq3b  if asdaq==1 //units off
ta s1aq1 s1aq3b  if asdaq==1 
gen dfgh=1  if asdaq==1 & s1aq5==. & s1aq4a~=.
drop dfgh 
 
gen dfgh=1  if asdaq==1 & s1aq5~=. & s1aq6a~=. & s1aq8a~=.
recode s1aq4a-s1aq4b (else=.)  if dfg==1 & s1aq4a==s1aq8a  
replace s1aq5=s1aq4a  if dfgh==1 & s1aq1==216 & hid=="6430764302015"
recode s1aq4a s1aq6a (else=10)    if dfgh==1 & s1aq1==216 & hid=="6430764302015"
recode s1aq4b s1aq6b (else=6)     if dfgh==1 & s1aq1==216 & hid=="6430764302015"
recode s1aq4a-s1aq6b (else=.)  if dfgh==1 & s1aq5==.
replace s1aq7a=s1aq3a  if dfgh==1 & (s1aq8a==. & s1aq8b==.)
replace s1aq7b=s1aq3b  if dfgh==1 & (s1aq8a==. & s1aq8b==.)
replace checked=1      if checked==. & dfgh==1
drop dfgh 

gen dfgh=1  if asdaq==1 & s1aq5~=. & (s1aq3b<=5 | s1aq3b==7 | s1aq3b==8 | s1aq3b==10 | s1aq3b==11) 
replace s1aq3b=6       if asdaq==1 & s1aq5~=. & (s1aq3b<=5 | s1aq3b==7 | s1aq3b==8 | s1aq3b==10 | s1aq3b==11)
//fish pie in packet is more piece not packet
replace s1aq4b=s1aq3b  if asdaq==1 & s1aq5~=. & (s1aq4b<=5 | s1aq4b==7 | s1aq4b==8 | s1aq4b==10 | s1aq4b==11)
replace s1aq6b=s1aq3b  if asdaq==1 & s1aq5~=. & (s1aq6b<=5 | s1aq6b==7 | s1aq6b==8 | s1aq6b==10 | s1aq6b==11) 
drop dfgh 
gen dfgh=1 if asdaq==1 & s1aq5==. & (s1aq3b<=5 | s1aq3b==7 | s1aq3b==8 | s1aq3b==10 | s1aq3b==11) 
recode s1aq4a-s1aq6b (else=.)  if dfgh==1
replace s1aq3b=6       if asdaq==1 & s1aq5==. & (s1aq3b<=5 | s1aq3b==7 | s1aq3b==8 | s1aq3b==10 | s1aq3b==11)
replace s1aq8a=s1aq3a  if asdaq==1 & s1aq5==. & s1aq7a==. & s1aq8a~=. 
replace s1aq8b=s1aq3b  if asdaq==1 & s1aq5==. & s1aq8a~=.
replace s1aq8a=s1aq3a  if asdaq==1 & s1aq5==. & s1aq7a==. & s1aq8a==. 
replace s1aq8b=s1aq3b  if asdaq==1 & s1aq5==. & s1aq8a~=.
replace checked=1   if checked==. & asdaq==1 
drop dfgh  asdaq 

recode s1aq3a s1aq7a (else=1)   if s1aq1==172 & hid=="6421564215006"
recode s1aq3b s1aq7b (else=10)  if s1aq1==172 & hid=="6421564215006"

gen asd=1  if s1aq3b==0 
gen asd1=1  if asd==1 & (s1aq4b~=0 & s1aq4b~=.)
ta asd1  //no obs 
drop asd1 
gen asd1=1  if asd==1 & (s1aq4b~=0 & s1aq4b~=.)
ta asd1   
replace s1aq3a=s1aq6a  if asd1==1 & (s1aq6b~=0 & s1aq6b~=.)
replace s1aq3b=s1aq6b  if asd1==1 & (s1aq6b~=0 & s1aq6b~=.)
drop asd1 
gen asd1=1  if asd==1 & (s1aq7b~=0 & s1aq7b~=.)
ta asd1  //no obs 
drop asd1 
gen asd1=1  if asd==1 & (s1aq8b~=0 & s1aq8b~=.)
ta asd1   
replace s1aq8b=10  if asd1==1 & s1aq1==178 & s1aq8b==14 & s1aq8a>1 
replace s1aq8b=1   if asd1==1 & s1aq1==178 & s1aq8b==14 & s1aq8a==1 
replace s1aq3a=s1aq8a  if asd1==1 & (s1aq6b~=0 & s1aq6b~=.)
replace s1aq3b=s1aq8b  if asd1==1 & (s1aq6b~=0 & s1aq6b~=.)
replace s1aq8b=9   if asd1==1 & s1aq1==7 & s1aq8b==14 & s1aq8a~=.
replace s1aq8b=8   if asd1==1 & s1aq1==139 & s1aq8b==14 & s1aq8a~=.
replace s1aq8b=99  if asd1==1 & s1aq1==187 & s1aq8b==14 & s1aq8a~=.
replace s1aq8b=6   if asd1==1 & s1aq1==118 & s1aq8b==14 & s1aq8a~=.
replace s1aq8b=1   if asd1==1 & s1aq1==168 & s1aq8b==14 & s1aq8a~=.
replace s1aq3a=s1aq8a  if asd1==1 & (s1aq8b~=0 & s1aq8b~=.)
replace s1aq3b=s1aq8b  if asd1==1 & (s1aq8b~=0 & s1aq8b~=.)
recode s1aq4a-s1aq6b (else=.)  if asd==1 & s1aq5==.
drop asd1 
gen asd1=1  if asd==1 & s1aq3b==0 & s1aq5==.  //85 obs still have wrong units 
ta asd1 
replace s1aq3b=10   if asd1==1 & (s1aq1<5 | s1aq1==104 | s1aq1==105 | s1aq1==171 | s1aq1==172 | s1aq1==178)
replace s1aq3b=11   if asd1==1 & (s1aq1==10 | s1aq1==140 | s1aq1==121 | s1aq1==227 | s1aq1==263 | s1aq1==237 | s1aq1==238 | s1aq1==265 | s1aq1==264) 
replace s1aq3b=9    if asd1==1 & (s1aq1==6 | s1aq1==7 | s1aq1>=11 & s1aq1<=13 | s1aq1==114 | s1aq1==141) 
replace s1aq3b=99   if asd1==1 & (s1aq1==187 | s1aq1==226 | s1aq1==99 | s1aq1==248)
replace s1aq3b=9    if asd1==1 & s1aq1==114
replace s1aq3b=8    if asd1==1 & (s1aq1==122 | s1aq1==139 ) 
replace s1aq3b=13   if asd1==1 & (s1aq1==184 | s1aq1==231 | s1aq1==232 | s1aq1==243) 
replace s1aq3b=5    if asd1==1 & (s1aq1==24 | s1aq1==26 | s1aq1==27 | s1aq1==109 | s1aq1==229 | s1aq1==236 | s1aq1==244 | s1aq1==245 | s1aq1==246 | s1aq1==247 | s1aq1==249 | s1aq1==250 | s1aq1==251 | s1aq1==255 | s1aq1==256)
replace s1aq3b=6    if asd1==1 & (s1aq1==16 | s1aq1==110 | s1aq1==112 | s1aq1==117 | s1aq1==118 | s1aq1==119 | s1aq1==123 | s1aq1==124 | s1aq1==127 | s1aq1==128 | s1aq1==129 | s1aq1==167 | s1aq1==194 | s1aq1==201 | s1aq1==202 | s1aq1==204 | s1aq1==208 | s1aq1>=257 & s1aq1<=259 | s1aq1==262) 
replace s1aq3b=12   if asd1==1 & s1aq1==189 
replace s1aq8a=s1aq3a  if asd1==1
replace s1aq8b=s1aq3b  if asd1==1 
drop asd1 
gen asd1=1  if asd==1 & s1aq3b==0 & s1aq5~=. 
ta asd1 //76 obs. Wil just replace the consumption untis and leave out the purchase units as this will take time.
recode s1aq3b s1aq4b s1aq6b (14=5)  if s1aq1==24 & hid=="4021040223001" 
replace s1aq5=50  if asd1==1 & s1aq1==24 & s1aq5==850
replace s1aq5=40  if asd1==1 & s1aq1==109 & s1aq5==400
replace s1aq5=s1aq5/10   if s1aq1==230 & s1aq5==650 & s1aq4a==1
replace s1aq4a=5  if s1aq1==230 & hid=="7310473133002"
replace s1aq4b=3  if s1aq1==230 & hid=="7310473133002"
replace s1aq4b=3  if s1aq1==230 & hid=="4021340217006"
replace s1aq5=s1aq5/10   if s1aq1==230 & s1aq5==600 & s1aq4a==1
replace s1aq4a=1   if s1aq1==230 & hid=="5530155311012"
recode s1aq7a s1aq7b (else=.)   if s1aq1==230 & hid=="5530155311012"
replace s1aq4a=1   if s1aq1==230 & hid=="4311543116013"
replace s1aq6a=s1aq3a    if s1aq1==230 & hid=="4311543116013"
replace s1aq6b=s1aq6b    if s1aq1==230 & hid=="4311543116013" 
replace s1aq4a=5  if s1aq1==230 & hid=="3030530383001"
replace s1aq4b=3  if s1aq1==230 & hid=="3030530383001"
replace s1aq3b=10   if asd1==1 & (s1aq1<5 | s1aq1==104 | s1aq1==105 | s1aq1==171 | s1aq1==172 | s1aq1==178)
replace s1aq3b=11   if asd1==1 & (s1aq1==10 | s1aq1==140 | s1aq1==121 | s1aq1==227 | s1aq1==263 | s1aq1==237 | s1aq1==238 | s1aq1==265 | s1aq1==264) 
replace s1aq3b=9    if asd1==1 & (s1aq1==6 | s1aq1==7 | s1aq1>=11 & s1aq1<=13 | s1aq1==114 | s1aq1==141) 
replace s1aq3b=99   if asd1==1 & (s1aq1==187 | s1aq1==226 | s1aq1==99 | s1aq1==230 | s1aq1==248)
replace s1aq3b=9    if asd1==1 & s1aq1==114
replace s1aq3b=8    if asd1==1 & (s1aq1==122 | s1aq1==139 ) 
replace s1aq3b=13   if asd1==1 & (s1aq1==184 | s1aq1==231 | s1aq1==232 | s1aq1==243) 
replace s1aq3b=5    if asd1==1 & (s1aq1==24 | s1aq1==26 | s1aq1==27 | s1aq1==109 | s1aq1==229 | s1aq1==236 | s1aq1==244 | s1aq1==245 | s1aq1==246 | s1aq1==247 | s1aq1==249 | s1aq1==250 | s1aq1==251 | s1aq1==255 | s1aq1==256)
replace s1aq3b=6    if asd1==1 & (s1aq1==16 | s1aq1==110 | s1aq1==112 | s1aq1==117 | s1aq1==118 | s1aq1==119 | s1aq1==123 | s1aq1==124 | s1aq1==127 | s1aq1==128 | s1aq1==129 | s1aq1==167 | s1aq1==194 | s1aq1==201 | s1aq1==202 | s1aq1==204 | s1aq1==208 | s1aq1>=257 & s1aq1<=259 | s1aq1==262) 
replace s1aq3b=12   if asd1==1 & s1aq1==189 
replace s1aq6b=s1aq3b  if asd1==1 & s1aq3a==s1aq6a
//the above obs tough to change the untis 
replace s1aq4b=s1aq3b  if asd1==1 & s1aq3a==s1aq6a & s1aq4b==0 
replace checked=1  if checked==. & asd==1
drop asd asd1 

recode s1aq3b s1aq7b s1aq8b (else=9)   if hid=="5612056108007" & s1aq1==141 
 
gen dfg=1   if hid=="6411764109010"
replace s1aq4a=s1aq3a   if s1aq1==243 & hid=="6411764109010" & s1aq4a~=.
replace s1aq4a=s1aq3a   if s1aq1==256 & hid=="6411764109010" & s1aq4a~=. 
replace s1aq4a=s1aq3a   if s1aq1==178 & hid=="6411764109010" & s1aq4a~=. 
replace s1aq3a=9        if hid=="6411764109010" & s1aq3a==98 
replace s1aq7a=s1aq3a   if hid=="6411764109010" & (s1aq4a==. & s1aq4b==. & s1aq5==. & s1aq6a==. & s1aq6b==. & s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==.)
replace s1aq7b=s1aq3b   if hid=="6411764109010" & s1aq7a~=.
replace checked=1       if checked==. & dfg==1  
drop dfg 

gen dfg=1   if s1aq1==226
replace s1aq5=s1aq7a    if s1aq1==226 & hid=="3310233131012"
recode s1aq7a s1aq7b (else=.)  if s1aq1==226 & hid=="3310233131012"
replace s1aq3a=s1aq6a  if s1aq1==226 & hid=="3310233131012"
gen asd2=1  if dfg==1 & s1aq1==226 & s1aq5==. & s1aq6a~=.
gen asd3=1  if asd2==1 & (s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==.)
replace s1aq7a=s1aq6a   if asd3==1
replace s1aq7b=s1aq6b   if asd3==1
recode s1aq4a s1aq4b s1aq6a s1aq6b (else=.)  if asd3==1 
replace checked=1       if checked==. & asd3==1 
drop asd2 asd3 
gen asd2=1   if dfg==1 & (s1aq4a==. & s1aq4b==. & s1aq5==. & s1aq6a==. & s1aq6b==. & s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==.)
replace s1aq7a=s1aq3a   if asd2==1
replace s1aq7b=s1aq3b   if asd2==1
replace checked=1       if checked==. & asd2==1 
drop asd2 
gen asd2=1  if dfg==1 & s1aq1==226 & s1aq5==. & s1aq6a~=.
recode s1aq4a s1aq4b s1aq6a s1aq6b (else=.)  if asd2==1 
replace s1aq7a=s1aq3a   if asd2==1 & (s1aq8a==. & s1aq8b==.) 
replace s1aq7b=s1aq3b   if asd2==1 & (s1aq8a==. & s1aq8b==.)
replace s1aq8a=s1aq3a   if asd2==1 & (s1aq7a==. & s1aq7b==.) 
replace s1aq8b=s1aq3b   if asd2==1 & (s1aq7a==. & s1aq7b==.)

replace s1aq3a=s1aq6a   if s1aq1==226 & (hid=="2120121201014" | hid=="3050230544014" | hid=="3133931341010" | hid=="3210232156002")
replace s1aq3a=s1aq6a   if s1aq1==226 & hid=="2230122310009"
replace s1aq3b=s1aq6b   if s1aq1==226 & (hid=="2230122310009" | hid=="3210532170003")
replace s1aq3a=s1aq6a   if s1aq1==226 & hid=="2310123112003"
replace s1aq3b=s1aq6b   if s1aq1==226 & hid=="2310123112003"
replace s1aq4a=s1aq6a   if s1aq1==226 & hid=="3020230225009"
replace s1aq4b=s1aq6b   if s1aq1==226 & hid=="3020230225009"
replace s1aq3a=s1aq6a   if s1aq1==226 & hid=="3020230225009"
replace s1aq3b=s1aq6b   if s1aq1==226 & hid=="3020230225009"
replace s1aq5=s1aq4a    if s1aq1==226 & hid=="3040130443011"
recode s1aq3a s1aq4a s1aq6a (else=2)  if s1aq1==226 & hid=="3040130443011"
recode s1aq3b s1aq4b s1aq6b (else=10)  if s1aq1==226 & hid=="3040130443011"
replace s1aq5=s1aq4a    if s1aq1==226 & hid=="3040130485012"
recode s1aq3a s1aq4a s1aq6a (else=2)  if s1aq1==226 & hid=="3040130485012"
recode s1aq3b s1aq4b s1aq6b (else=10)  if s1aq1==226 & hid=="3040130485012"
replace s1aq4a=s1aq6a   if s1aq1==226 & hid=="3060130659015"
replace s1aq3a=s1aq6a   if s1aq1==226 & hid=="3060130659015"
replace s1aq3b=s1aq6b   if s1aq1==226 & hid=="3060130659015"
recode s1aq3a s1aq4a s1aq6a (117=7)   if s1aq1==226 & hid=="1010110106011"
recode s1aq7a s1aq7b (else=.)  if s1aq1==226 & (hid=="2320123251010" | hid=="3410334110001")
recode s1aq3a s1aq4a s1aq6a (else=2)   if s1aq1==226 & hid=="3081830829007"
recode s1aq3b s1aq4b s1aq6b (else=7)   if s1aq1==226 & hid=="3081830829007"
replace s1aq4a=s1aq6a   if s1aq1==226 & (hid=="3110331110003" | hid=="3111131102002")
replace s1aq5=s1aq4a   if s1aq1==226 & (hid=="3133631305010" | hid=="3133631305011")
recode s1aq3a s1aq4a s1aq6a (else=2)  if s1aq1==226 & (hid=="3133631305010" | hid=="3133631305011")
recode s1aq3b s1aq4b s1aq6b (else=10)  if s1aq1==226 & (hid=="3133631305010" | hid=="3133631305011")
recode s1aq3a s1aq4a (else=1)  if s1aq1==226 & hid=="3142031442010"
recode s1aq3b  (else=10)  if s1aq1==226 & hid=="3142031442010"
replace s1aq4a=1   if s1aq1==226 & hid=="3210232156013"
replace s1aq4b=7   if s1aq1==226 & hid=="3210232156013"
recode s1aq3b s1aq4b s1aq6b s1aq8b (else=7)   if s1aq1==226 & hid=="3210232156013"
replace s1aq6a=s1aq3a  if s1aq1==226 & hid=="3210232156013"
recode s1aq8a s1aq8b (else=.)   if s1aq1==226 & (hid=="3210232156013" | hid=="3230432314013" | hid=="3311033102012")
replace s1aq4a=s1aq3a  if s1aq1==226 & hid=="3230232357013"
replace s1aq3a=s1aq6a   if s1aq1==226 & (hid=="3230232357011" | hid=="3230432314009" | hid=="3230632325005" | hid=="3240832455002" )
replace s1aq3b=s1aq6b   if s1aq1==226 & (hid=="3230232357011" | hid=="3230432314009" | hid=="3240832455002" )
replace s1aq4a=s1aq6a   if s1aq1==226 & (hid=="3230232357011" | hid=="3230432314009" |   )
replace s1aq5=s1aq4a   if s1aq1==226 & hid=="3241332469009"
recode s1aq3a s1aq4a s1aq6a (else=2)   if s1aq1==226 & hid=="3241332469009"
recode s1aq3b s1aq4b s1aq6b (else=10)   if s1aq1==226 & hid=="3241332469009"
recode s1aq7a s1aq7b (else=.)   if s1aq1==226 & (hid=="3241332469009" | hid=="3310733120008")
replace s1aq5=s1aq5/10   if s1aq1==226 & hid=="3311033102012"
recode s1aq3a s1aq4a s1aq6a (else=1)    if s1aq1==226 & hid=="3311033106001"
recode s1aq3b s1aq4b s1aq6b (else=10)   if s1aq1==226 & hid=="3311033106001"
replace s1aq5=s1aq4a   if s1aq1==226 & hid=="3311533135001"
recode s1aq3a s1aq4a s1aq6a (else=2.5)  if s1aq1==226 & hid=="3311533135001"
recode s1aq3b s1aq4b s1aq6b (else=11)   if s1aq1==226 & hid=="3311533135001"
replace s1aq5=s1aq4a   if s1aq1==226 & hid=="3311533135012"
recode s1aq3a s1aq4a s1aq6a (else=4)    if s1aq1==226 & hid=="3311533135012"
replace s1aq3a=s1aq6a   if s1aq1==226 & hid=="3320433220016"
replace s1aq4a=s1aq6a   if s1aq1==226 & hid=="3320433220016"
recode s1aq3b s1aq4b s1aq6b (else=10)    if s1aq1==226 & hid=="3320433220016"
replace s1aq5=s1aq4a   if s1aq1==226 & hid=="3320633228001"
recode s1aq3a s1aq4a s1aq6a (else=2.5)  if s1aq1==226 & hid=="3320633228001"
recode s1aq3b s1aq4b s1aq6b (else=11)   if s1aq1==226 & hid=="3320633228001"
replace s1aq3a=s1aq6a   if s1aq1==226 & hid=="3410334103009"
replace s1aq5=s1aq4a   if s1aq1==226 & hid=="3410334106014"
recode s1aq3a s1aq4a s1aq6a (else=2.5)  if s1aq1==226 & hid=="3410334106014"
recode s1aq3b s1aq4b s1aq6b (else=11)   if s1aq1==226 & hid=="3410334106014"
replace checked=1       if checked==. & asd2==1 
gen asd3=1   if s1aq1==226 & s1aq5==200
replace s1aq5=s1aq4a*5  if asd3==1 & s1aq4b==10
replace checked=1       if checked==. & asd3==1 
drop asd3
gen asd3=1   if s1aq1==226 & s1aq5==200
replace s1aq5=.  if asd3==1 & s1aq4a==.
replace s1aq4a=4   if asd3==1
replace s1aq4b=1   if asd3==1
replace s1aq3a=s1aq3a/10   if asd3==1 & s1aq3a==25
replace s1aq3b=10  if asd3==1 & (s1aq3b==0 | s1aq3b==1 | s1aq3b==3 | s1aq3b==13 | s1aq3b==14 | s1aq3b==15)
replace s1aq6a=s1aq3a   if asd3==1
replace s1aq6b=s1aq3b   if asd3==1
replace checked=1       if checked==. & asd3==1 
drop asd3
gen asd3=1   if s1aq1==226 & s1aq3b==0
drop asd3
gen asd3=1   if s1aq1==226 & s1aq3b==3
recode s1aq4a s1aq4b (else=.)  if asd3==1 & s1aq5==. 
replace s1aq4a=s1aq5/50  if asd3==1 & (hid=="4022440219004" | hid=="4022440219013" | hid=="5310253111014") 
replace s1aq4b=1         if asd3==1 & (hid=="4022440219004" | hid=="4022440219013" | hid=="5310253111014") 
replace s1aq4b=10  if asd3==1 & hid=="3221532255005"
replace s1aq3b=10  if asd3==1 & s1aq3b~=.
replace s1aq3a=s1aq6a  if asd3==1 & hid=="5211152102009"
replace s1aq6b=s1aq3b   if asd3==1 & s1aq6b~=.
replace s1aq7b=s1aq3b   if asd3==1 & s1aq7b~=.
replace s1aq8b=s1aq3b   if asd3==1 & s1aq8b~=.
replace checked=1       if checked==. & asd3==1  
drop asd3
gen asd3=1   if s1aq1==226 & s1aq3a==20
recode s1aq3b s1aq8b (else=11)   if s1aq1==226 & hid=="4021040223005"
replace s1aq4a=s1aq5/50   if s1aq1==226 & hid=="7420174207012"
recode s1aq3b s1aq6b (else=99)  if s1aq1==226 & hid=="4022440219013"
replace s1aq5=s1aq4a   if s1aq1==226 & hid=="6320963209014"
replace s1aq4a=s1aq5/50   if s1aq1==226 & hid=="6320963209014"
replace s1aq4b=1          if s1aq1==226 & hid=="6320963209014"
replace s1aq6a=s1aq3a  if s1aq1==226 & hid=="6320963209014"
replace s1aq6b=s1aq3b  if s1aq1==226 & hid=="6320963209014"
replace s1aq3a=s1aq6a  if s1aq1==226 & hid=="6410364103010"
replace s1aq3b=s1aq6b  if s1aq1==226 & hid=="6410364103010"
replace s1aq3a=s1aq6a  if s1aq1==226 & hid=="7420174207012"
replace s1aq3b=s1aq6b  if s1aq1==226 & hid=="7420174207012"
replace s1aq3a=s1aq4a  if s1aq1==226 & hid=="8611586104010"
replace s1aq3b=s1aq4b  if s1aq1==226 & hid=="8611586104010"
recode s1aq4a s1aq4b (else=.)   if s1aq1==226 & hid=="8611586104010"
replace s1aq7a=s1aq3a  if s1aq1==226 & hid=="8611586104010"
replace s1aq7b=s1aq3b  if s1aq1==226 & hid=="8611586104010"
replace checked=1       if checked==. & asd3==1 
drop asd3 
ta s1aq4b  if s1aq1==226

gen asd3=1   if s1aq1==226 & s1aq4b==0
replace s1aq4b=s1aq3b  if asd3==1 & s1aq3b==10
replace s1aq6a=s1aq3a  if asd3==1 & s1aq3b==10
replace checked=1       if checked==. & asd3==1 
drop asd3 
gen asd3=1   if s1aq1==226 & s1aq4b==0
replace s1aq3b=99  if asd3==1 & s1aq3a==98
replace s1aq7a=s1aq3a   if asd3==1
replace s1aq7b=s1aq3b   if asd3==1
recode s1aq4a s1aq4b (else=.)  if asd3==1 & s1aq5==.
replace checked=1       if checked==. & asd3==1 
drop asd3 

gen asd3=1   if s1aq1==226 & s1aq4b==2
recode s1aq7a s1aq7b s1aq8a s1aq8b (else=.)  if asd3==1
replace s1aq4b=1    if asd3==1 & (s1aq5>=80 & s1aq5~=.)
replace s1aq4a=s1aq5/50   if asd3==1 & (s1aq5>=80 & s1aq5~=.)
replace s1aq4b=10  if asd3==1 & s1aq4b==2
recode s1aq3a s1aq4a s1aq6a (50=5)    if asd3==1
replace s1aq6a=s1aq3a  if asd3==1 & s1aq6a==. 
replace s1aq6b=s1aq3b  if asd3==1 & s1aq6b==. 
replace s1aq6a=s1aq3a  if asd3==1 & hid=="5121851236014"
replace checked=1       if checked==. & asd3==1 
drop asd3 

gen asd3=1  if s1aq1==226 & s1aq5==300
replace s1aq5=.  if asd3==1 & s1aq4a==.
replace s1aq4b=1   if asd3==1 & s1aq4b~=.
replace s1aq4a=s1aq5/50   if asd3==1 & s1aq4a~=.
recode s1aq3b s1aq6b (else=10)  if asd3==1 & hid=="4520145212004"
recode s1aq4a-s1aq6b (else=.) if asd3==1 & s1aq5==.
replace s1aq7a=s1aq3a  if asd3==1 & s1aq5==.
replace s1aq7b=s1aq3b  if asd3==1 & s1aq5==.
replace checked=1       if checked==. & asd3==1 
drop asd3 

gen asd3=1   if s1aq1==226 & s1aq4b==3
replace s1aq4a=s1aq4a/10   if asd3==1 & s1aq5==110
replace s1aq6b=s1aq3b  if asd3==1 
recode s1aq7a-s1aq7b (else=.) if asd3==1 
replace checked=1       if checked==. & asd3==1 
drop asd3 

gen asd3=1  if s1aq1==226 & s1aq4b==4
drop asd3 

gen asd3=1   if s1aq1==226 & s1aq6b==0
drop asd3 

gen asd3=1   if s1aq1==226 & (s1aq6b==3 | s1aq6b==4)
drop asd3 

gen asd3=1   if s1aq1==226 & (s1aq6b==13 | s1aq6b==15)
replace s1aq6a=s1aq3a   if asd3==1 
replace s1aq6b=s1aq3b   if asd3==1 
replace checked=1       if checked==. & asd3==1 
drop asd3 

gen asd3=1   if s1aq1==226 & s1aq6b==14
drop asd3 

gen gh=1  				if s1aq1==258 & s1aq5==100
replace s1aq4a=1        if gh==1 & (s1aq4a==. | s1aq4a~=1)
replace s1aq4b=5        if gh==1 & (s1aq4b==. | s1aq4b~=5)
replace s1aq3a=s1aq6a        if s1aq1==258 & hid=="5411654115007"
replace s1aq3b=s1aq6b        if s1aq1==258 & hid=="5411654115007"
replace checked=1       if checked==. & gh==1 
drop gh 

gen dfg1=1   if hid=="6421564215004"
replace s1aq5=s1aq4a   if dfg1==1 & s1aq4a~=. & s1aq5==.
replace s1aq3b=99   if dfg1==1 & s1aq3a==98
replace s1aq7a=s1aq3a   if dfg1==1 & (s1aq4a==. & s1aq4b==. & s1aq5==. & s1aq6a==. & s1aq6b==. & s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==.)
replace s1aq7b=s1aq3b   if dfg1==1 & (s1aq4a==. & s1aq4b==. & s1aq5==. & s1aq6a==. & s1aq6b==. & s1aq7a~=. & s1aq7b==. & s1aq8a==. & s1aq8b==.)
replace s1aq6a=s1aq3a   if dfg1==1 & (s1aq6a==. & s1aq6b==. & s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==.)
replace s1aq6b=s1aq3b   if dfg1==1 & (s1aq6a~=. & s1aq6b==. & s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==.)
replace s1aq4a=12       if dfg1==1 & s1aq1==16  //one buys fish in whole and not halves
replace s1aq4a=2        if dfg1==1 & s1aq1==25  
recode s1aq6b s1aq8b (else=10)  if dfg1==1 & s1aq1==178 
replace s1aq4a=2        if dfg1==1 & s1aq1==194
replace s1aq4a=1        if dfg1==1 & s1aq1==230
replace s1aq4a=1        if dfg1==1 & s1aq1==231
replace s1aq4a=1        if dfg1==1 & s1aq1==251
replace s1aq4a=10       if dfg1==1 & s1aq1==178
replace s1aq4a=1        if dfg1==1 & s1aq1==256
replace s1aq4a=1        if dfg1==1 & s1aq1==258
replace checked=1       if checked==. & dfg1==1 
drop dfg1 

gen gh=1  				if s1aq1==256  
gen gh1=1   if gh==1 & s1aq3b<5
recode s1aq4a-s1aq6b (else=.) if gh1==1 & s1aq5<=10
replace s1aq4a=s1aq5/10  if gh==1 & s1aq5==210
replace s1aq4b=5   if gh1==1 & s1aq4b~=.
replace s1aq8b=5  if gh==1 & s1aq8b~=.
replace s1aq3a=s1aq8a  if gh==1 & s1aq8a~=.
replace s1aq3b=s1aq8b  if gh==1 & s1aq8b~=.
replace s1aq3a=s1aq4a if gh==1 & s1aq4a~=.
replace s1aq3a=s1aq4a if gh==1 & s1aq4a~=.
replace s1aq3b=s1aq4b if gh==1 & s1aq4b~=.
replace s1aq6a=s1aq4a if gh==1 & s1aq6a~=.
replace s1aq6b=s1aq4b if gh==1 & s1aq6b~=.
replace checked=1       if checked==. & gh1==1 
drop gh1 

gen gh1=1   if gh==1 & (s1aq3b>=7 & s1aq3b<=8)
replace s1aq5=s1aq4a   if gh1==1 & hid=="5621956214006"
recode s1aq3a s1aq4a s1aq6a (else=7)  if gh1==1 & hid=="5621956214006"
replace s1aq5=s1aq4a*10   if gh1==1 & hid=="3710137101005" & s1aq5==35

replace s1aq3b=5   if gh1==1 & s1aq3b~=.
replace s1aq4b=5   if gh1==1 & s1aq4b~=.
replace s1aq6b=5   if gh1==1 & s1aq6b~=.
replace s1aq7b=5   if gh1==1 & s1aq7b~=.
replace s1aq8b=5   if gh1==1 & s1aq8b~=.
replace checked=1       if checked==. & gh1==1 
drop gh1 

gen gh1=1   if gh==1 & (s1aq3b>=7 & s1aq3b<11)
recode s1aq4a s1aq4b (else=.) if gh1==1 & s1aq5==.
replace s1aq3b=5  if gh1==1
replace s1aq4b=s1aq3b   if gh1==1 & s1aq4b~=.
replace s1aq6b=s1aq3b   if gh1==1 & s1aq6b~=.
replace s1aq7a=s1aq3a  if gh1==1 & s1aq5==.
replace s1aq7b=s1aq3b  if gh1==1 & s1aq5==.
drop gh1 

gen gh1=1   if gh==1 & (s1aq3b>=7 & s1aq3b==10)
drop gh1

gen gh1=1   if gh==1 & s1aq4b<5
recode s1aq3b s1aq4b s1aq6b (else=5) if gh1==1 
drop gh1

gen gh1=1   if gh==1 & (s1aq4b==7 | s1aq4b==10 | s1aq4b==14 | s1aq4b==15) 
recode s1aq3b s1aq4b s1aq6b (else=5) if gh1==1 
drop gh1

gen gh1=1   if gh==1 & s1aq6b<5
drop gh1 

gen gh1=1   if gh==1 & (s1aq6b>=7 & s1aq6b<11)
drop gh1 

gen gh1=1   if gh==1 & (s1aq6b>=11 & s1aq6b~=.)
recode s1aq4a-s1aq6b (else=.)  if gh1==1 & s1aq5==.
replace s1aq7a=s1aq3a  if gh1==1 & s1aq5==.
replace s1aq7b=s1aq3b  if gh1==1 & s1aq5==.
replace checked=1        if checked==. & s1aq1==256 
drop gh1 
drop asd2 

gen asd=1  if s1aq3b==0
recode s1aq3b s1aq8b (else=10)   if asd==1 & s1aq1==5
recode s1aq3b s1aq8b (else=5)   if asd==1 & s1aq1==23
recode s1aq3b s1aq8b (else=11)   if asd==1 & s1aq1==168
recode s1aq3b s1aq8b (else=99)   if asd==1 & s1aq1==230
replace checked=1        if checked==. & asd==1 
drop asd 

/*
gen asdd=1  if s1aq4b==14 & (s1aq4a>=2 & s1aq4a~=.) & (s1aq5>=1000 & s1aq5~=.)
replace s1aq4a=1   if asdd==1 & s1aq1<=4 & (s1aq5>=1000 & s1aq5<2000)
replace s1aq4a=1  if asdd==1 & (s1aq5>=1000 & s1aq5~=.) & (s1aq1<=4 | s1aq1==178)
s 
recode s1aq3b s1aq6b (14=10)  if asdd==1 
drop asdd  
s 
gen asdd=1  if s1aq4b==14 & (s1aq4a>=2 & s1aq4a~=.) & (s1aq5>=1000 & s1aq5~=.)
replace s1aq4a=1   if asdd==1 & s1aq4b==14 & s1aq3a==s1aq4a & s1aq3a==s1aq6a 
replace s1aq4a=1   if asdd==1 & s1aq4b==14  
recode s1aq3b s1aq4b (14=10 ) if asdd==1 & s1aq4b==14 & s1aq3a==s1aq4a & s1aq3a==s1aq6a 
s 
recode s1aq4a s1aq4b (else=.)   if asdd==1


drop asdd 
gen asdd=1  if s1aq4b==14 & (s1aq4a>2 & s1aq4a~=.)

s
*/
gen df=1   if  s1aq1==178 & s1aq4b==0 & s1aq3b~=14
replace s1aq4b=14 if df==1 & (s1aq5>1000 & s1aq5~=.)
replace s1aq4a=1  if df==1 & (s1aq5>1000 & s1aq5~=.) 
recode s1aq4a-s1aq6b (else=.)  if df==1 & s1aq5==.
replace s1aq7a=s1aq3a   if df==1 & s1aq5==. & s1aq8a==.
replace s1aq7b=s1aq3b   if df==1 & s1aq5==. & s1aq8b==.
replace s1aq3b=10      if df==1 & s1aq3b==6
replace s1aq4a=s1aq3a   if df==1 & s1aq4a~=s1aq3a & s1aq4b~=14 
recode s1aq4a-s1aq6b (else=.)  if df==1 & s1aq5==.
replace s1aq4b=s1aq3b  if df==1 & s1aq4b==0
replace s1aq6b=s1aq3b  if df==1 & s1aq6b==0
replace checked=1       if checked==. & df==1 
drop df 

gen df=1  if s1aq1==178 & s1aq4b==2 
recode s1aq8a s1aq8b (else=.)  if df==1 
replace s1aq5=s1aq6a   if df==1 & s1aq6a==200 & hid=="5110251114002"
replace s1aq5=s1aq4a*10  if df==1 & hid=="6323563229005"
replace s1aq4a=s1aq5/10  if  df==1
replace s1aq4b=10  if df==1 
replace s1aq3b=99  if df==1 
replace s1aq6a=s1aq3a  if df==1
replace s1aq6b=s1aq3b  if df==1
replace checked=1       if checked==. & df==1 
drop df

gen df=1  if (s1aq4a>=500 & s1aq4a~=.) & s1aq1==178 
replace s1aq5=s1aq6a*10  if df==1 & s1aq5==750
replace s1aq4a=s1aq6a  if df==1  
recode s1aq3b s1aq4b s1aq6b (1=10)  if df==1 & hid=="8611386125002"
replace checked=1       if checked==. & df==1 
drop df
  
gen df=1  if (s1aq4b==3 | s1aq4b==4) & s1aq1==178
recode s1aq8a s1aq8b (else=.)  if df==1
replace s1aq4b=14   if df==1 & s1aq4b==4 & s1aq5==1800 
recode s1aq4b (else=10)  if df==1 & (hid=="4022440219010" | hid=="4121041204006" | hid=="8422684226004")
replace s1aq5=s1aq4a  if df==1 & hid=="7310473133011"
recode s1aq3b s1aq6b (else=1)  if df==1 & (hid=="5530155342009" | hid=="6112561121005" | hid=="7310473133011")
replace s1aq4b=1 if df==1 & s1aq4b==3
recode s1aq4a s1aq6a (else=1)  if df==1 & hid=="7310473133011"
replace checked=1       if checked==. & df==1 
drop df

gen asd=1   if s1aq6a~=. & s1aq6b!=. & s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==. 
count if asd==1 & s1aq7a~=.
count if asd==1 & s1aq7b~=.
count if asd==1 & s1aq8a~=.
count if asd==1 & s1aq8b~=.
tab1 s1aq3b s1aq4b s1aq6b s1aq7b s1aq8b if asd==1
count if asd==1 & s1aq5==.
gen asd1=1   if asd==1 & s1aq5==.
gen asd2=1   if asd1==1 & s1aq3a==s1aq4a & s1aq3a==s1aq6a 
ta s1aq3b    if asd2==1 
replace s1aq6b=s1aq3b   if s1aq1==201 & hid=="8220182233014"
replace checked=1       if checked==. & s1aq1==201 
replace s1aq7a=s1aq3a  if asd1==1 
replace s1aq7b=s1aq3b  if asd1==1 
recode s1aq4a-s1aq6b (else=.)  if asd1==1
replace s1aq7a=s1aq6a  if asd2==1 & s1aq7a==. 
replace s1aq7b=s1aq6b  if asd2==1 & s1aq7b==.  
recode s1aq4a-s1aq6b (else=.)  if asd2==1 

gen dfgh=1  if asd2==1 & s1aq3b~=s1aq6b & s1aq1<=5
recode s1aq3a s1aq6a (805=105)  if asd2==1 & s1aq3b~=s1aq6b & s1aq1<=5  
*replace s1aq3b=10   if asd2==1 & (s1aq3b~=s1aq6b & s1aq1<=5 & s1aq3b==1)   //should we replace some of these as they look like outleirs.  Leavign as is for now and durign analytics this can be fixed
*replace s1aq7a=s1aq3a  if dfgh==1
*replace s1aq7b=s1aq3b  if dfgh==1
*recode s1aq4a-s1aq6b (else=.)  if dfgh==1
replace checked=1       if checked==. & dfgh==1 
drop dfgh asd2
gen asd2=1   if asd1==1 & s1aq3a==s1aq4a & s1aq3a==s1aq6a 
drop asd2 
 
gen dfge=1  if s1aq3a~=. & s1aq3b~=. & s1aq4a==. & s1aq4b==. & s1aq5==. & s1aq6a==. & s1aq6b==. & s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==.
count if dfge==1  //2564.  Assume that this was from own stock/production or gifts so that you do not lose HH consumption
ta s1aq1  if dfge==1 & s1aq3b==0  //0 obs
replace s1aq4a=7  if hid=="2410124122013" & s1aq1==251
replace s1aq4b=5  if hid=="2410124122013" & s1aq1==251
recode s1aq3b s1aq8b (else=99)  if s1aq1==251 & hid=="7111171113001"
recode s1aq4a-s1aq6b (else=.)    if s1aq1==251 & hid=="7111171113001"
recode s1aq3b s1aq4b s1aq6b (else=5)  if s1aq1==251 & (hid=="2120221245004"  | hid=="3050330585009") 
replace checked=1       if checked==. & s1aq3b<5 & s1aq1==251
replace s1aq7a=s1aq3a  if dfge==1 & s1aq8a==.
replace s1aq7b=s1aq3b  if dfge==1 & s1aq8b==.
replace checked=1       if checked==. & dfge==1 
drop dfge 

ta s1aq4a  if s1aq4b==14
gen dfge=1  if s1aq4b==14
gen dfge1=1 if dfge==1 & s1aq4a>=700 & s1aq4b==14
drop dfge1 
gen dfge1=1 if dfge==1 & s1aq5<500
replace s1aq7a=s1aq3a  if dfge1==1 & s1aq1==3 & hid=="5111951130008"
replace s1aq7b=s1aq3b  if dfge1==1 & s1aq1==3 & hid=="5111951130008"
recode s1aq4a-s1aq6b (else=.) if dfge1==1 & s1aq1==3 & hid=="5111951130008"
replace s1aq4a=s1aq5/50   if dfge==1 & s1aq1==226
replace s1aq4b=1          if dfge==1 & s1aq1==226 
replace s1aq4b=.  if s1aq4a==. & s1aq1==226 
replace s1aq3b=99  if dfge==1 & s1aq1==226 & s1aq3b==14
replace s1aq6b=99  if dfge==1 & s1aq1==226 & s1aq6b==14
replace s1aq7b=99  if dfge==1 & s1aq1==226 & s1aq7b==14
drop dfge1 


**sweet pottaoes
replace s1aq5=s1aq6a   if s1aq1==167 & hid=="4111241102011"
recode s1aq3a s1aq4a s1aq6a (else=7)    if s1aq1==167 & hid=="4111241102011"
recode s1aq3b s1aq4b s1aq6b (else=11)   if s1aq1==167 & hid=="4111241102011"
recode s1aq7a s1aq7b (else=.)  if s1aq1==167 & hid=="4111241102011"
replace s1aq5=s1aq4a   if s1aq1==167 & hid=="8621986204016"
recode s1aq3a s1aq4a s1aq6a (else=12)    if s1aq1==167 & hid=="8621986204016"
recode s1aq3b s1aq4b s1aq6b (else=11)   if s1aq1==167 & hid=="8621986204016"
 
gen hjk=1  if s1aq1==167 & s1aq5==.
replace s1aq7a=s1aq3a  if hjk==1 & s1aq8a==.
replace s1aq7b=s1aq3b  if hjk==1 & s1aq8b==.
replace s1aq8a=s1aq3a  if hjk==1 & s1aq7a==.
replace s1aq8b=s1aq3b  if hjk==1 & s1aq7b==.
recode s1aq4a-s1aq6b (else=.)   if hjk==1 
drop hjk

gen hjk=1  if s1aq4a~=. & s1aq4a==s1aq5 & s1aq1==167  //price and quantity purchased same.  Not for this item 
replace s1aq5=30  if hjk==1 & hid=="3330433304005"
replace s1aq5=70  if hjk==1 & hid=="5221652215005"
replace s1aq5=s1aq5*10  if hjk==1 & hid=="8311083132003"
recode s1aq3b s1aq4b s1aq6b (else=11)  if hjk==1 & hid=="6323563229100"
replace s1aq6a=s1aq3a  if hjk==1 & (hid=="3330433304005" | hid=="5221652215005" | hid=="5621856202007")
replace s1aq4a=s1aq6a  if hjk==1 
replace s1aq4b=s1aq6b  if hjk==1 
recode s1aq3a s1aq4a s1aq6a (else=4)  if hjk==1 & hid=="6420364203001"
recode s1aq3b s1aq4b s1aq6b (else=1)  if hjk==1 & hid=="6420364203001"
drop hjk 

replace s1aq5=15       if s1aq1==167 & hid=="3133631323008"
replace s1aq4a=s1aq3a  if s1aq1==167 & hid=="3222832216003" 
replace s1aq3a=s1aq6a  if s1aq1==167 & hid=="3410834114002" 
replace s1aq3b=s1aq6b  if s1aq1==167 & s1aq3b==2 
replace s1aq6b=s1aq3b  if s1aq1==167 & s1aq6b==2 
recode s1aq3b s1aq4b s1aq6b (else=1)  if s1aq1==167 & (hid=="5310353120012" | hid=="5321053215012")  
replace s1aq5=25  if s1aq1==167 & hid=="5310353120012"
replace s1aq4a=s1aq3a  if s1aq1==167 & (hid=="5110551105008" | hid=="5210652125002") 
replace s1aq6a=s1aq3a  if s1aq1==167 & hid=="5110551105008"
recode s1aq8a s1aq8b (else=.)  if s1aq1==167 & (hid=="5011150170014" | hid=="5013050121012")
recode s1aq7a s1aq7b (else=.)  if s1aq1==167 & (hid=="5121651214015" | hid=="5530155356008" | hid=="7331673301007")

gen hjk=1  if s1aq4b==14 & s1aq1==167 
replace s1aq5=150  if hjk==1
replace s1aq4b=s1aq3b if hjk==1 
drop hjk

gen hjk=1  if s1aq1==167 & (s1aq3b>=2 & s1aq3b<6)
recode s1aq3b s1aq4b s1aq6b (else=11)  if hjk==1 
replace s1aq5=s1aq5*10  if hjk==1 & s1aq5==4
replace s1aq3a=s1aq6a  if hjk==1
drop hjk 

gen hjk=1  if s1aq1==167 & (s1aq3b>=7 & s1aq3b<11)
replace s1aq3a=s1aq6a   if hjk==1
replace s1aq4a=s1aq6a   if hjk==1
recode s1aq3b s1aq4b s1aq6b (else=11)  if hjk==1 
drop hjk

gen hjk=1  if s1aq1==167 & (s1aq4b==0 | s1aq4b==2 | s1aq4b==3 | s1aq4b==12 | s1aq4b==99)
replace s1aq4a=s1aq3a  if hjk==1
replace s1aq4b=s1aq3b  if hjk==1
replace s1aq6a=s1aq3a  if hjk==1
replace s1aq6b=s1aq3b  if hjk==1
replace s1aq5=200  if hjk==1 & s1aq5==500 
drop hjk

gen hjk=1  if s1aq1==167 & (s1aq6b==0 | s1aq6b==5 | s1aq6b==7 | s1aq6b==10 | s1aq6b==12 | s1aq6b==14)
replace s1aq6b=s1aq3b  if hjk==1
recode s1aq7a-s1aq7b (else=.)  if hjk==1 
drop hjk

gen hjk=1  if s1aq1==167 & s1aq7b==0 
recode s1aq7a-s1aq7b (else=.)  if hjk==1 
drop hjk

gen hjk=1  if s1aq1==167 & s1aq8b==0 
recode s1aq8a-s1aq8b (else=.)  if hjk==1 
drop hjk

replace checked=1       if checked==. & s1aq1==167


**boabob fruit 
gen hjk=1  if s1aq1==118 & s1aq5==.
replace s1aq7a=s1aq3a  if hjk==1 & s1aq8a==.
replace s1aq7b=s1aq3b  if hjk==1 & s1aq8b==.
replace s1aq8a=s1aq3a  if hjk==1 & s1aq7a==.
replace s1aq8b=s1aq3b  if hjk==1 & s1aq7b==.
recode s1aq4a-s1aq6b (else=.)   if hjk==1 
drop hjk

gen hjk=1  if s1aq4a~=. & s1aq4a==s1aq5 & s1aq1==118
recode s1aq4a-s1aq7b (else=.)   if hjk==1 & hid=="3330533320004"
recode s1aq3b s1aq8b (else=6)   if hjk==1 & hid=="3330533320004"
replace s1aq4a=s1aq3a  if hjk==1 & hid=="8611386125002"
replace s1aq6b=s1aq3b  if hjk==1 & hid=="8611386125002"
drop hjk 

gen hjk=1  if s1aq1==118 & (s1aq3b==3 | s1aq3b==4 | s1aq3b==13 | s1aq3b==14) 
replace s1aq4a=s1aq3a  if s1aq1==118 & hid=="3230232347013"
replace s1aq4b=s1aq3b if hjk==1 & s1aq3b==13 & s1aq4b~=.
replace s1aq6b=s1aq3b if hjk==1 & s1aq3b==13 & s1aq6b~=.
recode s1aq3a s1aq4a s1aq6a (else=4 ) if hjk==1 & hid=="6411164123013"
recode s1aq3b s1aq4b s1aq6b (else=11 ) if hjk==1 & hid=="6411164123013"
drop hjk 

gen hjk=1  if s1aq1==118 & s1aq3b==14 
replace s1aq3a=s1aq6a  if hjk==1 & s1aq6a~=. 
replace s1aq3b=s1aq6b  if hjk==1 & (s1aq6b~=. & s1aq6b~=14)
replace s1aq3b=99  if hjk==1 & s1aq3b==14
replace s1aq4b=99  if hjk==1 & (s1aq4b~=. & s1aq4b==14)
replace s1aq6b=99  if hjk==1 & (s1aq6b~=. & s1aq6b==14)
replace s1aq7b=99  if hjk==1 & (s1aq7b~=. & s1aq7b==14)

recode s1aq7a-s1aq8b (else=.)  if s1aq1==118 & s1aq4a~=.
replace s1aq3b=s1aq6b  if s1aq1==118 & hid=="5310353120001"
recode s1aq7a-s1aq7b (else=.)  if s1aq1==118 & hid=="5211652115006"
replace checked=1       if checked==. & s1aq1==118
drop hjk 


**irish potato
replace s1aq5=s1aq6a  if s1aq1==168 & hid=="4021240209011"
recode s1aq3a s1aq4a s1aq6a (else=7)  if s1aq1==168 & hid=="4021240209011"
recode s1aq3b s1aq4b s1aq6b (else=11)  if s1aq1==168 & hid=="4021240209011"
recode s1aq7a s1aq7b (else=.)         if s1aq1==168 & (hid=="4021240209011" | hid=="4311543120016")
replace s1aq5=s1aq4a     if s1aq1==168 & hid=="4210142109011"
replace s1aq4a=s1aq5/50  if s1aq1==168 & hid=="4210142109011"
replace s1aq3a=s1aq6a  if s1aq1==168 & hid=="4210142109008"
replace s1aq5=s1aq5/10  if s1aq1==168 & hid=="4121441205011"
recode s1aq3b s1aq4b s1aq6b (else=1)  if s1aq1==168 & hid=="4210342104015"
replace s1aq5=s1aq5/10  if s1aq1==168 & hid=="4311743142010"
replace s1aq6a=s1aq3a  if s1aq1==168 & hid=="4410644108006"
replace s1aq6b=s1aq3b  if s1aq1==168 & hid=="4410644108006"
replace s1aq5=.        if s1aq1==168 & hid=="4410644108006"

replace s1aq4a=1   if s1aq1==168 & (hid=="4021340217001" | hid=="4021340217007" | hid=="4021340217011" | hid=="4021340217010" | hid=="4210242107001" | hid=="4210242107002" ) 
replace s1aq4b=14  if s1aq1==168 & (hid=="4021340217001" | hid=="4021340217007" | hid=="4021340217011" | hid=="4021340217010" | hid=="4210242107001" | hid=="4210242107002" ) 
replace s1aq3b=s1aq6b  if s1aq1==168 & (hid=="4021340217001" | hid=="4021340217007" | hid=="4021340217011" | hid=="4021340217010" | hid=="4210242107001" | hid=="4210242107002" ) 
recode s1aq3b s1aq6b (14=11)    if s1aq1==168 & (hid=="4021340217001" | hid=="4021340217007" | hid=="4021340217011" | hid=="4021340217010" | hid=="4210242107001" | hid=="4210242107002" ) 
recode s1aq3b s1aq6b (14=11)   if s1aq1==168 & (hid=="4021340217001" | hid=="4021340217007" | hid=="4021340217010" | hid=="4111241102006" | hid=="4121141207002")

recode s1aq3a s1aq4a s1aq6a (30=3)   if s1aq1==168 & hid=="4110241106001"  //based on prices in data
recode s1aq3a s1aq4a s1aq6a (else=5)  if s1aq1==168 & hid=="3821338205011"
replace s1aq3a=s1aq6a  if s1aq1==168 & hid=="8110281125002"
recode s1aq3b s1aq4b s1aq6b (else=1)  if s1aq1==168 & (hid=="3821338205011" | hid=="8110281125002")

gen hjk=1  if s1aq1==168 & (s1aq3b==2 | s1aq3b==4 | s1aq3b==5)
replace s1aq5=s1aq4a  if s1aq1==168 & hid=="4512045110002"
replace s1aq4a=s1aq3a  if s1aq1==168 & hid=="4512045110002"
replace s1aq6a=s1aq3a  if s1aq1==168 & hid=="4512045110002"
recode s1aq7a s1aq7b (else=.) if s1aq1==168 & hid=="4512045110002"
replace s1aq4a=s1aq5/50  if hjk==1 & s1aq5>=100  & s1aq4b==2
recode s1aq3b s1aq4b s1aq6b (2=1) if hjk==1 & (hid=="5310353120011" | hid=="5310753122004" | hid=="5611756102006" | hid=="8220282217013" | hid=="8111181106006" | hid=="7440674410007" | hid=="8310283111003" | hid=="8311083132007" | hid=="8511285126009" | hid=="6313963107003" | hid=="8120681207008" | hid=="6313963107003" | hid=="4512045110009" | hid=="4510345114011" | hid=="4512045110002" | hid=="6122261202002" | hid=="7322073230013")
replace s1aq3b=6  if s1aq1==168 & hjk==1 & s1aq3b==5 
replace s1aq4b=6  if s1aq1==168 & hjk==1 & s1aq4b==5 
replace s1aq6b=6  if s1aq1==168 & hjk==1 & s1aq6b==5 
replace s1aq4a=1   if s1aq1==168 & hid=="4021240209002"  
replace s1aq4b=14  if s1aq1==168 & hid=="4021240209002"  
recode s1aq8a s1aq8b (else=.)  if s1aq1==168 & hid=="4021240209002"
drop hjk 
 
gen hjk=1  if s1aq1==168 & s1aq3b==3
replace s1aq5=s1aq4a  if hjk==1 & hid=="7510175104090"
replace s1aq4a=s1aq5/50  if hjk==1 & s1aq5==150
replace s1aq6a=s1aq3a  if hjk==1 & hid=="7510175104090"
recode s1aq7a s1aq7b (else=.)  if hjk==1
replace s1aq4a=1   if hjk==1 & hid=="4010240101006" 
replace s1aq4b=14  if hjk==1 & hid=="4010240101006"
recode s1aq3b s1aq6b (else=6)  if hjk==1 & hid=="4010240101006"
replace s1aq3b=1  if hjk==1 & s1aq3b==3
replace s1aq4b=1  if hjk==1 & s1aq4b==3
replace s1aq6b=1  if hjk==1 & s1aq6b==3
drop hjk 

gen hjk=1  if s1aq1==168 & (s1aq4b==0 | s1aq4b>2 & s1aq4b<6 | s1aq4b==12)
replace s1aq4a=1   if hjk==1 & hid=="2010120101001"
replace s1aq4b=1   if hjk==1 & hid=="2010120101001"
replace s1aq4b=1   if hjk==1 & hid=="3020230247001"
replace s1aq6b=6  if hjk==1 & s1aq6b==0
replace s1aq3a=s1aq6a  if hjk==1 
replace s1aq3b=s1aq6b  if hjk==1 
recode s1aq4a-s1aq6b (else=.)  if hjk==1 & (hid=="3330533320010" | hid=="3522535215003" | hid=="3710137101016" )
replace s1aq7a=s1aq3a  if hjk==1 & (hid=="3330533320010" | hid=="3710137101016" )
replace s1aq7b=s1aq3b  if hjk==1 & (hid=="3330533320010" | hid=="3710137101016" )
drop hjk

gen hjk=1  if s1aq1==168 & s1aq4b==14
replace s1aq4a=1   if hjk==1 & hid=="3710137101015"
recode s1aq3b s1aq6b (else=6)  if hjk==1 & hid=="3710137101015"
replace s1aq4b=1  if hjk==1 & hid=="1220112215010"
recode s1aq3b s1aq6b (else=11)  if hjk==1 & hid=="3810838102006" 
*recode s1aq3b s1aq6b (else=1)   if hjk==1 & hid=="4010240101015" 
replace s1aq3a=s1aq6a  if hjk==1 & hid=="5012750140007"
recode s1aq3b s1aq6b (else=11)  if hjk==1 & hid=="4111241102006"
replace s1aq3a=s1aq6a           if hjk==1 & hid=="4111241102006"
replace s1aq6a=s1aq3a           if hjk==1 & hid=="6421564215013"
replace s1aq6b=s1aq3b           if hjk==1 & hid=="6421564215013"
drop hjk 

gen dfge1=1 if dfge==1 & s1aq5<500 & s1aq4b==14 
br if dfge1==1 & (s1aq3a==s1aq4a & s1aq4a==s1aq6a)
gen dfge2=1  if dfge1==1 & (s1aq3a==s1aq4a & s1aq4a==s1aq6a) & (s1aq1==178 | s1aq1==179)
replace s1aq5=.  if dfge2==1 & (hid=="3050230524009" | hid=="3133631323016")
replace s1aq4a=s1aq5/35  if dfge2==1
replace s1aq4b=1         if dfge2==1 & s1aq4b~=. 
recode s1aq3b s1aq4b s1aq6b (else=1)  if dfge2==1 & hid=="4210442101016"
replace s1aq3b=10  if dfge2==1 & s1aq3b==14 
replace s1aq6b=s1aq3b  if dfge2==1 
drop dfge2 
 
gen dfge2=1  if dfge1==1 & s1aq1<6
replace s1aq7a=s1aq3a  if dfge2==1 & s1aq5<100
replace s1aq7b=s1aq3b  if dfge2==1 & s1aq5<100
replace s1aq4a=.       if dfge2==1 & s1aq5<100
replace s1aq4b=.       if dfge2==1 & s1aq5<100
replace s1aq5 =.       if dfge2==1 & s1aq5<100
replace s1aq6a=.       if dfge2==1 & s1aq5==.
replace s1aq6b=.       if dfge2==1 & s1aq5==.
replace s1aq4a=.25     if dfge2==1 & s1aq4a~=.
drop dfge2 
recode s1aq3b s1aq4b s1aq6b (else=10)  if dfge1==1 & s1aq1==105 
recode s1aq3b s1aq4b s1aq6b (else=99)  if dfge1==1 & s1aq1==110

recode s1aq4a s1aq4b (else=.)  if s1aq1==122 & s1aq5==. 
replace s1aq3a=14  if dfge1==1 & s1aq1==122 & hid=="3511835102016"
replace s1aq4a=14  if dfge1==1 & s1aq1==122 & hid=="3511835102016"
replace s1aq6a=14  if dfge1==1 & s1aq1==122 & hid=="3511835102016"
replace s1aq3b=8   if dfge1==1 & s1aq1==122 & hid=="3511835102016"
replace s1aq4b=8   if dfge1==1 & s1aq1==122 & hid=="3511835102016"
replace s1aq6b=8   if dfge1==1 & s1aq1==122 & hid=="3511835102016"
replace s1aq3b=s1aq7b   if s1aq1==122 & hid=="8610986122013"
recode s1aq6a s1aq6b (else=.)  if s1aq1==122 &  hid=="3521135203004"
recode s1aq7a s1aq7b (else=.)  if s1aq1==122 & (hid=="3421034211014" | hid=="3520535211006") 
recode s1aq8a s1aq8b (else=.)  if s1aq1==122 & hid=="3511835102001" 
replace checked=1  if checked==. & s1aq1==122 

gen dfge2=1  if dfge1==1 & (s1aq3a==s1aq4a & s1aq4a==s1aq6a) 
recode s1aq3b s1aq4b s1aq6b (else=6)   if dfge2==1 & s1aq1==194 
recode s1aq3b s1aq4b s1aq6b (else=6)   if dfge2==1 & s1aq1==194 
drop dfge2 

replace s1aq3b=s1aq6b  if s1aq1==227 & hid=="5420554201001"
replace s1aq4b=s1aq6b  if s1aq1==227 & hid=="5420554201001"
replace s1aq4b=1  if s1aq1==227 & hid=="5310753122003"
recode s1aq3b s1aq6b (else=10) if s1aq1==227 & hid=="5310753122003"

gen hjk=1  if s1aq1==247
replace s1aq4a=s1aq3a   if hjk==1 & (hid=="6313963104007" | hid=="8410784114011") 
replace s1aq5=s1aq4a    if hjk==1 & hid=="3081730807008" 
replace s1aq4a=s1aq3a   if hjk==1 & hid=="3081730807008" 
replace s1aq4b=s1aq3b   if hjk==1 & hid=="3081730807008" 
replace s1aq6a=s1aq4a   if hjk==1 & hid=="3081730807008" 
replace s1aq6b=s1aq3b   if hjk==1 & hid=="3081730807008" 
recode s1aq4a-s1aq6b (else=.)  if hjk==1 & s1aq3b==2 
recode s1aq3b s1aq8b (else=5)  if hjk==1 & s1aq3b==2 
recode s1aq3b s1aq4b s1aq6b (else=3)  if hjk==1 & s1aq3b==4 
recode s1aq3b s1aq4b s1aq6b (else=3)  if hjk==1 & s1aq3b==11 
recode s1aq3b s1aq4b s1aq6b (else=13)  if hjk==1 & s1aq3b==14 
replace s1aq4a=s1aq3a  if s1aq1==247 & hid=="6421564215003"
replace s1aq4b=s1aq3b  if s1aq1==247 & hid=="6421564215003"
recode s1aq8a s1aq8b (else=.)  if s1aq1==247 & hid=="3130231348006"
recode s1aq4a-s1aq6b (else=.)  if s1aq1==247 & s1aq5==.
recode s1aq8a-s1aq8b (else=.)  if s1aq1==247 & s1aq5~=. & s1aq8a~=.
replace checked=1  if checked==. & s1aq1==247 

gen dfge2=1  if dfge1==1 & (s1aq3a==s1aq4a & s1aq4a==s1aq6a) 
replace s1aq4a=s1aq5/50  if dfge2==1 & s1aq1==227 
replace s1aq4b=1   if dfge2==1 & s1aq1==227 
recode s1aq3b s1aq6b (else=10)  if dfge2==1 & s1aq1==227

replace s1aq5=s1aq5/10  if s1aq1==187 & (hid=="3050230524006" | hid=="3230432314008" | hid=="3240832455014" | hid=="3321033216004" | hid=="3710137101014") 
recode s1aq3a s1aq4a (else=1)   if s1aq1==187 & hid=="5221852211015"
recode s1aq3b s1aq4b (else=11)  if s1aq1==187 & hid=="5221852211015"
replace s1aq6a=s1aq3a  if s1aq1==187 & hid=="4311543116014"
replace s1aq3b=s1aq6b  if s1aq1==187 & hid=="4311543116014"
recode s1aq3a s1aq4a s1aq6a (else=2)  if s1aq1==187 & hid=="5420554201009" 
replace s1aq5=250  if s1aq1==187 & hid=="7310173107014"
replace s1aq5=s1aq5/10  if s1aq1==187 & (hid=="5211052111005" | hid=="5321053215002")
recode s1aq3b s1aq4b s1aq6b (else=1)  if s1aq1==187 & (hid=="5211052111005" | hid=="5321053215002")
replace checked=1  if checked==. & s1aq1==187 

recode s1aq3a s1aq4a s1aq6a (else=14)  if dfge1==1 & s1aq1==194 & (hid=="3710537105012" | hid=="7220472231002" | hid=="7330373311001" | hid=="8121181225012" | hid=="8323283239004")
recode s1aq3b s1aq4b s1aq6b (else=6)  if dfge1==1 & s1aq1==194 & (hid=="7220472231002" | hid=="7330373311001" | hid=="8121181225012" | hid=="8323283239004")
replace s1aq5=28  if dfge1==1 & s1aq1==194 & (hid=="7220472231002" | hid=="7330373311001" | hid=="8121181225012" | hid=="8323283239004")
replace s1aq6a=s1aq3a  if dfge1==1 & s1aq1==178 & hid=="8511285122015"
replace s1aq6b=s1aq3b  if dfge1==1 & s1aq1==178 & hid=="8511285122015"
replace s1aq5=.   if dfge1==1 & s1aq1==178 & hid=="8511285122015"
replace s1aq3a=s1aq6a  if dfge1==1 & s1aq6a~=.
replace s1aq7a=s1aq3a  if dfge1==1 & s1aq5==. & (hid=="3050230524009" | hid=="3133631323016")
replace s1aq7b=s1aq3b  if dfge1==1 & s1aq5==. &  (hid=="3050230524009" | hid=="3133631323016")
recode s1aq4a-s1aq6b (else=.)  if dfge1==1 & s1aq5==. &  (hid=="3050230524009" | hid=="3133631323016")
recode s1aq3b s1aq7b (else=10)  if dfge1==1 & s1aq1==3 & hid=="7010170111009"
replace checked=1  if checked==. & dfge1==1 
replace checked=1  if checked==. & s1aq1==227 

replace s1aq5=s1aq4a  if s1aq1==110 & hid=="5013050117006"
replace s1aq4a=1      if s1aq1==110 & hid=="5013050117006"
replace s1aq4b=12     if s1aq1==110 & hid=="5013050117006"
replace s1aq6a=s1aq3a  if s1aq1==110 & hid=="5013050117006"
replace s1aq6b=s1aq4b  if s1aq1==110 & hid=="5013050117006"
replace s1aq3b=s1aq4b  if s1aq1==110 & hid=="5013050117006"

gen ghq=1  if s1aq1==110  & s1aq5~=. & s1aq4a==.
replace s1aq4a=s1aq3a  if ghq==1
replace s1aq4b=s1aq3b  if ghq==1
replace s1aq6a=s1aq3a  if ghq==1
replace s1aq6b=s1aq3b  if ghq==1 
replace checked=1  if checked==. & ghq==1

recode s1aq4a-s1aq6b (else=.) if dfge==1 & s1aq5==.
replace s1aq8a=.  if s1aq1==4 & hid=="5012550139009"
replace s1aq7a=s1aq3a   if dfge==1 & s1aq5==. & s1aq8a==. & s1aq8b==.
replace s1aq7b=s1aq3b   if dfge==1 & s1aq5==. & s1aq8a==. & s1aq8b==.
replace s1aq8a=s1aq3a   if dfge==1 & s1aq5==. & s1aq7a==. & s1aq7b==.
replace s1aq8b=s1aq3b   if dfge==1 & s1aq5==. & s1aq7a==. & s1aq7b==.

gen dgfe=1  if s1aq1==141
recode s1aq4a-s1aq6b (else=.) if dgfe==1 & s1aq5==.
replace s1aq3b=9  if s1aq3b==0 & s1aq1==141
replace s1aq4b=9  if s1aq4b==0 & s1aq1==141
replace s1aq6b=9  if s1aq6b==0 & s1aq1==141
replace s1aq7b=9  if s1aq7b==0 & s1aq1==141
replace s1aq8b=9  if s1aq8b==0 & s1aq1==141
replace s1aq3b=9  if s1aq1==141 & (s1aq3b==2 | s1aq3b==3 | s1aq3b==14 | s1aq3b==15)
replace s1aq7a=s1aq3a  if dgfe==1 & (hid=="4121041204005" | hid=="6311763117013" | hid=="8420684201015") 
replace s1aq7b=s1aq3b  if dgfe==1 & (hid=="4121041204005" | hid=="6311763117013" | hid=="8420684201015") 
recode s1aq8a-s1aq8b (else=.) if dgfe==1 & (hid=="4121041204005" | hid=="6311763117013" | hid=="8420684201015") 
replace s1aq7a=s1aq3a  if dgfe==1 & (s1aq5==. & s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==.)
replace s1aq7b=s1aq3b  if dgfe==1 & (s1aq5==. & s1aq8a==. & s1aq8b==.)
replace s1aq8a=s1aq3a       if s1aq1==141 & hid=="3810438110002"
replace s1aq8b=s1aq3b  if s1aq1==141 & hid=="3810438110002"
replace s1aq8a=s1aq3a       if s1aq1==141 & hid=="4011140114003"
recode s1aq3b s1aq8b (1=9)  if s1aq1==141 & hid=="8420684201006" 
recode s1aq3b s1aq7b (1=9)  if s1aq1==141 & (hid=="5622256208010" | hid=="8411284101012")
replace checked=1       if checked==. & s1aq1==141 
drop dgfe dfge
  
/*replace s1aq5=s1aq4a   if s1aq1==11 & hid=="8411184117002"
replace s1aq4a=1       if s1aq1==11 & hid=="8411184117002"
replace s1aq6a=s1aq3a  if s1aq1==11 & hid=="8411184117002"
replace s1aq6b=s1aq3b  if s1aq1==11 & hid=="8411184117002"
replace s1aq4a=1       if s1aq1==13 & hid=="8411184117002"
replace s1aq5=s1aq4a   if hid=="8411184117002" & s1aq5==.
replace s1aq6a=s1aq3a  if hid=="8411184117002"
replace s1aq6b=s1aq3b  if hid=="8411184117002"
recode s1aq4a-s1aq6b (else=.)  if s1aq5==. & hid=="8411184117002"
replace s1aq4a=s1aq6a   if hid=="8411184117002" & (s1aq4a~=1)
replace s1aq8b=s1aq3b  if s1aq1==178 & hid=="8411184117002"
replace checked=1       if checked==. & hid=="8411184117002"*/

gen dfge=1  if s1aq4b==14
replace s1aq5=s1aq4a  if s1aq1==17 & hid=="3120531214005"
recode s1aq3a s1aq4a s1aq6a (else=3)  if s1aq1==17 & hid=="3120531214005"
recode s1aq3b s1aq4b s1aq6b (else=6)  if s1aq1==17 & hid=="3120531214005"
recode s1aq7a s1aq7b (else=.)  if s1aq1==17 & hid=="3120531214005"

gen ghj=1  if dfge==1 & (s1aq1==16 | s1aq1==17) & s1aq3b<6
*recode s1aq3b s1aq4b s1aq6b (else=6)  if ghq==1
replace s1aq5=s1aq4a  if s1aq1==16 & hid=="5530155339006"
recode s1aq3a s1aq4a s1aq6a (else=2)  if s1aq1==16 & hid=="5530155339006"
recode s1aq3b s1aq4b s1aq6b (else=6)  if s1aq1==16 & hid=="5530155339006"
drop ghj 

gen ghj=1  if (s1aq1==16 | s1aq1==17) & s1aq6b<6
replace s1aq3b=6  if ghj==1 & s1aq3b~=6 
replace s1aq4b=s1aq3b  if ghj==1 
replace s1aq6b=s1aq3b  if ghj==1 
recode s1aq3a s1aq4a s1aq6a (else=14)  if s1aq1==16 & (hid=="8610986122009" | hid=="8610986122011")
replace s1aq5=s1aq4a  if s1aq1==16 & (hid=="3820638202009" | hid=="4210442101001" | hid=="6410364103010")
replace s1aq4a=s1aq3a    if s1aq1==16 & (hid=="3820638202009" | hid=="4210442101001" | hid=="6410364103010")
replace s1aq4a=s1aq3a  if s1aq1==16 & hid=="6430764305010"
replace s1aq5=s1aq5*10  if s1aq1==16 & hid=="7330573322016"
replace s1aq6a=s1aq3a  if ghj==1 
recode s1aq7a-s1aq8b (else=.)  if ghj==1 
*repalce s1aq6a=s1aq4a  if ghj==1 & ((s1aq1==16 & hid=="3230232357013" ) | (s1aq1==16 & hid=="3820638202009"))
drop ghj 
gen ghj=1  if (s1aq1==16 | s1aq1==17) & s1aq6b>6
gen ghj1=1  if ghj==1 & (s1aq3b>6 & s1aq3b<11)
replace s1aq3b=6  if ghj1==1
replace s1aq4b=6  if ghj1==1 & s1aq4b~=. 
replace s1aq6b=6  if ghj1==1 & s1aq6b~=. 
replace s1aq7b=6  if ghj1==1 & s1aq7b~=. 
drop ghj1 
recode s1aq3a s1aq8a (else=14)  if ghj==1 & s1aq1==16 & hid=="3821338206010"
recode s1aq3b s1aq8b (else=11)  if ghj==1 & s1aq1==16 & hid=="3821338206010"
drop ghj 

gen ghj=1  if  (s1aq1==16 | s1aq1==17)
gen corrects=s1aq6a*7   if ghj==1
gen corr=s1aq5/7  if ghj==1 
gen corr1=round(corr)
order hid-s1aq4a corr1 corr corrects s1aq4b 
replace s1aq5=s1aq4a   if ghj==1 & (hid=="4111341101006" | hid=="5012950107011") 
replace s1aq4a=s1aq3a  if ghj==1 & (hid=="4111341101006" | hid=="5012950107011") 
replace s1aq6a=s1aq3a  if ghj==1 & (hid=="4111341101006" | hid=="5012950107011") 
replace s1aq4a=s1aq6a  if ghj==1 & s1aq1==17 & hid=="5530155311012"
replace s1aq4a=s1aq4a/10   if ghj==1 & s1aq1==16 & hid=="6411464112015"
replace s1aq6a=s1aq4a  if ghj==1 & (hid=="5530155311012" | hid=="6411464112015" )
replace s1aq4a=s1aq6a  if ghj==1 & (hid=="6311963130006" | hid=="6410764121012" | hid=="8610586117008" | hid=="8610686120015" | hid=="8611486127010" | hid=="8611586104009" ) 
replace s1aq5=s1aq5*10  if ghj==1 & s1aq1==16 & hid=="8611586104009"
replace s1aq3a=s1aq3b if ghj==1 & s1aq1==17 & hid=="3222432230013"
replace s1aq3b=6      if ghj==1 & s1aq1==17 & hid=="3222432230013"
replace s1aq6a=s1aq3a  if ghj==1 & (hid=="3020230225001" | hid=="3030130341011" | hid=="3071930721002" | hid=="3144131471001" | hid=="3222432230004" | hid=="3222432230013"  )
replace s1aq4a=s1aq3a  if ghj==1 & (hid=="3020230225001" | hid=="3030130341011" | hid=="3071930721002" | hid=="3144131471001" | hid=="3222432230004" | hid=="3222432230013"  )
replace s1aq5=s1aq4a*7  if ghj==1 & s1aq5==1414
replace s1aq3a=s1aq6a  if ghj==1 & s1aq1==16 & hid=="3133631305002"
replace s1aq4a=s1aq6a  if ghj==1 & hid=="4120441209012"
replace s1aq3a=s1aq6a  if ghj==1 & hid=="4120441209012"
replace s1aq5=corrects  if ghj==1 & hid=="5012550139008" 
recode s1aq7a-s1aq8b (else=.)  if ghj==1 & (hid=="5012750140002" | hid=="5013050113013" | hid=="5020150236006" | hid=="5020850205006") 
replace s1aq3a=s1aq6a if ghj==1 & (hid=="3144131471001" | hid=="3210932108007" | hid=="3222432230013" )
replace s1aq5=s1aq5*10  if ghj==1 & s1aq1==16 & hid=="3210932108007" 
drop corrects corr corr1

gen ghj1=1  if ghj==1 & s1aq3a>s1aq6a 
replace s1aq7a=.  if ghj1==1 & s1aq7b==0 
replace s1aq7b=.  if ghj1==1 & s1aq7a==. 
replace s1aq8a=.  if ghj1==1 & s1aq8b==0 
replace s1aq8b=.  if ghj1==1 & s1aq8a==. 
replace s1aq3a=s1aq4a  if ghj1==1 & s1aq1==16 & hid=="3522535218001"
replace s1aq6a=s1aq4a  if ghj1==1 & s1aq1==16 & hid=="3810638106012"
replace s1aq5=s1aq5*7  if ghj1==1 & s1aq1==16 & (hid=="3810638106012" | hid=="1220112202012")
recode s1aq4a s1aq6a (else=10)  if ghj1==1 & (hid=="4020540221014" )
replace s1aq7a=6  if ghj1==1 & s1aq1==16 & hid=="4110941110013"
recode s1aq4a s1aq6a (else=23) if ghj1==1 & s1aq1==16 & hid=="4110941110013"
replace s1aq7a=10 if ghj1==1 & s1aq1==16 & hid=="4110941110013"
recode s1aq3a s1aq4a (else=2) if ghj1==1 & hid=="4110941110015"
recode s1aq3b s1aq4b (else=6) if ghj1==1 & hid=="4110941110015"
replace s1aq6a=s1aq4a  if ghj1==1 & s1aq1==16 & (hid=="1220112202012" | hid=="6320963209002" | hid=="6410464105016" | hid=="6411764109001" | hid=="4210242107014" | hid=="8322183225009" | hid=="8510185117002" | hid=="8511285124002" | hid=="3240432416013" | hid=="7310173107012" | hid=="8010580134011" | hid=="8013380113002" | hid=="8310283115011")
replace s1aq6a=s1aq4a  if ghj1==1 & s1aq1==17 & (hid=="1030110302013" | hid=="1120111210016" | hid=="8610586113011")
replace s1aq4a=s1aq6a  if ghj1==1 & s1aq1==16 & hid=="8020580247004"
replace s1aq5=s1aq5*7  if ghj1==1 & s1aq1==16 & hid=="6411764109001"
egen dfgh=rsum(s1aq6a s1aq7a s1aq8a)  if ghj1==1
order hid-s1aq3a dfgh  //br to make sure all good 
replace s1aq3a=dfgh  if ghj1==1 
drop dfgh 
replace s1aq3b=6  if ghj1==1 & s1aq3b~=6 
replace s1aq4b=6  if ghj1==1 & (s1aq4b~=6 & s1aq4b~=.) 
replace s1aq6b=6  if ghj1==1 & (s1aq6b~=6 & s1aq6b~=.)  
replace s1aq7b=6  if ghj1==1 & (s1aq7b~=6 & s1aq7b~=.)  
replace s1aq8b=6  if ghj1==1 & (s1aq8b~=6 & s1aq8b~=.) 
drop ghj ghj1 

gen ghj=1  if (s1aq1==16 | s1aq1==17) & s1aq7b<6 
replace s1aq5=s1aq6a   if ghj==1 & s1aq1==16 & (hid=="5520155217016" | hid=="6431564317016" | hid=="3721237203004") 
replace s1aq6a=s1aq4a  if ghj==1 & s1aq1==16 & hid=="5520155217016"
replace s1aq4a=s1aq3a  if ghj==1 & s1aq1==16 & hid=="6431564317016"
replace s1aq6a=s1aq3a  if ghj==1 & s1aq1==16 & hid=="6431564317016"
replace s1aq5=s1aq5*10  if ghj==1 & s1aq1==16 & hid=="7510175107168"
replace s1aq6a=s1aq4a   if ghj==1 & s1aq1==16 & hid=="7510175107168"
replace s1aq6a=s1aq3a   if ghj==1 & s1aq1==16 & hid=="3721237203004" 
replace s1aq4a=s1aq6a   if ghj==1 & s1aq1==16 & hid=="3721237203004" 
replace s1aq6b=s1aq4b   if ghj==1 & s1aq1==16 & hid=="7510175107168"
replace s1aq7b=s1aq3b   if ghj==1 & s1aq5==.
replace s1aq7a=.  if ghj==1 & s1aq7b==0
replace s1aq7b=.  if ghj==1 & s1aq7a==. 
replace s1aq8a=.  if ghj==1 & s1aq8b==0 
replace s1aq8b=.  if ghj==1 & s1aq8a==. 
recode s1aq7a-s1aq8b (else=.)  if ghj==1 & (hid=="2220122228003" | hid=="4311543108005" | hid=="8510185108006" | hid=="8521185208005" )
replace s1aq3b=6  if ghj==1 & s1aq3b~=6 
replace s1aq4b=6  if ghj==1 & (s1aq4b~=6 & s1aq4b~=.) 
replace s1aq6b=6  if ghj==1 & (s1aq6b~=6 & s1aq6b~=.)  
replace s1aq7b=6  if ghj==1 & (s1aq7b~=6 & s1aq7b~=.)  
replace s1aq8b=6  if ghj==1 & (s1aq8b~=6 & s1aq8b~=.) 
drop ghj

gen ghj=1  if (s1aq1==16 | s1aq1==17) & s1aq8b<6
replace s1aq8a=s1aq3a  if ghj==1 & s1aq5==.
replace s1aq8b=s1aq3b  if ghj==1 & s1aq5==.
recode s1aq7a-s1aq8b (else=.)  if ghj==1 & s1aq6a==s1aq3a 
drop ghj

gen ghj=1  if (s1aq1==16 | s1aq1==17) & (s1aq3b>6 & s1aq3b~=.)
replace s1aq3b=s1aq6b  if ghj==1 & s1aq6b==6 & s1aq3a==s1aq6a
replace s1aq4a=s1aq6a  if ghj==1 & s1aq1==16 & hid=="8110281127004"
replace s1aq4b=s1aq6b  if ghj==1 & s1aq6b==6 & s1aq3a==s1aq6a
drop ghj 
gen ghj=1  if (s1aq1==16 | s1aq1==17) & (s1aq3b>6 & s1aq3b~=.) 
gen ghj1=1  if ghj==1 & s1aq3b==14 
replace s1aq3a=s1aq6a  if ghj1==1
replace s1aq3b=s1aq4b  if ghj1==1
drop ghj1 
gen ghj1=1  if ghj==1 & s1aq3a==6 
replace s1aq3a=s1aq6a  if ghj1==1
replace s1aq3b=s1aq4b  if ghj1==1
recode s1aq7a s1aq7b (else=.)  if ghj1==1 
drop ghj1 
drop ghj

gen ghj=1  if (s1aq1==16 | s1aq1==17) & (s1aq3b>6 & s1aq3b~=.)
drop ghj 

gen ghj=1  if (s1aq1==16 | s1aq1==17) & (s1aq4b>6 & s1aq4b~=.)
replace s1aq5=s1aq4a   if ghj==1 & s1aq1==17 & hid=="3020230225003"
replace s1aq4a=s1aq6a  if ghj==1 & s1aq1==17 & hid=="3020230225003"
replace s1aq3a=s1aq6a   if ghj==1 & s1aq6a~=. & s1aq6a~=s1aq3a 
replace s1aq4b=s1aq3b   if ghj==1 & s1aq4b~=. 
replace s1aq6b=s1aq3b   if ghj==1 & s1aq6b~=. 
drop ghj
 
gen ghj=1  if (s1aq1==16 | s1aq1==17) & (s1aq6b>6 & s1aq6b~=.)
replace s1aq6a=s1aq3a  if ghj==1 & hid=="6411164123011"
replace s1aq4b=s1aq3b   if ghj==1 & s1aq4b~=. 
replace s1aq6b=s1aq3b   if ghj==1 & s1aq6b~=.
replace s1aq5=s1aq6a  if ghj==1 & hid=="6120561218015"
replace s1aq6a=s1aq3a  if s1aq3a~=s1aq6a & ghj==1
drop ghj

gen ghj=1  if (s1aq1==16 | s1aq1==17) & (s1aq7b>6 & s1aq7b~=.)
recode s1aq7a-s1aq8b (else=.)  if ghj==1 & s1aq5~=. 
drop ghj

gen ghj=1  if (s1aq1==16 | s1aq1==17) & (s1aq8b>6 & s1aq8b~=.)
drop ghj
replace checked=1       if checked==. &  (s1aq1==16 | s1aq1==17) 
drop dfge 

gen dfge=1  if s1aq4a>=100 & s1aq4b==14
drop dfge 

replace s1aq6a=s1aq3a  if s1aq1==178 & hid=="3030530383013"
replace s1aq6b=s1aq3b  if s1aq1==178 & hid=="3030530383013"

replace s1aq3a=s1aq4a   if s1aq1==221 & hid=="5013050113013"
replace s1aq7a=s1aq3a  if s1aq1==221 & hid=="5013050113013"
replace s1aq7b=s1aq3b  if s1aq1==221 & hid=="5013050113013"
recode s1aq3b s1aq7b (else=99)  if s1aq1==221 & hid=="5013050113013"
recode s1aq4a-s1aq6b (else=.)  if s1aq1==221 & hid=="5013050113013"
replace s1aq3a=s1aq6a  if s1aq1==221 & hid=="8311083138004"
replace s1aq4a=s1aq3a   if s1aq1==221 & hid=="6314263133007"
replace s1aq4b=s1aq3b   if s1aq1==221 & hid=="6314263133007"
replace s1aq6a=s1aq3a   if s1aq1==221 & hid=="6314263133007"
replace s1aq6b=s1aq3b   if s1aq1==221 & hid=="6314263133007"
recode s1aq7a-s1aq8b (else=.)  if s1aq1==221 & (hid=="3230432314007" | hid=="3230432314007")
replace s1aq4a=s1aq3a  if s1aq1==221 & hid=="6411764109012"
recode s1aq3b s1aq4b s1aq6b (else=12)  if s1aq1==221 & hid=="2020120213007" 
replace s1aq5=s1aq3a if s1aq1==221 & hid=="5530155356004"
replace s1aq6b=s1aq3b if s1aq1==221 & hid=="5530155356004"
recode s1aq3a s1aq4a s1aq6a (else=1)  if s1aq1==221 & hid=="5530155356004"
replace s1aq7a=s1aq3a  if s1aq1==221 & hid=="4021140205008"
replace s1aq7b=s1aq3b  if s1aq1==221 & hid=="4021140205008"
replace checked=1       if checked==. & s1aq1==221 

recode s1aq4b s1aq6b (else=12)  if s1aq1==272 & hid=="2340123436014"
recode s1aq4b s1aq6b (else=6)   if s1aq1==270 & hid=="4010240101015"
recode s1aq4b s1aq6b (else=6)   if s1aq1==271 & hid=="8320583240001"

replace s1aq6b=s1aq3b   if s1aq1==269 & hid=="5012750140003"
replace s1aq6b=s1aq3b   if s1aq1==273 & hid=="5530155307006"
replace s1aq6b=s1aq3b   if s1aq1==269 & hid=="5022350219002"

recode s1aq4a s1aq4b (else=.)  if s1aq1==271 & s1aq5==. & hid=="1230112304003"
replace s1aq8b=s1aq3b  if s1aq1==271 & s1aq5==. & hid=="1230112304003"

replace s1aq8a=s1aq3a   if s1aq1>=268 & (s1aq8b<3 | s1aq8b==9) & s1aq5==.
replace s1aq8b=s1aq3b   if s1aq1>=268 & (s1aq8b<3 | s1aq8b==9) & s1aq5==.

recode s1aq4a s1aq4b (else=.)   if s1aq1==270 & hid=="4021240209009"
recode s1aq8a s1aq8b  (else=.)  if s1aq1>=268 & (s1aq8b<3 | s1aq8b==9) & s1aq6a==s1aq3a & s1aq5~=.
recode s1aq3b s1aq8b (4=3)   if s1aq1==270 & hid=="4021240209009"
recode s1aq4a s1aq6a (else=14)  if s1aq1==269 & hid=="4110741108007"
recode s1aq4a-s1aq6b (else=.)  if s1aq1==286 & hid=="5220752220001"
recode s1aq3b s1aq4b s1aq6b (4=3)  if s1aq1>=268

gen jk=1   if s1aq1>=268 & s1aq5==. & s1aq4a~=.
replace s1aq8a=s1aq3a   if jk==1
replace s1aq8b=s1aq3b   if jk==1
recode s1aq4a-s1aq6b (else=.) if jk==1
drop jk 

gen jkl=1  if s1aq1>=268 & s1aq6a~=s1aq3a & s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==.
replace s1aq7a=s1aq3a   if jkl==1 & s1aq5==.
replace s1aq7b=s1aq3b   if jkl==1 & s1aq5==.
recode s1aq4a-s1aq6b (else=.)  if jkl==1 & s1aq5==.
replace s1aq6a=s1aq3a  if jkl==1 & s1aq6a==.
replace s1aq6b=s1aq3b  if jkl==1 & s1aq6a~=.
replace s1aq3a=s1aq6a   if jkl==1 & s1aq6a~=s1aq3a & s1aq5~=.
drop jk jkl 
replace checked=1       if checked==. &  s1aq1>=268

gen jk=1  if s1aq1==256 & s1aq6a==. & s1aq5~=.
replace s1aq4a=s1aq5/10  if jk==1 & s1aq4a==.
replace s1aq4b=s1aq3b    if jk==1 & s1aq4a~=.

gen fg=1  if s1aq1==256 & s1aq6a==. & s1aq5~=.
replace s1aq4b=s1aq3b  if fg==1
replace s1aq4b=5  if fg==1 & s1aq4b==99 
replace s1aq6a=s1aq3a  if fg==1.
replace s1aq6b=s1aq3b  if fg==1
recode s1aq8a s1aq8b (else=.)  if fg==1 
*jk==1 & hid=="8621986204014"
drop fg 

replace s1aq3b=s1aq6b if s1aq1==257 & s1aq3b==7
replace s1aq6a=s1aq3a  if s1aq1==257 & hid=="8622086232015"
replace s1aq6b=s1aq3b  if s1aq1==257 & hid=="8622086232015" 
replace checked=1       if checked==. &  s1aq1==256
replace checked=1       if checked==. &  s1aq1==257

gen fgh=1  if s1aq1==258 & s1aq4b==5 & s1aq6b==6
replace s1aq6a=s1aq3a   if fgh==1 & hid=="1010110106003"
replace s1aq5=.  		 if fgh==1 & hid=="1010110106003"
replace s1aq4a=1        if fgh==1 & hid=="6420464205016"
replace s1aq3b=6  		if fgh==1 & s1aq4a>1
replace s1aq4b=6  		if fgh==1 & s1aq4a>1
replace s1aq3a=s1aq6a   if fgh==1 & s1aq3a~=s1aq6a
replace s1aq3b=s1aq6b   if fgh==1 & s1aq3a==s1aq6a
replace s1aq4b=s1aq6b   if fgh==1 & s1aq4a==s1aq6a
drop fgh 
 
gen fgh=1 if s1aq1==258
gen fgh0=1  if fgh==1 & (s1aq6a==. & s1aq6b==. & s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==.) 
replace s1aq4a=.  if fgh0==1 & s1aq4a==0
replace s1aq4b=.   if fgh0==1 & s1aq4a==. 
replace s1aq5=s1aq4a  if fgh0==1 & s1aq5==. & (s1aq4a>=40 & s1aq4a~=.) 
replace s1aq4a=1    if fgh0==1 & (s1aq5>40 & s1aq5~=.) 
replace s1aq4b=5    if fgh0==1 & s1aq4b==. & (s1aq5>40 & s1aq5~=.) 
replace s1aq6a=s1aq3a  if fgh0==1 & s1aq5~=. 
replace s1aq6b=s1aq3b  if fgh0==1 & s1aq5~=.  
replace s1aq7a=s1aq3a  if fgh0==1 & s1aq5==. 
replace s1aq7b=s1aq3b  if fgh0==1 & s1aq5==.  
replace s1aq4a=1  if fgh0==1 & (s1aq4a==40)  
replace s1aq4b=5  if fgh0==1 & hid=="8511285124006"
recode s1aq4a-s1aq6b (else=.)  if fgh0==1 & s1aq5==.
drop fgh0   
replace checked=1  if checked==. & fgh==1
drop fgh

gen fgh0=1  if s1aq1==259 
recode s1aq4a s1aq6a (else=12)  if fgh0==1 & hid=="2210122167008"
recode s1aq8a s1aq8a (else=.)   if fgh0==1 & (hid=="2220122208008" | hid=="3090330950004") 
gen fgh00=1  if fgh0==1 & s1aq5==. & s1aq7a==.
replace s1aq5=s1aq4a   if fgh00==1 & s1aq4a>28 & s1aq8a==.
replace s1aq4b=5    if fgh00==1 & s1aq4a>28 & s1aq8a==. 
replace s1aq4a=1    if fgh00==1 & s1aq4a>28 & s1aq8a==.
replace s1aq6a=s1aq3a  if fgh00==1 & s1aq5~=.
replace s1aq6b=s1aq3b  if fgh00==1 & s1aq5~=.
recode s1aq4a-s1aq6b (else=.)  if fgh00==1 & s1aq5==.
replace s1aq7a=s1aq3a   if fgh00==1 & (s1aq5==. & s1aq7a==. & s1aq8a==.) 
replace s1aq7b=s1aq3b   if fgh00==1 & (s1aq5==. & s1aq7b==. & s1aq8b==.) 
replace s1aq8a=s1aq3a   if fgh00==1 & (s1aq5==. & s1aq8a~=.) 
replace s1aq8b=s1aq3b   if fgh00==1 & (s1aq5==. & s1aq8b~=.) 
drop fgh00  
replace s1aq3a=s1aq6a  if fgh0==1 & hid=="3810938107009"
replace s1aq4a=1       if fgh0==1 & hid=="3810938107009"
recode s1aq3b s1aq6b (5=6)  if fgh0==1 & hid=="3810938107009"
replace s1aq5=s1aq4a   if fgh0==1 & hid=="4021340217014"
replace s1aq4a=s1aq3a  if fgh0==1 & hid=="4021340217014"
replace s1aq4b=s1aq3b  if fgh0==1 & hid=="4021340217014"
recode s1aq3b s1aq4b s1aq6b (else=6)  if fgh0==1 & s1aq3a==s1aq4a & s1aq4a==s1aq6a & s1aq3a==s1aq5 & s1aq3b==5  //based on the price as in other cases.
recode s1aq3b s1aq6b (else=6)  if fgh0==1 & hid=="7510175105110"
replace s1aq4a=1   if fgh0==1 & hid=="7510175105110"
replace s1aq4b=s1aq3b  if fgh0==1 & s1aq1==259 & hid=="8610986122005"
recode s1aq3b s1aq4b s1aq6b (3=6)  if fgh0==1 & s1aq3a==s1aq4a & s1aq4a==s1aq6a & s1aq4b==5 & (s1aq3a>1 & s1aq3a~=.) & s1aq5<100
replace s1aq4a=1  if fgh0==1 & hid=="6411164123009"
replace s1aq4b=5  if fgh0==1 & hid=="6411164123009"
recode s1aq3b s1aq4b s1aq6b (else=6)  if fgh0==1 & hid=="7510175103053"
replace s1aq3a=s1aq6a  if fgh0==1 & s1aq1==259 & hid=="8520385216015"
replace s1aq3b=s1aq6b  if fgh0==1 & s1aq1==259 & hid=="8520385216015"
recode s1aq3b s1aq7b (7 8=6) if fgh0==1 & (s1aq3b==7 | s1aq3b==8)
recode s1aq3a s1aq4a s1aq6a (else=14)  if fgh0==1 & hid=="6020460220004"
recode s1aq3b s1aq4b s1aq6b (else=6)   if fgh0==1 & hid=="6020460220004"
replace s1aq4a=1   if fgh0==1 & s1aq4b==0 & hid=="5530155311007"
replace s1aq4b=5   if fgh0==1 & s1aq4b==0 & hid=="5530155311007"
replace s1aq4b=6   if fgh0==1 & s1aq4b==7
replace s1aq5=s1aq6a   if fgh0==1 & hid=="5540855416010"
replace s1aq6b=s1aq3b  if fgh0==1 & hid=="5540855416010"
gen fgh00=1  if fgh0==1 & s1aq6b==0
replace s1aq6a=s1aq3a  if fgh00==1 & s1aq6b==0
replace s1aq6b=s1aq3b  if fgh00==1 & s1aq6b==0
drop fgh00 
gen fgh00=1  if fgh0==1 & (s1aq6b==10 | s1aq6b==14) 
replace s1aq6a=s1aq3a  if fgh00==1  
replace s1aq6b=s1aq3b  if fgh00==1  
drop fgh00 
replace s1aq6b=6   if fgh0==1 & (s1aq6b==7 | s1aq6b==8 | s1aq6b==9 | s1aq6b==10 | s1aq6b==14) 
recode s1aq3b s1aq8b (else=6)   if fgh0==1 & hid=="3321433202011"
replace s1aq8b=.  if fgh0==1 & s1aq8a==.
recode s1aq8a s1aq8b (else=.)  if fgh0==1 & (hid=="2120221269011" | hid=="5420754215011")  
recode s1aq7a s1aq7b (else=.)  if fgh0==1 & (hid=="3321433202011" | hid=="3610636103011")
replace checked=1  if checked==. & (s1aq1==258 | s1aq1==259)
drop fgh0 

gen fgh=1 if s1aq1==259
gen fgh0=1  if fgh==1 & (s1aq6a==. & s1aq6b==. & s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==.) 
replace s1aq4a=.  if fgh0==1 & s1aq4a==0
replace s1aq4b=.   if fgh0==1 & s1aq4a==. 
replace s1aq5=s1aq4a  if fgh0==1 & s1aq5==. & (s1aq4a>=40 & s1aq4a~=.) 
replace s1aq4a=1    if fgh0==1 & (s1aq5>40 & s1aq5~=.) 
replace s1aq4b=5    if fgh0==1 & s1aq4b==. & (s1aq5>40 & s1aq5~=.) 
replace s1aq6a=s1aq3a  if fgh0==1 & s1aq5~=. 
replace s1aq6b=s1aq3b  if fgh0==1 & s1aq5~=.  
replace s1aq7a=s1aq3a  if fgh0==1 & s1aq5==. 
replace s1aq7b=s1aq3b  if fgh0==1 & s1aq5==.  
recode s1aq4a-s1aq6b (else=.)  if fgh0==1 & s1aq5==.
replace s1aq4a=1  if fgh0==1 & s1aq5~=. & s1aq4a==.
replace s1aq4b=5  if fgh0==1 & s1aq5~=. & s1aq4b==.
drop fgh0   
replace checked=1  if checked==. & fgh==1
drop fgh

gen fgh0=1  if s1aq1==260 
recode s1aq4a-s1aq6b (else=.)  if fgh0==1 & s1aq5==.
recode s1aq3b s1aq4b s1aq6b (else=6)   if fgh0==1 & (hid=="7411974123004" | hid=="3221532255004" | hid=="3221532255004")
replace s1aq8b=s1aq3b  if fgh0==1 & hid=="3521135203010"
recode s1aq3b s1aq7b (else=11)  if fgh0==1 & hid=="6111161109015"
replace checked=1  if checked==. & (s1aq1==258 | s1aq1==259 | s1aq1==260)
drop fgh0
replace s1aq7a=s1aq3a  if s1aq1==258 & hid=="6312063123002" 
replace s1aq7b=s1aq3b  if s1aq1==258 & hid=="6312063123002"
recode s1aq4a-s1aq6b (else=.)  if s1aq1==258 & hid=="6312063123002" 

gen fgh=1 if s1aq1==260
gen fgh0=1  if fgh==1 & (s1aq6a==. & s1aq6b==. & s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==.) 
replace s1aq7a=s1aq3a  if fgh0==1 & s1aq5==. 
replace s1aq7b=s1aq3b  if fgh0==1 & s1aq5==.  
recode s1aq4a-s1aq6b (else=.)  if fgh0==1 & s1aq5==.
drop fgh0   
replace checked=1  if checked==. & s1aq1==260
drop fgh

gen fgh0=1  if ((s1aq1>=258 & s1aq1<=260) & s1aq3a==98)  //sugegstions from Team
replace s1aq3a=s1aq3b  if fgh0==1 
replace s1aq3b=11      if fgh0==1 
replace s1aq6a=s1aq6b  if fgh0==1 & s1aq6a~=. 
replace s1aq6b=11      if fgh0==1 & s1aq6b~=. 
replace s1aq7a=s1aq7b  if fgh0==1 & s1aq7a~=. 
replace s1aq7b=11      if fgh0==1 & s1aq7b~=. 
replace s1aq8a=s1aq8b  if fgh0==1 & s1aq8a~=. 
replace s1aq8b=11      if fgh0==1 & s1aq8b~=. 
replace s1aq7a=s1aq6a  if fgh0==1 & s1aq7a==. 
replace s1aq7b=s1aq6b  if fgh0==1 & s1aq7b==.  
recode s1aq6a s1aq6b (else=.)   if fgh0==1 & s1aq5==.
drop fgh0 

gen fgh0=1  if ((s1aq1>=258 & s1aq1<=260) & s1aq4a==98)
ta fgh0 
drop fgh0 
gen fgh0=1  if ((s1aq1>=258 & s1aq1<=260) & s1aq6a==98)
ta fgh0 
drop fgh0 
gen fgh0=1  if ((s1aq1>=258 & s1aq1<=260) & s1aq7a==98)
ta fgh0 
drop fgh0 

gen fgh=1  if s1aq1>=258 & s1aq1<=260 
recode s1aq8a s1aq8b (else=.)  if fgh==1 & s1aq1==258 & (hid=="3410234119005" |  hid=="8321783208011")
recode s1aq3b s1aq4b s1aq6b (else=11)   if fgh==1 & s1aq1==258 & (hid=="3410234119005"  |  hid=="8321783208011") 
replace s1aq3b=s1aq6b  if fgh==1 & s1aq1==258 & hid=="5530155347011"
recode s1aq3a s1aq6a (else=2)   if fgh==1 & s1aq1==258 & hid=="5530155347011"
replace s1aq4a=1   if fgh==1 & (hid=="1220112215001" | hid=="2410124101011")
replace s1aq4b=5   if fgh==1 & (hid=="1220112215001" | hid=="2410124101011")
replace s1aq3a=s1aq6a   if fgh==1 & (hid=="1220112215001" | hid=="2410124101011")
replace s1aq3b=s1aq6b   if fgh==1 & (hid=="1220112215001" | hid=="2410124101011")
replace s1aq3a=s1aq6a  if fgh==1 & hid=="6020160224007"
replace s1aq3b=s1aq6b  if fgh==1 & hid=="6020160224007"
recode s1aq3b s1aq4b s1aq6b (else=5)  if fgh==1 & hid=="3520735220007"
recode s1aq3b s1aq4b s1aq6b (else=6)   if fgh==1 & s1aq3b<5 

gen fgh1=1  if fgh==1 & (s1aq3b==7 | s1aq3b==10 | s1aq3b==14)
ta fgh1 
replace s1aq3a=s1aq6a  if fgh1==1 & s1aq6a~=.
recode s1aq3b s1aq4b s1aq6b (else=6)   if fgh1==1
drop fgh1 
gen fgh1=1  if fgh==1 & (s1aq4b<5 | s1aq4b==7 | s1aq4b==12)
recode s1aq4a-s1aq6b (else=.)   if fgh1==1 & s1aq5==. 
replace s1aq3b=6  if fgh1==1 & hid=="8013680119001"
replace s1aq3b=5  if fgh1==1 & hid=="8411184117006"
replace s1aq4a=s1aq3a  if fgh1==1 & s1aq4a~=. 
replace s1aq6a=s1aq3a  if fgh1==1 & s1aq6a~=. 
replace s1aq4b=s1aq3b  if fgh1==1 & s1aq4b~=. 
replace s1aq6b=s1aq3b  if fgh1==1 & s1aq6b~=. 
drop fgh1 
gen fgh1=1  if fgh==1 & (s1aq6b<5 | s1aq6b==7 | s1aq6b==10 | s1aq6b==14)
replace s1aq4b=5   if fgh1==1 & (s1aq5>=140 & s1aq5~=.)
replace s1aq4a=5   if fgh1==1 & (s1aq5>=140 & s1aq5~=.)
replace s1aq3b=6   if fgh1==1 & s1aq3b==5
replace s1aq6a=s1aq3a  if fgh1==1
replace s1aq6b=s1aq3b  if fgh1==1
recode s1aq8a s1aq8b (else=.)   if fgh1==1
replace s1aq4b=s1aq3b   if fgh1==1 & s1aq5<140 & s1aq4a==s1aq3a 
replace s1aq4a=14  if fgh1==1 & s1aq1==258 & hid=="7410374118008"
replace s1aq4b=6  if fgh1==1 & s1aq1==258 & hid=="7410374118008"
drop fgh1 
gen fgh1=1  if fgh==1 & (s1aq8b<5 | s1aq8b==9)
recode s1aq8a s1aq8b (else=.)   if fgh1==1 & s1aq5~=. 
recode s1aq4a-s1aq6b (else=.)   if fgh1==1 & s1aq5==.
replace checked=1  if checked==. & (s1aq1>=258 & s1aq1<=260) 
drop fgh fgh1 

gen fgh=1  if s1aq1>=261 & s1aq1<=267 
recode s1aq4a-s1aq6b (else=.)  if s1aq5==. & fgh==1 
recode s1aq7a-s1aq8b (else=.)  if fgh==1 & (s1aq3a==s1aq6a) & (s1aq3a==s1aq7a)
gen fgh1=1  if fgh==1 & s1aq3b<3 
replace s1aq3a=s1aq6a  if fgh1==1 & hid=="3040130443002"
replace s1aq3a=s1aq7a  if fgh1==1 & hid=="3711637103013" 
replace s1aq3b=11      if fgh1==1 & s1aq3b~=. 
replace s1aq4b=11      if fgh1==1 & s1aq4b~=. 
replace s1aq6b=11      if fgh1==1 & s1aq6b~=. 
replace s1aq7b=11      if fgh1==1 & s1aq7b~=. 
replace s1aq8b=11      if fgh1==1 & s1aq8b~=. 
recode s1aq8a-s1aq8b (else=.)  if fgh==1 & hid=="8420884221014" 
drop fgh1 

gen fgh1=1  if fgh==1 & (s1aq1>=261 & s1aq1<=267 ) & s1aq3a==98
replace s1aq3a=s1aq3b  if fgh1==1 & s1aq3b~=11
replace s1aq3b=11      if fgh1==1 
replace s1aq6a=s1aq6b  if fgh1==1 & s1aq6a~=. & s1aq6b~=11
replace s1aq6b=11      if fgh1==1 & s1aq6b~=. 
replace s1aq7a=s1aq7b  if fgh1==1 & s1aq7a~=. & s1aq7b~=11
replace s1aq7b=11      if fgh1==1 & s1aq7b~=. 
replace s1aq8a=s1aq8b  if fgh1==1 & s1aq8a~=. 
replace s1aq8b=11      if fgh1==1 & s1aq8b~=. & s1aq8b~=11
replace s1aq3a=3  if fgh1==1 & s1aq3a==98 
replace s1aq7a=3  if fgh1==1 & s1aq7a==98 
replace s1aq8a=3  if fgh1==1 & s1aq8a==98 
replace s1aq8a=s1aq3a  if fgh1==1 & s1aq8a~=. 
drop fgh1 
gen fgh1=1  if fgh==1 & (s1aq1>=261 & s1aq1<=267 ) & s1aq3a==93
replace s1aq3a=s1aq3b  if fgh1==1 & s1aq3b~=11
replace s1aq3b=11      if fgh1==1 
replace s1aq6a=s1aq6b  if fgh1==1 & s1aq6a~=. & s1aq6b~=11
replace s1aq6b=11      if fgh1==1 & s1aq6b~=. 
replace s1aq7a=s1aq7b  if fgh1==1 & s1aq7a~=. & s1aq7b~=11
replace s1aq7b=11      if fgh1==1 & s1aq7b~=. 
replace s1aq8a=s1aq8b  if fgh1==1 & s1aq8a~=. 
replace s1aq8b=11      if fgh1==1 & s1aq8b~=. & s1aq8b~=11
drop fgh1 
gen fgh1=1  if fgh==1 & (s1aq1>=261 & s1aq1<=267 ) & s1aq3b<5
replace s1aq3b=11      if fgh1==1 & s1aq3b~=.
replace s1aq4b=11      if fgh1==1 & s1aq4b~=.
replace s1aq6b=11      if fgh1==1 & s1aq6b~=.
replace s1aq7b=11      if fgh1==1 & s1aq7b~=.
replace s1aq8b=11      if fgh1==1 & s1aq8b~=.
drop fgh1 

gen fgh1=1  if fgh==1 & (s1aq1>=261 & s1aq1<=267 ) & (s1aq3b>=7 & s1aq3b<11)
replace s1aq3b=11      if fgh1==1 & s1aq3b~=.
replace s1aq4b=11      if fgh1==1 & s1aq4b~=.
replace s1aq6b=11      if fgh1==1 & s1aq6b~=.
replace s1aq7b=11      if fgh1==1 & s1aq7b~=.
replace s1aq8b=11      if fgh1==1 & s1aq8b~=.
drop fgh1 
gen fgh1=1  if fgh==1 & (s1aq1>=261 & s1aq1<=265 ) & (s1aq3b>=12 & s1aq3b<99)
replace s1aq3b=11      if fgh1==1 & s1aq3b~=.
replace s1aq4b=11      if fgh1==1 & s1aq4b~=.
replace s1aq6b=11      if fgh1==1 & s1aq6b~=.
replace s1aq7b=11      if fgh1==1 & s1aq7b~=.
replace s1aq8b=11      if fgh1==1 & s1aq8b~=.
 
replace s1aq3b=12      if s1aq1==266 & s1aq3b==13 
replace s1aq4b=12      if s1aq1==266 & s1aq4b==13 
replace s1aq6b=12      if s1aq1==266 & s1aq6b==13 
replace s1aq7b=12      if s1aq1==266 & s1aq7b==13 

replace s1aq4b=11      if  (s1aq1>=261 & s1aq1<=267 ) & s1aq4b==1
replace s1aq4b=99      if  (s1aq1>=261 & s1aq1<=267 ) & s1aq4b==14
replace s1aq5=20   if s1aq1==264 & hid=="5012750140005"  //was 202

gen kl=1  if (s1aq1>=261 & s1aq1<=267 ) & s1aq6b<5
ta kl 
replace s1aq6a=s1aq3a  if kl==1 
replace s1aq6b=s1aq3b  if kl==1
recode s1aq7a-s1aq8b (else=.)  if kl==1
drop kl
gen kl=1  if (s1aq1>=261 & s1aq1<=267 ) & s1aq7b<5
ta kl 
replace s1aq7a=s1aq3a  if kl==1 
replace s1aq7b=s1aq3b  if kl==1
drop kl
gen kl=1  if (s1aq1>=261 & s1aq1<=267 ) & s1aq7b==7 
ta kl 
recode s1aq7a-s1aq7b (else=.)  if kl==1
replace s1aq8a=s1aq3a  if kl==1 
replace s1aq8b=s1aq3b  if kl==1
drop kl
gen kl=1  if (s1aq1>=261 & s1aq1<=267 ) & s1aq7b==12
ta kl 
drop kl
gen kl=1  if (s1aq1>=261 & s1aq1<=267 ) & s1aq8b<5
replace s1aq8a=s1aq3a  if kl==1 
replace s1aq8b=s1aq3b  if kl==1
recode s1aq8a-s1aq8b (else=.)  if kl==1 & hid=="4410444101010"
recode s1aq8a-s1aq8b (else=.)  if kl==1 & hid=="6020460220006"
drop kl
gen kl=1  if (s1aq1>=261 & s1aq1<=267 ) & s1aq8b==9
replace s1aq3a=s1aq6a  if kl==1
recode s1aq8a-s1aq8b (else=.)  if kl==1
drop kl
replace checked=1       if checked==. &  (s1aq1>=260 & s1aq1<=267)

gen pl=1  if s1aq1<=5 & s1aq3b==6
replace s1aq3b=10   if pl==1 
replace s1aq6b=s1aq3b  if pl==1 & s1aq3a==s1aq6a 
replace s1aq7b=s1aq3b  if pl==1 & s1aq3a==s1aq7a 
replace s1aq4b=s1aq3b  if pl==1 & s1aq3a==s1aq4a 
replace s1aq4a=1   if pl==1 & s1aq1==3 & (hid=="3211032132010" | hid=="3311633110007")
replace s1aq4b=14  if pl==1 & s1aq1==3 & (hid=="3211032132010" | hid=="3311633110007") 
drop pl 

ta s1aq3b  if s1aq1<=5
replace s1aq4a=1   if s1aq1==4 & (hid=="4021840212009" | hid=="4110741108001")
replace s1aq4b=14  if s1aq1==4 & (hid=="4021840212009" | hid=="4110741108001")
recode s1aq3b s1aq6b (else=10)  if s1aq1==4 & (hid=="4021840212009" | hid=="4110741108001")

ta s1aq4b  if s1aq1<=5
gen kl=1   if  s1aq1<=5 & (s1aq4b==0 | s1aq4b==3 | s1aq4b==4 | s1aq4b==6)
replace s1aq5=.  if kl==1 & (s1aq5<100 | s1aq5==520)
recode s1aq4a-s1aq6b (else=.)  if kl==1 & s1aq5==.
replace s1aq4b=14  if kl==1 & s1aq1==3 & hid=="3240432429010"
replace s1aq4b=s1aq3b   if kl==1 & s1aq4b~=. & s1aq4a==s1aq3a 
replace s1aq4a=s1aq3a   if kl==1 & hid=="3110331130005"
replace s1aq4b=s1aq3b   if kl==1 & hid=="3110331130005"
replace s1aq6b=s1aq3b   if kl==1 & s1aq6b~=. & s1aq6a==s1aq3a 
replace s1aq3a=s1aq6a   if kl==1 & s1aq1==1 & hid=="8620386216009"
recode s1aq4b s1aq3b (0=9)  if kl==1 & s1aq1==1 & hid=="8620386216009"
replace s1aq4a=1   if kl==1 & s1aq1==3 & hid=="8010880106001"
replace s1aq4b=14  if kl==1 & s1aq1==3 & hid=="8010880106001"
replace s1aq7a=s1aq3a  if kl==1 & (s1aq6a==. & s1aq6b==. & s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==.) 
replace s1aq7b=s1aq3b  if kl==1 & (s1aq6a==. & s1aq6b==. & s1aq7a~=. & s1aq7b==. & s1aq8a==. & s1aq8b==.) 
recode s1aq8a-s1aq8b (else=.)  if kl==1 & hid=="3020230247015"
drop kl 

gen kl=1   if  s1aq1<=5 & (s1aq4b==11 | s1aq4b==12 | s1aq4b==15 )
replace s1aq4b=14  if s1aq4b==15
replace s1aq4b=1  if kl==1 & s1aq4b==12 & (s1aq5>1000 & s1aq5~=.)
replace s1aq5=.  if kl==1 & hid=="7220472233015"
replace s1aq7a=s1aq3a  if kl==1 & s1aq5==. & s1aq8a==.
replace s1aq7b=s1aq3b  if kl==1 & s1aq5==. & s1aq8b==. 
recode s1aq4a-s1aq6b (else=.)  if kl==1 & s1aq5==.
replace s1aq3b=10  if kl==1 & s1aq3b==11
replace s1aq4b=s1aq3b  if kl==1 & s1aq4b==11
replace s1aq8b=s1aq3b  if kl==1 & s1aq8b==11
drop kl 

gen kl=1   if  s1aq1<=5 & (s1aq4b==14 ) 
replace s1aq5=1200  if kl==1 & s1aq1==4 & hid=="3210432144003"
replace s1aq5=s1aq5/10  if kl==1 & s1aq1==3 & hid=="3222432230001"
replace s1aq4a=s1aq3a  if kl==1 & (hid=="8510285103008" | hid=="4311543129014")
replace s1aq4b=s1aq3b  if kl==1 & (hid=="8510285103008" | hid=="4311543129014")
gen kl1=1   if  kl==1 & s1aq5<100
ta kl1
drop kl kl1 

gen kl=1   if  s1aq1<=5 & (s1aq4b==6 ) 
ta kl
drop kl

replace s1aq3a=s1aq4a  if s1aq1==4 & (hid=="5110351125014" | hid=="1010110101007")
replace s1aq5=.        if s1aq1==4 & (hid=="5110351125014" | hid=="1010110101007")  //wrong price

gen kl=1  if s1aq1<=5 & (s1aq5>1000 & s1aq5~=.) & (s1aq4b>1 & s1aq4b<14)  //easier to convert this into the 50kg bag
*ta s1aq5  if kl==1  
replace s1aq4a=1  if kl==1 & s1aq5<1600
replace s1aq4a=2  if kl==1 & (s1aq5>=1600 & s1aq5<=2500)
replace s1aq4b=14  if kl==1
recode s1aq8a-s1aq8b (else=.)  if kl==1
replace s1aq6a=s1aq3a  if kl==1 & s1aq6a~=.
replace s1aq6b=s1aq3b  if kl==1 & s1aq6b~=.
drop kl

gen kl=1  if s1aq1<=5 & (s1aq5>1000 & s1aq5~=.) & s1aq4b==1 & s1aq4a~=50
replace s1aq4a=1  if kl==1 & s1aq5<1600
replace s1aq4a=2  if kl==1 & (s1aq5>=1600 & s1aq5<=2500)
replace s1aq4a=3  if kl==1 & (s1aq5>2500 & s1aq5<=3800)
replace s1aq4a=4  if kl==1 & (s1aq5>3800 & s1aq5<=5000)
recode s1aq8a-s1aq8b (else=.)  if kl==1  //when exact the same as total consumed
replace s1aq6a=s1aq3a  if kl==1 & (s1aq6a==. & s1aq6b==. & s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==.)
replace s1aq6b=s1aq3b  if kl==1 & (s1aq6a~=. & s1aq6b==. & s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==.)
gen kl1=1 if kl==1 & s1aq3a>20 & s1aq3b==1 & hhsize<40 
recode s1aq3b s1aq6b (else=10)  if kl1==1 & (hid=="4120541202005" | hid=="4111241102012" | hid=="5310353120013" )   //the remaining obs like outlier and want to change to cup
drop kl1 kl

gen kl=1  if s1aq1<=5 & (s1aq6b==0 | s1aq6b==2 | s1aq6b==3 | s1aq6b==4)
replace s1aq5=.  if kl==1 & s1aq3a==s1aq5
recode s1aq4a-s1aq6b (else=.)  if kl==1 & s1aq5==. 
replace s1aq6b=s1aq3b  if kl==1 & s1aq6b~=.
replace s1aq8b=s1aq3b  if kl==1 & s1aq8b~=.
replace s1aq6a=s1aq3a  if kl==1 & s1aq6a~=.
replace s1aq7a=s1aq3a  if kl==1 & s1aq5==.
replace s1aq7b=s1aq3b  if kl==1 & s1aq5==.
drop kl

gen kl=1  if s1aq1<=5 & s1aq3a~=s1aq6a &  (s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==.)
recode s1aq4a-s1aq6b (else=.)  if kl==1 & s1aq5==. 
replace s1aq3a=56 if kl==1 & s1aq3a==5656
replace s1aq6a=s1aq3a  if kl==1 & s1aq5~=.
replace s1aq6b=s1aq3b  if kl==1 & s1aq5~=. 
replace s1aq7a=s1aq3a  if kl==1 & s1aq5==. & s1aq8a==. 
replace s1aq7b=s1aq3b  if kl==1 & s1aq5==. & s1aq8b==.


gen kl1=1  if kl==1 & s1aq3a>500
ta kl1 
drop kl1 
gen kl1=1  if kl==1 & s1aq3a>100  //all good
drop kl1 

replace s1aq4a=s1aq3a  if s1aq1==3 & hid=="3210532170008"
replace s1aq4b=s1aq3b  if s1aq1==194 & hid=="3710537105012" 
replace s1aq3a=s1aq6a  if s1aq1==178 & hid=="4011140114007"
recode s1aq3b s1aq6b (else=10)  if s1aq1==178 & hid=="4011140114007"
recode s1aq3b s1aq7b (else=10)  if s1aq1==178 & (hid=="4011240118003" | hid=="4020740207002")
replace s1aq3a=s1aq6a  if s1aq1==178 & (hid=="4120541202011" | hid=="4220642204012" | hid=="4021340217007")
recode s1aq3b s1aq6b (else=10)  if s1aq1==178 & (hid=="4120541202011" | hid=="4220642204012" | hid=="4021340217007")
replace s1aq6a=s1aq3a            if s1aq1==178 & (hid=="4311543108005")
recode s1aq3b s1aq6b (else=10)   if s1aq1==178 & (hid=="4311543108005")
replace s1aq4a=s1aq5/35  		if s1aq1==178 & (hid=="4311543108005")
replace s1aq4b=1   	  			if s1aq1==178 & (hid=="4311543108005")
replace s1aq3a=s1aq6a  if (s1aq1==226 & hid=="4111041112010") | (s1aq1==168 & hid=="4111241102006") | (s1aq1==226 & hid=="4120341210005")
replace s1aq3b=s1aq6b  if (s1aq1==226 & hid=="4111041112010") | (s1aq1==168 & hid=="4111241102006") | (s1aq1==226 & hid=="4120341210005")
replace s1aq4a=s1aq6a  if s1aq1==194 & (hid=="6410364103012" | hid=="6420364203007")
recode s1aq3b s1aq4b (else=6)   if s1aq1==194 & (hid=="6410364103012" | hid=="6420364203007")
recode s1aq8a s1aq8b (else=.)   if s1aq1==3 & hid=="3241332469009"  //duplicate of s1aq7a 
recode s1aq3b s1aq7b (else=10)  if s1aq1==178 & hid=="8610686120013"

gen fh=1  if (s1aq1>24 & s1aq1<=167) & s1aq4b==14
replace s1aq4b=s1aq6b if fh==1 & s1aq6a==s1aq4a 
recode s1aq4a-s1aq6b (else=.)  if fh==1 & s1aq5==. 
drop fh 
gen fh=1  if (s1aq1>24 & s1aq1<=167) & s1aq4b==14
replace s1aq4a=1  if fh==1 & s1aq1==25 
replace s1aq4b=5  if fh==1 & s1aq1==25  

gen fh1=1  if s1aq1==105
gen fh2=1  if fh1==1 & s1aq1==105 & s1aq4b==1
gen fh3=1  if fh2==1 & s1aq3a==s1aq4a
replace s1aq4b=s1aq3b  if fh3==1
replace s1aq6a=s1aq3a  if fh3==1
replace s1aq6b=s1aq3b  if fh3==1
drop fh3 
replace s1aq4a=5   if s1aq1==105 & hid=="5530155311012" 
replace s1aq4b=s1aq4a  if s1aq1==105 & hid=="3222632243003"
replace s1aq4a=1       if s1aq1==105 & hid=="3222632243003"
drop fh2 
gen fh2=1  if fh1==1 & s1aq1==105 & s1aq4b==1
recode s1aq3b s1aq4b s1aq6b (1=10)  if fh2==1 & s1aq5<40 
drop fh2 fh 

ta s1aq3b  if s1aq1==105
gen fh=1  if fh1==1 & (s1aq3b==2 | s1aq3b==4 | s1aq3b==5) 
recode s1aq3a s1aq4a s1aq6a (else=4)   if fh1==1 & (hid=="5530155356012" | hid=="3144131452010")
recode s1aq3b s1aq4b s1aq6b (else=10)  if fh1==1 & (hid=="5530155356012" | hid=="3144131452010"  | hid=="5420554201011" | hid=="6120561218014")
recode s1aq3a s1aq6a (else=4)   if fh1==1 & hid=="5120651225001"
recode s1aq3b s1aq6b (else=10)  if fh1==1 & (hid=="5120651225001" | hid=="5110251114002")
replace s1aq4a=20   if fh1==1 & (hid=="5120651225001" | hid=="1010110106002")
replace s1aq4b=1    if fh1==1 & (hid=="5120651225001" | hid=="1010110106002")
replace s1aq5=s1aq4a  if fh1==1 & hid=="5622156219002" 
recode s1aq3a s1aq4a s1aq6a (else=4)   if fh1==1 & hid=="5622156219002" 
recode s1aq3b s1aq4b s1aq6b (else=8)   if fh1==1 & hid=="5622156219002" 
recode s1aq8a s1aq8b (else=.)   if fh1==1 & hid=="5622156219002" 
replace s1aq4b=1  if fh==1 & hid=="5110251114002"
recode s1aq3b s1aq7b (else=10)  if fh==1 & hid=="6112661124015" 
replace s1aq3a=s1aq6a  if fh==1 & s1aq6a~=.
replace s1aq3b=s1aq6b  if fh==1 & s1aq6b~=.
replace s1aq4a=s1aq6a  if fh==1 & (hid=="3133931341011" | hid=="3240232403006" | hid=="4220642203004")
replace s1aq4b=s1aq6b  if fh==1 & (hid=="3133931341011" | hid=="3240232403006" | hid=="4220642203004")
drop fh fh1 
gen fh=1  if s1aq1==105 
gen fh1=1  if fh==1 & (s1aq3b==5 | s1aq3b==9 | s1aq3b==14 | s1aq3b==15) 
replace s1aq5=s1aq3a  if fh1==1 & hid=="8620986231003"
recode s1aq4a s1aq4b (else=1) if  fh1==1 & hid=="8620986231003"
replace s1aq3a=s1aq3b  if fh1==1 & s1aq3b==15
replace s1aq3b=10  if fh1==1 & s1aq3b==15
recode s1aq4a-s1aq6b (else=.)  if fh1==1 & s1aq5==.
replace s1aq6a=s1aq3a  if fh1==1 & s1aq5~=.
replace s1aq6b=s1aq3b  if fh1==1 & s1aq5~=.
replace s1aq3a=s1aq3b  if fh1==1 & s1aq3b==14 
replace s1aq3b=10      if fh1==1 & s1aq3b==14
replace s1aq6a=s1aq3b  if fh1==1 & s1aq6b==14 
replace s1aq6b=10      if fh1==1 & s1aq6b==14 
replace s1aq8a=s1aq3a  if fh1==1 & s1aq8a~=. 
replace s1aq8b=s1aq3b  if fh1==1 & s1aq8b~=.  
drop fh1 
gen fh1=1  if fh==1 & s1aq3b==6 
replace s1aq4a=20   if fh1==1 & (s1aq5>1000 & s1aq5~=.)  //based on other obs
replace s1aq4b=1    if fh1==1 & (s1aq5>1000 & s1aq5~=.)
replace s1aq3b=10  if fh1==1 & hid=="5221052226011" 
replace s1aq5=s1aq4a  if fh1==1 & hid=="7221972208012"
recode s1aq3a s1aq4a s1aq6a (else=6)  if fh1==1 & hid=="7221972208012"
recode s1aq3b s1aq4b s1aq6b (else=10) if fh1==1 & (hid=="7221972208012" | hid=="7222172212013" | hid=="3210432144003" | hid=="5221652215005")
recode s1aq8a s1aq8b (else=.) if fh1==1 & hid=="7221972208012"
replace s1aq3a=s1aq8a  if fh1==1 & hid=="5221052226011"
replace s1aq3b=s1aq3b  if fh1==1 & hid=="5221652215005" 
replace s1aq3a=s1aq6a  if fh1==1 & hid=="3210432144003"
replace s1aq4b=s1aq6b  if fh1==1 & hid=="3130231348007" 
replace s1aq6a=s1aq3a  if fh1==1 & s1aq6a==. & s1aq5~=.
replace s1aq6b=s1aq3b  if fh1==1 & s1aq6b==. & s1aq5~=.
replace s1aq7a=s1aq3a  if fh1==1 & s1aq7a==. & s1aq5==. & s1aq8a==.
replace s1aq7b=s1aq3b  if fh1==1 & s1aq7b==. & s1aq5==. & s1aq8b==. 
replace s1aq4a=s1aq3a  if fh1==1 & s1aq5~=. & s1aq4a==. 
replace s1aq4b=s1aq3b  if fh1==1 & s1aq5~=. & s1aq4b==. 
drop fh1 
gen fh1=1  if fh==1 & s1aq3b==5 
drop fh1 
replace checked=1  if checked==. & s1aq1==105
recode s1aq3b s1aq4b s1aq6b (else=6)  if (s1aq1>24 & s1aq1<=167) & s1aq4b==14
replace s1aq3a=s1aq6a  if s1aq1==104 & hid=="6430164315014"
recode s1aq3b s1aq6b (else=10)  if s1aq1==104 & hid=="6430164315014"
replace s1aq4b=3      if s1aq1==104 & hid=="6430164315014"
recode s1aq3a s1aq4a s1aq6a (else=14)  if s1aq1==122 & hid=="3621636209002"
recode s1aq3b s1aq4b s1aq6b (else=8)  if s1aq1==122 & hid=="3621636209002"
replace s1aq5=.  if s1aq1==114 & hid=="3130231348005" 
replace s1aq4a=1  if s1aq1==114 & hid=="5122251233008"
replace s1aq3a=s1aq3b  if s1aq1==114 & (hid=="3810438110006" | hid=="3810438110010" | hid=="5122251233008") 
replace s1aq3b=8       if s1aq1==114 & (hid=="3810438110006" | hid=="3810438110010" | hid=="5122251233008") 
replace s1aq6a=s1aq3a  if s1aq1==114 & (hid=="3810438110006" | hid=="3810438110010" | hid=="5122251233008") 
replace s1aq6b=s1aq3b  if s1aq1==114 & (hid=="3810438110006" | hid=="3810438110010" | hid=="5122251233008") 

*br if s1aq1<=5 & valid==1 & s1aq3b==14 //12 obs and 3 of them look like outliers as HHSIZE<10. Others are large HHolds 
count if s1aq1<=5 & valid==1 & s1aq3b==14   //will leave as is for now
replace s1aq6a=s1aq3a  if hid=="1120111204008" & s1aq1==104
replace s1aq6b=s1aq3b  if hid=="1120111204008" & s1aq1==104
replace s1aq6a=s1aq3a  if hid=="1120111204008" & s1aq1==106 
replace s1aq6b=s1aq3b  if hid=="1120111204008" & s1aq1==106 
replace s1aq6a=s1aq3a  if hid=="1120111204008" & s1aq1==187 
recode s1aq3b s1aq4b s1aq6b (else=1)   if hid=="1020110201013" & s1aq1==208
replace s1aq6a=s1aq3a   if hid=="2340123436012" & s1aq1==232
replace s1aq5=s1aq5*6   if hid=="2340123436012" & s1aq1==232
recode s1aq3a s1aq4a s1aq6a (else=1)   if hid=="3030530383001" & s1aq1==232
recode s1aq3b s1aq4b s1aq6b (else=6)   if hid=="3071930721003" & s1aq1==232
recode s1aq3b s1aq4b s1aq6b (else=6)   if hid=="3722237213007" & s1aq1==232
replace s1aq4b=s1aq3b 	if hid=="3810438110002" & s1aq1==232
replace s1aq5=50     if hid=="4011140114004" & s1aq1==232   //based on obs
replace s1aq4a=s1aq6a  if hid=="4011140114004" & s1aq1==232
replace s1aq5=s1aq5/10     if hid=="4021340217007" & s1aq1==232   //based on obs
recode s1aq3b s1aq4b s1aq6b (else=5)  if asd==1 & hid=="4021040223012" & s1aq1==232
recode s1aq3a s1aq4a s1aq6a (else=1)  if asd==1 & hid=="4021040223012" & s1aq1==232

br if s1aq4a==50 & s1aq4b==14
replace s1aq4b=1  if s1aq4a==50 & s1aq4b==14

drop asd
gen asd=1   if s1aq1<=5 & s1aq3a>1 & s1aq3b==14  //large HHs although thisishigh
drop asd asd1 

gen asd=1  if s1aq4a==0 & s1aq4b~=. & s1aq5==.
ta asd 
gen asd1=1 if asd==1 & s1aq1==3 & s1aq3b==1
recode s1aq4a s1aq4b (else=.)  if asd1==1 
replace s1aq8a=s1aq3a  if asd1==1 
replace s1aq8b=s1aq3b  if asd1==1 
drop asd1 
gen asd2=1  if asd==1 & (s1aq6a==. & s1aq6b==. & s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==. )
count if asd2==1  //75 cases.  Will assume own stock 
replace s1aq3b=10  if asd2==1 & s1aq1==178 & s1aq3b==1 
replace s1aq7a=s1aq3a   if asd2==1
replace s1aq7b=s1aq3b   if asd2==1
recode s1aq4a-s1aq6b (else=.)  if asd2==1 
drop asd2

drop asd 
gen asd=1  if s1aq1<=4 & s1aq3b==15
drop asd 

gen asd=1  if s1aq1<=4 & s1aq3b==2
drop asd 

replace s1aq3b=10   if s1aq1<=4 & s1aq3b==11  

gen asd=1  if s1aq1<=4 & s1aq3b==6 
drop asd 

gen asd=1  if s1aq1<=4 & s1aq3b==0
drop asd 

gen asd=1   if s1aq1<=4 & s1aq3b==99
drop asd 

ta s1aq3b  if s1aq1==6
gen asd=1    if s1aq1==6 & s1aq2==1 & s1aq3b==0
replace s1aq4b=14   if s1aq1==5 & hid=="4011140114007"
replace s1aq3b=9  if s1aq1==6 & s1aq3b==3 & s1aq3b~=. 
replace s1aq4b=9  if s1aq1==6 & s1aq4b==3 & s1aq4b~=. 
replace s1aq6b=9  if s1aq1==6 & s1aq6b==3 & s1aq6b~=. 
replace s1aq7b=9  if s1aq1==6 & s1aq7b==3 & s1aq7b~=. 
replace s1aq8b=9  if s1aq1==6 & s1aq8b==3 & s1aq8b~=. 

replace s1aq3b=s1aq6b  if s1aq1==6 & s1aq3b==4 & hid=="5211452117006"
recode s1aq4a-s1aq6b (else=.)  if s1aq1==6 & hid=="5211452117006"

drop asd 
ta s1aq4b  if s1aq1==6
gen asd=1  if s1aq1==6 & s1aq4b==0
replace s1aq4b=s1aq3b  if asd==1 & hid=="5221052226005"
replace s1aq5=s1aq4a  if asd==1 & hid=="8421584215013"
replace s1aq4a=s1aq3a  if asd==1 & hid=="8421584215013"
replace s1aq4b=s1aq3b  if asd==1 & hid=="8421584215013"
replace s1aq6a=s1aq3a  if asd==1 & hid=="8421584215013"
replace s1aq6b=s1aq3b  if asd==1 & hid=="8421584215013"
recode s1aq7a s1aq7b (else=.)  if asd==1 & hid=="8421584215013"
recode s1aq4a-s1aq6b (else=.)  if asd==1 & s1aq5<10
replace s1aq7a=s1aq3a  if asd==1 & s1aq5==.
replace s1aq7b=s1aq3b  if asd==1 & s1aq5==.
recode s1aq4a-s1aq6b (else=.)  if asd==1 & s1aq5==. 
drop asd 

ta s1aq6b  if s1aq1==6
gen asd=1  if s1aq1==6 & s1aq6b==0
recode s1aq4a s1aq4b s1aq6a s1aq6b s1aq8a s1aq8b (else=.)  if asd==1 & s1aq5==.
replace s1aq3b=9  if asd==1 & s1aq3a==35
replace s1aq7b=9  if asd==1 & s1aq7a==35
drop asd 

ta s1aq7b  if s1aq1==6
gen asd=1  if s1aq1==6 & s1aq7b==0
replace s1aq7a=s1aq3a  if asd==1
replace s1aq7b=s1aq3b  if asd==1
drop asd 

ta s1aq8b  if s1aq1==6
gen asd=1  if s1aq1==6 & s1aq8b==0
replace s1aq8a=s1aq3a  if asd==1
replace s1aq8b=s1aq3b  if asd==1
drop asd 

replace s1aq4a=.5  if ((s1aq1==3 & hid=="4311543108005") | (s1aq1==1 & hid=="6311963128001"))  //error soemwehre
replace s1aq4b=14  if ((s1aq1==3 & hid=="4311543108005") | (s1aq1==1 & hid=="6311963128001"))

ta s1aq4b  if s1aq1<=5
gen asd=1  if s1aq1<=5 & s1aq4b==0 
drop asd 

gen asd=1   if s1aq4a~=. & s1aq6a~=. & s1aq7a==. & s1aq8a==.
gen asd1=1  if asd==1 & s1aq4a==s1aq6a 
gen asd2=1  if asd1==1 & s1aq4b~=s1aq6b   //1180 obs. There could be nothing wrong as it is possible.  Did not venture checkign this.
drop asd* 

ta s1aq1 s1aq3b

drop fgh*
gen fgh=1  if s1aq1==7 & s1aq2==1 & s1aq3b==0 & (s1aq6b~=0 | s1aq6b~=.)
drop fgh 

gen fgh=1   if s1aq1==12 & s1aq2==1 & s1aq3b==0
drop fgh

gen fgh=1  if s1aq1==7 & s1aq2==1 & s1aq3b==. & (s1aq7b>0 & s1aq7b~=.)
drop fgh

tab1  s1aq3b s1aq4b s1aq6b s1aq7b s1aq8b  if s1aq1<=5
gen fgh=1  if s1aq1<=5 & (s1aq4b>=2 & s1aq4b<=4)
ta fgh 
drop fgh 

gen fgh=1  if s1aq1<=5 & (s1aq6b>=2 & s1aq6b<=4)
drop fgh 

gen fgh=1  if s1aq1<=5 & s1aq4b==12
ta fgh 
drop fgh 

gen fgh=1   if s1aq6b==0 & s1aq1<=5
ta fgh 
drop fgh 

gen fgh=1   if s1aq2==1 & s1aq3b==0
ta fgh 
drop fgh 

gen ghj=1   if (s1aq3a==s1aq7a & s1aq7b==s1aq3b & (s1aq8a==. & s1aq8b==.))
ta ghj 
drop ghj

gen fgh=1   if (s1aq2==1 & s1aq3a==s1aq7a & s1aq3b==s1aq7b & s1aq8a==s1aq8b)
recode s1aq4a-s1aq6b (else=.) if fgh==1 & s1aq5==.
gen fgh1=1  if fgh==1 & s1aq5~=.
replace s1aq3a=s1aq5  if fgh1==1 & hid=="3522535219010"
replace s1aq7a=s1aq5  if fgh1==1 & hid=="3522535219010"
recode s1aq4a-s1aq6b (else=.)  if fgh1==1 & hid=="3522535219010"
replace s1aq6a=s1aq3a  if fgh==1 & s1aq5~=.
replace s1aq6b=s1aq3b  if fgh==1 & s1aq5~=.
recode s1aq7a-s1aq8b (else=.)  if fgh1==1 & s1aq5~=. 
recode s1aq3a s1aq4a s1aq6a (700=70)  if s1aq1==7 & hid=="5530155311012"
replace s1aq4a=s1aq3a  if s1aq1==12 & hid=="6420164208008"
replace s1aq4a=s1aq3a  if s1aq1==187 & hid=="8611386125002" 
br if fgh1==1 & s1aq4a==0
gen fgh2=1  if fgh1==1 & s1aq4a==0 
replace s1aq5=. if fgh2==1 & (hid=="5420254209006" | hid=="6120261210006" | hid=="6120761209016" | hid=="8220282223002")  //prices off
replace s1aq4a=s1aq3a  if fgh2==1 & s1aq5~=. 
replace s1aq7a=s1aq3a  if fgh2==1 & s1aq5==.
replace s1aq7b=s1aq3b  if fgh2==1 & s1aq5==.
recode s1aq4a-s1aq6b (else=.)  if fgh2==1 & s1aq5==.
drop fgh2 
drop fgh1 fgh  
gen fgh=1   if (s1aq2==1 & s1aq3a==s1aq7a & s1aq3b==s1aq7b & s1aq8a==s1aq8b)
recode s1aq8a s1aq8b (else=.)  if fgh==1 
drop fgh

gen fgh1=1   if   (s1aq2==1 & s1aq4a==s1aq3a & s1aq3a==s1aq7a & s1aq3b==s1aq7b & s1aq8a==. & s1aq8b==.)  //all missing 
replace s1aq1=2  if fgh1==1
drop fgh1 

gen fgh2=1   if (s1aq3a==. & s1aq3b==. & s1aq4a==. & s1aq4b==. & s1aq5==. & s1aq6a==. & s1aq6b==. & s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==.)   //all missing 
replace s1aq1=2  if fgh2==1
drop fgh2 

gen fgh2=1   if (s1aq3a==. & s1aq3b==. & s1aq4a==. & s1aq4b==. & s1aq5==. & s1aq6a==. & s1aq6b==. & s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==.)  //all missing 
replace s1aq1=2  if fgh2==1
drop fgh2 

gen fgh=1  if s1aq4a==0 & s1aq4b~=. & s1aq5==.
recode s1aq4a s1aq4b (else=.)  if fgh==1 
drop fgh

gen fgh=1  if s1aq3b==0   
ta fgh 
drop fgh

gen fgh=1  if s1aq4b==0   
recode s1aq4a s1aq4b (else=.)  if fgh==1 & s1aq5==.
gen fgh1=1  if fgh==1 & s1aq4a==s1aq3a 
replace s1aq4b=s1aq3b  if fgh1==1 
replace s1aq6b=s1aq3b  if fgh1==1 
recode s1aq7a-s1aq8b (else=.) if fgh1==1
drop fgh1 
drop fgh 
gen fgh=1  if s1aq4b==0  
replace s1aq5=.  if fgh==1 & s1aq5==s1aq3a 
replace s1aq7a=s1aq3a  if fgh==1 & s1aq5==.
replace s1aq7b=s1aq3b  if fgh==1 & s1aq5==.
recode s1aq4a-s1aq6b (else=.) if fgh==1 & s1aq5==.
replace s1aq4a=s1aq3a  if fgh==1 & s1aq4a==s1aq3b 
replace s1aq4b=s1aq3b  if fgh==1 & s1aq4a==s1aq3a 
replace s1aq4b=6  if fgh==1 & (s1aq1==16 | s1aq1==128) 
replace s1aq4a=s1aq3a  if fgh==1 & s1aq1==172 & hid=="3040130443011"
replace s1aq4b=s1aq3b  if fgh==1 & s1aq1==172 & hid=="3040130443011"
replace s1aq6a=s1aq3a  if fgh==1 & s1aq1==172 & hid=="3040130443011"
replace s1aq6b=s1aq3b  if fgh==1 & s1aq1==172 & hid=="3040130443011"
replace s1aq4a=s1aq3a  if fgh==1 & s1aq1==140 & hid=="4410644110003"
replace s1aq4b=s1aq3b  if fgh==1 & s1aq1==140 & hid=="4410644110003"
replace s1aq4b=s1aq3b  if fgh==1 & s1aq1==140 & hid=="4410644110003"
recode s1aq8a s1aq8b (else=.) if fgh==1 & hid=="3144131452015"
recode s1aq3b s1aq4b s1aq6b (else=5) if fgh==1 & hid=="3144131452015"
replace s1aq4a=2  if fgh==1 & hid=="3144131452015"
replace s1aq3a=2  if fgh==1 & hid=="3144131452015"
replace s1aq5=.   if fgh==1 & hid=="3144131452015"
replace s1aq4a=s1aq3a  if s1aq1==104 & hid=="3020230225008"
replace s1aq4a=20  if s1aq1==104 & s1aq5==300 & s1aq4a==. 
replace s1aq4b=10  if s1aq1==104 & s1aq5==300 & s1aq4b==. 
replace s1aq4a=20  if s1aq1==104 & hid=="3090230919015" 
replace s1aq4b=10  if s1aq1==104 & hid=="3090230919015"  
replace s1aq6a=s1aq3a  if s1aq1==104 & hid=="3090230919015" 
replace s1aq6b=s1aq3b  if s1aq1==104 & hid=="3090230919015" 
replace s1aq6a=s1aq3a  if s1aq1==171 & hid=="3710137101004" 
replace s1aq6b=s1aq3b  if s1aq1==171 & hid=="3710137101004"
replace s1aq5=.        if s1aq1==171 & hid=="3710137101004"
replace s1aq4a=s1aq3a  if s1aq1==232 & hid=="6311363126011" 
replace s1aq4b=s1aq3b  if s1aq1==232 & hid=="6311363126011"
replace s1aq4a=1       if s1aq1==21 & hid=="6311963130002" 
replace s1aq4b=5       if s1aq1==21 & hid=="6311963130002"
replace s1aq6a=s1aq3a  if s1aq1==21 & hid=="6311963130002" 
replace s1aq6b=s1aq3b  if s1aq1==21 & hid=="6311963130002"
replace s1aq4a=1       if s1aq1==230 & hid=="6311963130002" 
replace s1aq4b=12      if s1aq1==230 & hid=="6311963130002"
replace s1aq6a=s1aq3a  if s1aq1==230 & hid=="6311963130002" 
replace s1aq6b=s1aq3b  if s1aq1==230 & hid=="6311963130002"
replace s1aq4a=s1aq3a  if hid=="6311963130002" & (s1aq1==16 | s1aq1==131 | s1aq1==178 | s1aq1==197) 
replace s1aq4a=s1aq3a  if s1aq1==252 & hid=="6311963130002" 
replace s1aq4b=s1aq3b  if s1aq1==252 & hid=="6311963130002"
replace s1aq6a=s1aq3a  if s1aq1==252 & hid=="6311963130002" 
replace s1aq6b=s1aq3b  if s1aq1==252 & hid=="6311963130002"
//palm oil and vegetable oil off completely for 1 person HH=hid=="6311963130002"
replace s1aq3a=1  if hid=="6311963130002" & s1aq3a~=. & (s1aq1==104 | s1aq1==105)
recode s1aq4a s1aq4b s1aq5 (else=.)  if hid=="6311963130002" & s1aq1==105  //wrong entry
replace s1aq6a=1  if hid=="6311963130002" & s1aq6a~=. & (s1aq1==104 | s1aq1==105)
replace s1aq7a=1  if hid=="6311963130002" & s1aq7a~=. & (s1aq1==104 | s1aq1==105)
drop fgh

gen fgh=1   if s1aq1==178 & s1aq8b==14  //wrong entry 153 obs
recode s1aq4a-s1aq6b (else=.)  if fgh==1 
replace s1aq5=.  if fgh==1 & hid=="3810838102007"
recode s1aq3a s1aq8a (else=14) if fgh==1 & hid=="3810838102007"
recode s1aq3b s1aq8b (else=10) if fgh==1 & hid=="3810838102007"
recode s1aq3a s1aq6a (else=14) if fgh==1 & hid=="5411654111010"
recode s1aq3b s1aq6b (else=10) if fgh==1 & hid=="5411654111010"
recode s1aq8a s1aq8b (else=.) if fgh==1 & hid=="5411654111010"
replace s1aq3b=10  if fgh==1 & s1aq3a==1 & s1aq3b==14 & hhsize<30
replace s1aq3b=10  if fgh==1 & s1aq3a>2 & s1aq3b==14
replace s1aq8a=s1aq3a  if fgh==1 & s1aq5==.
replace s1aq8b=s1aq3b  if fgh==1 & s1aq5==.
drop fgh 

gen fgh=1  if s1aq8b==2 
replace s1aq7a=s1aq3a  if fgh==1 & s1aq3b==s1aq7b 
recode s1aq7a s1aq7b (else=.)  if fgh==1 & s1aq7a==2 & s1aq7b==2 & s1aq5~=.
recode s1aq8a s1aq8b (else=.)  if fgh==1 & s1aq8a==2 & s1aq8b==2 & s1aq5~=.
recode s1aq4a-s1aq6b (else=.)  if fgh==1 & s1aq5==.
recode s1aq7a s1aq7b (else=.)  if fgh==1 & s1aq7a~=. & s1aq6a~=. 
recode s1aq8a s1aq8b (else=.)  if fgh==1 & s1aq8a~=. & s1aq6a~=. 
recode s1aq8a s1aq8b (else=.)  if fgh==1 & s1aq8a~=. & s1aq7a~=. 
recode s1aq4a-s1aq6b (else=.)  if fgh==1 & s1aq1==252 & hid=="8611886107008"
replace s1aq5=s1aq4a   if s1aq1==106 & hid=="3310133116009"
replace s1aq4b=s1aq3b  if s1aq1==106 & hid=="3310133116009"
replace s1aq4a=s1aq3a  if s1aq1==106 & hid=="3310133116009"
replace s1aq4b=s1aq5   if s1aq1==188 & hid=="3143531411008"
replace s1aq5=s1aq4a   if s1aq1==188 & hid=="3143531411008"
replace s1aq4a=s1aq3a  if s1aq1==188 & hid=="3143531411008"
recode s1aq4a-s1aq6b (else=.)  if fgh==1 & ((s1aq1==109 & hid=="8221382211012") | (s1aq1==191 & hid=="8311083138012") | (s1aq1==25 & hid=="7410374112005") | (s1aq1==21 & hid=="6010160108007") | (s1aq1==233 & hid=="5110151135010") | (s1aq1==193 & hid=="5020850205001") | (s1aq1==27 & hid=="5020850205005") | (s1aq1==200 & hid=="3721737202002") | (s1aq1==104 & hid=="3410334101009") | (s1aq1==104 & hid=="3410334105008") | (s1aq1==106 & hid=="3320433220009") | (s1aq1==106 & hid=="1110111112011") | (s1aq1==106 & hid=="3410334101009") | (s1aq1==106 & hid=="3410334105008") | (s1aq1==10 & hid=="3421134215013") | (s1aq1==180 & hid=="6430764302011") | (s1aq1==223 & hid=="7210372117013"))
replace s1aq5=.  if (s1aq1==202 & hid=="2340123436007") | (s1aq1==207 & hid=="3240932442013") | (s1aq1==214 & hid=="3520935207016") | (s1aq1==203 & hid=="5012150173011") | (s1aq1==214 & hid=="5110551108008") | (s1aq1==211 & hid=="5211652115009") | (s1aq1==205 & hid=="7110371109004") | (s1aq1==119 & hid=="8422684226014")
recode s1aq3b s1aq4b s1aq6b (2=6)  if fgh==1 & s1aq1==198 & hid=="6112561121010"   

replace s1aq3a=s1aq4a  if s1aq1==7 & hid=="4512045112012"  //changed based on the low quantities which
replace s1aq3b=9      if s1aq1==7 & s1aq3b==2
replace s1aq4b=9      if s1aq1==7 & s1aq4b==2
replace s1aq6b=9      if s1aq1==7 & s1aq6b==2
replace s1aq7b=9      if s1aq1==7 & s1aq7b==2
replace s1aq8b=9      if s1aq1==7 & s1aq8b==2

replace s1aq4b=1      if s1aq1==236 & hid=="5012950107013"  //changed based on the low quantities whch
replace s1aq3b=10     if s1aq1==236 & hid=="5012950107013"
replace s1aq6b=10     if s1aq1==236 & hid=="5012950107013"
replace s1aq3b=5      if s1aq1==236 & s1aq3b==2
replace s1aq4b=5      if s1aq1==236 & s1aq4b==2
replace s1aq6b=5      if s1aq1==236 & s1aq6b==2
replace s1aq7b=5      if s1aq1==236 & s1aq7b==2
replace s1aq8b=5      if s1aq1==236 & s1aq8b==2
replace s1aq3b=11     if s1aq1==236 & s1aq3b==14 

replace s1aq3b=99      if s1aq1==184 & s1aq3b==2 & s1aq3a<100  //changed based on the low quantities which
replace s1aq4b=99      if s1aq1==184 & s1aq4b==2 & s1aq4a<100
replace s1aq6b=99      if s1aq1==184 & s1aq6b==2 & s1aq6a<100
replace s1aq7b=99      if s1aq1==184 & s1aq7b==2 & s1aq7a<100
replace s1aq8b=99      if s1aq1==184 & s1aq8b==2 & s1aq8a<100

replace s1aq3a=s1aq4a  if s1aq1==109 & s1aq3b==15
replace s1aq3b=s1aq4b  if s1aq1==109 & s1aq3b==15
recode s1aq3b s1aq4b (else=12)  if s1aq1==109 & hid=="3410334105001"
recode s1aq3b s1aq4b s1aq6b (else=99)  if s1aq1==109 & hid=="4210142109016" 
replace s1aq4b=12  if s1aq1==109 & s1aq4b==2 & s1aq5==80 & s1aq4a<500
replace s1aq3b=s1aq4b  if s1aq1==109 & s1aq3b==2 & s1aq4b==12 & s1aq5==80 & s1aq3a==s1aq4a 
replace s1aq6b=s1aq3b  if s1aq1==109 & s1aq6b==2 & s1aq4b==12 & s1aq5==80 & s1aq6a==s1aq4a 
recode s1aq8a s1aq8b (else=.)  if s1aq1==109 & hid=="5013050121012"

replace s1aq3b=99     if s1aq1==109 & s1aq3b==2 & s1aq3a<10  //consumption of 1 gram of butter is not feasible
replace s1aq4b=99     if s1aq1==109 & s1aq4b==2 & s1aq4a<10
replace s1aq6b=99     if s1aq1==109 & s1aq6b==2 & s1aq6a<10
replace s1aq7b=99     if s1aq1==109 & s1aq7b==2 & s1aq7a<10
replace s1aq8b=99     if s1aq1==109 & s1aq8b==2 & s1aq8a<10

gen fgh1=1  if fgh==1 & s1aq6a~=. & s1aq6a~=s1aq3a
replace s1aq6a=s1aq3a  if fgh1==1
replace s1aq6b=s1aq3b  if fgh1==1
drop fgh1
gen fgh1=1  if fgh==1 & s1aq6a~=. & s1aq6b~=s1aq3b
replace s1aq6b=s1aq3b  if fgh1==1
drop fgh1
gen fgh1=1  if fgh==1 & s1aq4a~=. & s1aq4b~=s1aq3b & s1aq3a==s1aq4a 
recode s1aq3b s1aq4b s1aq6b (else=1)   if fgh1==1 & hid=="5220152222015"
recode s1aq3b s1aq4b s1aq6b (else=99)  if fgh1==1 & hid=="3143531402006"
replace s1aq4b=s1aq3b  if fgh1==1
replace s1aq5=.  if fgh1==1 & s1aq5==2 
drop fgh1 
gen fgh1=1  if fgh==1 & s1aq7a~=. 
replace s1aq7a=s1aq3a  if fgh1==1
replace s1aq7b=s1aq3b  if fgh1==1
drop fgh1 
gen fgh1=1  if fgh==1 & s1aq8a~=. 
replace s1aq3b=10  if fgh1==1 & s1aq1==178 & s1aq3b==2
replace s1aq3b=10  if s1aq1==27 & (s1aq3b==2 | s1aq3b==3)
replace s1aq3b=1   if s1aq1==27 & hid=="4111041113014"
replace s1aq4b=10  if s1aq1==27 & (s1aq4b==2 | s1aq4b==3)
replace s1aq6b=10  if s1aq1==27 & (s1aq6b==2 | s1aq6b==3)
replace s1aq8a=s1aq3a  if fgh1==1
replace s1aq8b=s1aq3b  if fgh1==1
replace s1aq5=.  if fgh1==1 
drop fgh1

recode s1aq3a s1aq4a (13=1)  if s1aq1==232 & hid=="1020110208014"
recode s1aq3b s1aq4b (1=13)  if s1aq1==232 & hid=="1020110208014"
replace s1aq5=s1aq4a  if s1aq1==225 & hid=="1220112208004"
replace s1aq4a=s1aq3a  if s1aq1==225 & hid=="1220112208004"

recode s1aq7a-s1aq8b (else=.)  if s1aq1==127 & hid=="1110111112003"

recode s1aq7a-s1aq7b (else=.)  if (s1aq1==115 & hid=="1210112102005") | (s1aq1==138 & hid=="1230112304001")

recode s1aq8a-s1aq8b (else=.)  if (s1aq1==4 & hid=="1120111210001") | (s1aq1==4 & hid=="1120111210002") | (s1aq1==225 & hid=="1220112208004") | (s1aq1==110 & hid=="2020120213004") | (s1aq1==178 & hid=="2020120213006")

count if (s1aq3b!=s1aq4b & s1aq3b!=. & s1aq4b!=.) | (s1aq3b!= s1aq6b & s1aq3b!=. & s1aq6b!=.) | (s1aq3b != s1aq7b & s1aq3b!=. & s1aq7b!=.) | (s1aq3b!= s1aq8b & s1aq3b!=. & s1aq8b!=.) | (s1aq4b!= s1aq6b & s1aq4b!=. & s1aq6b!=.)| (s1aq4b != s1aq7b & s1aq4b!=. & s1aq7b!=.) | (s1aq4b != s1aq8b & s1aq4b!=. & s1aq8b!=.)| (s1aq6b!= s1aq7b & s1aq6b!=. & s1aq7b!=.)| (s1aq6b != s1aq8b & s1aq6b!=. & s1aq8b!=.) | (s1aq7b != s1aq8b & s1aq7b!=. & s1aq8b!=.)

gen asd1=1 if (s1aq3b!=s1aq4b & s1aq3b!=. & s1aq4b!=.) | (s1aq3b != s1aq6b & s1aq3b!=. & s1aq6b!=.) | (s1aq3b != s1aq7b & s1aq3b!=. & s1aq7b!=.) | (s1aq3b!= s1aq8b & s1aq3b!=. & s1aq8b!=.) | (s1aq4b != s1aq6b & s1aq4b!=. & s1aq6b!=.)| (s1aq4b != s1aq7b & s1aq4b!=. & s1aq7b!=.) | (s1aq4b!= s1aq8b & s1aq4b!=. & s1aq8b!=.) | (s1aq6b!= s1aq7b & s1aq6b!=. & s1aq7b!=.)| (s1aq6b != s1aq8b & s1aq6b!=. & s1aq8b!=.) | (s1aq7b!= s1aq8b & s1aq7b!=. & s1aq8b!=.)

gen asd2=1  if asd1==1 & s1aq5~=. & s1aq8a~=. 
replace s1aq8a=.  if asd2==1 & s1aq8b==0
replace s1aq8b=.  if asd2==1 & s1aq8a==.
recode s1aq7a-s1aq8b (else=.)  if asd2==1
replace s1aq3a=s1aq6a  if asd2==1 & s1aq1==178 & hid=="8310283111003"

replace s1aq5=s1aq4a  if asd2==1 & ((s1aq1==24 & hid=="8621086206001") | (s1aq1==237 & hid=="5320653207009"))
replace s1aq4a=s1aq3a  if asd2==1 & ((s1aq1==24 & hid=="8621086206001") | (s1aq1==237 & hid=="5320653207009"))
replace s1aq3b=s1aq6b if asd2==1 & s1aq1==10 & hid=="5622156219007"
recode s1aq3b s1aq6b (else=99)  if asd2==1 & s1aq1==226 & hid=="4510745106008"
replace s1aq5=s1aq4a   if asd2==1 & s1aq1==105 & (hid=="3620136214012" | hid=="3330133317001")
replace s1aq5=s1aq4a   if asd2==1 & s1aq1==237 & hid=="8310283120008"
replace s1aq4a=1       if asd2==1 & s1aq1==105 & (hid=="3620136214012" | hid=="3330133317001")
replace s1aq4a=1       if asd2==1 & s1aq1==105 & hid=="3330133317001"
replace s1aq5=s1aq6a   if asd2==1 & s1aq1==21 & hid=="3130231348014"
recode s1aq3b s1aq4b (else=5) if asd2==1 & s1aq1==21 & hid=="3130231348014"
replace s1aq5=s1aq3a  if asd2==1 & s1aq1==238 & hid=="3081730807001"
replace s1aq3a=s1aq6a  if asd2==1 & s1aq1==238 & hid=="3081730807001"
replace s1aq3b=s1aq6b  if asd2==1 & s1aq1==238 & hid=="3081730807001"
replace s1aq4a=s1aq3a  if asd2==1 & s1aq1==238 & hid=="3081730807001"
replace s1aq4b=s1aq3b  if asd2==1 & s1aq1==238 & hid=="3081730807001"
replace s1aq3a=s1aq6a  if asd2==1 & s1aq1==237 & (hid=="8322583218002" | hid=="8323283239013" | (s1aq1==178 & hid=="8310283111003") | (s1aq1==104 & hid=="6022460203002") )
recode s1aq3b s1aq4b s1aq6b (else=11)  if asd2==1 & s1aq1==237 & (hid=="8322583218002" | hid=="8323283239013" | (s1aq1==178 & hid=="8310283111003") | (s1aq1==104 & hid=="6022460203002") )
replace s1aq4a=s1aq3a  if asd2==1 & s1aq1==178 & hid=="8610686120011" 
replace s1aq5=.        if asd2==1 & s1aq1==178 & hid=="8610686120011" 
replace s1aq6a=s1aq3a  if asd2==1
replace s1aq6b=s1aq3b  if asd2==1
drop asd2 
drop asd1 

gen asd1=1 if (s1aq3b!=s1aq4b & s1aq3b!=. & s1aq4b!=.) | (s1aq3b != s1aq6b & s1aq3b!=. & s1aq6b!=.) | (s1aq3b != s1aq7b & s1aq3b!=. & s1aq7b!=.) | (s1aq3b!= s1aq8b & s1aq3b!=. & s1aq8b!=.) | (s1aq4b != s1aq6b & s1aq4b!=. & s1aq6b!=.)| (s1aq4b != s1aq7b & s1aq4b!=. & s1aq7b!=.) | (s1aq4b!= s1aq8b & s1aq4b!=. & s1aq8b!=.) | (s1aq6b!= s1aq7b & s1aq6b!=. & s1aq7b!=.)| (s1aq6b != s1aq8b & s1aq6b!=. & s1aq8b!=.) | (s1aq7b!= s1aq8b & s1aq7b!=. & s1aq8b!=.)

gen miss=1  if s1aq4a==. & s1aq4b==. & s1aq5==. & s1aq6a==. & s1aq6b==. & s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==.
replace s1aq7a=s1aq3a  if miss==1
replace s1aq7b=s1aq3b  if miss==1
replace s1aq1=2  if s1aq3a==. 
drop miss 
gen miss=1  if s1aq6a==. & s1aq6b==. & s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==.
replace s1aq6a=s1aq3a  if miss==1 & s1aq5~=.
replace s1aq6b=s1aq3b  if miss==1 & s1aq5~=.
gen miss1=1  if miss==1 & s1aq5==. & s1aq4a==s1aq3a 
replace s1aq7a=s1aq3a  if miss1==1
replace s1aq7b=s1aq3b  if miss1==1 
recode s1aq4a s1aq4b (else=.)  if miss1==1
drop miss1 
gen miss1=1  if miss==1 & s1aq5==. & s1aq4a~=s1aq3a & s1aq4a~=. 
replace s1aq3a=s1aq3b  if miss1==1 & s1aq1==226 & hid=="5210652125002"
replace s1aq3b=11      if miss1==1 & s1aq1==226 & hid=="5210652125002"
replace s1aq5=s1aq4a   if miss1==1 
replace s1aq6a=s1aq3a  if miss1==1 
replace s1aq6b=s1aq3b  if miss1==1 
recode s1aq4a s1aq4b (else=.)  if miss1==1 
replace s1aq5=.  if s1aq5<15 
drop miss miss1 
gen miss=1  if s1aq6a==. & s1aq6b==. & s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==.

recode s1aq4b s1aq3b s1aq6b (else=5)     if s1aq4b==15 & s1aq1==25 

drop asd1 
gen asd1=1 if (s1aq3b!=s1aq4b & s1aq3b!=. & s1aq4b!=.) | (s1aq3b != s1aq6b & s1aq3b!=. & s1aq6b!=.) | (s1aq3b != s1aq7b & s1aq3b!=. & s1aq7b!=.) | (s1aq3b!= s1aq8b & s1aq3b!=. & s1aq8b!=.) | (s1aq4b != s1aq6b & s1aq4b!=. & s1aq6b!=.)| (s1aq4b != s1aq7b & s1aq4b!=. & s1aq7b!=.) | (s1aq4b!= s1aq8b & s1aq4b!=. & s1aq8b!=.) | (s1aq6b!= s1aq7b & s1aq6b!=. & s1aq7b!=.)| (s1aq6b != s1aq8b & s1aq6b!=. & s1aq8b!=.) | (s1aq7b!= s1aq8b & s1aq7b!=. & s1aq8b!=.)
drop asd asd1

*br if s1aq3a~=s1aq8a & s1aq8a~=.
gen fgz=1  if s1aq3a~=s1aq8a & s1aq8a~=.
gen ghj=fgz 
egen tots=rsum(s1aq6a s1aq7a s1aq8a)
order hid hhsize s1aq1 tots
br if fgz==1
gen fgz1=1  if fgz==1 & s1aq5==. & s1aq8a==50 
replace s1aq8a=s1aq3a  if fgz1==1
replace s1aq8b=s1aq3b  if fgz1==1
recode s1aq4a-s1aq6b (else=.)  if fgz1==1 & s1aq5==.
replace fgz=.  if fgz1==1
drop fgz1 
gen fgz1=1  if fgz==1 & s1aq5==. & s1aq8b==10 & s1aq3b==14
replace s1aq3a=s1aq8a  if fgz1==1
replace s1aq3b=s1aq8b  if fgz1==1
replace fgz=.  if fgz1==1
drop fgz1 
gen fgz1=1  if fgz==1 & s1aq5==. & tots==s1aq3a 
recode s1aq7a s1aq7b (else=.)  if fgz1==1 & s1aq1==169 & hid=="7510175107166"
recode s1aq7a s1aq7b (else=.)  if fgz1==1 & s1aq1==17 & hid=="3610536108007"
replace s1aq7a=s1aq6a  if fgz1==1 & s1aq6a~=.
replace s1aq7b=s1aq3b  if fgz1==1 & s1aq6b~=.
replace s1aq8b=s1aq3b  if fgz1==1 & s1aq6b~=.
recode s1aq4a-s1aq6b (else=.) if fgz1==1 
replace fgz=.  if fgz1==1
drop fgz1
gen fgz1=1  if fgz==1 & s1aq5~=. & s1aq3a==s1aq6a
replace s1aq8a=s1aq8a/10  if fgz1==1 & s1aq1==256 & (hid=="4121141207008" | hid=="3230232347014")
egen tots1=rsum(s1aq6a s1aq7a s1aq8a)
replace tots=tots1  if fgz1==1 
replace s1aq3a=tots  if fgz1==1
replace fgz=.  if fgz1==1
drop fgz1
gen fgz1=1  if fgz==1 & s1aq5~=. & s1aq3a~=tots  
replace s1aq3a=tots  if fgz1==1
replace fgz=.  if fgz1==1
drop fgz1
gen fgz1=1  if fgz==1 & s1aq5~=. & s1aq3a==tots  
recode s1aq7a s1aq7b (else=.)  if fgz1==1 & s1aq1==194 & hid=="5530155356014"
drop tots1
egen tots1=rsum(s1aq6a s1aq7a s1aq8a)
replace tots=tots1  if fgz1==1 
replace s1aq3a=tots  if fgz1==1
replace fgz=.  if fgz1==1
drop fgz1
replace s1aq3a=s1aq4a  if (s1aq1==178 & hid=="3040130406006") | (s1aq1==105 & hid=="3040130423008") | (s1aq1==258 & hid=="3040130423008") 
replace s1aq3a=s1aq8a  if (s1aq1==187 & hid=="3050330585012") | (s1aq1==187 & hid=="3311033102004") | (s1aq1==256 & hid=="3620336207008")
replace s1aq5=s1aq4a   if s1aq1==178 & hid=="3311033102015"
replace s1aq4a=s1aq3a  if s1aq1==178 & hid=="3311033102015"
replace s1aq4b=s1aq3b  if s1aq1==178 & hid=="3311033102015"
replace s1aq6a=s1aq3a  if s1aq1==178 & hid=="3311033102015"
replace s1aq6b=s1aq3b  if s1aq1==178 & hid=="3311033102015"
replace s1aq4a=s1aq3a  if s1aq1==178 & hid=="3311033102015"
recode s1aq8a s1aq8b (else=.)  if s1aq1==178 & hid=="3311033102015"
replace s1aq3b=s1aq4b  if s1aq1==178 & hid=="3721937201016" 
replace s1aq3b=10      if s1aq1==178 & (hid=="4210242107010" | hid=="5013050117015")
replace s1aq3a=s1aq8a  if s1aq1==105 & hid=="4320443201004"  
replace s1aq3b=s1aq4b  if s1aq1==127 & hid=="5013050129013" 
replace s1aq3a=s1aq8b  if s1aq1==106 & hid=="5111451111005" 
replace s1aq3b=s1aq8a  if s1aq1==106 & hid=="5111451111005" 
replace s1aq3a=s1aq8a  if s1aq1==110 & hid=="5420554201008"  
replace s1aq3a=s1aq8a  if s1aq1==256 & hid=="6022460203016" 
replace s1aq3b=10      if s1aq1==3 & hid=="6410764121012" 
replace s1aq3a=s1aq8a  if s1aq1==3 & hid=="6420164208005" 
replace s1aq3b=s1aq8b  if s1aq1==3 & hid=="6420164208005"
replace s1aq3a=s1aq8a  if s1aq1==256 & (hid=="8110281119002" | hid=="8110281125005")
replace s1aq3a=s1aq8a  if s1aq1==105 & (hid=="4110341105009" | hid=="4121441205004")
replace s1aq3b=s1aq8b  if s1aq1==105 & (hid=="4110341105009" | hid=="4121441205004") 
replace s1aq3b=s1aq4b  if s1aq1==178 & hid=="3040130406006"
replace s1aq3a=s1aq8a  if s1aq1==187 & hid=="3050330585012"
replace s1aq3b=s1aq8b  if s1aq1==178 & (hid=="4110341105013" | hid=="4110741108012")
replace s1aq3b=s1aq8b  if s1aq1==105 & hid=="4121441205004"
replace s1aq3b=s1aq8b  if s1aq1==178 & hid=="4210242106012"
replace s1aq3a=s1aq8a  if s1aq1==178 & hid=="4210242106012"
recode s1aq3b s1aq8b (else=10)  if s1aq1==178 & hid=="4210242107010" 
gen fgz1=1  if fgz==1 & s1aq7a==s1aq3a 
recode s1aq8a s1aq8b (else=.)  if fgz==1 & s1aq7a==s1aq3a 
recode s1aq4a-s1aq6b (else=.) if fgz1==1 
replace fgz=.  if fgz1==1
drop fgz1
gen fgz1=1  if fgz==1 & s1aq8a==s1aq3a 
recode s1aq4a-s1aq6b (else=.) if fgz1==1 
replace fgz=.  if fgz1==1
drop fgz1
gen fgz1=1  if fgz==1 & s1aq5==. 
replace s1aq8a=s1aq3a  if fgz1==1 
replace s1aq8b=s1aq3b  if fgz1==1
recode s1aq4a-s1aq6b (else=.) if fgz1==1 
replace fgz=.  if fgz1==1
drop fgz1
drop tots1 
egen tots1=rsum(s1aq6a s1aq7a s1aq8a)
replace tots=tots1  if ghj==1
replace s1aq3a=tots  if ghj==1
drop fgz 

gen fgz=1  if s1aq4a~=. & s1aq6a~=. & s1aq7a~=. & s1aq8a~=. 
recode s1aq7a-s1aq8b (else=.) if fgz==1 & s1aq5~=. 
recode s1aq4a-s1aq6b s1aq8a s1aq8b  (else=.) if fgz==1 & s1aq5==.
drop tots1 
egen tots1=rsum(s1aq6a s1aq7a s1aq8a)
replace tots=tots1  if fgz==1
drop fgz 

ta s1aq3b if s1aq1==129
gen fgz=1  if s1aq1==129
gen fgz1=1  if fgz==1 & s1aq3b<6
recode s1aq3b s1aq4b s1aq6b (else=6)  if fgz1==1 & hid=="3143531421009"
replace s1aq3b=11  if fgz==1 & (s1aq3a==2.5 | s1aq3a==.5)
replace s1aq4b=11  if fgz==1 & (s1aq4a==2.5 | s1aq4a==.5)
replace s1aq6b=11  if fgz==1 & (s1aq6a==2.5 | s1aq6a==.5)
replace s1aq7b=11  if fgz==1 & (s1aq7a==2.5 | s1aq7a==.5)
replace s1aq8b=11  if fgz==1 & (s1aq8a==2.5 | s1aq8a==.5)
replace s1aq4a=s1aq3a  if s1aq1==129 & hid=="8011480128016"
replace s1aq4a=s1aq3a  if s1aq1==129 & hid=="8611886107004"
recode s1aq3b s1aq4b s1aq6b s1aq7b s1aq8b (else=6)  if  s1aq1==129 & hid=="4010840108007"
recode s1aq3b s1aq4b s1aq6b s1aq7b s1aq8b  (else=11)  if s1aq1==129 & (hid=="3050330585011" | hid=="3060530638002" | hid=="3144131462014" | hid=="3210932108003" | hid=="3810738103014" | hid=="8121181225008" | hid=="4121441205004" | hid=="3111131102002" | hid=="3240432429016" | hid=="5520155217014" | hid=="5520155217014" | hid=="8611886107004" | hid=="5530155304007" | hid=="3311033102002" | hid=="3111131102003" | hid=="1120111210003" | hid=="3330533320013" | hid=="3520235213001" | hid=="3521135203009" | hid=="3610636104009" | hid=="3621636209003" | hid=="3721837205007" | hid=="4311543108012" | hid=="4512045110005" | hid=="5013050125016" | hid=="5211052111004" | hid=="5310253111001" | hid=="5411654111015" | hid=="5420754215008" |  hid=="5420754215011" | hid=="4311543116016") 
recode s1aq3b s1aq4b s1aq6b s1aq7b s1aq8b  (else=1)   if s1aq1==129 & (hid=="2220122228001" | hid=="3090330950002" | hid=="3711637103008" | hid=="3711637103009" | hid=="3721937201001" | hid=="3810738103016" | hid=="4010440103015" | hid=="4220442209014" | hid=="4220642204006") 
recode s1aq3b s1aq4b s1aq6b s1aq7b s1aq8b  (else=1) if s1aq1==129 & (hid=="2020120213010" | hid=="2410124101008" | hid=="3320433220007" | hid=="3710137101004" | hid=="3710137101011" | hid=="3720437211001" | hid=="3720437211002" | hid=="3722237213014" | hid=="3810338108014" | hid=="3820238208006" | hid=="3821338206004" | hid=="4020540221005" | hid=="4021240209015" | hid=="4110241106008" | hid=="4220642204012")
replace s1aq4b=.  if s1aq1==129 & s1aq4a==. 
replace s1aq6b=.  if s1aq1==129 & s1aq6a==. 
replace s1aq7b=.  if s1aq1==129 & s1aq7a==. 
replace s1aq8b=.  if s1aq1==129 & s1aq8a==. 
drop fgz1 fgz 

gen fgz=1  if s1aq1==127
gen fgz1=1  if fgz==1 & s1aq3b<6 
recode s1aq3a s1aq4a s1aq6a (else=1)  if s1aq1==127 & hid=="5530155311012"
recode s1aq7a s1aq7b (else=.)  if s1aq1==127 & (hid=="5530155311012" | hid=="7510175104098" | hid=="8013680119011")
replace s1aq5=s1aq4a  if s1aq1==127 & hid=="7510175104098"
replace s1aq5=s1aq4a  if s1aq1==127 & hid=="8013680119011"
recode s1aq3a s1aq4a s1aq6a (else=4) if s1aq1==127 & (hid=="7510175104098" | hid=="8013680119011")
recode s1aq3b s1aq4b s1aq6b (else=11) if s1aq1==127 & (hid=="7510175104098" | hid=="5012750140010" | hid=="5121851236010" | hid=="8013680119011")
recode s1aq3b s1aq4b s1aq6b (else=11) if s1aq1==127 & hid=="3030530383015" 
recode s1aq3a s1aq4a s1aq6a (else=2)  if s1aq1==128 & hid=="3010430108011" 
recode s1aq3b s1aq4b s1aq6b (else=11) if s1aq1==128 & hid=="3010430108011" 
replace s1aq4a=s1aq3a  if s1aq1==128 & (hid=="6311963128004" | hid=="8611386125002")
recode s1aq3b s1aq4b s1aq6b s1aq7b s1aq8b (else=1)  if s1aq1==128 & (hid=="1020110201011" | hid=="1110111106009" | hid=="1130111303001" | hid=="2130121308010" | hid=="2210122167013" | hid=="2340123436014" | hid=="2410124101016" | hid=="3030130302014" | hid=="3030130341011" | hid=="3030330362014" | hid=="3722237213011" | hid=="3821338206009" | hid=="4011140114005" | hid=="5420554201006" | hid=="6311963128004" | hid=="8611386125002" | hid=="7011670108012")
replace s1aq5=s1aq4a  if s1aq1==128 & hid=="8410784115005"
replace s1aq6a=s1aq3a  if s1aq1==128 & hid=="3810138105008"
replace s1aq6b=s1aq3b  if s1aq1==128 & hid=="3810138105008"
recode s1aq3b s1aq4b s1aq6b s1aq7b s1aq8b (else=11)  if s1aq1==128 & (hid=="3810938107001" | hid=="5530155311003" | hid=="7310273118015" | hid=="3521035222004" | hid=="3810638106016" | hid=="5310553123016" | hid=="5411754121011" | hid=="5420554201003" | hid=="5420754218014" | hid=="5420754218015" | hid=="5530155307011" | hid=="5530155352014" | hid=="6011360102010" | hid=="5420554201016" | hid=="8410784115005")
replace s1aq4b=.  if s1aq1==128 & s1aq4a==. 
replace s1aq6b=.  if s1aq1==128 & s1aq6a==. 
replace s1aq7b=.  if s1aq1==128 & s1aq7a==. 
replace s1aq8b=.  if s1aq1==128 & s1aq8a==. 

replace s1aq3b=9   if s1aq3b==15 & s1aq1==114
replace s1aq7b=9   if s1aq7b==15 & s1aq1==114

recode s1aq3a s1aq4a s1aq6a(else=1) if s1aq1==114 & hid=="5530155311012"
recode s1aq3b s1aq4b s1aq6b (else=9) if s1aq1==114 & hid=="5530155311012"
recode s1aq7a s1aq7b (else=.) if s1aq1==114 & hid=="5530155311012"
replace s1aq4b=14  if s1aq1==114 & (hid=="3810438110006" | hid=="3810438110010" | hid=="5122251233008")
replace s1aq4b=.  if s1aq4a==. 
replace s1aq6b=.  if s1aq6a==. 
replace s1aq7b=.  if s1aq7a==. 
replace s1aq8b=.  if s1aq8a==. 

replace s1aq3a=s1aq6b  if (s1aq1==7 & hid=="5320953205007") | (s1aq1==31 & hid=="5420554201008") 
recode s1aq3a s1aq6a (else=6) if s1aq1==7 & hid=="5420754215009"
recode s1aq3b s1aq6a (else=10) if s1aq1==7 & hid=="5420754215009"
recode s1aq7a s1aq7b (else=.) if s1aq1==7 & hid=="5420754215009"
replace s1aq3a=s1aq6a  if (s1aq1==196 & hid=="6430164315005") | (s1aq1==179 & hid=="8110281125001")
replace s1aq3b=s1aq6b  if (s1aq1==196 & hid=="6430164315005") | (s1aq1==179 & hid=="8110281125001")
recode s1aq3b s1aq4b s1aq6b s1aq7b s1aq8b (else=10) if (s1aq1==178 & hid=="5520855211011") | (s1aq1==178 & hid=="6410864115010") | (s1aq1==6 & hid=="8420684201015") | (s1aq1==7 & hid=="8420684201015")
recode s1aq3b s1aq4b s1aq6b (else=5) if (s1aq1==25 & hid=="8511285218012")
replace s1aq3b=s1aq6b  if (s1aq1==198 & hid=="1010110106009") | (s1aq1==104 & hid=="2340123460002") | (s1aq1==31 & hid=="3030130341002") | (s1aq1==25 & hid=="3522535215009") | (s1aq1==187 & hid=="5222252205007") | (s1aq1==5 & hid=="5320953205007") | (s1aq1==31 & hid=="5420554201008")

replace s1aq3a=s1aq3b  if (s1aq1==7 & hid=="5420754220013") | (s1aq1==7 & hid=="5420754220015")
replace s1aq3b=1       if (s1aq1==7 & hid=="5420754220013") | (s1aq1==7 & hid=="5420754220015")
replace s1aq6a=s1aq3a  if (s1aq1==7 & hid=="5420754220013") | (s1aq1==7 & hid=="5420754220015")
replace s1aq6b=s1aq3b  if (s1aq1==7 & hid=="5420754220013") | (s1aq1==7 & hid=="5420754220015")
replace s1aq3a=s1aq6a  if (s1aq1==7 & hid=="5320953205007")
replace s1aq3b=s1aq6b  if (s1aq1==7 & hid=="5320953205007")
recode s1aq3b s1aq6b (else=10)  if s1aq1==7 & hid=="5320253210005"
gen jks=1  if s1aq3b==15
recode s1aq3a s1aq6a (else=15)  if jks==1  
recode s1aq3b s1aq6b (else=10)  if jks==1  
drop jks

gen jks=1  if s1aq6b==15
replace s1aq6a=s1aq3a  if jks==1 
replace s1aq6b=s1aq3b  if jks==1 
recode s1aq7a s1aq7b (else=.)  if jks==1  
drop jks

gen jks=1  if s1aq7b==0
gen jks1=1  if jks==1 & s1aq3a==s1aq7a & s1aq5~=. 
recode s1aq7a s1aq7b (else=.)  if jks1==1 
drop jks1 
gen jks1=1  if jks==1 & s1aq3a==s1aq7a & s1aq5==. 
recode s1aq4a-s1aq6b (else=.)  if jks1==1 
replace s1aq8a=s1aq3a  if jks1==1 & s1aq8a~=.
replace s1aq8b=s1aq3b  if jks1==1 & s1aq8b~=.
replace s1aq7a=.  if jks1==1 & s1aq8a~=.
replace s1aq7b=.  if jks1==1 & s1aq8b~=.
replace s1aq7a=s1aq3a  if jks1==1 & s1aq7a~=.
replace s1aq7b=s1aq3b  if jks1==1 & s1aq7b~=.
drop jks1 
drop jks 
gen jks=1  if s1aq7b==0
gen jks1=1  if jks==1 & (s1aq3a==s1aq6a & s1aq5~=.) 
replace s1aq3b=s1aq6b  if jks1==1 & s1aq1==104 & (hid=="5210652125014" | hid=="5122551211015")
replace s1aq6a=s1aq3a  if jks1==1 & s1aq6a~=.
replace s1aq6b=s1aq3b  if jks1==1 & s1aq6b~=.
recode s1aq7a s1aq7b (else=.)  if jks1==1 
drop jks1 
gen jks1=1  if jks==1 & (s1aq3a==s1aq6a & s1aq5==.) 
replace s1aq7a=s1aq3a  if jks1==1 & s1aq7a~=.
replace s1aq7b=s1aq3b  if jks1==1 & s1aq7b~=.
recode s1aq4a-s1aq6b (else=.)  if jks1==1 
drop jks1 
drop jks 
gen jks=1  if s1aq7b==0
gen jks1=1  if jks==1 & (s1aq5==. & s1aq4a==.)
replace s1aq7a=s1aq3a  if jks==1
replace s1aq7b=s1aq3b  if jks==1
recode s1aq4a-s1aq6b (else=.)  if jks1==1 
drop jks1 
drop jks 

gen jks=1  if s1aq8b==0
gen jks1=1  if jks==1 & (s1aq5==. & s1aq4a==.)
drop jks jks1 

replace s1aq5=s1aq4a   if s1aq1==104 & hid=="3050330585010"
recode s1aq3b s1aq4b s1aq6b (else=10)   if s1aq1==104 & hid=="3050330585010"
recode s1aq3a s1aq4a s1aq6a (else=1)   if s1aq1==104 & hid=="3050330585010"
recode s1aq7a s1aq7b (else=.)   if s1aq1==104 & hid=="3050330585010"
replace s1aq5=s1aq4a   if s1aq1==194 & hid=="3512535115011"
recode s1aq3b s1aq4b s1aq6b (else=6)   if s1aq1==194 & hid=="3512535115011"
recode s1aq3a s1aq4a s1aq6a (else=2)   if s1aq1==194 & hid=="3512535115011"
recode s1aq7a s1aq7b (else=.)   if s1aq1==194 & hid=="3512535115011"

replace s1aq4b=.  if s1aq4a==. 
replace s1aq6b=.  if s1aq6a==. 
replace s1aq7b=.  if s1aq7a==. 
replace s1aq8b=.  if s1aq8a==. 

gen jks=1  if s1aq3a~=s1aq8a & s1aq8a~=.  //ok
drop jks
gen jks=1  if s1aq3b~=s1aq8b & s1aq8b~=.
gen jks1=1 if jks==1 & s1aq4a==.
replace s1aq3b=10  if jks1==1 & (s1aq1==178 & s1aq3b==2)
replace s1aq3b=10  if jks1==1 & (s1aq1==178 & s1aq3b==14)
replace s1aq8a=.  if jks1==1 & s1aq7a~=.
replace s1aq8b=.  if jks1==1 & s1aq7b~=.
replace s1aq7a=s1aq3a if jks==1 & s1aq8a==. 
replace s1aq7b=s1aq3b if jks==1 & s1aq8b==. 
replace s1aq3b=s1aq4b  if jks==1 & (s1aq1==104 & hid=="5210652125001")
replace s1aq3b=s1aq4b  if jks==1 & (s1aq1==187 & hid=="6110261119006") 
replace s1aq3b=s1aq8b  if jks==1 & (s1aq1==226 & hid=="8321783213014")
replace s1aq3b=s1aq8b  if jks==1 & (s1aq1==178 & hid=="6431564317013")
replace s1aq3b=s1aq8b  if jks==1 & (s1aq1==101 & hid=="6421564215004")
replace s1aq3b=s1aq8b  if jks==1 & (s1aq1==105 & hid=="6421564215004")
replace s1aq8a=s1aq3a if jks==1 & s1aq7a==.
replace s1aq8b=s1aq3b if jks==1 & s1aq7a==.
recode s1aq4a-s1aq6b (else=.)   if jks==1 
drop jks jks1 

gen jks=1  if s1aq3b~=s1aq6b & s1aq6b~=.
gen jks1=1 if jks==1 & s1aq5==.
replace s1aq3b=s1aq6b  if jks1==1 & ((s1aq1==227 & hid=="3421034211008") | (s1aq1==232 & hid=="4111041112008") )
replace s1aq3b=s1aq4b  if jks1==1 & (s1aq1==226 & hid=="5011350157010")
replace s1aq3a=s1aq3b  if jks1==1 & (s1aq1==178 & hid=="5111751123002")
replace s1aq3b=s1aq6a  if jks1==1 & (s1aq1==178 & hid=="5111751123002")
replace s1aq3b=9  if jks1==1 & (s1aq1==7 & hid=="5222152223008")
replace s1aq3b=10  if jks1==1 & (s1aq1==178 & hid=="5420554201002") 
replace s1aq3b=11  if jks1==1 & (s1aq1==237 & hid=="6113761127012")
replace s1aq3b=1  if jks1==1 & (s1aq1==238 & hid=="6411764109004")
replace s1aq3a=s1aq3b  if jks1==1 & (s1aq1==184 & hid=="7111171113016")
replace s1aq3b=s1aq6a  if jks1==1 & (s1aq1==184 & hid=="7111171113016")
replace s1aq3a=s1aq3b  if jks1==1 & (s1aq1==241 & hid=="7331373325009")
replace s1aq3b=s1aq6a  if jks1==1 & (s1aq1==241 & hid=="7331373325009")
replace s1aq3b=5       if jks1==1 & (s1aq1==194 & hid=="7410374108004")
replace s1aq3a=s1aq3b  if jks1==1 & (s1aq1==226 & hid=="8220282217005")
replace s1aq3b=s1aq6a  if jks1==1 & (s1aq1==226 & hid=="8220282217005")
replace s1aq3a=s1aq3b  if jks1==1 & (s1aq1==194 & hid=="8520385216012")
replace s1aq3b=s1aq6a  if jks1==1 & (s1aq1==194 & hid=="8520385216012")
replace s1aq3b=5       if jks1==1 & s1aq1==235 & hid=="3420934212010"
replace s1aq3a=s1aq6a  if jks1==1 & ((s1aq1==226 & hid=="4110741108015") | (s1aq1==196 & hid=="4111241102015") | (s1aq1==129 & hid=="4120341210013" ) | (s1aq1==30 & hid=="4210242106011") | (s1aq1==227 & hid=="4311543134009") | (s1aq1==226 & hid=="4511345113015") | (s1aq1==232 & hid=="5010550185004") | (s1aq1==237 & hid=="5011350157004") | (s1aq1==238 & hid=="5013050125001") | (s1aq1==237 & hid=="5020150236014") | (s1aq1==226 & hid=="5530155339008") | (s1aq1==171 & hid=="6022360208006") | (s1aq1==226 & hid=="6022360208006") | (s1aq1==238 & hid=="6431564317006") | (s1aq1==227 & hid=="7011670108011") | (s1aq1==227 & hid=="7110371109004") | (s1aq1==198 & hid=="7111171113010") | (s1aq1==232 & hid=="7510175103054") | (s1aq1==227 & hid=="8020680201013") )
replace s1aq3b=s1aq6b  if jks1==1 & ((s1aq1==226 & hid=="4110741108015") | (s1aq1==196 & hid=="4111241102015") | (s1aq1==129 & hid=="4120341210013" ) | (s1aq1==30 & hid=="4210242106011") | (s1aq1==227 & hid=="4311543134009") | (s1aq1==226 & hid=="4511345113015") | (s1aq1==232 & hid=="5010550185004") | (s1aq1==237 & hid=="5011350157004") | (s1aq1==238 & hid=="5013050125001") | (s1aq1==237 & hid=="5020150236014") | (s1aq1==226 & hid=="5530155339008") | (s1aq1==171 & hid=="6022360208006") | (s1aq1==226 & hid=="6022360208006") | (s1aq1==238 & hid=="6431564317006") | (s1aq1==227 & hid=="7011670108011") | (s1aq1==227 & hid=="7110371109004") | (s1aq1==198 & hid=="7111171113010") | (s1aq1==232 & hid=="7510175103054") | (s1aq1==227 & hid=="8020680201013") | (s1aq1==194 & hid=="5012650134002") | (s1aq1==104 & hid=="5013050125015") | (s1aq1==241 & hid=="5121651214005") | (s1aq1==26 & hid=="5122251233001") | (s1aq1==232 & hid=="5122251233008") | (s1aq1==138 & hid=="5122251233014") | (s1aq1==232 & hid=="5221852211015") | (s1aq1==245 & hid=="5411654115007") | (s1aq1==245 & hid=="5420754218011") | (s1aq1==245 & hid=="5530155347009") | (s1aq1==226 & hid=="5610656115001") | (s1aq1==124 & hid=="5612056108010") | (s1aq1==194 & hid=="6020960225014") | (s1aq1==226 & hid=="6021460217012") | (s1aq1==114 & hid=="6112161122008") | (s1aq1==226 & hid=="6321663215004") | (s1aq1==196 & hid=="6322163222005") | (s1aq1==196 & hid=="6421564215016") | (s1aq1==196 & hid=="6431564317005") | (s1aq1==226 & hid=="7220472231009") | (s1aq1==237 & hid=="7333273304016") | (s1aq1==226 & hid=="8020480209012") | (s1aq1==238 & hid=="8020680201003") | (s1aq1==237 & hid=="8110281127005") | (s1aq1==226 & hid=="8220282217006") | (s1aq1==237 & hid=="8620686221007"))
recode s1aq4a-s1aq6b (else=.) if jks1==1 & s1aq7a~=.
replace s1aq7a=s1aq3a  if jks1==1 & s1aq7a~=.
replace s1aq7b=s1aq3b  if jks1==1 & s1aq7b~=.
replace s1aq7a=s1aq3a  if jks1==1 & (s1aq7a==. & s1aq8a==.)
replace s1aq7b=s1aq3b  if jks1==1 & (s1aq7b==. & s1aq8b==.)
recode s1aq4a-s1aq6b (else=.) if jks1==1  
drop jks1 
gen jks1=1 if jks==1 & s1aq5==. 

sort hid s1aq1 

compress
save "$temp\food_1A_editted.dta",replace 



append using "$temp\food_1A_notconsumed.dta"
sort hid s1aq1

gen PT2_Sect_1="PART 2 Section 1A"
la var PT2_Sect_1 "PART 2 Section 1A"

count if (s1aq3b!=s1aq4b & s1aq3b!=. & s1aq4b!=.) | (s1aq3b!= s1aq6b & s1aq3b!=. & s1aq6b!=.) | (s1aq3b != s1aq7b & s1aq3b!=. & s1aq7b!=.) | (s1aq3b!= s1aq8b & s1aq3b!=. & s1aq8b!=.) | (s1aq4b!= s1aq6b & s1aq4b!=. & s1aq6b!=.)| (s1aq4b != s1aq7b & s1aq4b!=. & s1aq7b!=.) | (s1aq4b != s1aq8b & s1aq4b!=. & s1aq8b!=.)| (s1aq6b!= s1aq7b & s1aq6b!=. & s1aq7b!=.)| (s1aq6b != s1aq8b & s1aq6b!=. & s1aq8b!=.) | (s1aq7b != s1aq8b & s1aq7b!=. & s1aq8b!=.)

br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b s1aq5  if (s1aq3b != s1aq4b & s1aq3b!=. & s1aq4b!=.) |  (s1aq3b != s1aq6b & s1aq3b!=. & s1aq6b!=.) | (s1aq3b != s1aq7b & s1aq3b!=. & s1aq7b!=.)| (s1aq3b != s1aq8b & s1aq3b!=. & s1aq8b!=.)| (s1aq4b != s1aq6b & s1aq4b!=. & s1aq6b!=.)| (s1aq4b != s1aq7b & s1aq4b!=. & s1aq7b!=.)| (s1aq4b != s1aq8b & s1aq4b!=. & s1aq8b!=.)| (s1aq6b != s1aq7b & s1aq6b!=. & s1aq7b!=.)| (s1aq6b != s1aq8b & s1aq6b!=. & s1aq8b!=.)| (s1aq7b != s1aq8b & s1aq7b!=. & s1aq8b!=.)

gen asd2=1 if (s1aq3b!=s1aq4b & s1aq3b!=. & s1aq4b!=.) | (s1aq3b != s1aq6b & s1aq3b!=. & s1aq6b!=.) | (s1aq3b != s1aq7b & s1aq3b!=. & s1aq7b!=.) | (s1aq3b!= s1aq8b & s1aq3b!=. & s1aq8b!=.) | (s1aq4b != s1aq6b & s1aq4b!=. & s1aq6b!=.)| (s1aq4b != s1aq7b & s1aq4b!=. & s1aq7b!=.) | (s1aq4b!= s1aq8b & s1aq4b!=. & s1aq8b!=.) | (s1aq6b!= s1aq7b & s1aq6b!=. & s1aq7b!=.)| (s1aq6b != s1aq8b & s1aq6b!=. & s1aq8b!=.) | (s1aq7b!= s1aq8b & s1aq7b!=. & s1aq8b!=.)

gen jkl=1   if s1aq4b==0 & s1aq3a==s1aq4a & asd2==1
drop jkl 

gen jkl1=1  if s1aq4a>1000 & s1aq4a~=.
replace s1aq4a=s1aq3a   if jkl1==1 & (s1aq3a==s1aq6a & s1aq3b==s1aq6b)
replace s1aq4a=s1aq3a   if jkl1==1 & s1aq3a~=s1aq4a & s1aq3b==s1aq4b
recode s1aq3a s1aq4a s1aq6a (else=10)  if jkl1==1 & (s1aq1==179 & hid=="8110281136037")
recode s1aq3b s1aq4b s1aq6b (else=10)  if jkl1==1 & (s1aq1==179 & hid=="8110281136037")
replace s1aq6a=s1aq3a   if jkl1==1
replace s1aq6b=s1aq3b   if jkl1==1
drop jkl1 

order hid hhno quarter int_day int_month int_year lga district district1 area settlement settlement_name eanum select_hhold PT2_Sect_1 s1aq1 s1aq1_os s1aq2 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b 
drop hhsize-asd2

ta s1aq1,m
tab1 s1aq2-s1aq8b if s1aq1==.
drop if s1aq1==.   

numlabel,remove 

la var eanum     "EA number"
la var s1aq3a    "S1AQ3A - QUANTITY: How much in total the HH Consumed of the [ITEM] last 7 days"
la var s1aq3b    "S1AQ3B - [ITEM] Unit code"
la var s1aq4a    "S1AQ4A - QUANTITY: How much did the HH purchase of [ITEM] last 7 days"
la var s1aq4b    "S1AQ4B - [ITEM] Unit code"
la var s1aq5     "S1AQ5 - How much HH spent on [ITEM] the last 7 Days"
la var s1aq6a    "S1AQ6A - QUANTITY: How much consumption of [ITEM] came from purchases"
la var s1aq6b    "S1AQ6B - [ITEM] Unit code"
la var s1aq7a    "S1AQ7A - QUANTITY: How much consumption of [ITEM] came from own production"
la var s1aq7b    "S1AQ7B - [ITEM] Unit code"
la var s1aq8a    "S1AQ8A - QUANTITY: How much consumption of [ITEM] came from food gifts"
la var s1aq8b    "S1AQ8B - [ITEM] Unit code"

sort hid s1aq1

compress 
save "$temp\PART B Section 1A-Food_consumption expenditure-portion1_editted.dta", replace


********************************************************************************************************************************************************
********************************************************************************************************************************************************


