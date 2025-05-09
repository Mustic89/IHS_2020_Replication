* * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* ####################################################### *
* #                                                     # *
* #       GAMBIA IHS 2020 CONSUMPTION AGGREGATION       # *
* #                                                     # *
* ####################################################### *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
/*
The nominal welfare aggregate can be decomposed into two sub-aggregates: the food consumption aggregate and the non-food consumption aggregate. The goal of this dofile is to calculate the welfare aggregate for The Gambia using data from the 2020 Integreted Household Survey (IHS). It is separated into 8 Modules. 

   - Module 1: allows for the extraction of important general household information that will be very useful in the poverty analyses.
   - Module 2: Total food purshase 
   - Module 3: Total food consumption from own productiom.  
     Module 2 and 3 derives the food consumption  aggregate
   - Module 4: Education 
   - Module 5: Health
   - Module 6: Non food frenquent
   - Module 7: Non food infrequent: Durable. 
     Module 4-7 calculate the aggregate of non-food consumption
   - Module 8: merge all the sub-parts together to produce the welfare aggregate (nominal).
   
*/
                                     
*************************************
** INITIALIZATION OF THE WORKSPACE **
*************************************
version 17

clear
set more off
cap log close

****************************
** DEFINE THE DIRECTORIES **
****************************
// change the specific file path to your IHS2020 folder here to run the dofile

*++++++++++++++++ CHANGE THIS PATH TO YOUR IHS 2020 FOLDER TO RUN ++++++++*
global path  "C:\Users\tchou\Desktop\IHS2020"
***************************************************************************

global findata     ${path}\01.Data\Stata
global findata_up  ${path}\01.Data\stata_updates
global othdata     ${path}\01.Data\Other
global fintab      ${path}\04.Results\output
global logs        ${path}\04.Results\logfiles
global temp        ${path}\04.Results\temp


log using "$logs\3-GMB 2020 cons aggregate.log" , replace

*++++++++++++++++++++++++++++++++++++++++++
*******************************************
****  Module 1: BASIC HH INFORMATION   ****
*******************************************
*+++++++++++++++++++++++++++++++++++++++++*

use "$findata\PART A Section 1_2_3_4_6-Individual level.dta",clear
merge m:1 hid using "$findata\PART A Date of interview.dta"
ta _m 
drop _merge

**WBG country code
gen country = "GMB"


**survey period
*2015-16 survey period: April 2015 to April 2016.
gen surveyr=2020
ta int_month int_year
replace int_year=2021 if int_year==2018 

destring int_*,replace
lab define int_month 1 "January" 2 "February" 3 "March" 4 "April" 5 "May" 6 "June"  ///
	7 "July" 8 "August" 9 "September" 10 "October" 11 "November" 12 "December",replace  
lab val int_month int_month  

gen cycle=quarter


**Area of residence.
ta area
ta area,nol
recode area (1=1) (2=0),gen(rururb)
lab define rururb   1 "Urban" 0 "Rural" 
lab val rururb rururb


**capital
tab district 
gen capital=1       if district<=12 
replace capital=2   if capital==. & rururb==1
replace capital=3   if rururb==0
lab define capital 1 "Capital"  2 "Other urban areas"  3 "Rural",modify
lab val capital capital
lab var capital "Main capital/city, other urban and rural classification"


**Banjul/Kanifing
*for some robustness check analytics
gen econzone=.
replace econzone=1    if district1<=20 & rururb==1
replace econzone=2    if econzone==. & rururb==1
replace econzone=3    if rururb==0
lab define econzone  1 "Banjul/Kanifing"  2 "Other urban"  3 "Rural"
lab val econzone econzone


**Adult equivalent scales: Modified Ghana measure which correlated slightly better than above and will be the measure used.
*Male Female: 0-1 yrs 0.25 0.25; 1-3 yrs 0.45 0.45; 4-6 yrs 0.62 0.62; 7-10 yrs 0.69 0.69.
*Male Feamle: 11-14 yrs 0.86 0.76; 15-18 yrs 1.03 0.76; 19-25 yrs 1.00  0.76; 26-50 yrs 1.00 0.76; 51 and above 0.79 0.66.
ta s1q5_years,m  //11 missing 
ta s1q5_years if s1q5_years==.  //4 heads, 1 spouse, 4 children and 1 parent
//drop hid=3210232156012 because most infor missing. HHSIZE=6
//drop hid=4410644110015 idnum=10. An outlier as all infor missing. HHSIZE=9 but this one all infor mising
//drop hid=5310253111003 idnum=1. An outlier as all infor missing. HHSIZE=1
//drop hid==5320753202002 idnum=1. An outlier as all infor missing. HHSIZE=1
//drop hid==5320953205010 idnum=1. An outlier as all infor missing. HHSIZE=1
drop if  s1q5_years==.   //based on the above.
tab s1q3,m
gen fao_ad=0.25      if ( s1q5_years<1 ) 
replace fao_ad=0.45  if ( s1q5_years>=1 & s1q5_years<=3 ) 
replace fao_ad=0.62  if ( s1q5_years>=4 & s1q5_years<=6 ) 
replace fao_ad=0.69  if ( s1q5_years>=7 & s1q4a<=10 ) 

replace fao_ad=0.86  if (( s1q5_years>=11 & s1q5_years<=14) & s1q3==1 ) 
replace fao_ad=1.03  if (( s1q5_years>=15 & s1q5_years<=18) & s1q3==1 ) 
replace fao_ad=1.00  if (( s1q5_years>=19 & s1q5_years<=25) & s1q3==1 ) 
replace fao_ad=1.00  if (( s1q5_years>=26 & s1q5_years<=50) & s1q3==1 ) 
replace fao_ad=0.79  if (  s1q5_years>=51 & s1q5_years<=98  & s1q3==1 ) 

replace fao_ad=0.76  if (( s1q5_years>=11 & s1q5_years<=14) & s1q3==2 ) 
replace fao_ad=0.76  if (( s1q5_years>=15 & s1q5_years<=18) & s1q3==2 ) 
replace fao_ad=0.76  if (( s1q5_years>=19 & s1q5_years<=25) & s1q3==2 ) 
replace fao_ad=0.76  if (( s1q5_years>=26 & s1q5_years<=50) & s1q3==2 ) 
replace fao_ad=0.66  if (  s1q5_years>=51 & s1q5_years<=98  & s1q3==2 ) 

replace fao_ad=1.00  if ( s1q5_years==. & s1q3<=2 | s1q3==10)   
replace fao_ad=0.76  if ( s1q5_years==. & s1q3<=2 | s1q3==10)  


**adult equivalent scales
*GMB does not have and so will use FAO
*Source: Recommended Dietary allowancs, Ninth Revised Edition 1980.  Committe on Dietary Allowances, Food and Nutrition Board, National Academy of Sciences, Washington, DC 1980
ta s1q5_months,m  
gen ctry_ad=0.26      	if ( s1q5_months<6 ) 
replace ctry_ad=0.35	if ( s1q5_months>=6 & s1q5_months<12)
replace ctry_ad=0.48  	if ( s1q5_years>=1 & s1q5_years<=3 ) 
replace ctry_ad=0.63 	if ( s1q5_years>=4 & s1q5_years<=6 ) 
replace ctry_ad=0.89  	if ( s1q5_years>=7 & s1q5_years<=10 ) 

replace ctry_ad=1.00  if (( s1q5_years>=11 & s1q5_years<=14) & s1q3==1 ) 
replace ctry_ad=1.04  if (( s1q5_years>=15 & s1q5_years<=18) & s1q3==1 ) 
replace ctry_ad=1.07  if (( s1q5_years>=19 & s1q5_years<=22) & s1q3==1 ) 
replace ctry_ad=1.00  if (( s1q5_years>=23 & s1q5_years<=50) & s1q3==1 ) 
replace ctry_ad=0.89  if (  s1q5_years>=51 & s1q5_years<=75  & s1q3==1 ) 
replace ctry_ad=0.76  if (  s1q5_years>=76 & s1q5_years<=98  & s1q3==1 ) 

replace ctry_ad=0.81  if (( s1q5_years>=11 & s1q5_years<=14) & s1q3==2 ) 
replace ctry_ad=0.78  if (( s1q5_years>=15 & s1q5_years<=18) & s1q3==2 ) 
replace ctry_ad=0.78  if (( s1q5_years>=19 & s1q5_years<=22) & s1q3==2 ) 
replace ctry_ad=0.74  if (( s1q5_years>=23 & s1q5_years<=50) & s1q3==2 ) 
replace ctry_ad=0.67  if (  s1q5_years>=51 & s1q5_years<=75  & s1q3==2 ) 
replace ctry_ad=0.59  if (  s1q5_years>=76 & s1q5_years<=98  & s1q3==2 ) 

replace ctry_ad=0.89  if ( s1q5_years==. & s1q3==1 )   
replace ctry_ad=0.78  if ( s1q5_years==. & s1q3==2 ) 


**Calculation of per capita calorie RDR
*used to check if the KCal make sense.  
gen rdr_ctry=690      	if ( s1q5_months<6 ) 
replace rdr_ctry=945 	if ( s1q5_months>=6 & s1q5_months<12) 
replace rdr_ctry=1300  	if ( s1q5_years>=1 & s1q5_years<=3 ) 
replace rdr_ctry=1700 	if ( s1q5_years>=4 & s1q5_years<=6 ) 
replace rdr_ctry=2400  	if ( s1q5_years>=7 & s1q5_years<=10 ) 

replace rdr_ctry=2700  if (( s1q5_years>=11 & s1q5_years<=14) & s1q3==1 ) 
replace rdr_ctry=2800  if (( s1q5_years>=15 & s1q5_years<=18) & s1q3==1 ) 
replace rdr_ctry=2900  if (( s1q5_years>=19 & s1q5_years<=22) & s1q3==1 ) 
replace rdr_ctry=2700  if (( s1q5_years>=23 & s1q5_years<=50) & s1q3==1 ) 
replace rdr_ctry=2400  if (  s1q5_years>=51 & s1q5_years<=75  & s1q3==1 ) 
replace rdr_ctry=2050  if (  s1q5_years>=76 & s1q5_years<=98  & s1q3==1 ) 

replace rdr_ctry=2200  if (( s1q5_years>=11 & s1q5_years<=14) & s1q3==2 ) 
replace rdr_ctry=2100  if (( s1q5_years>=15 & s1q5_years<=18) & s1q3==2 ) 
replace rdr_ctry=2100  if (( s1q5_years>=19 & s1q5_years<=22) & s1q3==2 ) 
replace rdr_ctry=2000  if (( s1q5_years>=23 & s1q5_years<=50) & s1q3==2 ) 
replace rdr_ctry=1800  if (  s1q5_years>=51 & s1q5_years<=75  & s1q3==2 ) 
replace rdr_ctry=1600  if (  s1q5_years>=76 & s1q5_years<=98  & s1q3==2 ) 

replace rdr_ctry=2700  if ( s1q5_years==. & s1q3==1 )   //1 head and 1 niece missing age
replace rdr_ctry=2100  if (s1q5_years==. & s1q3==2 )


**Calculation of per capita calorie RDR  
*Source: World Health Organization as reported on a 1987 poster by the CTA/ECSA group.
*entitled "Food consumption table for energy and eight important nutrients in foods commonly eaten in East Africa".

*style 1
gen rdr=.
replace rdr=820  	if ( s1q5_years<1 )
replace rdr=1150 	if ( s1q5_years==1 )
replace rdr=1350 	if ( s1q5_years==2 )
replace rdr=1550 	if ( inrange( s1q5_years,  3,  4 ) )
replace rdr=1850 	if ( s1q3==1 & inrange( s1q5_years,  5,  6 ) )
replace rdr=2100 	if ( s1q3==1 & inrange( s1q5_years,  7,  9 ) )
replace rdr=2200 	if ( s1q3==1 & inrange( s1q5_years, 10, 11 ) )
replace rdr=2400 	if ( s1q3==1 & inrange( s1q5_years, 12, 13 ) )
replace rdr=2650 	if ( s1q3==1 & inrange( s1q5_years, 14, 15 ) )
replace rdr=2850 	if ( s1q3==1 & inrange( s1q5_years, 16, 17 ) )
replace rdr=1750 	if ( s1q3==2 & inrange( s1q5_years,  5,  6 ) )
replace rdr=1800 	if ( s1q3==2 & inrange( s1q5_years,  7,  9 ) )
replace rdr=1950 	if ( s1q3==2 & inrange( s1q5_years, 10, 11 ) )
replace rdr=2100 	if ( s1q3==2 & inrange( s1q5_years, 12, 13 ) )
replace rdr=2150 	if ( s1q3==2 & inrange( s1q5_years, 14, 15 ) )
replace rdr=2150 	if ( s1q3==2 & inrange( s1q5_years, 16, 17 ) )
*for adults assign moderate workload by gender
replace rdr=3000 	if ( s1q3==1 & inrange( s1q5_years, 18, 29 ) )
replace rdr=2900 	if ( s1q3==1 & inrange( s1q5_years, 30, 59 ) )
replace rdr=2450 	if ( s1q3==1 & inrange( s1q5_years, 60, 98 ) )
replace rdr=2100 	if ( s1q3==2 & inrange( s1q5_years, 18, 29 ) )
replace rdr=2150 	if ( s1q3==2 & inrange( s1q5_years, 30, 59 ) )
replace rdr=1950 	if ( s1q3==2 & inrange( s1q5_years, 60, 95 ) )
*missing age
replace rdr=2900 	if ( s1q3==1 & s1q5_years==. )
replace rdr=2150 	if ( s1q3==2 & s1q5_years==. )
 
*style 2
*seasonally adjusted for rural adults
*We can adjust this based on number of months of workload.  Hence the RDR for rural adults can be computed as a weighted average of (0.75 moderate RDR + 0.25 heavy RDR)
gen rdr_a=.
replace rdr_a=820  	  if ( s1q5_years<1 )
replace rdr_a=1150 	  if ( s1q5_years==1 )
replace rdr_a=1350 	  if ( s1q5_years==2 )
replace rdr_a=1550 	  if ( inrange( s1q5_years,  3,  4 ) )
replace rdr_a=1850 	  if ( s1q3==1 & inrange( s1q5_years,  5,  6 ) )
replace rdr_a=2100 	  if ( s1q3==1 & inrange( s1q5_years,  7,  9 ) )
replace rdr_a=2200 	  if ( s1q3==1 & inrange( s1q5_years, 10, 11 ) )
replace rdr_a=2400 	  if ( s1q3==1 & inrange( s1q5_years, 12, 13 ) )
replace rdr_a=2650 	  if ( s1q3==1 & inrange( s1q5_years, 14, 15 ) )
replace rdr_a=2850 	  if ( s1q3==1 & inrange( s1q5_years, 16, 17 ) )
replace rdr_a=1750 	  if ( s1q3==2 & inrange( s1q5_years,  5,  6 ) )
replace rdr_a=1800 	  if ( s1q3==2 & inrange( s1q5_years,  7,  9 ) )
replace rdr_a=1950 	  if ( s1q3==2 & inrange( s1q5_years, 10, 11 ) )
replace rdr_a=2100 	  if ( s1q3==2 & inrange( s1q5_years, 12, 13 ) )
replace rdr_a=2150 	  if ( s1q3==2 & inrange( s1q5_years, 14, 15 ) )
replace rdr_a=2150 	  if ( s1q3==2 & inrange( s1q5_years, 16, 17 ) )
*for adults assign moderate workload for urban
replace rdr_a=3000 	  if ( s1q3==1 & inrange( s1q5_years, 18, 29 ) )
replace rdr_a=2900 	  if ( s1q3==1 & inrange( s1q5_years, 30, 59 ) )
replace rdr_a=2450 	  if ( s1q3==1 & inrange( s1q5_years, 60, 95 ) )
replace rdr_a=2100 	  if ( s1q3==2 & inrange( s1q5_years, 18, 29 ) )
replace rdr_a=2150 	  if ( s1q3==2 & inrange( s1q5_years, 30, 59 ) )
replace rdr_a=1950 	  if ( s1q3==2 & inrange( s1q5_years, 60, 95 ) )
*for adults assign moderate workload for rural
replace rdr_a=3137.5  if rururb==0 & s1q3==1 & ( inrange( s1q5_years, 18, 29 ) )
replace rdr_a=3025 	  if rururb==0 & s1q3==1 & ( inrange( s1q5_years, 30, 59 ) )
replace rdr_a=2550 	  if rururb==0 & s1q3==1 & ( inrange( s1q5_years, 60, 95 ) )
replace rdr_a=2162.5  if rururb==0 & s1q3==2 & ( inrange( s1q5_years, 18, 29 ) )
replace rdr_a=2212.5  if rururb==0 & s1q3==2 & ( inrange( s1q5_years, 30, 59 ) )
replace rdr_a=2000 	  if rururb==0 & s1q3==2 & ( inrange( s1q5_years, 60, 95 ) )
*missing age
replace rdr_a=3025 	  if rururb==0 & s1q3==1 & s1q5_years==. 
replace rdr_a=2212.5  if rururb==0 & s1q3==2 & s1q5_years==. 
  

**spouses
ta s1q6,m
gen spouse=1  if s1q6==2 | s1q6==3  //spouse and co-wife
recode spouse (.=0)
bys hid: egen spouses=total(spouse)
lab var spouses "Number of spouses in household"


**HH size and composition
gen kids=1            if s1q5_years>=0 & s1q5_years<=4
gen tots=1            if s1q5_years>=5 & s1q5_years<=9
gen teens=1           if s1q5_years>=10 & s1q5_years<=17
gen fems=1            if (s1q5_years>=18 & s1q5_years<=98) & s1q3==2
gen admals=1          if (s1q5_years>=18 & s1q5_years<=98) & s1q3==1
gen female=1          if s1q3==2
gen male=1            if s1q3==1
gen depen0014=1       if s1q5_years<=14
gen activ1564=1       if s1q5_years>14 & s1q5_years<65   
gen depen65UP=1       if s1q5_years>64 & s1q5_years<=98

gen hh=1
egen hhsize			=sum(hh), by(hid)

egen kids0004		=sum(kids), by(hid)
egen kids0509		=sum(tots), by(hid)
egen kids1017		=sum(teens), by(hid)
egen adfems			=sum(fems), by(hid)
egen admales		=sum(admals), by(hid)
egen females		=sum(female), by(hid)
egen males			=sum(male), by(hid)
egen depend0014 	=sum(depen0014), by(hid)
egen active1564		=sum(activ1564), by(hid)
egen depend65UP		=sum(depen65UP), by(hid)
egen fao_adq		=sum(fao_ad), by(hid)  
egen ctry_adq		=sum(ctry_ad), by(hid)  
egen rdr_hh			=sum(rdr), by(hid)
egen rdr_hh_a		=sum(rdr_a), by(hid)
egen rdr_hh_ctry	=sum(rdr), by(hid)


**HH head characteristics

*gender
tab s1q3,m
recode s1q3 (1=1)  (2=0),gen(hhsex)
lab define hhsex  1 "Male" 0 "Female"
lab val hhsex hhsex

*marital status
tab s1q10,m
recode s1q10  (1=3) (2=1) (3=4) (4 5=5) (6=6),gen(hhmarital6)
ta s1q11 s1q10
replace hhmarital=2  if s1q11>1 & s1q10==2
lab define hhmarital6  1 "Married monogamous"  2 "Married polygamous"  3 "Never married"  4 "Living together"  ///
	5 "Divorced/Separated"  6 "Widowed"  
lab val hhmarital6 hhmarital6 
ta s1q10 hhmarital6

recode s1q10 (1=2) (2=1) (3=3) (4 5=4) (6=5),gen(hhmarital5)
lab define hhmarital5  1 "Married"  2 "Never married"  3 "Living together"  ///
	4 "Divorced/Separated"  5 "Widowed"  
lab val hhmarital5 hhmarital5
ta s1q10 hhmarital5

*ever attended school 
tab s3aq2
recode s3aq2 (1=1)  (2=0),gen(hheverattd)
lab define hheverattd  1 "Yes" 0 "No"
lab val hheverattd hheverattd

*education level
ta s1q4a s3aq7   //some outliers
ta s3aq7 s3aq6
gen hheducat10=.
replace hheducat10=1    if hheverattd==0
replace hheducat10=2    if s3aq6==0
replace hheducat10=3    if s3aq6==1 & s3aq7<6
replace hheducat10=4    if s3aq6==1 & s3aq7==6
replace hheducat10=4    if s3aq6==2 & s3aq7<3
replace hheducat10=5    if s3aq6==2 & (s3aq7>=3 & s3aq7~=.)
replace hheducat10=5    if s3aq6==3 & (s3aq7<3)
replace hheducat10=6    if s3aq6==3 & (s3aq7>=3 & s3aq7~=.)
replace hheducat10=7    if s3aq6>=4 & s3aq6<=6
replace hheducat10=8    if s3aq6==7 | s3aq6==8
lab def hheducat10  1 "No Education"  2 "Pre-school"  3 "Primary not completed" ///
	4 "Completed primary, but less than completed lower secondary" ///
	5 "Completed lower secondary (or post-primary vocational education) but less than completed upper secondary" ///
	6 "Completed upper secondary (or extended vocational/technical education)" ///
	7 "Post-secondary technical"  8 "University and higher"  9 "Formal adult education or literacy" ///
	10 "Other",modify 
lab val hheducat10 hheducat10
replace hheverattd=1   if (hheducat10>1 & hheducat10<=8) & hheverattd==.
replace hheverattd=1   if (hheducat10>1 & hheducat10<=8) & hheverattd==0
ta hheducat10 hheverattd

gen hheducat7=. 
replace hheducat7=1    if hheverattd==0
replace hheducat7=1    if s3aq6==0
replace hheducat7=2    if s3aq6==1 & s3aq7<6
replace hheducat7=3    if s3aq6==1 & s3aq7==6
replace hheducat7=4    if s3aq6==2 & s3aq7<3
replace hheducat7=4    if s3aq6==2 & (s3aq7>=3 & s3aq7~=.)
replace hheducat7=4    if s3aq6==3 & (s3aq7<3)
replace hheducat7=5    if s3aq6==3 & (s3aq7>=3 & s3aq7~=.)
replace hheducat7=6    if s3aq6>=4 & s3aq6<=6
replace hheducat7=7    if s3aq6==7 | s3aq6==8
lab def hheducat7  1 "No education"  2 "Primary incomplete"  3 "Primary complete"  4 "Secondary incomplete"  ///
	5 "Secondary complete"  6 "Post secondary but not university"  7 "University"  8 "Other",modify 
lab val hheducat7 hheducat7
tab hheducat7
ta hheducat10 hheducat7
ta hheducat7 hheverattd

recode hheducat7 (3 4=3) (5=4) (6 7=5) (8=.),gen(hheducat5)
lab define hheducat5  1 "No education"  2 "Primary incomplete"  3 "Primary complete but Secondary incomplete"  ///
	4 "Secondary complete"  5 "Tertiary (completed or incomplete)",modify 
lab val hheducat5 hheducat5
ta hheducat5 hheverattd

recode hheducat7 (2 3=2) (4 5=3) (6 7=4) (8=.),gen(hheducat4)
lab define hheducat4  1 "No education"  2 "Primary (complete or incomplete)"   ///
	3 "Secondary (complete or incomplete)" 4 "Tertiary (complete or incomplete)",modify
lab val hheducat4 hheducat4
ta hheducat4 hheverattd
	

**household weighting coefficent.
sort eanum
gen EA_code = eanum
merge m:1 EA_code using "$findata\The_Gambia_IHS_weights"  //final weight file provided by Consultant David Megill
ta _m
keep if _merge == 3
drop  _merge 

gen wta_hh=hh_weight
gen wta_pop=wta_hh*hhsize
gen wta_cadq=wta_hh*ctry_adq

bys lga: egen totright=total(wta_hh)

tabstat totright ,by(lga)  		   s(mean)  f(%12.0f)
tabstat wta_hh ,by(district1)  s(sum)  f(%12.0f)


cap erase "${fintab}\Z-output 1-pop size.xls"
foreach var of varlist lga district1 rururb year_mth{
tabout `var'  using "${fintab}\Z-output 1-pop size.xls", sum c(sum wta_hh sum hh_weight) append
}


**Other
gen cluster=eanum 
gen hhno=select_hhold


**select one obs per HH. Keep HH head  
tab s1q6
keep if s1q6==1  //keep household head only.  Make sure only one head per household

gen hhagey=s1q5_years 
replace hhagey=.  if hhagey==98 | hhagey==99  //missing and dDK
impute hhagey hhsex, generate(assd)
bys hhsex: egen hh_med=median(hhagey)
tab hh_med
replace hhagey=int(assd)

gen hhageygrp = .
forval i=0(5)95 {
	replace hhageygrp = 1+`i'/5 if inrange(hhagey,`i',`i'+4)
}
replace hhageygrp=21  if hhagey==.
lab define hhageygrp 3 "10-14 years old"  4 "15-19 years old"  5 "20-24 years old"  6 "25-29 years old"  7 "30-34 years old"  ///
	8 "35-39 years old"  9 "40-44 years old"  10 "45-49 years old"  11 "50-54 years old"  12 "55-59 years old"  ///
	13 "60-64 years old"  14 "65 and above years old"  
lab val hhageygrp hhageygrp
replace hhageygrp=14    if hhageygrp>=15 & hhageygrp~=.

gen headmale	=1  if hhsex==1 
gen nevermarried=1  if hhmarital6==3
gen marriedmono	=1  if hhmarital6==1
gen marriedpoly	=1  if hhmarital6==2
gen divorcewidow=1  if hhmarital6==5 | hhmarital6==6

recode headmale nevermarried marriedmono marriedpoly divorcewidow (.=0)

***Generate quarter based on the interview month. Quarter 4 includes January 2021
drop quarter
recode int_month  (2/3=1) (4/6=2) (7/9=3) (1 10/12=4) , gen(quarter)
lab def quarter 1 "Q1_2020" 2 "Q2_2020" 3 "Q3_2020" 4 "Q4_2020",modify
lab val quarter quarter

**label variables 
lab var country    		"Country code"
lab var lga        		"Local Government Area (LGA)"
lab var district		"District"
lab var hid         	"Household unique identifier (country derived)"
lab var surveyr    		"Year of survey"
lab var rururb     		"Area of residence"
lab var econzone   		"Area of residence (economic)"
lab var capital 		"Main capital/city, other urban and rural classification"
lab var hhsize     		"Number of people in household"
lab var fao_adq  	  	"Sum total of adult equivalent scales (FAO-specific)"
lab var ctry_adq  	  	"Sum total of adult equivalent scales (country-specific)"
lab var hhsex     		"Sex of Household head"
lab var hhagey     		"Age of Household head"
lab var hhageygrp   	"Broad age-groups of age of Household head"
lab var hhmarital5 		"Marital status of Household head (5 categories)"
lab var hhmarital6 		"Marital status of Household head (6 categories)"
lab var hheverattd 		"Ever attended school for Household head"
lab var hheducat4 		"Highest level of education completed by Household head (4 categories)"
lab var hheducat5 		"Highest level of education completed by Household head (5 categories)"
lab var hheducat7 		"Highest level of education completed by Household head (7 categories)"
lab var hheducat10 		"Highest level of education completed by Household head (10 categories)"
lab var spouses    		"Number of spouses in household"
lab var headmale		"Head of household is male, dummy (1,0)"
lab var nevermarried	"Marital status of Household head is single"
lab var marriedmono		"Marital status of Household head is monogamous marriage"
lab var marriedpoly		"Marital status of Household head is polygamous marriage"
lab var divorcewidow	"Marital status of Household head is divorced, separated or widowed"
lab var kids0004		"Children between 0-4 years old in household"
lab var kids0509		"Children between 5-9 years old in household"
lab var kids1017		"Children between 10-17 years old in household"
lab var adfems			"Adult females in household"
lab var admales			"Adult males in household"
lab var females			"Number of females in household"
lab var males			"Number of males in household"
lab var depend0014		"Population between 0-14 years old in household"
lab var active1564		"Population between 15-64 years old in household"
lab var depend65UP		"Population over 64 years old in household"
lab var int_month       "Month of interview visit"
lab var int_year        "Year of interview visit"
lab var year_mth        "Month and year merged (string)"
lab var yearmth         "Month and year merged into one variable for analysis ease"   
lab var cycle			"Cycle"
lab var cluster         "Cluster (enumeration area)"
lab var hhno            "Household number"
lab var hid             "Household unique identifier"
lab var wta_hh  		"Household weighting coefficient"
lab var wta_pop  		"Population weighting coefficient"
lab var wta_cadq  		"Adult equivalent population weighting coefficient"
lab var rdr_hh  		"Total daily calories"
lab var rdr_hh_a  		"Total daily calories adjusted for seasonality in rural areas"
lab var rdr_hh_ctry		"Total daily calories (country-specific)"
 
duplicates tag (hid) ,gen(dup1)
tab dup1

keep lga district district1 eanum cluster hhno country hid rururb econzone capital  ///
	surveyr quarter int_month int_year year_mth yearmth  ///
	wta_hh wta_pop wta_cadq hhsize fao_adq ctry_adq  ///
	hhsex hhagey hhageygrp hhmarital6 hhmarital5  ///
	hheverattd hheducat10 hheducat7 hheducat5 hheducat4 spouses  ///
	headmale nevermarried marriedmono marriedpoly  ///
	divorcewidow kids0004 kids0509 kids1017 females males adfems admales  ///
	depend0014 active1564 depend65UP rdr_hh rdr_hh_a rdr_hh_ctry cycle
	
order cycle lga district district1 eanum cluster hhno country hid rururb econzone capital  ///
	surveyr quarter int_month int_year year_mth yearmth  ///
	wta_hh wta_pop wta_cadq hhsize females males fao_adq ctry_adq  ///
	hhsex hhagey hhageygrp hhmarital6 hhmarital5  ///
	hheverattd hheducat10 hheducat7 hheducat5 hheducat4 spouses  ///
	headmale nevermarried marriedmono marriedpoly  ///
	divorcewidow kids0004 kids0509 kids1017 adfems admales  ///
	depend0014 active1564 depend65UP rdr_hh rdr_hh_a rdr_hh_ctry

sort hid 
	
compress
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
save "$fintab\Module 1 basicinfo.dta", replace 
***********************************************


**keep subset file to use later during edits.
keep  hid lga district district1 rururb capital cluster hhno hhsize ctry_adq wta_hh  ///
	quarter int_month int_year year_mth yearmth
order lga district district1 rururb capital wta_hh quarter ctry_adq hhsize cluster hhno hid int_month int_year year_mth yearmth

sort hid

compress
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
save "$temp\hhsize.dta", replace
*********************************




*+++++++++++++++++++++++++++++++++++++++++++*
*********************************************
*****    MODULE 2- FOOD  EXPENDITURE    *****
*********************************************
*+++++++++++++++++++++++++++++++++++++++++++*
/*
Two data files are used to obtain the food consumption aggregate (fdtexp) :
 - Food Outside.dta: which allow us to calculate the annual food consumption outside the home (fdrestby)
- Food expenditure.dta: which allows us to calculate the Total purchased food expenditure (fdtotby) [which itself is equal to Food given as gifts (gift_amt) + Food purchased (purc_amt)] and Total value of auto-consumption food (fdtotpr)
At the end the aggregate food consumption is calculated as follows:
		fdtexp =  fdrestby + fdtotby + fdtotpr
*/

**********************************************
***** 2.1-Food consumed outside the home *****
**********************************************
*To calculate the total consumption outside the house (fdrestby) we consider only the information contained in question s1bq3 "TOTAL amount HH paid for the Meal", which we then annualise after detecting and correcting the outliers.

use "$findata\PART B Section 1B-Food outside.dta" , clear

mdesc s1bq1 s1bq2  

summarize s1bq3 if s1bq2==3 
/* There is one observations where S1BQ2==3 but for which there is a total amount of expenses made and even the products consumed.
The S1BQ2 data for these household appear to be in error. 
We will replace 3=No with 1=Yes in The Gambia
*/
replace s1bq2=1  if s1bq2==3 & s1bq3!=. & s1bq3>0  //2 obs
keep if s1bq2==1 | s1bq2==2
mdesc s1bq3 
generate valid=1

** check the outliers here before annaluasing
tabstat s1bq3, s(min p1 p5 p25 p50 p75 p95 p99 max) by(s1bq1)
tab s1bq3 if s1bq2==2 
 
/*  OUTLIERS
   S1BQ3 - |
      TOTAL |
  amount HH |
   paid for |
  the Meals |      Freq.     Percent        Cum.
------------+-----------------------------------
          1 |          2        0.15        0.15
          2 |      1,073       79.25       79.39
          3 |        128        9.45       88.85

		  */	
replace s1bq3=. if s1bq2==2 & s1bq3<=3
bys lga s1bq1 : egen asd_md=median(s1bq3)  
replace s1bq3 = asd_md  if s1bq2==2 & s1bq3<=3
tab s1bq3 if s1bq2==2 

gen fmtot=s1bq3/7*365
tabstat fmtot,by(lga)
tabstat fmtot,by(district)
tabstat fmtot, s(min p1 p5 p25 p50 p75 p95 p99 max) by(s1bq1)

merge m:1 hid using "$temp\hhsize.dta"
keep if valid==1 
drop _m


**********************************
***  Identification outliers   *** 

gen pcfmtot = fmtot/hhsize
gen ln_pcfmtot = ln(pcfmtot )
tempfile full_1 
save `full_1'
foreach stats in mean median sd {
use `full_1', clear
collapse (`stats')  ln_pcfmtot pcfmtot [aw=wta_hh], by(lga  s1bq1)
rename ln_pcfmtot ln_pcfmtot_`stats'
rename pcfmtot pcfmtot_`stats'
tempfile `stats'
save ``stats''
}

use `full_1', clear
merge m:1 lga s1bq1 using `mean'
drop _merge
merge m:1 lga s1bq1 using `median'
drop _merge
merge m:1 lga s1bq1 using `sd'
drop _merge
tabstat  ln_pcfmtot_mean ln_pcfmtot_median ln_pcfmtot_sd, by(s1bq1)   f(%12.2f)
tabstat  pcfmtot_mean pcfmtot_median pcfmtot_sd, by(s1bq1)   f(%12.2f)
 
mdesc ln_pcfmtot ln_pcfmtot_mean  ln_pcfmtot_sd
gen zscor=(ln_pcfmtot-ln_pcfmtot_mean)/ln_pcfmtot_sd
lab var zscor "Z scores for a normal distribution"

gen fmtot1=fmtot
replace fmtot1=pcfmtot_median*hhsize   if zscor>3 & zscor~=.
tab fmtot1

sum fmtot fmtot1 

tabstat fmtot fmtot1 ,by(s1bq1)
tabstat fmtot fmtot1 ,by(lga)

sum fmtot1,detail
count if fmtot1>=70000*1.4029 & fmtot1~=.   //14 obs.
//food prices have gone up by about 40 percent. 	
//70K was used to top code outliers.
replace fmtot1=70000*1.4029       if fmtot1>=70000*1.4029 & fmtot1~=.
sum fmtot1,detail

ren fmtot1 fdrestby  

tabstat fdrestby            , s(min p1 p5 p25 p50 p75 p95 p99 max) by(s1bq1)
tabstat fdrestby [aw=wta_hh], s(min p1 p5 p25 p50 p75 p95 p99 max) by(s1bq1)

collapse (sum) fdrestby ,by(lga district hid)
sort hid 

compress
save "$temp\Module 2 - restaurant.dta", replace


*******************************************************
***** 2.2-Food items consume within the household *****
*******************************************************  
// To compute the total amount consume within the household, we only using the info on purchases (s1aq4 and s1aq5) to construct prices, and then using those prices to value total quantity and then taking the share of purchases. An alternative here could be to just take the total expenditure reported in (s1aq5) since in most cases, the amount purchased (s1aq4) is the same as the amount consumed from purchases (S1aq3).           

*use "$findata\PART B Section 1A-Food_consumption expenditure.dta", clear 

*use "C:\Users\Rostand Tchouakam\Desktop\World Bank Group\Welfare Aggregate\GMB\IHS2020\01.Data\stata_updates\PART B Section 1A-Food_consumption expenditure_2022-06-13.dta",clear
use "$findata_up\PART B Section 1A-Food_consumption expenditure_2022-06-13.dta",clear



*use "C:\Users\Rostand Tchouakam\Desktop\World Bank Group\Welfare Aggregate\GMB\IHS2020\01.Data\stata_updates\Food_consumption expenditure_updated_April13_2022.dta",clear

gen asd=1  if s1aq3a==0 & s1aq3b==0
replace s1aq3a=.  if asd==1
replace s1aq3b=.  if asd==1
drop asd 
gen asd=1  if s1aq4a==0 & s1aq4b==0
replace s1aq4a=.  if asd==1
replace s1aq4b=.  if asd==1
drop asd 
gen asd=1  if s1aq6a==0 & s1aq6b==0
replace s1aq6a=.  if asd==1
replace s1aq6b=.  if asd==1
drop asd 
gen asd=1  if s1aq7a==0 & s1aq7b==0
replace s1aq7a=.  if asd==1
replace s1aq7b=.  if asd==1
drop asd 
gen asd=1  if s1aq8a==0 & s1aq8b==0
replace s1aq8a=.  if asd==1
replace s1aq8b=.  if asd==1
drop asd 

gen s1aq3_ori=s1aq3a 
gen s1aq3b_ori=s1aq3b 
gen s1aq4a_ori=s1aq4a 
gen s1aq4b_ori=s1aq4b
gen s1aq5_ori=s1aq5 
gen s1aq6a_ori=s1aq6a 
gen s1aq6b_ori=s1aq6b 
gen s1aq7a_ori=s1aq7a 
gen s1aq7b_ori=s1aq7b 
gen s1aq8a_ori=s1aq8a
gen s1aq8b_ori=s1aq8b

merge m:1 hid using "$temp\hhsize.dta"
keep if _m==3  //dropped 199 HHs that have no informations in the Roster  
drop _m

order select_hhold quarter int_month int_year lga district district1 area settlement settlement_name eanum PT2_Sect_1 s1aq1_os,last

summarize s1aq3a-s1aq8b if s1aq2==2  //check to make sure that no positive values
mdesc s1aq3a-s1aq8b if s1aq2==1
keep if s1aq2==1  //keep only valid obs

misstable sum s1aq3a // 64 missing values here. This is a problem

tabulate s1aq1,m
 foreach i of numlist 3 4 6 7 8 {
  replace  s1aq`i'b =. if s1aq`i'a ==0
  recode  s1aq`i'a (0 =.)
  }

gen asd0=1   	if s1aq6a~=. & s1aq6b~=. & s1aq7a==. & s1aq7b==. & s1aq8a==. & s1aq8b==.
replace asd0=2	if s1aq6a==. & s1aq6b==. & s1aq7a~=. & s1aq7b~=. & s1aq8a==. & s1aq8b==.
replace asd0=3	if s1aq6a==. & s1aq6b==. & s1aq7a==. & s1aq7b==. & s1aq8a~=. & s1aq8b~=.
replace asd0=0   if s1aq2==1 & s1aq3a==.
ta asd0,m

*gen asd=1    if s1aq4a>1000 & s1aq4a~=.  
*replace s1aq4a=.  if s1aq4a>1000 & s1aq4a~=.   //outliers
*replace s1aq6a=.  if asd==1 & (s1aq6a>1000 & s1aq6a~=.)


egen tot=rsum(s1aq6a s1aq7a s1aq8a)  //assuming units same
count if s1aq3a~=tot // 147 observations 


**********************************
*** check unit cost and edit   ***

gen qty=s1aq4a
gen qty_unit=s1aq4b

replace qty_unit=. if s1aq4b==0 | s1aq4b==99 // We don't consider "NO UNIT" and "OTHER (specify)" as unit

/*
recode s1aq4b s1aq3b s1aq6b (else=11)    if s1aq4b==15 & s1aq1==63 
recode s1aq4b s1aq3b s1aq6b (else=5)     if s1aq4b==15 & s1aq1==25 
recode s1aq4b s1aq3b s1aq6b (else=5)     if s1aq4b==15 & s1aq1==164
replace s1aq4b=14   if s1aq4b==15 & s1aq5>=100 & s1aq5~=.

replace s1aq4b=s1aq6b  if s1aq4b==15 & s1aq6b==1
*/

gen asdd=1   if s1aq4b==14 & s1aq4a==1
/*count if s1aq5<200 & s1aq4b==14
recode s1aq4a s1aq4b s1aq5 (else=.)  if s1aq5<200 & s1aq4b==14

replace s1aq4b=1   if asd==1
*/

gen qty1=qty 
replace qty=50    if asdd==1
replace s1aq4b=1  if asdd==1

gen s1price=s1aq5/qty   if s1aq4b==s1aq3b   //unit price

tabstat s1price,by(s1aq1)  s(N mean median max)
bys eanum s1aq1 s1aq4b: egen recall_obvs = count(s1price)   if (s1price>0) & !mi(s1price)

replace qty_unit=s1aq3b  	if qty_unit==. & s1aq3b!=0  & s1aq3b!=99   //this way where the unit type is same, a value is assigned
bys eanum s1aq1 qty_unit: egen cprice_md=median(s1price)   if (s1price~=. | s1price~=0) & (recall_obvs>12 & recall_obvs~=.)

compress
saveold "$temp\food.dta",replace


*******************************************
*** derive prices to be replace missing ***
preserve 
collapse (median) cprice_md = s1price   if (s1price~=. | s1price~=0) & (recall_obvs>12 & recall_obvs~=.), by( eanum s1aq1 qty_unit)
sort eanum s1aq1 qty_unit
rename qty_unit s1aq3b
compress 
saveold "$temp\unit_cluster.dta", replace
restore

bys district1 s1aq1 qty_unit: egen dprice_md=median(s1price)   if s1price~=. | s1price~=0
preserve 
collapse (median) dprice_md = s1price  if s1price~=. | s1price~=0, by( district1 s1aq1 qty_unit)
sort district1 s1aq1 qty_unit
rename qty_unit s1aq3b
compress 
saveold "$temp\unit_district.dta", replace
restore

bys lga  s1aq1 qty_unit: egen lprice_md=median(s1price)   if s1price~=. | s1price~=0
preserve 
collapse  (median) lprice_md = s1price  if s1price~=. | s1price~=0, by(lga s1aq1 qty_unit)
sort lga s1aq1 qty_unit
rename qty_unit s1aq3b
compress 
saveold "$temp\unit_lga.dta", replace
restore

bys s1aq1 qty_unit: egen nprice_md=median(s1price)   if s1price~=. | s1price~=0
preserve 
collapse (median) nprice_md = s1price  if s1price~=. | s1price~=0, by(s1aq1 qty_unit)
sort s1aq1 qty_unit
rename qty_unit s1aq3b
compress 
saveold "$temp\unit_n.dta", replace
restore


************************************
*** Beginning of the test method ***

** Case 1: if the unit of the consumed quantity is different from the unit of the purchased quantity (use of the median price)
drop cprice_md dprice_md lprice_md nprice_md

*cluster
sort eanum s1aq1 s1aq3b
merge m:1 eanum s1aq1 s1aq3b using "$temp\unit_cluster.dta"
keep if _m!=2
drop _merge
*district
sort  district1 s1aq1 s1aq3b
merge m:1 district1 s1aq1 s1aq3b using "$temp\unit_district.dta"
keep if _m!=2
drop _merge
*lga
sort lga s1aq1 s1aq3b
merge m:1 lga s1aq1 s1aq3b using "$temp\unit_lga.dta" 
keep if _m!=2
drop _merge
*national
sort s1aq1 s1aq3b
merge m:1 s1aq1 s1aq3b using "$temp\unit_n.dta" 
keep if _m!=2
drop _merge

** Case 2: if the unit of the consumed quantity is the same than the unit of the purchased quantity (use of the particular household price)
gen unit_price=.
replace unit_price = s1price 	if s1aq3b == qty_unit
replace unit_price = cprice_md 	if unit_price==.
replace unit_price = dprice_md 	if unit_price==.
replace unit_price = lprice_md 	if unit_price==.
replace unit_price = nprice_md 	if unit_price==.


replace unit_price = s1price 	if unit_price==. & s1aq3b==s1aq4b 

count if unit_price==.  // 7,423obs
codebook unit_price


/*
// Manually imputation of missing prices //
******************************************

** Long-grained rice (imported)
  * packet
	replace unit_price=. if unit_price=. & s1aq3b==5 & s1aq1==1
  * Medium tomato cup
	replace unit_price=. if unit_price=. & s1aq3b==8 & s1aq1==2

	
** Paddy rice Long Grain (Local)
  * Big tomato cup 
	replace unit_price=. if unit_price=. & s1aq3b==9 & s1aq1==2
  * Tin  
	replace unit_price=. if unit_price=. & s1aq3b==12 & s1aq1==2
  * 50kg bag
	replace unit_price=. if unit_price=. & s1aq3b==14 & s1aq1==2

	
**  Medium-Grained Rice (Imported)
  * Tin
	replace unit_price=. if unit_price=. & s1aq3b==12 & s1aq1==3

	
** Small grained rice (imported)
  * Big tomato
	replace unit_price=. if unit_price=. & s1aq3b==9 & s1aq1==4
  * Tin 
	replace unit_price=. if unit_price=. & s1aq3b==12 & s1aq1==4
	

5. Basmati Rice (Imported)
2. Grams
7. Small tomato cup
12. Tin


6.  Maize
2. Grams


8.  Findi
3. Litres
7. Small tomato cup
10. Cup (standard rice cup

9.  Other Cereal Please Specify
6. Piece/Number

10.  Wheat Flour
5. Packet
14. 50kg bag


11.  Maize Flour
5. Packet
6. Piece/Number
2. Grams
14. 50kg bag


13.  Other Flour of Cereal Please Specify
8. Medium tomato cup
9. Big tomato cup
10. Cup (standard rice cup


14.  Cake
1. Kilogram
2. Grams
7. Small tomato cup


16.  Bread (tapalapa)
2. Grams
3. Litres
4. Millitres
5. Packet


17.  Bread (Senfurr)
5. Packet


18. Sweet bread
1. Kilogram
2. Grams


19.   Sliced white bread
3. Litres
11. Bunch/heap


20.  Other Bread and bakery products Please Specify
2. Grams

*/



* derive s1aq6a, s1aq7a, s1aq8a shares to total before edits so that one can derive values for consumption from purchases,  own productiom and gifts
gen pur_shr=s1aq6a/s1aq3a 
gen own_shr=s1aq7a/s1aq3a 
gen gif_shr=s1aq8a/s1aq3a 
egen dfg=rsum(pur_shr own_shr gif_shr)
ta dfg
drop dfg


********************************
*** check unit cost and edit ***
gen lnprice=log(unit_price)
bys district1 s1aq1 qty_unit: egen price_md=median(lnprice)   if lnprice~=.  
bys district1 s1aq1 qty_unit: egen price_mn=mean(lnprice)     if lnprice~=.  
bys district1 s1aq1 qty_unit: egen price_sd=sd(lnprice)       if lnprice~=.  

gen s1aq1_num = s1aq1
graph box lnprice  if qty_unit==1,over(s1aq1_num)

tabstat unit_price,by(s1aq1)  s(N mean median max)

gen zscore=abs((lnprice-price_mn)/price_sd)
count if zscore>2.5 & zscore!=.
tab s1aq1 if zscore>2.5 & zscore!=.

gen priced=exp(price_md)

gen unitp=unit_price
replace unitp=priced  if zscore>2.5 & zscore!=.

tabstat unitp if qty_unit==1,by(s1aq1)  s(N mean median max sd)

********************************************
*** edit value purchase and consumption  ***

gen fmtot=s1aq3a*unitp
replace fmtot=s1aq5 if unit_price==.
*replace fmtot=s1aq5 if unit_price==. & inlist(lga,3,4,5,6,7,8)

*gen fmtot=s1aq5  // This is an alternative when considering that the amount purchased (q4) is the same as the amount consumed from purchases (q6) and I would just take the total expenditure reported in (q5).

merge m:1 hid using "$temp\hhsize.dta"
tab _m
keep if _m==3
drop _m



/*
*Identification of Lower Outliers 
*********************************
assert s1aq3a < .
replace fmtot=fmtot_md if fmtot==0
*/


***********************************
*** Identification of  Outliers ***
gen pcfmtot = fmtot/hhsize
gen ln_pcfmtot = ln(pcfmtot )
tempfile full_1 
save `full_1'
foreach stats in mean median sd {
use `full_1', clear
collapse (`stats')  ln_pcfmtot pcfmtot [aw=wta_hh], by(lga s1aq1)
rename ln_pcfmtot ln_pcfmtot_`stats'
rename pcfmtot pcfmtot_`stats'
tempfile `stats'
save ``stats''
}
use `full_1', clear
merge m:1 lga s1aq1 using `mean'
drop _merge
merge m:1 lga s1aq1 using `median'
drop _merge
merge m:1 lga s1aq1 using `sd'
drop _merge
tabstat  ln_pcfmtot_mean ln_pcfmtot_median ln_pcfmtot_sd, by(s1aq1)   f(%12.2f)
tabstat  pcfmtot_mean pcfmtot_median pcfmtot_sd, by(s1aq1)   f(%12.2f)
      
gen zscor=(ln_pcfmtot-ln_pcfmtot_mean)/ln_pcfmtot_sd
lab var zscor "Z scores for a normal distribution"

gen fmtot1=fmtot
replace fmtot1=pcfmtot_median*hhsize   if zscor>3 & zscor~=.
tab fmtot1

replace fmtot1 = pcfmtot_median*hhsize if fmtot==.


sum fmtot fmtot1 

tabstat fmtot fmtot1 ,by(s1aq1)
tabstat fmtot fmtot1 ,by(lga)


**************************************
*** value purchase and consumption ***
gen pur =fmtot1*pur_shr 
gen cop =fmtot1*own_shr 
gen gift=fmtot1*gif_shr 

*annualized 
gen purc_amt=pur*365/7
gen ownp_amt=cop*365/7
gen gift_amt=gift*365/7

sort hid

compress
save "$temp\Food item unit level1.dta", replace


collapse (sum) purc_amt ownp_amt gift_amt, by(hid lga s1aq1)
sort hid
compress
save "$temp\Filtered Sec1_Food cons-exp.dta",replace


***********************************************
*** code below is used deriving food basket ***
egen itemexp=rsum(purc_amt ownp_amt gift_amt)
lab var itemexp "Item expenditure"

append using "$temp\Module 2 - restaurant.dta"

*replace s1aq1=999         if s1aq1==. & fdrestby~=.
replace itemexp=fdrestby  if itemexp==. & fdrestby~=.

keep hid lga s1aq1 itemexp
fillin hid s1aq1
replace itemexp=0   if itemexp==.
drop if hid=="" | s1aq1==.

//the assumption is that if a HHD didn't consume the item, expenditure is assumed to be zero

drop _fillin  

sort hid s1aq1

compress
saveold "$fintab\Filtered Sec1_Food basket.dta",replace  
//this file will be used to derive food basket of the poorest population (e.g. X% of population).


********************************************************
*** Aggregating food purchases by broad food groups. ***

*data annualized by item.

use "$temp\Filtered Sec1_Food cons-exp.dta", clear

tab s1aq1, m

collapse (sum) purc_amt ownp_amt gift_amt , by(hid lga)

drop if hid==""
	
compress
saveold "$temp\table2_agg.dta", replace


**********************************************
*** Derive total food and other variables. ***

use "$temp\table2_agg.dta", clear

merge 1:1 hid using "$temp\Module 2 - restaurant.dta"
ta _m

recode fd* ( . = 0 )

egen fdtotby = rsum(gift_amt purc_amt fdrestby) 
lab var fdtotby  "Total purchased food expenditure"
lab var gift_amt 	"Food given as gifts"
lab var purc_amt 	"Food purchased"
lab var fdrestby  "Food consumed in restaurants & canteens purchased"

rename gift_amt fdtotgift
rename purc_amt fdtotpurc
drop _merge ownp_amt

**survey used 7 day recall periods.
gen fdby_tr = 2 
lab var fdby_tr "Food purchases recall period"
lab val fdby_tr fdby_tr
lab define fdby_tr  1 "Day" 2 "Less than a Week/week"  3 "Two-week"  4 "Month"  5 "Quarterly"  6 "Semi-annual"  7 "Annual"

sum  fdtotby  fdtotpurc   fdtotgift fdrestby

order hid district fdby_tr fdtotby fdtotpurc  fdtotgift fdrestby

d

sort hid

compress

*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
saveold "$fintab\Module 2 foodpurchexp.dta", replace
*****************************************************



*++++++++++++++++++++++++++++++++++++++++++++++++++++*
******************************************************
*********** MODULE 3 - FOOD OWN CONSUMPTION **********
******************************************************
*++++++++++++++++++++++++++++++++++++++++++++++++++++*

use "$temp\Filtered Sec1_Food cons-exp.dta", clear
//see above how file is derived.

recode ownp_amt ( . = 0 )
egen fdtotpr=rsum(ownp_amt)

collapse (sum) fdtotpr,by(hid)
lab var fdtotpr "Total value of auto-consumption food" 

sum  fdtotpr 
keep  hid  fdtotpr
order hid  fdtotpr
drop if hid==""

d

sort hid

compress

*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
save "$fintab\Module 3 ownconsexp.dta", replace
***********************************************

merge 1:1 hid using "$fintab\Module 2 foodpurchexp.dta"

egen fdtexp=rsum(fdtotby fdtotpr)
sum fdtexp,detail
count if fdtexp>500000  // 226
count if fdtexp>400000  // 366





*++++++++++++++++++++++++++++++++++++++++++++++++++++++*
********************************************************
*********** MODULE 4 - EDUCATION EXPENDITURES **********
********************************************************
*++++++++++++++++++++++++++++++++++++++++++++++++++++++*

use "$findata\PART A Section 1_2_3_4_6-Individual level.dta",clear

*br s3aq8 s3aq11 s3b*   if s3aq8==2 & s3aq11==1
sum s3b*               if s3aq8==2 & s3aq11==2
gen insch=1            if s3aq8==1 | s3aq11==1   //select only persons who attended school currently and last 12 months.

gen asd=1    if s3bq3==. & s3bq4==. & s3bq5==. & s3bq6==. & s3bq7==. & s3bq8==. & s3bq9==. & s3bq10==. & s3bq11==. &   ///
	s3bq12==. & s3bq13==. & s3bq14==. 
ta s3bq17    if asd==1

gen asd1=1   if s3bq3==0 & s3bq4==0 & s3bq5==0 & s3bq6==0 & s3bq7==0 & s3bq8==0 & s3bq9==0 & s3bq10==0 & s3bq11==0 &   ///
	s3bq12==0 & s3bq13==0 & s3bq14==0  
ta s3bq17    if asd1==1
	
*drop if s3bq3==. & s3bq4==. & s3bq5==. & s3bq6==. & s3bq7==. & s3bq8==. & s3bq9==. & s3bq10==. & s3bq11==. &   ///
*	s3bq12==. & s3bq13==. & s3bq14==. 

*drop if s3bq3==0 & s3bq4==0 & s3bq5==0 & s3bq6==0 & s3bq7==0 & s3bq8==0 & s3bq9==0 & s3bq10==0 & s3bq11==0 &   ///
*	s3bq12==0 & s3bq13==0 & s3bq14==0  
	
keep if s3aq8==1 | s3aq11==1

*recode s3bq4-s3bq17 (.=0)

*check for outliers at the person-level
gen	ss3bq3g	 =	s3bq3 
gen	ss3bq4g	 =	s3bq4 
gen	ss3bq5g  =	s3bq5 
gen	ss3bq6g  =	s3bq6
gen	ss3bq7g  =	s3bq7 
gen	ss3bq8g  =	s3bq8 
gen	ss3bq9g  =	s3bq9 
gen	ss3bq10g =	s3bq10 
gen	ss3bq11g =	s3bq11 
gen	ss3bq12g =	s3bq12 
gen	ss3bq13g =	s3bq13

egen c3b_tot =rsum(s3bq3 s3bq4 s3bq5 s3bq6 s3bq7 s3bq8 s3bq9 s3bq10 s3bq11 s3bq12 s3bq13)


/*
drop s3bq2
foreach var of varlist s3bq* 				{
		qui gen Z_`var' = 0
		qui gen Y_`var' = 0
	order Z_`var' , after(`var')
	order Y_`var' , after(Z_`var')
	
	qui levelsof hheducat7  , local(grades)
	qui levelsof district1 , local(strata)
	foreach g of local grades				{
	foreach s of local strata  		{
	
		qui su `var'   			  		if district1 == `s' & hheducat7==`g', d
		qui replace Z_`var' = 1   		if `var' > (r(mean) + 3*(r(sd))) & !missing(`var') & district1 == `s' & hheducat7 ==`g'
		qui replace `var' = r(mean) 	if Z_`var'==1
		qui replace Y_`var' = 1   		if !missing(`var') & `var'>0 & district1 == `s' & hheducat7 ==`g'
			}
		}
}

*
tempfile ed_1
*/
compress 
save "$temp/ed_1.dta" , replace
/*
egen checktotal = rsum(Z*)
egen obvstotal = rsum(Y*)
bys hid: egen hh_ed_outliers = total(checktotal)
bys hid: egen hh_ed_total  = total(obvstotal)

collapse (sum) totalobvs=obvstotal (sum) outliers=checktotal , by(district1 area)
drop if mi(area)
gen prop_outliers = (outliers/totalobvs)*100

table district1 , c(median prop_outliers)
*/

use "$temp/ed_1.dta", clear

tab s3aq6

sum s3bq3 s3bq4 s3bq5 s3bq6 s3bq7 s3bq8 s3bq9 s3bq10 s3bq11 s3bq12 s3bq13 s3bq14 s3bq17
tabstat s3bq3 s3bq4 s3bq5 s3bq6 s3bq7 s3bq8 s3bq9 s3bq10 s3bq11 s3bq12 s3bq13 s3bq14 s3bq17,by(s3aq6)

collapse (sum) s3bq3 s3bq4 s3bq5 s3bq6 s3bq7 s3bq8 s3bq9 s3bq10 s3bq11 *s3bq12 s3bq13 s3bq14 s3bq17 insch,by(lga district eanum hid)

sum insch

sort eanum

gen EA_code = eanum
merge m:1 EA_code using "$findata\The_Gambia_IHS_weights.dta"  //final weight file
ta _m
keep if _m==3
drop _m 


tabstat  s3bq3 s3bq4 s3bq5 s3bq6 s3bq7 s3bq8 s3bq9 s3bq10 s3bq11 s3bq12 s3bq13 s3bq14 s3bq17 [aw=hh_weight],by(district)

gen  edtution=s3bq3   
egen edbooks =rsum(s3bq6 s3bq7)
gen  edunifms=s3bq5
gen  edrmbrd =s3bq9 
gen  edtrnsp =s3bq8 
gen  edmtnce =s3bq4
gen  edextra =s3bq11
gen  edoth   =s3bq12
gen  edexams =s3bq10
gen  edagg   =s3bq13
gen  edschshp=s3bq17

recode edtution edbooks edunifms edrmbrd edtrnsp edmtnce edextra edoth edexams edagg (0=.)
sum  edtution edbooks edunifms edrmbrd edtrnsp edmtnce edextra edoth edexams edagg

recode edtution edbooks edunifms edrmbrd edtrnsp edmtnce edextra edoth edexams edagg (.=0)
sum  edtution edbooks edunifms edrmbrd edtrnsp edmtnce edextra edoth edexams edagg

lab var edtution 	"Tuition (school fees and registration)" 
lab var edbooks  	"Text books and school supplies" 
lab var edunifms 	"School uniforms" 
lab var edextra  	"Extra-curricular activities" 
lab var edrmbrd  	"Feeding and Boarding" 
lab var edtrnsp  	"Transport to school" 
lab var edmtnce  	"Fees for school maintenance" 
lab var edexams  	"Exam fees" 
lab var edoth    	"Expenditure on education not mentioned elsewhere" 
lab var edagg    	"Education expenditure if cannot be classified by above groups" 
lab var edschshp	"Value of scholarship received last 12 months" 

keep hid edtution edbooks edunifms edrmbrd edtrnsp edmtnce edextra edoth edexams edagg edschshp 
d

sort hid

compress
save "$temp\Educexp Section 3a.dta", replace


*****************************
****    2.2. training    ****
*****************************

use "$findata\PART A Section 1_2_3_4_6-Individual level.dta",clear

egen tot=rsum(s3dq6 s3dq7 s3dq8 s3dq9)         if s3dq5<=2
replace tot=.  if s3dq6==. & s3dq7==. & s3dq8==. & s3dq9==.

gen asd=1   if tot~=s3dq10 & s3dq5<=2   // 19 obs out of  257
tab asd

collapse (sum) s3dq6 s3dq7 s3dq8 s3dq9,by(lga hid)

compress
save "$temp\Educexp Section 3d.dta",replace


*merge education files
use "$temp\Educexp Section 3a.dta",clear

merge 1:1 hid using "$temp\Educexp Section 3d.dta"
tab _m
drop _m

merge 1:1 hid using "$temp\hhsize.dta"
tab _m
drop _m

egen edtrain=rsum(s3dq6 s3dq7 s3dq8 s3dq9)

egen edtexp=rsum(edtution edbooks edunifms edextra edrmbrd edtrnsp edmtnce* edexams edoth  edagg edtrain) // if we add training

*egen edtexp=rsum(edtution edbooks edunifms edextra edrmbrd edtrnsp edmtnce edexams edoth  edagg ) // If we don't add training

/*
**Identification of Lower Outliers 
**********************************
egen  edtexp_md = wpctile(edtexp), w(wta_hh) p(50) 
replace edtexp =edtexp_md  if edtexp ==0
*/

lab var edtution 	"Tuition (school fees and registration)" 
lab var edbooks  	"Text books and school supplies" 
lab var edunifms 	"School uniforms" 
lab var edextra  	"Extra-curricular activities" 
lab var edrmbrd  	"Feeding and Boarding" 
lab var edtrnsp  	"Transport to school" 
lab var edmtnce  	"Fees for school maintenance" 
lab var edexams  	"Exam fees" 
lab var edoth    	"Expenditure on education not mentioned elsewhere" 
lab var edagg    	"Education expenditure if cannot be classified by above groups" 
lab var edtexp   	"Total monetary value of education" 
lab var edschshp	"Value of scholarship received last 12 months" 
lab var edtrain 	"Value of training courses" 

drop s3dq6 s3dq7 s3dq8 s3dq9 lga 

sort hid

compress

*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
save "$fintab\Module 4 educexp.dta",replace 
*********************************************





*++++++++++++++++++++++++++++++++++++++++++++++++*
**************************************************
*********** MODULE 5 - HEALTH EXPENDITURES *******
**************************************************
*++++++++++++++++++++++++++++++++++++++++++++++++*

use "$findata\PART A Section 1_2_3_4_6-Individual level.dta",clear 

gen sick=1   if s2aq2==1 | s2aq8==1 

keep if sick==1

recode s2aq20a s2aq20b s2aq20c s2aq20d s2aq20e s2aq20f s2aq20g s2aq20h s2aq20i s2aq20j s2aq20k (.=0)
egen hlth=rsum(s2aq20a s2aq20b s2aq20c s2aq20d s2aq20e s2aq20f s2aq20g s2aq20h s2aq20i s2aq20j s2aq20k)

*not all two-week recall expenses can be multiplied by 26 (52.14/2) weeks as that is overestimating HH consumption on health.  
*for example, ambulance services is not every two weeks.  DISCUSS WITH NSO

*365/4=52.14 weeks
*reference was 2 weeks
gen cons   =s2aq20a*52.14/2
gen dentist=s2aq20b*2    //GBoS=max assumed to be 2 visits in a year. 
egen hlcons=rsum(cons dentist)


gen immunisation  =s2aq20i*13    		if s1q4a<=5   //just 4 obs
replace immunisation=s2aq20i*52.14/2	if s1q4a>5 & s1q4a~=.
egen medc=rsum(s2aq20c s2aq20j)
gen hlmedc1=medc*52.14/2
egen hlmedc=rsum(hlmedc1 immunisation)

gen hlproc=s2aq20d*52.14/2 

egen hlthoth1=rsum(s2aq20e s2aq20f s2aq20g s2aq20h)  //xray, scanning, ambulance, child birth services - are not something one does every 2 weeks in a normal situation. Not annualised
gen hlthoth2 =s2aq20k*52.14/2 
egen hloth   =rsum(hlthoth1 hlthoth2)

gen asd=1    if s2aq20a==0 & s2aq20b==0 & s2aq20c==0 & s2aq20d==0 & s2aq20e==0 & s2aq20f==0 & s2aq20g==0 &  ///
	s2aq20h==0 & s2aq20i==0 & s2aq20j==0 & s2aq20k==0 
gen hlagg  =s2aq20l*52.14/4   	if asd==1                                     

egen hlhospt=rsum(s2aq27a  s2aq27b)    //is never included as part of expenditure due to its lumpy nature

collapse (sum) hlcons hlmedc hlproc hloth hlagg hlhospt ,by(hid)

recode hl* ( . = 0 )

egen hltexp=rsum(hlcons hlmedc hlproc hloth hlagg)

lab var hlcons     "Consultation fees"
lab var hlmedc     "Medication"
lab var hlproc     "Procedures"
lab var hloth      "Expenditures on health not mentioned elsewhere" 
lab var hlagg      "Expenditures on health at the aggregate level" 
lab var hlhospt    "Hospitalization"
lab var hltexp     "Total monetary value of health"

keep  hid hlcons hlmedc hlproc hlhospt hlagg hloth hltexp

order hid hlcons hlmedc hlproc hloth hlagg hlhospt hltexp
d

sort hid

compress
save "$temp\Module 5 healthexp_Sec2.dta", replace


***********************
*** Part B - Sec 2C ***
***********************
use "$findata\PART B Section 2C-Nonfood last 3 months.dta", clear

replace s2cq2=1   if s2cq2==2 & s2cq3~=.
keep if s2cq2==1

merge m:1 hid using "$temp\hhsize.dta"
tab _m
keep if _m==3
drop _m

ta s2cq3
gen s2c_ann=s2cq3*4
gen pc_s2c=s2c_ann/hhsize
gen ln_pc_s2c= ln(pc_s2c)

tempfile full_3 
save `full_3'
foreach stats in mean median sd {
use `full_3', clear
drop if s2c_ann==0
collapse (`stats') ln_pc_s2c pc_s2c [aw=wta_hh], by(district1 s2cq1)
rename pc_s2c pc_s2c_`stats'
rename ln_pc_s2c ln_pc_s2c_`stats'
tempfile `stats'
save ``stats''
}
use `full_3', clear
merge m:1 district1 s2cq1 using `mean'
drop _merge
merge m:1 district1 s2cq1 using `median'
drop _merge
merge m:1 district1 s2cq1 using `sd'
drop _merge
tabstat  pc_s2c_mean pc_s2c_median pc_s2c_sd, by(s2cq1)   f(%12.2f)
tabstat  ln_pc_s2c_mean ln_pc_s2c_median ln_pc_s2c_sd, by(s2cq1)   f(%12.2f)

gen zscor=(ln_pc_s2c-ln_pc_s2c_mean)/ln_pc_s2c_sd
lab var zscor "Z score for a normal distribution"
count if zscor>3 & zscor~=.

tab s2cq1           if zscor>3 & zscor~=.
tab district1       if zscor>3 & zscor~=.

gen s2c_new=s2c_ann
replace s2c_new=pc_s2c_median*hhsize  if zscor>3 & zscor~=.

tabstat s2c_ann s2c_new,by(s2cq1)       s(mean)  f(%12.2f)

tabstat s2c_ann s2c_new,by(district1)   s(mean)  f(%12.2f)
tabstat s2c_ann s2c_new,by(rururb)      s(mean)  f(%12.2f)

compress
save "$temp\Part B Section 2C.dta",replace


gen hl_medc_2C=s2c_new    if (s2cq1>=132 & s2cq1<=149)
gen hl_cons_2C=s2c_new    if (s2cq1==196) | (s2cq1==208) | (s2cq1>=183 & s2cq1<=192) 
gen hl_hosp_2C=s2c_new    if (s2cq1==182) | (s2cq1>=193 & s2cq1<=194)| (s2cq1>=205 & s2cq1<=206)
gen hl_proc_2C=.
gen hl_oth_2C=s2c_new     if (s2cq1==150) | (s2cq1>=155 & s2cq1<=166) | (s2cq1==176) | (s2cq1>=178 & s2cq1<=180) | (s2cq1>=199 & s2cq1<=204)

collapse (sum) hl_medc_2C hl_cons_2C hl_hosp_2C hl_proc_2C hl_oth_2C,by(hid)
egen hltexp_2C=rsum(hl_medc_2C hl_cons_2C hl_proc_2C hl_oth_2C)

/*
gen hltexp_2C=s2c_new   if (s2cq1>=132 & s2cq1<=150) | (s2cq1>=155 & s2cq1<=166) | (s2cq1>=178 & s2cq1<=180) | (s2cq1>=183 & s2cq1<=192) | (s2cq1>=199 & s2cq1<=204) | (s2cq1==176) | (s2cq1==196) | (s2cq1==208) 

collapse (sum)  hltexp_2C ,by(hid)
*/
compress
save  "$temp\Module 5 healthexp_Sec2C.dta",replace



*************************************
*** merge files and compare costs ***
*************************************
use "$temp\Module 5 healthexp_Sec2.dta",clear

merge 1:1 hid using "$temp\Module 5 healthexp_Sec2C.dta"
tab _m
drop _m

recode hl* (.=0)
sum hl*
//will use combination of Part 1 Sec 2 and Part 2 Sec 2C

ren hltexp hltexpp

egen hltexp=rsum(hltexpp hltexp_2C) // if we decide to  include health expenditure containing in the file last 3 months

*egen hltexp=rsum(hltexpp)  //if we decide to not include health expenditure containing in the file last 3 months

ren hlcons hlconss
ren hlmedc hlmedcc
ren hlproc hlprocc
ren hloth  hlothh 

egen hlcons=rsum(hlconss hltexp_2C)
egen hlmedc=rsum(hlmedcc hl_medc_2C)
egen hlproc=rsum(hlprocc hl_proc_2C)
egen hloth=rsum(hlothh hl_oth_2C)



lab var hlhospt    "Hospitalization"
lab var hlmedc     "Medication"
lab var hloth      "Expenditures on health not mentioned elsewhere" 
*lab var hlinsur    "Health insurance"
*lab var hleqpt     "Therapeutic equipment"
lab var hltexp     "Total monetary value of health" 

drop hl_medc_2C hl_cons_2C hl_hosp_2C hl_proc_2C hl_oth_2C hltexp_2C
drop hlconss hlmedcc hlprocc hlothh hltexpp
 
sort hid

compress

*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
saveold "$fintab\Module 5 healthexp.dta",replace
*************************************************





*+++++++++++++++++++++++++++++++++++++++++++++++++++*
*****************************************************
*** MODULE 6 - FREQUENT NON-FOOD CONSUMPTION ********
*****************************************************
*+++++++++++++++++++++++++++++++++++++++++++++++++++*

******************************
*** Rent ***
******************************
*Data : Section 8 

use "$findata\PART A Section 8-Housing.dta",clear 

keep if hid != ""

*** gas ***
***********
gen unitp=s8aq9a/s8aq9c
sum unitp

tabstat unitp,by(s8aq9b)

bys s8aq9b: egen unit_m=median(unitp)
replace unitp=unit_m  if unitp==. & s8aq9b~=.

gen nfdgas=unitp*s8aq9c*12


*** light ***
*************
gen light    =s8aq14a*12   if s8aq14b==1
replace light=s8aq14a*4    if s8aq14b==2
replace light=s8aq14a*1    if s8aq14b==3

gen light1=light

foreach z of numlist 1(1)2  {                   
sum light  if area==`z', detail
scalar r95_`z'=r(p95)
scalar r1_`z'=r(p1)
replace light=r95_`z'  if (light>r95_`z' & light~=.) & area==`z'
replace light=r1_`z'   if light<r1_`z'  & area==`z'
}

sum light light1

tabstat light light1,by(area)

gen nfdelec=light


*** garbage ***
***************
gen garbage    =s8aq16a*12   if s8aq16b==1
replace garbage=s8aq16a*4    if s8aq16b==2
replace garbage=s8aq16a*1    if s8aq16b==3

gen garbage1=garbage

foreach z of numlist 1(1)2  {                   
sum light  if area==`z', detail
scalar r95_`z'=r(p95)
scalar r1_`z'=r(p1)
replace garbage=r95_`z'  if (garbage>r95_`z' & garbage~=.) & area==`z'
replace garbage=r1_`z'   if garbage<r1_`z'  & area==`z'
}

sum garbage garbage1

tabstat garbage garbage1,by(area)

gen nfdgarb=garbage1

keep hid nfdgas nfdelec nfdgarb

sort hid

compress
saveold "$temp\Module 6 nonfood-Sec 8 util.dta", replace



**********************************************************
**Step 2: PART A
*Data: Section 8
*rent.
use "$findata\PART A Section 8-Housing.dta",clear 

keep if hid != ""

merge 1:1 hid using "$temp\hhsize.dta"
keep if _m==3
drop _m

ta s8aq2

replace s8bq3a=.  if s8bq3a==0
gen     rntif=s8bq3a*12    if s8bq3b==1
replace rntif=s8bq3a*4     if s8bq3b==2
replace rntif=s8bq3a*2     if s8bq3b==3
replace rntif=s8bq3a*1     if s8bq3b==4

replace s8bq6a=.  if s8bq6a==0
replace s8bq6a=s8bq6a/10   if s8bq6a==110000
gen     rntac1=s8bq6a*12   if s8bq6b==1
replace rntac1=s8bq6a*4    if s8bq6b==2
replace rntac1=s8bq6a*2    if s8bq6b==3
replace rntac1=s8bq6a*1    if s8bq6b==4

replace s8bq8a=.  if s8bq8a==0
gen     rntac2=s8bq8a*12   if s8bq8b==1
replace rntac2=s8bq8a*4    if s8bq8b==2
replace rntac2=s8bq8a*2    if s8bq8b==3
replace rntac2=s8bq8a*1    if s8bq8b==4

egen rntac=rsum(rntac1 rntac2) 
replace rntac=.  if rntac1==. & rntac2==.

sum rntif rntac

ta rntac  if rntac<1200   //12 obs - 4 in urban and 8 in rural
replace rntac=.   if rntac<1200 & area==1  //CHECK if this is OK to remove outlier
replace rntac=.   if rntac<900  & area==2  

*actual renters
gen nfdrntac = rntac   
lab var nfdrntac "Actual rent paid"

tabstat nfdrntac, stat (n mean median sd min max) by(district)
tabstat nfdrntac, stat (n mean median sd min max) by(area)

gen dist_new    =1   if district1==10
replace dist_new=2   if district1==20
replace dist_new=3   if dist_new==. & area==1
replace dist_new=4   if dist_new==. & area==2
la define dist_new  1 "Banjul"  2 "Kanifing"  3 "Other urban" 4 "Rural"
la val dist_new dist_new

ta dist_new   if rntac~=.


* select owner occupiers and computing annual estimated rent if they were to rent
gen nfdrntif = rntif
label var nfdrntif "Household's estimate of what they would pay if they rented their dwelling"

tabstat nfdrntif, stat (n mean median sd min max) by(district)
tabstat nfdrntif, stat (n mean median sd min max) by(area)

tabstat nfdrntac nfdrntif,by(district)
tabstat nfdrntac nfdrntif,by(area)

ta s8aq4,m


* number of rooms
gen rooms=s8aq4   
replace rooms = . if ( rooms==0 | rooms>12)
bysort dist_new: egen room_md=median(rooms)
lab var room_md "Mean number of rooms by zone"
replace rooms=room_md  if rooms==.


*log of rooms to smooth out (normal distribution)
gen lnroom  = ln(rooms)
gen lnroom2 = lnroom^2

local testlist = "s8aq2 s8aq5 s8aq6 s8aq8 s8aq12 s8aq15 s8aq17 s8aq18 s8aq22 s8aq23"
foreach var of local testlist {
   tab `var', m
}
corr s8aq2 s8aq5 s8aq6 s8aq8 s8aq12 s8aq15 s8aq17 s8aq18 s8aq22 s8aq23


** log rent
gen lnrent = ln(nfdrntac)


** create dummies.


*rural-urban
tab dist_new, gen(distdum)
 
 
* wall dummy=permanent structure (durable - code 12, 13, 14, 15)
ta s8aq21
gen byte wallperm = cond( inlist( s8aq21, 4 )            , 1, 0 )      if ( s8aq21~=. )
gen byte wallothe = cond( inlist( s8aq21, 1, 2, 3, 5, 6, 9) , 1, 0 )   if ( s8aq21~=. )


* roof dummy=iron sheets
ta s8aq22
gen byte roofperm = cond( inlist ( s8aq22, 2, 3, 4, 5 )    , 1, 0 )   if ( s8aq22~=. )
gen byte roofoth  = cond( inlist ( s8aq22, 1, 6, 9 ) , 1, 0 )   	  if ( s8aq22~=. )


* floor dummy=permanent roof (durable - code 4-5)
ta s8aq23
gen florperm = cond( inlist ( s8aq23, 3, 4, 5 ) , 1, 0 )      if ( s8aq23 ~= . )
gen floroth  = cond( inlist ( s8aq23, 1, 2, 6) , 1, 0 )       if ( s8aq23 ~= . )


* water dummy=unsafe (code 6, 8, 10-96)
ta s8aq6
gen watsafe  = cond( inlist ( s8aq6, 1, 2, 3, 4, 6, 9, 13 )   , 1, 0 )   if ( s8aq6~=. )
gen watunsafe= cond( inlist ( s8aq6, 6, 7, 10,99 ), 1, 0 )   if ( s8aq6~=. )


* toilet dummy=uncovered pit latrine (code 23)
ta s8aq18
gen byte toleflsh = cond( inrange(s8aq18, 1, 3)     			   , 1, 0 )   if ( s8aq18~=. )
gen byte tolelat  = cond( s8aq18==5 | s8aq18==6   				   , 1, 0 )   if ( s8aq18~=. )
gen byte toleoth  = cond( inlist( s8aq18, 4, 7, 8, 9 )                , 1, 0 )   if ( s8aq18~=. )

* garbage disposal=other refuse disposal
gen byte dispcoll = cond( s8aq15==5 | s8aq15==6 | s8aq15==7		   , 1, 0 )   if ( s8aq15~=. )


* cooking fuel=other
ta s8aq8
gen byte cukelec = cond( s8aq8==4 | s8aq8==5 | s8aq8==6           , 1, 0 )   if ( s8aq8~=. )


* lighting fuel
ta s8aq12
gen byte ligtelec = cond( s8aq12==1 | s8aq12==2            		   , 1, 0 )   if ( s8aq12~=. )

* run regression model.
* no accounting for clustering or survey design
reg lnrent lnroom lnroom2 distdum2-distdum4 walloth floroth tolelat toleoth dispcoll ligtelec watunsafe
predict lnrent_hat, xb
gen lnrnthat=exp(lnrent_hat)
lab var lnrnthat "No accounting for clustering or survey design"

* account for clustering
reg lnrent lnroom lnroom2 distdum2-distdum4 wallothe roofoth floroth tolelat toleoth dispcoll ligtelec watunsafe, cluster( eanum )
predict lnrent_cls, xb
gen lnrntcls=exp(lnrent_cls)
lab var lnrntcls "Accounting for clustering"


**The predlog command works if one can assume homoskedastic errors.
*Also note that one should use the predlog command with the raw dependent variable (not logged).
*predlog is self-contained and carries out a regression and then does the necessary extra calculations
*predlog - gives 3 types of predicted values and that is all it does.
*(a) "Straight Retransformation" which is just the exponentiated predicted yhat [exp(yhat)]
*(b) "Naive transformation": adjust the predicted plus half of squared root mean squared error.
*(c) "Duan's Smearing Retransformation": mutiply the exponentiated predicted yhat by the mean value of residuals from the regression (otherwise known as smearing).
*(a) YHAT=exp(yhat)
*(b) YHAT1=exp(yhat+(rmse^2/2))
*(c) YHAT2=YHAT*mean residual
*Duan, Naihua (1983). "Smearing Estimate: A Nonparametric Retransformation Method." {it:Journal of the American Statistical Association}. 78 (383): 605-610.  
*Manning, Willard G. (1998). "The logged dependent variable, heteroscedasticity, and the retransformation problem." {it:Journal of Health Economics}. 17 (3): 283-295.
*Manning, Willard G., and John Mullahy (2001). "Estimating log models: to transform or not to transform?" {it:Journal of Health Economics}. 20 (4): 461-494.  
*fpredict constrains predlog to calculate in-sample predictions only.  The default is to calculate predictions for all possible cases.

*predlog  lnrent rooms distdum2-distdum4 wallothe roofoth floroth tolelat toleoth dispcoll ligtelec watunsafe 
*estimates store model2
*fpredict lnrent_pred 
*gen rent11=exp(YHATRAW)
*gen rent12=exp(YHTNAIVE)
*gen lnrntpred=exp(YHTSMEAR)
*lab var lnrntpred "Predlog method"

**GLM is a flexible generalization of ordinary linear regression that allows for response variables that have other than a normal distribution. 
*GLM generalizes linear regression by allowing the linear model to be related to the response variable via a link function and
*by allowing the magnitude of the variance of each measurement to be a function of its predicted value.


glm lnrent lnroom lnroom2 distdum2-distdum4 wallothe floroth tolelat toleoth dispcoll ligtelec watunsafe , link(log)
estimates store model_glm
predict lnrent_glm
gen lnrntglm=exp(lnrent_glm)
lab var lnrntglm "GLM method"

tabstat lnrnthat lnrntcls  lnrntglm ,by(district1)

/*
erase "$fintab\consumption\Z-output 2b-rent expenditure_hhsize.xls"

*deflated expenditures
foreach var of varlist lga district1 rururb {
tabout `var' [aw=wta_hh] using "${fintab}\consumption\Z-output 2b-rent expenditure_hhsize.xls", sum c(mean lnrnthat mean lnrntcls   ///
	mean lnrntpred mean lnrntglm) append
}
*/

gen nfdrntim = exp( lnrent_glm )   //was lnrent_hat - use GLM
label var nfdrntim "Statistical imputed rent for all households"

gen nfdrnthh = cond( nfdrntac>0 & nfdrntac~=., nfdrntac, nfdrntim )
lab var nfdrnthh "Actual and imputed rent (for missing households)"

tabstat nfdrntac nfdrntif nfdrntim nfdrnthh,by(district1)


*if HH has an actual rent value, assign value if missing then assign predicted from model;

*Actual rent might have some outliers
foreach z of numlist 1(1)4  {                   
sum nfdrntac  if dist_new==`z', detail
scalar r95_`z'=r(p95)
scalar r1_`z' =r(p1)
replace nfdrntac=r95_`z'  if (nfdrntac>r95_`z' & nfdrntac~=.)  & dist_new==`z'
replace nfdrntac=r1_`z'   if nfdrntac<r1_`z'   & dist_new==`z'
}

foreach z of numlist 1(1)4  {                   
sum nfdrnthh  if dist_new==`z', detail
scalar r95_`z'=r(p95)
scalar r1_`z'=r(p1)
replace nfdrnthh=r95_`z'  if (nfdrnthh>r95_`z' & nfdrnthh~=.) & dist_new==`z'
replace nfdrnthh=r1_`z'   if nfdrnthh<r1_`z'  & dist_new==`z'
}

tabstat nfdrntac nfdrntif nfdrntim nfdrnthh,by(lga)

tabstat nfdrntac nfdrntif nfdrntim nfdrnthh,by(district1)

tabstat nfdrntac nfdrntif nfdrntim nfdrnthh,by(area)

keep hid nfdrntac nfdrntif nfdrntim nfdrnthh

sort hid

compress
saveold "$temp\Module 6 nonfood-Sec 8 rent.dta",replace


******************************
*** Other frequent nonfood ***
******************************


***********************
*** housing repairs ***
*****************8*****

use "$findata\PART A Section 8-Housing.dta",clear 

drop if hid==""

rename *,lower

sum s8bq12a s8bq12b s8bq12c

ta s8bq12c

tabstat s8bq12c,by(district)

gen repar=s8bq12c
recode repar (0=.)
replace repar=repar*100   if repar==1
replace repar=repar*100   if repar==2

tabstat repar,by(district)

gen nfdrepar_s8c=repar
replace nfdrepar_s8c=repar/10  if repar==350000

keep hid nfdrepar_s8c

drop if hid==""

compress
saveold "$temp\Module 6 nonfood-Sec 8 repar.dta",replace


***************************
*** Nonfood last 7 days ***
***************************
*Data: Part B Section 2A - last 7 days
use "$findata\PART B Section 2A-Nonfood last 7 days.dta", clear

replace s2aq2=1   if s2aq2==2 & s2aq3~=.
keep if s2aq2==1

merge m:1 hid using "$temp\hhsize.dta"
tab _m
keep if _m==3
drop _m
replace s2aq3=222  if s2aq3==2222222

gen s2a_ann=s2aq3*52
gen pc_s2a=s2a_ann/hhsize

tempfile full_4 
save `full_4'
foreach stats in mean median sd {
use `full_4', clear
drop if pc_s2a==0
collapse (`stats') pc_s2a[aw=wta_hh], by(district1 s2aq1)
rename pc_s2a pc_s2a_`stats'
tempfile `stats'
save ``stats''
}
use `full_4', clear
merge m:1 district1 s2aq1 using `mean'
drop _merge
merge m:1 district1 s2aq1 using `median'
drop _merge
merge m:1 district1 s2aq1 using `sd'
drop _merge
tabstat  pc_s2a_mean pc_s2a_median pc_s2a_sd, by(s2aq1)   f(%12.2f)

gen zscor=(pc_s2a-pc_s2a_mean)/pc_s2a_sd
lab var zscor "Z score for a normal distribution"
count if zscor>3 & zscor~=.

tab s2aq1       if zscor>3 & zscor~=.
tab district1   if zscor>3 & zscor~=.

gen s2a_new=s2a_ann
replace s2a_new=pc_s2a_median*hhsize  if zscor>3 & zscor~=.

tabstat s2a_ann s2a_new,by(s2aq1)       s(mean)  f(%12.2f)
tabstat s2a_ann s2a_new,by(district1)   s(mean)  f(%12.2f)
tabstat s2a_ann s2a_new,by(rururb)      s(mean)  f(%12.2f)

/* 2015
gen nfdtbac     =s2a_new    if s2aq1<=412
gen nfdfmtn_s2a =s2a_new    if s2aq1>=413 & s2aq1<=424
gen nfdrecre_s2a=s2a_new    if s2aq1==425 | s2aq1==429
gen nfdmobi_s2a =s2a_new    if s2aq1>=426 & s2aq1<=427
gen nfdinter_s2a=s2a_new    if s2aq1==428

collapse (sum) nfdtbac nfdfmtn_s2a nfdrecre_s2a nfdmobi_s2a nfdinter_s2a,by(hid)
*/

gen nfd_frequent_Last7Day =s2a_new 

collapse (sum) nfd_frequent_Last7Day ,by(hid)

merge 1:1 hid using "$temp\hhsize.dta"
tab _m
drop _m


**Identification of Lower Outliers 
**********************************
egen  nfd_frequent_Last7Day_md = wpctile(nfd_frequent_Last7Day), w(wta_hh) p(50) 
replace nfd_frequent_Last7Day =nfd_frequent_Last7Day_md  if nfd_frequent_Last7Day ==0

sort hid

compress
saveold "$temp\Module 6 nonfood-Sec 2A 7-days.dta",replace


***************************
*** Nonfood last 1 month ***
***************************
*Data: Part B Section 2B - last 1 month
use "$findata\PART B Section 2B-Nonfood last 1 month.dta", clear

replace s2bq2=1   if s2bq2==2 & s2bq3~=.

keep if s2bq2==1

merge m:1 hid using "$temp\hhsize.dta"
tab _m
keep if _m==3
drop _m


/* I don't know why all this
replace s2bq3=222    if s2bq3==2222222

replace s2bq3=1125   if s2bq3==91125 & s2bq1==622 & hid=="3322416"
replace s2bq3=17500  if s2bq3==75000 & s2bq1==622 & hid=="4120710"
replace s2bq3=15000  if s2bq3==45000 & s2bq1==622 & hid=="5016810"
replace s2bq3=200    if s2bq3==20000 & s2bq1==625 & hid=="4512214"
replace s2bq3=3000  if hid=="8024104" & s2bq1==626
replace s2bq3=2000  if hid=="4120710" & s2bq1==602
*/
gen s2b_ann=s2bq3*12

**replace s2b_ann=s2bq3      if s2bq1>=610 & s2bq1<=617  | s2bq1==620 //one does not buy parts and alarm every month
gen pc_s2b=s2b_ann/hhsize
tempfile full_5 
save `full_5'
foreach stats in mean median sd {
use `full_5', clear
drop if pc_s2b==0
collapse (`stats') pc_s2b [aw=wta_hh], by(district1 s2bq1)
rename pc_s2b pc_s2b_`stats'
tempfile `stats'
save ``stats''
}
use `full_5', clear
merge m:1 district1 s2bq1 using `mean'
drop _merge
merge m:1 district1 s2bq1 using `median'
drop _merge
merge m:1 district1 s2bq1 using `sd'
drop _merge
tabstat  pc_s2b_mean pc_s2b_median pc_s2b_sd, by(s2bq1)   f(%12.2f)

gen zscor=(pc_s2b-pc_s2b_mean)/pc_s2b_sd
lab var zscor "Z score for a normal distribution"
count if zscor>3 & zscor~=.

tab s2bq1           if zscor>3 & zscor~=.
tab district1       if zscor>3 & zscor~=.

gen s2b_new=s2b_ann
replace s2b_new=pc_s2b_median*hhsize  if zscor>3 & zscor~=.

tabstat s2b_ann s2b_new,by(s2bq1)       s(mean)  f(%12.2f)
tabstat s2b_ann s2b_new,by(district1)   s(mean)  f(%12.2f)
tabstat s2b_ann s2b_new,by(rururb)      s(mean)  f(%12.2f)

/* 2015
gen nfdkero      =s2b_new    if s2bq1==600
gen nfdpgen      =s2b_new    if s2bq1==601
gen nfddgen      =s2b_new    if s2bq1==602
gen nfdfwood     =s2b_new    if s2bq1==603
gen nfdchar      =s2b_new    if s2bq1==604
gen nfdbiogas	 =s2b_new    if s2bq1==605 
gen nfdbatt      =s2b_new    if s2bq1==606 
gen nfdbulbs	 =s2b_new	 if s2bq1==607
gen nfdliqd		 =s2b_new    if s2bq1==608
gen nfdsold	 	 =s2b_new    if s2bq1==609
gen nfdtrans     =s2b_new    if s2bq1>=610 & s2bq1<=620 | s2bq1>=623 & s2bq1<=628
gen nfdpetrol    =s2b_new    if s2bq1==621
gen nfddiesel    =s2b_new    if s2bq1==622
gen nfdfare_l    =s2b_new    if s2bq1>=629 & s2bq1<=633 
gen nfdcomm_s2b  =s2b_new    if s2bq1>=634 & s2bq1<=638 
gen nfddome      =s2b_new    if s2bq1>=639 & s2bq1<=644 
gen nfdoth_s2b   =s2b_new    if s2bq1>=645 & s2bq1<=658 

collapse (sum) nfdkero nfdpgen nfddgen nfdfwood nfdchar nfdbiogas nfdbatt nfdbulbs  ///
	nfdliqd nfdsold nfdtrans nfdpetrol nfddiesel nfdfare_l nfdcomm_s2b nfddome nfdoth_s2b,by(hid)
*/

gen nfd_frequent_Last1Mnth =s2b_new  if (s2bq1>=1 & s2bq1<=14)  | (s2bq1>=24 & s2bq1<=119) | (s2bq1>=122 & s2bq1<=123) | (s2bq1>=162 & s2bq1<=163)| (s2bq1>=174 & s2bq1<=179)| (s2bq1>=181 & s2bq1<=220)

// We exclude a couple of good here because they seems to be durables goods. And we don't have the depreciation rate so that we can include them in the durable part.


gen  nfddurable =s2b_new if (s2bq1>=124 & s2bq1<=161) | (s2bq1>=164 & s2bq1<=173)| (s2bq1==180)  // These are the items.


collapse (sum) nfd_frequent_Last1Mnth  nfddurable ,by(hid)

merge 1:1 hid using "$temp\hhsize.dta"
tab _m
drop _m

/*
** Identification of Lower Outliers **
**************************************
egen  nfd_frequent_Last1Mnth_md = wpctile(nfd_frequent_Last1Mnth), w(wta_hh) p(50) 
egen  nfddurable_md = wpctile(nfddurable), w(wta_hh) p(50) 
replace nfddurable=nfddurable_md  if nfddurable==0
replace nfd_frequent_Last1Mnth=nfd_frequent_Last1Mnth_md  if nfd_frequent_Last1Mnth==0
*/

sort hid

compress
save "$temp\Module 6 nonfood-Sec 2B 1-month.dta",replace



****************************
*** Nonfood last 3 month ***
****************************
*Data: Part B Section 2A - last 3 month
*see line XXX for derivation of "$temp\Part B Section 2C.dta"
*use "$findata\PART B Section 2C-Nonfood last 3 month.dta", clear

use "$temp\Part B Section 2C.dta", clear

/*
gen nfdcloth    =s2c_new    if s2cq1<=750 
gen nfdfwear    =s2c_new    if s2cq1>=751 & s2cq1<=782
gen nfdoth_s2c  =s2c_new    if s2cq1>=783 & s2cq1<=790
gen nfdfmtn_s2c =s2c_new    if s2cq1>=791 & s2cq1<=802 
gen nfdrecre_2c =s2c_new    if s2cq1>=803 & s2cq1<=816

collapse (sum) nfdcloth nfdfwear nfdoth_s2c nfdfmtn_s2c nfdrecre_2c,by(hid)
*/

gen nfd_frequent_Last3Mnth =s2c_new  if (s2cq1>=1 & s2cq1<=117)  | (s2cq1>=215 & s2cq1<=237) | (s2cq1>=240 & s2cq1<=241) | (s2cq1>=243 & s2cq1<=264)  

collapse (sum) nfd_frequent_Last3Mnth ,by(hid)

sort hid

compress
saveold "$temp\Module 6 nonfood-Sec 2C 3-month.dta",replace


****************************
*** Nonfood last 12 months ***
****************************
*Data: Part B Section 2D - last 12 months

use "$findata\PART B Section 2D-Nonfood last 12 months.dta", clear

replace s2dq2=1   if s2dq2==2 & s2dq3~=.

keep if s2dq2==1

merge m:1 hid using "$temp\hhsize.dta"
tab _m
keep if _m==3
drop _m

ta s2dq3
/* I don't know why this
replace s2dq3=22     if s2dq3==2222222 & s2dq1==930
replace s2dq3=222    if s2dq3==2222222 & s2dq1==906 
replace s2dq3=22222  if s2dq3==2222222 & s2dq1==935 
replace s2dq3=7000   if s2dq3==70      & s2dq1==935 
replace s2dq3=8000   if s2dq3==800     & s2dq1==935 
replace s2dq3=4000   if s2dq3==400     & s2dq1==935 
replace s2dq3=1200   if s2dq3==120     & s2dq1==935 
*/
gen s2d_ann=s2dq3  
gen pc_s2d=s2d_ann/hhsize
tempfile full_6 
save `full_6'
foreach stats in mean median sd {
use `full_6', clear
drop if pc_s2d==0
collapse (`stats') pc_s2d[aw=wta_hh], by(district1 s2dq1)
rename pc_s2d pc_s2d_`stats'
tempfile `stats'
save ``stats''
}
use `full_6', clear
merge m:1 district1 s2dq1 using `mean'
drop _merge
merge m:1 district1 s2dq1 using `median'
drop _merge
merge m:1 district1 s2dq1 using `sd'
drop _merge
tabstat  pc_s2d_mean pc_s2d_median pc_s2d_sd, by(s2dq1)   f(%12.2f)

gen zscor=(pc_s2d-pc_s2d_mean)/pc_s2d_sd
lab var zscor "Z score for a normal distribution"
count if zscor>3 & zscor~=.

tab s2dq1           if zscor>3 & zscor~=.
tab district1       if zscor>3 & zscor~=.

gen s2d_new=s2d_ann
replace s2d_new=pc_s2d_median*hhsize  if zscor>3 & zscor~=.

tabstat s2d_ann s2d_new,by(s2dq1)       s(mean)  f(%12.2f)

tabstat s2d_ann s2d_new,by(district)   s(mean)  f(%12.2f)
tabstat s2d_ann s2d_new,by(rururb)      s(mean)  f(%12.2f)

compress
saveold "$temp\Part B Section 2D.dta",replace
/*
gen nfdfmtn_s2d  =s2d_new    if s2dq1>=902 & s2dq1<=912 | s2dq1>=930 & s2dq1<=933
gen nfdseppl     =s2d_new    if s2dq1>=913 & s2dq1<=921 
gen nfdsnppl     =s2d_new    if s2dq1>=922 & s2dq1<=929 
gen nfdtrans     =s2d_new    if s2dq1>=939 & s2dq1<=944
gen nfdfare_i    =s2d_new    if s2dq1==945       
gen nfdrecre_s2d =s2d_new    if s2dq1>=953 & s2dq1<=961 
gen nfdinsur     =s2d_new    if s2dq1>=963 & s2dq1<=967
gen nfdcerem     =s2d_new    if s2dq1>=968 & s2dq1<=972
gen nfdrepar_s2d =s2d_new    if s2dq1>=973 & s2dq1<=985 
gen nfdoth_s2d   =s2d_new    if s2dq1>=986 & s2dq1<=989
gen nfdlottery   =s2d_new    if s2dq1>=990 & s2dq1<=992

collapse (sum) nfdfmtn_s2d nfdseppl nfdsnppl nfdtrans nfdfare_i nfdrecre_s2d nfdinsur  ///
	nfdcerem nfdrepar_s2d nfdoth_s2d nfdlottery,by(hid)
*/

gen nfd_frequent_Last12Mnth =s2d_new  if (s2dq1>=4 & s2dq1<=192) | (s2dq1>=216 & s2dq1<=283) | (s2dq1==292) | (s2dq1>=294 & s2dq1<=353)| (s2dq1==358) | (s2dq1>=360 & s2dq1<=396) | (s2dq1>=410 & s2dq1<=487)

collapse (sum) nfd_frequent_Last12Mnth ,by(hid)


merge 1:1 hid using "$temp\hhsize.dta"
tab _m
drop _m

/*
**Identification of Lower Outliers **
*************************************
egen  nfd_frequent_Last12Mnth_md = wpctile(nfd_frequent_Last12Mnth), w(wta_hh) p(50) 
replace nfd_frequent_Last12Mnth =nfd_frequent_Last12Mnth_md  if nfd_frequent_Last12Mnth ==0
*/

sort hid

compress
saveold "$temp\Module 6 nonfood-Sec 2D 12-month.dta",replace


*******************
*** Merge files ***
*******************

use "$temp\Module 6 nonfood-Sec 8 util.dta",clear

merge 1:1 hid using "$temp\Module 6 nonfood-Sec 8 rent.dta"
tab _m
drop _m

merge 1:1 hid using "$temp\Module 6 nonfood-Sec 8 repar.dta"
ta _m
drop _m

merge 1:1 hid using "$temp\Module 6 nonfood-Sec 2A 7-days.dta" 
ta _m
drop _m

merge 1:1 hid using "$temp\Module 6 nonfood-Sec 2B 1-month.dta"
tab _m
drop _m

merge 1:1 hid using "$temp\Module 6 nonfood-Sec 2C 3-month.dta"
tab _m
drop _m

merge 1:1 hid using "$temp\Module 6 nonfood-Sec 2D 12-month.dta"
tab _m
drop _m

lab var nfdrntac 				"Actual rent paid"
lab var nfdrntif 				"Owner-occupied imputed rent"
lab var nfdrntim 				"Statistical Imputed rent"
lab var nfdrnthh 				"Actual and imputed rent for missing households"
lab var nfdelec     			"Electricity" 
lab var nfdgas      			"Gas" 
lab var nfdgarb 				"Refuse disposal and collection"
lab var nfdrepar       			"Housing repair expenditures"	
lab var nfd_frequent_Last7Day	"Expenditures on frequent non-food last 7 Days"
lab var nfd_frequent_Last1Mnth	"Expenditures on frequent non-food last 1 Mnth"
lab var nfd_frequent_Last3Mnth	"Expenditures on frequent non-food last 3 Mnths"	
lab var nfd_frequent_Last12Mnth	"Expenditures on frequent non-food last 12 Mnths"

compress
saveold "$temp\Module 6 temp nfood freq.dta",replace


keep hid nfdrepar nfddurable
compress
save "$temp\Module 7 nonfood-Sec 2D 12-month.dta",replace


use  "$temp\Module 6 temp nfood freq.dta",clear

egen nfdftexp=rsum(nfdgas nfdelec nfdgarb nfdrnthh nfd_frequent_Last7Day nfd_frequent_Last1Mnth nfd_frequent_Last3Mnth nfd_frequent_Last12Mnth) 
lab var nfdftexp 		"Total value of frequent non-food expenditures excluding education and health"

keep hid nfdgas nfdelec nfdgarb nfdrnthh nfdrepar nfd_frequent_Last7Day nfd_frequent_Last1Mnth nfd_frequent_Last3Mnth nfd_frequent_Last12Mnth  nfdftexp

order hid nfdgas nfdelec nfdgarb nfdrnthh nfdrepar nfd_frequent_Last7Day nfd_frequent_Last1Mnth nfd_frequent_Last3Mnth nfd_frequent_Last12Mnth nfdftexp 
d

sort hid

compress

*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
save "$fintab\Module 6 nfood freq.dta", replace 
**************************************************************



/*
*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*
******************************************************************
*********** MODULE 7 - INFREQUENT NON-FOOD CONSUMPTION ***********
******************************************************************
*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*

use "$findata1\Ownership of Durable Assets.dta", clear
* WE ARE GOING TO ASSUME THERE IS ONLY ONE VALUE PER DURABLE ITEM

*1. Finding out the lifespan of each type of durable. We will use twice the median of the number of years people have this item.

*lifespan per item
for var s9q4_1 s9q4_2 s9q6_1 s9q6_2 s9q3: recode X 98=. 99=.
egen double Med1=median(s9q4_1), by(s9q1)
egen double Med2=median(s9q4_2), by(s9q1)
gen double lifespan1=2*Med1
gen double lifespan2=2*Med2

*Number of remainding years
gen double rem_lif1=max(2*Med1-s9q4_1,2)
gen double rem_lif2=max(2*Med2-s9q4_2,2)

*Annual usage value dividing current valus into remaining years of use.
gen t_gdura1_0=s9q6_1/rem_lif1
gen t_gdura2_0=s9q6_2/rem_lif2

*durable value for all items
gen gdura1_0=t_gdura1_0*s9q3

gen double gdura2_0A=t_gdura1_0
gen double gdura2_0B=t_gdura2_0*(s9q3-1) if s9q3>=2 & !mi(s9q3)
egen double	gdura2_0 =rsum(gdura2_0A gdura2_0B)
collapse (sum) gdura1_0 gdura2_0, by(hid)

lab var gdura1_0 "Large investment expenditure (purchase of household durable assets)"
lab var gdura2_0 "Large investment expenditure (purchase of household durable assets)"

gen nfditexp = gdura2_0
lab var nfditexp "Total infrequent non-food expenditure excluding rent, education and health"

sort hid
compress

*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
saveold "$fintab\Module 7 nfood infreq.dta", replace
****************************************************
*/




*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*
****************************************************************
*********** MODULE 7 - INFREQUENT NON-FOOD CONSUMPTION *********
****************************************************************
*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*

* deflators for durable goods.
* provided by Macro Economic Dept in EXCEL (Prices Unit division).
* these are CPI which adjusts the purchase price to current prices.
* This CPI data indexes items to September 2020 (one can chose any month as the reference).  Selected midpoint.

clear
import excel "$othdata\GMB CPI.xlsx", sheet("GMB CPI editted") firstrow clear

drop if Year==.
drop G

ren Year year
ren Month month_name
ren AllItem cpi_all 
ren Food cpi_food 
ren NonFood cpi_nonfood

lab var year       "Year"
lab var month      "Month" 
lab var month_name "Month name" 
lab var cpi_all    "CPI index (all item)"

*select a reference period (base July 2020=100)
*mid-point of survey

gen refyear=cpi_all if year==2020 & month==7
egen baseyear=total(refyear)
lab var baseyear "Reference time"
drop refyear

gen cpib=cpi_all/baseyear
lab var cpib  "Durable goods deflator"

sort year month

compress
saveold "$fintab\Z-Durable goods deflators.dta", replace


***********************************
****stack file for easy to work
***********************************

*first item
use "$findata_up\PARTA  Section9 - Ownership of durable assets_update_May20_2022.dta", clear

*use "$findata\PART A Section 9-Ownership of durable assets.dta", clear


keep if s9q2==1
gen item=1   if s9q2==1

ren s9q4_1 age 
ren s9q5_1 purchase
ren s9q6_1  sale

keep  hid-s9q3 item age purchase sale 
order hid-s9q3 item age purchase sale 

compress
saveold "$temp\durable good first.dta", replace


*second item
use "$findata_up\PARTA  Section9 - Ownership of durable assets_update_May20_2022.dta", clear

*use "$findata\PART A Section 9-Ownership of durable assets.dta", clear

keep if s9q2==1

gen item=2     if s9q2==1

ren s9q4_2  age 
ren s9q5_2 purchase
ren s9q6_2 sale

keep  hid-PT1_Sect_9  s9q1 item age purchase sale 
order hid-PT1_Sect_9  s9q1 item age purchase sale 

drop if age==. & purchase==. & sale==.

compress
saveold "$temp\durable good second.dta", replace


*merge the two durable files.
**********************************
use "$temp\durable good first.dta",clear
append using "$temp\durable good second.dta"

sort hid s9q1 item

drop s9q2 s9q3 

tab s9q1

sort hid s9q1 

compress
saveold "$temp\durable1.dta", replace


**exclude all production items - home, land, boat, canoes and outboard from computation.
*for canoes and company, these are not luxuries but are used for household sustenance. 
*These generate income for household and this is used for basic household expenditure (production goods).
*house excluded for captured in rent model to avoid double counting
*will drop motorcycle as well.
*drop if s9q1>=37 & s9q1<=41 | s9q1==35

count if age==.
count if purchase==.
count if sale==.

**drop households with missing age, purchase and sale price.
count if age==. & purchase==. & sale==.
drop  if age==. & purchase==. & sale==.

**drop households with missing purchase and sale price.
*Records with zero amount in both sale and purchase (sale=0 and purchase=0) deleted.
count if age~=. & purchase==. & sale==.

gen valid=0      if purchase==. & sale==.
replace valid=1  if valid==. & purchase==0 & sale==0
replace valid=2  if valid==. & purchase==.d & sale==.d  
replace valid=3  if valid==. & purchase==.d & sale==.
replace valid=4  if valid==. & purchase==.  & sale==.d
tab valid
keep if valid==.
drop valid

*if either purchase/sale is zero and vice versa==. drop.
gen valid=0      if purchase==0 & sale==.
replace valid=1  if purchase==. & sale==0
tab valid
keep if valid==.
drop valid

tabstat age purchase sale,by(s9q1)    s(mean median min max) 

**if purchase or sale prices missing impute by median by item type.
recode age (.d=.) 
recode purchase sale (.d=.) 

bys s9q1: egen agemed=median(age)
gen age1=age
replace age=agemed 		if age==.					    	//Replace, for age of item, missings with median value

gen purchase1=purchase
replace purchase=.  		if purchase==0
bys lga s9q1 age: egen purmed=median(purchase)
replace purchase=purmed 	if purchase==0 | purchase==.	//Replace, for purchase price of item, missing and zeros with median value
count if purchase==.
bys lga s9q1: egen purmed1=median(purchase)
replace purchase=purmed1 	if purchase==.               	//Replace, for purchase price of item, missing 

gen sale1=sale
replace sale=.  			if sale==0
bys lga s9q1 age: egen salemed=median(sale)
replace sale=salemed 		if sale==0 | sale==.			//Replace, for sa;e price of item, missing and zeros with median value
count if sale==.
bys lga s9q1: egen salemed1=median(sale)
replace sale=salemed1 		if sale==.                      //Replace, for sale price of item, missing 

drop purmed purmed1 salemed salemed1

sort hid s9q1 

compress
saveold "$temp\durable2.dta", replace

**edit prices.
*Some obvious data entry errors.



***keep only if purchases is greater than 0.
*Selecting the first item declared only if NOT older than five years.  
*********************************************************************
use "$temp\durable2.dta", clear

keep if purchase>0 & purchase~=.

keep if age<=16          //based on availability of CPI.  Need to bring prices to current prices.

tabstat purchase,by(s9q1)

sort hid 
merge m:1 hid using "$temp\hhsize.dta" 
tab _m
keep if _m==3
drop _m

ren int_month month 
ren int_year  year

sort month year

gen year1=year
drop year


*the derived below refers to the year when the item was purchased.
gen year=year1-age
tab year


sort month year
merge m:1 year month using  "$fintab\Z-Durable goods deflators.dta"
tab _m
keep if _m==3
drop _m


*if items aged less than one year, survey asked an entry of zero.
*presence of items with age zero, will assume correct age.
*however, code does not work with zero age and will assign 6 months as age (0.5 years).
*convert age of item in years to months.
gen agem = (age*12)  
replace agem=6 if age==0
lab var agem "Age of item (imputed 6 months for zero year)"


*purchase should be deflated CPI composite price - done in 2003-04.
*make all past values real.
gen dpp = purchase/cpib 
lab var dpp "Deflated purchase price (to current prices)"


***METHOD 1 
*Refer to Deaton and Zaidi page 107.
gen rate=(27-5.97)/100   //this is the lending rate adjusted for inflation.  Commerical Bank discount rate is 27% and Central Bank is 23%.  Inflation is about Source: Central Bank website : 5.97%.  
	//Will use Comemrical Bank rate because that is what people pay for credit.
lab var rate "Estimated real interest rate"

**depreciation rates.
*depre by item range from negative to positive values.
*assume items distributed evenly over time and thus use median.

gen depre1 = 1 - (sale/dpp)^(1/(agem/12))    
lab var depre1 "Depreciation rate by item at the HH - method 2"
tabstat depre1,by(s9q1)  s(mean N median min max)    //observe depreciation rates generated from table.
		//median rates are utilised (see next line of code) as this varies from negative to positive.

bys s9q1: egen depre1_md=median(depre1)     //derive depreciation rates into file.
		//assumes that durables purchases are uniformly distributed in time and thus use median.

gen usevalue1 = sale*(rate+depre1_md)/(1-depre1_md) 
lab var usevalue1 "Use value - method 1"


***METHOD 2: uses sale (value of durable good at time of survey) of item and age.
bys s9q1: egen age_mn=mean(age)

gen age_mn2=age_mn*2          	//average lifetime of each duable good
								//under the assumption that purchases are uniformly distributed over time

gen lifetime=(age_mn2-age)
replace lifetime=2   if lifetime<2    //arbitrarily "rounded up"to 2 years when less.

gen usevalue2=sale/(age_mn2-age)
lab var usevalue2 "Use value - method 2"


***METHOD 3: uses sale price and age 
*age inverse is the depreciation rate.
gen depre3 = 1/(2*agem)             					//where 2*age is the expected lifespan of durable good
gen usevalue3 = sale*((rate+depre3)/(1-depre3))
lab var usevalue3 "Use value - method 3"


***** METHOD 4 (Handbook on Poverty and Equality by Jonathan Haughton) 
* Straight line depreciation
gen price1 = purchase/cpib    //bring the former price in the present

gen valide = ! ( sale > price1 & sale !=. & price1 !=.)

gen diffPurchaseSale = price1-sale 				if valide==1
gen annDepreciation = diffPurchaseSale/age 		if age !=0
replace annDepreciation = diffPurchaseSale 		if age==0

gen interestCost = annDepreciation*((27-5.97)/100)   //Compute the interest cost

egen usevalue4=rsum(interestCost annDepreciation)   //Consomption cost
lab var usevalue4 "Use value - method 4"

tabstat usevalue4, stat(mean p50 cv) by (s9q1)      //Imputation for the non-valid

compress
saveold "$temp\durable3.dta", replace 


**aggregate total use value irrespective of asset to HH-level.
	
collapse (sum) usevalue1 usevalue2 usevalue3 usevalue4, by(lga district1 area hid)

order hid usevalue1 usevalue2 usevalue3 usevalue4

sum usevalue1 usevalue2 usevalue3 usevalue4

tabstat usevalue1 usevalue2 usevalue3 usevalue4,by(lga)
tabstat usevalue1 usevalue2 usevalue3 usevalue4,by(district1)
tabstat usevalue1 usevalue2 usevalue3 usevalue4,by(area)
 
keep hid usevalue1
ren usevalue1 nfdusevalue

sort hid

compress
saveold "$temp\nfdusevalue1.dta", replace

**********************************************************
***durables last 12 months.
*these are items purchased during the survey period.  Survey period was 12 months.
*kitchen utensils fall under NFDFMTN.
*large items (NFDINVES) will not be included in the final household consumption as these are durables.
*and use value over time is dereived.  
*see USE VALUE computations above on durables.

use "$temp\durable1.dta", clear
keep if age<=1

collapse (sum) purchase,by(hid)

ren purchase nfdinves
lab var nfdinves "Large investment expenditure (purchase of household durable assets)"

sort hid

compress
saveold "$temp\large investments.dta", replace

/*
**************************
*** transfer received. ***

*includes cash, food and in-kind transfers.
*food gift would be double counting food expenditure if included.
*it will be assumed that the value derived here is reflected in total food and will not be included again.

use "$findata\Part A Section 12A-Transfers received.dta", clear

*sum s12aq7 s12aq8 s12aq9

gen nfdremcs=s12aq7 

gen nfdremfd=s12aq8 

gen nfdremot=s12aq9

collapse (sum) nfdremcs nfdremfd nfdremot,by(hid)

replace nfdremcs=360000  if nfdremcs>360000 & nfdremcs~=.
replace nfdremfd=175000  if nfdremfd>200000 & nfdremfd~=.
replace nfdremot=400000  if nfdremot>400000 & nfdremot~=.

lab var nfdremcs "Cash transfer received"
lab var nfdremfd "Food transfer received"
lab var nfdremot "Other transfer received"

sort hid

compress
saveold "$temp\remittances.dta", replace
*/

*****************
** Merge files **

use "$temp\Module 7 nonfood-Sec 2D 12-month.dta"

merge 1:1 hid using "$temp\nfdusevalue1.dta"
tab _m
drop _m

merge 1:1 hid using "$temp\large investments.dta"
tab _m
drop _m

*merge 1:1 hid using  "$temp\remittances.dta"
*ta _m
*drop _m

*egen nfditexp=rsum(nfdseppl nfdsnppl nfdrepar nfdusevalue)
*egen nfditexp=rsum(nfdusevalue nfddurable) // if we add the durables from Non food last 3 months

egen nfditexp=rsum(nfdusevalue nfdrepar) 

*lab var nfdseppl 		"Electrical items"
*lab var nfdsnppl 		"Non-electric items"
lab var nfdrepar 		"Household minor repairs and services"
lab var nfddurable      "Household durable last 1Mnth"
*lab var nfdlottery 		"Lottery tickets/gambling"
*lab var nfdcerem    	"Ceemonies (non-regular expenditure)"
lab var nfditexp    	"Total infrequent non-food expenditure excluding rent, education and health"


merge 1:1 hid using "$temp\hhsize.dta"
tab _m
drop _m

/*
**Identification of Lower Outliers 
**********************************
egen  nfditexp_md = wpctile(nfditexp), w(wta_hh) p(50) 
replace nfditexp =nfditexp_md  if nfditexp==0
*/

d

sort hid

compress

*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
saveold "$fintab\Module 7 nfood infreq.dta", replace  
*******************************************************



*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*********************************************************************
****** MODULE 8 - MERGE ALL THE CONSUMPTION AGGREGATE FILES ********
*********************************************************************++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*

use "$fintab\Module 1 basicinfo.dta",clear

merge 1:1 hid using  "$fintab\Module 2 foodpurchexp.dta" 
tab _m
drop _m

merge 1:1 hid using  "$fintab\Module 3 ownconsexp.dta"
tab _m
drop _m

merge 1:1 hid using  "$fintab\Module 4 educexp.dta"
tab _m
drop _m

merge 1:1 hid using  "$fintab\Module 5 healthexp.dta"
tab _m
drop _m

merge 1:1 hid using  "$fintab\Module 6 nfood freq.dta"
tab _m
drop _m

merge 1:1 hid using  "$fintab\Module 7 nfood infreq.dta"
tab _m
drop _m

count  if hhsize>0 & hhsize~=.  //all valid HHs
drop if hhsize==.

tab int_month,m 

recode fd* ed* hl* nfd* (.=0)

egen fdtexp = rsum(fdtotby fdtotpr)
label var fdtexp "Total purchased and auto-consumption food expenditure"

count  if fdtexp==0  //13 have zero food.  Not possible in real life as minimum food required for basic survival
*HHs with large food expenditures will also be dropped!!!!
count  if fdtexp>500000*1.4029    //199 obs; 

gen rent=nfdrnthh
bys district1: egen med_rnt=median(nfdrnthh)
replace nfdrnthh=med_rnt   if nfdrnthh==0

gen nfd1=nfdftexp
replace nfdftexp=(nfd1-rent)+nfdrnthh
sum nfd1 nfdftexp
drop nfd1 rent med_rnt

egen nfdtexp = rowtotal(edtexp hltexp nfdftexp nfditexp) // if including health

*egen nfdtexp = rowtotal(edtexp  nfdftexp nfditexp) // if not include health 
label var nfdtexp "Total non-food consumption expenditure"

egen hhtexp = rowtotal(fdtexp nfdtexp)
label var hhtexp  "Total household food and non-food consumption expenditure"

*generate per capita and per adult equivalent expenditure
gen pc_fd = fdtexp/hhsize
label var pc_fd   "Per capita total household food consumption expenditure"

gen pc_hh = hhtexp/hhsize
label var pc_hh   "Per capita total household food and non-food consumption expenditure"

gen padq_fd = fdtexp/ctry_adq
label var padq_fd   "Per adult equivalent total household food consumption expenditure"

gen padq_hh = hhtexp/ctry_adq
label var padq_hh   "Per adult equivalent total household food and non-food consumption expenditure"

gen padq_hhF = hhtexp/fao_adq
label var padq_hhF   "Per adult equivalent total household food and non-food consumption expenditure (FAO)"

sum padq_hh padq_hhF pc_hh 

drop padq_hhF 


**Second weight generated for consumption
*other one retained for other files.
****************************************** 
egen asd=total(wta_pop)
bys cluster:egen totpop=total(wta_pop)

bys cluster:egen totpop1=total(wta_pop)   if fdtexp>0 & fdtexp<=500000*1.4029  //93 obs to be dropped - 78 have zero food expenditure
		//and 15 have outragous food expenditure.  These HHs were revisited to peruse data and extremely difficult to guestimate some reasonable values 

gen ratio=totpop/totpop1    if fdtexp>0 & fdtexp<=500000*1.4029 

gen wta_hh_c=wta_hh*ratio
gen wta_pop_c=wta_hh_c*hhsize
gen wta_cadq_c=wta_hh_c*ctry_adq
la var wta_hh_c    "Household weighting coefficient (for poverty analyses)"
la var wta_pop_c   "Population weighting coefficient (for poverty analyses)"
la var wta_cadq_c  "Adult equivalent population weighting coefficient (for poverty analyses)"

bys cluster:egen totpop2=total(wta_pop_c)

egen asd2=total(wta_pop)
egen asd3=total(wta_pop_c)

drop asd-ratio totpop2 asd2 asd3


order cycle-wta_cadq wta_hh_c wta_pop_c wta_cadq_c

drop wta_pop wta_hh wta_cadq

drop if fdtexp==0 | fdtexp>500000*1.4029  //212 obs dropped


**********************************************************
***quintile groupings by area of residence and population distribution and annual per capita expenditure (undeflated).

*takes into account area of residence (rural or urban).
*quintiles (5 equal groups) and deciles (10 equal groupd) weighted by population.

xtile qrur = pc_hh if rururb==0 [pweight=wta_pop_c], nq(5) 
xtile qurb = pc_hh if rururb==1 [pweight=wta_pop_c], nq(5) 
gen quintile=qrur
replace quintile=qurb if quintile==.
label var quintile  "Undeflated quintile by RURURB and PC_HH (5 groups)"

*national quintile groupings by population distribution and annual per capita expenditure.
*does not take into account area of residence (rural or urban).

xtile nquintil=pc_hh [aw=wta_pop_c],nq(5)
label var nquintil  "National undeflated quintile by PC_HH (5 groups)"

**national decile groupings by population distribution and annual per capita expenditure.
*does not take into account area of residence (rural or urban).

xtile ndecil=pc_hh [aw=wta_pop_c],nq(10)
label var ndecil  "National undeflated decile by PC_HH (5 groups)"

sort hid

compress
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
saveold "$fintab\Module 8 nominal consagg.dta", replace  
**********************************************************



**********************************************************
*the below file is used for price deflators derivation.
**********************************************************
collapse (sum) wta_pop_c,by(district1)
lab var wta_pop_c "Population size by district"

egen tot_pop=total(wta_pop_c)
format  tot_pop %15.0g
lab var tot_pop "Total population for country"

ren wta_pop_c district_pop

sort district1

compress
saveold "$temp\district pop.dta", replace



**********************
*** BASIC ANALYSES ***
**********************

use "$fintab\Module 8 nominal consagg.dta",clear

label var qrur  "Rural undeflated quintile by PC_HH (5 groups)"
label var qurb  "Urban undeflated quintile by PC_HH (5 groups)"
 


cap erase "${fintab}\Z-output 1a-sample size.xls"
cap erase "${fintab}\Z-output 1b-hhsize_adq.xls"


**sample size
foreach var of varlist lga district1 rururb quintil qrur qurb nquintil ndecil year_mth{
tabout `var' [aw=wta_hh_c] using "${fintab}\Z-output 1a-sample size.xls", append
}

**household size
foreach var of varlist lga district1 rururb quintil qrur qurb nquintil ndecil year_mth{
tabout `var' [aw=wta_hh_c] using "${fintab}\Z-output 1b-hhsize_adq.xls", sum c(mean hhsize mean ctry_adq mean fao_adq) append
}



**************
*** THE END
**************
