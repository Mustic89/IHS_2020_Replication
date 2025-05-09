* * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* ####################################################### *
* #                                                     # *
* #        GAMBIA IHS 2020 POVERTY MEASUREMENT          # *
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

*++++++++++++ CHANGE THIS PATH TO YOUR IHS 2020 FOLDER TO RUN ++++++++++++*
global path  "C:\Users\tchou\Desktop\IHS2020"
***************************************************************************

global findata     ${path}\01.Data\Stata
global othdata     ${path}\01.Data\Other
global fintab      ${path}\04.Results\output
global logs        ${path}\04.Results\logfiles
global temp        ${path}\04.Results\temp


log using "$logs\9-GMB 2020 poverty measures hhsize.log" , replace


**************************************************************************************************************************
**MERGE IN POVERTY LINES and FINALIZE MODULE 10
**************************************************************************************************************************
***use 2400 calories food poverty line.
**per capita poverty lines

use "$fintab\GMB_IHS2020_E_hhsize.dta", clear

*use "C:\Users\Rostand Tchouakam\Desktop\World Bank Group\Welfare Aggregate\GMB\IHS2015\output\Consumption\GMB_IHS2015_E_hhsize.dta",clear // 2015

**********************************************************
**poverty estimates

*food poverty
sepov  pc_fddr [w=wta_pop_c], p(pl_fd)
sepov  pc_fddr [w=wta_pop_c], p(pl_fd)	by (lga)
sepov  pc_fddr [w=wta_pop_c], p(pl_fd) 	by (rururb)
sepov  pc_fddr [w=wta_pop_c], p(pl_fd) 	by (econzone)
sepov  pc_fddr [w=wta_pop_c], p(pl_fd) 	by (district1)
sepov  pc_fddr [w=wta_pop_c], p(pl_fd) 	by (yearmth)

*Ravallion lower poverty line
sepov pc_hhdr [w=wta_pop_c], p(pl_abs) 
sepov pc_hhdr [w=wta_pop_c], p(pl_abs) 	by (lga)
sepov pc_hhdr [w=wta_pop_c], p(pl_abs) 	by (rururb)
sepov pc_hhdr [w=wta_pop_c], p(pl_abs)  by (econzone)
sepov pc_hhdr [w=wta_pop_c], p(pl_abs) 	by (district1)
sepov pc_hhdr [w=wta_pop_c], p(pl_abs) 	by (yearmth)

*extreme poverty
sepov pc_hhdr [w=wta_pop_c], p(pl_ext)
sepov pc_hhdr [w=wta_pop_c], p(pl_ext) 	by (lga)
sepov pc_hhdr [w=wta_pop_c], p(pl_ext) 	by (rururb)
sepov pc_hhdr [w=wta_pop_c], p(pl_ext)  by (econzone)
sepov pc_hhdr [w=wta_pop_c], p(pl_ext) 	by (district1)
sepov pc_hhdr [w=wta_pop_c], p(pl_ext) 	by (yearmth)


**********************************************************
**inequality

*food inequality.
ineqdeco  pc_fd [aw=wta_pop_c]
ineqdeco  pc_fd [aw=wta_pop_c],  by (lga)
ineqdeco  pc_fd [aw=wta_pop_c],  by (rururb)
ineqdeco  pc_fd [aw=wta_pop_c],  by (econzone)
ineqdeco  pc_fd [aw=wta_pop_c],  by (district1)
ineqdeco  pc_fd [aw=wta_pop_c],  by (yearmth)

*overall (total food and non-food) inequality.

ineqdeco  pc_hh [aw=wta_pop_c]
ineqdeco  pc_hh [aw=wta_pop_c],  by (lga)
ineqdeco  pc_hh [aw=wta_pop_c],  by (rururb)
ineqdeco  pc_hh [aw=wta_pop_c],  by (econzone)
ineqdeco  pc_hh [aw=wta_pop_c],  by (district1)
ineqdeco  pc_hh [aw=wta_pop_c],  by (yearmth)


**deflated consumption so as to compare with 2010
ineqdeco  pc_hhdr [aw=wta_pop_c]
ineqdeco  pc_hhdr [aw=wta_pop_c],  by (lga)
ineqdeco  pc_hhdr [aw=wta_pop_c],  by (rururb)
ineqdeco  pc_hhdr [aw=wta_pop_c],  by (econzone)
ineqdeco  pc_hhdr [aw=wta_pop_c],  by (district1)
ineqdeco  pc_hhdr [aw=wta_pop_c],  by (yearmth)


*****************************
***THE END
*****************************


