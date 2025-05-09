* * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* ####################################################### *
* #                                                     # *
* #           GAMBIA IHS 2020 FOOD BASKET               # *
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
***************************************************************************

global findata     ${path}\01.Data\Stata
global othdata     ${path}\01.Data\Other
global fintab      ${path}\04.Results\output
global logs        ${path}\04.Results\logfiles
global temp        ${path}\04.Results\temp


log using "$logs\5- GMB 2020 food basket_hhsize.log" , replace


*********************************************
*********************************************
**  BASIC POPULATION AND FOOD EXPENDITURE  **
*********************************************
*********************************************

** generate population and percentiles.

use "$fintab\Module 8 nominal consagg.dta", clear

keep if wta_hh_c~=.

egen pophh=total(wta_pop_c)
lab var pophh "Total population"

egen popcadq=total(wta_cadq_c)
lab var popcadq "Adult equivalent total population"
format pophh popcadq %12.2f

*takes into account area of residence (rural or urban).
*percentiles (100 equal groups) weighted by population for rural and urban respectively.

xtile prur = pc_hh  if rururb==0 [pweight=wta_pop_c], nq(100) 
xtile purb = pc_hh  if rururb==1 [pweight=wta_pop_c], nq(100) 
gen percentile=prur
replace percentile=purb if percentile==.
label var prur        "Rural undeflated percentile by PCEXP"
label var purb  	  "Urban undeflated percentile by PCEXP"
label var percentile  "Undeflated percentile PCEXP accounting for RURURB"

*national percentile groupings by population distribution 
*does not take into account area of residence (rural or urban).

xtile npercentile=pc_hh[aw=wta_pop_c],nq(100)
label var npercentile  "National undeflated percentile by PCEXP"

keep  lga district1 rururb hid ctry_adq hhsize wta_hh_c wta_cadq_c wta_pop_c pophh popcadq fdtexp nfdtexp hhtexp prur purb percentile npercentile 
	
order lga district1 rururb hid ctry_adq hhsize wta_hh_c wta_cadq_c wta_pop_c pophh popcadq fdtexp nfdtexp hhtexp prur purb percentile npercentile 

sort hid

compress
saveold "$temp\HH quintile-decil_hhsize.dta", replace


**********************************************************
**make sure each HH has the same number of items

use "$fintab\Filtered Sec1_Food basket.dta", clear

sort hid s1aq1

*check equal number of items
ta s1aq1

compress
saveold "$temp\food item expenditure equal items.dta",replace

**General methdology of deriving a basket
*Use the food items which account for higher shares of food to include in the basket
*several steps (a) all items (b) drop items "other" as cannoo derive calories (c) drop items with low shares
*food items should represent the commonly consumed items by the poor.
*who are the reference group?
*2005: Rural and urban done separately - 35 to 55 percentiles of the rural and the 25 to 45 percentiles of the urban price-adjusted weighted 
*food consumption distributions represented the optimal bandwidth for computing the respective food poverty lines.

**************************************************************************************************************************
**NATIONAL BASKET
**************************************************************************************************************************

*Step 1: keep reference population and sum up total food

use "$temp\HH quintile-decil_hhsize.dta", clear

gen N_n2555=fdtexp     if npercentile>=25 & npercentile<=55
gen N_n3055=fdtexp     if npercentile>=30 & npercentile<=55
gen N_n3555=fdtexp     if npercentile>=35 & npercentile<=55

compress
saveold "$temp\HH quintile-decil_0.dta" , replace


*weighted by adult equivalent because poverty lines based on that. 
local vars = "N_n2555 N_n3055 N_n3555"

foreach var of local vars {
use "$temp\HH quintile-decil_0.dta" , clear
collapse (sum) `var' [aw = wta_pop_c]
gen number = 1     
format `var' %15.2f
compress
saveold "$temp/`var'.dta" , replace
}
*

use "$temp/N_n2555.dta",clear
merge 1:1 number using "$temp/N_n3055.dta"
drop _m
merge 1:1 number using "$temp/N_n3555.dta"
drop _m

ren *55 *55_tot

order number

compress
saveold "$temp\total food_2-6 deciles_hhsize.dta",replace


**********************************************************
*Step 2: merge in item foods.
*Combine file with item level expenditure and aggregate food expenditure to create food shares

use "$temp\HH quintile-decil_hhsize.dta", clear

sort hid
merge 1:m hid using  "$temp\food item expenditure equal items.dta"
tab _m
keep if _m==3
drop _m

gen number=1
merge m:1 number using  "$temp\total food_2-6 deciles_hhsize.dta"
tab _m
keep if _m==3
drop _m

gen N_n2555=1     if npercentile>=25 & npercentile<=55
gen N_n3055=1     if npercentile>=30 & npercentile<=55
gen N_n3555=1     if npercentile>=35 & npercentile<=55

tab s1aq1

sort hid s1aq1

compress
saveold "$temp\total food_2-6 deciles_1_hhsize.dta",replace


**********************************************************
**Step 3: obtain the shares of each item in the reference group
*all items

use "$temp\total food_2-6 deciles_1_hhsize.dta",clear

foreach var of varlist N_n2555 - N_n3555 {
    gen `var'share = (itemexp/`var'_tot)*100 
	replace `var'share = . if `var'==.
	lab var `var'share "Food item share to total food"
	}


collapse (sum) *share [aw=wta_pop_c],by(s1aq1)

foreach var of varlist N_n2555share-N_n3555share {
gsort -`var'
gen `var'_rank = _n
order `var'_rank , after(`var')
}


compress
saveold "$fintab\Food basket_National-all items_hhsize.dta", replace


**********************************************************
**Step 4: drop foods that prices/calories cannot be easily derived.
*this excludes items classified as "other" and hotel/cafe (difficult to assign calories)
**obtain the shares of each item 

use "$temp\total food_2-6 deciles_1_hhsize.dta",clear


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
	
sort hid s1aq1


foreach var of varlist N_n2555 - N_n3555 {
    gen `var'share = (itemexp/`var'_tot)*100 
	replace `var'share = . if `var'==.
	lab var `var'share "Food item share to total food"
	}
*

collapse (sum) *share [aw=wta_pop_c],by(s1aq1)

foreach var of varlist N_n2555share-N_n3555share {
gsort -`var'
gen `var'_rank = _n
order `var'_rank , after(`var')
}
*

sort s1aq1

compress
saveold "$fintab\Food basket_National-excl other_hhsize.dta", replace


**********************************************************
**Step 5: drop foods that prices/calories cannot be derived.
*this excludes items classified as "other"
*this excludes items with very low food shares

use "$fintab\Food basket_National-excl other_hhsize.dta",clear

drop N_n2555share_rank N_n3055share_rank N_n3555share_rank


foreach var of varlist N_n2555share-N_n3555share {

replace `var'=.   if `var'<=0.3

egen `var'_tot=total(`var')  if `var'~=.

gen `var'_wtshare=`var'*100/`var'_tot
gsort -`var'_wtshare
gen `var'_rank = _n   if `var'~=.
order `var'_rank , after(`var')
}
*

sort s1aq1


drop N_n2555share N_n3055share N_n3555share  *_tot

order s1aq1 N_n2555share_wtshare N_n2555share_rank N_n3055share_wtshare N_n3055share_rank N_n3555share_wtshare N_n3555share_rank 

compress
saveold "$fintab\Food basket_National-final_hhsize.dta", replace


sort N_n3555share_rank
export excel s1aq1-N_n3555share_rank using "$fintab\Z-output.xls", sheet("food basket-pcap") sheetreplace firstrow(variables) nolabel



use "$fintab\Food basket_National-final_hhsize.dta", clear
keep s1aq1 N_n2555share_wtshare N_n2555share_rank
rename N_n2555share_wtshare wtshare 
rename  N_n2555share_rank fdrank
drop if fdrank==.
order s1aq1 fdrank wtshare
compress
saveold "$fintab\Food basket_National-final_hhsize-2555.dta", replace

use "$fintab\Food basket_National-final_hhsize.dta", clear
keep s1aq1 N_n3055share_wtshare N_n3055share_rank
rename N_n3055share_wtshare   wtshare 
rename  N_n3055share_rank   fdrank
drop if fdrank==.
order s1aq1 fdrank wtshare
compress
saveold "$fintab\Food basket_National-final_hhsize-3055.dta", replace

use "$fintab\Food basket_National-final_hhsize.dta", clear
keep s1aq1 N_n3555share_wtshare N_n3555share_rank
rename N_n3555share_wtshare   wtshare 
rename  N_n3555share_rank   fdrank
drop if fdrank==.
order s1aq1 fdrank wtshare
compress
saveold "$fintab\Food basket_National-final_hhsize-3555.dta", replace


*check if all prices exist for final national basket.


******************
*** THE END
******************