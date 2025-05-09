**************************************************************************
** World Bank Poverty and Equity GP -  International poverty estimate
** COUNTRY			The Gambia
** COUNTRY ISO CODE	GMB
** YEAR				2020
** SURVEY NAME		IHS 2020
** PREPARED BY		Rostand Tchouakam Mbouendeu
**                  email: rtchouakammbouen@worldbank.org
**                  January 2022
***************************************************************************

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

*++++++++++++++++ CHANGE THIS PATH TO YOUR IHS 2020 FOLDER TO RUN +++++++*
global path "C:\Users\tchou\Desktop\IHS2020"
***************************************************************************

global findata     ${path}\01.Data\Stata
global othdata     ${path}\01.Data\Other
global fintab      ${path}\04.Results\output
global logs        ${path}\04.Results\logfiles
global temp        ${path}\04.Results\temp

log using "$logs\4-International poverty estimate 2020 GMB.log" , replace



** Data loading
use "${fintab}\Module 8 nominal consagg.dta",clear


** 1. The mean in local currency (GMD)  
gen welfare_Mnth =pc_hh/12  //pc_hh is Per capita total household food and non-food consumption expenditure
tabstat welfare_Mnth [weight=wta_pop_c ]


** 2. The mean in $PPP. For that you will need to use the CPI from IMF IFS and the PPP
gen ppp = 10.911632 // From the File PPP and CPI 2020
gen cpi=1.756248       // From the File PPP and CPI 2020
gen welfare_ppp = pc_hh/(cpi*ppp)
gen welfare_ppp_Mnth = welfare_ppp/12
tabstat welfare_ppp_Mnth [weight=wta_pop_c]

** 3. Replication of the headcount poverty rate
gen welfare_ppp_day = welfare_ppp/365
gen pov_line_ppp_day = 1.9
gen poor = 1 if welfare_ppp_day <= pov_line_ppp_day
replace poor = 0 if welfare_ppp_day > pov_line_ppp_day
tabstat poor [weight=wta_pop_c]

**END

tabstat poor  [weight=wta_pop_c],by(quarter)
tabstat poor [weight=wta_pop_c],by(rururb)
tabstat poor  [weight=wta_pop_c],by(lga)