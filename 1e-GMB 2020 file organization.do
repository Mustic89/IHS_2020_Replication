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


cap log 1b GMB 2020 file organization nonfood
log using "$log\1b GMB 2020 file organization nonfood.log" , replace


********************************************************************************************************************************************************
********************************************************************************************************************************************************
******************* PART B NON-FOOD*******************
********************************************************************************************************************************************************
********************************************************************************************************************************************************


********************************************************************************
*** Sect 2 - NONFOOD EXPENDITURE

** Sect 2A - Nonfood last 7 days
use "$data\Original\Raw PART 2\SECT02AQ1Q2-NON-FOOD-LAST-7-DAYS.dta" , clear 
*use "C:\Users\wb102942\OneDrive - WBG\GBoS data\SECT02AQ1Q2-NON-FOOD-LAST-7-DAYS.dta" , clear 
count 
renvars,l
duplicates drop

ta s2aq1,m

sort settlement eanum select_hhold s2aq1

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

duplicates tag (settlement eanum select_hhold s2aq1),gen(dup)
ta dup
bys settlement eanum select_hhold s2aq1: gen countdup=_n
ta countdup 
drop if s2aq2==2 & s2aq3==. & dup==1 & countdup==2
drop dup 
duplicates tag (settlement eanum select_hhold s2aq1),gen(dup)
ta dup  //2 obs duplicates

renvars lga lga_name quarter district name_distr settlmnt_name area intervdate intervday intervmonth intervyear / lga1 lga_name1 quarter1 district2 name_distr1 settlmnt_name1 area1 intervdate1 intervday1 intervmonth1 intervyear1 

merge m:1 settlement eanum select_hhold using "$data\Stata\PART A Date of interview.dta"
ta _m 
br if dup==1 & countdup<=2
drop if dup==1 & countdup==1
ta s2aq1  if dup==1
drop dup 
drop if _m==1

gen PT2_Sect_2="PART 2 Section 2A"
la var PT2_Sect_2 "PART 2 Section 2A"
la var eanum    "EA number"

duplicates tag (settlement eanum select_hhold s2aq1),gen(dup)
ta dup

ta s2aq1,m
tab1 s2aq1-s2aq3 if s2aq1==.
drop if s2aq1==.  //209 obs

drop lga1 lga_name1 quarter1 district2 name_distr1 settlmnt_name1 area1 intervdate1 intervday1 intervmonth1 intervyear1 
drop intervcode-section_2a_non_food_last_seven_d select_hhold_dup countdup int_day int_month int_year yearmth year_mth _merge dup 

order hid lga quarter district district1 area settlement settlement_name eanum select_hhold PT2_Sect_2 

sort hid s2aq1

compress 
save "$data\Stata\PART B Section 2A-Nonfood last 7 days.dta", replace


** Sect 2B - Nonfood last 1 month
*use "$data\Original\Raw PART 2\SECT02AQ1Q2 - NON FOOD LAST 7 DAYS.dta" , clear 
use "C:\Users\wb102942\OneDrive - WBG\GBoS data\SECT02BQ1Q2 - NON FOOD LAST 1 MONTH.dta" , clear 
count 
renvars,l
duplicates drop

ta s2bq1,m

sort settlement eanum select_hhold s2bq1

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

duplicates tag (settlement eanum select_hhold s2bq1),gen(dup)
ta dup
bys settlement eanum select_hhold s2bq1: gen countdup=_n
ta countdup 
drop if s2bq2==2 & s2bq3==. & dup==1 & countdup==2
drop dup 
duplicates tag (settlement eanum select_hhold s2bq1),gen(dup)
ta dup  //20 obs
drop dup
duplicates tag (settlement eanum select_hhold s2bq1),gen(dup)
ta dup  //4 obs 

renvars lga lga_name quarter district name_distr settlmnt_name area intervdate intervday intervmonth intervyear / lga1 lga_name1 quarter1 district2 name_distr1 settlmnt_name1 area1 intervdate1 intervday1 intervmonth1 intervyear1 

merge m:1 settlement eanum select_hhold using "$data\Stata\PART A Date of interview.dta"
ta _m 
drop if _m==1   //these obs do not have roster

drop dup
duplicates tag (settlement eanum select_hhold s2bq1),gen(dup)
ta dup
drop if dup==1 & s2bq2==2 & s2bq3==.  //3 obs dropped 

gsort hid s2bq1 -s2bq3
drop countdup 
bys settlement eanum select_hhold s2bq1: gen countdup=_n
ta countdup 
drop if countdup==2  //keeping largest value of duplicate item in HH
drop dup 

gen PT2_Sect_2="PART 2 Section 2A"
la var PT2_Sect_2 "PART 2 Section 2A"
la var eanum    "EA number"

tab1 s2bq1-s2bq3 if s2bq1==.
drop if s2bq1==.  //209 obbs

drop lga1 lga_name1 quarter1 district2 name_distr1 settlmnt_name1 area1 intervdate1 intervday1 intervmonth1 intervyear1 
drop intervcode section_2b_non_food_last_1_month select_hhold_dup countdup int_day int_month int_year yearmth year_mth _merge
drop intervname-interview_status

order hid lga quarter district district1 area settlement settlement_name eanum select_hhold PT2_Sect_2

sort hid s2bq1

compress 
save "$data\Stata\PART B Section 2B-Nonfood last 1 month.dta", replace


** Sect 2C - Nonfood 3 months
*use "$data\Original\Raw PART 2\SECT02CQ1Q2 - NON FOOD LAST 3 MNTHS.dta" , clear 
use "C:\Users\wb102942\OneDrive - WBG\GBoS data\SECT02CQ1Q2 - NON FOOD LAST 3 MNTHS.dta" , clear 
count 
renvars,l
duplicates drop

ta s2cq1,m

sort settlement eanum select_hhold s2cq1

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

duplicates tag (settlement eanum select_hhold s2cq1),gen(dup)
ta dup  //524
bys settlement eanum select_hhold s2cq1: gen countdup=_n
ta countdup 
drop if s2cq2==2 & s2cq3==. & dup==1 & countdup==2  //264 obs dropped
drop dup 
duplicates tag (settlement eanum select_hhold s2cq1),gen(dup)
ta dup  //14 obs

renvars lga lga_name quarter district name_distr settlmnt_name area intervdate intervday intervmonth intervyear / lga1 lga_name1 quarter1 district2 name_distr1 settlmnt_name1 area1 intervdate1 intervday1 intervmonth1 intervyear1 

merge m:1 settlement eanum select_hhold using "$data\Stata\PART A Date of interview.dta"
ta _m 
drop if _m==1   //these obs do not have roster

drop dup
duplicates tag (settlement eanum select_hhold s2cq1),gen(dup)
ta dup
drop if dup==1 & s2cq2==2 & s2cq3==.  //5 obs dropped 

gsort hid s2cq1 -s2cq3
drop countdup 
bys settlement eanum select_hhold s2cq1: gen countdup=_n
ta countdup 
drop if countdup==2  //2 deleted keeping largest value of duplicate item in HH
drop dup 

gen PT2_Sect_2="PART 2 Section 2C"
la var PT2_Sect_2 "PART 2 Section 2C"
la var eanum    "EA number"

drop lga1 lga_name1 quarter1 district2 name_distr1 settlmnt_name1 area1 intervdate1 intervday1 intervmonth1 intervyear1 
drop intervcode select_hhold_dup countdup int_day int_month int_year yearmth year_mth _merge intervname-section_2c_non_food_last_3_month

ta s2cq1,m
tab1 s2cq2 s2qcq1_os s2cq3 if s2cq1==.
drop if s2cq1==.

order hid lga quarter district district1 area settlement settlement_name eanum select_hhold PT2_Sect_2

sort hid s2cq1

compress 
save "$data\Stata\PART B Section 2C-Nonfood last 3 months.dta", replace


** Sect 2D - Nonfood 12 months
*use "$data\Original\Raw PART 2\SECT02DQ1Q2 - NONFOOD LAST 12 MNTHS.dta" , clear 
use "C:\Users\wb102942\OneDrive - WBG\GBoS data\SECT02DQ1Q2 - NONFOOD LAST 12 MNTHS.dta" , clear 
count 
renvars,l
duplicates drop

ta s2dq1,m

sort settlement eanum select_hhold s2dq1

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

duplicates tag (settlement eanum select_hhold s2dq1),gen(dup)
ta dup  //974
bys settlement eanum select_hhold s2dq1: gen countdup=_n
ta countdup 
drop if s2dq2==2 & s2dq3==. & dup==1 & countdup==2  //475 obs dropped
drop dup 
duplicates tag (settlement eanum select_hhold s2dq1),gen(dup)
ta dup  //24 obs
drop if s2dq2==2 & s2dq3==. & countdup==1
drop dup 
duplicates tag (settlement eanum select_hhold s2dq1),gen(dup)
ta dup //4 obs

renvars lga lga_name quarter district name_distr settlmnt_name area intervdate intervday intervmonth intervyear / lga1 lga_name1 quarter1 district2 name_distr1 settlmnt_name1 area1 intervdate1 intervday1 intervmonth1 intervyear1 

merge m:1 settlement eanum select_hhold using "$data\Stata\PART A Date of interview.dta"
ta _m 
drop if _m==1   //these obs do not have roster

drop dup 
duplicates tag (settlement eanum select_hhold s2dq1),gen(dup)
ta dup //4 obs

gsort hid s2dq1 -s2dq3
drop countdup 
bys settlement eanum select_hhold s2dq1: gen countdup=_n
ta countdup 
drop if countdup==2  //keep larger value

gen PT2_Sect_2="PART 2 Section 2D"
la var PT2_Sect_2 "PART 2 Section 2D"
la var eanum    "EA number"

drop lga1 lga_name1 quarter1 district2 name_distr1 settlmnt_name1 area1 intervdate1 intervday1 intervmonth1 intervyear1 
drop intervcode-section_2d_non_food_last_12_mont int_day-countdup select_hhold_dup

ta s2dq1,m
tab1 s2dq1-s2dq3 if s2dq1==.
drop if s2dq1==.  //804 obbs

order hid lga quarter district district1 area settlement settlement_name eanum select_hhold PT2_Sect_2

sort hid s2dq1

compress 
save "$data\Stata\PART B Section 2D-Nonfood last 12 months.dta ", replace


********************************************************************************
*** Sect 3 - AGRIC HOLDING

** Section 3A - Agric holding
use "$data\Original\Raw PART 2\SECT03AQ1Q2 - AGRIC HOLDING.dta" , clear 
*use "C:\Users\wb102942\OneDrive - WBG\GBoS data\SECT03AQ1Q2 - AGRIC HOLDING.dta" , clear 
count 
renvars,l
duplicates drop

sort settlement eanum select_hhold s3aq1

ta s3aq1
drop if s3aq1==2

la define s3aq1  1 "Yes"  2 "No",replace 
la val s3aq1 s3aq1 

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

duplicates tag (settlement eanum select_hhold s3aq2),gen(dup)
ta dup
bys settlement eanum select_hhold: gen s3aq2_ID=_n  //will help fix duplicate plot details 

drop lga lga_name quarter district name_distr settlmnt_name area intervdate- primarylast section_3a_agriculture_holding select_hhold_dup dup

replace rec_type="PART 2 Section 3A"

merge m:1 settlement eanum select_hhold using "$data\Stata\PART A Date of interview.dta"
ta _m 
drop if _m==1   //no infor from roster

sort hid s3aq1
bys hid: gen countdup=_n 
replace s3aq1=.  if countdup>1
replace s3aq1=2  if _m==2
ta s3aq1 

replace rec_type="PART 2 Section 3A"
la var rec_type "PART 2 Section 3A"
ren rec_type PT2_Sect_3

la var eanum   		"EA number"
la var s3aq2    	"S3AQ2 - Parcel_Plot ID"
la var s3aq2_ID 	"S3AQ2_ID - Parcel_Plot ID (corrected)"

order hid lga quarter district district1 area settlement settlement_name eanum select_hhold PT2_Sect_3 s3aq1 s3aq2 s3aq2_ID 
drop s3aq_any_mor_plots- _merge

sort hid s3aq1 s3aq2_ID

compress 
save "$data\Stata\PART B Section 3A-Agriculture holding.dta", replace


** Sect 3B - Crop production
use "$data\Original\Raw PART 2\SECT03BQ1Q2- CROP PRODUCTION.dta" , clear 
*use "C:\Users\wb102942\OneDrive - WBG\GBoS data\SECT03BQ1Q2- CROP PRODUCTION.dta" , clear 
count 
renvars,l
duplicates drop

sort settlement eanum select_hhold s3bq1

ta s3bq1

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

duplicates tag (settlement eanum select_hhold s3bq2),gen(dup)
ta dup
bys settlement eanum select_hhold s3bq2: gen countdup=_n  //will help fix duplicate plot details 
ta dup 
drop if countdup==2 
drop dup countdup

drop lga-name_distr settlmnt_name area intervdate- interview_status s3b_group3b select_hhold_dup

merge m:1 settlement eanum select_hhold using "$data\Stata\PART A Date of interview.dta"
ta _m 
drop if _m==1   //no infor from roster

bys settlement eanum select_hhold: gen countdup=_n 
ta countdup 
replace s3bq1=1  if s3bq2~=.
replace s3bq1=.  if s3bq1==1 & countdup>1
replace s3bq1=2  if _m==2
replace s3bq1=2  if s3bq1==. & s3bq2==. & s3bq3==. & s3bq4==. & s3bq5==. & s3bq6==. & s3bq7==. & s3bq8==. & s3bq9==. & s3bq10==. & s3bq11==.
ta s3bq1 

gen PT2_Sect_3="PART 2 Section 3B"
la var PT2_Sect_3 "PART 2 Section 3B"
la var eanum    "EA number"

order hid lga quarter district district1 area settlement settlement_name eanum select_hhold PT2_Sect_3 s3bq1 
drop int_day-countdup

sort hid s3bq1 s3bq2

compress 
save "$data\Stata\PART B Section 3B-Crop production.dta", replace


** Sect 3C - Crop processing 
use "$data\Original\Raw PART 2\SECT03CQ1Q2-PROCESSING OF AGRI PRODUCTS.dta" , clear 
*use "C:\Users\wb102942\OneDrive - WBG\GBoS data\SECT03CQ1Q2-PROCESSING OF AGRI PRODUCTS.dta" , clear 
count 
renvars,l
duplicates drop

sort settlement eanum select_hhold s3cq1

ta s3cq1

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

duplicates tag (settlement eanum select_hhold s3cq2),gen(dup)
ta dup
bys settlement eanum select_hhold s3cq2: gen countdup=_n  //will help fix duplicate plot details 
ta countdup  //cannot drop if =2 because HH can process same crop in different ways
drop dup countdup

drop lga- name_distr settlmnt_name area intervdate- interview_status s3c_group3c select_hhold_

merge m:1 settlement eanum select_hhold using "$data\Stata\PART A Date of interview.dta"
ta _m 
drop if _m==1   //no infor from roster

bys settlement eanum select_hhold: gen countdup=_n 
ta countdup 
replace s3cq1=.  if s3cq1==1 & countdup>1
replace s3cq1=2  if _m==2
replace s3cq1=2  if s3cq1==. & countdup==1 
replace s3cq1=.  if s3cq1==2 & countdup==2
ta s3cq1 

gen PT2_Sect_3="PART 2 Section 3C"
la var PT2_Sect_3 "PART 2 Section 3C"
la var eanum    "EA number"

order hid lga quarter district district1 area settlement settlement_name eanum select_hhold PT2_Sect_3 s3cq1 
drop int_day-countdup

sort hid s3cq1 s3cq2

compress 
save "$data\Stata\PART B Section 3C-Processing agricultural produce.dta", replace


** Sect 3D - Crop costs 
use "$data\Original\Raw PART 2\IHS2_SECT3D_Crop costs" , clear 
*use "C:\Users\wb102942\OneDrive - WBG\GBoS data\IHS2_SECT3D_Crop costs.dta" , clear 
count 
renvars,l
duplicates drop

sort settlement eanum select_hhold s3dq1

ta s3dq1

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

duplicates tag (settlement eanum select_hhold s3dq2),gen(dup)
ta dup
bys settlement eanum select_hhold s3dq2: gen countdup=_n  //will help fix duplicate plot details 
ta dup 
drop if countdup==2 
drop dup countdup

drop lga-name_distr settlmnt_name area intervdate- interview_status s3d_group3d select_hhold_dup

merge m:1 settlement eanum select_hhold using "$data\Stata\PART A Date of interview.dta"
ta _m 
drop if _m==1   //no infor from roster

bys settlement eanum select_hhold: gen countdup=_n 
ta countdup 
replace s3dq1=1  if s3dq2~=.
replace s3dq1=.  if s3dq1==1 & countdup>1
replace s3dq1=2  if _m==2
replace s3dq1=2  if s3dq1==. & s3dq2==. & s3dq3==. & s3dq4==. & s3dq5a==. & s3dq5b==. & s3dq6==. & s3dq7==. & s3dq8==. 
ta s3dq1 

gen PT2_Sect_3="PART 2 Section 3D"
la var PT2_Sect_3 "PART 2 Section 3D"
la var eanum    "EA number"

order hid lga quarter district district1 area settlement settlement_name eanum select_hhold PT2_Sect_3 s3dq1 
drop int_day-countdup

sort hid s3dq1 s3dq2

compress 
save "$data\Stata\PART B Section 3D-Agricultural costs-crops.dta", replace


** Sect 3E - Livestock ownership 
use "$data\Original\Raw PART 2\IHS2_SECT3E-Livestock.dta" , clear 
*use "C:\Users\wb102942\OneDrive - WBG\GBoS data\IHS2_SECT3E-Livestock.dta" , clear 
count 
renvars,l
duplicates drop

sort settlement eanum select_hhold s3eq1

ta s3eq1

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

duplicates tag (settlement eanum select_hhold s3eq2),gen(dup)
ta dup
bys settlement eanum select_hhold s3eq2: gen countdup=_n  //will help fix duplicate plot details 
ta countdup 
drop if countdup==2 
drop dup countdup

drop lga-name_distr settlmnt_name area intervdate- interview_status s3e select_hhold_dup

merge m:1 settlement eanum select_hhold using "$data\Stata\PART A Date of interview.dta"
ta _m 
drop if _m==1   //no infor from roster

bys settlement eanum select_hhold: gen countdup=_n 
ta countdup 
replace s3eq1=1  if s3eq2~=.
replace s3eq1=.  if s3eq1==1 & countdup>1
replace s3eq1=2  if _m==2
replace s3eq1=2  if s3eq1==. & s3eq2==. & s3eq3==. & s3eq5==. & s3eq4a==. & s3eq4b==. & s3eq4c==. & s3eq6==. & s3eq7==. & s3eq8==. & s3eq9==.
ta s3eq1 

gen PT2_Sect_3="PART 2 Section 3E"
la var PT2_Sect_3 "PART 2 Section 3E"
la var eanum    "EA number"

order hid lga quarter district district1 area settlement settlement_name eanum select_hhold PT2_Sect_3 s3eq1 
drop int_day-countdup tot_livestock tot_livestock1

sort hid s3eq1 s3eq2

compress 
save "$data\Stata\PART B Section 3E-Livestock ownership.dta ", replace


** Sect 3F - Livestock and Fishing inputs 
use "$data\Original\Raw PART 2\IHS2_SECT3F-Livestock costs.dta" , clear 
*use "C:\Users\wb102942\OneDrive - WBG\GBoS data\IHS2_SECT3F-Livestock costs.dta" , clear 
count 
renvars,l
duplicates drop

sort settlement eanum select_hhold s3fq1

ta s3fq1

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

duplicates tag (settlement eanum select_hhold s3fq2),gen(dup)
ta dup
bys settlement eanum select_hhold s3fq2: gen countdup=_n  //will help fix duplicate plot details 
ta countdup 
drop if countdup==2 
drop dup countdup

drop lga-name_distr settlmnt_name area intervdate- interview_status s3f_group3f select_hhold_dup

merge m:1 settlement eanum select_hhold using "$data\Stata\PART A Date of interview.dta"
ta _m 
drop if _m==1   //no infor from roster

bys settlement eanum select_hhold: gen countdup=_n 
ta countdup 
replace s3fq1=1  if s3fq2~=.
replace s3fq1=.  if s3fq1==1 & countdup>1
replace s3fq1=2  if _m==2
replace s3fq1=2  if s3fq1==. & s3fq2==. & s3fq3==. & s3fq4==. & s3fq5a==. & s3fq5b==. & s3fq6==. & s3fq7==. & s3fq8==. 
ta s3fq1 

replace rec_type="PART 2 Section 3F"
ren rec_type PT2_Sect_3

order hid lga quarter district district1 area settlement settlement_name eanum select_hhold PT2_Sect_3 s3fq1 
drop int_day-countdup

sort hid s3fq1 s3fq2

compress 
save "$data\Stata\PART B Section 3F-Agricultural costs-livestock_fishing.dta ", replace


********************************************************************************
*** Sect 4 - HOUSEHOLD INCOME 

** Sect 4A - Household income 
use "$data\Original\Raw PART 2\IHS2_SECT4A-Income.dta" , clear 
*use "C:\Users\wb102942\OneDrive - WBG\GBoS data\IHS2_SECT4A-Income.dta" , clear 
count 
renvars,l
duplicates drop

sort settlement eanum select_hhold s4aq1

ta s4aq1

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

duplicates tag (settlement eanum select_hhold s4aq1),gen(dup)
ta dup
bys settlement eanum select_hhold s4aq1: gen countdup=_n  //will help fix duplicate plot details 
ta countdup 
drop if countdup==2 
drop dup countdup

drop lga-name_distr settlmnt_name area intervdate- interview_status section_4a_household_income select_hhold_dup

merge m:1 settlement eanum select_hhold using "$data\Stata\PART A Date of interview.dta"
ta _m 
drop if _m==1   //no infor from roster

bys settlement eanum select_hhold: gen countdup=_n 
ta countdup 

gen PT2_Sect_4="PART 2 Section 4A"
la var PT2_Sect_4 "PART 2 Section 4A"
la var eanum    "EA number"

order hid lga quarter district district1 area settlement settlement_name eanum select_hhold PT2_Sect_4 s4aq1 
drop int_day-countdup

drop if s4aq1==.  //213 HHs did not respond

sort hid s4aq1

compress 
save "$data\Stata\PART B Section 4A-Household income.dta", replace


** Sect 4B - Miscellaneous income 
use "$data\Original\Raw PART 2\IHS2_SECT4B-Miscellaneous income.dta" , clear 
*use "C:\Users\wb102942\OneDrive - WBG\GBoS data\IHS2_SECT4B-Miscellaneous income.dta" , clear 
count 
renvars,l
duplicates drop

sort settlement eanum select_hhold 

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

drop lga-name_distr settlmnt_name area intervdate- interview_status select_hhold_dup

duplicates tag (settlement eanum select_hhold),gen(dup)
bys settlement eanum select_hhold: gen countdup=_n
drop if countdup==2
drop countdup

merge m:1 settlement eanum select_hhold using "$data\Stata\PART A Date of interview.dta"
ta _m 
drop if _m==1   //no infor from roster

bys settlement eanum select_hhold: gen countdup=_n 
ta countdup 
drop if countdup==2

ta s4bq1,m 
tab1 s4bq2a-s4bq9b if s4bq1==.
replace s4bq1=2   if s4bq1==.

gen PT2_Sect_4="PART 2 Section 4B"
la var PT2_Sect_4 "PART 2 Section 4B"
la var eanum    "EA number"

order hid lga quarter district district1 area settlement settlement_name eanum select_hhold PT2_Sect_4  
drop int_day-countdup dup

sort hid 

compress 
save "$data\Stata\PART B Section 4B-Miscellaneous income.dta", replace


** Sect 4C - Miscellaneous expenditures 
use "$data\Original\Raw PART 2\IHS2_SECT4C-Miscellaneous Expenditures.dta" , clear 
*use "C:\Users\wb102942\OneDrive - WBG\GBoS data\IHS2_SECT4C-Miscellaneous Expenditures.dta" , clear 
count 
renvars,l
duplicates drop

sort settlement eanum select_hhold 

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

drop lga-name_distr settlmnt_name area intervdate- interview_status select_hhold_dup

merge m:1 settlement eanum select_hhold using "$data\Stata\PART A Date of interview.dta"
ta _m 
drop if _m==1   //no infor from roster

bys settlement eanum select_hhold: gen countdup=_n 
ta countdup 
drop if countdup==2

ta s4cq1,m 
tab1 s4cq2a-s4cq6b if s4cq1==.
replace s4cq1=2   if s4cq1==.

gen PT2_Sect_4="PART 2 Section 4C"
la var PT2_Sect_4 "PART 2 Section 4C"
la var eanum    "EA number"

order hid lga quarter district district1 area settlement settlement_name eanum select_hhold PT2_Sect_4  
drop int_day-countdup

sort hid 

compress 
save "$data\Stata\PART B Section 4C-Miscellaneous expenditures.dta ", replace


********************************************************************************
*** Sect 5 - NON-AGRICULTURAL HOUSEHOLD ENTERPRISES 

use "$data\Original\Raw PART 2\IHS2_SECT5-Enterprise.dta" , clear 
*use "C:\Users\wb102942\OneDrive - WBG\GBoS data\IHS2_SECT5-Enterprise.dta" , clear 
count 
renvars,l
duplicates drop

sort settlement eanum select_hhold s5q3

ta s5q3

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

duplicates tag (settlement eanum select_hhold s5q3),gen(dup)
ta dup
bys settlement eanum select_hhold s5q3: gen countdup=_n  //will help fix duplicate plot details 
ta countdup 
drop if countdup==2 
drop dup countdup

drop lga-name_distr settlmnt_name area intervdate- interview_status s5_group select_hhold_dup

merge m:1 settlement eanum select_hhold using "$data\Stata\PART A Date of interview.dta"
ta _m 
drop if _m==1   //no infor from roster

bys settlement eanum select_hhold: gen countdup=_n 
ta countdup 

replace s5q1=1   if s5q3~=.
replace s5q1=.   if s5q1==1 & countdup>1
replace s5q1=2   if _m==2
replace s5q1=2   if countdup==1 & s5q1==.
ta s5q1 

gen PT2_Sect_5="PART 2 Section 5"
la var PT2_Sect_5 "PART 2 Section 5"
la var eanum    "EA number"

order hid lga quarter district district1 area settlement settlement_name eanum select_hhold PT2_Sect_5 s5q1 s5q2_1 s5q2_2 
drop int_day-countdup

sort hid s5q1

compress 
save "$data\Stata\PART B Section 5-Household enterprise.dta", replace


********************************************************************************************************************************************************
********************************************************************************************************************************************************
