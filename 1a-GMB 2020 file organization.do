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


cap log GMB 2020 file organization Part A
log using "$log\GMB 2020 file organization Part A.log" , replace


********************************************************************************************************************************************************
********************************************************************************************************************************************************
******************* PART A INDIVIDUAL and HOUSEHOLD *******************
********************************************************************************************************************************************************
********************************************************************************************************************************************************

********************************************************************************
**** INDIVIDUAL - Section 1,2, 3, 4, 6 

*** Section 2 - Roster
use "C:\Users\wb102942\OneDrive - WBG\Desktop\hhdbase\GMB\IHS2020\Data\Original\Raw PART 1\IHS1 -  Hhold Roster.dta", clear
count 
renvars,l
count
duplicates drop
duplicates tag (settlement eanum select_hhold s1q1),gen(dup)  //check duplicate IDs.  11208
drop dup

clonevar select_hhold_dup  = select_hhold
//Household head name: MODOU BOYE
replace select_hhold = 100 if eanum == 63229 & select_hhold_dup == 11 & intervdate == 12022020
//Household head name: FARAMBA SANYANG
replace select_hhold = 100 if eanum == 75104 & select_hhold_dup == 85 & intervdate == 15072020
//Household head name: MALANG NJIE
replace select_hhold = 111 if eanum == 75104 & select_hhold_dup == 91 & intervdate == 18082020

duplicates tag ( settlement eanum select_hhold s1q1),gen(dup)
drop dup

replace settlement=35125  if settlement==1    & lga==3 & eanum==35115
replace settlement=75101  if settlement==12   & lga==7 & eanum==75106
replace settlement=70109  if settlement==70   & lga==7 & eanum==70113
replace settlement=41210  if settlement==4012 & lga==4 & eanum==41204
replace settlement=43115  if settlement==4311 & lga==4 & eanum==43108
drop select_hhold_dup

*use "$data\Stata\DataPART1\Hhold Roster.dta" , clear  //test file

label define lga 1 "Banjul"  2 "Kanifing"  3 "Brikama" 4 "Mansakonko"  5 "Kerewan"  ///
	6 "Kuntaur"  7 "Janjangbureh"  8 "Basse", modify
la val lga lga 

ta lga_name 
ta lga_name lga 
drop lga_name  //drop this as not useful

la define quarter  1 "Quarter 1"  2 "Quarter 2"  3 "Quarter 3"  4 "Quarter 4",replace 
la val quarter quarter

clonevar district1=district
replace district1=10   if district<=12
replace district1=20   if district>=20 & district<30
ta district1
ta district1 district
la define district1   10 "Banjul City Council"  20 "Kanifing Municipal Council"   /// 
  30 "Kombo North"  31 "Kombo South"  32 "Kombo Central"  33 "Kombo East"  34 "Foni Brefet"  ///
  35 "Foni Bintang Karanai"  36 "Foni Kansala"  37 "Foni Bondali"  38 "Foni Jarrol"  ///
  40 "Kiang West"  41 "Kiang Central"  42 "Kiang East"  43 "Jarra West"  44 "Jarra Central"  45 "Jarra East"  ///  
  50 "Lower Niumi"  51 "Upper Niumi"  52 "Jokadu"  53 "Lower Badibu"  54 "Central Badibu"  55 "Illiasa"  56 "Sabach Sanjar"  ///  
  60 "Lower Saloum"  61 "Upper Saloum"  62 "Nianija"  63 "Niani"  64 "Sami"  ///
  70 "Niamina Dankunku"  71 "Niamina West"  72 "Niamina East"  73 "Lower Fuladu West"  74 "Upper Fuladu West"  75 "Janjanbureh"  /// 
  80 "Jimara"  81 "Basse"  82 "Tumana"  83 "Kantora"  84 "Wuli West"  85 "Wuli East"  86 "Sandu", modify   
la val district1 district1  

la define district  10 "Banjul South"  11 "Banjul Central"  12 "Banjul North"  ///
	20 "Bakau"  21 "New Jeshwang"  22 "Sere Kunda Central"  23 "Sere Kunda East"  24 "Sere Kunda West"  ///  
	30 "Kombo North"  31 "Kombo South"  32 "Kombo Central"  33 "Kombo East"  34 "Foni Brefet"   ///
	35 "Foni Bintang Karanai"  36 "Foni Kansala"  37 "Foni Bondali"  38 "Foni Jarrol"  /// 
	40 "Kiang West"  41 "Kiang Central"  42 "Kiang East"  43 "Jarra West"  44 "Jarra Central"  45 "Jarra East"  /// 
	50 "Lower Niumi"  51 "Upper Niumi"  52 "Jokadu"  53 "Lower Badibu"  54 "Central Badibu"  55 "Illiasa"  56 "Sabach Sanjar"  ///
	60 "Lower Saloum"  61 "Upper Saloum"  62 "Nianija"  63 "Niani"  64 "Sami"  ///
	70 "Niamina Dankunku"  71 "Niamina West"  72 "Niamina East"  73 "Lower Fuladu West"  74 "Upper Fuladu West"  75 "Janjanbureh"  ///  
	80 "Jimara"  81 "Basse"  82 "Tumana"  83 "Kantora"  84 "Wuli West"  85 "Wuli East"  86 "Sandu", modify 
la val district district

drop name_distr //not useful 

drop s1q2  //name of respondent

la define area 1 "Urban"  2 "Rural", modify
la val area area 

la define more_hh_members 1 "Yes"  2 "No",modify 
la val more_hh_members more_hh_members

ta intervday intervmonth
 
ta intervyear,m 
ta intervmonth intervyear
replace intervyear=2021  if intervyear==2018 // That is probably an error because the survey was carry out fron February 2020 to January 2021

replace rec_type="PART 1 Section 1"
la var rec_type "PART 1 Section 1"

gen hid= string(int( settlement ),"%05.0f") + string(int( eanum ),"%05.0f") + string(int( select_hhold ),"%03.0f" ),before(lga)

la var quarter 			"Quarter"
la var lga              "Local Governemnt Area"
la var district         "District"
la var district1        "District (level of aggregation for analyses)"
la var settlement       "Settlement"
la var area             "Area"
la var eanum            "Eunumeration area" 
la var select_hhold     "Household number"
la var hid              "Unique HH identifier"
la var s1q1 			"S1Q1 - Member ID"
la var s1q3  			"S1Q3 - Sex"
la var s1q5a			"S1Q5A - [NAME] got a birth certificate from the Registrar's Office"
la var s1q5b			"S1Q5B - If not, what is the main reason?"
la var s1q6				"S1Q6 - What is [NAME]'s Relationship to Household Head"
la var s1q7				"S1Q7 - What is [NAME]'s Nationality (citizenship)?"
la var s1q8				"S1Q8 - What is [NAME]'s Ethinicity?"
la var other_s1q8 	    "S1Q8 - OTHER Ethnicity"
la var s1q17    		"S1Q17 - [NAME]'s Father industry of occupation"
la var s1q23    		"S1Q23 - [NAME]'s Mother industry of occupation"
la var more_hh_members	"Are there any other household member"
la var rec_type 		"PART A Section 1"


order hid lga quarter district district1 area settlement settlmnt_name eanum select_hhold rec_type
ren rec_type PT1_Sect_1
ren settlmnt_name settlement_name

sort hid s1q1 
ren s1q1 idnum 

compress 
save "$temp\Roster_0.dta", replace 


drop intervdate-interview_status number_of_hhold_members
ta s1q5_years  //one negative value. 10 Missing ages
replace s1q5_years = abs(s1q5_years)
gen valid=1
compress 
save "$temp\Roster.dta", replace 


********************************************************************************
*** Date of interview
use "$temp\Roster_0.dta", clear

keep if idnum==1

keep hid quarter lga district district1 settlement settlement_name area eanum select_hhold interview_status intervday intervmonth intervyear
tostring intervmonth,gen(int_month) format (%02.0f)
tostring intervyear,gen(int_year)  format (%04.0f)

egen yearmth=concat(int_year int_month)
destring yearmth,replace

gen hyphen="-"
egen year_mth=concat(int_year hyphen int_month)
drop hyphen

la var eanum    	"EA number"
la var year_mth		"Month and year merged (string)"
la var yearmth 		"Month and year merged into one variable for analysis ease"   

drop int_month int_year

renvars intervday intervmonth intervyear / int_day int_month int_year

ta int_month quarter
li hid if quarter==1 & int_month==5  //peruse 
replace quarter=2  if quarter==1 & int_month==5

sort hid  

compress 
save "$data\Stata\PART A Date of interview.dta", replace  


********************************************************************************
*** COVER - not for public 
use "$temp\Roster_0.dta", clear
keep if idnum==1
keep hid lga quarter district district1 settlement_name area eanum select_hhold intervname field_supervisor field_supervisor_name telephon1 telephon2 telephon3 interview_start_time interview_start_hours interview_start_minutes interview_end_time interview_end_hours interview_end_minutes interview_status
compress 
save "$data\Stata\PART A Sec 0 Cover not for public.dta", replace 


********************************************************************************
*** SECTION 2 - HEALTH
use "$data\Original\Raw PART 1\IHS1 - sect2a - Health for all the Hhold Members.dta" , clear 
count 
renvars,l
count
duplicates drop
duplicates tag (settlement eanum select_hhold idnum),gen(dup)  //check duplicate IDs.  11208
ta dup 
drop dup 

clonevar select_hhold_dup  = select_hhold
//Household head name: MODOU BOYE
replace select_hhold = 100 if eanum == 63229 & select_hhold_dup == 11 & (name=="MODOU BOYE" | name=="IDA SECKA" | name=="MOD SARR" | name=="ALAGIE KEBBA SECKA" | name=="ISATOU BOYE" | name=="BABUCARR BOYE")
//Household head name: FARAMBA SANYANG
replace select_hhold = 100 if eanum == 75104 & select_hhold_dup == 85 & (name=="FARAMBA SANYANG" | name=="DANDANG DAMPHA" | name=="MUSA DARBOE" | name=="DANDANG JAMMEH" | name=="KADDY DARBOE")
//Household head name: MALANG NJIE
replace select_hhold = 111 if eanum == 75104 & select_hhold_dup == 91 & (name=="MALANG NJIE" | name=="MAMA TOURAY" | name=="SAINEY NJIE" | name=="SANNA NJIE" | name=="SARJO NJIE" | name=="DAWDA NJIE" | name=="SULAYMAN NJIE" | name=="SARJO NJIE")

duplicates tag ( settlement eanum select_hhold idnum),gen(dup)
ta dup 
drop if dup==1
drop dup

replace settlement=35125  if settlement==1    & lga==3 & eanum==35115
replace settlement=75101  if settlement==12   & lga==7 & eanum==75106
replace settlement=70109  if settlement==70   & lga==7 & eanum==70113
replace settlement=41210  if settlement==4012 & lga==4 & eanum==41204
replace settlement=43115  if settlement==4311 & lga==4 & eanum==43108
drop select_hhold_dup lga- district settlmnt_name area

gen PT1_Sect_2="PART 1 Section 2"
la var PT1_Sect_2 "PART 1 Section 2"

drop name sex age name_distr

order settlement eanum select_hhold PT1_Sect_2
sort settlement eanum select_hhold idnum 

la var s2aq2         		"S2AQ2 - For the last two weeks has [NAME] been sick/injured?"
la var s2aq3_main    		"S2AQ3_MAIN - During the last 2 weeks, what symptoms has [NAME] suffered from?"
la var other_s2aq3_main		"S2AQ3 - OTHER main illness [NAME] suffered from last 2 weeks"
la var s2aq3_second			"S2AQ3_SECOND - During the last 2 weeks, what symptoms has [NAME] suffered from?"
la var s2aq4_main       	"S2AQ4_MAIN - Did [NAME] consult health provider for illness/injury last 2 weeks"
la var s2aq4_second     	"S2AQ4_SECOND - Did [NAME] consult health provider for illness/injury last 2 weeks"
la var s2aq5_main       	"S2AQ5_MAIN - Main reason [NAME] did not visit a health provider"
la var other_s2aq5_second 	"S2AQ5 - OTHER Main reason [NAME] did not visit a health provider"
la var s2aq6_second  		"S2AQ6_SECOND - Last 2 weeks who diagnosed [NAME]'s sickness/injury?"
la var s2aq7 				"S2AQ7 - Days last 2 weeks was [NAME] too ill not to do usual activities"
la var s2aq8 				"S2AQ8 - Did [NAME] visit health provider for any other health related reason"
la var s2aq9				"S2AQ9 - What was the reason for [NAME]'s visit?"
la var s2aq10 				"S2AQ10 - What type of facility did [NAME] visit?"
la var s2aq11				"S2AQ11 - Where is the location of facility visited by [NAME]?"
la var s2aq12				"S2AQ12 - Wistance from [NAME]'s house to health care facility visited?"
la var s2aq13				"S2AQ13 - How long did [NAME] take to travel for the consultation?"
la var s2aq14				"S2AQ14 - What was the main mode of transport to the facility used by [NAME]?"
la var other_s2aq14			"S2AQ14 - OTHER mode of transport to facility used by [NAME]?"
la var s2aq15 				"S2AQ15 - How much did [NAME] pay to travel to the health care facility?"
la var s2aq16				"S2AQ16 - How long did [NAME] wait for the services to be rendered?"
la var s2aq17				"S2AQ17 - Was [NAME] satisfied with the service offered?"
la var s2aq18a				"S2AQ18A - First reason [NAME] not satisfied with the health provider services?"
la var other_s2aq18a		"S2AQ18A - OTHER first reason [NAME] was not satisfied with the provider?"
la var s2aq18b				"S2AQ18B - Second reason [NAME] not satisfied with the health provider services"
la var other_s2aq18b		"S2AQ18B - OTHER second reason [NAME] not satisfied with the health provider services"
la var s2aq18c 				"S2AQ18C - Third reason [NAME] not satisfied with the health provider services?"
la var other_s2aq18c 		"S2AQ18C - OTHER third main reason why name was not satisfied with the provider?"
la var s2aq19				"S2AQ19 - Did [NAME] pay for the health care services provided?"
la var s2aq20a  			"S2AQ20A - Consultations"
la var s2aq20b				"S2AQ20B - Dental fees"
la var s2aq20c				"S2AQ20C - injection"
la var s2aq20d 				"S2AQ20D - lab fees"
la var s2aq20e				"S2AQ20E - X-ray"
la var s2aq20f				"S2Aq20F - Scanning"
la var s2aq20g				"S2AQ20G - Ambulance services"
la var s2aq20h				"S2AQ20H - Child birth/delivery"
la var s2aq20i				"S2AQ20I - Immunization"
la var s2aq20j 				"S2AQ20J - Medicines (Prescriptions and over-the counter)"
la var s2aq20k				"S2AQ20K - Other charges"
la var s2aq20l				"S2AQ20L - Total expenditure"
renvars s2aq24_1 other_s2aq24_1 s2aq24_2 other_s2aq24_2 / s2aq24_main other_s2aq24_main s2aq24_second other_s2aq24_second
la var s2aq24_main			"S2AQ24_MAIN - Main reason for by passing the facility nearest household"
la var other_s2aq24_main	"S2AQ24_MAIN - OTHER main reason for by passing the facility nearest household"
la var s2aq24_second		"S2AQ24_SECOND - Second reason for by passing the facility nearest household"
la var other_s2aq24_second	"S2AQ24_SECOND - OTHER second reason for by passing the facility nearest household"
la var s2aq27_medical_facility "S2AQ27A - Hospitalisation (medical facility)"
la var s2aq27_traditional_healer "S2AQ27B - Hospitalisation (traditional healer)" 
renvars s2aq27_medical_facility s2aq27_traditional_healer / s2aq27a s2aq27b

compress 
save "$temp\Health_2a.dta", replace


use "$data\Original\Raw PART 1\IHS1 - Sect2c - Disability.dta" , clear 
count 
renvars,l
count
duplicates drop
duplicates tag (settlement eanum select_hhold idnum),gen(dup)  //check duplicate IDs.  11208
ta dup 
drop dup 

clonevar select_hhold_dup  = select_hhold
//Household head name: MODOU BOYE
replace select_hhold = 100 if eanum == 63229 & select_hhold_dup == 11 & (name=="MODOU BOYE" | name=="IDA SECKA" | name=="MOD SARR" | name=="ALAGIE KEBBA SECKA" | name=="ISATOU BOYE" | name=="BABUCARR BOYE")
//Household head name: FARAMBA SANYANG
replace select_hhold = 100 if eanum == 75104 & select_hhold_dup == 85 & (name=="FARAMBA SANYANG" | name=="DANDANG DAMPHA" | name=="MUSA DARBOE" | name=="DANDANG JAMMEH" | name=="KADDY DARBOE")
//Household head name: MALANG NJIE
replace select_hhold = 111 if eanum == 75104 & select_hhold_dup == 91 & (name=="MALANG NJIE" | name=="MAMA TOURAY" | name=="SAINEY NJIE" | name=="SANNA NJIE" | name=="SARJO NJIE" | name=="DAWDA NJIE" | name=="SULAYMAN NJIE" | name=="SARJO NJIE")

duplicates tag ( settlement eanum select_hhold idnum),gen(dup)
ta dup 
drop dup

replace settlement=35125  if settlement==1    & lga==3 & eanum==35115
replace settlement=75101  if settlement==12   & lga==7 & eanum==75106
replace settlement=70109  if settlement==70   & lga==7 & eanum==70113
replace settlement=41210  if settlement==4012 & lga==4 & eanum==41204
replace settlement=43115  if settlement==4311 & lga==4 & eanum==43108

drop lga-name_distr settlmnt_name area intervdate- number_of_hhold_members name sex age s1q5_months select_hhold_dup s2cmoree 

order settlement eanum select_hhold 
sort settlement eanum select_hhold idnum 
 
compress 
save "$temp\Health_2c.dta", replace 


use "$data\Original\Raw PART 1\IHS1 - SECT2D - SMOKING.dta" , clear 
count 
renvars,l
count
duplicates drop
duplicates tag (settlement eanum select_hhold idnum),gen(dup)  //check duplicate IDs.  11208
ta dup 
drop dup 

clonevar select_hhold_dup  = select_hhold
//Household head name: MODOU BOYE
replace select_hhold = 100 if eanum == 63229 & select_hhold_dup == 11 & (name=="MODOU BOYE" | name=="IDA SECKA" | name=="MOD SARR" | name=="ALAGIE KEBBA SECKA" | name=="ISATOU BOYE" | name=="BABUCARR BOYE")
//Household head name: FARAMBA SANYANG
replace select_hhold = 100 if eanum == 75104 & select_hhold_dup == 85 & (name=="FARAMBA SANYANG" | name=="DANDANG DAMPHA" | name=="MUSA DARBOE" | name=="DANDANG JAMMEH" | name=="KADDY DARBOE")
//Household head name: MALANG NJIE
replace select_hhold = 111 if eanum == 75104 & select_hhold_dup == 91 & (name=="MALANG NJIE" | name=="MAMA TOURAY" | name=="SAINEY NJIE" | name=="SANNA NJIE" | name=="SARJO NJIE" | name=="DAWDA NJIE" | name=="SULAYMAN NJIE" | name=="SARJO NJIE")

duplicates tag ( settlement eanum select_hhold idnum),gen(dup)
ta dup 
drop dup

replace settlement=35125  if settlement==1    & lga==3 & eanum==35115
replace settlement=75101  if settlement==12   & lga==7 & eanum==75106
replace settlement=70109  if settlement==70   & lga==7 & eanum==70113
replace settlement=41210  if settlement==4012 & lga==4 & eanum==41204
replace settlement=43115  if settlement==4311 & lga==4 & eanum==43108

drop lga-name_distr settlmnt_name area intervdate- number_of_hhold_members name sex age select_hhold_dup

order settlement eanum select_hhold 
sort settlement eanum select_hhold idnum 

compress 
save "$temp\Health_2d.dta", replace 


use "$data\Original\Raw PART 1\IHS1 - SECT2E - CHILD HEALTH.dta" , clear 
count 
gen valid=1
renvars,l
count
duplicates drop
duplicates tag (settlement eanum select_hhold idnum),gen(dup)  //check duplicate IDs.  11208
ta dup 
drop dup 

clonevar select_hhold_dup  = select_hhold
//Household head name: MODOU BOYE
replace select_hhold = 100 if eanum == 63229 & select_hhold_dup == 11 & (name=="MODOU BOYE" | name=="IDA SECKA" | name=="MOD SARR" | name=="ALAGIE KEBBA SECKA" | name=="ISATOU BOYE" | name=="BABUCARR BOYE")
//Household head name: FARAMBA SANYANG
replace select_hhold = 100 if eanum == 75104 & select_hhold_dup == 85 & (name=="FARAMBA SANYANG" | name=="DANDANG DAMPHA" | name=="MUSA DARBOE" | name=="DANDANG JAMMEH" | name=="KADDY DARBOE")
//Household head name: MALANG NJIE
replace select_hhold = 111 if eanum == 75104 & select_hhold_dup == 91 & (name=="MALANG NJIE" | name=="MAMA TOURAY" | name=="SAINEY NJIE" | name=="SANNA NJIE" | name=="SARJO NJIE" | name=="DAWDA NJIE" | name=="SULAYMAN NJIE" | name=="SARJO NJIE")

duplicates tag ( settlement eanum select_hhold idnum),gen(dup)
ta dup 
drop if dup==1

replace settlement=35125  if settlement==1    & lga==3 & eanum==35115
replace settlement=75101  if settlement==12   & lga==7 & eanum==75106
replace settlement=70109  if settlement==70   & lga==7 & eanum==70113
replace settlement=41210  if settlement==4012 & lga==4 & eanum==41204
replace settlement=43115  if settlement==4311 & lga==4 & eanum==43108

drop lga lga_name quarter district name_distr settlmnt_name area intervdate- number_of_hhold_members name sex age s1q5_months dup select_hhold_dup valid rec_type

la var s2eq4  		"S2EQ4 - Date of birth of Child (day/month/year)"
la var s2eq6  		"S2EQ6 - Type of Facility [NAME] was delivered"
la var s2eq5  		"S2EQ5 - Where was [NAME] delivered"
la var other_s2eq5  "S2EQ5 - OTHER places of Delivery specified"
la var s2eq7        "S2EQ7 - Who assisted in birth of [NAME]"
la var other_s2eq7  "S2EQ7 - OTHERS who assisted in birth of [NAME], specified?"
la var s2eq8        "S2EQ8 - Has [NAME] ever been breastfed?"
la var s2eq9        "S2EQ9 - Is [NAME] currently breastfeeding"
la var s2eq10       "S2EQ10 - How long was [NAME] breastfeeding (months)"
la var s2eq11       "S2EQ11 - How many months was [NAME] exclusively breastfed (months)"
la var s2eq12       "S2EQ12 - Participation in Community Nutrition Programs"
la var s2eq13       "S2EQ13 - Participation in SAM + NAM Programs"
la var s2eq14       "S2EQ14 - Participation in deworming programs"
la var s2eq15       "S2EQ15 - Participation in anemia Programs"
la var s2eq16       "S2EQ16 - Participation in Growth Monitoring Clinic"
la var s2eq17       "S2EQ17 - Have a vaccination card/paper"
la var s2eq18       "S2EQ18 - BCG Vaccine against Tuberculosis"
la var s2eq19       "S2EQ19 - BCG Scar on the left hand"
la var s2eq20       "S2EQ20 - Polio Vaccine taken"
la var s2eq21       "S2EQ21 - Age when First polio vaccine given (months)"
la var s2eq22       "S2EQ22 - Polio vaccine frequency since given first Dose (number)"
la var s2eq23       "S2EQ23 - Any Tetanus, Whooping Cough and DPT vaccine given"
la var s2eq24       "S2EQ24 - How many times DPT doses given (number)"
la var s2eq25       "S2EQ25 - Was Measles Vaccinations given at 9 mnths Age"

tab1 s2eq3-s2eq25 if idnum==.
drop if idnum==.

order settlement eanum select_hhold 
sort settlement eanum select_hhold idnum 
 
compress 
save "$temp\Health_2e.dta", replace 


use "$data\Original\Raw PART 1\IHS1 - SECT2F - FACILITY.dta" , clear 
count 
renvars,l
count
duplicates drop
duplicates tag (settlement eanum select_hhold idnum),gen(dup)  //check duplicate IDs.  11208
ta dup 
drop if dup==1 & idnum==.
drop dup 

ren s2fq2 name 

clonevar select_hhold_dup  = select_hhold
//Household head name: MODOU BOYE
replace select_hhold = 100 if eanum == 63229 & select_hhold_dup == 11 & (name=="MODOU BOYE" | name=="IDA SECKA" | name=="MOD SARR" | name=="ALAGIE KEBBA SECKA" | name=="ISATOU BOYE" | name=="BABUCARR BOYE")
//Household head name: FARAMBA SANYANG
replace select_hhold = 100 if eanum == 75104 & select_hhold_dup == 85 & (name=="FARAMBA SANYANG" | name=="DANDANG DAMPHA" | name=="MUSA DARBOE" | name=="DANDANG JAMMEH" | name=="KADDY DARBOE")
//Household head name: MALANG NJIE
replace select_hhold = 111 if eanum == 75104 & select_hhold_dup == 91 & (name=="MALANG NJIE" | name=="MAMA TOURAY" | name=="SAINEY NJIE" | name=="SANNA NJIE" | name=="SARJO NJIE" | name=="DAWDA NJIE" | name=="SULAYMAN NJIE" | name=="SARJO NJIE")

duplicates tag ( settlement eanum select_hhold idnum),gen(dup)
ta dup 
drop dup

tab1 s2fq3- s2fq18a  if sex==.
drop if sex==.

replace settlement=35125  if settlement==1    & lga==3 & eanum==35115
replace settlement=75101  if settlement==12   & lga==7 & eanum==75106
replace settlement=70109  if settlement==70   & lga==7 & eanum==70113
replace settlement=41210  if settlement==4012 & lga==4 & eanum==41204
replace settlement=43115  if settlement==4311 & lga==4 & eanum==43108

drop lga- name_distr settlmnt_name area name_distr rec_type intervdate- number_of_hhold_members sex age select_hhold_dup name

order settlement eanum select_hhold 
sort settlement eanum select_hhold idnum 

compress 
save "$temp\Health_2f.dta", replace 


use "$temp\Health_2a.dta",clear 
merge 1:1 settlement eanum select_hhold idnum using "$temp\Health_2c.dta"
drop _merge
merge 1:1 settlement eanum select_hhold idnum using "$temp\Health_2d.dta"
drop _m 
merge 1:1 settlement eanum select_hhold idnum using "$temp\Health_2e.dta" 
drop _m 
merge 1:1 settlement eanum select_hhold idnum using "$temp\Health_2f.dta"
drop _m 

sort settlement eanum select_hhold idnum 
 
compress 
save "$temp\Health_all_sections.dta", replace 


********************************************************************************
*** SECTION 3 - EDUCATION 
use "$data\Original\Raw PART 1\IHS1 - SECT3A - Education General.dta" , clear 
count 
renvars,l
duplicates drop
ren s3aq1 idnum 
duplicates tag (settlement eanum select_hhold idnum),gen(dup)  //check duplicate IDs.  11208
ta dup 
drop dup 

ren s3aq1_name name 

clonevar select_hhold_dup  = select_hhold
//Household head name: MODOU BOYE
replace select_hhold = 100 if eanum == 63229 & select_hhold_dup == 11 & (name=="MODOU BOYE" | name=="IDA SECKA" | name=="MOD SARR" | name=="ALAGIE KEBBA SECKA" | name=="ISATOU BOYE" | name=="BABUCARR BOYE")
//Household head name: FARAMBA SANYANG
replace select_hhold = 100 if eanum == 75104 & select_hhold_dup == 85 & (name=="FARAMBA SANYANG" | name=="DANDANG DAMPHA" | name=="MUSA DARBOE" | name=="DANDANG JAMMEH" | name=="KADDY DARBOE")
//Household head name: MALANG NJIE
replace select_hhold = 111 if eanum == 75104 & select_hhold_dup == 91 & (name=="MALANG NJIE" | name=="MAMA TOURAY" | name=="SAINEY NJIE" | name=="SANNA NJIE" | name=="SARJO NJIE" | name=="DAWDA NJIE" | name=="SULAYMAN NJIE" | name=="SARJO NJIE")

duplicates tag ( settlement eanum select_hhold idnum),gen(dup)
ta dup 
drop if dup==1 & idnum==.  //all infor missing 
drop dup

drop lga-name_distr settlmnt_name area intervdate-number_of_hhold_members name select_hhold_dup

replace rec_type="PART 1 Section 3"
la var rec_type "PART 1 Section 3"

order settlement eanum select_hhold rec_type
ren rec_type PT1_Sect_3
sort settlement eanum select_hhold idnum  

compress 
save "$temp\Education_general.dta", replace 


use "$data\Original\Raw PART 1\IHS1 - Sect3B - Education Expenditure.dta" , clear 
count 
renvars,l
duplicates drop
ren s3bq1 idnum 
duplicates tag (settlement eanum select_hhold idnum),gen(dup)  //check duplicate IDs.  11208
ta dup 
drop dup 

ren s3bq2 name 

clonevar select_hhold_dup  = select_hhold
//Household head name: MODOU BOYE
replace select_hhold = 100 if eanum == 63229 & select_hhold_dup == 11 & (name=="MODOU BOYE" | name=="IDA SECKA" | name=="MOD SARR" | name=="ALAGIE KEBBA SECKA" | name=="ISATOU BOYE" | name=="BABUCARR BOYE")
//Household head name: FARAMBA SANYANG
replace select_hhold = 100 if eanum == 75104 & select_hhold_dup == 85 & (name=="FARAMBA SANYANG" | name=="DANDANG DAMPHA" | name=="MUSA DARBOE" | name=="DANDANG JAMMEH" | name=="KADDY DARBOE")
//Household head name: MALANG NJIE
replace select_hhold = 111 if eanum == 75104 & select_hhold_dup == 91 & (name=="MALANG NJIE" | name=="MAMA TOURAY" | name=="SAINEY NJIE" | name=="SANNA NJIE" | name=="SARJO NJIE" | name=="DAWDA NJIE" | name=="SULAYMAN NJIE" | name=="SARJO NJIE")

duplicates tag ( settlement eanum select_hhold idnum),gen(dup)
ta dup 
drop if dup==1 & idnum==.  //all infor missing 
drop dup

drop lga-name_distr settlmnt_name area intervdate-number_of_hhold_members name select_hhold_dup rec_type

la var s3bq3 "S3BQ3 - Sch and Registation Fees"
la var s3bq5 "S3BQ5 - Uniforms and Sports clothes"
la var other_s3bq15 "S3BQ15 - OTHER people responsible for Education Expenses"

order settlement eanum select_hhold 
sort settlement eanum select_hhold idnum 

compress 
save "$temp\Education_expenditure.dta", replace 


use "$data\Original\Raw PART 1\IHS1 - SECT3C - LITERACY.dta" , clear 
count 
renvars,l
duplicates drop
ren s3cq1 idnum 
duplicates tag (settlement eanum select_hhold idnum),gen(dup)  //check duplicate IDs.  11208
ta dup 
drop dup 

ren s3cq2 name 

clonevar select_hhold_dup  = select_hhold
//Household head name: MODOU BOYE
replace select_hhold = 100 if eanum == 63229 & select_hhold_dup == 11 & (name=="MODOU BOYE" | name=="IDA SECKA" | name=="MOD SARR" | name=="ALAGIE KEBBA SECKA" | name=="ISATOU BOYE" | name=="BABUCARR BOYE")
//Household head name: FARAMBA SANYANG
replace select_hhold = 100 if eanum == 75104 & select_hhold_dup == 85 & (name=="FARAMBA SANYANG" | name=="DANDANG DAMPHA" | name=="MUSA DARBOE" | name=="DANDANG JAMMEH" | name=="KADDY DARBOE")
//Household head name: MALANG NJIE
replace select_hhold = 111 if eanum == 75104 & select_hhold_dup == 91 & (name=="MALANG NJIE" | name=="MAMA TOURAY" | name=="SAINEY NJIE" | name=="SANNA NJIE" | name=="SARJO NJIE" | name=="DAWDA NJIE" | name=="SULAYMAN NJIE" | name=="SARJO NJIE")

duplicates tag ( settlement eanum select_hhold idnum),gen(dup)
ta dup 
drop if dup==1 & idnum==.  //all infor missing 
drop dup

drop lga-name_distr settlmnt_name area intervdate-number_of_hhold_members name select_hhold_dup rec_type

order settlement eanum select_hhold 
sort settlement eanum select_hhold idnum 

compress 
save "$temp\Education_3c.dta", replace 


use "$data\Original\Raw PART 1\IHS1 - SECT3D - TRAINING.dta" , clear 
count 
renvars,l
duplicates drop
ren s3dq1 idnum 
duplicates tag (settlement eanum select_hhold idnum),gen(dup)  //check duplicate IDs.  11208
ta dup 
drop dup 

ren s3dq2 name 

clonevar select_hhold_dup  = select_hhold
//Household head name: MODOU BOYE
replace select_hhold = 100 if eanum == 63229 & select_hhold_dup == 11 & (name=="MODOU BOYE" | name=="IDA SECKA" | name=="MOD SARR" | name=="ALAGIE KEBBA SECKA" | name=="ISATOU BOYE" | name=="BABUCARR BOYE")
//Household head name: FARAMBA SANYANG
replace select_hhold = 100 if eanum == 75104 & select_hhold_dup == 85 & (name=="FARAMBA SANYANG" | name=="DANDANG DAMPHA" | name=="MUSA DARBOE" | name=="DANDANG JAMMEH" | name=="KADDY DARBOE")
//Household head name: MALANG NJIE
replace select_hhold = 111 if eanum == 75104 & select_hhold_dup == 91 & (name=="MALANG NJIE" | name=="MAMA TOURAY" | name=="SAINEY NJIE" | name=="SANNA NJIE" | name=="SARJO NJIE" | name=="DAWDA NJIE" | name=="SULAYMAN NJIE" | name=="SARJO NJIE")

duplicates tag ( settlement eanum select_hhold idnum),gen(dup)
ta dup 
drop if dup==1 & idnum==.  //all infor missing 
drop dup

drop lga-name_distr settlmnt_name area intervdate-number_of_hhold_members name select_hhold_dup rec_type

la var s3dq11   "S3DQ11A-J - List of all skills learnt (max 3)"
la var s3dq11a  "S3DQ11A - Soap making"
la var s3dq11b  "S3DQ11B - Tie & dye/batik"
la var s3dq11c  "S3DQ11C - Sewing"
la var s3dq11d  "S3DQ11D - Mechanical work"
la var s3dq11e  "S3DQ11E - Carpentry"
la var s3dq11f  "S3DQ11F - Masonry"
la var s3dq11g  "S3DQ11G - Food processing"
la var s3dq11h  "S3DQ11H - Agriculture"
la var s3dq11i  "S3DQ11I - Hair dressing"
la var s3dq11j  "S3DQ11J - Welding & fabrication"
la var s3dq11x  "S3DQ11X - Other"

order settlement eanum select_hhold 
sort settlement eanum select_hhold idnum 

order settlement-s3dq11i s3dq11x other_s3dq11

compress 
save "$temp\Education_3d.dta", replace


*** merge files 
use "$temp\Education_general.dta",clear 
merge 1:1 settlement eanum select_hhold idnum using "$temp\Education_expenditure.dta"
drop _m 
merge 1:1 settlement eanum select_hhold idnum using "$temp\Education_3c.dta"
drop _m 
merge 1:1 settlement eanum select_hhold idnum using "$temp\Education_3d.dta",
drop _m 
sort settlement eanum select_hhold idnum  

compress 
save "$temp\Education_all_sections.dta", replace 


********************************************************************************
*** SECTION 4 - Labour
use "$data\Original\Raw PART 1\IHS1 - Sect4A - Labour Force PARTicipation",clear 
count 
renvars,l
duplicates drop
ren s4aq1 idnum 
duplicates tag (settlement eanum select_hhold idnum),gen(dup)  //check duplicate IDs.  11208
ta dup 
drop dup 

ren s4aq1_name name 

clonevar select_hhold_dup  = select_hhold
//Household head name: MODOU BOYE
replace select_hhold = 100 if eanum == 63229 & select_hhold_dup == 11 & (name=="MODOU BOYE" | name=="IDA SECKA" | name=="MOD SARR" | name=="ALAGIE KEBBA SECKA" | name=="ISATOU BOYE" | name=="BABUCARR BOYE")
//Household head name: FARAMBA SANYANG
replace select_hhold = 100 if eanum == 75104 & select_hhold_dup == 85 & (name=="FARAMBA SANYANG" | name=="DANDANG DAMPHA" | name=="MUSA DARBOE" | name=="DANDANG JAMMEH" | name=="KADDY DARBOE")
//Household head name: MALANG NJIE
replace select_hhold = 111 if eanum == 75104 & select_hhold_dup == 91 & (name=="MALANG NJIE" | name=="MAMA TOURAY" | name=="SAINEY NJIE" | name=="SANNA NJIE" | name=="SARJO NJIE" | name=="DAWDA NJIE" | name=="SULAYMAN NJIE" | name=="SARJO NJIE")

duplicates tag ( settlement eanum select_hhold idnum),gen(dup)
ta dup 
drop dup

drop lga name_distr settlmnt_name area name select_hhold_dup lga_name quarter district

ren emp* s4q*
ren other_emp4 other_s4q4
ren other_emp7 other_s4q7
ren other_emp8 other_s4q8

replace rec_type="PART 1 Section 4"
ren rec_type PT1_Sect_4
la var PT1_Sect_4 "PART 1 Section 4" 

la var s4q7		"EMP7 - Kind of efforts [NAME] put into finding a job?"
la var s4q7a	"EMP7A - Submitted credentials to recruitment agency"
la var s4q7b    "EMP7B - Contacted friends/relatives"
la var s4q7c    "EMP7C - Responded to advertisment"
la var s4q7d    "EMP7D - Contacted the employer"
la var s4q7e    "EMP7E - Tried to start own business"
la var s4q7f    "EMP7F - Took PART in a job test"
la var s4q7x    "EMP7X - Other (specify)"

order settlement eanum select_hhold PT1_Sect_4
sort settlement eanum select_hhold idnum 

compress 
save "$temp\labour.dta", replace


********************************************************************************
*** SECTION 6 - DECISION MAKING
use "$data\Original\Raw PART 1\\IHS1 - Sect6 - Decision Making.dta" ,clear
count 
renvars,l
duplicates drop
ren s6q1 idnum 
duplicates tag (settlement eanum select_hhold idnum),gen(dup)  //check duplicate IDs.  11208
ta dup 
drop dup 

ren s6q2 name 

clonevar select_hhold_dup  = select_hhold
//Household head name: MODOU BOYE
replace select_hhold = 100 if eanum == 63229 & select_hhold_dup == 11 & (name=="MODOU BOYE" | name=="IDA SECKA" | name=="MOD SARR" | name=="ALAGIE KEBBA SECKA" | name=="ISATOU BOYE" | name=="BABUCARR BOYE")
//Household head name: FARAMBA SANYANG
replace select_hhold = 100 if eanum == 75104 & select_hhold_dup == 85 & (name=="FARAMBA SANYANG" | name=="DANDANG DAMPHA" | name=="MUSA DARBOE" | name=="DANDANG JAMMEH" | name=="KADDY DARBOE")
//Household head name: MALANG NJIE
replace select_hhold = 111 if eanum == 75104 & select_hhold_dup == 91 & (name=="MALANG NJIE" | name=="MAMA TOURAY" | name=="SAINEY NJIE" | name=="SANNA NJIE" | name=="SARJO NJIE" | name=="DAWDA NJIE" | name=="SULAYMAN NJIE" | name=="SARJO NJIE")

duplicates tag ( settlement eanum select_hhold idnum),gen(dup)
ta dup 
replace idnum=1   if s6q4a~=. & dup==1
drop if dup==1 & idnum==.

drop lga-name_distr settlmnt_name area intervdate-number_of_hhold_members name select_hhold_dup dup 

duplicates tag ( settlement eanum select_hhold idnum),gen(dup)
ta dup
tab1 s6q3-s6q10 if idnum==.
drop if idnum==.
drop dup

duplicates tag ( settlement eanum select_hhold idnum),gen(dup)
ta dup

replace s6q3=2 if dup==1 
drop if dup==1 & s6q5==.
drop dup

replace rec_type="PART 1 Section 6"
la var rec_type "PART 1 Section 6"

la var s6q4  "S6Q4 - List of all household items purchased"
la var s6q4a "S6Q4A - House"
la var s6q4b "S6Q4B - Land"
la var s6q4c "S6Q4C - Car"
la var s6q4d "S6Q4D - Household Appliances"
la var s6q4e "S6Q4E - Livestock"
la var s6q4f "S6Q4F - Boat/canoe"
la var s6q4x "S6Q4F - Other major household item"

order settlement eanum select_hhold rec_type 
ren rec_type PT1_Sect_6
sort settlement eanum select_hhold idnum 

compress 
save "$temp\decision_making.dta", replace


********************************************************************************
//test if can merge

use "$temp\Roster.dta",clear 
merge 1:1 settlement eanum select_hhold idnum using "$temp\Health_all_sections.dta"
drop _m 
merge 1:1 settlement eanum select_hhold idnum using "$temp\Education_all_sections.dta"
drop _m 
merge 1:1 settlement eanum select_hhold idnum using "$temp\labour.dta"
drop _merge 
merge 1:1 settlement eanum select_hhold idnum using "$temp\decision_making.dta"
ta _m 
drop _merge quarter

keep if valid==1
drop valid

drop if hid=="4410644110015" & idnum==10  //wrong entry after looking through HH data 
drop if hid=="3210232156012"  //all infor missing for this HH
 
*replace s1q5_years=98   if s1q5_years==99 & s1q4b<9000
*replace s1q5_years=99   if s1q5_years==98 & s1q4a==98 & s1q4b==9998

sort hid idnum 

compress 
save "$data\Stata\PART A Section 1_2_3_4_6-Individual level.dta", replace


********************************************************************************
*** SECTION 5 - HOUSEHOLD SHOCKS
use "$data\Original\Raw PART 1\IHS1 - SECT5 - HHOLD SHOCKS.dta" , clear 
count 
renvars,l
duplicates drop
duplicates tag (settlement eanum select_hhold),gen(dup)  //check duplicate IDs.  11208
ta dup 
drop dup 
 
clonevar select_hhold_dup  = select_hhold
//Household head name: MODOU BOYE
replace select_hhold = 100 if eanum == 63229 & select_hhold_dup == 11 & intervdate == 12022020
//Household head name: FARAMBA SANYANG
replace select_hhold = 100 if eanum == 75104 & select_hhold_dup == 85 & intervdate == 15072020
//Household head name: MALANG NJIE
replace select_hhold = 111 if eanum == 75104 & select_hhold_dup == 91 & intervdate == 18082020

duplicates tag ( settlement eanum select_hhold),gen(dup)
ta dup
drop if dup==1 & s5q1a==.
drop dup

replace settlement=35125  if settlement==1    & lga==3 & eanum==35115
replace settlement=75101  if settlement==12   & lga==7 & eanum==75106
replace settlement=70109  if settlement==70   & lga==7 & eanum==70113
replace settlement=41210  if settlement==4012 & lga==4 & eanum==41204
replace settlement=43115  if settlement==4311 & lga==4 & eanum==43108

drop lga name_distr settlmnt_name area name_distr intervdate- number_of_hhold_members lga name_distr lga_name quarter district

order settlement eanum select_hhold 
sort settlement eanum select_hhold 

tab1 s5q1a-s5q18b  if s5q1==""
drop if s5q1==""  //all missing 

merge 1:1 settlement eanum select_hhold using "$data\Stata\PART A Date of interview.dta"
ta _m 

tab1 s5q1a-s5q18b  if _m==1
drop if _m==1

sort hid 
order hid lga quarter district district1 area settlement settlement_name eanum select_hhold rec_type 

replace rec_type="PART 1 Section 5"
la var rec_type "PART 1 Section 5"
ren rec_type PT1_Sect_5

drop select_hhold_dup-_merge

la var  eanum   	"EA number"
la var	s5q1a		"S5Q1A - Serious illness or accident of a member of the household"
la var	s5q1b		"S5Q1B - Death of a member of the household"
la var	s5q1c		"S5Q1C - Divorce"
la var	s5q1d		"S5Q1D - Separation"
la var	s5q1e		"S5Q1E - Drought/Irregular rain"
la var	s5q1f		"S5Q1F - Floods"
la var	s5q1g		"S5Q1G - Fire outbreak"
la var	s5q1h		"S5Q1H - Loss / Decrease of harvests"
la var	s5q1i		"S5Q1I - High rate of crop diseases"
la var	s5q1j		"S5Q1J - High rate of animal diseases"
la var	s5q1k		"S5Q1K - Significant drop in prices of agricultural products"
la var	s5q1l		"S5Q1L - High prices of agricultural inputs"
la var	s5q1m		"S5Q1M - High prices of food products"
la var	s5q1n		"S5Q1N - Regular transfers from other household members stopped"
la var	s5q1o		"S5Q1O - Significant loss of HH non-farm income (not due to accident or illness)"
la var	s5q1p		"S5Q1P - Bankruptcy of a non-agricultural household business"
la var	s5q1q		"S5Q1Q - Significant loss of salary income (not due to accident or illness)"
la var	s5q1r		"S5Q1R - Loss of paid employment of a member"
la var	s5q1s		"S5Q1S - Theft of money, property, crops or livestock"
la var	s5q1t		"S5Q1T - Farmer/breeder conflict"
la var	s5q1u		"S5Q1U - Armed Conflict/violence/insecurity"
la var	s5q1v		"S5Q1V - Locust attacks or other crop pests"
la var	s5q1w		"S5Q1W - Loss of family support/abandonment of family support"
la var	s5q1x		"S5Q1X - Remittances from the diaspora stopped"
la var	s5q1y		"S5Q1Y - Family violence"
la var	s5q1z		"S5Q1Z - Other (specify)"
la var	s5q1_9		"S5Q1_9 - None"
la var	other_s5q1	"S5Q1_9 - OTHER shocks that have had an economic impact on household"
la var	s5q2_1		"S5Q2_1 - Shocks - most important"
la var	s5q2_2		"S5Q2_2 - Shocks - second important"
la var	s5q2_3		"S5Q2_3 - Shocks - third important"
la var	s5q3		"S5Q3 - For the three main shocks listed in 5.2, indicate main strategy adopted"
la var	s5q3a		"S5Q3A - Help from relatives or friends"
la var	s5q3b		"S5Q3B - Government/State aid"
la var	s5q3c		"S5Q3C - Help from religious organizations or NGOs"
la var	s5q3d		"S5Q3D - Children given out for marriage"
la var	s5q3e		"S5Q3E - Children under 15 started working"
la var	s5q3f		"S5Q3F - Children dropped out of school"
la var	s5q3g		"S5Q3G - Entrusting children to other households"
la var	s5q3h		"S5Q3H - Change of consumption habits (reduction of the number of meals per day)"
la var	s5q3i		"S5Q3I - Purchase of cheaper foods"
la var	s5q3j		"S5Q3J - Reduction of health/education expenses"
la var	s5q3k		"S5Q3K - Employed household members took additional jobs"
la var	s5q3l		"S5Q3L - Adult members (at least 15) inactive or unemployed have taken jobs"
la var	s5q3m		"S5Q3M - Using your savings"
la var	s5q3n		"S5Q3N - Getting a credit"
la var	s5q3o		"S5Q3O - Rent/give land as collateral"
la var	s5q3p		"S5Q3P - Sale of agricultural assets"
la var	s5q3q		"S5Q3Q - Sale of household durable goods"
la var	s5q3r		"S5Q3R - Sale of household durable goods"
la var	s5q3s		"S5Q3S - Sale of food stocks"
la var	s5q3t		"S5Q3T - Sale of livestock"
la var	s5q3u		"S5Q3U - More practice of fishing activities"
la var	s5q3v		"S5Q3V - Practice of off-season cultivation"
la var	s5q3w		"S5Q3W - Engaged in spiritual activities (prayers/sacrifices/marabout)"
la var	s5q3x		"S5Q3X - Migration of household members"
la var	s5q3y		"S5Q3Y - Other strategy (specify)"
la var	s5q3z		"S5Q3Z - No strategy"
la var	other_s5q3	"S5Q3 OTHER - OTHER main strategy adopted by the household to address the shock"
la var	s5q4		"S5Q4 -  Over the last 5 years, shock(s) which impacted HH permanently"
la var	s5q5		"S5Q5 - What was the shock that had had an economic impact on your household?"
la var	s5q5a		"S5Q5A - Serious illness or accident of a member of the household"
la var	s5q5b		"S5Q5B - Death of a member of the household"
la var	s5q5c		"S5Q5C - Divorce"
la var	s5q5d		"S5Q5D - Separation"
la var	s5q5e		"S5Q5E - Drought/irregular rain"
la var	s5q5f		"S5Q5F - Floods"
la var	s5q5g		"S5Q5G - Fire outbreak"
la var	s5q5h		"S5Q5H - Loss/decrease of harvests"
la var	s5q5i		"S5Q5I - High rate of crop diseases"
la var	s5q5j		"S5Q5J - High rate of animal diseases"
la var	s5q5k		"S5Q5K - Significant drop in prices of agricultural products"
la var	s5q5l		"S5Q5L - High prices of agricultural inputs"
la var	s5q5m		"S5Q5M - High prices of food products"
la var	s5q5n		"S5Q5N - Regular transfers from other household members stopped"
la var	s5q5o		"S5Q5O - Loss of household non-farm income (not due to accident or illness)"
la var	s5q5p		"S5Q5P - Bankruptcy of a non-agricultural household business"
la var	s5q5q		"S5Q5Q - Significant loss of salary income (not due to accident or illness)"
la var	s5q5r		"S5Q5R - Loss of paid employment of a member"
la var	s5q5s		"S5Q5S - Theft of money, property, crops or livestock"
la var	s5q5t		"S5Q5T - Farmer/breeder conflict"
la var	s5q5u		"S5Q5U - Armed Conflict/violence/insecurity"
la var	s5q5v		"S5Q5V - Locust attacks or other crop pests"
la var	s5q5w		"S5Q5W - Loss of family support/abandonment of family support"
la var	s5q5x		"S5Q5X - Remittances from the diaspora stopped"
la var	s5q5y		"S5Q5Y - Family violence"
la var	s5q5z		"S5Q5Z - Other (specify)"
la var	other_s5q5	"S5Q5Z OTHER - OTHER shocks that have had an economic impact on your household"
la var	s5q6		"S5Q6 - Any members of your household who have died/disappeared on migratory trip"
la var	s5q7		"S5Q7 - How many members?"
la var	s5q8		"S5Q8 - Did any member of your household skip a meal due to lack of funds?"
la var	s5q9		"S5Q9 - How many times did at least one member of HH skip a meal?"
la var	s5q11		"S5Q11 - Worried you would not have enough food to eat due to lack of funds"
la var	s5q12		"S5Q12 - Unable to eat healthy/nutritious food due to lack of money/resources?"
la var	s5q13		"S5Q13 - You ate few kinds of foods due to lack of money/resources?"
la var	s5q14		"S5Q14 - You skip a meal because not enough money/resources to get food?"
la var	s5q15		"S5Q15 - Last 12 months, you ate less because of a lack of money/resources?"
la var	s5q16		"S5Q16 - Did household ran out of food because of a lack of money/resources?"
la var	s5q16a		"S5Q16A - Past 4 weeks, HH ran out of food due to lack of money/resources?"
la var	s5q16b		"S5Q16B - How often did this happen in the past 4 weeks (30 days)?"
la var	s5q17		"S5Q17 - Hungry but did not eat because not enough money/resources for food?"
la var	s5q17a		"S5Q17A - Past 4 weeks, did not eat because not enough money/resources for food?"
la var	s5q18		"S5Q18 - You went without eating for a whole day because lack of money/resources?"
la var	s5q18a		"S5Q18A - Past 4 weeks, went without eating all day because lack money/resources?"
la var	s5q18b		"S5Q18B - How often did this happen in the past 4 weeks?"

drop if hid=="3210232156012"  //all infor missing for this HH in roster

compress 
save "$data\Stata\PART A Section 5-Household Shocks.dta", replace


********************************************************************************
*** SECTION 7 - ACCESS TO CREDIT

** Sect 7A - Credit received
use "$data\Original\Raw PART 1\IHS1 - SECT7A - Credit Received.dta" , clear 
count 
renvars,l
duplicates drop

ta s7aq1,m
 
clonevar select_hhold_dup  = select_hhold
//Household head name: MODOU BOYE
replace select_hhold = 100 if eanum == 63229 & select_hhold_dup == 11 & intervdate == 12022020
//Household head name: FARAMBA SANYANG
replace select_hhold = 100 if eanum == 75104 & select_hhold_dup == 85 & intervdate == 15072020
//Household head name: MALANG NJIE
replace select_hhold = 111 if eanum == 75104 & select_hhold_dup == 91 & intervdate == 18082020

duplicates tag ( settlement eanum select_hhold),gen(dup)
ta dup
drop dup

replace settlement=35125  if settlement==1    & lga==3 & eanum==35115
replace settlement=75101  if settlement==12   & lga==7 & eanum==75106
replace settlement=70109  if settlement==70   & lga==7 & eanum==70113
replace settlement=41210  if settlement==4012 & lga==4 & eanum==41204
replace settlement=43115  if settlement==4311 & lga==4 & eanum==43108


drop lga- name_distr settlmnt_name area intervdate-number_of_hhold_members name_distr s7aq1c_names select_hhold_dup

merge m:1 settlement eanum select_hhold using "$data\Stata\PART A Date of interview.dta"
ta _m 
drop if _m==2

replace rec_type="PART 1 Section 7A"
la var rec_type "PART 1 Section 7A"
ren rec_type PT1_Sect_7

la var eanum     "EA number"
la var s7aq9     "S7AQ9 - Main reason(s) why no one borrowed money (max 3)"
la var s7aq9a    "S7AQ9A - Repaying a loan"
la var s7aq9b    "S7AQ9B - No access to credit"
la var s7aq9c    "S7AQ9C - Interest rate very high"
la var s7aq9d    "S7AQ9D - Do not want to pay interest"
la var s7aq9e    "S7AQ9E - Not needed"
la var s7aq9f    "S7AQ9F - Fear of default"
la var s7aq9g    "S7AQ9G - Lack of collateral/guarantor"
la var s7aq9x    "S7AQ9X - Other (specify)"

sort hid 
order hid lga quarter district district1 area settlement settlement_name eanum select_hhold PT1_Sect_7
drop int_day-_merge

drop if hid=="3210232156012"  //all infor missing for this HH in roster

compress 
save "$data\Stata\PART A Section 7A-Credit Received.dta", replace


**Sect 7B - Credit denied
use "$data\Original\Raw PART 1\IHS1 - Sect7B - Credit Denied.dta" , clear 
count 
renvars,l
duplicates drop

ta s7bq1,m
 
clonevar select_hhold_dup  = select_hhold
//Household head name: MODOU BOYE
replace select_hhold = 100 if eanum == 63229 & select_hhold_dup == 11 & intervdate == 12022020
//Household head name: FARAMBA SANYANG
replace select_hhold = 100 if eanum == 75104 & select_hhold_dup == 85 & intervdate == 15072020
//Household head name: MALANG NJIE
replace select_hhold = 111 if eanum == 75104 & select_hhold_dup == 91 & intervdate == 18082020

duplicates tag ( settlement eanum select_hhold),gen(dup)
ta dup
drop dup

replace settlement=35125  if settlement==1    & lga==3 & eanum==35115
replace settlement=75101  if settlement==12   & lga==7 & eanum==75106
replace settlement=70109  if settlement==70   & lga==7 & eanum==70113
replace settlement=41210  if settlement==4012 & lga==4 & eanum==41204
replace settlement=43115  if settlement==4311 & lga==4 & eanum==43108

drop lga-name_distr settlmnt_name area intervdate-number_of_hhold_members select_hhold_dup

merge m:1 settlement eanum select_hhold using "$data\Stata\PART A Date of interview.dta"
ta _m 
tab1 s7bq1-s7bmore  if _m==2  //all missing
drop if _m==2
drop _m 

replace rec_type="PART 1 Section 7B"
la var rec_type "PART 1 Section 7B"
ren rec_type PT1_Sect_7

la var eanum    	"EA number"

order hid lga quarter district district1 area settlement settlement_name eanum select_hhold PT1_Sect_7 
drop int_day-year_mth

drop if hid=="3210232156012"  //all infor missing for this HH in roster

sort hid

compress 
save "$data\Stata\PART A Section 7B-Credit Denied.dta", replace


**Sect 7C - Savings
*use "$data\Original\Raw PART 1\IHS1 - Sect7C - Savings.dta" , clear //file updated
use "$data\Original\Raw PART 1\IHS1_SECT7C_CORRECTED.dta", clear
count 
renvars,l
duplicates drop
drop s7cq2_name

gen asd=1  if s7cq1==. & s7cq1_id==. & s7cq2_id==. & s7cq4==. & s7cq5a==. & s7cq5b==. & s7cmore==.
ta asd,m
drop if asd==1

ta s7cq1,m
 
clonevar select_hhold_dup  = select_hhold
//Household head name: MODOU BOYE
replace select_hhold = 100 if eanum == 63229 & select_hhold_dup == 11 & intervdate == 12022020
//Household head name: FARAMBA SANYANG
replace select_hhold = 100 if eanum == 75104 & select_hhold_dup == 85 & intervdate == 15072020
//Household head name: MALANG NJIE
replace select_hhold = 111 if eanum == 75104 & select_hhold_dup == 91 & intervdate == 18082020

duplicates tag ( settlement eanum select_hhold),gen(dup)
ta dup
drop dup

replace settlement=35125  if settlement==1    & lga==3 & eanum==35115
replace settlement=75101  if settlement==12   & lga==7 & eanum==75106
replace settlement=70109  if settlement==70   & lga==7 & eanum==70113
replace settlement=41210  if settlement==4012 & lga==4 & eanum==41204
replace settlement=43115  if settlement==4311 & lga==4 & eanum==43108

drop lga-name_distr settlmnt_name area asd select_hhold_dup

merge m:1 settlement eanum select_hhold using "$data\Stata\PART A Date of interview.dta"
ta _m 
tab1 s7cq1 s7cq1_id s7cq2_id s7cq4 s7cq5a s7cq5b s7cmore if _m==2  //all missing
drop if _m==2
tab1 s7cq1 s7cq1_id s7cq2_id s7cq4 s7cq5a s7cq5b s7cmore if _m==1  //all missing
drop _m 

replace rec_type="PART 1 Section 7C"
la var rec_type "PART 1 Section 7C"
ren rec_type PT1_Sect_7

la var eanum    	"EA number"

order hid lga quarter district district1 area settlement settlement_name eanum select_hhold PT1_Sect_7 
drop int_day-year_mth

drop if hid==""

drop if hid=="3210232156012"  //all infor missing for this HH in roster

sort hid 

compress 
save "$data\Stata\PART A Section 7C-Savings.dta", replace


** Sect 7D -Access to financial insitutions
use "$data\Original\Raw PART 1\IHS1 - Sect7D - Acess To Finance.dta" , clear 
count 
renvars,l
duplicates drop
drop s7dq2a

gen asd=1  if s7dq1==. & s7dq2==. & s7dq3==. & s7dq4==. & s7dq5==. & s7d_more==.
ta asd,m
tab1 s7dq1-s7d_more if asd==1
drop if asd==1
drop asd 

ta s7dq1,m
 
clonevar select_hhold_dup  = select_hhold
//Household head name: MODOU BOYE
replace select_hhold = 100 if eanum == 63229 & select_hhold_dup == 11 & number_of_hhold_members==.
//Household head name: FARAMBA SANYANG
replace select_hhold = 100 if eanum == 75104 & select_hhold_dup == 85 & number_of_hhold_members==5
//Household head name: MALANG NJIE
replace select_hhold = 111 if eanum == 75104 & select_hhold_dup == 91 & number_of_hhold_members==8

duplicates tag ( settlement eanum select_hhold),gen(dup)
ta dup
drop dup

replace settlement=35125  if settlement==1    & lga==3 & eanum==35115
replace settlement=75101  if settlement==12   & lga==7 & eanum==75106
replace settlement=70109  if settlement==70   & lga==7 & eanum==70113
replace settlement=41210  if settlement==4012 & lga==4 & eanum==41204
replace settlement=43115  if settlement==4311 & lga==4 & eanum==43108

drop lga-name_distr settlmnt_name area intervdate-number_of_hhold_members select_hhold_dup

merge m:1 settlement eanum select_hhold using "$data\Stata\PART A Date of interview.dta"
ta _m 
tab1 s7dq1 s7dq0 s7dq2 s7dq3 other_s7dq3 s7dq4 other_s7dq4 s7dq5 s7d_more if _m==2  //all missing
drop if _m==2
drop _m 

replace rec_type="PART 1 Section 7D"
la var rec_type "PART 1 Section 7D"
ren rec_type PT1_Sect_7

la var eanum    "EA number"

order hid lga quarter district district1 area settlement settlement_name eanum select_hhold PT1_Sect_7 
drop int_day-year_mth 

drop if hid=="3210232156012"  //all infor missing for this HH in roster

sort hid s7dq0 

compress 
save "$data\Stata\PART A Section 7D-Access to financial institutions.dta", replace


********************************************************************************
*** SECTION 8 - HOUSING

use "$data\Original\Raw PART 1\IHS1 - Sect8A - Housing.dta" , clear 
count 
renvars,l
duplicates drop

ta s8aq1,m
 
clonevar select_hhold_dup  = select_hhold
//Household head name: MODOU BOYE
replace select_hhold = 100 if eanum == 63229 & select_hhold_dup == 11 & intervdate == 12022020
//Household head name: FARAMBA SANYANG
replace select_hhold = 100 if eanum == 75104 & select_hhold_dup == 85 & intervdate == 15072020
//Household head name: MALANG NJIE
replace select_hhold = 111 if eanum == 75104 & select_hhold_dup == 91 & intervdate == 18082020

duplicates tag ( settlement eanum select_hhold),gen(dup)
ta dup
drop if dup==1  //all roster data missing infor 
drop dup

replace settlement=35125  if settlement==1    & lga==3 & eanum==35115
replace settlement=75101  if settlement==12   & lga==7 & eanum==75106
replace settlement=70109  if settlement==70   & lga==7 & eanum==70113
replace settlement=41210  if settlement==4012 & lga==4 & eanum==41204
replace settlement=43115  if settlement==4311 & lga==4 & eanum==43108

gen PT1_Sect_8="PART 1 Section 8"
la var PT1_Sect_8 "PART 1 Section 8"

drop lga-name_distr area intervdate-number_of_hhold_members select_hhold_dup settlmnt_name

order settlement eanum select_hhold PT1_Sect_8 
sort settlement eanum select_hhold 

compress 
save "$temp\housing.dta", replace 


** Sec 8B
use "$data\Original\Raw PART 1\IHS1 - Sect8B - Housing Expenses.dta" , clear 
count 
renvars,l
duplicates drop

ta s8bq1,m
 
clonevar select_hhold_dup  = select_hhold
//Household head name: MODOU BOYE
replace select_hhold = 100 if eanum == 63229 & select_hhold_dup == 11 & intervdate == 12022020
//Household head name: FARAMBA SANYANG
replace select_hhold = 100 if eanum == 75104 & select_hhold_dup == 85 & intervdate == 15072020
//Household head name: MALANG NJIE
replace select_hhold = 111 if eanum == 75104 & select_hhold_dup == 91 & intervdate == 18082020

duplicates tag ( settlement eanum select_hhold),gen(dup)
ta dup
drop if dup==1  //all missing infor 
drop dup

replace settlement=35125  if settlement==1    & lga==3 & eanum==35115
replace settlement=75101  if settlement==12   & lga==7 & eanum==75106
replace settlement=70109  if settlement==70   & lga==7 & eanum==70113
replace settlement=41210  if settlement==4012 & lga==4 & eanum==41204
replace settlement=43115  if settlement==4311 & lga==4 & eanum==43108

drop lga-name_distr area intervdate-number_of_hhold_members rec_type select_hhold_dup settlmnt_name

la var eanum     "EA number"
la var s8bq9     "S8BQ9 - Who pays the rent for HH (max 3)"
la var s8bq9a    "S8BQ9A - Ourselves (household)"
la var s8bq9b    "S8BQ9B - Someone living outside the HH"
la var s8bq9c    "S8BQ9C - Relative of HH"
la var s8bq9d    "S8BQ9D - Non relative"
la var s8bq9e    "S8BQ9E - The Government"
la var s8bq9f    "S8BQ9F - Private company"
la var s8bq9g    "S8BQ9G - Support organization"
la var s8bq9x    "S8BQ9X - Other (specify)"

order settlement eanum select_hhold 
sort settlement eanum select_hhold 

compress 
save "$temp\housing_exp.dta", replace 


** merge file
use "$temp\housing.dta", clear 
merge 1:1 settlement eanum select_hhold using "$temp\housing_exp.dta"
drop _m  

merge m:1 settlement eanum select_hhold using "$data\Stata\PART A Date of interview.dta"
ta _m 
tab1 s8aq1-s8bq12c if _m==1  //all missing infor 
drop if _m==2
drop _m int_day-year_mth

la var eanum    "EA number"

order hid lga quarter district district1 area settlement settlement_name eanum select_hhold PT1_Sect_8  

drop if hid=="3210232156012"  //all infor missing for this HH in roster

sort hid

compress 
save "$data\Stata\PART A Section 8-Housing.dta", replace


********************************************************************************
*** SECTION 9 - OWNERSHIP OF DURABLE GOODS

use "$data\Original\Raw PART 1\IHS1 - Sect9 - Ownership of Durable Assets.dta" , clear 
count 
renvars,l
duplicates drop

ta s9q1,m
 
clonevar select_hhold_dup  = select_hhold
//Household head name: MODOU BOYE
replace select_hhold = 100 if eanum == 63229 & select_hhold_dup == 11 & intervdate == 12022020
//Household head name: FARAMBA SANYANG
replace select_hhold = 100 if eanum == 75104 & select_hhold_dup == 85 & intervdate == 15072020
//Household head name: MALANG NJIE
replace select_hhold = 111 if eanum == 75104 & select_hhold_dup == 91 & intervdate == 18082020

duplicates tag ( settlement eanum select_hhold s9q1),gen(dup)
ta dup
drop dup

replace settlement=35125  if settlement==1    & lga==3 & eanum==35115
replace settlement=75101  if settlement==12   & lga==7 & eanum==75106
replace settlement=70109  if settlement==70   & lga==7 & eanum==70113
replace settlement=41210  if settlement==4012 & lga==4 & eanum==41204
replace settlement=43115  if settlement==4311 & lga==4 & eanum==43108

la var eanum      "EA number"
la var s9q4_1     "S9Q4_1 - How long ago was item obtained - first asset"
la var s9q4_2     "S9Q4_2 - How long ago was item obtained - second asset"
la var s9q5_1     "S9Q5_1 - What was the price of Item - first asset"
la var s9q5_2     "S9Q5_2 - What was the price of Item - second asset"
la var s9q6_1     "S9Q6_1 - How much could you sell the Item now - first asset"
la var s9q6_2     "S9Q6_2 - How much could you sell the Item now - second asset"

drop lga-name_distr area intervdate-number_of_hhold_members select_hhold_dup settlmnt_name

merge m:1 settlement eanum select_hhold using "$data\Stata\PART A Date of interview.dta"
ta _m 
tab1 s9q1-s9q6_2  if _m==2

replace rec_type="PART 1 Section 9"
la var rec_type "PART 1 Section 9"
ren rec_type PT1_Sect_9

order hid lga quarter district district1 area settlement settlement_name eanum select_hhold PT1_Sect_9 
drop int_day-_merge

drop if hid=="3210232156012"  //all infor missing for this HH in roster

sort hid s9q1 

compress 
save "$data\Stata\PART A Section 9-Ownership of durable assets.dta", replace


********************************************************************************
*** SECTION 10 - ENVIRONMENT

use "$data\Original\Raw PART 1\IHS1 - Sect10 - Environment.dta" , clear 
count 
renvars,l
duplicates drop

ta s10q1,m
 
clonevar select_hhold_dup  = select_hhold
//Household head name: MODOU BOYE
replace select_hhold = 100 if eanum == 63229 & select_hhold_dup == 11 & intervdate == 12022020
//Household head name: FARAMBA SANYANG
replace select_hhold = 100 if eanum == 75104 & select_hhold_dup == 85 & intervdate == 15072020
//Household head name: MALANG NJIE
replace select_hhold = 111 if eanum == 75104 & select_hhold_dup == 91 & intervdate == 18082020

duplicates tag ( settlement eanum select_hhold),gen(dup)
ta dup
drop if dup==1  //all missing infor 
drop dup

replace settlement=35125  if settlement==1    & lga==3 & eanum==35115
replace settlement=75101  if settlement==12   & lga==7 & eanum==75106
replace settlement=70109  if settlement==70   & lga==7 & eanum==70113
replace settlement=41210  if settlement==4012 & lga==4 & eanum==41204
replace settlement=43115  if settlement==4311 & lga==4 & eanum==43108

drop lga-name_distr area intervdate-number_of_hhold_members select_hhold_dup settlmnt_name

merge 1:1 settlement eanum select_hhold using "$data\Stata\PART A Date of interview.dta"
ta _m 
drop if _m==1   //no infor

replace rec_type="PART 1 Section 10"
la var rec_type "PART 1 Section 10"
ren rec_type PT1_Sect_10 

la var eanum    "EA number"

order hid lga quarter district district1 area settlement settlement_name eanum select_hhold PT1_Sect_10
drop int_day-_merge

drop if hid=="3210232156012"  //all infor missing for this HH in roster

sort hid  

compress 
save "$data\Stata\PART A Section 10-Environment.dta", replace


********************************************************************************
*** SECTION 11 - GOVERNANCE

use "$data\Original\Raw PART 1\IHS1 - Sect11- Governance.dta" , clear 
count 
renvars,l
duplicates drop

ta s11q1,m
 
clonevar select_hhold_dup  = select_hhold
//Household head name: MODOU BOYE
replace select_hhold = 100 if eanum == 63229 & select_hhold_dup == 11 & intervdate == 12022020
//Household head name: FARAMBA SANYANG
replace select_hhold = 100 if eanum == 75104 & select_hhold_dup == 85 & intervdate == 15072020
//Household head name: MALANG NJIE
replace select_hhold = 111 if eanum == 75104 & select_hhold_dup == 91 & intervdate == 18082020

duplicates tag ( settlement eanum select_hhold),gen(dup)
ta dup
drop if dup==1  //all missing infor 
drop dup

replace settlement=35125  if settlement==1    & lga==3 & eanum==35115
replace settlement=75101  if settlement==12   & lga==7 & eanum==75106
replace settlement=70109  if settlement==70   & lga==7 & eanum==70113
replace settlement=41210  if settlement==4012 & lga==4 & eanum==41204
replace settlement=43115  if settlement==4311 & lga==4 & eanum==43108

drop lga-name_distr area intervdate-number_of_hhold_members select_hhold_dup settlmnt_name

merge 1:1 settlement eanum select_hhold using "$data\Stata\PART A Date of interview.dta"
ta _m 
drop if _m==1   //no infor

replace rec_type="PART 1 Section 11"
la var rec_type "PART 1 Section 11"
ren rec_type PT1_Sect_11

la var eanum    "EA number"

order hid lga quarter district district1 area settlement settlement_name eanum select_hhold PT1_Sect_11
drop  int_day- _merge

drop if hid=="3210232156012"  //all infor missing for this HH in roster

sort hid  

compress 
save "$data\Stata\PART A Section 11-Governance.dta", replace


********************************************************************************
*** SECTION 12 - TRANSFERS 

** Sect 12A - Received by Hhold
use "$data\Original\Raw PART 1\IHS1 - Sect12A - Transfers Received by Hhold.dta" , clear 
count 
renvars,l
duplicates drop

ta s12aq1,m
replace s12aq0=.  if s12aq1==.
replace s12aq1=2  if s12aq1==.
replace s12aq2=2  if s12aq2==.

clonevar select_hhold_dup  = select_hhold
//Household head name: MODOU BOYE
replace select_hhold = 100 if eanum == 63229 & select_hhold_dup == 11 & intervdate == 12022020
//Household head name: FARAMBA SANYANG
replace select_hhold = 100 if eanum == 75104 & select_hhold_dup == 85 & intervdate == 15072020
//Household head name: MALANG NJIE
replace select_hhold = 111 if eanum == 75104 & select_hhold_dup == 91 & intervdate == 18082020

drop s12aq01

duplicates tag ( settlement eanum select_hhold),gen(dup)
ta dup
drop dup

replace settlement=35125  if settlement==1    & lga==3 & eanum==35115
replace settlement=75101  if settlement==12   & lga==7 & eanum==75106
replace settlement=70109  if settlement==70   & lga==7 & eanum==70113
replace settlement=41210  if settlement==4012 & lga==4 & eanum==41204
replace settlement=43115  if settlement==4311 & lga==4 & eanum==43108

replace rec_type="PART 1 Section 12A"

drop lga-name_distr area intervdate-number_of_hhold_members select_hhold_dup settlmnt_name

merge m:1 settlement eanum select_hhold using "$data\Stata\PART A Date of interview.dta"
ta _m 
tab1 s12aq1-s12amore if _m==2
bys settlement eanum select_hhold: gen countdup=_n
ta countdup 
replace s12aq1=2  if s12aq1==.  //should we assume that missing HHs implied the did not receive transfers
replace s12aq2=2  if s12aq2==.
replace rec_type="PART 1 Section 12A"  if rec_type==""
la var rec_type "PART 1 Section 12A"
ren rec_type PT1_Sect_12 

ren s12aq0 s12aq0_id 

la var eanum    "EA number"

order hid lga quarter district district1 area settlement settlement_name eanum select_hhold PT1_Sect_12 
drop int_month-countdup

drop if hid=="3210232156012"  //all infor missing for this HH in roster

sort hid s12aq0_id

compress 
save "$data\Stata\PART A Section 12A-Transfers received.dta", replace


*** Sect 12B - Transfers made out
*use "$data\Original\Raw PART 1\IHS1 - Sect12B - Transfers Made out by Hholds.dta" , clear 
use "$data\Original\Raw PART 1\IHS!_SECT12B_cORRECTED.dta" , clear 
count 
renvars,l
duplicates drop

drop s12bq0_name

ta s12bq1,m
//what is this? s12q1_lagg s12q2_lag s12q3_lag

clonevar select_hhold_dup  = select_hhold
//Household head name: MODOU BOYE
replace select_hhold = 100 if eanum == 63229 & select_hhold_dup == 11 & intervdate == 12022020
//Household head name: FARAMBA SANYANG
replace select_hhold = 100 if eanum == 75104 & select_hhold_dup == 85 & intervdate == 15072020
//Household head name: MALANG NJIE
replace select_hhold = 111 if eanum == 75104 & select_hhold_dup == 91 & intervdate == 18082020

duplicates tag ( settlement eanum select_hhold),gen(dup)
ta dup
drop dup

replace settlement=35125  if settlement==1    & lga==3 & eanum==35115
replace settlement=75101  if settlement==12   & lga==7 & eanum==75106
replace settlement=70109  if settlement==70   & lga==7 & eanum==70113
replace settlement=41210  if settlement==4012 & lga==4 & eanum==41204
replace settlement=43115  if settlement==4311 & lga==4 & eanum==43108

drop lga-name_distr settlmnt_name area

merge m:1 settlement eanum select_hhold using "$data\Stata\PART A Date of interview.dta"
ta _m 
tab1 s12bq1-more_transf if _m==2
tab1 s12bq1-more_transf if _m==1
drop if _m==1

bys settlement eanum select_hhold: gen countdup=_n
ta countdup 
*replace s12bq1=2  if s12bq1==.  //should we assume that missing HHs implied the did not receive transfers
*replace s12bq2=2  if s12bq2==.
replace rec_type="PART 1 Section 12B"  if rec_type==""
la var rec_type "PART 1 Section 12B"
ren rec_type PT1_Sect_12

la var eanum    "EA number"

order hid lga quarter district district1 area settlement settlement_name eanum select_hhold PT1_Sect_12 
drop select_hhold_dup-countdup intervdate-number_of_hhold_members

drop if hid=="3210232156012"  //all infor missing for this HH in roster

sort hid s12bq0_id 

compress 
save "$data\Stata\PART A Section 12B-Transfers made outd.dta", replace


********************************************************************************
*** SECTION 13 - SUBJECTIVE POVERTY

use "$data\Original\Raw PART 1\IHS1 - Sect13 - Subjective Poverty.dta" , clear 
count 
renvars,l
duplicates drop

ta s13q1,m
 
clonevar select_hhold_dup  = select_hhold
//Household head name: MODOU BOYE
replace select_hhold = 100 if eanum == 63229 & select_hhold_dup == 11 & intervdate == 12022020
//Household head name: FARAMBA SANYANG
replace select_hhold = 100 if eanum == 75104 & select_hhold_dup == 85 & intervdate == 15072020
//Household head name: MALANG NJIE
replace select_hhold = 111 if eanum == 75104 & select_hhold_dup == 91 & intervdate == 18082020

duplicates tag ( settlement eanum select_hhold),gen(dup)
ta dup
drop if dup==1  //all missing infor 
drop dup

replace settlement=35125  if settlement==1    & lga==3 & eanum==35115
replace settlement=75101  if settlement==12   & lga==7 & eanum==75106
replace settlement=70109  if settlement==70   & lga==7 & eanum==70113
replace settlement=41210  if settlement==4012 & lga==4 & eanum==41204
replace settlement=43115  if settlement==4311 & lga==4 & eanum==43108

drop lga-name_distr area intervdate-number_of_hhold_members select_hhold_dup settlmnt_name

merge 1:1 settlement eanum select_hhold using "$data\Stata\PART A Date of interview.dta"
ta _m 
drop if _m==1   //no infor

replace rec_type="PART 1 Section 13"
la var rec_type "PART 1 Section 13"
ren rec_type PT1_Sect_13

la var eanum    "EA number"

order hid lga quarter district district1 area settlement settlement_name eanum select_hhold PT1_Sect_13 
drop int_day-_merge

drop if hid=="3210232156012"  //all infor missing for this HH in roster

sort hid  

compress 
save "$data\Stata\PART A Section 13-Subjective poverty.dta", replace


********************************************************************************
*** SECTION 14 - ACCESS TO NEAREST SCOIAL AMENITY

use "$data\Original\Raw PART 1\IHS1 - Sect14 - Access to Nearest Social Amenity.dta" , clear 
count 
renvars,l
duplicates drop

ta s14q1,m
 
clonevar select_hhold_dup  = select_hhold
//Household head name: MODOU BOYE
replace select_hhold = 100 if eanum == 63229 & select_hhold_dup == 11 & intervdate == 12022020
//Household head name: FARAMBA SANYANG
replace select_hhold = 100 if eanum == 75104 & select_hhold_dup == 85 & intervdate == 15072020
//Household head name: MALANG NJIE
replace select_hhold = 111 if eanum == 75104 & select_hhold_dup == 91 & intervdate == 18082020

duplicates tag ( settlement eanum select_hhold s14q1),gen(dup)
ta dup
drop dup

replace settlement=35125  if settlement==1    & lga==3 & eanum==35115
replace settlement=75101  if settlement==12   & lga==7 & eanum==75106
replace settlement=70109  if settlement==70   & lga==7 & eanum==70113
replace settlement=41210  if settlement==4012 & lga==4 & eanum==41204
replace settlement=43115  if settlement==4311 & lga==4 & eanum==43108

drop lga-name_distr settlmnt_name area intervdate-number_of_hhold_members select_hhold_dup

merge m:1 settlement eanum select_hhold using "$data\Stata\PART A Date of interview.dta"
ta _m 
tab1 s14q1_code-other_s14q4 if _m==2
drop if _m==2   //no infor

gen PT1_Sect_14="PART 1 Section 14"
la var PT1_Sect_14 "PART 1 Section 14"

ren s14q1_code s14q1_id
order hid lga quarter district district1 area settlement settlement_name eanum select_hhold s14q1_id PT1_Sect_14 
drop int_day-_merge

la var eanum    "EA number"

drop if hid=="3210232156012"  //all infor missing for this HH in roster

sort hid  

compress 
save "$data\Stata\PART A Section 14-Access to amenities.dta", replace


********************************************************************************
*** SECTION 15 - CRIME & SECURITY

** Sect 15A - Individuals
use "$data\Original\Raw PART 1\IHS1 - Sect15A - Crime & Social Security.dta" , clear 
count 
renvars,l
duplicates drop

ta s15aq1,m
 
clonevar select_hhold_dup  = select_hhold
//Household head name: MODOU BOYE
replace select_hhold = 100 if eanum == 63229 & select_hhold_dup == 11 & intervdate == 12022020
//Household head name: FARAMBA SANYANG
replace select_hhold = 100 if eanum == 75104 & select_hhold_dup == 85 & intervdate == 15072020
//Household head name: MALANG NJIE
replace select_hhold = 111 if eanum == 75104 & select_hhold_dup == 91 & intervdate == 18082020

duplicates tag ( settlement eanum select_hhold s15aq1),gen(dup)
ta dup
drop dup

replace settlement=35125  if settlement==1    & lga==3 & eanum==35115
replace settlement=75101  if settlement==12   & lga==7 & eanum==75106
replace settlement=70109  if settlement==70   & lga==7 & eanum==70113
replace settlement=41210  if settlement==4012 & lga==4 & eanum==41204
replace settlement=43115  if settlement==4311 & lga==4 & eanum==43108

drop lga-name_distr settlmnt_name area intervdate-number_of_hhold_members select_hhold_dup

merge m:1 settlement eanum select_hhold using "$data\Stata\PART A Date of interview.dta"
ta _m 
tab1 s15aq1-s15aq6 if _m==2
drop if _m==2   //no infor

replace rec_type="PART 1 Section 15A"
la var rec_type "PART 1 Section 15A"
ren rec_type PT1_Sect_15 

la var eanum    "EA number"

order hid lga quarter district district1 area settlement settlement_name eanum select_hhold PT1_Sect_15 
drop int_day-_merge

drop if hid=="3210232156012"  //all infor missing for this HH in roster

sort hid s15aq1

compress 
save "$data\Stata\PART A Section 15A-Crime HH Members.dta", replace


*** Sect 15 - Communities
use "$data\Original\Raw PART 1\IHS1 - SECT15B - Crime & Social Security - Communities.dta" , clear 
count 
renvars,l
duplicates drop

ta s15bq1,m
 
clonevar select_hhold_dup  = select_hhold
//Household head name: MODOU BOYE
replace select_hhold = 100 if eanum == 63229 & select_hhold_dup == 11 & intervdate == 12022020
//Household head name: FARAMBA SANYANG
replace select_hhold = 100 if eanum == 75104 & select_hhold_dup == 85 & intervdate == 15072020
//Household head name: MALANG NJIE
replace select_hhold = 111 if eanum == 75104 & select_hhold_dup == 91 & intervdate == 18082020

duplicates tag ( settlement eanum select_hhold s15bq1),gen(dup)
ta dup
drop if dup==1  //all missing infor 
drop dup

replace settlement=35125  if settlement==1    & lga==3 & eanum==35115
replace settlement=75101  if settlement==12   & lga==7 & eanum==75106
replace settlement=70109  if settlement==70   & lga==7 & eanum==70113
replace settlement=41210  if settlement==4012 & lga==4 & eanum==41204
replace settlement=43115  if settlement==4311 & lga==4 & eanum==43108

drop lga-name_distr settlmnt_name area intervdate-number_of_hhold_members select_hhold_dup

merge m:1 settlement eanum select_hhold using "$data\Stata\PART A Date of interview.dta"
ta _m 
tab1 s15bq1-s15bq14 if _m==1
drop if _m==1   //no infor

replace rec_type="PART 1 Section 15B"
la var rec_type "PART 1 Section 15B"
ren rec_type PT1_Sect_15

la var eanum    "EA number"

order hid lga quarter district district1 area settlement settlement_name eanum select_hhold PT1_Sect_15
drop int_day-_merge

drop if hid=="3210232156012"  //all infor missing for this HH in roster

sort hid s15bq1

compress 
save "$data\Stata\PART A Section 15B-Crime Community.dta", replace



********************************************************************************************************************************************************
********************************************************************************************************************************************************


