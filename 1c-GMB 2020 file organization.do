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


cap log 1c GMB 2020 file organization food
log using "$log\1c GMB 2020 file organization food.log" , replace


********************************************************************************************************************************************************
********************************************************************************************************************************************************
******************* PART B FOOD *******************
********************************************************************************************************************************************************
********************************************************************************************************************************************************

use "$temp\Food_1A_consumed_Mohammed_to_edit.dta", clear 

sort s1aq1

br

///////6320363219002
br if hid =="6320363219002"  & s1aq1==33
//This hh bougt Ikg of mutton not a life sheep.

recode s1aq1 (33=43)if hid =="6320363219002"  & s1aq1==33

/////7420174207004
br hid-s1aq8b  if hid =="7420174207004" & s1aq1==33
recode s1aq1 (33=43)if hid =="7420174207004"  & s1aq1==33


//////4210442101015
br hid-s1aq8b  if hid =="4210442101015" & s1aq1==33
recode s1aq1 (33=43)if hid =="4210442101015"  & s1aq1==43
recode s1aq6b (3=1)if hid =="4210442101015"  & s1aq1==43
recode s1aq7a (1=.)if hid =="4210442101015"  & s1aq1==43 
recode s1aq7b (1=.)if hid =="4210442101015"  & s1aq1==43 // this household is most likely to buy 3 kg of meat 
recode s1aq6a (250=750)if hid =="4210442101015"  & s1aq1==43 // The price is not correct ,250 is for 1kg, need* 3 

////4011440105014
br hid-s1aq8b  if hid =="4011440105014" & s1aq1==33
recode s1aq1 (33=43)if hid =="4011440105014"  & s1aq1==33

////4210442101012
br hid-s1aq8b  if hid =="4210442101012" & s1aq1==33
recode s1aq1 (33=43)if hid =="4210442101012"  & s1aq1==33

////3810838102003
br hid-s1aq8b  if hid =="3810838102003" & s1aq1==33
recode s1aq1 (33=43)if hid =="3810838102003"  & s1aq1==33


////to check 7310873128015, 5310553123010 ,


////5620156228003
br hid-s1aq8b  if hid =="5620156228003" & s1aq1==33
recode s1aq3b (1=6) if hid =="5620156228003"  & s1aq1==33
recode  s1aq4b (1=.)if hid =="5620156228003"  & s1aq1==33
recode  s1aq8b (1=6)if hid =="5620156228003"  & s1aq1==33



////5013050125015
br hid-s1aq8b  if hid =="5013050125015" & s1aq1==33
recode s1aq4a (1=.) if hid =="5013050125015"  & s1aq1==33
recode s1aq4b (1=.) if hid =="5013050125015"  & s1aq1==33
recode s1aq6a (4=.) if hid =="5013050125015"  & s1aq1==33
recode s1aq6b (1=.) if hid =="5013050125015"  & s1aq1==33

////3810938107013

br hid-s1aq8b  if hid =="3810938107013" & s1aq1==33
recode s1aq3b (1=6) if hid =="3810938107013"  & s1aq1==33
recode s1aq4a (1=.) if hid =="3810938107013"  & s1aq1==33
recode s1aq4b (1=.) if hid =="3810938107013"  & s1aq1==33
recode s1aq6a (1=.) if hid =="3810938107013"  & s1aq1==33
recode s1aq6b (1=.) if hid =="3810938107013"  & s1aq1==33
recode s1aq7b (1=6) if hid =="3810938107013"  & s1aq1==33

////4220142208002
br hid-s1aq8b  if hid =="4220142208002" & s1aq1==33
recode s1aq1 (33=43) if hid =="4220142208002"  & s1aq1==33

////5620156228003
br hid-s1aq8b  if hid =="5620156228003" & s1aq1==33
recode s1aq4b (1=.) if hid =="5620156228003"  & s1aq1==33
recode s1aq3b (1=6) if hid =="5620156228003"  & s1aq1==33
recode s1aq8b (1=6) if hid =="5620156228003"  & s1aq1==33

////4020540221014
br hid-s1aq8b  if hid =="4020540221014" & s1aq1==33
recode s1aq1 (33=43)if hid =="4020540221014"  & s1aq1==33

////4021240209003
br hid-s1aq8b  if hid =="4021240209003" & s1aq1==33
recode s1aq1 (33=43)if hid =="4021240209003"  & s1aq1==33

////3810838102015
br hid-s1aq8b  if hid =="3810838102015" & s1aq1==33
recode s1aq7a (1=.) if hid =="3810838102015"  & s1aq1==33
recode s1aq7b (1=.) if hid =="3810838102015"  & s1aq1==33
recode s1aq1 (33=43)if hid =="3810838102015"  & s1aq1==33

////4021240209003
br hid-s1aq8b  if hid =="4021240209003" & s1aq1==43
recode s1aq7a (1=.) if hid =="4021240209003"  & s1aq1==43
recode s1aq7b (1=.) if hid =="4021240209003"  & s1aq1==43

////4210242106004
br hid-s1aq8b  if hid =="4210242106004" & s1aq1==33
recode s1aq4a (0=.) if hid =="4210242106004"  & s1aq1==33
recode s1aq4b (1=.) if hid =="4210242106004"  & s1aq1==33
recode s1aq1 (33=43)if hid =="4210242106004"  & s1aq1==33

////6010360105008
br hid-s1aq8b  if hid =="6010360105008" & s1aq1==33
recode s1aq1 (33=43)if hid =="6010360105008"  & s1aq1==33

////5110551105003
br hid-s1aq8b  if hid =="5110551105003" & s1aq1==33
recode s1aq1 (33=43)if hid =="5110551105003"  & s1aq1==33

////4011440105015
br hid-s1aq8b  if hid =="4011440105015" & s1aq1==33
recode s1aq7a (1=.) if hid =="4011440105015"  & s1aq1==33
recode s1aq7b (1=.) if hid =="4011440105015"  & s1aq1==33
recode s1aq1 (33=43)if hid =="4011440105015"  & s1aq1==33   // input s1aq5

////5013050125015
br hid-s1aq8b  if hid =="5013050125015" & s1aq1==33
recode s1aq7a (4=.) if hid =="5013050125015"  & s1aq1==33
recode s1aq7b (1=.) if hid =="5013050125015"  & s1aq1==33
recode s1aq1 (33=43)if hid =="5013050125015"  & s1aq1==33

////4210442101012
br hid-s1aq8b  if hid =="4210442101012" & s1aq1==33
recode s1aq1 (33=43)if hid =="4210442101012"  & s1aq1==33

////4021240209003
br hid-s1aq8b  if hid =="4021240209003" & s1aq1==33
recode s1aq1 (33=43)if hid =="4021240209003"  & s1aq1==33
recode s1aq7a (1=.) if hid =="4021240209003"  & s1aq1==33
recode s1aq7b (1=.) if hid =="4021240209003"  & s1aq1==33

////6320363219002
br hid-s1aq8b  if hid =="6320363219002" & s1aq1==33
recode s1aq1 (33=43)if hid =="6320363219002"  & s1aq1==33

////5310253111009
br hid-s1aq8b  if hid =="5310253111009" & s1aq1==33
recode s1aq3b (6=1) if hid =="5310253111009"  & s1aq1==33
recode s1aq4b (6=1) if hid =="5310253111009"  & s1aq1==33
recode s1aq6b (6=1) if hid =="5310253111009"  & s1aq1==33
recode s1aq1 (33=43)if hid =="5310253111009"  & s1aq1==33   // input s1aq5

////6010360105008
br hid-s1aq8b  if hid =="6010360105008" & s1aq1==33
recode s1aq1 (33=43)if hid =="6010360105008"  & s1aq1==33

////3810838102015
br hid-s1aq8b  if hid =="3810838102015" & s1aq1==33
recode s1aq7a (1=.) if hid =="3810838102015"  & s1aq1==33
recode s1aq7b (1=.) if hid =="3810838102015"  & s1aq1==33
recode s1aq1 (33=43)if hid =="3810838102015"  & s1aq1==33

////5310253105002
br hid-s1aq8b  if hid =="5310253105002" & s1aq1==33
recode s1aq7a (1=.) if hid =="5310253105002"  & s1aq1==33
recode s1aq7b (1=.) if hid =="5310253105002"  & s1aq1==33
recode s1aq8a (1=.) if hid =="5310253105002"  & s1aq1==33
recode s1aq8b (0=.) if hid =="5310253105002"  & s1aq1==33
recode s1aq1 (33=43)if hid =="5310253105002"  & s1aq1==33

////6113761127006
br hid-s1aq8b  if hid =="6113761127006" & s1aq1==33
recode s1aq4a (0=.) if hid =="6113761127006"  & s1aq1==33
recode s1aq4b (6=.) if hid =="6113761127006"  & s1aq1==33
recode s1aq1 (33=43)if hid =="6113761127006"  & s1aq1==33   

////5310253105004
br hid-s1aq8b  if hid =="5310253105004" & s1aq1==33
recode s1aq1 (33=43)if hid =="5310253105004"  & s1aq1==33   

////3810938107013
br hid-s1aq8b  if hid =="3810938107013" & s1aq1==33
recode s1aq7a (1=.) if hid =="3810938107013"  & s1aq1==33
recode s1aq7b (1=.) if hid =="3810938107013"  & s1aq1==33  // input s1aq5
recode s1aq1 (33=43)if hid =="3810938107013"  & s1aq1==33

////4210442101015
br hid-s1aq8b  if hid =="4210442101015" & s1aq1==33
recode s1aq3a (3=1) if hid =="4210442101015"  & s1aq1==33
recode s1aq4a (3=1) if hid =="4210442101015"  & s1aq1==33
recode s1aq5 (3=250) if hid =="4210442101015"  & s1aq1==33
recode s1aq6a (250=1) if hid =="4210442101015" & s1aq1==33
recode s1aq6b (3=1) if hid =="4210442101015"  & s1aq1==33
recode s1aq7a (1=.) if hid =="4210442101015"  & s1aq1==33
recode s1aq7b (1=.) if hid =="4210442101015"  & s1aq1==33  
recode s1aq1 (33=43)if hid =="4210442101015"  & s1aq1==33   

////7420174207004
br hid-s1aq8b  if hid =="7420174207004" & s1aq1==33
recode s1aq1 (33=43)if hid =="7420174207004"  & s1aq1==33   

////5211152102009
br hid-s1aq8b  if hid =="5211152102009" & s1aq1==33
recode s1aq1 (33=43)if hid =="5211152102009"  & s1aq1==33   

////6114661104001
br hid-s1aq8b  if hid =="6114661104001" & s1aq1==33
recode s1aq4a (0=.) if hid =="6114661104001"  & s1aq1==33
recode s1aq4b (1=.) if hid =="6114661104001"  & s1aq1==33
recode s1aq1 (33=43)if hid =="6114661104001"  & s1aq1==33   

////4220142208002
br hid-s1aq8b  if hid =="4220142208002" & s1aq1==33
recode s1aq1 (33=43)if hid =="4220142208002"  & s1aq1==33   

////5022350219004
br hid-s1aq8b  if hid =="5022350219004" & s1aq1==34
recode s1aq3b (2=1) if hid =="5022350219004"  & s1aq1==34
recode s1aq4a (2=.) if hid =="5022350219004"  & s1aq1==34
recode s1aq4b (2=.) if hid =="5022350219004"  & s1aq1==34
recode s1aq5 (2=.) if hid =="5022350219004"  & s1aq1==34
recode s1aq6a (2=.) if hid =="5022350219004" & s1aq1==34
recode s1aq6b (1=.) if hid =="5022350219004"  & s1aq1==34
recode s1aq7a (2=.) if hid =="5022350219004"  & s1aq1==34 
recode s1aq7b (1=.) if hid =="5022350219004"  & s1aq1==34 
recode s1aq8b (2=1) if hid =="5022350219004"  & s1aq1==34 
recode s1aq1 (34=48)if hid =="5022350219004"  & s1aq1==34   

////5222252205007
br hid-s1aq8b  if hid =="5222252205007" & s1aq1==34
recode s1aq1 (34=48)if hid =="5222252205007"  & s1aq1==34   

////5111951130006
br hid-s1aq8b  if hid =="5111951130006" & s1aq1==34
recode s1aq3b (2=1) if hid =="5111951130006"  & s1aq1==34
recode s1aq4b (2=1) if hid =="5111951130006"  & s1aq1==34
recode s1aq6b (2=1) if hid =="5111951130006"  & s1aq1==34
recode s1aq1 (34=48)if hid =="5022350219004"  & s1aq1==34   

////8321283221016
br hid-s1aq8b  if hid =="8321283221016" & s1aq1==34
recode s1aq1 (34=48)if hid =="8321283221016"  & s1aq1==34   

////8510285103004
br hid-s1aq8b  if hid =="8510285103004" & s1aq1==34
recode s1aq1 (34=48)if hid =="8510285103004"  & s1aq1==34   

////7110271108006
br hid-s1aq8b  if hid =="7110271108006" & s1aq1==34
recode s1aq4a (.=1) if hid =="7110271108006"  & s1aq1==34
recode s1aq4b (.=6) if hid =="7110271108006"  & s1aq1==34
recode s1aq6a (.=1) if hid =="7110271108006" & s1aq1==34
recode s1aq6b (.=6) if hid =="7110271108006"  & s1aq1==34
recode s1aq7a (1=.) if hid =="7110271108006"  & s1aq1==34 
recode s1aq7b (6=.) if hid =="7110271108006"  & s1aq1==34 

////5621956214002
br hid-s1aq8b  if hid =="5621956214002" & s1aq1==34
recode s1aq4a (0=.) if hid =="5621956214002"  & s1aq1==34
recode s1aq4b (6=.) if hid =="5621956214002"  & s1aq1==34
recode s1aq8a (8=.) if hid =="5621956214002"  & s1aq1==34
recode s1aq8b (0=.) if hid =="5621956214002"  & s1aq1==34

////6212762108013
br hid-s1aq8b  if hid =="6212762108013" & s1aq1==34
recode s1aq4a (0=.) if hid =="6212762108013"  & s1aq1==34
recode s1aq4b (6=.) if hid =="6212762108013"  & s1aq1==34

////4120341210001
br hid-s1aq8b  if hid =="4120341210001" & s1aq1==34
recode s1aq4a (1=.) if hid =="4120341210001"  & s1aq1==34
recode s1aq4b (6=.) if hid =="4120341210001"  & s1aq1==34

////8020580247018
br hid-s1aq8b  if hid =="8020580247018" & s1aq1==34
recode s1aq1 (34=48)if hid =="8020580247018"  & s1aq1==34   

////5411254109009
br hid-s1aq8b  if hid =="5411254109009" & s1aq1==34
recode s1aq1 (34=48)if hid =="5411254109009"  & s1aq1==34   

////5411254109009
br hid-s1aq8b  if hid =="5411254109009" & s1aq1==34
recode s1aq1 (34=48)if hid =="5411254109009"  & s1aq1==34   

////6210162122016
br hid-s1aq8b  if hid =="6210162122016" & s1aq1==34
recode s1aq4b (1=.) if hid =="6210162122016"  & s1aq1==34
recode s1aq1 (34=48)if hid =="6210162122016"  & s1aq1==34   

////8320183237014
br hid-s1aq8b  if hid =="8320183237014" & s1aq1==34
recode s1aq4a (1=.) if hid =="8320183237014"  & s1aq1==34
recode s1aq4b (6=.) if hid =="8320183237014"  & s1aq1==34

////6410764121014
br hid-s1aq8b  if hid =="6410764121014" & s1aq1==34
recode s1aq1 (34=48)if hid =="6410764121014"  & s1aq1==34   

////6210162122015
br hid-s1aq8b  if hid =="6210162122015" & s1aq1==34
recode s1aq1 (34=48)if hid =="6210162122015"  & s1aq1==34   

////6120161207012
br hid-s1aq8b  if hid =="6210162122015" & s1aq1==34
recode s1aq7a (1=.) if hid =="7110271108006"  & s1aq1==34 
recode s1aq7b (6=.) if hid =="7110271108006"  & s1aq1==34 

////7420174207004
br hid-s1aq8b  if hid =="7420174207004" & s1aq1==34
recode s1aq1 (34=48)if hid =="7420174207004"  & s1aq1==34   

////5530155347008
br hid-s1aq8b  if hid =="5530155347008" & s1aq1==34
recode s1aq4a (0=.) if hid =="5530155347008"  & s1aq1==34
recode s1aq4b (1=.) if hid =="5530155347008"  & s1aq1==34

////4210242107012
br hid-s1aq8b  if hid =="4210242107012" & s1aq1==34
recode s1aq1 (34=48)if hid =="4210242107012"  & s1aq1==34   

////3821338206013
br hid-s1aq8b  if hid =="3821338206013" & s1aq1==34
recode s1aq1 (34=48)if hid =="3821338206013"  & s1aq1==34   

////5220452209012
br hid-s1aq8b  if hid =="5220452209012" & s1aq1==34
recode s1aq4a (.=1) if hid =="5220452209012"  & s1aq1==34
recode s1aq4b (.=6) if hid =="5220452209012"  & s1aq1==34

////5022650224011
br hid-s1aq8b  if hid =="5022650224011" & s1aq1==34
recode s1aq3b (0=6) if hid =="5022650224011"  & s1aq1==34

////5012750140001
br hid-s1aq8b  if hid =="5012750140001" & s1aq1==34
recode s1aq1 (34=48)if hid =="5012750140001"  & s1aq1==34   

////5010550185004
br hid-s1aq8b  if hid =="5010550185004" & s1aq1==34
recode s1aq1 (34=48)if hid =="5010550185004"  & s1aq1==34   

////4511945122006
br hid-s1aq8b  if hid =="4511945122006" & s1aq1==34
recode s1aq1 (34=48)if hid =="4511945122006"  & s1aq1==34   

////4210242106016
br hid-s1aq8b  if hid =="4210242106016" & s1aq1==34
recode s1aq1 (34=48)if hid =="4210242106016"  & s1aq1==34   

////8611386125002
br hid-s1aq8b  if hid =="8611386125002" & s1aq1==34
recode s1aq4a (1=.) if hid =="8611386125002"  & s1aq1==34
recode s1aq4b (6=.) if hid =="8611386125002"  & s1aq1==34
recode s1aq6a (1=.) if hid =="8611386125002" & s1aq1==34
recode s1aq6b (6=.) if hid =="8611386125002"  & s1aq1==34

////6120561218001
br hid-s1aq8b  if hid =="6120561218001" & s1aq1==34
recode s1aq1 (34=48)if hid =="6120561218001"  & s1aq1==34   

////8511285122003
br hid-s1aq8b  if hid =="8511285122003" & s1aq1==34
recode s1aq1 (34=48)if hid =="8511285122003"  & s1aq1==34   

////6212762108016
br hid-s1aq8b  if hid =="6212762108016" & s1aq1==34
recode s1aq1 (34=48)if hid =="6212762108016"  & s1aq1==34   

////7420174207016
br hid-s1aq8b  if hid =="7420174207016" & s1aq1==34
recode s1aq1 (34=48)if hid =="7420174207016"  & s1aq1==34   

////6120161207008
br hid-s1aq8b  if hid =="6120161207008" & s1aq1==34
recode s1aq1 (34=48)if hid =="6120161207008"  & s1aq1==34   

////8322383232015
br hid-s1aq8b  if hid =="8322383232015" & s1aq1==34
recode s1aq1 (34=48)if hid =="8322383232015"  & s1aq1==34   


//////////////42.   Beef with bones ,price 200

//49.  Beef Without bones ,price 250-300

////5221652213013
br hid-s1aq8b  if hid =="5221652213013" & s1aq1==35
recode s1aq1 (35=49)if hid =="5221652213013"  & s1aq1==35  

////5222252205016
br hid-s1aq8b  if hid =="5222252205016" & s1aq1==35
recode s1aq1 (35=49)if hid =="5222252205016"  & s1aq1==35  

////7321373205006
br hid-s1aq8b  if hid =="7321373205006" & s1aq1==35
recode s1aq1 (35=42)if hid =="7321373205006"  & s1aq1==35  

////8410684119004
br hid-s1aq8b  if hid =="8410684119004" & s1aq1==35
recode s1aq1 (35=42)if hid =="8410684119004"  & s1aq1==35  

////5013050117002
br hid-s1aq8b  if hid =="5013050117002" & s1aq1==35
recode s1aq1 (35=42)if hid =="5013050117002"  & s1aq1==35  

////5221652213014
br hid-s1aq8b  if hid =="5221652213014" & s1aq1==35
recode s1aq1 (35=42)if hid =="5221652213014"  & s1aq1==35  

////5221652213014
br hid-s1aq8b  if hid =="5221652213014" & s1aq1==35
recode s1aq1 (35=42)if hid =="5221652213014"  & s1aq1==35  

////5020150236007
br hid-s1aq8b  if hid =="5020150236007" & s1aq1==35
recode s1aq1 (35=42)if hid =="5020150236007"  & s1aq1==35  

////5012950109014
br hid-s1aq8b  if hid =="5012950109014" & s1aq1==35
recode s1aq3b (15=1) if hid =="5012950109014"  & s1aq1==35
recode s1aq1 (35=42)if hid =="5012950109014"  & s1aq1==35  

////5221652215006
br hid-s1aq8b  if hid =="5221652215006" & s1aq1==35
recode s1aq1 (35=42)if hid =="5221652215006"  & s1aq1==35  

////5012950107009
br hid-s1aq8b  if hid =="5012950107009" & s1aq1==35
recode s1aq1 (35=49)if hid =="5012950107009"  & s1aq1==35  

////5012750140001
br hid-s1aq8b  if hid =="5012750140001" & s1aq1==35
recode s1aq1 (35=42)if hid =="5012750140001"  & s1aq1==35  

////5012550139002
br hid-s1aq8b  if hid =="5012550139002" & s1aq1==35
recode s1aq1 (35=49)if hid =="5012550139002"  & s1aq1==35  

////7420174207013
br hid-s1aq8b  if hid =="7420174207013" & s1aq1==35
recode s1aq1 (35=42)if hid =="7420174207013"  & s1aq1==35  

////6311563111016
br hid-s1aq8b  if hid =="6311563111016" & s1aq1==35
recode s1aq3a (6=1) if hid =="6311563111016"  & s1aq1==35
recode s1aq3b (1=6) if hid =="6311563111016"  & s1aq1==35

////3133631313001
br hid-s1aq8b  if hid =="3133631313001" & s1aq1==35
recode s1aq1 (35=49)if hid =="3133631313001"  & s1aq1==35  

////8311083138004
br hid-s1aq8b  if hid =="8311083138004" & s1aq1==35
recode s1aq1 (35=42)if hid =="8311083138004"  & s1aq1==35  

////5022650224008
br hid-s1aq8b  if hid =="5022650224008" & s1aq1==35
recode s1aq1 (35=49)if hid =="5022650224008"  & s1aq1==35  

////6311763117007
br hid-s1aq8b  if hid =="6311763117007" & s1aq1==35
recode s1aq1 (35=42)if hid =="6311763117007"  & s1aq1==35  

////5110251114008
br hid-s1aq8b  if hid =="5110251114008" & s1aq1==35
recode s1aq1 (35=49)if hid =="5110251114008"  & s1aq1==35  

////5221352207011
br hid-s1aq8b  if hid =="5221352207011" & s1aq1==35
recode s1aq1 (35=42)if hid =="5221352207011"  & s1aq1==35  

////5420754218001
br hid-s1aq8b  if hid =="5420754218001" & s1aq1==35
recode s1aq1 (35=42)if hid =="5420754218001"  & s1aq1==35  

////8511285122002
br hid-s1aq8b  if hid =="8511285122002" & s1aq1==35
recode s1aq1 (35=42)if hid =="8511285122002"  & s1aq1==35  

////
br hid-s1aq8b  if hid =="8511285122002" & s1aq1==35
recode s1aq1 (35=42)if hid =="8511285122002"  & s1aq1==35  

////5111651120009
br hid-s1aq8b  if hid =="5111651120009" & s1aq1==35
recode s1aq1 (35=42)if hid =="5111651120009"  & s1aq1==35  

////5111451111004
br hid-s1aq8b  if hid =="5111451111004" & s1aq1==35
recode s1aq1 (35=42)if hid =="5111451111004"  & s1aq1==35  

////5111151127011
br hid-s1aq8b  if hid =="5111151127011" & s1aq1==35
recode s1aq1 (35=42)if hid =="5111151127011"  & s1aq1==35  
recode s1aq4a (2=.) if hid =="5111151127011"  & s1aq1==35
recode s1aq4b (1=.) if hid =="5111151127011"  & s1aq1==35

////5111551117006
br hid-s1aq8b  if hid =="5111551117006" & s1aq1==35
recode s1aq1 (35=42)if hid =="5111551117006"  & s1aq1==35  

////5022350219003
br hid-s1aq8b  if hid =="5022350219003" & s1aq1==35
recode s1aq1 (35=49)if hid =="5022350219003"  & s1aq1==35  

////5320653207014
br hid-s1aq8b  if hid =="5320653207014" & s1aq1==35
recode s1aq3a (3=1) if hid =="5320653207014"  & s1aq1==35
recode s1aq3b (1=6) if hid =="5320653207014"  & s1aq1==35

////5220152222008
br hid-s1aq8b  if hid =="5220152222008" & s1aq1==35
recode s1aq1 (35=49)if hid =="5220152222008"  & s1aq1==35  

////5221652213016
br hid-s1aq8b  if hid =="5221652213016" & s1aq1==35
recode s1aq1 (35=49)if hid =="5221652213016"  & s1aq1==35  

////5120151204001
br hid-s1aq8b  if hid =="5120151204001" & s1aq1==35
recode s1aq1 (35=42)if hid =="5120151204001"  & s1aq1==35  

////8611886107007
br hid-s1aq8b  if hid =="8611886107007" & s1aq1==35
recode s1aq3a (6=2) if hid =="8611886107007"  & s1aq1==35
recode s1aq3b (2=1) if hid =="8611886107007"  & s1aq1==35
recode s1aq4a (2=.) if hid =="8611886107007"  & s1aq1==35
recode s1aq4b (2=.) if hid =="8611886107007"  & s1aq1==35
recode s1aq5  (2=.) if hid =="8611886107007"  & s1aq1==35
recode s1aq6a (2=.) if hid =="8611886107007"  & s1aq1==35
recode s1aq6b (2=.) if hid =="8611886107007"  & s1aq1==35
recode s1aq7a (2=.) if hid =="8611886107007"  & s1aq1==35
recode s1aq7b (2=.) if hid =="8611886107007"  & s1aq1==35
recode s1aq8b (2=1) if hid =="8611886107007"  & s1aq1==35
recode s1aq1  (35=42)if hid =="8611886107007" & s1aq1==35  

////5211552122004
br hid-s1aq8b  if hid =="5211552122004" & s1aq1==35
recode s1aq1 (35=49)if hid =="5211552122004"  & s1aq1==35  

////5120151202013
br hid-s1aq8b  if hid =="5120151202013" & s1aq1==35
recode s1aq1 (35=49)if hid =="5120151202013"  & s1aq1==35  

////5220152222007
br hid-s1aq8b  if hid =="5220152222007" & s1aq1==35
recode s1aq1 (35=49)if hid =="5220152222007"  & s1aq1==35  

////8322383232014
br hid-s1aq8b  if hid =="8322383232014" & s1aq1==35
recode s1aq1 (35=42)if hid =="8322383232014"  & s1aq1==35  

////4120341211010
br hid-s1aq8b  if hid =="4120341211010" & s1aq1==35
recode s1aq1 (35=42)if hid =="4120341211010"  & s1aq1==35  

////5121251218013
br hid-s1aq8b  if hid =="5121251218013" & s1aq1==35
recode s1aq1 (35=42)if hid =="5121251218013"  & s1aq1==35  

////5110551108011
br hid-s1aq8b  if hid =="5110551108011" & s1aq1==35
recode s1aq1 (35=42)if hid =="5110551108011"  & s1aq1==35  

////5120151204002
br hid-s1aq8b  if hid =="5120151204002" & s1aq1==35
recode s1aq1 (35=42)if hid =="5120151204002"  & s1aq1==35  

//309
br


*************** Muhammed I. Jaiteh*********************


////7420174207003    I am not sure if this should be beef with bones or beef without bones
br hid-s1aq8b  if hid =="7420174207003" & s1aq1==35
recode s1aq1 (35=42)if hid =="7420174207003"  & s1aq1==35 // since it is from gifts and other sources, I assume it is beef with bones

////6311763117007    I am not sure if this should be beef with bones or beef without bones
br hid-s1aq8b  if hid =="6311763117007" & s1aq1==35
recode s1aq1 (35=42)if hid =="6311763117007"  & s1aq1==35 // // since it is from gifts and other sources, I assume it is beef with bones

////8611886107007
br hid-s1aq8b  if hid =="8611886107007" & s1aq1==35
recode s1aq3a (6=2) if hid =="8611886107007"  & s1aq1==35
recode s1aq3b (2=1) if hid =="8611886107007"  & s1aq1==35
recode s1aq4a (2=.) if hid =="8611886107007"  & s1aq1==35
recode s1aq4b (2=.) if hid =="8611886107007"  & s1aq1==35
recode s1aq5 (2=.)  if hid =="8611886107007"  & s1aq1==35
recode s1aq6a (2=.) if hid =="8611886107007"  & s1aq1==35
recode s1aq6b (2=.) if hid =="8611886107007"  & s1aq1==35
recode s1aq7a (2=.) if hid =="8611886107007"  & s1aq1==35
recode s1aq7b (2=.) if hid =="8611886107007"  & s1aq1==35
recode s1aq8b (2=1) if hid =="8611886107007"  & s1aq1==35
recode s1aq1 (35=42)if hid =="8611886107007"  & s1aq1==35  

////7420174207013
br hid-s1aq8b  if hid =="7420174207013" & s1aq1==35
recode s1aq1 (35=42)if hid =="7420174207013"  & s1aq1==35

////5221652213013
br hid-s1aq8b  if hid =="5221652213013" & s1aq1==35
recode s1aq1 (35=49)if hid =="5221652213013"  & s1aq1==35

////5013050113009
br hid-s1aq8b  if hid =="5013050113009" & s1aq1==35
recode s1aq1 (35=42)if hid =="5013050113009"  & s1aq1==35

////5012750140001
br hid-s1aq8b  if hid =="5012750140001" & s1aq1==35
recode s1aq1 (35=42)if hid =="5012750140001"  & s1aq1==35

////5222252205016
br hid-s1aq8b  if hid =="5222252205016" & s1aq1==35
recode s1aq1 (35=42)if hid =="5222252205016"  & s1aq1==35

////8311083138005
br hid-s1aq8b  if hid =="8311083138005" & s1aq1==35
recode s1aq1 (35=42)if hid =="8311083138005"  & s1aq1==35

////6112161122004
br hid-s1aq8b  if hid =="6112161122004" & s1aq1==37
recode s1aq4a (2=.) if hid =="6112161122004"  & s1aq1==37
recode s1aq4b (6=.) if hid =="6112161122004"  & s1aq1==37
recode s1aq6a (2=.) if hid =="6112161122004"  & s1aq1==37
recode s1aq6b (6=.) if hid =="6112161122004"  & s1aq1==37

////6312063123004
br hid-s1aq8b  if hid =="6312063123004" & s1aq1==37 // this seems okay but I am not sure about it

////3210232156009
br hid-s1aq8b  if hid =="3210232156009" & s1aq1==37 
recode s1aq4a (12=.) if hid =="3210232156009"  & s1aq1==37
recode s1aq4b (6=.) if hid =="3210232156009"  & s1aq1==37

////4520145212003
br hid-s1aq8b  if hid =="4520145212003" & s1aq1==37 // D3500 spent on 10 chickens, seems high for Jarra Barrow kunda in Feb 2020

////5013050129012
br hid-s1aq8b  if hid =="5013050129012" & s1aq1==37 
recode s1aq4a (2=.) if hid =="5013050129012"  & s1aq1==37
recode s1aq4b (6=.) if hid =="5013050129012"  & s1aq1==37
recode s1aq6a (2=.) if hid =="5013050129012"  & s1aq1==37
recode s1aq6b (6=.) if hid =="5013050129012"  & s1aq1==37

////5621256211011
br hid-s1aq8b  if hid =="5621256211011" & s1aq1==37
recode s1aq8a (2=.) if hid =="5621256211011"  & s1aq1==37
recode s1aq8b (2=.) if hid =="5621256211011"  & s1aq1==37

////3030530383008
br hid-s1aq8b  if hid =="3030530383008" & s1aq1==37 
recode s1aq4a (1=.) if hid =="3030530383008"  & s1aq1==37
recode s1aq4b (6=.) if hid =="3030530383008"  & s1aq1==37
recode s1aq6a (1=.) if hid =="3030530383008"  & s1aq1==37
recode s1aq6b (6=.) if hid =="3030530383008"  & s1aq1==37

////2320123251003
br hid-s1aq8b  if hid =="2320123251003" & s1aq1==37 
recode s1aq6a (1=.) if hid =="2320123251003"  & s1aq1==37
recode s1aq6b (0=.) if hid =="2320123251003"  & s1aq1==37
recode s1aq7a (6=7) if hid =="2320123251003"  & s1aq1==37

////3820638202005
br hid-s1aq8b  if hid =="3820638202005" & s1aq1==37 
recode s1aq1 (37=44)if hid =="3820638202005"  & s1aq1==37  

////6212762108009
br hid-s1aq8b  if hid =="6212762108009" & s1aq1==37
recode s1aq3b (1=6) if hid =="6212762108009"  & s1aq1==37
recode s1aq4a (0=.) if hid =="6212762108009"  & s1aq1==37
recode s1aq4b (1=.) if hid =="6212762108009"  & s1aq1==37
recode s1aq6b (6=.) if hid =="6212762108009"  & s1aq1==37
recode s1aq7b (1=6) if hid =="6212762108009"  & s1aq1==37

////6110261119005
br hid-s1aq8b  if hid =="6110261119005" & s1aq1==37
recode s1aq4a (6=.) if hid =="6110261119005"  & s1aq1==37
recode s1aq4b (6=.) if hid =="6110261119005"  & s1aq1==37
recode s1aq6a (6=.) if hid =="6110261119005"  & s1aq1==37
recode s1aq6b (6=.) if hid =="6110261119005"  & s1aq1==37

////4410444101014
br hid-s1aq8b  if hid =="4410444101014" & s1aq1==37
recode s1aq4a (.=1) if hid =="4410444101014"  & s1aq1==37
recode s1aq4b (.=6) if hid =="4410444101014"  & s1aq1==37

////8410284108012
br hid-s1aq8b  if hid =="8410284108012" & s1aq1==37
recode s1aq5 (.=100) if hid =="8410284108012"  & s1aq1==37
recode s1aq1 (37=44)if hid =="8410284108012"  & s1aq1==37  

////8611386125010
br hid-s1aq8b  if hid =="8611386125010" & s1aq1==37
recode s1aq4a (2=.) if hid =="8611386125010"  & s1aq1==37
recode s1aq4b (6=.) if hid =="8611386125010"  & s1aq1==37
recode s1aq6a (2=.) if hid =="8611386125010"  & s1aq1==37
recode s1aq6b (6=.) if hid =="8611386125010"  & s1aq1==37
  
////6011360102001
br hid-s1aq8b  if hid =="6011360102001" & s1aq1==37
recode s1aq4a (0=.) if hid =="6011360102001"  & s1aq1==37
recode s1aq4b (6=.) if hid =="6011360102001"  & s1aq1==37
recode s1aq6a (6=.) if hid =="6011360102001"  & s1aq1==37
recode s1aq6b (0=.) if hid =="6011360102001"  & s1aq1==37
recode s1aq7a (6=.) if hid =="6011360102001"  & s1aq1==37
recode s1aq7b (0=.) if hid =="6011360102001"  & s1aq1==37
recode s1aq8a (-11=1) if hid =="6011360102001"  & s1aq1==37

////5020150236006
br hid-s1aq8b  if hid =="5020150236006" & s1aq1==37
recode s1aq4a (1=.) if hid =="5020150236006"  & s1aq1==37
recode s1aq4b (6=.) if hid =="5020150236006"  & s1aq1==37
recode s1aq6a (1=.) if hid =="5020150236006"  & s1aq1==37
recode s1aq6b (6=.) if hid =="5020150236006"  & s1aq1==37

////6112161122012
br hid-s1aq8b  if hid =="6112161122012" & s1aq1==37
recode s1aq4a (0=.) if hid =="6112161122012"  & s1aq1==37
recode s1aq4b (6=.) if hid =="6112161122012"  & s1aq1==37
recode s1aq5 (4000=.) if hid =="6112161122012"  & s1aq1==37
recode s1aq6a (2=.) if hid =="6112161122012"  & s1aq1==37
recode s1aq6b (2=.) if hid =="6112161122012"  & s1aq1==37
recode s1aq7a (1=3) if hid =="6112161122012"  & s1aq1==37

////6210162122007
br hid-s1aq8b  if hid =="6210162122007" & s1aq1==37
recode s1aq4a (0=.) if hid =="6210162122007"  & s1aq1==37
recode s1aq4b (6=.) if hid =="6210162122007"  & s1aq1==37
recode s1aq6a (6=.) if hid =="6210162122007"  & s1aq1==37
recode s1aq6b (0=.) if hid =="6210162122007"  & s1aq1==37

////5121851236001
br hid-s1aq8b  if hid =="5121851236001" & s1aq1==37
recode s1aq4a (2=.) if hid =="5121851236001"  & s1aq1==37
recode s1aq4b (6=.) if hid =="5121851236001"  & s1aq1==37
recode s1aq6a (2=.) if hid =="5121851236001"  & s1aq1==37
recode s1aq6b (6=.) if hid =="5121851236001"  & s1aq1==37

////6121661217007
br hid-s1aq8b  if hid =="6121661217007" & s1aq1==37
recode s1aq3b (1=6) if hid =="6121661217007"  & s1aq1==37
recode s1aq7b (1=6) if hid =="6121661217007"  & s1aq1==37

////5012650134001
br hid-s1aq8b  if hid =="5012650134001" & s1aq1==37
recode s1aq6a (1=.) if hid =="5012650134001"  & s1aq1==37
recode s1aq6b (6=.) if hid =="5012650134001"  & s1aq1==37

////6120561218013
br hid-s1aq8b  if hid =="6120561218013" & s1aq1==37
recode s1aq4a (6=.) if hid =="6120561218013"  & s1aq1==37
recode s1aq4b (6=.) if hid =="6120561218013"  & s1aq1==37
recode s1aq6a (6=.) if hid =="6120561218013"  & s1aq1==37
recode s1aq6b (6=.) if hid =="6120561218013"  & s1aq1==37

////6323563229015
br hid-s1aq8b  if hid =="6323563229015" & s1aq1==37
recode s1aq4a (1=.) if hid =="6323563229015"  & s1aq1==37
recode s1aq4b (6=.) if hid =="6323563229015"  & s1aq1==37
recode s1aq6a (1=.) if hid =="6323563229015"  & s1aq1==37
recode s1aq6b (6=.) if hid =="6323563229015"  & s1aq1==37

////4410444101015
br hid-s1aq8b  if hid =="4410444101015" & s1aq1==37
recode s1aq5 (600=.) if hid =="4410444101015"  & s1aq1==37


////6211662120004
br hid-s1aq8b  if hid =="6211662120004" & s1aq1==37
recode s1aq4a (0=.) if hid =="6211662120004"  & s1aq1==37
recode s1aq4b (6=.) if hid =="6211662120004"  & s1aq1==37
recode s1aq6a (6=.) if hid =="6211662120004"  & s1aq1==37
recode s1aq6b (0=.) if hid =="6211662120004"  & s1aq1==37

////3810938107011
br hid-s1aq8b  if hid =="3810938107011" & s1aq1==37
recode s1aq4a (1=.) if hid =="3810938107011"  & s1aq1==37
recode s1aq4b (6=.) if hid =="3810938107011"  & s1aq1==37
recode s1aq7a (1=.) if hid =="3810938107011"  & s1aq1==37
recode s1aq7b (6=.) if hid =="3810938107011"  & s1aq1==37

////5530155339015
br hid-s1aq8b  if hid =="5530155339015" & s1aq1==37
recode s1aq4a (1=.) if hid =="5530155339015"  & s1aq1==37
recode s1aq4b (6=.) if hid =="5530155339015"  & s1aq1==37
recode s1aq7b (0=6) if hid =="5530155339015"  & s1aq1==37

////7321373205003
br hid-s1aq8b  if hid =="7321373205003" & s1aq1==37
recode s1aq4a (6=.) if hid =="7321373205003"  & s1aq1==37
recode s1aq4b (6=.) if hid =="7321373205003"  & s1aq1==37
recode s1aq6a (6=.) if hid =="7321373205003"  & s1aq1==37
recode s1aq6b (6=.) if hid =="7321373205003"  & s1aq1==37

////5530155339014
br hid-s1aq8b  if hid =="5530155339014" & s1aq1==37
recode s1aq4a (1=.) if hid =="5530155339014"  & s1aq1==37
recode s1aq4b (6=.) if hid =="5530155339014"  & s1aq1==37

////2420224209005
br hid-s1aq8b  if hid =="2420224209005" & s1aq1==37
recode s1aq3b (6=1) if hid =="2420224209005"  & s1aq1==37
recode s1aq4b (6=1) if hid =="2420224209005"  & s1aq1==37
recode s1aq6b (6=1) if hid =="2420224209005"  & s1aq1==37
recode s1aq1 (37=44)if hid =="2420224209005"  & s1aq1==37 

////6112161122014 
br hid-s1aq8b  if hid =="6112161122014" & s1aq1==37
recode s1aq4a (1=.) if hid =="6112161122014"  & s1aq1==37
recode s1aq4b (6=.) if hid =="6112161122014"  & s1aq1==37

////8322383232002
br hid-s1aq8b  if hid =="8322383232002" & s1aq1==37
recode s1aq7b (0=6) if hid =="8322383232002"  & s1aq1==37

////4210242106002
br hid-s1aq8b  if hid =="4210242106002" & s1aq1==37
recode s1aq4a (1=.) if hid =="4210242106002"  & s1aq1==37
recode s1aq4b (6=.) if hid =="4210242106002"  & s1aq1==37

////5010550185004
br hid-s1aq8b  if hid =="5010550185004" & s1aq1==37
recode s1aq4a (1=.) if hid =="5010550185004"  & s1aq1==37
recode s1aq4b (6=.) if hid =="5010550185004"  & s1aq1==37
recode s1aq6a (1=.) if hid =="5010550185004"  & s1aq1==37
recode s1aq6b (6=.) if hid =="5010550185004"  & s1aq1==37

////6022360208009
br hid-s1aq8b  if hid =="6022360208009" & s1aq1==37
recode s1aq7a (2=1) if hid =="6022360208009"  & s1aq1==37

////5121251218013
br hid-s1aq8b  if hid =="5121251218013" & s1aq1==37
recode s1aq4a (2=.) if hid =="5121251218013"  & s1aq1==37
recode s1aq4b (6=.) if hid =="5121251218013"  & s1aq1==37
recode s1aq6a (2=.) if hid =="5121251218013"  & s1aq1==37
recode s1aq6b (6=.) if hid =="5121251218013"  & s1aq1==37

////4521145208007
br hid-s1aq8b  if hid =="4521145208007" & s1aq1==37
recode s1aq5 (225=.) if hid =="4521145208007"  & s1aq1==37

////5110151135013
br hid-s1aq8b  if hid =="5110151135013" & s1aq1==37
recode s1aq4a (1=.) if hid =="5110151135013"  & s1aq1==37
recode s1aq4b (6=.) if hid =="5110151135013"  & s1aq1==37
recode s1aq6a (1=.) if hid =="5110151135013"  & s1aq1==37
recode s1aq6b (6=.) if hid =="5110151135013"  & s1aq1==37


////5622156219016
br hid-s1aq8b  if hid =="5622156219016" & s1aq1==37
recode s1aq3b (0=6) if hid =="5622156219016"  & s1aq1==37
recode s1aq7a (1=3) if hid =="5622156219016"  & s1aq1==37
recode s1aq8a (2=.) if hid =="5622156219016"  & s1aq1==37
recode s1aq8b (2=.) if hid =="5622156219016"  & s1aq1==37


////6020160224006
br hid-s1aq8b  if hid =="6020160224006" & s1aq1==37
recode s1aq4a (3=.) if hid =="6020160224006"  & s1aq1==37
recode s1aq4b (6=.) if hid =="6020160224006"  & s1aq1==37
recode s1aq6a (3=.) if hid =="6020160224006"  & s1aq1==37
recode s1aq6b (6=.) if hid =="6020160224006"  & s1aq1==37


////3810738103014
br hid-s1aq8b  if hid =="3810738103014" & s1aq1==37
recode s1aq1 (37=44) if hid =="3810738103014"  & s1aq1==37


////3810738103004
br hid-s1aq8b  if hid =="3810738103004" & s1aq1==37
recode s1aq4a (2=.) if hid =="3810738103004"  & s1aq1==37
recode s1aq4b (6=.) if hid =="3810738103004"  & s1aq1==37
recode s1aq8a (6=2.) if hid =="3810738103004"  & s1aq1==37
recode s1aq8b (0=6.) if hid =="3810738103004"  & s1aq1==37


////6122261202002
br hid-s1aq8b  if hid =="6122261202002" & s1aq1==37
recode s1aq4a (9=.) if hid =="6122261202002"  & s1aq1==37
recode s1aq4b (6=.) if hid =="6122261202002"  & s1aq1==37
recode s1aq6a (9=.) if hid =="6122261202002"  & s1aq1==37
recode s1aq6b (6=.) if hid =="6122261202002"  & s1aq1==37


////8221382211005
br hid-s1aq8b  if hid =="8221382211005" & s1aq1==37
recode s1aq1 (37=44) if hid =="8221382211005"  & s1aq1==37


////5530155311005
br hid-s1aq8b  if hid =="5530155311005" & s1aq1==37
recode s1aq3b (1=6) if hid =="5530155311005"  & s1aq1==37


////6110561115012
br hid-s1aq8b  if hid =="6110561115012" & s1aq1==37
recode s1aq4a (0=.) if hid =="6110561115012"  & s1aq1==37
recode s1aq4b (6=.) if hid =="6110561115012"  & s1aq1==37
recode s1aq6a (6=.) if hid =="6110561115012"  & s1aq1==37
recode s1aq6b (0=.) if hid =="6110561115012"  & s1aq1==37


////7011670108004
br hid-s1aq8b  if hid =="7011670108004" & s1aq1==37
recode s1aq4a (.=1) if hid =="7011670108004"  & s1aq1==37
recode s1aq4b (.=6) if hid =="7011670108004"  & s1aq1==37


////4220642203004
br hid-s1aq8b  if hid =="4220642203004" & s1aq1==37
recode s1aq4a (2=.) if hid =="4220642203004"  & s1aq1==37
recode s1aq4b (6=.) if hid =="4220642203004"  & s1aq1==37


////6210162122006
br hid-s1aq8b  if hid =="6210162122006" & s1aq1==37
recode s1aq3a (6=1) if hid =="6210162122006"  & s1aq1==37


////4512045112011
br hid-s1aq8b  if hid =="4512045112011" & s1aq1==37
recode s1aq5 (300=.) if hid =="4512045112011"  & s1aq1==37


////7111071106001
br hid-s1aq8b  if hid =="7111071106001" & s1aq1==37
recode s1aq1 (37=44) if hid =="7111071106001"  & s1aq1==37


////7111171113005
br hid-s1aq8b  if hid =="7111171113005" & s1aq1==37
recode s1aq3b (5=6) if hid =="7111171113005"  & s1aq1==37
recode s1aq7b (5=6) if hid =="7111171113005"  & s1aq1==37


////4020340202006
br hid-s1aq8b  if hid =="4020340202006" & s1aq1==37
recode s1aq4a (1=.) if hid =="4020340202006"  & s1aq1==37
recode s1aq4b (6=.) if hid =="4020340202006"  & s1aq1==37


////3720737207007
br hid-s1aq8b  if hid =="3720737207007" & s1aq1==37
recode s1aq4a (2=.) if hid =="3720737207007"  & s1aq1==37
recode s1aq4b (6=.) if hid =="3720737207007"  & s1aq1==37


////6323963202005
br hid-s1aq8b  if hid =="6323963202005" & s1aq1==37
recode s1aq8a (.=1) if hid =="6323963202005"  & s1aq1==37
recode s1aq8b (.=6) if hid =="6323963202005"  & s1aq1==37


////3230232347010
br hid-s1aq8b  if hid =="3230232347010" & s1aq1==37
recode s1aq4a (1=.) if hid =="3230232347010"  & s1aq1==37
recode s1aq4b (6=.) if hid =="3230232347010"  & s1aq1==37
recode s1aq6a (1=.) if hid =="3230232347010"  & s1aq1==37
recode s1aq6b (6=.) if hid =="3230232347010"  & s1aq1==37


////5023050213005
br hid-s1aq8b  if hid =="5023050213005" & s1aq1==37
recode s1aq4a (3=.) if hid =="5023050213005"  & s1aq1==37
recode s1aq4b (6=.) if hid =="5023050213005"  & s1aq1==37
recode s1aq6a (3=.) if hid =="5023050213005"  & s1aq1==37
recode s1aq6b (6=.) if hid =="5023050213005"  & s1aq1==37


////8311583128010
br hid-s1aq8b  if hid =="8311583128010" & s1aq1==37
recode s1aq1 (37=44) if hid =="8311583128010"  & s1aq1==37



////7510175103057
br hid-s1aq8b  if hid =="7510175103057" & s1aq1==37
recode s1aq4a (6=.) if hid =="7510175103057"  & s1aq1==37
recode s1aq4b (6=.) if hid =="7510175103057"  & s1aq1==37
recode s1aq6a (6=.) if hid =="7510175103057"  & s1aq1==37
recode s1aq6b (6=.) if hid =="7510175103057"  & s1aq1==37



////6110261119002
br hid-s1aq8b  if hid =="6110261119002" & s1aq1==37
recode s1aq4a (1=.) if hid =="6110261119002"  & s1aq1==37
recode s1aq4b (6=.) if hid =="6110261119002"  & s1aq1==37
recode s1aq6a (1=.) if hid =="6110261119002"  & s1aq1==37
recode s1aq6b (6=.) if hid =="6110261119002"  & s1aq1==37


////4520545214009
br hid-s1aq8b  if hid =="4520545214009" & s1aq1==37
recode s1aq5 (400=.) if hid =="4520545214009"  & s1aq1==37


////7321373205007
br hid-s1aq8b  if hid =="7321373205007" & s1aq1==37
recode s1aq4a (1=.) if hid =="7321373205007"  & s1aq1==37
recode s1aq4b (6=.) if hid =="7321373205007"  & s1aq1==37


////5321053215016
br hid-s1aq8b  if hid =="5321053215016" & s1aq1==37
recode s1aq3b (0=6) if hid =="5321053215016"  & s1aq1==37
recode s1aq4a (5=.) if hid =="5321053215016"  & s1aq1==37
recode s1aq4b (0=.) if hid =="5321053215016"  & s1aq1==37
recode s1aq6a (5=.) if hid =="5321053215016"  & s1aq1==37
recode s1aq6b (0=.) if hid =="5321053215016"  & s1aq1==37
recode s1aq7b (0=6) if hid =="5321053215016"  & s1aq1==37



////3810438110012
br hid-s1aq8b  if hid =="3810438110012" & s1aq1==37
recode s1aq3b (1=6) if hid =="3810438110012"  & s1aq1==37
recode s1aq4a (2=.) if hid =="3810438110012"  & s1aq1==37
recode s1aq4b (1=.) if hid =="3810438110012"  & s1aq1==37
recode s1aq6a (2=.) if hid =="3810438110012"  & s1aq1==37
recode s1aq6b (1=.) if hid =="3810438110012"  & s1aq1==37
recode s1aq7a (1=2) if hid =="3810438110012"  & s1aq1==37
recode s1aq7b (1=6) if hid =="3810438110012"  & s1aq1==37


////4120341210001
br hid-s1aq8b  if hid =="4120341210001" & s1aq1==37
recode s1aq4a (3=.) if hid =="4120341210001"  & s1aq1==37
recode s1aq4b (6=.) if hid =="4120341210001"  & s1aq1==37


////3410834116009
br hid-s1aq8b  if hid =="3410834116009" & s1aq1==37
recode s1aq3b (5=6) if hid =="3410834116009"  & s1aq1==37


////6022460205003
br hid-s1aq8b  if hid =="6022460205003" & s1aq1==37
recode s1aq4a (0=.) if hid =="6022460205003"  & s1aq1==37
recode s1aq4b (6=.) if hid =="6022460205003"  & s1aq1==37
recode s1aq6a (6=.) if hid =="6022460205003"  & s1aq1==37
recode s1aq6b (0=.) if hid =="6022460205003"  & s1aq1==37


////5211652115005
br hid-s1aq8b  if hid =="5211652115005" & s1aq1==37
recode s1aq3b (1=6) if hid =="5211652115005"  & s1aq1==37
recode s1aq4a (2=.) if hid =="5211652115005"  & s1aq1==37
recode s1aq4b (1=.) if hid =="5211652115005"  & s1aq1==37
recode s1aq6a (2=.) if hid =="5211652115005"  & s1aq1==37
recode s1aq6b (1=.) if hid =="5211652115005"  & s1aq1==37
recode s1aq7b (1=6) if hid =="5211652115005"  & s1aq1==37


////3810738103002
br hid-s1aq8b  if hid =="3810738103002" & s1aq1==37
recode s1aq4a (2=.) if hid =="3810738103002"  & s1aq1==37
recode s1aq4b (6=.) if hid =="3810738103002"  & s1aq1==37


////5622156219005
br hid-s1aq8b  if hid =="5622156219005" & s1aq1==37
recode s1aq3b (0=6) if hid =="5622156219005"  & s1aq1==37


////7510175104088
br hid-s1aq8b  if hid =="7510175104088" & s1aq1==37
recode s1aq1 (37=44) if hid =="7510175104088"  & s1aq1==37


////7442474424004
br hid-s1aq8b  if hid =="7442474424004" & s1aq1==37
recode s1aq4a (4=.) if hid =="7442474424004"  & s1aq1==37
recode s1aq4b (6=.) if hid =="7442474424004"  & s1aq1==37
recode s1aq6a (4=.) if hid =="7442474424004"  & s1aq1==37
recode s1aq6b (6=.) if hid =="7442474424004"  & s1aq1==37


////7322073230004
br hid-s1aq8b  if hid =="7322073230004" & s1aq1==37
recode s1aq3b (9=6) if hid =="7322073230004"  & s1aq1==37


////6431564317009
br hid-s1aq8b  if hid =="6431564317009" & s1aq1==37
recode s1aq6a (1=.) if hid =="6431564317009"  & s1aq1==37
recode s1aq6b (6=.) if hid =="6431564317009"  & s1aq1==37


////7321373205009
br hid-s1aq8b  if hid =="7321373205009" & s1aq1==37
recode s1aq3a (1.5=1) if hid =="7321373205009"  & s1aq1==37
recode s1aq3b (1=6) if hid =="7321373205009"  & s1aq1==37
recode s1aq7a (1.5=1) if hid =="7321373205009"  & s1aq1==37
recode s1aq7b (1=6) if hid =="7321373205009"  & s1aq1==37



////5511155116002
br hid-s1aq8b  if hid =="5511155116002" & s1aq1==37
recode s1aq7a (1=.) if hid =="5511155116002"  & s1aq1==37
recode s1aq7b (6=.) if hid =="5511155116002"  & s1aq1==37


////5013050117002
br hid-s1aq8b  if hid =="5013050117002" & s1aq1==37
recode s1aq4a (2=.) if hid =="5013050117002"  & s1aq1==37
recode s1aq4b (6=.) if hid =="5013050117002"  & s1aq1==37
recode s1aq6a (2=.) if hid =="5013050117002"  & s1aq1==37
recode s1aq6b (6=.) if hid =="5013050117002"  & s1aq1==37


////4220442209001
br hid-s1aq8b  if hid =="4220442209001" & s1aq1==37
recode s1aq4a (1=.) if hid =="4220442209001"  & s1aq1==37
recode s1aq4b (6=.) if hid =="4220442209001"  & s1aq1==37


////5310253111007
br hid-s1aq8b  if hid =="5310253111007" & s1aq1==37
recode s1aq3b (0=6) if hid =="5310253111007"  & s1aq1==37
recode s1aq4a (1=.) if hid =="5310253111007"  & s1aq1==37
recode s1aq4b (0=.) if hid =="5310253111007"  & s1aq1==37
recode s1aq7b (0=6) if hid =="5310253111007"  & s1aq1==37


////6113161102002
br hid-s1aq8b  if hid =="6113161102002" & s1aq1==37
recode s1aq4a (60=.) if hid =="6113161102002"  & s1aq1==37
recode s1aq4b (6=.) if hid =="6113161102002"  & s1aq1==37
recode s1aq6a (60=.) if hid =="6113161102002"  & s1aq1==37
recode s1aq6b (6=.) if hid =="6113161102002"  & s1aq1==37


////4520145212002
br hid-s1aq8b  if hid =="4520145212002" & s1aq1==37
recode s1aq5 (800=.) if hid =="4520145212002"  & s1aq1==37


////4010840110002
br hid-s1aq8b  if hid =="4010840110002" & s1aq1==37
recode s1aq4a (1=.) if hid =="4010840110002"  & s1aq1==37
recode s1aq4b (6=.) if hid =="4010840110002"  & s1aq1==37


////5612056108013
br hid-s1aq8b  if hid =="5612056108013" & s1aq1==37
recode s1aq3b (0=6) if hid =="5612056108013"  & s1aq1==37
recode s1aq4a (1=.) if hid =="5612056108013"  & s1aq1==37
recode s1aq4b (0=.) if hid =="5612056108013"  & s1aq1==37
recode s1aq7b (0=6) if hid =="5612056108013"  & s1aq1==37


////5220752220010
br hid-s1aq8b  if hid =="5220752220010" & s1aq1==37
recode s1aq3b (1=6) if hid =="5220752220010"  & s1aq1==37
recode s1aq4b (1=6) if hid =="5220752220010"  & s1aq1==37
recode s1aq6b (1=6) if hid =="5220752220010"  & s1aq1==37


////3511335106003
br hid-s1aq8b  if hid =="3511335106003" & s1aq1==37
recode s1aq4a (3=.) if hid =="3511335106003"  & s1aq1==37
recode s1aq4b (5=.) if hid =="3511335106003"  & s1aq1==37


////4220442209005
br hid-s1aq8b  if hid =="4220442209005" & s1aq1==37
recode s1aq3b (1=6) if hid =="4220442209005"  & s1aq1==37
recode s1aq6a (1=.) if hid =="4220442209005"  & s1aq1==37
recode s1aq6b (1=.) if hid =="4220442209005"  & s1aq1==37
recode s1aq7b (1=6) if hid =="4220442209005"  & s1aq1==37


////1020110208015
br hid-s1aq8b  if hid =="1020110208015" & s1aq1==37
recode s1aq4b (1=6) if hid =="1020110208015"  & s1aq1==37


////7010870115005
br hid-s1aq8b  if hid =="7010870115005" & s1aq1==37
recode s1aq5 (600=.) if hid =="7010870115005"  & s1aq1==37


////5121251218015
br hid-s1aq8b  if hid =="5121251218015" & s1aq1==37
recode s1aq3b (1=6) if hid =="5121251218015"  & s1aq1==37
recode s1aq4b (1=6) if hid =="5121251218015"  & s1aq1==37
recode s1aq6b (1=6) if hid =="5121251218015"  & s1aq1==37


////6211662120014
br hid-s1aq8b  if hid =="6211662120014" & s1aq1==37
recode s1aq4a (0=.) if hid =="6211662120014"  & s1aq1==37
recode s1aq4b (6=.) if hid =="6211662120014"  & s1aq1==37
recode s1aq6a (6=.) if hid =="6211662120014"  & s1aq1==37
recode s1aq6b (0=.) if hid =="6211662120014"  & s1aq1==37
recode s1aq7a (6=.) if hid =="6211662120014"  & s1aq1==37
recode s1aq7b (2=.) if hid =="6211662120014"  & s1aq1==37
recode s1aq8a (6=2) if hid =="6211662120014"  & s1aq1==37
recode s1aq8b (0=6) if hid =="6211662120014"  & s1aq1==37


////5222152223016
br hid-s1aq8b  if hid =="5222152223016" & s1aq1==37
recode s1aq3b (1=6) if hid =="5222152223016"  & s1aq1==37
recode s1aq4b (1=6) if hid =="5222152223016"  & s1aq1==37
recode s1aq5 (.=400) if hid =="5222152223016"  & s1aq1==37
recode s1aq6b (1=6) if hid =="5222152223016"  & s1aq1==37
recode s1aq7b (1=6) if hid =="5222152223016"  & s1aq1==37


////5621856204002
br hid-s1aq8b  if hid =="5621856204002" & s1aq1==37
recode s1aq4a (0=.) if hid =="5621856204002"  & s1aq1==37
recode s1aq4b (6=.) if hid =="5621856204002"  & s1aq1==37
recode s1aq6a (6=.) if hid =="5621856204002"  & s1aq1==37
recode s1aq6b (0=.) if hid =="5621856204002"  & s1aq1==37
recode s1aq7a (6=.) if hid =="5621856204002"  & s1aq1==37
recode s1aq7b (0=.) if hid =="5621856204002"  & s1aq1==37
recode s1aq8a (6=1) if hid =="5621856204002"  & s1aq1==37
recode s1aq8b (0=6) if hid =="5621856204002"  & s1aq1==37


////5320653207015
br hid-s1aq8b  if hid =="5320653207015" & s1aq1==37
recode s1aq3b (0=6) if hid =="5320653207015"  & s1aq1==37


////5622156219015
br hid-s1aq8b  if hid =="5622156219015" & s1aq1==37
recode s1aq3b (0=6) if hid =="5622156219015"  & s1aq1==37
recode s1aq7b (5=6) if hid =="5622156219015"  & s1aq1==37


//951 this is where I stopped      ********* Muhammed I. Jaiteh***********
br


*******************************************************
*************** Sering starts *************************
*******************************************************

*** Look at items individually
numlabel, add
tab s1aq1

sort s1aq3b

gen pending = .

*=========================
****** item 33- life sheep
*=========================

br hid s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1 == 33

// It appears some enteries for live sheep (33) should have been sheep meet (43)

** spent 8000 on ship, unit== kg-- change to piece
replace s1aq3b = 6 if s1aq3b == 1 & s1aq1==33 & hid == "3050230544010"


*** expenditures <1000 on a whole sheep should be changed to sheep meat

replace s1aq1 = 43 if s1aq1 == 33 & s1aq3b == 1 & s1aq5!=.

** Take a look at item 33 again
br hid s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1 == 33

** those with an actual amount spent
sum s1aq5 if s1aq1 == 33 //one item with an expenditure of 210

replace s1aq1 = 43 if s1aq1 == 33 & s1aq3b == 5 & s1aq5!=.

*** remaining ones- change to sheep meat
br hid s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1 == 33 & s1aq3b!=6

replace s1aq1 = 43 if s1aq1 == 33 & s1aq3b == 1

replace pending = 1 if s1aq1 == 33 & s1aq3b!=6

*=========================
****** item 34- life goat
*=========================

br hid s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1 == 34

** Again most of the kilograms should be mutton instead of life goat

br hid s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1 == 34 & s1aq3b == 1

** one kilogram should be changed to piece. change all units from kg to piece

replace s1aq3b = 6 if s1aq1 == 34 & s1aq5 == 8000
replace s1aq4b = 6 if s1aq1 == 34 & s1aq5 == 8000
replace s1aq6b = 6 if s1aq1 == 34 & s1aq5 == 8000

*** mistake in qty and unit-- instead of 1 piece, it says 6kg
replace s1aq3b = 6 if s1aq3b == 1 & s1aq1 == 34 & hid == "4021040223003"

replace s1aq3a = 1 if s1aq3a == 6 & s1aq1 == 34 & hid == "4021040223003"

** check again.
br hid s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1 == 34 & s1aq3b == 1


***sticky 1 error
replace s1aq4a = 1 if s1aq4a == 11 & s1aq1 ==34 & hid == "5220952204009"

replace s1aq6a = 1 if s1aq6a == 11 & s1aq1 ==34 & hid == "5220952204009"

** mistake- packet to piece/number
replace s1aq3b = 6 if s1aq3b == 5 & s1aq1 == 34 & hid == "6430364311004"


// Remaining ones (with amount spent!=.) should be changed to goat meat instead of life goat

count if s1aq1 == 34 & s1aq3b == 1 & s1aq5!=. //26 changes to be made

replace s1aq1 = 48 if s1aq1 == 34 & s1aq3b == 1 & s1aq5!=.


*** remaining ones to be corrected:

br hid s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1 == 34 & s1aq3b != 6

*** change ones with kg to goat meat
replace s1aq1 = 48 if s1aq1 == 34 & s1aq3b == 1

replace pending = 1 if s1aq1 == 34 & s1aq3b != 6

*=========================
****** item 35- life bull
*=========================

br hid s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1 == 35

*** Fix mistakes in unit/quantity
replace s1aq3b = 6 if s1aq3b == 1 & s1aq1 == 35 & hid == "6311563111016"

replace s1aq3a = 1 if s1aq3a == 6 & s1aq1 == 35 & hid == "6311563111016"

*wrong unit
replace s1aq3b = 6 if s1aq3b == 1 & s1aq1 == 35 & hid == "5320653207014"

*100 KG bag? should be kg
replace s1aq3b = 1 if s1aq3b == 15 & s1aq1 == 35 & hid == "5012950109014"

// Remaining ones (with amount spent!=.) should be changed to beef instead of life bull

count if s1aq1 == 35 & s1aq3b == 1 

replace s1aq1 = 42 if s1aq1 == 35 & s1aq3b == 1

******* Remaining ones
br hid s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1 == 35 & s1aq3b!=6

replace pending = 1 if s1aq1 == 35 & s1aq3b!=6
*=========================
****** item 36- life pig
*=========================

br hid s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1 == 36
//NO PROBLEMS


*=========================
****** item 37- life chicken- local breed
*=========================

br hid s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1 == 37

** focus on the ones which are not piece/number of life chicken
br hid s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1 == 37 & s1aq3b!=6

*** TO FIX- those with kg or packet- to be changed to chicken meat?

*wrong unit- Big tomato cup

replace s1aq3b = 6 if s1aq3b == 9 & s1aq1 == 37 & hid == "7322073230004"

br hid s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1 == 37 & s1aq3b!=6

*** TO FIX- those with kg or packet- to be changed to chicken meat?
replace pending = 1 if s1aq1 == 37 & s1aq3b!=6

*=========================
****** item 38- life chicken- industrial breed
*=========================

/*
TO CONFIRM WITH GBOS- unit for life chicken imported should be piece/number? i.e WHOLE CHICKEN SOLD in SUPERMARKETS
*/
br hid s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1 == 38

*** TO FIX- those with kg or packet- to be changed to chicken meat?
replace pending = 1 if s1aq1 == 38
*=========================
****** item 39- life duck
*=========================

br hid s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1 == 39

** wrong unit- change from kg to piece
replace s1aq3b = 6 if s1aq3b == 1 & s1aq1 == 39 & hid == "7420174207003"

replace s1aq7b = 6 if s1aq7b == 1 & s1aq1 == 39 & hid == "7420174207003"

*** pending
replace pending =1 if s1aq1 == 39 & s1aq3b ==0

*=========================
****** item 40- life guinea fowl
*=========================

br hid s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1 == 40

*** change no units to piece/number
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 40 & hid == "5520155217012"

replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 40 & hid == "3110331110009"


*=========================
****** item 41- Other Live  and Land animals
*=========================

br hid s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1 == 41

// Two entries with kg units
replace pending = 1 if s1aq1 == 41 & s1aq3b!=6

*=========================
****** item 42- Beef with bones
*=========================

br hid s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1 == 42

*** focus on non-kg
br hid s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1 == 42 & s1aq3b!=1

// NOTE- it appears most of the entries with units bunch/heap are sticky 1 problems- change to kg
br hid s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1 == 42 & s1aq3b==11

** wrong qty- 2 instead of 26
replace s1aq3a = 2 if s1aq3a == 26 & s1aq1 ==42 & hid == "8621386228016"

foreach v in s1aq3b s1aq4b s1aq6b s1aq7b s1aq8b {
	replace `v' = 1 if `v' == 11 & s1aq1 == 42
	
}

*** mismatch in unit and qty- 11 qty & unit= 15 should be qty =1.5 and unit = 1

replace s1aq3a = 1.5 if s1aq3a == 11 & s1aq1 ==42 & hid == "5420554201016"

replace s1aq3b = 1 if s1aq3b == 15 & s1aq1 ==42 & hid == "5420554201016"

** mismatch in units- entered 1 ml (4) instead of 4 kg
// corrent 3a and 3b
replace s1aq3a = 4 if s1aq3a == 1 & s1aq1 ==42 & hid == "8620286226006"
replace s1aq3b = 1 if s1aq3b == 4 & s1aq1 ==42 & hid == "8620286226006"

//correct 4a and 4b
replace s1aq4a = 4 if s1aq4a == 1 & s1aq1 ==42 & hid == "8620286226006"
replace s1aq4b = 1 if s1aq4b == 4 & s1aq1 ==42 & hid == "8620286226006"

*** the enteries with unit = gram (2) should be kg instead

foreach v in s1aq3b s1aq4b s1aq6b s1aq7b s1aq8b {
	replace `v' = 1 if `v' == 2 & s1aq1 == 42 & s1aq3a <5
	
} 


*** error in unit- change from piece/number to kg
foreach v in s1aq3b s1aq4b s1aq6b s1aq7b s1aq8b {
	replace `v' = 1 if `v' == 6 & s1aq1 == 42 & (hid == "8020580242009" | hid == "7431574306016" | hid == "2430124317007")
} 

** change amount spent to 600 instead of 690.
replace s1aq5 = 600 if s1aq5 == 690 & s1aq1 == 42 & hid == "2430124317007"

*** mismatch in units- 4b and 6b correct but 3b is wrong
replace s1aq3b = 1 if s1aq3b == 6 & s1aq1 == 42 & hid == "8621086206006"

**** REMAINING ONES TO BE FIXED
br hid s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1 == 42 & s1aq3b!=1

replace pending = 1 if s1aq1 == 42 & s1aq3b!=1

*=========================
****** item 43- Sheep
*=========================

br hid s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1 == 43

** the ones that are piece/number (6) should be changed to life sheep (33)
br hid s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1 == 43 & s1aq3b == 6

replace s1aq1 = 33 if s1aq1 == 43 & s1aq3b == 6 //13 changes made

*** wrong entry of qty. 1 instead of 21
replace s1aq3a = 1 if s1aq3a == 21 & s1aq1 == 43 & hid == "7220672220005"

replace s1aq6a = 1 if s1aq6a == 21 & s1aq1 == 43 & hid == "7220672220005"

*=========================
****** item 44- Chicken leg (Imported)
*=========================

br hid s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1 == 44

** look at non-kg enteries
sort s1aq3b

br hid s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1 == 44 & s1aq3b !=1

** wrong entry- kg instead of gram
replace s1aq3b = 1 if s1aq3b == 2 & s1aq1 == 44 & hid == "5620656225013"

** wrong entry - 2 packet (5) entered instead of 2.5 qty in kg
replace s1aq3a = 2.5 if s1aq3a == 2 & s1aq3b == 5 & s1aq1 == 44 & hid == "7320873225008"

replace s1aq3b = 1 if s1aq3b == 5 & s1aq1 == 44 & hid == "7320873225008"

** wrong unit- small tomato cup
replace s1aq3a = 7 if s1aq3a == 1 & s1aq1 == 44 & hid == "5013050117014"

replace s1aq3b = 1 if s1aq3b == 7 & s1aq1 == 44 & hid == "5013050117014"

*** wrong unit- bunch/heap likely to be due to sticky 1
****** ONLY fix those for which amount spent is at least 100 GMD
foreach v in s1aq3b s1aq4b s1aq6b s1aq7b s1aq8b {
	replace `v' = 1 if `v' == 11 & s1aq1 == 44 & inrange(s1aq5, 101, 500)	
} 


*** wrong entries- gram instead of kilograms
replace s1aq3a = 2 if s1aq3a == 1 & s1aq3b == 2 & s1aq1 == 44 & hid == "1130111303004"

replace s1aq3b = 1 if s1aq3b == 2 & s1aq1 == 44 & hid == "1130111303004"

replace s1aq3b = 1 if s1aq3b == 2 & s1aq4b == 1 & s1aq1 == 44

foreach v in s1aq3b s1aq4b s1aq6b s1aq7b s1aq8b {
	replace `v' = 1 if `v' == 2 & s1aq1 == 44 & (hid == "3721737202005" | hid == "5320653207016" | hid == "2430124317007")
} 

*** Remaining
replace pending = 1 if s1aq1 == 44 & s1aq3b !=1

/*
Packet- pack of chicken legs sold in supermarkets
piece - pieces of chicken legs sold in local markets
Bunch/heap- not quite sure- could this be same as piece/number
*/

*=========================
****** item 45- Chicken(Local)
*=========================

br hid s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1 == 45

replace s1aq3b = 1 & s1aq3b == 4 & s1aq1 == 45 & hid == "3820638202006"

** focus on non-piece/number
br hid s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1 == 45 & s1aq3b!=6

replace s1aq3b = 6 if s1aq3b == 1 & s1aq4b == 6 & s1aq1 == 45
/*
NEED TO ASK GBOS if CHICKEN LOCAL SHOULD BE PIECE/NUMBER
If so, then replace kg to piece/number
*/

****pending
replace pending = 1 if s1aq1 == 45 & s1aq3b!=6

*=========================
****** item 46- Pork
*=========================

br hid s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1 == 46

** only two items pending
replace pending =1 if s1aq1 == 46 & s1aq3b == 6


*=========================
****** item 47 Chicken Wings (Imported)
*=========================

br hid s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1 == 47

** reasonable units are kg and packet

** pending ones are: piece/number and 1 entry for bunch/heap
replace pending = 1 if s1aq1 == 47 & (s1aq3b == 6 | s1aq3b == 11)


*=========================
****** item 48 Goat meat
*=========================

br hid s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1 == 48

*** bunch/heap due to sticky 1?
foreach v in s1aq3b s1aq4b s1aq6b s1aq7b s1aq8b {
	replace `v' = 1 if `v' == 11 & s1aq1 == 48 
} 

*** pending - piece/number and gram

replace pending = 1 if s1aq1 == 48 & s1aq3b != 1


*=========================
****** item 49 Beef without bones
*=========================

br hid s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1 == 49

**error in unit for 4b
replace s1aq4a = 8 if s1aq4a == 1 & s1aq4b == 8 & s1aq1 == 49 & hid == "5013050113015"

replace s1aq4b = 1 if s1aq4b == 8 & s1aq1 == 49 & hid == "5013050113015"

** wrong amount- instead of qty = 1 & amt == 200, the reverse is entered
foreach v in s1aq3a s1aq4a s1aq6a {
	
	replace `v' = 1 if `v' == 200 & s1aq1 ==49 & hid == "5530155356014"
}



** wrong unit- liters instead of kg
replace s1aq4b = 1 if s1aq4b == 3 & s1aq1 == 49 & hid == "7420374219016"

** Grams and bunch/heap should be kg instead
foreach v in s1aq3b s1aq4b s1aq6b s1aq7b s1aq8b {
	replace `v' = 1 if (`v' == 11 | `v' == 2) & s1aq1 == 49 
} 

*** Only one remaining
replace pending = 1 if s1aq1 == 49 & s1aq3b != 1


*=========================
****** item 50 Chicken (whole frozen)
*=========================

br hid s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a  s1aq7b s1aq8a s1aq8b if s1aq1 == 50

*** Not a big problem here, we only need to ensure consistency - take as a packet or piece/number and change accordingly.

***ST- decided to go with piece

foreach v in s1aq3b s1aq4b s1aq6b s1aq7b s1aq8b {
	replace `v' = 6 if (`v' == 1 | `v' == 5) & s1aq1 == 50 
} 

*** One mistake in unit of 3b
replace s1aq3b = 6 if s1aq3b == 0 & s1aq4b == 6 & s1aq1 == 50 


** few pending
replace pending = 1 if s1aq1 == 50 & s1aq3b != 6



*=========================
****** item 51 Other Meat, fresh, chilled or froz
*=========================

br hid s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a  s1aq7b s1aq8a s1aq8b if s1aq1 == 51

** 1 pending entry - bunch/heap- change to kg?
replace s1aq3b = 1 if s1aq3b == 11 & s1aq1 == 51
replace s1aq7b = 1 if s1aq7b == 11 & s1aq1 == 51
*=========================================================


/*FROM ROSE
gen asdd=1  if (s1aq4a>=1000 & s1aq4a~=.) & s1aq1<=8  //103 cases
replace s1aq5=s1aq4a  if asdd==1 & s1aq5==.
replace s1aq4b=14     if asdd==1 & s1aq4a==s1aq5
replace s1aq4a=1      if asdd==1 & s1aq4a==s1aq5 & s1aq4b==14



gen asdd1=1  if asdd==1 & (s1aq4a>=1000 & s1aq4a~=.) & s1aq1<=8
replace s1aq6a=s1aq3a  if asdd1==1
replace s1aq6b=s1aq3b  if asdd1==1
replace s1aq5=s1aq4a   if asdd1==1 & s1aq4b~=10
replace s1aq4a=1       if asdd==1 & s1aq4a==s1aq5 & s1aq4b==14
replace s1aq4a=50      if asdd==1 & s1aq4a==s1aq5 & s1aq4b==1
replace s1aq4a=s1aq3a  if asdd1==1 & s1aq6a==s1aq3a & s1aq4b==10
drop asdd1 asdd */

br

egen tot_consumed = rowtotal( s1aq6a s1aq7a s1aq8a) 

/* total quantity household consume is not equal to quantity consume of household
 from puchase, own production & gifts to Within the past 7 days*/ 
 
count if s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.  //5,380 cases 
br if s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.
br hid-s1aq8b tot_consumed if s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.
list s1aq2 s1aq1 s1aq3a s1aq6a s1aq7a s1aq8a tot_consumed if s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.
br s1aq2 s1aq1 s1aq3a s1aq6a s1aq7a s1aq8a tot_consumed if s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.



br hid-s1aq8b tot_consumed if hid =="3820238208009"  & s1aq1==33
recode s1aq6a (10=.) if hid =="3820238208009" & s1aq1==33
recode  s1aq6b (1=.) if hid =="3820238208009" & s1aq1==33
recode  s1aq7a (1=10)if hid =="3820238208009" & s1aq1==33



br hid-s1aq8b tot_consumed if hid =="8620586211011"  & s1aq1==33
recode s1aq3a (2=1) if hid =="8620586211011" & s1aq1==33


////3810938107013
br hid-s1aq8b tot_consumed if hid =="3810938107013"  & s1aq1==33
recode s1aq3b (0=6) if hid =="3810938107013" & s1aq1==33
recode  s1aq7a (.=1)if hid =="3810938107013" & s1aq1==33

////5220452209012
br hid-s1aq8b tot_consumed if hid =="5220452209012"  & s1aq1==34
recode s1aq3b (0=6) if hid =="5220452209012" & s1aq1==34
recode s1aq6a (.=1) if hid =="5220452209012" & s1aq1==34
recode  s1aq6b (.=6) if hid =="5220452209012" & s1aq1==34

////5013050125015


br hid-s1aq8b tot_consumed if hid =="5013050125015"  & s1aq1==43
recode s1aq4b (.=1) if hid =="5013050125015" & s1aq1==43
recode s1aq6a (.=4) if hid =="5013050125015" & s1aq1==43
recode  s1aq6b (.=1) if hid =="5013050125015" & s1aq1==43

////3810938107013
br hid-s1aq8b tot_consumed if hid =="3810938107013"  & s1aq1==43
recode s1aq7a (.=1) if hid =="3810938107013" & s1aq1==43



sort hid s1aq1
drop tot_consumed
egen tot_consumed = rowtotal( s1aq6a s1aq7a s1aq8a) 
br  hid s1aq2 s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b tot_consumed if s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.


/******************************
 *********** March 28th. 
 *********** Task Division


keep if s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.
gen count = _n
gen responsible = 1 if inrange(count, 1,1335)
replace responsible = 2 if inrange(count, 1336 , 2670)
replace responsible = 3 if inrange(count, 2671 , 4005)
replace responsible = 4 if responsible == .
label define responsible 1 "Janneh" 2 "Davies" 3 "Isatou" 4 "Sering"
label values responsible responsible
tab responsible
*/

/****
Sering Starts-

*/

*keep if responsible == 4

gen pending_sering = .
*****************************
****** Okra
****************************
///// 7410374108011
replace s1aq5 = 50 if s1aq5 == 11 & s1aq1 == 156 & hid == "7410374108011"
replace s1aq6a = 5 if s1aq6a == 50 & s1aq1 == 156 & hid == "7410374108011"
replace s1aq6b = 11 if s1aq6b == 5 & s1aq1 == 156 & hid == "7410374108011"
replace s1aq7a = . if s1aq7a == 11 & s1aq1 == 156 & hid == "7410374108011"
replace s1aq7b = . if s1aq7b == 0 & s1aq1 == 156 & hid == "7410374108011"

replace s1aq3a = 5 if s1aq3a == 4 & s1aq1 == 156 & hid == "7410374108011"
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 156 & hid == "7410374108011"


////// 4020340202002
replace s1aq8a = 5 if s1aq8a == 11 & s1aq1 == 156 & hid == "4020340202002"
replace s1aq8b = 11 if s1aq8b == 0 & s1aq1 == 156 & hid == "4020340202002"
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 156 & hid == "4020340202002"

/// missing units for 3b
replace s1aq3b = 11 if s1aq3b == 0 & (hid == "7510175105102" | hid == "8120681207006")

*** wrong quantity and unit- /// 2020120213010
replace s1aq3a = 5 if s1aq3a == 1 & s1aq1 == 156 & hid == "2020120213010"
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 156 & hid == "2020120213010"
replace s1aq4b = 11 if s1aq4b == 1 & s1aq1 == 156 & hid == "2020120213010"
replace s1aq5 = . if s1aq5 == 11 & s1aq1 == 156 & hid == "2020120213010"

**** Duplicate in purchases and own production. Keep own production since no expenditure is reportbr

//// 5122851222008
replace s1aq6a = . if s1aq6a == 5 & s1aq1 == 156 & hid == "5122851222008"
replace s1aq6b = . if s1aq6b == 11 & s1aq1 == 156 & hid == "5122851222008"

replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 156 & hid == "5122851222008"

//// 3330533320014
replace s1aq6a = . if s1aq6a == 5 & s1aq1 == 156 & hid == "3330533320014"
replace s1aq6b = . if s1aq6b == 11 & s1aq1 == 156 & hid == "3330533320014"

replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 156 & hid == "3330533320014"


//// 3330133317009
replace s1aq6a = . if s1aq6a == 4 & s1aq1 == 156 & hid == "3330133317009"
replace s1aq6b = . if s1aq6b == 6 & s1aq1 == 156 & hid == "3330133317009"

replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 156 & hid == "3330133317009"


/// 3311533135013
replace s1aq6a = . if s1aq6a == 3 & s1aq1 == 156 & hid == "3311533135013"
replace s1aq6b = . if s1aq6b == 11 & s1aq1 == 156 & hid == "3311533135013"

replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 156 & hid == "3311533135013"


**** wrong unit for 3a
///// 8212782103005

replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 156 & hid == "8212782103005"

*replace pending_sering = 1 if s1aq1 == 156 & hid == "8212782103005"


**** Duplicate in purchases and own production. Keep purchases since  expenditure is reported

///3420234201012
replace s1aq7a = . if s1aq7a == 4 & s1aq1 == 156 & hid == "3420234201012"
replace s1aq7b = . if s1aq7b == 11 & s1aq1 == 156 & hid == "3420234201012"

replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 156 & hid == "3420234201012"


///5530155321010
replace s1aq7a = . if s1aq7a == 6 & s1aq1 == 156 & hid == "5530155321010"
replace s1aq7b = . if s1aq7b == 11 & s1aq1 == 156 & hid == "5530155321010"

replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 156 & hid == "5530155321010"

*** Sticky 1/0
//// 5220952204003
replace s1aq6a = 1 if s1aq6a == 111 & s1aq1 == 156 & hid == "5220952204003"
replace s1aq6b = 11 if s1aq6b == 0 & s1aq1 == 156 & hid == "5220952204003"

replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 156 & hid == "5220952204003"

//// 3050230524008
replace s1aq4a = 5 if s1aq4a == 511 & s1aq1 == 156 & hid == "3050230524008"
replace s1aq6a = 5 if s1aq6a == 511 & s1aq1 == 156 & hid == "3050230524008"

replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 156 & hid == "3050230524008"

/// 6211662120015 - sticky 0 and duplicated entry- both purchase and own/production - use own production since amount spent is not reported.

replace s1aq4a = 1 if s1aq4a == 100 & s1aq1 == 156 & hid == "3050230524008"
replace s1aq6a = . if s1aq6a == 100 & s1aq1 == 156 & hid == "3050230524008"

replace s1aq6b = . if s1aq6b == 11 & s1aq1 == 156 & hid == "3050230524008"

replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 156 & hid == "3050230524008"

///3421134215004
replace s1aq6a = . if s1aq6a == 2 & s1aq1 == 156 & hid == "3421134215004"
replace s1aq6b = . if s1aq6b == 11 & s1aq1 == 156 & hid == "3421134215004"

replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 156 & hid == "3421134215004"


///3410134112011
replace s1aq6a = . if s1aq6a == 3 & s1aq1 == 156 & hid == "3410134112011"
replace s1aq6b = . if s1aq6b == 11 & s1aq1 == 156 & hid == "3410134112011"

replace s1aq4a = 3 if s1aq4a == . & s1aq1 == 156 & hid == "3410134112011"
replace s1aq4b = 11 if s1aq4b == . & s1aq1 == 156 & hid == "3410134112011"

replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 156 & hid == "3410134112011"


//3711637103004
replace s1aq6a = . if s1aq6a == 21 & s1aq1 == 156 & hid == "3711637103004"
replace s1aq6b = . if s1aq6b == 11 & s1aq1 == 156 & hid == "3711637103004"

replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 156 & hid == "3711637103004"

replace s1aq7a = 21 if s1aq7a == 1 & s1aq1 == 156 & hid == "3711637103004"
replace s1aq4a = 21 if s1aq4a == . & s1aq1 == 156 & hid == "3711637103004"
replace s1aq4b = 11 if s1aq4b == . & s1aq1 == 156 & hid == "3711637103004"


//7321373205003 - wrong entry.
replace s1aq6a = . if s1aq6a == 11 & s1aq1 == 156 & hid == "7321373205003"
replace s1aq6b = . if s1aq6b == 11 & s1aq1 == 156 & hid == "7321373205003"

replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 156 & hid == "7321373205003"

replace s1aq4a = 4 if s1aq4a == 11 & s1aq1 == 156 & hid == "7321373205003"
replace s1aq4b = 11 if s1aq4b == . & s1aq1 == 156 & hid == "7321373205003"

///5111451111014
replace s1aq6a = . if s1aq6a == 5 & s1aq1 == 156 & hid == "5111451111014"
replace s1aq6b = . if s1aq6b == 6 & s1aq1 == 156 & hid == "5111451111014"

replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 156 & hid == "5111451111014"

//3410334110014 - wrong entry.
replace s1aq6a = . if s1aq6a == 2 & s1aq1 == 156 & hid == "3410334110014"
replace s1aq6b = . if s1aq6b == 11 & s1aq1 == 156 & hid == "3410334110014"

replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 156 & hid == "3410334110014"

replace s1aq4a = 2 if s1aq4a == . & s1aq1 == 156 & hid == "3410334110014"
replace s1aq4b = 11 if s1aq4b == . & s1aq1 == 156 & hid == "3410334110014"


//4110741108016
replace s1aq6a = . if s1aq6a == 7 & s1aq1 == 156 & hid == "4110741108016"
replace s1aq6b = . if s1aq6b == 11 & s1aq1 == 156 & hid == "4110741108016"

replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 156 & hid == "4110741108016"

replace s1aq7a = 7 if s1aq7a == 1 & s1aq1 == 156 & hid == "4110741108016"
replace s1aq4a = 7 if s1aq4a == . & s1aq1 == 156 & hid == "4110741108016"
replace s1aq4b = 11 if s1aq4b == . & s1aq1 == 156 & hid == "4110741108016"


///5111451111014
replace s1aq6a = . if s1aq6a == 5 & s1aq1 == 156 & hid == "5111451111014"
replace s1aq6b = . if s1aq6b == 6 & s1aq1 == 156 & hid == "5111451111014"

replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 156 & hid == "5111451111014"

////4020340202012
replace s1aq7a = 7 if s1aq7a == 1 & s1aq1 == 156 & hid == "4020340202012"

replace s1aq6a = . if s1aq6a == 7 & s1aq1 == 156 & hid == "4020340202012"
replace s1aq6b = . if s1aq6b == 11 & s1aq1 == 156 & hid == "4020340202012"

replace s1aq4a = 7 if s1aq4a == . & s1aq1 == 156 & hid == "4020340202012"
replace s1aq4b = 11 if s1aq4b == . & s1aq1 == 156 & hid == "4020340202012"

replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 156 & hid == "4020340202012"


///5530155311003
replace s1aq6a = 1 if s1aq6a == 100 & s1aq1 == 156 & hid == "5530155311003"

replace s1aq4a = 1 if s1aq4a == 100 & s1aq1 == 156 & hid == "5530155311003"

replace s1aq5 = 60 if s1aq5 == 120 & s1aq1 == 156 & hid == "5530155311003"

replace s1aq3a = 1 if s1aq3a == 60 & s1aq1 == 156 & hid == "5530155311003"
replace s1aq3b = 1 if s1aq3b == 0 & s1aq1 == 156 & hid == "5530155311003"

//// 8212782103005
replace s1aq6a = 5 if s1aq6a == 2 & s1aq1 == 156 & hid == "8212782103005"

/// 8320183237014
replace s1aq7a = 12 if s1aq7a == 2 & s1aq1 == 156 & hid == "8320183237014"

replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 156 & hid == "8320183237014"

replace s1aq4a = 12 if s1aq4a == . & s1aq1 == 156 & hid == "8320183237014"

replace s1aq4b = 6 if s1aq4b == . & s1aq1 == 156 & hid == "8320183237014"

/// 8411384103015
replace s1aq7a = 5 if s1aq7a == 3 & s1aq1 == 156 & hid == "8411384103015"

replace s1aq7b = 11 if s1aq7b == 99 & s1aq1 == 156 & hid == "8411384103015"

replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 156 & hid == "8411384103015"

replace s1aq4a = 5 if s1aq4a == . & s1aq1 == 156 & hid == "8411384103015"

replace s1aq4b = 11 if s1aq4b == . & s1aq1 == 156 & hid == "8411384103015"

*** no entry for 4, but enteries for both 6 and 7--- flag as pending
*replace pending_sering = 1 if hid == "4020340202012" & s1aq1 == 156
*replace pending_sering = 1 if hid == "8411384103015" & s1aq1 == 156
*replace pending_sering = 1 if hid == "8320183237014" & s1aq1 == 156
*replace pending_sering = 1 if hid == "5530155311003" & s1aq1 == 156
*replace pending_sering = 1 if hid == "3410834114003" & s1aq1 == 156





*** Adjust 3 to match quantity consumed and purchased
// 8611886107002
replace s1aq3a = 20 if s1aq3a == 10 & s1aq1 == 156 & hid == "8611886107002"

replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 156 & hid == "8611886107002"


***** missing details- qty. consumed from purchases (6) missing.

/// 4210142109016
replace s1aq6a = 7 if s1aq6a == . & s1aq1 == 156 & hid == "4210142109016"
replace s1aq6b = 11 if s1aq6b == . & s1aq1 == 156 & hid == "4210142109016"

replace s1aq3b = 11 if s1aq3b == 6 & s1aq1 == 156 & hid == "4210142109016"

**** error in breakdown- sources- received as gift by unit entered in place of qty.

///5111551117003
replace s1aq8a = 7 if s1aq8a == 11 & s1aq1 == 156 & hid == "5111551117003"
replace s1aq8b = 11 if s1aq8b == 0 & s1aq1 == 156 & hid == "5111551117003"

replace s1aq4a = 7 if s1aq4a == . & s1aq1 == 156 & hid == "5111551117003"
replace s1aq4b = 11 if s1aq4b == . & s1aq1 == 156 & hid == "5111551117003"
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 156 & hid == "5111551117003"

// 5530155356014
replace s1aq6a = 5 if s1aq6a == 15 & s1aq1 == 156 & hid == "5530155356014"

replace s1aq4a = 5 if s1aq4a == 15 & s1aq1 == 156 & hid == "5530155356014"
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 156 & hid == "5530155356014"

/*
WHAT follows now restricts the code to my share only.
*/

*keep if responsible == 4

drop tot_consumed
egen tot_consumed = rowtotal( s1aq6a s1aq7a s1aq8a) 
br  hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b tot_consumed if s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

/***** Common issues
ISSUE 1. Breakdown of qty consumed (4) is entered twice - in purchases (6) and own production (7)

Fix: if amount spent (5) is missing, keep qty obtained from own production (7) and delete qty. in purchases (6)

*/
count if s1aq5==. & tot_consumed == 2*s1aq3a & s1aq6a == s1aq7a & s1aq8a==.
gen issue1 = 1 if s1aq5==. & tot_consumed == 2*s1aq3a & s1aq6a == s1aq7a & s1aq8a==.

br  hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b tot_consumed if issue1 == 1

replace s1aq3b = s1aq7b if s1aq3b == 0 & s1aq7b!=. & issue1 == 1
replace s1aq4a = s1aq3a if s1aq4a != s1aq3a & issue1 == 1
replace s1aq4b = s1aq3b if s1aq4b != s1aq3b & issue1 == 1

replace s1aq6a = . if issue1 == 1
replace s1aq6b = . if issue1 == 1


/*
ISSUE 2. Breakdown of qty consumed (4) is entered twice - in purchases (6) and own production (7)

Fix: if amount spent (5) is NOT missing, keep  qty. in purchases (6) and delete qty obtained from own production (7)

*/
drop tot_consumed
egen tot_consumed = rowtotal( s1aq6a s1aq7a s1aq8a) 

count if s1aq5!=. & tot_consumed == 2*s1aq3a & s1aq6a == s1aq7a & s1aq8a==.
gen issue2 = 1 if s1aq5!=. & tot_consumed == 2*s1aq3a & s1aq6a == s1aq7a & s1aq8a==.

br  hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b tot_consumed if issue2 == 1

replace s1aq3b = s1aq6b if s1aq3b == 0 & s1aq6b!=. & issue2 == 1
replace s1aq4a = s1aq3a if s1aq4a != s1aq3a & issue2 == 1
replace s1aq4b = s1aq3b if s1aq4b != s1aq3b &  issue2 == 1
replace s1aq7a = . if issue2 == 1
replace s1aq7b = . if issue2 == 1

/*
ISSUE 3. Breakdown of qty consumed (4) is entered twice - in purchases (6) and own production (7) and/or gifts (8)

Fix: if amount spent (5) is missing, keep  qty. in gifts (8) and delete qty obtained from purchases (6)

*/
drop tot_consumed
egen tot_consumed = rowtotal( s1aq6a s1aq7a s1aq8a) 

count if s1aq5==. & tot_consumed == 2*s1aq3a & s1aq6a == s1aq8a & s1aq8a!=.
gen issue3 = 1 if s1aq5==. & tot_consumed == 2*s1aq3a & s1aq6a == s1aq8a & s1aq8a!=.

br  hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b tot_consumed if issue3 == 1

replace s1aq3b = s1aq8b if s1aq3b == 0 & s1aq8b!=. & issue3 == 1
replace s1aq4a = s1aq3a if s1aq4a != s1aq3a &  issue3 == 1
replace s1aq4b = s1aq3b if s1aq4b != s1aq3b &  issue3 == 1
replace s1aq6a = . if issue3 == 1
replace s1aq6b = . if issue3 == 1


/*
ISSUE 4. Breakdown of qty consumed (4) is entered twice - in purchases (6) and own production (7) and/or gifts (8)

Fix: if amount spent (5) is NOT missing, keep  qty. obtained from purchases (6) and delete qty in gifts (8).

*/
drop tot_consumed
egen tot_consumed = rowtotal( s1aq6a s1aq7a s1aq8a) 

count if s1aq5!=. & tot_consumed == 2*s1aq3a & s1aq6a == s1aq8a & s1aq8a!=.
gen issue4 = 1 if s1aq5!=. & tot_consumed == 2*s1aq3a & s1aq6a == s1aq8a & s1aq8a!=.

br  hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b tot_consumed if issue4 == 1

replace s1aq3b = s1aq6b if s1aq3b == 0 & s1aq6b!=. & issue4 == 1
replace s1aq4a = s1aq3a if s1aq4a != s1aq3a &  issue4 == 1
replace s1aq4b = s1aq3b if s1aq4b != s1aq3b &  issue4 == 1
replace s1aq8a = . if issue4 == 1
replace s1aq8b = . if issue4 == 1

drop issue*
/*****
foreach v in s1aq6a s1aq6b {
	replace `v' = . if s1aq5==. & tot_consumed == 2*s1aq3a & s1aq1 == 156

}

foreach v in s1aq7a s1aq7b {
	replace `v' = . if s1aq5!=. & tot_consumed == 2*s1aq3a & s1aq1 == 156

}
*/
drop tot_consumed
egen tot_consumed = rowtotal( s1aq6a s1aq7a s1aq8a) 
br  hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b tot_consumed if s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.


replace pending_sering = 1 if hid == "3410834114003" & s1aq1 == 156
replace pending_sering = 1 if hid == "8510385101004" & s1aq1 == 156
replace pending_sering = 1 if hid == "4210242106008" & s1aq1 == 156
replace pending_sering = 1 if hid == "3410834114004" & s1aq1 == 156
replace pending_sering = 1 if hid == "8411384103015" & s1aq1 == 156
replace pending_sering = 1 if hid == "2110321101009" & s1aq1 == 156
replace pending_sering = 1 if hid == "8210382110016" & s1aq1 == 156
replace pending_sering = 1 if hid == "5022350219003" & s1aq1 == 156

br hid s1aq1 hhsize s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a  s1aq7b s1aq8a s1aq8b tot_consumed settlement_name settlement  lga if pending_sering == 1

*** fix for pending:
replace s1aq3b = 11 if pending_sering == 1
replace s1aq7a = s1aq3a if pending_sering == 1
replace s1aq7b = 11 if pending_sering == 1
replace s1aq4a = s1aq3a if pending_sering == 1
replace s1aq4b = 11 if pending_sering == 1

drop pending_sering

/// 3144131471009 --- potential data entry error in 3

replace s1aq3a = 9 if s1aq3a == 3 & s1aq1 == 156 & hid == "3144131471009"
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 156 & hid == "3144131471009"


*** wrong entry in own production (7) plus update total purchases - 4
replace s1aq7a = . if s1aq1 == 156 & hid == "3721237203008"
replace s1aq7b = . if s1aq1 == 156 & hid == "3721237203008"

replace s1aq4a = s1aq3a if s1aq1 == 156 & hid == "3721237203008"
replace s1aq4b = s1aq3b if s1aq1 == 156 & hid == "3721237203008"

*** wrong entry in total consumption (3)
replace s1aq3a = 12 if s1aq3a == 3 & s1aq1 == 156 & hid == "3230432314001"
replace s1aq3b = 11 if s1aq3a == 0 & s1aq1 == 156 & hid == "3230432314001"

**** Since expenditure is missing, assume entry is for own production- 6
replace s1aq7a = 14 if s1aq7a == 1 & s1aq1 == 156 & hid == "3621636211012"
replace s1aq3b = s1aq7b if s1aq1 == 156 & hid == "3621636211012"

replace s1aq6a = . if s1aq1 == 156 & hid == "3621636211012"
replace s1aq6b = . if s1aq1 == 156 & hid == "3621636211012"

replace s1aq4a = s1aq3a if s1aq1 == 156 & hid == "3621636211012"
replace s1aq4b = s1aq3b if s1aq1 == 156 & hid == "3621636211012"

***** wrong entry

replace s1aq6a = 33 if s1aq6a == 11 & s1aq1 == 156 & hid == "8620686221005"
replace s1aq4a = 33 if s1aq4a == 165 & s1aq1 == 156 & hid == "8620686221005"


replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 156 & hid == "8620686221005"


***

replace s1aq3a = 1 if s1aq3a == .1 & s1aq1 == 156 & hid == "2020120213006"
replace s1aq3b = 9 if s1aq3b == 0 & s1aq1 == 156 & hid == "2020120213006"

**** 
replace s1aq3a = 2 if s1aq3a == 3 & s1aq1 == 156 & hid == "8120681207006"
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 156 & hid == "8120681207006"


/*
MARCH 31st. 2022
TASK DIVISION above did not follow proper sorting of households
*/
sort hid s1aq1
drop tot_consumed
egen tot_consumed = rowtotal( s1aq6a s1aq7a s1aq8a) 
br  hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b tot_consumed if s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

preserve
drop if  s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

save cleaned_cases.dta, replace

restore

count if s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=. //Down to 4,216


sort hid s1aq1
keep if s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.
gen count = _n
gen responsible = 1 if inrange(count, 1,1054)
replace responsible = 2 if inrange(count, 1055 , 2110)
replace responsible = 3 if inrange(count, 2111 , 3165)
replace responsible = 4 if responsible == .
label define responsible 1 "Janneh" 2 "Davies" 3 "Isatou" 4 "Sering"
label values responsible responsible
tab responsible

save revised_task_distribution_dta_file.dta, replace


use revised_task_distribution_dta_file.dta, clear

/*
 Sering Starts
*/

keep if responsible == 4

br hid s1aq1 hhsize s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a  s1aq7b s1aq8a s1aq8b tot_consumed settlement_name settlement  lga

// 6410164116001 - mismatch between 3 and 8 - maintain what was entered in 8
replace s1aq3a = 2 if hid == "6410164116001" & s1aq1 == 146
replace s1aq3b = 11 if hid == "6410164116001" & s1aq1 == 146

replace s1aq4a = 2 if hid == "6410164116001" & s1aq1 == 146
replace s1aq4b = 11 if hid == "6410164116001" & s1aq1 == 146

//6410164116008 - additional entry not required.

replace s1aq7a = . if hid == "6410164116008" & s1aq1 == 152
replace s1aq7b = . if hid == "6410164116008" & s1aq1 == 152

replace s1aq3b = 11 if hid == "6410164116008" & s1aq1 == 152

//6410164116008
replace s1aq7a = . if hid == "6410164116008" & s1aq1 == 155
replace s1aq7b = . if hid == "6410164116008" & s1aq1 == 155

replace s1aq3b = 6 if hid == "6410164116008" & s1aq1 == 155

// 6410164116013 - likely an error with unit
replace s1aq3a = 1 if hid == "6410164116013" & s1aq1 == 164
replace s1aq3b = 1 if hid == "6410164116013" & s1aq1 == 164

replace s1aq4b = 1 if hid == "6410164116013" & s1aq1 == 164
replace s1aq6b = 1 if hid == "6410164116013" & s1aq1 == 164

//6410164116015 change 3 to match 4 and 6- likely to be 3 not 4 kgs.
replace s1aq3a = 3 if hid == "6410164116015" & s1aq1 == 164
replace s1aq3b = 1 if hid == "6410164116015" & s1aq1 == 164


//6410364103006
replace s1aq3b = 1 if hid == "6410364103006" & s1aq1 == 164

replace s1aq4a = 2 if hid == "6410364103006" & s1aq1 == 164
replace s1aq6a = 2 if hid == "6410364103006" & s1aq1 == 164
replace s1aq6b = 1 if hid == "6410364103006" & s1aq1 == 164

//6410364103008
replace s1aq3a = 4 if hid == "6410364103008" & s1aq1 == 155
replace s1aq3b = 6 if hid == "6410364103008" & s1aq1 == 155

replace s1aq4a = 4 if hid == "6410364103008" & s1aq1 == 155

//6410364103010

replace s1aq3b = 6 if hid == "6410364103010" & s1aq1 == 59

replace s1aq4a = 23 if hid == "6410364103010" & s1aq1 == 59
replace s1aq6a = 23 if hid == "6410364103010" & s1aq1 == 59
replace s1aq6b = 6 if hid == "6410364103010" & s1aq1 == 59


//6410364103015
replace s1aq3b = 6 if hid == "6410364103015" & s1aq1 == 143

replace s1aq4a = 1 if hid == "6410364103015" & s1aq1 == 143
replace s1aq4b = 6 if hid == "6410364103015" & s1aq1 == 143
replace s1aq5 = 35 if hid == "6410364103015" & s1aq1 == 143
replace s1aq6a = 1 if hid == "6410364103015" & s1aq1 == 143
replace s1aq6b = 6 if hid == "6410364103015" & s1aq1 == 143
replace s1aq7a = . if hid == "6410364103015" & s1aq1 == 143
replace s1aq7b = . if hid == "6410364103015" & s1aq1 == 143

//6410464105005
replace s1aq3a = 1 if hid == "6410464105005" & s1aq1 == 152
replace s1aq3b = 8 if hid == "6410464105005" & s1aq1 == 152

//6410464105006
replace s1aq3a = 1 if hid == "6410464105006" & s1aq1 == 152
replace s1aq3b = 8 if hid == "6410464105006" & s1aq1 == 152

replace s1aq4a = 1 if hid == "6410464105006" & s1aq1 == 152
replace s1aq4b = 8 if hid == "6410464105006" & s1aq1 == 152

//6410764121004
replace s1aq3a = 2 if hid == "6410764121004" & s1aq1 == 59
replace s1aq3b = 11 if hid == "6410764121004" & s1aq1 == 59


//6410764121006
replace s1aq3b = 1 if hid == "6410764121006" & s1aq1 == 164

replace s1aq6a = 3 if hid == "6410764121006" & s1aq1 == 164
replace s1aq6b = 1 if hid == "6410764121006" & s1aq1 == 164
replace s1aq7a = . if hid == "6410764121006" & s1aq1 == 164
replace s1aq7b = . if hid == "6410764121006" & s1aq1 == 164

**** Some other general issues
/// additional enteries made in error - 4 and 6 match but source of discrepancy btw. 3 and tot_consumed is due to additional entry in 7
gen issue = 1 if s1aq4a == s1aq6a & s1aq6a == s1aq3a & s1aq4b == s1aq6b & s1aq7a!=. & s1aq5!=.

br hid s1aq1 hhsize s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a  s1aq7b s1aq8a s1aq8b tot_consumed settlement_name settlement  lga if issue == 1

** some issues
// 6420464205010 * two bonga likely to be 10 instead of 1

replace s1aq5 = 10 if hid == "6420464205010" & s1aq1 == 59
replace s1aq3b = 6 if hid == "6420464205010" & s1aq1 == 59
replace s1aq4b = 6 if hid == "6420464205010" & s1aq1 == 59
replace s1aq6b = 6 if hid == "6420464205010" & s1aq1 == 59

//8013680119004 - local chicken likely to piece and from own production
replace s1aq5 = . if hid == "8013680119004" & s1aq1 == 45
replace s1aq3b = 6 if hid == "8013680119004" & s1aq1 == 45
replace s1aq4b = 6 if hid == "8013680119004" & s1aq1 == 45
replace s1aq6a = . if hid == "8013680119004" & s1aq1 == 45
replace s1aq6b = . if hid == "8013680119004" & s1aq1 == 45
replace s1aq7b = 6 if hid == "8013680119004" & s1aq1 == 45
replace s1aq8a = . if hid == "8013680119004" & s1aq1 == 45
replace s1aq8b = . if hid == "8013680119004" & s1aq1 == 45

replace issue = . if hid == "8013680119004" & s1aq1 == 45

*** 2 entered throughout- likely an error 8410684119005

foreach v in s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a  s1aq7b s1aq8a s1aq8b issue {
	replace `v' = . if hid == "8410684119005" & s1aq1 == 61

}

** What remains can be be fixed by removing other entries - 7 and 8 when !missing
replace s1aq3b = s1aq4b if issue == 1

foreach v in s1aq7a  s1aq7b s1aq8a s1aq8b{
	replace `v' = . if issue == 1

}


drop tot_consumed issue
egen tot_consumed = rowtotal( s1aq6a s1aq7a s1aq8a) 
br hid s1aq1 hhsize s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a  s1aq7b s1aq8a s1aq8b tot_consumed settlement_name settlement  lga if s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

// 6410464105005
replace s1aq3b = 8 if hid == "6410464105005" & s1aq1 == 152
replace s1aq4a = 5 if hid == "6410464105005" & s1aq1 == 152
replace s1aq4b = 6 if hid == "6410464105005" & s1aq1 == 152
replace s1aq6a = 5 if hid == "6410464105005" & s1aq1 == 152


// 6410864115001
replace s1aq3b = 6 if hid == "6410864115001" & s1aq1 == 69
replace s1aq8a = . if hid == "6410864115001" & s1aq1 == 69
replace s1aq8b = . if hid == "6410864115001" & s1aq1 == 69

// 6410764121012
replace s1aq3b = 99 if hid == "6410764121012" & s1aq1 == 164
replace s1aq4a = 20 if hid == "6410764121012" & s1aq1 == 164
replace s1aq5 = 500 if hid == "6410764121012" & s1aq1 == 164
replace s1aq6a = 20 if hid == "6410764121012" & s1aq1 == 164
replace s1aq6b = 99 if hid == "6410764121012" & s1aq1 == 164

// 6410864115003
replace s1aq3a = 1 if hid == "6410864115003" & s1aq1 == 91
replace s1aq3b = 1 if hid == "6410864115003" & s1aq1 == 91
replace s1aq4a = 1 if hid == "6410864115003" & s1aq1 == 91
replace s1aq5 = 200 if hid == "6410864115003" & s1aq1 == 91
replace s1aq6a = 1 if hid == "6410864115003" & s1aq1 == 91
replace s1aq6b = 1 if hid == "6410864115003" & s1aq1 == 91

//6410864115005
replace s1aq3a = 1 if hid == "6410864115005" & s1aq1 == 91
replace s1aq3b = 1 if hid == "6410864115005" & s1aq1 == 91
replace s1aq4a = 1 if hid == "6410864115005" & s1aq1 == 91
replace s1aq5 = 200 if hid == "6410864115005" & s1aq1 == 91
replace s1aq6a = 1 if hid == "6410864115005" & s1aq1 == 91
replace s1aq6b = 1 if hid == "6410864115005" & s1aq1 == 91

// 6411164123002
replace s1aq3b = 11 if hid == "6411164123002" & s1aq1 == 152
replace s1aq4a = 5 if hid == "6411164123002" & s1aq1 == 152
replace s1aq6a = 5 if hid == "6411164123002" & s1aq1 == 152
replace s1aq6b = 11 if hid == "6411164123002" & s1aq1 == 152

//6411164123006
replace s1aq3b = 11 if hid == "6411164123006" & s1aq1 == 150
replace s1aq4a = 4 if hid == "6411164123006" & s1aq1 == 150
replace s1aq6a = 4 if hid == "6411164123006" & s1aq1 == 150

//6411164123006
replace s1aq3b = 6 if hid == "6411164123006" & s1aq1 == 153
replace s1aq4a = 15 if hid == "6411164123006" & s1aq1 == 153
replace s1aq6a = 15 if hid == "6411164123006" & s1aq1 == 153
replace s1aq6b = 6 if hid == "6411164123006" & s1aq1 == 153

//6411164123007
replace s1aq3b = 11 if hid == "6411164123007" & s1aq1 == 146
replace s1aq7a = 4 if hid == "6411164123007" & s1aq1 == 146

//6411164123011
replace s1aq3a = 5 if hid == "6411164123011" & s1aq1 == 92
replace s1aq3b = 12 if hid == "6411164123011" & s1aq1 == 92
replace s1aq6a = 5 if hid == "6411164123011" & s1aq1 == 92
replace s1aq6b = 12 if hid == "6411164123011" & s1aq1 == 92

//6411164123013
replace s1aq3a = 3 if hid == "6411164123013" & s1aq1 == 143
replace s1aq3b = 6 if hid == "6411164123013" & s1aq1 == 143
replace s1aq4a = . if hid == "6411164123013" & s1aq1 == 143
replace s1aq4b = . if hid == "6411164123013" & s1aq1 == 143
replace s1aq5 = . if hid == "6411164123013" & s1aq1 == 143
replace s1aq6a = . if hid == "6411164123013" & s1aq1 == 143
replace s1aq6b = . if hid == "6411164123013" & s1aq1 == 143

//6411164123013

replace s1aq3b = 6 if hid == "6411164123013" & s1aq1 == 154
replace s1aq6a = 3 if hid == "6411164123013" & s1aq1 == 154

// 6411464112006
replace s1aq3a = 3 if hid == "6411464112006" & s1aq1 == 152
replace s1aq3b = 7 if hid == "6411464112006" & s1aq1 == 152

//6411464112008
replace s1aq3b = 11 if hid == "6411464112008" & s1aq1 == 146
replace s1aq4a = . if hid == "6411464112008" & s1aq1 == 146
replace s1aq4b = . if hid == "6411464112008" & s1aq1 == 146
replace s1aq6a = . if hid == "6411464112008" & s1aq1 == 146
replace s1aq6b = . if hid == "6411464112008" & s1aq1 == 146

//6411464112011
replace s1aq3a = 1 if hid == "6411464112011" & s1aq1 == 42
replace s1aq3b = 1 if hid == "6411464112011" & s1aq1 == 42
replace s1aq4a = 1 if hid == "6411464112011" & s1aq1 == 42

//6411764109003
replace s1aq3a = 4 if hid == "6411764109003" & s1aq1 == 157
replace s1aq3b = 6 if hid == "6411764109003" & s1aq1 == 157



// 6411764109004
replace s1aq3a = 5 if hid == "6411764109004" & s1aq1 == 164
replace s1aq3b = 6 if hid == "6411764109004" & s1aq1 == 164
replace s1aq4a = 5 if hid == "6411764109004" & s1aq1 == 164
replace s1aq4b = 6 if hid == "6411764109004" & s1aq1 == 164

//6411764109007
replace s1aq3a = 1 if hid == "6411764109007" & s1aq1 == 164
replace s1aq3b = 1 if hid == "6411764109007" & s1aq1 == 164

*** Another common issue - 4 = 6 and 5!=. but 4!=3
gen issue = 1 if s1aq4a == s1aq6a & s1aq6a != s1aq3a & s1aq4b == s1aq6b & s1aq5!=. & s1aq6a!=.

br hid s1aq1 hhsize s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a  s1aq7b s1aq8a s1aq8b tot_consumed settlement_name settlement  lga if issue == 1

//6411864118004
replace s1aq3a = 10 if hid == "6411864118004" & s1aq1 == 164
replace s1aq3b = 11 if hid == "6411864118004" & s1aq1 == 164
replace s1aq4a = 10 if hid == "6411864118004" & s1aq1 == 164
replace s1aq4b = 11 if hid == "6411864118004" & s1aq1 == 164
replace s1aq5 = 140 if hid == "6411864118004" & s1aq1 == 164
replace s1aq6a = 10 if hid == "6411864118004" & s1aq1 == 164
replace s1aq6b = 11 if hid == "6411864118004" & s1aq1 == 164

replace s1aq7a = . if hid == "6411864118004" & s1aq1 == 164
replace s1aq7b = . if hid == "6411864118004" & s1aq1 == 164

replace issue = . if hid == "6411864118004" & s1aq1 == 164

// 6412064125015
replace s1aq3a = 2 if hid == "6412064125015" & s1aq1 == 85
replace s1aq3b = 3 if hid == "6412064125015" & s1aq1 == 85
replace s1aq4a = 2 if hid == "6412064125015" & s1aq1 == 85
replace s1aq4b = 3 if hid == "6412064125015" & s1aq1 == 85
replace s1aq5 = 40 if hid == "6412064125015" & s1aq1 == 85
replace s1aq6a = 2 if hid == "6412064125015" & s1aq1 == 85
replace s1aq6b = 3 if hid == "6412064125015" & s1aq1 == 85

replace s1aq7a = . if hid == "6412064125015" & s1aq1 == 85
replace s1aq7b = . if hid == "6412064125015" & s1aq1 == 85

replace issue = . if hid == "6412064125015" & s1aq1 == 85

//6430364311002

replace s1aq3b = 11 if hid == "6430364311002" & s1aq1 == 149
replace s1aq4a = 4 if hid == "6430364311002" & s1aq1 == 149
replace s1aq6a = 4 if hid == "6430364311002" & s1aq1 == 149

replace issue = . if hid == "6430364311002" & s1aq1 == 149


/// 6430764303014

replace s1aq3a = 1 if hid == "6430764303014" & s1aq1 == 155
replace s1aq3b = 6 if hid == "6430764303014" & s1aq1 == 155
replace s1aq4a = 1 if hid == "6430764303014" & s1aq1 == 155
replace s1aq4b = 6 if hid == "6430764303014" & s1aq1 == 155
replace s1aq5 = 10 if hid == "6430764303014" & s1aq1 == 155
replace s1aq6a = 1 if hid == "6430764303014" & s1aq1 == 155
replace s1aq6b = 6 if hid == "6430764303014" & s1aq1 == 155

replace s1aq7a = . if hid == "6430764303014" & s1aq1 == 155
replace s1aq7b = . if hid == "6430764303014" & s1aq1 == 155

replace issue = . if hid == "6430764303014" & s1aq1 == 155

//7010970112005
replace s1aq3a = 2 if hid == "7010970112005" & s1aq1 == 154
replace s1aq3b = 6 if hid == "7010970112005" & s1aq1 == 154

replace s1aq4a = 2 if hid == "7010970112005" & s1aq1 == 154
replace s1aq4b = 6 if hid == "7010970112005" & s1aq1 == 154

replace s1aq5 = . if hid == "7010970112005" & s1aq1 == 154

replace s1aq6a = 2 if hid == "7010970112005" & s1aq1 == 154
replace s1aq6b = 6 if hid == "7010970112005" & s1aq1 == 154


replace issue = . if hid == "7010970112005" & s1aq1 == 154

//7110271108014
replace s1aq3a = 1 if hid == "7110271108014" & s1aq1 == 63
replace s1aq3b = 1 if hid == "7110271108014" & s1aq1 == 63

replace s1aq4a = 1 if hid == "7110271108014" & s1aq1 == 63
replace s1aq4b = 1 if hid == "7110271108014" & s1aq1 == 63

replace s1aq5 = 50 if hid == "7110271108014" & s1aq1 == 63

replace s1aq6a = 1 if hid == "7110271108014" & s1aq1 == 63
replace s1aq6b = 1 if hid == "7110271108014" & s1aq1 == 63

replace s1aq7a = . if hid == "7110271108014" & s1aq1 == 63
replace s1aq7b = . if hid == "7110271108014" & s1aq1 == 63

replace issue = . if hid == "7110271108014" & s1aq1 == 63

//7210372119016
replace s1aq3b = 6 if hid == "7210372119016" & s1aq1 == 102

replace s1aq4a = 2 if hid == "7210372119016" & s1aq1 == 102

replace s1aq6a = 2 if hid == "7210372119016" & s1aq1 == 102

replace issue = . if hid == "7210372119016" & s1aq1 == 102

//7220472233016

replace s1aq3a = 1 if hid == "7220472233016" & s1aq1 == 63
replace s1aq3b = 1 if hid == "7220472233016" & s1aq1 == 63

replace s1aq4a = 1 if hid == "7220472233016" & s1aq1 == 63

replace s1aq5 = 50 if hid == "7220472233016" & s1aq1 == 63

replace s1aq6a = 1 if hid == "7220472233016" & s1aq1 == 63

replace s1aq7a = . if hid == "7220472233016" & s1aq1 == 63
replace s1aq7b = . if hid == "7220472233016" & s1aq1 == 63

replace issue = . if hid == "7220472233016" & s1aq1 == 63

//7220672220009
replace s1aq3b = 1 if hid == "7220672220009" & s1aq1 == 165

replace s1aq4a = 1 if hid == "7220672220009" & s1aq1 == 165

replace s1aq5 = . if hid == "7220672220009" & s1aq1 == 165

replace s1aq6a = 1 if hid == "7220672220009" & s1aq1 == 165

replace s1aq7a = . if hid == "7220672220009" & s1aq1 == 165
replace s1aq7b = . if hid == "7220672220009" & s1aq1 == 165

replace issue = . if hid == "7220672220009" & s1aq1 == 165

//7220872215010
replace s1aq3a = 2 if hid == "7220872215010" & s1aq1 == 70
replace s1aq3b = 1 if hid == "7220872215010" & s1aq1 == 70

replace s1aq4a = 2 if hid == "7220872215010" & s1aq1 == 70

replace s1aq5 = 120 if hid == "7220872215010" & s1aq1 == 70

replace s1aq6a = 2 if hid == "7220872215010" & s1aq1 == 70

replace s1aq7a = . if hid == "7220872215010" & s1aq1 == 70
replace s1aq7b = . if hid == "7220872215010" & s1aq1 == 70

replace issue = . if hid == "7220872215010" & s1aq1 == 70

//7220972205013
replace s1aq3b = 3 if hid == "7220972205013" & s1aq1 == 85

replace s1aq4a = 7 if hid == "7220972205013" & s1aq1 == 85
replace s1aq4b = 3 if hid == "7220972205013" & s1aq1 == 85

replace s1aq5 = 280 if hid == "7220972205013" & s1aq1 == 85

replace s1aq6a = 7 if hid == "7220972205013" & s1aq1 == 85
replace s1aq6b = 3 if hid == "7220972205013" & s1aq1 == 85

replace issue = . if hid == "7220972205013" & s1aq1 == 85


//7221272210015
replace s1aq3b = 11 if hid == "7221272210015" & s1aq1 == 165

replace s1aq4a = 1 if hid == "7221272210015" & s1aq1 == 165
replace s1aq4b = 11 if hid == "7221272210015" & s1aq1 == 165

replace s1aq5 = 20 if hid == "7221272210015" & s1aq1 == 165

replace s1aq6a = 1 if hid == "7221272210015" & s1aq1 == 165
replace s1aq6b = 11 if hid == "7221272210015" & s1aq1 == 165

replace s1aq7a = . if hid == "7221272210015" & s1aq1 == 165
replace s1aq7b = . if hid == "7221272210015" & s1aq1 == 165

replace issue = . if hid == "7221272210015" & s1aq1 == 165

//7221772227014
replace s1aq3a = 3 if hid == "7221772227014" & s1aq1 == 69
replace s1aq3b = 1 if hid == "7221772227014" & s1aq1 == 69

replace s1aq4a = 3 if hid == "7221772227014" & s1aq1 == 69
replace s1aq4b = 1 if hid == "7221772227014" & s1aq1 == 69

replace s1aq5 = 180 if hid == "7221772227014" & s1aq1 == 69

replace s1aq6a = 3 if hid == "7221772227014" & s1aq1 == 69
replace s1aq6b = 1 if hid == "7221772227014" & s1aq1 == 69

replace s1aq7a = . if hid == "7221772227014" & s1aq1 == 69
replace s1aq7b = . if hid == "7221772227014" & s1aq1 == 69

replace issue = . if hid == "7221772227014" & s1aq1 == 69


//hid
//7222972218005

replace s1aq3b = 11 if hid == "7222972218005" & s1aq1 == 153

replace s1aq4a = 2 if hid == "7222972218005" & s1aq1 == 153

replace s1aq6a = 2 if hid == "7222972218005" & s1aq1 == 153

replace issue = . if hid == "7222972218005" & s1aq1 == 153

//hid
//7222972218010

replace s1aq3b = 1 if hid == "7222972218010" & s1aq1 == 69

replace s1aq4a = 1 if hid == "7222972218010" & s1aq1 == 69

replace s1aq5 = 60 if hid == "7222972218010" & s1aq1 == 69

replace s1aq6a = 1 if hid == "7222972218010" & s1aq1 == 69

replace s1aq7a = . if hid == "7222972218010" & s1aq1 == 69
replace s1aq7b = . if hid == "7222972218010" & s1aq1 == 69

replace issue = . if hid == "7222972218010" & s1aq1 == 69


//hid
//7222972218012

replace s1aq3b = 11 if hid == "7222972218012" & s1aq1 == 156

replace s1aq4a = 1 if hid == "7222972218012" & s1aq1 == 156
replace s1aq4b = 11 if hid == "7222972218012" & s1aq1 == 156

replace s1aq5 = 30 if hid == "7222972218012" & s1aq1 == 156

replace s1aq6a = 1 if hid == "7222972218012" & s1aq1 == 156
replace s1aq6b = 11 if hid == "7222972218012" & s1aq1 == 156

replace s1aq7a = . if hid == "7222972218012" & s1aq1 == 156
replace s1aq7b = . if hid == "7222972218012" & s1aq1 == 156

replace issue = . if hid == "7222972218012" & s1aq1 == 156


//hid
//7310173110012
replace s1aq3a = 6 if hid == "7310173110012" & s1aq1 == 69
replace s1aq3b = 6 if hid == "7310173110012" & s1aq1 == 69

replace s1aq4a = 6 if hid == "7310173110012" & s1aq1 == 69
replace s1aq4b = 6 if hid == "7310173110012" & s1aq1 == 69

replace s1aq5 = 30 if hid == "7310173110012" & s1aq1 == 69

replace s1aq6a = 6 if hid == "7310173110012" & s1aq1 == 69
replace s1aq6b = 6 if hid == "7310173110012" & s1aq1 == 69

replace s1aq7a = . if hid == "7310173110012" & s1aq1 == 69
replace s1aq7b = . if hid == "7310173110012" & s1aq1 == 69

replace issue = . if hid == "7310173110012" & s1aq1 == 69

//hid
//7311873120013

replace s1aq3b = 6 if hid == "7311873120013" & s1aq1 == 69

replace s1aq4a = 10 if hid == "7311873120013" & s1aq1 == 69
replace s1aq4b = 6 if hid == "7311873120013" & s1aq1 == 69


replace s1aq6a = 10 if hid == "7311873120013" & s1aq1 == 69

replace issue = . if hid == "7311873120013" & s1aq1 == 69

//hid
//7311873120014
replace s1aq3b = 6 if hid == "7311873120014" & s1aq1 == 69

replace s1aq4a = 2 if hid == "7311873120014" & s1aq1 == 69

replace s1aq6a = 2 if hid == "7311873120014" & s1aq1 == 69

replace issue = . if hid == "7311873120014" & s1aq1 == 69

//hid
// 7321373205002
replace s1aq3b = 11 if hid == "7321373205002" & s1aq1 == 152

replace s1aq4a = 7 if hid == "7321373205002" & s1aq1 == 152

replace s1aq6a = 7 if hid == "7321373205002" & s1aq1 == 152

replace issue = . if hid == "7321373205002" & s1aq1 == 152


//hid
//7321373205004
replace s1aq3b = 6 if hid == "7321373205004" & s1aq1 == 72

replace s1aq4a = 4 if hid == "7321373205004" & s1aq1 == 72

replace s1aq6a = 4 if hid == "7321373205004" & s1aq1 == 72

replace issue = . if hid == "7321373205004" & s1aq1 == 72

//hid
//6411864118003
replace s1aq3a = 14 if hid == "6411864118003" & s1aq1 == 59
replace s1aq3b = 11 if hid == "6411864118003" & s1aq1 == 59

replace issue = . if hid == "6411864118003" & s1aq1 == 59



/**** Common issues:
1. 3 wrongly entered but 4 and 6 correct.
2. Same value entered for qty and unit for 4 and 6- most cases, the value in unit and use qty from 3
3. qty for 4 and 6 entered as expenditure in 5
*/
gen issue2 = 1 if s1aq4a == s1aq6a & s1aq6a != s1aq3a & s1aq4b == s1aq6b & s1aq5!=. & s1aq6a!=. & s1aq5!=s1aq6a & s1aq5>s1aq6a & s1aq4a!=s1aq4b
br hid s1aq1 hhsize s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a  s1aq7b s1aq8a s1aq8b tot_consumed settlement_name settlement  lga if issue2 == 1

*** some special cases before general fix
//hid
//7410374105014 - sticky 1
replace s1aq3a = 1 if hid == "7410374105014" & s1aq1 == 91
replace s1aq3b = 1 if hid == "7410374105014" & s1aq1 == 91

replace s1aq4b = 1 if hid == "7410374105014" & s1aq1 == 91
replace s1aq6b = 1 if hid == "7410374105014" & s1aq1 == 91

replace issue2 = . if hid == "7410374105014" & s1aq1 == 91

//hid
//7442274402016
replace s1aq3b = 12 if hid == "7442274402016" & s1aq1 == 92

replace s1aq4a = 5 if hid == "7442274402016" & s1aq1 == 92
replace s1aq6a = 5 if hid == "7442274402016" & s1aq1 == 92

replace issue2 = . if hid == "7442274402016" & s1aq1 == 92

//hid
//7510175106121
replace s1aq3b = 1 if hid == "7510175106121" & s1aq1 == 42

replace s1aq4a = 3.5 if hid == "7510175106121" & s1aq1 == 42
replace s1aq6a = 3.5 if hid == "7510175106121" & s1aq1 == 42

replace issue2 = . if hid == "7510175106121" & s1aq1 == 42

//hid
//8020480221003
replace s1aq3a = 15 if hid == "8020480221003" & s1aq1 == 164
replace s1aq3b = 1 if hid == "8020480221003" & s1aq1 == 164

replace s1aq4a = 15 if hid == "8020480221003" & s1aq1 == 164
replace s1aq6a = 15 if hid == "8020480221003" & s1aq1 == 164

replace issue2 = . if hid == "8020480221003" & s1aq1 == 164

//hid
//8110281125016
replace s1aq3b = 11 if hid == "8110281125016" & s1aq1 == 156

replace s1aq4a = 3 if hid == "8110281125016" & s1aq1 == 156
replace s1aq6a = 3 if hid == "8110281125016" & s1aq1 == 156

replace issue2 = . if hid == "8110281125016" & s1aq1 == 156

//hid
//8110281136022

replace s1aq3b = 11 if hid == "8110281136022" & s1aq1 == 146

replace s1aq4a = 4 if hid == "8110281136022" & s1aq1 == 146
replace s1aq6a = 4 if hid == "8110281136022" & s1aq1 == 146

replace issue2 = . if hid == "8110281136022" & s1aq1 == 146

//hid
//8321283221007
replace s1aq3b = 6 if hid == "8321283221007" & s1aq1 == 59

replace s1aq4a = 30 if hid == "8321283221007" & s1aq1 == 59
replace s1aq6a = 30 if hid == "8321283221007" & s1aq1 == 59

replace issue2 = . if hid == "8321283221007" & s1aq1 == 59

//hid
//8410584121003
replace s1aq3b = 6 if hid == "8410584121003" & s1aq1 == 70

replace s1aq4a = 14 if hid == "8410584121003" & s1aq1 == 70
replace s1aq6a = 14 if hid == "8410584121003" & s1aq1 == 70

replace issue2 = . if hid == "8410584121003" & s1aq1 == 70

//hid
//8410684119014
replace s1aq3b = 12 if hid == "8410684119014" & s1aq1 == 92

replace s1aq4a = 3 if hid == "8410684119014" & s1aq1 == 92
replace s1aq6a = 3 if hid == "8410684119014" & s1aq1 == 92

replace issue2 = . if hid == "8410684119014" & s1aq1 == 92

//hid
//8411184117016
replace s1aq3b = 12 if hid == "8411184117016" & s1aq1 == 92

replace s1aq4a = 2 if hid == "8411184117016" & s1aq1 == 92
replace s1aq6a = 2 if hid == "8411184117016" & s1aq1 == 92

replace issue2 = . if hid == "8411184117016" & s1aq1 == 92

//hid
//8510285103002
replace s1aq3b = 11 if hid == "8510285103002" & s1aq1 == 146

replace s1aq4a = 2 if hid == "8510285103002" & s1aq1 == 146
replace s1aq6a = 2 if hid == "8510285103002" & s1aq1 == 146

replace issue2 = . if hid == "8510285103002" & s1aq1 == 146

//hid
//8511285124012
replace s1aq3b = 11 if hid == "8511285124012" & s1aq1 == 165

replace s1aq4a = 2 if hid == "8511285124012" & s1aq1 == 165
replace s1aq6a = 2 if hid == "8511285124012" & s1aq1 == 165

replace issue2 = . if hid == "8511285124012" & s1aq1 == 165

//hid
//8521685202015
replace s1aq3b = 1 if hid == "8521685202015" & s1aq1 == 42

replace s1aq4a = 5 if hid == "8521685202015" & s1aq1 == 42
replace s1aq6a = 5 if hid == "8521685202015" & s1aq1 == 42

replace issue2 = . if hid == "8521685202015" & s1aq1 == 42

//hid
//8610586117011

replace s1aq3b = 12 if hid == "8610586117011" & s1aq1 == 92

replace s1aq4a = 4 if hid == "8610586117011" & s1aq1 == 92
replace s1aq6a = 4 if hid == "8610586117011" & s1aq1 == 92

replace issue2 = . if hid == "8610586117011" & s1aq1 == 92

//hid
//8610686120009
replace s1aq3b = 12 if hid == "8610686120009" & s1aq1 == 92

replace s1aq4a = 2 if hid == "8610686120009" & s1aq1 == 92
replace s1aq6a = 2 if hid == "8610686120009" & s1aq1 == 92

replace issue2 = . if hid == "8610686120009" & s1aq1 == 92

//hid
//8610986122009
replace s1aq3b = 11 if hid == "8610986122009" & s1aq1 == 59

replace s1aq4a = 8 if hid == "8610986122009" & s1aq1 == 59
replace s1aq6a = 8 if hid == "8610986122009" & s1aq1 == 59

replace issue2 = . if hid == "8610986122009" & s1aq1 == 59

//hid
//8421584215001
replace s1aq3b = 11 if hid == "8421584215001" & s1aq1 == 59

replace s1aq4a = 10 if hid == "8421584215001" & s1aq1 == 59
replace s1aq6a = 10 if hid == "8421584215001" & s1aq1 == 59

replace issue2 = . if hid == "8421584215001" & s1aq1 == 59


** General fix can now be applied to remaining issues
replace s1aq3a = s1aq4a if issue2 == 1
replace s1aq3b = s1aq4b if issue2 == 1

drop issue2

***** another issue of quantities/units being entered in 5
gen issue3 = 1 if s1aq4a == s1aq6a & s1aq6a != s1aq3a & s1aq4b == s1aq6b & s1aq5!=. & s1aq6a!=. & s1aq5!=s1aq6a & s1aq5<s1aq6a

br hid s1aq1 hhsize s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a  s1aq7b s1aq8a s1aq8b tot_consumed settlement_name settlement  lga if issue3 == 1

** most of these appear to be units in 5 instead of 4 and 6 
br hid s1aq1 hhsize s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a  s1aq7b s1aq8a s1aq8b tot_consumed settlement_name settlement  lga if issue3 == 1 & (s1aq5 == 6 | s1aq5 == 11)

** special cases before applying general fix
//hid
//6430764305006
replace s1aq3a = 1 if hid == "6430764305006" & s1aq1 == 158
replace s1aq3b = 1 if hid == "6430764305006" & s1aq1 == 158

replace s1aq4a = 1 if hid == "6430764305006" & s1aq1 == 158
replace s1aq6a = 1 if hid == "6430764305006" & s1aq1 == 158

replace s1aq5 = 50 if hid == "6430764305006" & s1aq1 == 158

replace issue3 = . if hid == "6430764305006" & s1aq1 == 158

//hid
//8020480209008
replace s1aq3a = 4 if hid == "8020480209008" & s1aq1 == 164
replace s1aq3b = 22 if hid == "8020480209008" & s1aq1 == 164

replace s1aq4a = 4 if hid == "8020480209008" & s1aq1 == 164
replace s1aq4b = 11 if hid == "8020480209008" & s1aq1 == 164

replace s1aq6a = 4 if hid == "8020480209008" & s1aq1 == 164
replace s1aq6b = 11 if hid == "8020480209008" & s1aq1 == 164

replace s1aq5 = 80 if hid == "8020480209008" & s1aq1 == 164

replace issue3 = . if hid == "8020480209008" & s1aq1 == 164


** general fix - swap 5 in place of 4 and 6
gen issue3_2 = 1 if issue3 == 1 & (s1aq5 == 6 | s1aq5 == 11)

replace s1aq3a = s1aq4b if issue3_2 == 1
replace s1aq3b = s1aq5 if issue3_2 == 1 

replace s1aq5 = s1aq4a if issue3_2 == 1 

replace s1aq4a = s1aq3a if issue3_2 == 1 
replace s1aq4b = s1aq3b if issue3_2 == 1 

replace s1aq6a = s1aq3a if issue3_2 == 1 
replace s1aq6b = s1aq3b if issue3_2 == 1

replace s1aq7a = . if issue3_2 == 1 
replace s1aq7b = . if issue3_2 == 1

drop issue3_2

drop tot_consumed issue
egen tot_consumed = rowtotal( s1aq6a s1aq7a s1aq8a) 


br hid s1aq1 hhsize s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a  s1aq7b s1aq8a s1aq8b tot_consumed settlement_name settlement  lga if issue == 1 & s1aq3a!=tot_consumed & s1aq3a!=.

***special cases:
//8611886107007
replace s1aq3b = s1aq4b if s1aq1 == 48 & hid == "8611886107007"
replace s1aq4a = s1aq3a if s1aq1 == 48 & hid == "8611886107007"
replace s1aq6a = s1aq3a if s1aq1 == 48 & hid == "8611886107007"

replace s1aq5 = . if s1aq1 == 48 & hid == "8611886107007"

replace issue = . if s1aq1 == 48 & hid == "8611886107007"

//8110681104011
replace s1aq3b = s1aq4b if s1aq1 == 143 & hid == "8110681104011"
replace s1aq4a = s1aq3a if s1aq1 == 143 & hid == "8110681104011"
replace s1aq6a = s1aq3a if s1aq1 == 143 & hid == "8110681104011"

replace s1aq5 = 75 if s1aq1 == 143 & hid == "8110681104011"

replace s1aq7a = . if s1aq1 == 143 & hid == "8110681104011"
replace s1aq7b = . if s1aq1 == 143 & hid == "8110681104011"

replace issue = . if s1aq1 == 143 & hid == "8110681104011"

//8020580247012
replace s1aq3b = s1aq4b if s1aq1 == 156 & hid == "8020580247012"
replace s1aq4a = s1aq3a if s1aq1 == 156 & hid == "8020580247012"
replace s1aq6a = s1aq3a if s1aq1 == 156 & hid == "8020580247012"

replace s1aq5 = . if s1aq1 == 156 & hid == "8020580247012"

replace issue = . if s1aq1 == 156 & hid == "8020580247012"

//7410874131006
replace s1aq3b = 6 if s1aq1 == 163 & hid == "7410874131006"
replace s1aq4a = s1aq3a if s1aq1 == 163 & hid == "7410874131006"
replace s1aq4b = 6 if s1aq1 == 163 & hid == "7410874131006"

replace s1aq6a = s1aq3a if s1aq1 == 163 & hid == "7410874131006"
replace s1aq6b = 6 if s1aq1 == 163 & hid == "7410874131006"

replace s1aq5 = . if s1aq1 == 163 & hid == "7410874131006"

replace issue = . if s1aq1 == 163 & hid == "7410874131006"

//7321373205014
replace s1aq3b = s1aq4b if s1aq1 == 158 & hid == "7321373205014"

replace s1aq4a = s1aq3a if s1aq1 == 158 & hid == "7321373205014"
replace s1aq6a = s1aq3a if s1aq1 == 158 & hid == "7321373205014"

replace s1aq5 = 20 if s1aq1 == 158 & hid == "7321373205014"

replace issue = . if s1aq1 == 158 & hid == "7321373205014"

replace s1aq8a =. if hid == "8011980136014" & s1aq1 == 94
replace s1aq8b =. if hid == "8011980136014" & s1aq1 == 94

*** Apply general fix
replace s1aq3b = s1aq4b if issue == 1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq4a = s1aq3a if issue == 1 & s1aq3a!=tot_consumed & s1aq3a!=.
replace s1aq6a = s1aq3a if issue == 1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq5 = 20 if s1aq1 == 158 & hid == "7321373205014"

drop issue

drop tot_consumed
egen tot_consumed = rowtotal( s1aq6a s1aq7a s1aq8a) 


br hid s1aq1 hhsize s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a  s1aq7b s1aq8a s1aq8b tot_consumed settlement_name settlement  lga if s1aq3a!=tot_consumed & s1aq3a!=.

*** new issue - 4 and 5 NOT missing but 6 is missing.

gen issue = 1 if s1aq3a!=. & s1aq3b!=. & s1aq4a!=. & s1aq4b!=. & s1aq5!=. & s1aq6a==. & s1aq6b==. & s1aq3a!=tot_consumed & s1aq3a!=.

tab issue

br hid s1aq1 hhsize s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a  s1aq7b s1aq8a s1aq8b tot_consumed settlement_name settlement  lga if issue == 1

*** special cases
//6411864118007 case of swapped entry
replace s1aq3a = 1 if s1aq1 == 103 & hid == "6411864118007"
replace s1aq3b = 6 if s1aq1 == 103 & hid == "6411864118007"
replace s1aq4a = s1aq3a if s1aq1 == 103 & hid == "6411864118007"
replace s1aq4b = 6 if s1aq1 == 103 & hid == "6411864118007"

replace s1aq6a = s1aq3a if s1aq1 == 103 & hid == "6411864118007"
replace s1aq6b = 6 if s1aq1 == 103 & hid == "6411864118007"

replace s1aq5 = 7 if s1aq1 == 103 & hid == "6411864118007"

replace issue = . if s1aq1 == 103 & hid == "6411864118007"

*** partial fixes before applying general fix- mostly cases of swapped entry
//6430364311009 
replace s1aq4a = s1aq3a if s1aq1 == 153 & hid == "6430364311009"

//6430764302011
replace s1aq5 = s1aq4a if s1aq1 == 152 & hid == "6430764302011"
replace s1aq4a = s1aq3a if s1aq1 == 152 & hid == "6430764302011"

//7321373205004
replace s1aq5 = s1aq4a if s1aq1 == 70 & hid == "7321373205004"
replace s1aq4a = s1aq3a if s1aq1 == 70 & hid == "7321373205004"

//7410374112001
replace s1aq5 = s1aq4a if s1aq1 == 149 & hid == "7410374112001"
replace s1aq4b = 11 if s1aq1 == 149 & hid == "7410374112001"
replace s1aq4a = s1aq3a if s1aq1 == 149 & hid == "7410374112001"

//8011980136007
replace s1aq5 = 20 if s1aq1 == 154 & hid == "8011980136007"

//8110281119012 - condensed milk likely to be tin.
replace s1aq5 = s1aq4a if s1aq1 == 93 & hid == "8110281119012"
replace s1aq4b = 12 if s1aq1 == 93 & hid == "8110281119012"
replace s1aq4a = s1aq3a if s1aq1 == 93 & hid == "8110281119012"

//8210682137007
replace s1aq5 = s1aq4a if s1aq1 == 143 & hid == "8210682137007"
replace s1aq4b = 6 if s1aq1 == 143 & hid == "8210682137007"
replace s1aq4a = s1aq3a if s1aq1 == 143 & hid == "8210682137007"

//8210682137007
replace s1aq5 = s1aq4a if s1aq1 == 158 & hid == "8210682137007"
replace s1aq4b = 11 if s1aq1 == 158 & hid == "8210682137007"
replace s1aq4a = s1aq3a if s1aq1 == 158 & hid == "8210682137007"

//8310283120013
replace s1aq5 = 150 if s1aq1 == 164 & hid == "8310283120013"
replace s1aq4a = s1aq3a if s1aq1 == 164 & hid == "8310283120013"

//8310283120015
replace s1aq5 = . if s1aq1 == 164 & hid == "8310283120015"
replace s1aq4a = s1aq3a if s1aq1 == 164 & hid == "8310283120015"

//8420584223001
replace s1aq5 = 250 if s1aq1 == 164 & hid == "8420584223001"
replace s1aq4a = s1aq3a if s1aq1 == 164 & hid == "8420584223001"

//8420584223003
replace s1aq5 = 500 if s1aq1 == 164 & hid == "8420584223003"
replace s1aq4a = s1aq3a if s1aq1 == 164 & hid == "8420584223003"

//8510185108002
replace s1aq5 = 200 if s1aq1 == 164 & hid == "8510185108002"
replace s1aq4a = s1aq3a if s1aq1 == 164 & hid == "8510185108002"

//8510185119009
replace s1aq5 = 250 if s1aq1 == 164 & hid == "8510185119009"
replace s1aq4a = s1aq3a if s1aq1 == 164 & hid == "8510185119009"

//8520285210004
replace s1aq5 = s1aq4a if s1aq1 == 69 & hid == "8520285210004"
replace s1aq4b = 6 if s1aq1 == 69 & hid == "8520285210004"
replace s1aq4a = s1aq3a if s1aq1 == 69 & hid == "8520285210004"

//8610586109005
replace s1aq4a = s1aq3a if s1aq1 == 68 & hid == "8610586109005"

//8610986122006
replace s1aq3a = 1 if s1aq1 == 91 & hid == "8610986122006"
replace s1aq4a = s1aq3a if s1aq1 == 91 & hid == "8610986122006"

//8620586211007
replace s1aq4a = s1aq3a if s1aq1 == 143 & hid == "8620586211007"

//8011980136007
replace s1aq7a = . if s1aq1 == 154 & hid == "8011980136007"
replace s1aq7b = . if s1aq1 == 154 & hid == "8011980136007"

//7321373205003 - likely to be one bunch/heap instead of 11 no units

replace s1aq3a = 1 if s1aq1 == 149 & hid == "7321373205003"
replace s1aq3b = 11 if s1aq1 == 149 & hid == "7321373205003"
replace s1aq4a = s1aq3a if s1aq1 == 149 & hid == "7321373205003"
replace s1aq4b = 11 if s1aq1 == 149 & hid == "7321373205003"

replace s1aq7a = s1aq3a if s1aq1 == 149 & hid == "7321373205003"
replace s1aq7b = 11 if s1aq1 == 149 & hid == "7321373205003"

replace s1aq5 = . if s1aq1 == 149 & hid == "7321373205003"

replace issue = . if s1aq1 == 149 & hid == "7321373205003"

*** Now apply general fix - replace 3b with 4b and turn 6a and 6b from missing to 4a and 4b respectively so tot_consumed now equals 3a

replace s1aq3b = s1aq4b if issue == 1
replace s1aq6a = s1aq4a if issue == 1
replace s1aq6b = s1aq4b if issue == 1

drop issue

** re-check
drop tot_consumed 
egen tot_consumed = rowtotal( s1aq6a s1aq7a s1aq8a) 


br hid s1aq1 hhsize s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a  s1aq7b s1aq8a s1aq8b tot_consumed settlement_name settlement  lga if s1aq3a!=tot_consumed & s1aq3a!=.


*** another common case - 3a and 3b NOT missing but everything else is missing.

gen issue = 1 if s1aq3a!=. & s1aq3b!=. & s1aq4a==. & s1aq4b==. & s1aq5==. & s1aq6a==. & s1aq6b==. & s1aq3a!=tot_consumed & s1aq3a!=.

br hid s1aq1 hhsize s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a  s1aq7b s1aq8a s1aq8b tot_consumed settlement_name settlement  lga if s1aq3a!=tot_consumed & s1aq3a!=. & issue == 1

***Fixes - 1. if 7a and 7b are !missing, then treat as from own production. Otherwise treat as gifts

***first fix special cases= when 7a == 11, its unit incorrectly entered as quanity
replace s1aq7b = 11 if issue == 1 & s1aq7a == 11
replace s1aq7a = s1aq3a if issue == 1 & s1aq7a == 11

** now apply fix when 7 is not missing
replace s1aq3a = s1aq7a if issue == 1 & s1aq7a!=.
replace s1aq3b = s1aq7b if issue == 1 & s1aq7b !=.

replace s1aq4a = s1aq3a if issue == 1 & s1aq7a!=.
replace s1aq4b = s1aq3b if issue == 1 & s1aq7a!=.

replace issue = . if issue == 1 & s1aq4a!=.

*** keep these as gifts and verify with colleagues BUT first fix issue with gifts
replace s1aq8b = s1aq8a if issue == 1 & (s1aq8a == 11 | s1aq8a == 6)
replace s1aq8a = s1aq3a if issue == 1 & (s1aq8a == 11 | s1aq8a == 6)

replace s1aq3a = s1aq8a if issue == 1 & s1aq8a!=.
replace s1aq3b = s1aq8b if issue == 1 & s1aq8b !=.

replace s1aq4a = s1aq3a if issue == 1 & s1aq8a!=.
replace s1aq4b = s1aq3b if issue == 1 & s1aq8a!=.

replace issue = . if issue == 1 & s1aq4a!=.

** what every is remaining can be considered as gifts

replace s1aq4a = s1aq3a if issue == 1
replace s1aq8a = s1aq3a if issue == 1

replace s1aq4b = s1aq3b if issue == 1
replace s1aq8b = s1aq3b if issue == 1

drop issue

** re-check
drop tot_consumed 
egen tot_consumed = rowtotal( s1aq6a s1aq7a s1aq8a) 


br hid s1aq1 hhsize s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a  s1aq7b s1aq8a s1aq8b tot_consumed settlement_name settlement  lga if s1aq3a!=tot_consumed & s1aq3a!=.

*** common issue discrepancy between 4 and 6. units are correct, but quantity looks off- if qty. in 3 looks more realistic, use that.

gen issue = 1 if s1aq3a!=. & s1aq3b!=. & s1aq4a!=. & s1aq4b!=. & s1aq5!=. & s1aq6a!=. & s1aq6b!=. & s1aq4a!=s1aq6a & s1aq3a!=tot_consumed & s1aq3a!=.

tab issue

br hid s1aq1 hhsize s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a  s1aq7b s1aq8a s1aq8b tot_consumed settlement_name settlement  lga if s1aq3a!=tot_consumed & s1aq3a!=. & issue == 1

***** partial fixes before general fix
//6430764305001
replace s1aq3a = 4 if s1aq1 == 146 & hid == "6430764305001"
replace s1aq4b = 11 if s1aq1 == 146 & hid == "6430764305001"

//6430764305002
replace s1aq5 = 35 if s1aq1 == 70 & hid == "6430764305002"

//6430764305003
replace s1aq3a = 1 if s1aq1 == 152 & hid == "6430764305003"
replace s1aq4b = 11 if s1aq1 == 152 & hid == "6430764305003"
replace s1aq5 = 5 if s1aq1 == 152 & hid == "6430764305003"

//6430764305006
replace s1aq5 = 300 if s1aq1 == 91 & hid == "6430764305006"

//6430764305011
replace s1aq3a = 1 if s1aq1 == 59 & hid == "6430764305011"

//6430764305014
replace s1aq5 = 50 if s1aq1 == 61 & hid == "6430764305014"

//6431564317008
replace s1aq4b = 1 if s1aq1 == 164 & hid == "6431564317008"

//7010370106007
replace s1aq3a = 2 if s1aq1 == 62 & hid == "7010370106007"

//7010870115014
replace s1aq3a = 1 if s1aq1 == 152 & hid == "7010870115014"
replace s1aq4b = 11 if s1aq1 == 152 & hid == "7010870115014"
replace s1aq5 = 5 if s1aq1 == 152 & hid == "7010870115014"

//7010970113001
replace s1aq3a = 1 if s1aq1 == 146 & hid == "7010970113001"

//7010970113014
replace s1aq5 = 25 if s1aq1 == 84 & hid == "7010970113014"

//7011170107007
replace s1aq5 = 20 if s1aq1 == 70 & hid == "7011170107007"

//7011370103003
replace s1aq4b = 1 if s1aq1 == 164 & hid == "7011370103003"

//7011670108012
replace s1aq3a = 1 if s1aq1 == 156 & hid == "7011670108012"

//7111071106015
replace s1aq5 = 105 if s1aq1 == 92 & hid == "7111071106015"

//7112071111013
replace s1aq3a = 2 if s1aq1 == 91 & hid == "7112071111013"
replace s1aq4b = 12 if s1aq1 == 91 & hid == "7112071111013"

//7220872215009
replace s1aq5 = 280 if s1aq1 == 154 & hid == "7220872215009"

//7321373205003
replace s1aq4b = 6 if s1aq1 == 165 & hid == "7321373205003"

//7321573207015
replace s1aq3a = 3 if s1aq1 == 63 & hid == "7321573207015"
replace s1aq4b = 11 if s1aq1 == 63 & hid == "7321573207015"
replace s1aq5 = 450 if s1aq1 == 63 & hid == "7321573207015"

//7322273202013
replace s1aq5 = 20 if s1aq1 == 69 & hid == "7322273202013"

//7410374115001
replace s1aq4b = 6 if s1aq1 == 165 & hid == "7410374115001"

//7411874126013
replace s1aq5 = 10 if s1aq1 == 69 & hid == "7411874126013"

//8020280230012
replace s1aq3a = 1 if s1aq1 == 164 & hid == "8020280230012"
replace s1aq4b = 14 if s1aq1 == 164 & hid == "8020280230012"

//8020480225013
replace s1aq4b = 11 if s1aq1 == 144 & hid == "8020480225013"

//8020680201007
replace s1aq3a = 1 if s1aq1 == 165 & hid == "8020680201007"
replace s1aq4b = 11 if s1aq1 == 165 & hid == "8020680201007"

//8020680201013
replace s1aq5 = 55 if s1aq1 == 70 & hid == "8020680201013"

//8110281127013
replace s1aq4b = 6 if s1aq1 == 143 & hid == "8110281127013"
replace s1aq5 = 40 if s1aq1 == 143 & hid == "8110281127013"

//8110781113001
replace s1aq5 = 300 if s1aq1 == 59 & hid == "8110781113001"

//8111181106006
replace s1aq3a = 2 if s1aq1 == 164 & hid == "8111181106006"
replace s1aq4b = 1 if s1aq1 == 164 & hid == "8111181106006"

//8120681207003
replace s1aq4b = 11 if s1aq1 == 152 & hid == "8120681207003"
replace s1aq5 = 5 if s1aq1 == 152 & hid == "8120681207003"

//8210182128011
replace s1aq4b = 6 if s1aq1 == 70 & hid == "8210182128011"

//8210182128011
replace s1aq3a = 5 if s1aq1 == 70 & hid == "8210182128011"
replace s1aq4b = 6 if s1aq1 == 70 & hid == "8210182128011"
replace s1aq5 = 25 if s1aq1 == 70 & hid == "8210182128011"

//8020680201013
replace s1aq5 = 55 if s1aq1 == 70 & hid == "8020680201013"

//8220782216007
replace s1aq3a = 1 if s1aq1 == 165 & hid == "8220782216007"

//8310283111003
replace s1aq3a = 5 if s1aq1 == 156 & hid == "8310283111003"

//8310283120003
replace s1aq5 = 15 if s1aq1 == 146 & hid == "8310283120003"

//8322383234005
replace s1aq5 = 100 if s1aq1 == 59 & hid == "8322383234005"

//8410784115008
replace s1aq3a = 1 if s1aq1 == 95 & hid == "8410784115008"

//8411084111002
replace s1aq3a = 20 if s1aq1 == 102 & hid == "8411084111002"
replace s1aq4b = 6 if s1aq1 == 102 & hid == "8411084111002"

//8422684226010
replace s1aq3a = 1 if s1aq1 == 165 & hid == "8422684226010"

//8610586109015
replace s1aq3a = 2 if s1aq1 == 164 & hid == "8610586109015"

//8610586113003
replace s1aq5 = 125 if s1aq1 == 74 & hid == "8610586113003"

//8610986122004
replace s1aq3a = 3 if s1aq1 == 59 & hid == "8610986122004"

//8610986122013
replace s1aq3a = 5 if s1aq1 == 69 & hid == "8610986122013"

//8611386125003
replace s1aq3a = 1 if s1aq1 == 156 & hid == "8611386125003"

//8611886107009
replace s1aq3a = 5 if s1aq1 == 145 & hid == "8611886107009"

//8620386216010
replace s1aq5 = 200 if s1aq1 == 59 & hid == "8620386216010"

//8620986231006
replace s1aq3a = 1 if s1aq1 == 164 & hid == "8620986231006"

//8620986231010
replace s1aq3a = 2 if s1aq1 == 164 & hid == "8620986231010"

//8620986231015
replace s1aq3a = 5 if s1aq1 == 69 & hid == "8620986231015"

//8621086206007
replace s1aq3a = 1 if s1aq1 == 157 & hid == "8621086206007"

//8622086232010
replace s1aq4b = 11 if s1aq1 == 68 & hid == "8622086232010"

//7010870115014
replace s1aq3a = 1 if s1aq1 == 152 & hid == "7010870115014"
replace s1aq5 = 10 if s1aq1 == 152 & hid == "7010870115014"

//7010970113014
replace s1aq5 = . if s1aq1 == 84 & hid == "7010970113014"

*** After many lines of fixing special cases- here comes the general fix....
replace s1aq4a = s1aq3a if issue == 1
replace s1aq3b = s1aq4b if issue == 1

replace s1aq6a = s1aq3a if issue == 1
replace s1aq6b = s1aq3b if issue == 1 

replace s1aq7a = . if issue == 1
replace s1aq7b = . if issue == 1 

replace s1aq8a = . if issue == 1
replace s1aq8b = . if issue == 1 


br hid s1aq1 hhsize s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a  s1aq7b s1aq8a s1aq8b tot_consumed settlement_name settlement  lga if issue == 1

drop issue

** re-check
drop tot_consumed 
egen tot_consumed = rowtotal( s1aq6a s1aq7a s1aq8a) 


br hid s1aq1 hhsize s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a  s1aq7b s1aq8a s1aq8b tot_consumed settlement_name settlement  lga if s1aq3a!=tot_consumed & s1aq3a!=.

**** common issue 3, 4 and 5 not missing but 6 is missing.
gen issue = 1 if s1aq3a!=. & s1aq3b!=. & s1aq4a!=. & s1aq4b!=. & s1aq5==. & s1aq6a==. & s1aq6b==. & s1aq3a!=tot_consumed & s1aq3a!=. 

tab issue

br hid s1aq1 hhsize s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a  s1aq7b s1aq8a s1aq8b tot_consumed settlement_name settlement  lga if s1aq3a!=tot_consumed & s1aq3a!=. & issue == 1

** fix: when 7 is not empty, use 7 for 3 and 4.

**** fix special cases
//8520385216016
replace s1aq7a = 7 if s1aq1 == 164 & hid == "8520385216016"
replace s1aq7b = 11 if s1aq1 == 164 & hid == "8520385216016"

//8610686120012
replace s1aq7a = 4 if s1aq1 == 164 & hid == "8610686120012"
replace s1aq7b = 11 if s1aq1 == 164 & hid == "8610686120012"

//8610686120014
replace s1aq7a = 7 if s1aq1 == 152 & hid == "8610686120014"
replace s1aq7b = 11 if s1aq1 == 152 & hid == "8610686120014"

//8611486127016
replace s1aq7a = 5 if s1aq1 == 164 & hid == "8611486127016"
replace s1aq7b = 6 if s1aq1 == 164 & hid == "8611486127016"

*** general fix - use correct 7a and 7b to replace 3a, 3b and 4a and 4b.

replace s1aq3a = s1aq7a if issue == 1 & s1aq7a!=.
replace s1aq3b = s1aq7b if issue == 1 & s1aq7b!=.

replace s1aq4a = s1aq7a if issue == 1 & s1aq7a!=.
replace s1aq4b = s1aq7b if issue == 1 & s1aq7b!=.

replace s1aq8a = . if  issue == 1 & s1aq7a!=.
replace s1aq8b = . if  issue == 1 & s1aq7a!=.

drop issue

** re-check

drop tot_consumed 
egen tot_consumed = rowtotal( s1aq6a s1aq7a s1aq8a) 


br hid s1aq1 hhsize s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a  s1aq7b s1aq8a s1aq8b tot_consumed settlement_name settlement  lga if s1aq3a!=tot_consumed & s1aq3a!=.

**** common issue 3, 4 and 5 not missing but 6 is missing.
gen issue = 1 if s1aq3a!=. & s1aq3b!=. & s1aq4a!=. & s1aq4b!=. & s1aq5==. & s1aq6a==. & s1aq6b==. & s1aq3a!=tot_consumed & s1aq3a!=. 

tab issue

br hid s1aq1 hhsize s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a  s1aq7b s1aq8a s1aq8b tot_consumed settlement_name settlement  lga if s1aq3a!=tot_consumed & s1aq3a!=. & issue == 1

** fix individual cases when entry in 4 seems to be for 5
//6430764302004 200 - 2kg of powered milk
replace s1aq3a = 2 if s1aq1 == 91 & hid == "6430764302004"
replace s1aq3b = 1 if s1aq1 == 91 & hid == "6430764302004"

replace s1aq4a = 2 if s1aq1 == 91 & hid == "6430764302004"

replace s1aq5 = 200 if s1aq1 == 91 & hid == "6430764302004"

replace s1aq6a = 2 if s1aq1 == 91 & hid == "6430764302004"
replace s1aq6b = 1 if s1aq1 == 91 & hid == "6430764302004"

//6431564317009 -- 1250? 25 pieces of smoked fix @ 5 each.
replace s1aq3a = 25 if s1aq1 == 70 & hid == "6431564317009"
replace s1aq3b = 6 if s1aq1 == 70 & hid == "6431564317009"

replace s1aq4a = 25 if s1aq1 == 70 & hid == "6431564317009"
replace s1aq4b = 6 if s1aq1 == 70 & hid == "6431564317009"

replace s1aq5 = 125 if s1aq1 == 70 & hid == "6431564317009"

replace s1aq6a = 25 if s1aq1 == 70 & hid == "6431564317009"
replace s1aq6b = 6 if s1aq1 == 70 & hid == "6431564317009"

//6430764302015 -- 600? 1 bag of of onion
replace s1aq3a = 1 if s1aq1 == 164 & hid == "6430764302015"
replace s1aq3b = 14 if s1aq1 == 164 & hid == "6430764302015"

replace s1aq4a = 1 if s1aq1 == 164 & hid == "6430764302015"
replace s1aq4b = 14 if s1aq1 == 164 & hid == "6430764302015"

replace s1aq5 = 600 if s1aq1 == 164 & hid == "6430764302015"

replace s1aq6a = 1 if s1aq1 == 164 & hid == "6430764302015"
replace s1aq6b = 14 if s1aq1 == 164 & hid == "6430764302015"

//6431564317009 550 onions- likely 1bag.
replace s1aq3a = 1 if s1aq1 == 164 & hid == "6431564317009"
replace s1aq3b = 14 if s1aq1 == 164 & hid == "6431564317009"

replace s1aq4a = 1 if s1aq1 == 164 & hid == "6431564317009"
replace s1aq4b = 14 if s1aq1 == 164 & hid == "6431564317009"

replace s1aq5 = 550 if s1aq1 == 164 & hid == "6431564317009"

replace s1aq6a = 1 if s1aq1 == 164 & hid == "6431564317009"
replace s1aq6b = 14 if s1aq1 == 164 & hid == "6431564317009"

//7111171113009 other fish @ 50 per kg.
replace s1aq3a = 5 if s1aq1 == 68 & hid == "7111171113009"
replace s1aq3b = 1 if s1aq1 == 68 & hid == "7111171113009"

replace s1aq4a = 5 if s1aq1 == 68 & hid == "7111171113009"
replace s1aq4b = 1 if s1aq1 == 68 & hid == "7111171113009"

replace s1aq5 = 250 if s1aq1 == 68 & hid == "7111171113009"

replace s1aq6a = 5 if s1aq1 == 68 & hid == "7111171113009"
replace s1aq6b = 1 if s1aq1 == 68 & hid == "7111171113009"

//8020580242008 25 for pumpkin- likely to be for 5
replace s1aq3a = 1 if s1aq1 == 157 & hid == "8020580242008"
replace s1aq3b = 6 if s1aq1 == 157 & hid == "8020580242008"

replace s1aq4a = 1 if s1aq1 == 157 & hid == "8020580242008"
replace s1aq4b = 6 if s1aq1 == 157 & hid == "8020580242008"

replace s1aq5 = 25 if s1aq1 == 157 & hid == "8020580242008"

replace s1aq6a = 1 if s1aq1 == 157 & hid == "8020580242008"
replace s1aq6b = 6 if s1aq1 == 157 & hid == "8020580242008"

//8410284108014 1000 for bonga- likely to be 100 5 heaps at 20 each
replace s1aq3a = 5 if s1aq1 == 70 & hid == "8410284108014"
replace s1aq3b = 11 if s1aq1 == 70 & hid == "8410284108014"

replace s1aq4a = 5 if s1aq1 == 70 & hid == "8410284108014"
replace s1aq4b = 11 if s1aq1 == 70 & hid == "8410284108014"

replace s1aq5 = 100 if s1aq1 == 70 & hid == "8410284108014"

replace s1aq6a = 5 if s1aq1 == 70 & hid == "8410284108014"
replace s1aq6b = 11 if s1aq1 == 70 & hid == "8410284108014"

//8410284108016 400 on onion- 7 kg 
replace s1aq3a = 7 if s1aq1 == 164 & hid == "8410284108016"
replace s1aq3b = 1 if s1aq1 == 164 & hid == "8410284108016"

replace s1aq4a = 7 if s1aq1 == 164 & hid == "8410284108016"
replace s1aq4b = 1 if s1aq1 == 164 & hid == "8410284108016"

replace s1aq5 = 400 if s1aq1 == 164 & hid == "8410284108016"

replace s1aq6a = 7 if s1aq1 == 164 & hid == "8410284108016"
replace s1aq6b = 1 if s1aq1 == 164 & hid == "8410284108016"

//8410784115003 300? 6kg of onions
replace s1aq3a = 6 if s1aq1 == 164 & hid == "8410784115003"
replace s1aq3b = 1 if s1aq1 == 164 & hid == "8410784115003"

replace s1aq4a = 6 if s1aq1 == 164 & hid == "8410784115003"
replace s1aq4b = 1 if s1aq1 == 164 & hid == "8410784115003"

replace s1aq5 = 300 if s1aq1 == 164 & hid == "8410784115003"

replace s1aq6a = 6 if s1aq1 == 164 & hid == "8410784115003"
replace s1aq6b = 1 if s1aq1 == 164 & hid == "8410784115003"

//8411184117003 500 onion
replace s1aq3a = 1 if s1aq1 == 164 & hid == "8411184117003"
replace s1aq3b = 14 if s1aq1 == 164 & hid == "8411184117003"

replace s1aq4a = 1 if s1aq1 == 164 & hid == "8411184117003"
replace s1aq4b = 14 if s1aq1 == 164 & hid == "8411184117003"

replace s1aq5 = 500 if s1aq1 == 164 & hid == "8411184117003"

replace s1aq6a = 1 if s1aq1 == 164 & hid == "8411184117003"
replace s1aq6b = 14 if s1aq1 == 164 & hid == "8411184117003"

//8411184117004
replace s1aq3a = 1 if s1aq1 == 164 & hid == "8411184117004"
replace s1aq3b = 14 if s1aq1 == 164 & hid == "8411184117004"

replace s1aq4a = 1 if s1aq1 == 164 & hid == "8411184117004"
replace s1aq4b = 14 if s1aq1 == 164 & hid == "8411184117004"

replace s1aq5 = 500 if s1aq1 == 164 & hid == "8411184117004"

replace s1aq6a = 1 if s1aq1 == 164 & hid == "8411184117004"
replace s1aq6b = 14 if s1aq1 == 164 & hid == "8411184117004"

//8520385216008
replace s1aq3a = 1 if s1aq1 == 91 & hid == "8520385216008"
replace s1aq3b = 12 if s1aq1 == 91 & hid == "8520385216008"

replace s1aq4a = 1 if s1aq1 == 91 & hid == "8520385216008"
replace s1aq4b = 12 if s1aq1 == 91 & hid == "8520385216008"

replace s1aq5 = 250 if s1aq1 == 91 & hid == "8520385216008"

replace s1aq6a = 1 if s1aq1 == 91 & hid == "8520385216008"
replace s1aq6b = 12 if s1aq1 == 91 & hid == "8520385216008"

//8610686120006 1500 likely 8 heaps for 160.
replace s1aq3a = 8 if s1aq1 == 70 & hid == "8610686120006"
replace s1aq3b = 11 if s1aq1 == 70 & hid == "8610686120006"

replace s1aq4a = 8 if s1aq1 == 70 & hid == "8610686120006"
replace s1aq4b = 11 if s1aq1 == 70 & hid == "8610686120006"

replace s1aq5 = 160 if s1aq1 == 70 & hid == "8610686120006"

replace s1aq6a = 8 if s1aq1 == 70 & hid == "8610686120006"
replace s1aq6b = 11 if s1aq1 == 70 & hid == "8610686120006"

//8610686120006 1000 on onions 20 - likely 2 bags of onion
replace s1aq3a = 2 if s1aq1 == 164 & hid == "8610686120006"
replace s1aq3b = 14 if s1aq1 == 164 & hid == "8610686120006"

replace s1aq4a = 2 if s1aq1 == 164 & hid == "8610686120006"
replace s1aq4b = 14 if s1aq1 == 164 & hid == "8610686120006"

replace s1aq5 = 1000 if s1aq1 == 164 & hid == "8610686120006"

replace s1aq6a = 2 if s1aq1 == 164 & hid == "8610686120006"
replace s1aq6b = 14 if s1aq1 == 164 & hid == "8610686120006"

//8610686120015 500 on onion - likely to one bag.
replace s1aq3a = 1 if s1aq1 == 164 & hid == "8610686120015"
replace s1aq3b = 14 if s1aq1 == 164 & hid == "8610686120015"

replace s1aq4a = 1 if s1aq1 == 164 & hid == "8610686120015"
replace s1aq4b = 14 if s1aq1 == 164 & hid == "8610686120015"

replace s1aq5 = 500 if s1aq1 == 164 & hid == "8610686120015"

replace s1aq6a = 1 if s1aq1 == 164 & hid == "8610686120015"
replace s1aq6b = 14 if s1aq1 == 164 & hid == "8610686120015"

//8610986122004 dried fish 100? qty = 1 likely to 10 instead
replace s1aq3a = 1 if s1aq1 == 164 & hid == "8610986122004"
replace s1aq3b = 6 if s1aq1 == 164 & hid == "8610986122004"

replace s1aq4a = 1 if s1aq1 == 164 & hid == "8610986122004"
replace s1aq4b = 6 if s1aq1 == 164 & hid == "8610986122004"

replace s1aq5 = 10 if s1aq1 == 164 & hid == "8610986122004"

replace s1aq6a = 1 if s1aq1 == 164 & hid == "8610986122004"
replace s1aq6b = 6 if s1aq1 == 164 & hid == "8610986122004"

//8610986122004
replace s1aq3a = 1 if s1aq1 == 91 & hid == "8610986122004"
replace s1aq3b = 12 if s1aq1 == 91 & hid == "8610986122004"

replace s1aq4a = 1 if s1aq1 == 91 & hid == "8610986122004"
replace s1aq4b = 12 if s1aq1 == 91 & hid == "8610986122004"

replace s1aq5 = 150 if s1aq1 == 91 & hid == "8610986122004"

replace s1aq6a = 1 if s1aq1 == 91 & hid == "8610986122004"
replace s1aq6b = 12 if s1aq1 == 91 & hid == "8610986122004"

//8611186102009 4 and 5 swapped
replace s1aq3a = 1 if s1aq1 == 152 & hid == "8611186102009"
replace s1aq3b = 9 if s1aq1 == 152 & hid == "8611186102009"

replace s1aq4a = 1 if s1aq1 == 152 & hid == "8611186102009"
replace s1aq4b = 9 if s1aq1 == 152 & hid == "8611186102009"

replace s1aq5 = 50 if s1aq1 == 152 & hid == "8611186102009"

replace s1aq6a = 1 if s1aq1 == 152 & hid == "8611186102009"
replace s1aq6b = 9 if s1aq1 == 152 & hid == "8611186102009"

//8611486127006
replace s1aq3a = 4 if s1aq1 == 152 & hid == "8611486127006"
replace s1aq3b = 6 if s1aq1 == 152 & hid == "8611486127006"

replace s1aq4a = 4 if s1aq1 == 152 & hid == "8611486127006"
replace s1aq4b = 6 if s1aq1 == 152 & hid == "8611486127006"

replace s1aq5 = 20 if s1aq1 == 152 & hid == "8611486127006"

replace s1aq6a = 4 if s1aq1 == 152 & hid == "8611486127006"
replace s1aq6b = 6 if s1aq1 == 152 & hid == "8611486127006"

//8620186223012
replace s1aq3a = 1 if s1aq1 == 152 & hid == "8620186223012"
replace s1aq3b = 6 if s1aq1 == 152 & hid == "8620186223012"

replace s1aq4a = 1 if s1aq1 == 152 & hid == "8620186223012"
replace s1aq4b = 6 if s1aq1 == 152 & hid == "8620186223012"

replace s1aq5 = 10 if s1aq1 == 152 & hid == "8620186223012"

replace s1aq6a = 1 if s1aq1 == 152 & hid == "8620186223012"
replace s1aq6b = 6 if s1aq1 == 152 & hid == "8620186223012"

//8620386216014
replace s1aq3a = 2 if s1aq1 == 164 & hid == "8620386216014"
replace s1aq3b = 14 if s1aq1 == 164 & hid == "8620386216014"

replace s1aq4a = 2 if s1aq1 == 164 & hid == "8620386216014"
replace s1aq4b = 14 if s1aq1 == 164 & hid == "8620386216014"

replace s1aq5 = 1000 if s1aq1 == 164 & hid == "8620386216014"

replace s1aq6a = 2 if s1aq1 == 164 & hid == "8620386216014"
replace s1aq6b = 14 if s1aq1 == 164 & hid == "8620386216014"

//8620586211010
replace s1aq3a = 1 if s1aq1 == 164 & hid == "8620586211010"
replace s1aq3b = 14 if s1aq1 == 164 & hid == "8620586211010"

replace s1aq4a = 1 if s1aq1 == 164 & hid == "8620586211010"
replace s1aq4b = 14 if s1aq1 == 164 & hid == "8620586211010"

replace s1aq5 = 450 if s1aq1 == 164 & hid == "8620586211010"

replace s1aq6a = 1 if s1aq1 == 164 & hid == "8620586211010"
replace s1aq6b = 14 if s1aq1 == 164 & hid == "8620586211010"

//8620586211011
replace s1aq3a = 1 if s1aq1 == 164 & hid == "8620586211011"
replace s1aq3b = 14 if s1aq1 == 164 & hid == "8620586211011"

replace s1aq4a = 1 if s1aq1 == 164 & hid == "8620586211011"
replace s1aq4b = 14 if s1aq1 == 164 & hid == "8620586211011"

replace s1aq5 = 500 if s1aq1 == 164 & hid == "8620586211011"

replace s1aq6a = 1 if s1aq1 == 164 & hid == "8620586211011"
replace s1aq6b = 14 if s1aq1 == 164 & hid == "8620586211011"

//8622086232009
replace s1aq3a = 1 if s1aq1 == 164 & hid == "8622086232009"
replace s1aq3b = 14 if s1aq1 == 164 & hid == "8622086232009"

replace s1aq4a = 1 if s1aq1 == 164 & hid == "8622086232009"
replace s1aq4b = 14 if s1aq1 == 164 & hid == "8622086232009"

replace s1aq5 = 300 if s1aq1 == 164 & hid == "8622086232009"

replace s1aq6a = 1 if s1aq1 == 164 & hid == "8622086232009"
replace s1aq6b = 14 if s1aq1 == 164 & hid == "8622086232009"

drop issue

** re-check

drop tot_consumed 
egen tot_consumed = rowtotal( s1aq6a s1aq7a s1aq8a) 


br hid s1aq1 hhsize s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a  s1aq7b s1aq8a s1aq8b tot_consumed settlement_name settlement  lga if s1aq3a!=tot_consumed & s1aq3a!=.

*** focus on ones with 6 and 5!=.
br hid s1aq1 hhsize s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a  s1aq7b s1aq8a s1aq8b tot_consumed settlement_name settlement  lga if s1aq3a!=tot_consumed & s1aq3a!=. & s1aq6a!=. & s1aq6b!=. & s1aq5!=.

***partial fix before general fix-

//6411864118007 - qty and unit mixed up
replace s1aq6a = 1 if s1aq1 == 84 & hid == "6411864118007"
replace s1aq6b = 3 if s1aq1 == 84 & hid == "6411864118007"

//6422364210011
replace s1aq6a = 1 if s1aq1 == 85 & hid == "6422364210011"

//6430364311014
replace s1aq6b = 11 if s1aq1 == 146 & hid == "6430364311014"

//6430764305015
replace s1aq6a = 2 if s1aq1 == 152 & hid == "6430764305015"

//7110371109015
replace s1aq6a = 6 if s1aq1 == 70 & hid == "7110371109015"
replace s1aq6a = 6 if s1aq1 == 70 & hid == "7110371109015"

replace s1aq5 = 10 if s1aq1 == 70 & hid == "7110371109015"

//7111171113006
replace s1aq6a = 5 if s1aq1 == 150 & hid == "7111171113006"

//7210172102012
replace s1aq6a = 7 if s1aq1 == 152 & hid == "7210172102012"

//7210372117014
replace s1aq6b = 6 if s1aq1 == 165 & hid == "7210372117014"

//7210572113007
replace s1aq6b = 1 if s1aq1 == 164 & hid == "7210572113007"
replace s1aq5 = 10 if s1aq1 == 164 & hid == "7210572113007"

//7210572113015
replace s1aq6a = 1 if s1aq1 == 37 & hid == "7210572113015"

//7220472230008
replace s1aq6a = 8 if s1aq1 == 94 & hid == "7220472230008"

//7220572225014
replace s1aq6a = 10 if s1aq1 == 150 & hid == "7220572225014"

//7220972205008
replace s1aq6a = 1 if s1aq1 == 150 & hid == "7220972205008"
replace s1aq6a = 11 if s1aq1 == 150 & hid == "7220972205008"

//7310873128004
replace s1aq6a = 3 if s1aq1 == 154 & hid == "7310873128004"

//7310873128004
replace s1aq6a = 5 if s1aq1 == 155 & hid == "7310873128004"

//7321373205004
replace s1aq6a = 4 if s1aq1 == 156 & hid == "7321373205004"

//7321373205006
replace s1aq6a = 1 if s1aq1 == 165 & hid == "7321373205006"
replace s1aq6b = 1 if s1aq1 == 165 & hid == "7321373205006"

//7321373205015
replace s1aq6a = 2 if s1aq1 == 63 & hid == "7321373205015"

//7330373311016
replace s1aq6a = 4 if s1aq1 == 70 & hid == "7330373311016"

//7331373325016
replace s1aq6a = 5 if s1aq1 == 59 & hid == "7331373325016"

//7410374105013
replace s1aq6a = 1 if s1aq1 == 165 & hid == "7410374105013"

//7410374105014
replace s1aq6a = 2 if s1aq1 == 73 & hid == "7410374105014"

//7420374219010
replace s1aq6a = 14 if s1aq1 == 164 & hid == "7420374219010"

//7510175104090
replace s1aq6a = 3 if s1aq1 == 146 & hid == "7510175104090"

//7510175107168
replace s1aq5 = 100 if s1aq1 == 56 & hid == "7510175107168"

//8010480122006
replace s1aq6a = 1 if s1aq1 == 143 & hid == "8010480122006"

//8010880106001
replace s1aq6a = 4 if s1aq1 == 145 & hid == "8010880106001"

//8013680119009
replace s1aq6a = 1 if s1aq1 == 149 & hid == "8013680119009"

//8020480214009
replace s1aq6a = 2 if s1aq1 == 143 & hid == "8020480214009"

//8020680201001
replace s1aq6b = 11 if s1aq1 == 164 & hid == "8020680201001"

//8110281134007
replace s1aq6a = 1 if s1aq1 == 158 & hid == "8110281134007"

//8110281136006
replace s1aq6a = 5 if s1aq1 == 102 & hid == "8110281136006"

//8110281145016
replace s1aq6b = 12 if s1aq1 == 56 & hid == "8110281145016"

//8110781115015
replace s1aq6b = 6 if s1aq1 == 154 & hid == "8110781115015"

//8211682144015
replace s1aq6a = 5 if s1aq1 == 155 & hid == "8211682144015"

//8212782101008
replace s1aq6b = 6 if s1aq1 == 154 & hid == "8212782101008"

//8220282217016
replace s1aq6b = 5 if s1aq1 == 94 & hid == "8220282217016"

//8310283107016
replace s1aq6a = 1 if s1aq1 == 148 & hid == "8310283107016"
replace s1aq6b = 11 if s1aq1 == 148 & hid == "8310283107016"

//8310983141013
replace s1aq5 =. if s1aq1 ==59 & hid == "8310983141013"

//8311083138002
replace s1aq6a = 3 if s1aq1 == 143 & hid == "8311083138002"

//8420884221010
replace s1aq6a = 1 if s1aq1 == 164 & hid == "8420884221010"
replace s1aq6b = 11 if s1aq1 == 164 & hid == "8420884221010"

//8511285120015
replace s1aq6a = 6 if s1aq1 == 154 & hid == "8511285120015"

//8521585214001
replace s1aq6b = 6 if s1aq1 == 165 & hid == "8521585214001"

//8610986122003
replace s1aq6a = 5 if s1aq1 == 149 & hid == "8610986122003"

//8610986122007
replace s1aq6a = 2 if s1aq1 == 155 & hid == "8610986122007"
replace s1aq6b = 6 if s1aq1 == 155 & hid == "8610986122007"

//8610986122012
replace s1aq6a = 7 if s1aq1 == 164 & hid == "8610986122012"

//8611586104010
replace s1aq6a = 5 if s1aq1 == 143 & hid == "8611586104010"

//8611886107007
replace s1aq5 = . if s1aq1 == 55 & hid == "8611886107007"

//8611886107013
replace s1aq6a = 5 if s1aq1 == 153 & hid == "8611886107013"

//8620286226016
replace s1aq6a = 7 if s1aq1 == 70 & hid == "8620286226016"

//8620986231015
replace s1aq6a = 1 if s1aq1 == 156 & hid == "8620986231015"

//8620986231016
replace s1aq6a = 1 if s1aq1 == 69 & hid == "8620986231016"
replace s1aq6a = 6 if s1aq1 == 69 & hid == "8620986231016"

//8621986204016
replace s1aq5 = . if s1aq1 == 157 & hid == "8621986204016"

//8622086232011
replace s1aq6a = 1 if s1aq1 == 152 & hid == "8622086232011"
replace s1aq5 = 10 if s1aq1 == 152 & hid == "8622086232011"


**** now comes the general fix
replace s1aq3a = s1aq6a if s1aq3a!=tot_consumed & s1aq3a!=. & s1aq6a!=. & s1aq6b!=. & s1aq5!=.

replace s1aq3b = s1aq6b if s1aq3a!=tot_consumed & s1aq3a!=. & s1aq6a!=. & s1aq6b!=. & s1aq5!=.

replace s1aq4a = s1aq6a if s1aq3a!=tot_consumed & s1aq3a!=. & s1aq6a!=. & s1aq6b!=. & s1aq5!=.

replace s1aq4b = s1aq6b if s1aq3a!=tot_consumed & s1aq3a!=. & s1aq6a!=. & s1aq6b!=. & s1aq5!=.

replace s1aq7a = . if s1aq3a!=tot_consumed & s1aq3a!=. & s1aq6a!=. & s1aq6b!=. & s1aq5!=.

replace s1aq7b = . if s1aq3a!=tot_consumed & s1aq3a!=. & s1aq6a!=. & s1aq6b!=. & s1aq5!=.

replace s1aq8a = . if s1aq3a!=tot_consumed & s1aq3a!=. & s1aq6a!=. & s1aq6b!=. & s1aq5!=.

replace s1aq8b = . if s1aq3a!=tot_consumed & s1aq3a!=. & s1aq6a!=. & s1aq6b!=. & s1aq5!=.

*** re-check
drop tot_consumed 
egen tot_consumed = rowtotal( s1aq6a s1aq7a s1aq8a) 

//164 cases left sort by item
sort s1aq1

br hid s1aq1 hhsize s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a  s1aq7b s1aq8a s1aq8b tot_consumed settlement_name settlement  lga if s1aq3a!=tot_consumed & s1aq3a!=.

*** life chicken, life goat, move to own production

replace s1aq3b = 6 if (s1aq1 == 34 | s1aq1 == 37) & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = s1aq3a if (s1aq1 == 34 | s1aq1 == 37) & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7b = 6 if (s1aq1 == 34 | s1aq1 == 37) & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq4a = . if (s1aq1 == 34 | s1aq1 == 37) & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq4b = . if (s1aq1 == 34 | s1aq1 == 37) & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq6a = . if (s1aq1 == 34 | s1aq1 == 37) & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq6b = . if (s1aq1 == 34 | s1aq1 == 37) & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq8a = . if (s1aq1 == 34 | s1aq1 == 37) & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq8b = . if (s1aq1 == 34 | s1aq1 == 37) & s1aq3a!=tot_consumed & s1aq3a!=.

//6430764305014
replace s1aq3b = 1 if s1aq1 == 42 & hid == "6430764305014"

replace s1aq8a = 1 if s1aq1 == 42 & hid == "6430764305014"
replace s1aq8b = 1 if s1aq1 == 42 & hid == "6430764305014"

replace s1aq4a = . if s1aq1 == 42 & hid == "6430764305014"
replace s1aq4b = . if s1aq1 == 42 & hid == "6430764305014"

replace s1aq6a = . if s1aq1 == 42 & hid == "6430764305014"
replace s1aq6b = . if s1aq1 == 42 & hid == "6430764305014"

replace s1aq7a = . if s1aq1 == 42 & hid == "6430764305014"
replace s1aq7b = . if s1aq1 == 42 & hid == "6430764305014"

//6412064125007
replace s1aq3b = 1 if s1aq1 == 42 & hid == "6412064125007"

replace s1aq8a = 5 if s1aq1 == 42 & hid == "6412064125007"
replace s1aq8b = 1 if s1aq1 == 42 & hid == "6412064125007"

replace s1aq4a = . if s1aq1 == 42 & hid == "6412064125007"
replace s1aq4b = . if s1aq1 == 42 & hid == "6412064125007"

replace s1aq6a = . if s1aq1 == 42 & hid == "6412064125007"
replace s1aq6b = . if s1aq1 == 42 & hid == "6412064125007"

replace s1aq7a = . if s1aq1 == 42 & hid == "6412064125007"
replace s1aq7b = . if s1aq1 == 42 & hid == "6412064125007"

//6412064125007
replace s1aq3b = 1 if s1aq1 == 44 & hid == "6412064125007"

replace s1aq8a = s1aq3a if s1aq1 == 44 & hid == "6412064125007"
replace s1aq8b = 1 if s1aq1 == 44 & hid == "6412064125007"

replace s1aq4a = . if s1aq1 == 44 & hid == "6412064125007"
replace s1aq4b = . if s1aq1 == 44 & hid == "6412064125007"

replace s1aq6a = . if s1aq1 == 44 & hid == "6412064125007"
replace s1aq6b = . if s1aq1 == 44 & hid == "6412064125007"

replace s1aq7a = . if s1aq1 == 44 & hid == "6412064125007"
replace s1aq7b = . if s1aq1 == 44 & hid == "6412064125007"


//6412064125003
replace s1aq3b = 1 if s1aq1 == 44 & hid == "6412064125003"

replace s1aq8a = s1aq3a if s1aq1 == 44 & hid == "6412064125003"
replace s1aq8b = 1 if s1aq1 == 44 & hid == "6412064125003"

replace s1aq4a = . if s1aq1 == 44 & hid == "6412064125003"
replace s1aq4b = . if s1aq1 == 44 & hid == "6412064125003"

//6430764305005
replace s1aq3a = 1 if s1aq1 == 45 & hid == "6430764305005"
replace s1aq3b = 6 if s1aq1 == 45 & hid == "6430764305005"

replace s1aq8a = s1aq3a if s1aq1 == 45 & hid == "6430764305005"
replace s1aq8b = 6 if s1aq1 == 45 & hid == "6430764305005"

replace s1aq4a = . if s1aq1 == 45 & hid == "6430764305005"
replace s1aq4b = . if s1aq1 == 45 & hid == "6430764305005"

replace s1aq6a = . if s1aq1 == 45 & hid == "6430764305005"
replace s1aq6b = . if s1aq1 == 45 & hid == "6430764305005"

//8611886107007

replace s1aq3b = 1 if s1aq1 == 48 & hid == "8611886107007"

replace s1aq8a = s1aq3a if s1aq1 == 48 & hid == "8611886107007"
replace s1aq8b = 1 if s1aq1 == 48 & hid == "8611886107007"

replace s1aq4a = . if s1aq1 == 48 & hid == "8611886107007"
replace s1aq4b = . if s1aq1 == 48 & hid == "8611886107007"

replace s1aq7a = . if s1aq1 == 48 & hid == "8611886107007"
replace s1aq7b = . if s1aq1 == 48 & hid == "8611886107007"

replace s1aq6a = . if s1aq1 == 48 & hid == "8611886107007"
replace s1aq6b = . if s1aq1 == 48 & hid == "8611886107007"

** what follows now adopts a partial fix approach by categorizing items into different types of fixes. Fix 3a and b and use that to fix corresponding category

//assign each entry to a category - 6, 7 and 8. when assigned as 6, correct 3 in the codes below; and later replicate in 4 and 6; if category == 7, correct 3, and replicate later in 7 (own production); 

gen category = .

//8611886107007
replace s1aq3a = 2 if s1aq1 == 55 & hid == "8611886107007" 
replace s1aq3b = 12 if s1aq1 == 55 & hid == "8611886107007" 

replace category = 8 if s1aq1 == 55 & hid == "8611886107007" 

//Fresh bonga - unit is likely piece/number. Qty looks okay.

replace s1aq3b = 6 if s1aq1 == 59 & s1aq3a!=tot_consumed & s1aq3a!=. // all 5 entries look like pieces

replace category = 8 if s1aq1 == 59 & s1aq3a!=tot_consumed & s1aq3a!=.

//Tilapia- Qty looks okay, but no unit
replace s1aq3b = 6 if s1aq1 == 63 & s1aq3a!=tot_consumed & s1aq3a!=. // all 4 entries look like pieces

replace category = 8 if s1aq1 == 63 & s1aq3a!=tot_consumed & s1aq3a!=.



** except one entry which says bunch/heap
replace s1aq3b = 11 if s1aq1 == 63 & hid == "6431564317001"

//6412064125003
replace s1aq3b = 6 if s1aq1 == 68 & hid == "6412064125003"

replace category = 6 if s1aq1 == 68 & hid == "6412064125003"

//dried fish - Qty looks okay but units are no units; and some with enteries for 5 not realistic

replace s1aq3b = 6 if s1aq1 == 69 & s1aq3a!=tot_consumed & s1aq3a!=. 

replace category = 8 if s1aq1 == 69 & s1aq3a!=tot_consumed & s1aq3a!=.

*** Smoked fish
replace s1aq3b = 6 if s1aq1 == 70 & s1aq3a!=tot_consumed & s1aq3a!=. 

replace category = 8 if s1aq1 == 70 & s1aq3a!=tot_consumed & s1aq3a!=.

** but few special cases:
replace s1aq5 = 20 if s1aq1 == 70 & hid == "8611486127006"

replace category = 6 if s1aq1 == 70 & hid == "8611486127006"

//8620186223012
replace s1aq5 = 100 if s1aq1 == 70 & hid == "8620186223012"

replace category = 6 if s1aq1 == 70 & hid == "8620186223012"

//Dried couta
//6421864213013
replace s1aq3b = 6 if s1aq1 == 72 & hid == "6421864213013"

replace s1aq5 = 30 if s1aq1 == 72 & hid == "6421864213013"

replace category = 6 if s1aq1 == 72 & hid == "6421864213013"

// 7310173107006 sardine
replace s1aq3a = 3 if s1aq1 == 74 & hid == "7310173107006"

replace s1aq3b = 12 if s1aq1 == 74 & hid == "7310173107006"

replace s1aq5 = . if s1aq1 == 74 & hid == "7310173107006"

replace category = 6 if s1aq1 == 74 & hid == "7310173107006"

//Fresh milk
replace s1aq3b = 3 if (s1aq1 == 84 | s1aq1 == 85) & s1aq3a!=tot_consumed & s1aq3a!=. 

replace category = 7 if (s1aq1 == 84 | s1aq1 == 85) & s1aq3a!=tot_consumed & s1aq3a!=.

//Powered milk
//8320583241010
replace s1aq3a = 14 if s1aq1 == 91 & hid == "8320583241010"

replace s1aq3b = 5 if s1aq1 == 91 & hid == "8320583241010"

replace category = 8 if s1aq1 == 91 & hid == "8320583241010"


//8410784114011
replace s1aq3a = 1 if s1aq1 == 91 & hid == "8410784114011"

replace s1aq3b = 12 if s1aq1 == 91 & hid == "8410784114011"

replace category = 6 if s1aq1 == 91 & hid == "8410784114011"

//8510185119005
replace s1aq3b = 5 if s1aq1 == 91 & hid == "8510185119005"

replace category = 8 if s1aq1 == 91 & hid == "8510185119005"

//6420364203012
replace s1aq3a = 1 if s1aq1 == 91 & hid == "6420364203012"

replace s1aq3b = 12 if s1aq1 == 91 & hid == "6420364203012"

replace category = 6 if s1aq1 == 91 & hid == "6420364203012"

**** Eggs
//8611486127001
replace s1aq3a = 4 if s1aq1 == 102 & hid == "8611486127001"

replace s1aq3b = 6 if s1aq1 == 102 & hid == "8611486127001"

replace category = 6 if s1aq1 == 102 & hid == "8611486127001"

//8410784114011
replace s1aq3a = 20 if s1aq1 == 102 & hid == "8410784114011"

replace s1aq3b = 6 if s1aq1 == 102 & hid == "8410784114011"

replace category = 6 if s1aq1 == 102 & hid == "8410784114011"


// Cabbage
replace s1aq3b = 6 if s1aq1 == 143 & s1aq3a!=tot_consumed & s1aq3a!=. 

replace category = 6 if s1aq1 == 143 & s1aq3a!=tot_consumed & s1aq3a!=. 

//8220382236007
replace s1aq3b = 11 if s1aq1 == 144 & hid == "8220382236007"

replace category = 7 if s1aq1 == 144 & hid == "8220382236007"

//6431064308006
replace s1aq3b = 6 if s1aq1 == 145 & hid == "6431064308006"

replace category = 7 if s1aq1 == 145 & hid == "6431064308006"

//Sorrel
// 8620386216011
replace s1aq3a = 9 if s1aq1 == 146 & hid == "8620386216011"

** all other entries
replace s1aq3b = 11 if s1aq1 == 146 & s1aq3a!=tot_consumed & s1aq3a!=. 

replace category = 7 if s1aq1 == 146 & s1aq3a!=tot_consumed & s1aq3a!=.

/// Onion leaves and potato leaves
replace s1aq3b = 11 if (s1aq1 == 149 | s1aq1 == 150) & s1aq3a!=tot_consumed & s1aq3a!=. 

replace category = 7 if (s1aq1 == 149 | s1aq1 == 150) & s1aq3a!=tot_consumed & s1aq3a!=.

**** Small peper
// when 5 is not empty, treat as a purchase
replace s1aq3b = 8 if s1aq1 == 152 & s1aq3a!=tot_consumed & s1aq3a!=. & s1aq5!=.

replace category = 6 if s1aq1 == 152 & s1aq3a!=tot_consumed & s1aq3a!=. & s1aq5!=.

// when 5 is empty treat as own production
replace s1aq3b = 11 if s1aq1 == 152 & s1aq3a!=tot_consumed & s1aq3a!=. & s1aq5==.

replace category = 7 if s1aq1 == 152 & s1aq3a!=tot_consumed & s1aq3a!=. & s1aq5==.

//Tomato fresh
replace s1aq3b = 11 if s1aq1 == 153 & s1aq3a!=tot_consumed & s1aq3a!=.

replace category = 6 if s1aq1 == 153 & s1aq3a!=tot_consumed & s1aq3a!=.

// Garden eggs - 8211682144003
replace s1aq3b = 6 if s1aq1 == 155 & hid == "8211682144003"

replace category = 7 if s1aq1 == 155 & hid == "8211682144003"

//Okra
replace s1aq3b = 11 if s1aq1 == 156 & s1aq3a!=tot_consumed & s1aq3a!=.

replace category = 7 if s1aq1 == 156 & s1aq3a!=tot_consumed & s1aq3a!=.

//Bitter tomato
//6412064125003
replace s1aq3b = 6 if s1aq1 == 154 & hid == "6412064125003"

replace category = 6 if s1aq1 == 154 & hid == "6412064125003"

//6430264313016
replace s1aq3b = 6 if s1aq1 == 154 & hid == "6430264313016"

replace category = 6 if s1aq1 == 154 & hid == "6430264313016"

//8410184106011
replace s1aq3b = 11 if s1aq1 == 154 & hid == "8410184106011"

replace category = 7 if s1aq1 == 154 & hid == "8410184106011"

//6430764305005
replace s1aq3b = 6 if s1aq1 == 154 & hid == "6430764305005"

replace category = 6 if s1aq1 == 154 & hid == "6430764305005"

//8611286124004
replace s1aq3b = 6 if s1aq1 == 154 & hid == "8611286124004"

replace category = 6 if s1aq1 == 154 & hid == "8611286124004"


//Pumpkin
// when 5 is not empty, treat as a purchase
replace s1aq3b = 6 if s1aq1 == 157 & s1aq3a!=tot_consumed & s1aq3a!=. & s1aq5!=.

replace category = 6 if s1aq1 == 157 & s1aq3a!=tot_consumed & s1aq3a!=. & s1aq5!=.

// when 5 is empty treat as own production
replace s1aq3b = 6 if s1aq1 == 157 & s1aq3a!=tot_consumed & s1aq3a!=. & s1aq5==.

replace category = 7 if s1aq1 == 157 & s1aq3a!=tot_consumed & s1aq3a!=. & s1aq5==.

// big red pepper
// when 5 is not empty, treat as a purchase
replace s1aq3b = 11 if s1aq1 == 158 & s1aq3a!=tot_consumed & s1aq3a!=. & s1aq5!=.

replace category = 6 if s1aq1 == 158 & s1aq3a!=tot_consumed & s1aq3a!=. & s1aq5!=.

// when 5 is empty treat as own production
replace s1aq3b = 11 if s1aq1 == 158 & s1aq3a!=tot_consumed & s1aq3a!=. & s1aq5==.

replace category = 7 if s1aq1 == 158 & s1aq3a!=tot_consumed & s1aq3a!=. & s1aq5==.


***** Onion
*** when 7 is not empty treat as own production
replace s1aq3b = s1aq7b if s1aq1 == 164 & s1aq3a!=tot_consumed & s1aq3a!=. & s1aq7b!=.

replace category = 7 if s1aq1 == 164 & s1aq3a!=tot_consumed & s1aq3a!=. & s1aq7b!=.

*** other cases treat individually
//8410184106008
replace s1aq3b = 1 if s1aq1 == 164 & hid == "8410184106008"

replace category = 6 if s1aq1 == 164 & hid == "8410184106008"

//6412064125006
replace s1aq3a = 0.5 if s1aq1 == 164 & hid == "6412064125006"
replace s1aq3b = 14 if s1aq1 == 164 & hid == "6412064125006"

replace category = 6 if s1aq1 == 164 & hid == "6412064125006"

//6411864118016
replace s1aq3b = 1 if s1aq1 == 164 & hid == "6411864118016"

replace category = 6 if s1aq1 == 164 & hid == "6411864118016"

//For expenses from 450 to 600 likely to be a full bag.

replace s1aq3a = 1 if s1aq1 == 164 & s1aq3a!=tot_consumed & s1aq3a!=. & s1aq5!=. & inrange(s1aq5, 449, 600)

replace s1aq3b = 14 if s1aq1 == 164 & s1aq3a!=tot_consumed & s1aq3a!=. & s1aq5!=. & inrange(s1aq5, 449, 600)

replace category = 6 if s1aq1 == 164 & s1aq3a!=tot_consumed & s1aq3a!=. & s1aq5!=. & inrange(s1aq5, 449, 600)

// If 4b is not missing, use unit in 4b

replace s1aq3b = s1aq4b if s1aq1 == 164 & s1aq3a!=tot_consumed & s1aq3a!=. & s1aq5==. & s1aq4b!=. & category == .

replace category = 6 if s1aq1 == 164 & s1aq3a!=tot_consumed & s1aq3a!=. & s1aq5!=. & s1aq4b!=. & category == .

//8621386228006

replace s1aq5 = 20 if s1aq1 == 164 & hid == "8621386228006"

** remaining ones are bunch/heap
replace s1aq3b = 11 if s1aq1 == 164 & s1aq3a!=tot_consumed & s1aq3a!=.  & category == .

replace category = 6 if s1aq1 == 164 & s1aq3a!=tot_consumed & s1aq3a!=.  & category == .

*** Garlic
//8411084111002

replace s1aq3a = 4 if s1aq1 == 165 & hid == "8411084111002"

replace s1aq3b = 6 if s1aq1 == 165 & s1aq3a!=tot_consumed & s1aq3a!=.

replace category = 6 if s1aq1 == 165 & s1aq3a!=tot_consumed & s1aq3a!=. 


**** Now comes the fix:
** purchases
replace s1aq4a = s1aq3a if category == 6
replace s1aq4b = s1aq3b if category == 6

replace s1aq6a = s1aq3a if category == 6
replace s1aq6b = s1aq3b if category == 6

replace s1aq7a = . if category == 6
replace s1aq7b = . if category == 6

replace s1aq8a = . if category == 6
replace s1aq8b = . if category == 6

*** own production
replace s1aq7a = s1aq3a if category == 7
replace s1aq7b = s1aq3b if category == 7

replace s1aq4a = . if category == 7
replace s1aq4b = . if category == 7

replace s1aq6a = . if category == 7
replace s1aq6b = . if category == 7

replace s1aq8a = . if category == 7
replace s1aq8b = . if category == 7

** gifts
replace s1aq8a = s1aq3a if category == 8
replace s1aq8b = s1aq3b if category == 8

replace s1aq4a = . if category == 8
replace s1aq4b = . if category == 8

replace s1aq6a = . if category == 8
replace s1aq6b = . if category == 8

replace s1aq7a = . if category == 8
replace s1aq7b = . if category == 8

drop category

*** re-check
drop tot_consumed 
egen tot_consumed = rowtotal(s1aq6a s1aq7a s1aq8a) 

br hid s1aq1 hhsize s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a  s1aq7b s1aq8a s1aq8b tot_consumed settlement_name settlement  lga if s1aq3a!=tot_consumed & s1aq3a!=.


** one major correction to my fixes - when own production (7) or gift (8), total purchases (4) should be empty

replace s1aq4a = . if s1aq4a!=. & (s1aq7a!=. | s1aq8a!=.)
replace s1aq4b = . if s1aq4b!=. & (s1aq7a!=. | s1aq8a!=.)


*** checks:
sum tot_consumed
count if tot_consumed==98 //12 enteries without any qty or unit - i.e  qty = 98
count if tot_consumed==0

br hid s1aq1 hhsize s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a  s1aq7b s1aq8a s1aq8b tot_consumed settlement_name settlement  lga if tot_consumed == 98

tempfile sering
save `sering'
/*=========================================================================

*** common issue - 3 and 5 are NOT missing, but 4, 6 etc. are missing.

gen issue = 1 if s1aq3a!=. & s1aq3b!=. & s1aq4a==. & s1aq4b==. & s1aq5!=. & s1aq6a==. & s1aq6b==. & s1aq3a!=tot_consumed & s1aq3a!=. 

tab issue

br hid s1aq1 hhsize s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a  s1aq7b s1aq8a s1aq8b tot_consumed settlement_name settlement  lga if s1aq3a!=tot_consumed & s1aq3a!=. & issue == 1
*/


/*==============================================================================
ADD code from other colleagues

*/
*************************************
********** Janneh:
*************************************
use revised_task_distribution_dta_file.dta, clear

keep if responsible == 1

**** CODE
sort s1aq1

br


************************ Life chicken (local breed) *************************

************************ Life chicken (local breed) ****************************

////3130231348013
br hid-s1aq8b  if hid =="3130231348013" & s1aq1==37
recode s1aq4a (2=.) if hid =="3130231348013"  & s1aq1==37
recode s1aq4b (5=.) if hid =="3130231348013"  & s1aq1==37
recode s1aq7b (5=6) if hid =="3130231348013"  & s1aq1==37
recode s1aq8a (2=.) if hid =="3130231348013"  & s1aq1==37
recode s1aq8b (2=.) if hid =="3130231348013"  & s1aq1==37


////3030130341008
br hid-s1aq8b  if hid =="3030130341008" & s1aq1==37
recode s1aq3a (1=2) if hid =="3030130341008"  & s1aq1==37
recode s1aq4a (2=1.) if hid =="3030130341008"  & s1aq1==37
recode s1aq6a (2=1) if hid =="3030130341008"  & s1aq1==37


////3110331110009
br hid-s1aq8b  if hid =="3110331110009" & s1aq1==37
recode s1aq8a (1=6) if hid =="3110331110009"  & s1aq1==40

******************** Beef with bones********************************************
////2010120101008
br hid-s1aq8b  if hid =="2010120101008" & s1aq1==42
recode s1aq3a (2=5) if hid =="2010120101008"  & s1aq1==42


////3081830829001
br hid-s1aq8b  if hid =="3081830829001" & s1aq1==42
recode s1aq8a (3=.) if hid =="3081830829001"  & s1aq1==42
recode s1aq8b (1=.) if hid =="3081830829001"  & s1aq1==42



////2340123436014
br hid-s1aq8b  if hid =="2340123436014" & s1aq1==42
recode s1aq8a (1=.) if hid =="2340123436014"  & s1aq1==42
recode s1aq8b (1=.) if hid =="2340123436014"  & s1aq1==42


////1110111112002
br hid-s1aq8b  if hid =="1110111112002" & s1aq1==42
recode s1aq3a (1=2) if hid =="1110111112002"  & s1aq1==42
recode s1aq4a (1=2) if hid =="1110111112002"  & s1aq1==42


////3211032132005
br hid-s1aq8b  if hid =="3211032132005" & s1aq1==42
recode s1aq6a (.5=1) if hid =="3211032132005"  & s1aq1==42


////3133931341001
br hid-s1aq8b  if hid =="3133931341001" & s1aq1==42
recode s1aq7a (1=2) if hid =="3133931341001"  & s1aq1==42


////3144131452011
br hid-s1aq8b  if hid =="3144131452011" & s1aq1==42
recode s1aq8a (1=.) if hid =="3144131452011"  & s1aq1==42
recode s1aq8b (1=.) if hid =="3144131452011"  & s1aq1==42


////3311033102002
br hid-s1aq8b  if hid =="3311033102002" & s1aq1==42
recode s1aq4a (195=1.5) if hid =="3311033102002"  & s1aq1==42
recode s1aq6a (195=1.5) if hid =="3311033102002"  & s1aq1==42


////2330123323002
br hid-s1aq8b  if hid =="2330123323002" & s1aq1==42
recode s1aq6a (1=2) if hid =="2330123323002"  & s1aq1==42


////3230232347012
br hid-s1aq8b  if hid =="3230232347012" & s1aq1==42
recode s1aq3a (2=1) if hid =="3230232347012"  & s1aq1==42
recode s1aq4a (2=1) if hid =="3230232347012"  & s1aq1==42


////3121031225014
br hid-s1aq8b  if hid =="3121031225014" & s1aq1==42
recode s1aq3a (1=2) if hid =="3121031225014"  & s1aq1==42


////1110111112014
br hid-s1aq8b  if hid =="1110111112014" & s1aq1==42
recode s1aq3a (2=1) if hid =="1110111112014"  & s1aq1==42
recode s1aq4a (2=1) if hid =="1110111112014"  & s1aq1==42
recode s1aq6a (.=1) if hid =="1110111112014"  & s1aq1==42


////1220112208003
br hid-s1aq8b  if hid =="1220112208003" & s1aq1==42
recode s1aq7a (1=.) if hid =="1220112208003"  & s1aq1==42
recode s1aq7b (0=.) if hid =="1220112208003"  & s1aq1==42
recode s1aq8a (1=.) if hid =="1220112208003"  & s1aq1==42
recode s1aq8b (0=.) if hid =="1220112208003"  & s1aq1==42


////1110111106011
br hid-s1aq8b  if hid =="1110111106011" & s1aq1==42
recode s1aq4a (2=1) if hid =="1110111106011"  & s1aq1==42
recode s1aq6a (2=1) if hid =="1110111106011"  & s1aq1==42


////1020110208015
br hid-s1aq8b  if hid =="1020110208015" & s1aq1==42
recode s1aq3a (1=2) if hid =="1020110208015"  & s1aq1==42


////3050330565003
br hid-s1aq8b  if hid =="3050330565003" & s1aq1==42
recode s1aq3a (11=1) if hid =="3050330565003"  & s1aq1==42


////1220112208006
br hid-s1aq8b  if hid =="1220112208006" & s1aq1==42
recode s1aq3a (6=10) if hid =="1220112208006"  & s1aq1==42


***************************Sheep************************************************
////1220112208005
br hid-s1aq8b  if hid =="1220112208005" & s1aq1==43
recode s1aq8a (.=7) if hid =="1220112208005"  & s1aq1==43    // I assumbr the whole 7 kg of mutton was from gifts and other sources
recode s1aq8b (.=1) if hid =="1220112208005"  & s1aq1==43


////1110111106009
br hid-s1aq8b  if hid =="1110111106009" & s1aq1==43
recode s1aq4b (0=.) if hid =="1110111106009"  & s1aq1==43
recode s1aq8a (.=2) if hid =="1110111106009"  & s1aq1==43
recode s1aq8b (.=1) if hid =="1110111106009"  & s1aq1==43




************************Chicken Leg (Imported)**********************************
////2120121223007
br hid-s1aq8b  if hid =="2120121223007" & s1aq1==44
recode s1aq3a (3=4) if hid =="2120121223007"  & s1aq1==44


////2130121308004
br hid-s1aq8b  if hid =="2130121308004" & s1aq1==44
recode s1aq8a (.=3) if hid =="2130121308004"  & s1aq1==44
recode s1aq8b (.=1) if hid =="2130121308004"  & s1aq1==44


////3240932442015
br hid-s1aq8b  if hid =="3240932442015" & s1aq1==44
recode s1aq6a (3=4) if hid =="3240932442015"  & s1aq1==44



////3060130659001
br hid-s1aq8b  if hid =="3060130659001" & s1aq1==44
recode s1aq6a (.=1) if hid =="3060130659001"  & s1aq1==44
recode s1aq6b (.=1) if hid =="3060130659001"  & s1aq1==44


////2010120117003
br hid-s1aq8b  if hid =="2010120117003" & s1aq1==44
recode s1aq8a (.=3) if hid =="2010120117003"  & s1aq1==44
recode s1aq8b (.=1) if hid =="2010120117003"  & s1aq1==44


////2010120101008
br hid-s1aq8b  if hid =="2010120101008" & s1aq1==44    // I am not sure about how this one should be corrected


////1110111106011
br hid-s1aq8b  if hid =="1110111106011" & s1aq1==44
recode s1aq6a (1=2) if hid =="1110111106011"  & s1aq1==44


////3133931341011
br hid-s1aq8b  if hid =="3133931341011" & s1aq1==44
recode s1aq3a (2=6) if hid =="3133931341011"  & s1aq1==44
recode s1aq4a (2=6) if hid =="3133931341011"  & s1aq1==44


////3030130341002
br hid-s1aq8b  if hid =="3030130341002" & s1aq1==44
recode s1aq8a (.=12) if hid =="3030130341002"  & s1aq1==44
recode s1aq8b (.=1) if hid =="3030130341002"  & s1aq1==44


////3240432429010
br hid-s1aq8b  if hid =="3240432429010" & s1aq1==44
recode s1aq6a (2=3) if hid =="3240432429010"  & s1aq1==44


////1020110208015
br hid-s1aq8b  if hid =="1020110208015" & s1aq1==44
recode s1aq6a (21=2) if hid =="1020110208015"  & s1aq1==44
recode s1aq6b (2=1) if hid =="1020110208015"  & s1aq1==44
recode s1aq8a (1=.) if hid =="1020110208015"  & s1aq1==44
recode s1aq8b (0=.) if hid =="1020110208015"  & s1aq1==44


////1110111112016
br hid-s1aq8b  if hid =="1110111112016" & s1aq1==44
recode s1aq6a (.=.5) if hid =="1110111112016"  & s1aq1==44
recode s1aq6b (.=1) if hid =="1110111112016"  & s1aq1==44


////3080730851004
br hid-s1aq8b  if hid =="3080730851004" & s1aq1==44
recode s1aq6b (10=1) if hid =="3080730851004"  & s1aq1==44
recode s1aq8a (10=.) if hid =="3080730851004"  & s1aq1==44
recode s1aq8b (0=.) if hid =="3080730851004"  & s1aq1==44


////3143531402004
br hid-s1aq8b  if hid =="3143531402004" & s1aq1==44
recode s1aq3a (75=1) if hid =="3143531402004"  & s1aq1==44


////3040130443015
br hid-s1aq8b  if hid =="3040130443015" & s1aq1==44
recode s1aq4a (150=2) if hid =="3040130443015"  & s1aq1==44
recode s1aq4b (2=1) if hid =="3040130443015"  & s1aq1==44
recode s1aq5 (1=150) if hid =="3040130443015"  & s1aq1==44
recode s1aq6a (.=2) if hid =="3040130443015"  & s1aq1==44
recode s1aq6b (.=1) if hid =="3040130443015"  & s1aq1==44


////2020120213004
br hid-s1aq8b  if hid =="2020120213004" & s1aq1==44
recode s1aq6a (1=2) if hid =="2020120213004"  & s1aq1==44


////1220112205007
br hid-s1aq8b  if hid =="1220112205007" & s1aq1==44   // I am not sure about this one


////3080730851001
br hid-s1aq8b  if hid =="3080730851001" & s1aq1==44 
recode s1aq3a (11=1) if hid =="3080730851001"  & s1aq1==44
recode s1aq4a (11=1) if hid =="3080730851001"  & s1aq1==44
recode s1aq6b (11=1.) if hid =="3080730851001"  & s1aq1==44


////3020630210013
br hid-s1aq8b  if hid =="3020630210013" & s1aq1==44 
recode s1aq8a (.=6) if hid =="3020630210013"  & s1aq1==44
recode s1aq8b (.=1) if hid =="3020630210013"  & s1aq1==44


////1210112104002
br hid-s1aq8b  if hid =="1210112104002" & s1aq1==44 
recode s1aq8a (.=5) if hid =="1210112104002"  & s1aq1==44
recode s1aq8b (.=1) if hid =="1210112104002"  & s1aq1==44


////1020110205003
br hid-s1aq8b  if hid =="1020110205003" & s1aq1==44 
recode s1aq8a (.=6) if hid =="1020110205003"  & s1aq1==44
recode s1aq8b (.=1) if hid =="1020110205003"  & s1aq1==44


////3230132368003
br hid-s1aq8b  if hid =="3230132368003" & s1aq1==44 
recode s1aq8a (2=.) if hid =="3230132368003"  & s1aq1==44
recode s1aq8b (2=.) if hid =="3230132368003"  & s1aq1==44


////3320633228012
br hid-s1aq8b  if hid =="3320633228012" & s1aq1==44 
recode s1aq6a (.=2) if hid =="3320633228012"  & s1aq1==44
recode s1aq6b (.=1) if hid =="3320633228012"  & s1aq1==44


////3030330362010
br hid-s1aq8b  if hid =="3030330362010" & s1aq1==44 
recode s1aq8a (.=3) if hid =="3030330362010"  & s1aq1==44
recode s1aq8b (.=1) if hid =="3030330362010"  & s1aq1==44


////1120111202009
br hid-s1aq8b  if hid =="1120111202009" & s1aq1==44 
recode s1aq8a (.=2) if hid =="1120111202009"  & s1aq1==44
recode s1aq8b (.=1) if hid =="1120111202009"  & s1aq1==44


////3210932108016
br hid-s1aq8b  if hid =="3210932108016" & s1aq1==44 
recode s1aq6a (.=1) if hid =="3210932108016"  & s1aq1==44
recode s1aq6b (.=1) if hid =="3210932108016"  & s1aq1==44


////1220112208015
br hid-s1aq8b  if hid =="1220112208015" & s1aq1==44 
recode s1aq8a (.=4) if hid =="1220112208015"  & s1aq1==44
recode s1aq8b (.=1) if hid =="1220112208015"  & s1aq1==44


////2130121308002
br hid-s1aq8b  if hid =="2130121308002" & s1aq1==44 
recode s1aq8a (.=6) if hid =="2130121308002"  & s1aq1==44
recode s1aq8b (.=1) if hid =="2130121308002"  & s1aq1==44


////3210632121012
br hid-s1aq8b  if hid =="3210632121012" & s1aq1==44 
recode s1aq8a (8=.) if hid =="3210632121012"  & s1aq1==44
recode s1aq8b (0=.) if hid =="3210632121012"  & s1aq1==44


////3010430108011
br hid-s1aq8b  if hid =="3010430108011" & s1aq1==44
recode s1aq4a (5=.5) if hid =="3010430108011"  & s1aq1==44
recode s1aq6a (5=.5) if hid =="3010430108011"  & s1aq1==44


////3030130302001
br hid-s1aq8b  if hid =="3030130302001" & s1aq1==44
recode s1aq8a (.=10) if hid =="3030130302001"  & s1aq1==44
recode s1aq8b (.=1) if hid =="3030130302001"  & s1aq1==44



****************************Chicken(local)**************************************
////3020230225012
br hid-s1aq8b  if hid =="3020230225012" & s1aq1==45
recode s1aq3a (2=1) if hid =="3020230225012"  & s1aq1==45
recode s1aq6a (21=1.) if hid =="3020230225012"  & s1aq1==45


////3210932108007
br hid-s1aq8b  if hid =="3210932108007" & s1aq1==45
recode s1aq4a (1=.) if hid =="3210932108007"  & s1aq1==45
recode s1aq4b (6=.) if hid =="3210932108007"  & s1aq1==45
recode s1aq8a (6=1) if hid =="3210932108007"  & s1aq1==45


////3030530383007
br hid-s1aq8b  if hid =="3030530383007" & s1aq1==45
recode s1aq4a (6=.) if hid =="3030530383007"  & s1aq1==45
recode s1aq4b (6=.) if hid =="3030530383007"  & s1aq1==45
recode s1aq6a (6=.) if hid =="3030530383007"  & s1aq1==45
recode s1aq6b (6=.) if hid =="3030530383007"  & s1aq1==45


////3330133313005
br hid-s1aq8b  if hid =="3330133313005" & s1aq1==45
recode s1aq4a (0=.) if hid =="3330133313005"  & s1aq1==45
recode s1aq4b (6=.) if hid =="3330133313005"  & s1aq1==45
recode s1aq6a (6=.) if hid =="3330133313005"  & s1aq1==45
recode s1aq6b (0=.) if hid =="3330133313005"  & s1aq1==45


////3130231348009
br hid-s1aq8b  if hid =="3130231348009" & s1aq1==45
recode s1aq8a (6=1) if hid =="3130231348009"  & s1aq1==45


////3330133313013
br hid-s1aq8b  if hid =="3330133313013" & s1aq1==45
recode s1aq4a (0=.) if hid =="3330133313013"  & s1aq1==45
recode s1aq4b (6=.) if hid =="3330133313013"  & s1aq1==45
recode s1aq6a (6=.) if hid =="3330133313013"  & s1aq1==45
recode s1aq6b (0=.) if hid =="3330133313013"  & s1aq1==45


****************************Beef without bones**********************************
////3210932108004
br hid-s1aq8b  if hid =="3210932108004" & s1aq1==49
recode s1aq5 (100=200) if hid =="3210932108004"  & s1aq1==49
recode s1aq6a (.=1) if hid =="3210932108004"  & s1aq1==49
recode s1aq6b (.=1) if hid =="3210932108004"  & s1aq1==49
recode s1aq1 (49=42) if hid =="3210932108004"  & s1aq1==49

////3133931332013
br hid-s1aq8b  if hid =="3133931332013" & s1aq1==49
recode s1aq3a (2=3) if hid =="3133931332013"  & s1aq1==49


////2010120101008
br hid-s1aq8b  if hid =="2010120101008" & s1aq1==49
recode s1aq3a (2=5) if hid =="2010120101008"  & s1aq1==49


*****************************Chicken whole,frozen*******************************
////3330233324015
br hid-s1aq8b  if hid =="3330233324015" & s1aq1==50
recode s1aq4a (2=.) if hid =="3330233324015"  & s1aq1==50
recode s1aq4b (6=.) if hid =="3330233324015"  & s1aq1==50
recode s1aq5 (2=.) if hid =="3330233324015"  & s1aq1==50
recode s1aq6a (2=.) if hid =="3330233324015"  & s1aq1==50
recode s1aq6b (6=.) if hid =="3330233324015"  & s1aq1==50
recode s1aq7a (2=.) if hid =="3330233324015"  & s1aq1==50
recode s1aq7b (6=.) if hid =="3330233324015"  & s1aq1==50


////3020230225008
br hid-s1aq8b  if hid =="3020230225008" & s1aq1==50
recode s1aq6a (4=5) if hid =="3020230225008"  & s1aq1==50



////2410124101006
br hid-s1aq8b  if hid =="2410124101006" & s1aq1==50
recode s1aq6a (.=2) if hid =="2410124101006"  & s1aq1==50
recode s1aq6b (.=6) if hid =="2410124101006"  & s1aq1==50


////2130121308003
br hid-s1aq8b  if hid =="2130121308003" & s1aq1==50
recode s1aq8a (.=3) if hid =="2130121308003"  & s1aq1==50
recode s1aq8b (.=6) if hid =="2130121308003"  & s1aq1==50


**********Other Meat, fresh, chilled or frozen Please Specify*******************

////1120111204001
br hid-s1aq8b  if hid =="1120111204001" & s1aq1==51
recode s1aq6a (2=3) if hid =="1120111204001"  & s1aq1==51



drop tot_consumed

egen tot_consumed = rowtotal( s1aq6a s1aq7a s1aq8a)

 

br hid s1aq1 hhsize s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a  s1aq7b s1aq8a s1aq8b tot_consumed settlement_name settlement  lga if s1aq3a!=tot_consumed & s1aq3a!=.

 

gen issue = .

//3144131452004

replace s1aq3a = 0.5 if s1aq1 == 44 & hid == "3144131452004"

replace s1aq3b = s1aq4b if s1aq1 == 44 & hid == "3144131452004"

 

replace issue = 6 if s1aq1 == 44 & hid == "3144131452004"

 

//2010120101008

replace s1aq3a = 1 if s1aq1 == 44 & hid == "2010120101008"

replace s1aq3b = 5 if s1aq1 == 44 & hid == "2010120101008"

 

replace issue = 6 if s1aq1 == 44 & hid == "2010120101008"

 

//1220112205007

replace s1aq3a = 1 if s1aq1 == 44 & hid == "1220112205007"

replace s1aq3b = 1 if s1aq1 == 44 & hid == "1220112205007"

 

replace issue = 6 if s1aq1 == 44 & hid == "1220112205007"

 

//3020230225012

replace s1aq3a = 1 if s1aq1 == 55 & hid == "3020230225012"

replace s1aq3b = 12 if s1aq1 == 55 & hid == "3020230225012"

 

replace issue = 6 if s1aq1 == 44 & hid == "1220112205007"

 

//Corned beef - all should be tins

replace s1aq3b = 12 if s1aq1 == 56 & s1aq3a!=tot_consumed & s1aq3a!=. 

 

replace issue = 6 if s1aq1 == 56 & s1aq3a!=tot_consumed & s1aq3a!=.

 

//issues with quantity

replace s1aq3a = 1 if s1aq1 == 56 & hid == "3230232347013"

replace s1aq3a = 1 if s1aq1 == 56 & hid == "1130111303001"

 

** Sausages

replace s1aq3b = 5 if s1aq1 == 57 & s1aq3a!=tot_consumed & s1aq3a!=. 

 

replace issue = 6 if s1aq1 == 57 & s1aq3a!=tot_consumed & s1aq3a!=.


 

 //issues with quantity

replace s1aq3a = 3 if s1aq1 == 57 & hid == "3040130423015"

 

** general fix:

replace s1aq4a = s1aq3a if issue == 6

replace s1aq4b = s1aq3b if issue == 6

 

replace s1aq6a = s1aq3a if issue == 6

replace s1aq6b = s1aq3b if issue == 6

 

replace s1aq7a = . if issue == 6

replace s1aq7b = . if issue == 6

 

replace s1aq8a = . if issue == 6

replace s1aq8b = . if issue == 6

 

drop issue

 

********* Fresh bonga

//Mostly unit in 4 is okay; and most entries are purchases - i.e belong to 6. There fix a few special/individual cases and then apply general fix:

 

replace s1aq4a = 5 if s1aq1 == 59 & hid == "3143531411012"

 

replace s1aq4a = 6 if s1aq1 == 59 & hid == "3134331356015"

 

replace s1aq4a = 4 if s1aq1 == 59 & hid == "3110331130013"

 

replace s1aq4a = 5 if s1aq1 == 59 & hid == "3020230247009"

replace s1aq4b = 6 if s1aq1 == 59 & hid == "3020230247009"

 

replace s1aq4a = 7 if s1aq1 == 59 & hid == "3120531214003"

replace s1aq4b = 6 if s1aq1 == 59 & hid == "3120531214003"

 

replace s1aq4a = 1 if s1aq1 == 59 & hid == "3081730807010"

replace s1aq4b = 11 if s1aq1 == 59 & hid == "3081730807010"

 

replace s1aq5 = 20 if s1aq1 == 59 & hid == "3081730807010"

 

 

replace s1aq4a = 4 if s1aq1 == 59 & hid == "3321433206010"

replace s1aq4b = 11 if s1aq1 == 59 & hid == "3321433206010"

 

replace s1aq5 = 100 if s1aq1 == 59 & hid == "3321433206010"

 

 

replace s1aq4a = 1 if s1aq1 == 59 & hid == "3143531421006"

replace s1aq4b = 1 if s1aq1 == 59 & hid == "3143531421006"

 

replace s1aq5 = 35 if s1aq1 == 59 & hid == "3143531421006"

 

replace s1aq4a = 15 if s1aq1 == 59 & hid == "3320333211012"

 

*** apply general fix for fresh bonga

replace s1aq3a = s1aq4a if s1aq1 == 59 & s1aq3a!=tot_consumed & s1aq3a!=.

 

replace s1aq3b = s1aq4b if s1aq1 == 59 & s1aq3a!=tot_consumed & s1aq3a!=.

 

replace s1aq6a = s1aq4a if s1aq1 == 59 & s1aq3a!=tot_consumed & s1aq3a!=.

 

replace s1aq6b = s1aq4b if s1aq1 == 59 & s1aq3a!=tot_consumed & s1aq3a!=.

 

**** Cat fish

 

replace s1aq4a = 2 if s1aq1 == 60 & hid == "3321433206011"

 

//2410124101013

replace s1aq4a = 4 if s1aq1 == 60 & hid == "2410124101013"

replace s1aq4b = 6 if s1aq1 == 60 & hid == "2410124101013"

 

replace s1aq5 = 100 if s1aq1 == 60 & hid == "2410124101013"

 

**** general fix

replace s1aq3a = s1aq4a if s1aq4a!=. & s1aq1 == 60 & s1aq3a!=tot_consumed & s1aq3a!=.

 

replace s1aq3b = s1aq4b if s1aq4b!=. & s1aq1 == 60 & s1aq3a!=tot_consumed & s1aq3a!=.

 

replace s1aq6a = s1aq4a if s1aq4a!=. & s1aq1 == 60 & s1aq3a!=tot_consumed & s1aq3a!=.

 

replace s1aq6b = s1aq4b if s1aq4a!=. & s1aq1 == 60 & s1aq3a!=tot_consumed & s1aq3a!=.

 

replace s1aq7a = . if s1aq4a!=. & s1aq1 == 60 & s1aq3a!=tot_consumed & s1aq3a!=.

 

replace s1aq7b = . if s1aq4a!=. & s1aq1 == 60 & s1aq3a!=tot_consumed & s1aq3a!=.

 

replace s1aq8a = . if s1aq4a!=. & s1aq1 == 60 & s1aq3a!=tot_consumed & s1aq3a!=.

 

replace s1aq8b = . if s1aq4a!=. & s1aq1 == 60 & s1aq3a!=tot_consumed & s1aq3a!=.

 

*** when 4a and 4b are missing, treat as gift

replace s1aq3b = 6 if s1aq3a!=. & s1aq4a == . & s1aq1 == 60 & s1aq3a!=tot_consumed & s1aq3a!=.

 

replace s1aq8a = s1aq3a if s1aq3a!=. & s1aq4a == . & s1aq1 == 60 & s1aq3a!=tot_consumed & s1aq3a!=.

 

replace s1aq8b = s1aq3b if s1aq3a!=. & s1aq4a == . & s1aq1 == 60 & s1aq3a!=tot_consumed & s1aq3a!=.

*************************Fresh Grouper/Lady Fish********************************
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 61 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if s1aq1  == 61 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq8a = s1aq3a if issue == 1
replace s1aq3b = 11 if issue == 1
replace s1aq8b = 11 if issue == 1

drop issue 




br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 61 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 2 if s1aq1  == 61 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = . if issue == 2
replace s1aq8a = . if issue == 2

replace s1aq7b = . if issue == 2
replace s1aq8b = . if issue == 2

replace s1aq6a = s1aq4a if issue == 2

replace s1aq3b = 11 if issue == 2
replace s1aq4b = 11 if issue == 2
replace s1aq6b = 11 if issue == 2


replace s1aq3a =1 if hid =="3143531402013"  & s1aq1==61
replace s1aq4a =1 if hid =="3143531402013"  & s1aq1==61
replace s1aq6a =1 if hid =="3143531402013"  & s1aq1==61


replace s1aq3a =1 if hid =="3060130659001"  & s1aq1==61

replace s1aq4a =1 if hid =="3110331130012"  & s1aq1==61
replace s1aq6a =1 if hid =="3110331130012"  & s1aq1==61


replace s1aq3a =1 if hid =="3311033102003"  & s1aq1==61
replace s1aq4a =1 if hid =="3311033102003"  & s1aq1==61
replace s1aq6a =1 if hid =="3311033102003"  & s1aq1==61


replace s1aq3a =1 if hid =="3143531402012"  & s1aq1==61
replace s1aq4a =1 if hid =="3143531402012"  & s1aq1==61
replace s1aq6a =1 if hid =="3143531402012"  & s1aq1==61

drop issue

replace s1aq6a =3 if hid =="3321433202004"  & s1aq1==61
replace s1aq6b =11 if hid =="3321433202004"  & s1aq1==61
replace s1aq3b =11 if hid =="3321433202004"  & s1aq1==61
replace s1aq4b =11 if hid =="3321433202004"  & s1aq1==61

//2010120101008
replace s1aq3a =6 if hid =="2010120101008"  & s1aq1==61


*********************************Fresh Baracuda*********************************
//2410124122006
replace s1aq8a = s1aq3a if hid =="2410124122006"  & s1aq1==62
replace s1aq3b =11 if hid =="2410124122006"  & s1aq1==62
replace s1aq8b =11 if hid =="2410124122006"  & s1aq1==62

//3080730851001
replace s1aq6a = s1aq4a if hid =="3080730851001"  & s1aq1==62
replace s1aq6b =11 if hid =="3080730851001"  & s1aq1==62
replace s1aq3b =11 if hid =="3080730851001"  & s1aq1==62
replace s1aq8a =. if hid =="3080730851001"  & s1aq1==62
replace s1aq8b =. if hid =="3080730851001"  & s1aq1==62

//3020230225008
replace s1aq6a = s1aq4a if hid =="3020230225008"  & s1aq1==62
replace s1aq3b =11 if hid =="3020230225008"  & s1aq1==62


//1220112208007
replace s1aq8a = s1aq3a if hid =="1220112208007"  & s1aq1==62
replace s1aq8b = 11 if hid =="1220112208007"  & s1aq1==62
replace s1aq3b = 11 if hid =="1220112208007"  & s1aq1==62


//3030130341002
replace s1aq8a = s1aq3a if hid =="3030130341002"  & s1aq1==62
replace s1aq8b = 11 if hid =="3030130341002"  & s1aq1==62
replace s1aq3b = 11 if hid =="3030130341002"  & s1aq1==62


//1220112208006
replace s1aq8a = s1aq3a if hid =="1220112208006"  & s1aq1==62
replace s1aq8b = 11 if hid =="1220112208006"  & s1aq1==62
replace s1aq3b = 11 if hid =="1220112208006"  & s1aq1==62


//3143531411001
replace s1aq6a = s1aq4a if hid =="3143531411001"  & s1aq1==62
replace s1aq6b = 11 if hid =="3143531411001"  & s1aq1==62
replace s1aq3b = 11 if hid =="3143531411001"  & s1aq1==62


**************************************Tilapia***********************************
//2010120117003
replace s1aq8a = s1aq3a if hid =="2010120117003"  & s1aq1==63
replace s1aq8b = 11 if hid =="2010120117003"  & s1aq1==63
replace s1aq3b = 11 if hid =="2010120117003"  & s1aq1==63


//3230832337005
replace s1aq6a = s1aq4a if hid =="3230832337005"  & s1aq1==63
replace s1aq3b = 11 if hid =="3230832337005"  & s1aq1==63


//3222632243009
replace s1aq6a = s1aq4a if hid =="3222632243009"  & s1aq1==63
replace s1aq6b = 11 if hid =="3222632243009"  & s1aq1==63
replace s1aq3b = 11 if hid =="3222632243009"  & s1aq1==63


//2020120213006
replace s1aq3a = 4 if hid =="2020120213006"  & s1aq1==63
replace s1aq3b = 6 if hid =="2020120213006"  & s1aq1==63

//2320123228016
replace s1aq3b = 11 if hid =="2320123228016"  & s1aq1==63
replace s1aq6b = 11 if hid =="2320123228016"  & s1aq1==63
replace s1aq7a = . if hid =="2320123228016"  & s1aq1==63
replace s1aq7b = . if hid =="2320123228016"  & s1aq1==63


********************************Red Snapper*************************************

br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 64 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if s1aq1  == 64 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq8a = s1aq3a if issue == 1
replace s1aq3b = 11 if issue == 1
replace s1aq8b = 11 if issue == 1

drop issue


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 64 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 64 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.


//3133931341013
replace s1aq3b = 11 if hid =="3133931341013"  & s1aq1==64
replace s1aq6b = 11 if hid =="3133931341013"  & s1aq1==64
replace s1aq6a = 1 if hid =="3133931341013"  & s1aq1==64


//3040130466009
replace s1aq3a = 2 if hid =="3040130466009"  & s1aq1==64
replace s1aq3b = 11 if hid =="3040130466009"  & s1aq1==64

//2010120101008
replace s1aq3a = 5 if hid =="2010120101008"  & s1aq1==64


//2110321101016
replace s1aq3a = 2 if hid =="2110321101016"  & s1aq1==64
replace s1aq3b = 11 if hid =="2110321101016"  & s1aq1==64


//3241032479003
replace s1aq6a = 2 if hid =="3241032479003"  & s1aq1==64
replace s1aq6b = 11 if hid =="3241032479003"  & s1aq1==64
replace s1aq3b = 11 if hid =="3241032479003"  & s1aq1==64


//3060530617009
replace s1aq3a = 4 if hid =="3060530617009"  & s1aq1==64
replace s1aq3b = 6 if hid =="3241032479003"  & s1aq1==64


//3241032479003
replace s1aq3b = 11 if hid =="3241032479003"  & s1aq1==64
replace s1aq6a = 2 if hid =="3241032479003"  & s1aq1==64


//3240832455009
replace s1aq3b = 11 if hid =="3240832455009"  & s1aq1==64
replace s1aq6a = 1 if hid =="3240832455009"  & s1aq1==64
replace s1aq6b = 11 if hid =="3240832455009"  & s1aq1==64


//3230232357009
replace s1aq3a = 4 if hid =="3230232357009"  & s1aq1==64
replace s1aq3b = 6 if hid =="3230232357009"  & s1aq1==64


//3080730874007
replace s1aq3a = 6 if hid =="3080730874007"  & s1aq1==64
replace s1aq3b = 6 if hid =="3080730874007"  & s1aq1==64

//1110111109004
replace s1aq3a = 2 if hid =="1110111109004"  & s1aq1==64
replace s1aq3b = 11 if hid =="1110111109004"  & s1aq1==64

//2210122118009
replace s1aq6a = 6 if hid =="2210122118009"  & s1aq1==64
replace s1aq6b = 6 if hid =="2210122118009"  & s1aq1==64
replace s1aq3b = 6 if hid =="2210122118009"  & s1aq1==64


*********************************Fresh small sardine****************************

//2110321101009
replace s1aq3b = 6 if hid =="2110321101009"  & s1aq1==65
replace s1aq8a = s1aq3a if hid =="2110321101009"  & s1aq1==65
replace s1aq8b = 6 if hid =="2110321101009"  & s1aq1==65


//3110331130012
replace s1aq3a = s1aq4a if hid =="3110331130012"  & s1aq1==65
replace s1aq3b = s1aq4b if hid =="3110331130012"  & s1aq1==65


//3230832337007
replace s1aq3a = s1aq4a if hid =="3230832337007"  & s1aq1==65
replace s1aq3b = s1aq4b if hid =="3230832337007"  & s1aq1==65


******************************Carptain Fish*************************************

//3130231348008
replace s1aq3b = 11 if hid =="3130231348008"  & s1aq1==66
replace s1aq8a = s1aq3a if hid =="3130231348008"  & s1aq1==66
replace s1aq8b = 11 if hid =="3130231348008"  & s1aq1==66


//3040130423004
replace s1aq3b = 11 if hid =="3040130423004"  & s1aq1==66
replace s1aq6a = s1aq3a if hid =="3040130423004"  & s1aq1==66
replace s1aq6b = 11 if hid =="3040130423004"  & s1aq1==66
replace s1aq7a = . if hid =="3040130423004"  & s1aq1==66
replace s1aq7b = . if hid =="3040130423004"  & s1aq1==66
replace s1aq8a = . if hid =="3040130423004"  & s1aq1==66
replace s1aq8b = . if hid =="3040130423004"  & s1aq1==66


//2410124122006
replace s1aq3b = 11 if hid =="2410124122006"  & s1aq1==66
replace s1aq8a = s1aq3a if hid =="2410124122006"  & s1aq1==66
replace s1aq8b = 11 if hid =="2410124122006"  & s1aq1==66


***************************Fresh Mackerel Fish**********************************

//1220112208007
replace s1aq3b = 11 if hid =="1220112208007"  & s1aq1==67
replace s1aq8a = s1aq3a if hid =="1220112208007"  & s1aq1==67
replace s1aq8b = 11 if hid =="1220112208007"  & s1aq1==67


//3080730851006
replace s1aq3b = 11 if hid =="3080730851006"  & s1aq1==67
replace s1aq6a = s1aq4a if hid =="3080730851006"  & s1aq1==67
replace s1aq6b = 11 if hid =="3080730851006"  & s1aq1==67

******************************Dried Fish****************************************

//1220112208006
replace s1aq3b = 6 if hid =="1220112208006"  & s1aq1==69
replace s1aq8a = s1aq3a if hid =="1220112208006"  & s1aq1==69
replace s1aq8b = 6 if hid =="1220112208006"  & s1aq1==69


//2410124101006
replace s1aq3b = 6 if hid =="2410124101006"  & s1aq1==69
replace s1aq6a = s1aq4a if hid =="2410124101006"  & s1aq1==69
replace s1aq6b = 6 if hid =="2410124101006"  & s1aq1==69


//1120111210003
replace s1aq3b = 6 if hid =="1120111210003"  & s1aq1==69
replace s1aq6b = 6 if hid =="1120111210003"  & s1aq1==69
replace s1aq7a = . if hid =="1120111210003"  & s1aq1==69
replace s1aq7b = . if hid =="1120111210003"  & s1aq1==69
replace s1aq8a = . if hid =="1120111210003"  & s1aq1==69
replace s1aq8b = . if hid =="1120111210003"  & s1aq1==69


//3222432230009
replace s1aq3a = 2 if hid =="3222432230009"  & s1aq1==69
replace s1aq3b = 11 if hid =="3222432230009"  & s1aq1==69


//3111131102003
replace s1aq3b = 6 if hid =="3111131102003"  & s1aq1==69
replace s1aq6a = 2 if hid =="3111131102003"  & s1aq1==69


//1020110208012
replace s1aq3b = 6 if hid =="1020110208012"  & s1aq1==69
replace s1aq7a = . if hid =="1020110208012"  & s1aq1==69
replace s1aq7b = . if hid =="1020110208012"  & s1aq1==69
replace s1aq8a = . if hid =="1020110208012"  & s1aq1==69
replace s1aq8b = . if hid =="1020110208012"  & s1aq1==69

//3050230524003
replace s1aq3b = 11 if hid =="3050230524003"  & s1aq1==69
replace s1aq4a = s1aq3a if hid =="3050230524003"  & s1aq1==69
replace s1aq4b = 11 if hid =="3050230524003"  & s1aq1==69
replace s1aq5 = 10 if hid =="3050230524003"  & s1aq1==69
replace s1aq6a = s1aq3a if hid =="3050230524003"  & s1aq1==69
replace s1aq6b = 11 if hid =="3050230524003"  & s1aq1==69
replace s1aq7a = . if hid =="3050230524003"  & s1aq1==69
replace s1aq7b = . if hid =="3050230524003"  & s1aq1==69


//3222632243005
replace s1aq3b = 6 if hid =="3222632243005"  & s1aq1==69
replace s1aq6a = 4 if hid =="3222632243005"  & s1aq1==69
replace s1aq6b = 6 if hid =="3222632243005"  & s1aq1==69


//2330123323010
replace s1aq3b = 6 if hid =="2330123323010"  & s1aq1==69
replace s1aq4a = . if hid =="2330123323010"  & s1aq1==69
replace s1aq4b = . if hid =="2330123323010"  & s1aq1==69
replace s1aq8a = s1aq3a if hid =="2330123323010"  & s1aq1==69
replace s1aq8b = 6 if hid =="2330123323010"  & s1aq1==69


*********************************Smoked Bonga***********************************

//1030110302001
replace s1aq3b = 11 if hid =="1030110302001"  & s1aq1==70
replace s1aq6b = 11 if hid =="1030110302001"  & s1aq1==70
replace s1aq7a = . if hid =="1030110302001"  & s1aq1==70
replace s1aq7b = . if hid =="1030110302001"  & s1aq1==70

//3230432314012
replace s1aq3b = 6 if hid =="3230432314012"  & s1aq1==70
replace s1aq6a = 3 if hid =="3230432314012"  & s1aq1==70
replace s1aq6b = 6 if hid =="3230432314012"  & s1aq1==70

//3310133116015
replace s1aq3b = 11 if hid =="3310133116015"  & s1aq1==70
replace s1aq6a =  3 if hid =="3310133116015"  & s1aq1==70
replace s1aq6b = 11 if hid =="3310133116015"  & s1aq1==70

//3060530638004
replace s1aq3b = 6 if hid =="3060530638004"  & s1aq1==70
replace s1aq8a = . if hid =="3060530638004"  & s1aq1==70
replace s1aq8b = . if hid =="3060530638004"  & s1aq1==70


//3230232357003
replace s1aq3b = 6 if hid =="3230232357003"  & s1aq1==70
replace s1aq8a = . if hid =="3230232357003"  & s1aq1==70
replace s1aq8b = . if hid =="3230232357003"  & s1aq1==70


//3120731204004
replace s1aq3b = 6 if hid =="3120731204004"  & s1aq1==70
replace s1aq4a = . if hid =="3120731204004"  & s1aq1==70
replace s1aq4b = . if hid =="3120731204004"  & s1aq1==70
replace s1aq5 = . if hid =="3120731204004"  & s1aq1==70
replace s1aq6a = . if hid =="3120731204004"  & s1aq1==70
replace s1aq6b = . if hid =="3120731204004"  & s1aq1==70
replace s1aq8a = s1aq3a if hid =="3120731204004"  & s1aq1==70
replace s1aq8b = 6 if hid =="3120731204004"  & s1aq1==70


//3240932442009
replace s1aq3b = 11 if hid =="3240932442009"  & s1aq1==70
replace s1aq4a = . if hid =="3240932442009"  & s1aq1==70
replace s1aq4b = . if hid =="3240932442009"  & s1aq1==70
replace s1aq5 = . if hid =="3240932442009"  & s1aq1==70
replace s1aq6a = . if hid =="3240932442009"  & s1aq1==70
replace s1aq6b = . if hid =="3240932442009"  & s1aq1==70
replace s1aq7a = . if hid =="3240932442009"  & s1aq1==70
replace s1aq7b = . if hid =="3240932442009"  & s1aq1==70
replace s1aq8a = s1aq3a if hid =="3240932442009"  & s1aq1==70
replace s1aq8b = 11 if hid =="3240932442009"  & s1aq1==70


//3134331356013
replace s1aq3a = s1aq4a if hid =="3134331356013"  & s1aq1==70
replace s1aq3b = s1aq4b if hid =="3134331356013"  & s1aq1==70


//3020230225009
replace s1aq3b = s1aq4b if hid =="3020230225009"  & s1aq1==70
replace s1aq6a = s1aq4a if hid =="3020230225009"  & s1aq1==70
replace s1aq6b = s1aq4b if hid =="3020230225009"  & s1aq1==70


//3133631313012
replace s1aq3b = 6 if hid =="3133631313012"  & s1aq1==70
replace s1aq7a = 6 if hid =="3133631313012"  & s1aq1==70


//1210112102014
replace s1aq3a = s1aq4a if hid =="1210112102014"  & s1aq1==70
replace s1aq3b = s1aq4b if hid =="1210112102014"  & s1aq1==70


//3144131452005
replace s1aq3b = s1aq4b if hid =="3144131452005"  & s1aq1==70
replace s1aq6a = s1aq4a if hid =="3144131452005"  & s1aq1==70
replace s1aq6b = s1aq4b if hid =="3144131452005"  & s1aq1==70


//3241032479003
replace s1aq3b = s1aq4b if hid =="3241032479003"  & s1aq1==70
replace s1aq6a = s1aq4a if hid =="3241032479003"  & s1aq1==70
replace s1aq6b = s1aq4b if hid =="3241032479003"  & s1aq1==70


//3240832455010
replace s1aq3a = s1aq4a if hid =="3240832455010"  & s1aq1==70
replace s1aq3b = s1aq4b if hid =="3240832455010"  & s1aq1==70


//3144131471010
replace s1aq3a = s1aq4a if hid =="3144131471010"  & s1aq1==70
replace s1aq3b = s1aq4b if hid =="3144131471010"  & s1aq1==70


//3144131471006
replace s1aq3a = s1aq4a if hid =="3144131471006"  & s1aq1==70
replace s1aq3b = s1aq4b if hid =="3144131471006"  & s1aq1==70


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 70 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq7a==. & s1aq8a==. & s1aq2==1 & s1aq6a==s1aq4a & s1aq3a!=tot_consumed 

gen issue = 3 if s1aq1  == 70 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq7a==. & s1aq8a==. & s1aq2==1 & s1aq6a==s1aq4a & s1aq3a!=tot_consumed 

replace s1aq3a = s1aq4a if issue == 3 
replace s1aq3b = s1aq4b if issue == 3

drop issue


//3080730851011
replace s1aq4a = s1aq3a if hid =="3080730851011"  & s1aq1==70
replace s1aq6a = s1aq3a if hid =="3080730851011"  & s1aq1==70
replace s1aq3b = s1aq4b if hid =="3080730851011"  & s1aq1==70


//3222632243008
replace s1aq3b = s1aq4b if hid =="3222632243008"  & s1aq1==70
replace s1aq6a = s1aq4a if hid =="3222632243008"  & s1aq1==70
replace s1aq6b = s1aq4b if hid =="3222632243008"  & s1aq1==70


//3133631313016
replace s1aq3b = 6 if hid =="3133631313016"  & s1aq1==70
replace s1aq4a = . if hid =="3133631313016"  & s1aq1==70
replace s1aq4b = . if hid =="3133631313016"  & s1aq1==70
replace s1aq8a = s1aq3a if hid =="3133631313016"  & s1aq1==70
replace s1aq8b = 6 if hid =="3133631313016"  & s1aq1==70


//3310133116009
replace s1aq3b = s1aq4b if hid =="3310133116009"  & s1aq1==70
replace s1aq6a = s1aq4a if hid =="3310133116009"  & s1aq1==70
replace s1aq6b = s1aq4b if hid =="3310133116009"  & s1aq1==70
replace s1aq5 = 15 if hid =="3310133116009"  & s1aq1==70


//3144131471011
replace s1aq3b = s1aq4b if hid =="3144131471011"  & s1aq1==70
replace s1aq6a = s1aq4a if hid =="3144131471011"  & s1aq1==70
replace s1aq6b = s1aq4b if hid =="3144131471011"  & s1aq1==70


//3210432144004
replace s1aq3b = s1aq4b if hid =="3210432144004"  & s1aq1==70
replace s1aq8a = . if hid =="3210432144004"  & s1aq1==70
replace s1aq8b = . if hid =="3210432144004"  & s1aq1==70


//3222632243010
br hid-s1aq8b  if hid =="3222632243010" & s1aq1==70
replace s1aq3b = s1aq4b if hid =="3222632243010"  & s1aq1==70
replace s1aq6a = s1aq4a if hid =="3222632243010"  & s1aq1==70
replace s1aq6b = s1aq4b if hid =="3222632243010"  & s1aq1==70


//3240232403009
replace s1aq3b = s1aq4b if hid =="3240232403009"  & s1aq1==70
replace s1aq6a = s1aq4a if hid =="3240232403009"  & s1aq1==70
replace s1aq6b = s1aq4b if hid =="3240232403009"  & s1aq1==70


//3143531402013
replace s1aq3b = s1aq4b if hid =="3143531402013"  & s1aq1==70
replace s1aq6a = s1aq4a if hid =="3143531402013"  & s1aq1==70
replace s1aq6b = s1aq4b if hid =="3143531402013"  & s1aq1==70


//3133931341011
replace s1aq3b = 6 if hid =="3133931341011"  & s1aq1==70
replace s1aq4a = . if hid =="3133931341011"  & s1aq1==70
replace s1aq4b = . if hid =="3133931341011"  & s1aq1==70
replace s1aq5 = . if hid =="3133931341011"  & s1aq1==70
replace s1aq6a = . if hid =="3133931341011"  & s1aq1==70
replace s1aq6b = . if hid =="3133931341011"  & s1aq1==70
replace s1aq7a = . if hid =="3133931341011"  & s1aq1==70
replace s1aq7b = . if hid =="3133931341011"  & s1aq1==70
replace s1aq8a = s1aq3a if hid =="3133931341011"  & s1aq1==70
replace s1aq8b = 6 if hid =="3133931341011"  & s1aq1==70


//3240432429004
replace s1aq3b = 11 if hid =="3240432429004"  & s1aq1==70
replace s1aq4b = 11 if hid =="3240432429004"  & s1aq1==70
replace s1aq6a = s1aq4a if hid =="3240432429004"  & s1aq1==70
replace s1aq6b = 11 if hid =="3240432429004"  & s1aq1==70


//3330133313009
replace s1aq3b = s1aq4b if hid =="3330133313009"  & s1aq1==70
replace s1aq8a = . if hid =="3330133313009"  & s1aq1==70
replace s1aq8b = . if hid =="3330133313009"  & s1aq1==70


//3143531402001
replace s1aq3b = 11 if hid =="3143531402001"  & s1aq1==70
replace s1aq4a = . if hid =="3143531402001"  & s1aq1==70
replace s1aq4b = . if hid =="3143531402001"  & s1aq1==70
replace s1aq8a = s1aq3a if hid =="3143531402001"  & s1aq1==70
replace s1aq8b = 11 if hid =="3143531402001"  & s1aq1==70


//3320733231003
replace s1aq3b = s1aq4b if hid =="3320733231003"  & s1aq1==70
replace s1aq6a = s1aq4a if hid =="3320733231003"  & s1aq1==70
replace s1aq6b = s1aq4b if hid =="3320733231003"  & s1aq1==70


//3133631305016
replace s1aq3b = s1aq4b if hid =="3133631305016"  & s1aq1==70
replace s1aq6a = s1aq4a if hid =="3133631305016"  & s1aq1==70
replace s1aq6b = s1aq4b if hid =="3133631305016"  & s1aq1==70


***********************************Smoked Fish**********************************

//3040130406002
replace s1aq3b = s1aq4b if hid =="3040130406002"  & s1aq1==71
replace s1aq6a = s1aq4a if hid =="3040130406002"  & s1aq1==71
replace s1aq6b = s1aq4b if hid =="3040130406002"  & s1aq1==71

//3060130659001
replace s1aq3a = s1aq4a if hid =="3060130659001"  & s1aq1==71
replace s1aq3b = s1aq4b if hid =="3060130659001"  & s1aq1==71

//3040130466009
replace s1aq3a = s1aq4a if hid =="3040130466009"  & s1aq1==71
replace s1aq3b = s1aq4b if hid =="3040130466009"  & s1aq1==71

//3040130443002
replace s1aq3b = s1aq4b if hid =="3040130443002"  & s1aq1==71
replace s1aq5 = 75 if hid =="3040130443002"  & s1aq1==71
replace s1aq6a = s1aq4a if hid =="3040130443002"  & s1aq1==71
replace s1aq6b = s1aq4b if hid =="3040130443002"  & s1aq1==71

//3241332469009
replace s1aq3b = 6 if hid =="3241332469009"  & s1aq1==71
replace s1aq4a = . if hid =="3241332469009"  & s1aq1==71
replace s1aq4b = . if hid =="3241332469009"  & s1aq1==71
replace s1aq8a = . if hid =="3241332469009"  & s1aq1==71
replace s1aq8b = . if hid =="3241332469009"  & s1aq1==71

//3133631305012
replace s1aq3b = 6 if hid =="3133631305012"  & s1aq1==71
replace s1aq4a = . if hid =="3133631305012"  & s1aq1==71
replace s1aq4b = . if hid =="3133631305012"  & s1aq1==71
replace s1aq5 = . if hid =="3133631305012"  & s1aq1==71
replace s1aq6a = . if hid =="3133631305012"  & s1aq1==71
replace s1aq6b = . if hid =="3133631305012"  & s1aq1==71
replace s1aq7a = . if hid =="3133631305012"  & s1aq1==71
replace s1aq7b = . if hid =="3133631305012"  & s1aq1==71
replace s1aq8a = s1aq3a if hid =="3133631305012"  & s1aq1==71
replace s1aq8b = 6 if hid =="3133631305012"  & s1aq1==71


//3050330565004
replace s1aq3b = s1aq4b if hid =="3050330565004"  & s1aq1==71
replace s1aq6a = s1aq4a if hid =="3050330565004"  & s1aq1==71
replace s1aq6b = s1aq4b if hid =="3050330565004"  & s1aq1==71
replace s1aq8a = . if hid =="3050330565004"  & s1aq1==71
replace s1aq8b = . if hid =="3050330565004"  & s1aq1==71


//3133631313009
replace s1aq3b = 6 if hid =="3133631313009"  & s1aq1==71
replace s1aq4a = . if hid =="3133631313009"  & s1aq1==71
replace s1aq4b = . if hid =="3133631313009"  & s1aq1==71
replace s1aq5 = . if hid =="3133631313009"  & s1aq1==71
replace s1aq6a = . if hid =="3133631313009"  & s1aq1==71
replace s1aq6b = . if hid =="3133631313009"  & s1aq1==71
replace s1aq7a = s1aq3a if hid =="3133631313009"  & s1aq1==71
replace s1aq7b = 6 if hid =="3133631313009"  & s1aq1==71


//3110331130012
replace s1aq3a = s1aq4a if hid =="3110331130012"  & s1aq1==71
replace s1aq3b = s1aq4b if hid =="3110331130012"  & s1aq1==71


**********************Sardine tin in vegetable oil******************************

//1110111106001
replace s1aq3b = 12 if hid =="1110111106001"  & s1aq1==74
replace s1aq8a = s1aq3a if hid =="1110111106001"  & s1aq1==74
replace s1aq8b = 12 if hid =="1110111106001"  & s1aq1==74


//3030530383014
replace s1aq3b = 12 if hid =="3030530383014"  & s1aq1==74
replace s1aq4a = . if hid =="3030530383014"  & s1aq1==74
replace s1aq4b = . if hid =="3030530383014"  & s1aq1==74
replace s1aq5 = . if hid =="3030530383014"  & s1aq1==74
replace s1aq6a = . if hid =="3030530383014"  & s1aq1==74
replace s1aq6b = . if hid =="3030530383014"  & s1aq1==74
replace s1aq8a = s1aq3a if hid =="3030530383014"  & s1aq1==74
replace s1aq8b = 12 if hid =="3030530383014"  & s1aq1==74

//3144131471012
replace s1aq3b = 12 if hid =="3144131471012"  & s1aq1==74
replace s1aq4a = s1aq3a if hid =="3144131471012"  & s1aq1==74
replace s1aq6a = s1aq3a if hid =="3144131471012"  & s1aq1==74


//3320433220012
replace s1aq3b = 12 if hid =="3320433220012"  & s1aq1==74
replace s1aq3a = s1aq6a if hid =="3320433220012"  & s1aq1==74
replace s1aq4a = s1aq6a if hid =="3320433220012"  & s1aq1==74


//3230232357001
replace s1aq3b = 12 if hid =="3230232357001"  & s1aq1==74
replace s1aq3a = s1aq4a if hid =="3230232357001"  & s1aq1==74


//1220112208005
replace s1aq3b = 12 if hid =="1220112208005"  & s1aq1==74
replace s1aq8a = s1aq3a if hid =="1220112208005"  & s1aq1==74
replace s1aq8b = 12 if hid =="1220112208005"  & s1aq1==74


//3310133116002
replace s1aq3b = 12 if hid =="3310133116002"  & s1aq1==74
replace s1aq3a = s1aq6a if hid =="3310133116002"  & s1aq1==74
replace s1aq4a = s1aq6a if hid =="3310133116002"  & s1aq1==74


************************Sardine in Tomato sauce*********************************

//3311633110001
replace s1aq3a = s1aq4a if hid =="3311633110001"  & s1aq1==76
replace s1aq3b = 12 if hid =="3311633110001"  & s1aq1==76
replace s1aq4b = 12 if hid =="3311633110001"  & s1aq1==76
replace s1aq6b = 12 if hid =="3311633110001"  & s1aq1==76


//1010110101009
replace s1aq3b = 12 if hid =="1010110101009"  & s1aq1==76
replace s1aq4a = s1aq3a if hid =="1010110101009"  & s1aq1==76
replace s1aq4b = 12 if hid =="1010110101009"  & s1aq1==76
replace s1aq5 = 50 if hid =="1010110101009"  & s1aq1==76
replace s1aq6a = s1aq3a if hid =="1010110101009"  & s1aq1==76
replace s1aq6b = 12 if hid =="1010110101009"  & s1aq1==76


//2310123112002
replace s1aq3b = 12 if hid =="2310123112002"  & s1aq1==76
replace s1aq8a = s1aq3a if hid =="2310123112002"  & s1aq1==76
replace s1aq8b = 12 if hid =="2310123112002"  & s1aq1==76


//1120111202016
br hid-s1aq8b  if hid =="1120111202016" & s1aq1==78   // I am not sure how this one can be fixed


***********************************Crabs****************************************

//2210122118004
replace s1aq3b = 11 if hid =="2210122118004"  & s1aq1==79
replace s1aq4a = s1aq3a if hid =="2210122118004"  & s1aq1==79
replace s1aq4b = 11 if hid =="2210122118004"  & s1aq1==79
replace s1aq6a = s1aq3a if hid =="2210122118004"  & s1aq1==79
replace s1aq6b = 11 if hid =="2210122118004"  & s1aq1==79


//1110111112014
replace s1aq3a = s1aq4a if hid =="1110111112014"  & s1aq1==79
replace s1aq3b = 11 if hid =="1110111112014"  & s1aq1==79


**********************************Shrimps***************************************

//2130121308010
replace s1aq3a = s1aq4a if hid =="2130121308010"  & s1aq1==80
replace s1aq3b = 1 if hid =="2130121308010"  & s1aq1==80


//2210122118015
replace s1aq3a = .5 if hid =="2210122118015"  & s1aq1==80
replace s1aq3b = 1 if hid =="2210122118015"  & s1aq1==80
replace s1aq4a = .5 if hid =="2210122118015"  & s1aq1==80
replace s1aq6a = .5 if hid =="2210122118015"  & s1aq1==80


**********************************Oyester**************************************

//2410124101006
replace s1aq3b = s1aq4b if hid =="2410124101006"  & s1aq1==81
replace s1aq6a = s1aq4a if hid =="2410124101006"  & s1aq1==81
replace s1aq6b = s1aq4b if hid =="2410124101006"  & s1aq1==81


***********************************Snails***************************************

//3320433220014
replace s1aq3a = s1aq4a if hid =="3320433220014"  & s1aq1==82
replace s1aq3b = 6 if hid =="3320433220014"  & s1aq1==82
replace s1aq5 = 70 if hid =="3320433220014"  & s1aq1==82


//3030530383015
replace s1aq3a = s1aq4a if hid =="3030530383015"  & s1aq1==82
replace s1aq3b = 1 if hid =="3030530383015"  & s1aq1==82


//3222832216004
replace s1aq3b = s1aq4b if hid =="3222832216004"  & s1aq1==82
replace s1aq5 = 50 if hid =="3222832216004"  & s1aq1==82
replace s1aq6a = s1aq4a if hid =="3222832216004"  & s1aq1==82
replace s1aq6b = s1aq4b if hid =="3222832216004"  & s1aq1==82


//3321433202013
replace s1aq3a = 6 if hid =="3321433202013"  & s1aq1==82
replace s1aq3b = 6 if hid =="3321433202013"  & s1aq1==82
replace s1aq4b = 6 if hid =="3321433202013"  & s1aq1==82
replace s1aq5 = 30 if hid =="3321433202013"  & s1aq1==82
replace s1aq6a = 6 if hid =="3321433202013"  & s1aq1==82


//2410124101006
replace s1aq3b = s1aq4b if hid =="2410124101006"  & s1aq1==82
replace s1aq6a = s1aq4a if hid =="2410124101006"  & s1aq1==82
replace s1aq6b = s1aq4b if hid =="2410124101006"  & s1aq1==82


*****************************Fresh cow milk*************************************

//3320433220002
replace s1aq3a = s1aq4a if hid =="3320433220002"  & s1aq1==84
replace s1aq3b = s1aq4b if hid =="3320433220002"  & s1aq1==84


//3230132368013
replace s1aq3b = s1aq4b if hid =="3230132368013"  & s1aq1==84
replace s1aq6a = s1aq4a if hid =="3230132368013"  & s1aq1==84


*****************************Sour cow milk**************************************

//2120121201006
replace s1aq3a = s1aq4a if hid =="2120121201006"  & s1aq1==85
replace s1aq3b = s1aq4b if hid =="2120121201006"  & s1aq1==85


//1230112304001
replace s1aq3b = s1aq4b if hid =="1230112304001"  & s1aq1==85
replace s1aq6a = s1aq4a if hid =="1230112304001"  & s1aq1==85
replace s1aq6b = s1aq4b if hid =="1230112304001"  & s1aq1==85


//1110111106011
replace s1aq3a = .5 if hid =="1110111106011"  & s1aq1==85
replace s1aq3b = 3 if hid =="1110111106011"  & s1aq1==85
replace s1aq5 = 20 if hid =="1110111106011"  & s1aq1==85
replace s1aq4a = .5 if hid =="1110111106011"  & s1aq1==85
replace s1aq6a = .5 if hid =="1110111106011"  & s1aq1==85


//3222432230001
replace s1aq3a = s1aq4a if hid =="3222432230001"  & s1aq1==85
replace s1aq3b = s1aq4b if hid =="3222432230001"  & s1aq1==85


//3050330585007
br hid-s1aq8b  if hid =="3050330585007" & s1aq1==87       // I am not sure how this one can be fixed



******************************Skimmed milk**************************************

//3240832455016
replace s1aq3b = s1aq4b if hid =="3240832455016"  & s1aq1==88
replace s1aq6a = s1aq4a if hid =="3240832455016"  & s1aq1==88
replace s1aq6b = s1aq4b if hid =="3240832455016"  & s1aq1==88


//3121031225003
replace s1aq3b = s1aq4b if hid =="3121031225003"  & s1aq1==88
replace s1aq6a = s1aq4a if hid =="3121031225003"  & s1aq1==88
replace s1aq6b = s1aq4b if hid =="3121031225003"  & s1aq1==88


//3081730807002
replace s1aq3b = s1aq4b if hid =="3081730807002"  & s1aq1==88
replace s1aq4a = s1aq3a if hid =="3081730807002"  & s1aq1==88
replace s1aq6a = s1aq3a if hid =="3081730807002"  & s1aq1==88


//3240432429003
replace s1aq3b = s1aq4b if hid =="3240432429003"  & s1aq1==88
replace s1aq6a = s1aq4a if hid =="3240432429003"  & s1aq1==88


*******************************Semi Skimmed milk********************************

//3040130485007
replace s1aq3a = s1aq8a if hid =="3040130485007"  & s1aq1==89
replace s1aq3b = s1aq8b if hid =="3040130485007"  & s1aq1==89


*******************************Milk Powder********************************


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 91 & ( s1aq4a==. & s1aq4b==. & s1aq5==. & s1aq6a==. & s1aq6b==.) & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if s1aq1  == 91 & ( s1aq4a==. & s1aq4b==. & s1aq5==. & s1aq6a==. & s1aq6b==.) & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq8a = s1aq3a if issue == 1
replace s1aq3b = 5 if issue == 1
replace s1aq8b = 5 if issue == 1

drop issue


//2020120213013
replace s1aq3b = 5 if hid =="2020120213013"  & s1aq1==91
replace s1aq4a = . if hid =="2020120213013"  & s1aq1==91
replace s1aq4b = . if hid =="2020120213013"  & s1aq1==91
replace s1aq8a = s1aq3a if hid =="2020120213013"  & s1aq1==91
replace s1aq8b = 5 if hid =="2020120213013"  & s1aq1==91


//3330133313011
replace s1aq3b = s1aq4b if hid =="3330133313011"  & s1aq1==91
replace s1aq6a = s1aq4a if hid =="3330133313011"  & s1aq1==91
replace s1aq6b = s1aq4b if hid =="3330133313011"  & s1aq1==91


//3211032132004
replace s1aq3b = s1aq4b if hid =="3211032132004"  & s1aq1==91
replace s1aq6a = s1aq4a if hid =="3211032132004"  & s1aq1==91


//2130121308011
replace s1aq3a = s1aq4a if hid =="2130121308011"  & s1aq1==91
replace s1aq3b = s1aq4b if hid =="2130121308011"  & s1aq1==91


//2320123251006
replace s1aq3b = 1 if hid =="2320123251006"  & s1aq1==91
replace s1aq8b = 1 if hid =="2320123251006"  & s1aq1==91


************************Evaporated Milk*****************************************

br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 92 & ( s1aq4a==. & s1aq4b==. & s1aq5==. & s1aq6a==. & s1aq6b==.) & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if s1aq1  == 92 & ( s1aq4a==. & s1aq4b==. & s1aq5==. & s1aq6a==. & s1aq6b==.) & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq8a = s1aq3a if issue == 1
replace s1aq3b = 12 if issue == 1
replace s1aq8b = 12 if issue == 1

drop issue


//3321033216009
replace s1aq3a = s1aq4a if hid =="3321033216009"  & s1aq1==92
replace s1aq3b = s1aq4b if hid =="3321033216009"  & s1aq1==92


//1020110205004
replace s1aq3a = s1aq4a if hid =="1020110205004"  & s1aq1==92
replace s1aq3b = s1aq4b if hid =="1020110205004"  & s1aq1==92


//3090330950011
replace s1aq3a = s1aq4a if hid =="3090330950011"  & s1aq1==92
replace s1aq3b = s1aq4b if hid =="3090330950011"  & s1aq1==92

//3071930721003
replace s1aq3a = s1aq4a if hid =="3071930721003"  & s1aq1==92
replace s1aq3b = s1aq4b if hid =="3071930721003"  & s1aq1==92

*****************************condensed Milk*************************************

//3010430108012
replace s1aq3a = s1aq6a if hid =="3010430108012"  & s1aq1==93
replace s1aq3b = s1aq6b if hid =="3010430108012"  & s1aq1==93
replace s1aq4a = s1aq6a if hid =="3010430108012"  & s1aq1==93

*******************************Milk Sacket**************************************

br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 94 & ( s1aq4a==. & s1aq4b==. & s1aq5==. & s1aq6a==. & s1aq6b==.) & s1aq3a!=tot_consumed & s1aq3a!=.


gen issue = 1 if s1aq1  == 94 & ( s1aq4a==. & s1aq4b==. & s1aq5==. & s1aq6a==. & s1aq6b==.) & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq8a = s1aq3a if issue == 1
replace s1aq3b = 5 if issue == 1
replace s1aq8b = 5 if issue == 1

drop issue



br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 94 & ( s1aq4a!=. & s1aq4b!=. & s1aq5!=. & s1aq6a!=. & s1aq6b!=. & s1aq7a==. & s1aq8a==. & s1aq4a==s1aq3a) & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if s1aq1  == 94 & ( s1aq4a!=. & s1aq4b!=. & s1aq5!=. & s1aq6a!=. & s1aq6b!=. & s1aq7a==. & s1aq8a==. & s1aq4a==s1aq3a) & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq6a = s1aq4a if issue == 1
replace s1aq3b = s1aq4b if issue == 1
replace s1aq6b = s1aq4b if issue == 1

drop issue



br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 94 & ( s1aq4a!=. & s1aq4b!=. & s1aq5!=. & s1aq6a!=. & s1aq6b!=. & s1aq7a==. & s1aq8a==. & s1aq4a==s1aq6a) & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if s1aq1  == 94 & ( s1aq4a!=. & s1aq4b!=. & s1aq5!=. & s1aq6a!=. & s1aq6b!=. & s1aq7a==. & s1aq8a==. & s1aq4a==s1aq6a) & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq3a = s1aq4a if issue == 1
replace s1aq3b = s1aq4b if issue == 1

drop issue



br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 94 & ( s1aq4a!=. & s1aq4b!=. & s1aq5!=. & s1aq6a==. & s1aq7a==. & s1aq8a==. & s1aq4a==s1aq3a) & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if s1aq1  == 94 & ( s1aq4a!=. & s1aq4b!=. & s1aq5!=. & s1aq6a==. & s1aq7a==. & s1aq8a==. & s1aq4a==s1aq3a) & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq6a = s1aq4a if issue == 1
replace s1aq3b = s1aq4b if issue == 1
replace s1aq6b = s1aq4b if issue == 1

drop issue


//3210632121002
replace s1aq3b = s1aq4b if hid =="3210632121002"  & s1aq1==94
replace s1aq5 = 35 if hid =="3210632121002"  & s1aq1==94
replace s1aq6a = s1aq4a if hid =="3210632121002"  & s1aq1==94
replace s1aq6b = s1aq4b if hid =="3210632121002"  & s1aq1==94
replace s1aq8a = . if hid =="3210632121002"  & s1aq1==94
replace s1aq8b = . if hid =="3210632121002"  & s1aq1==94


//3240932442003
replace s1aq3b = s1aq4b if hid =="3240932442003"  & s1aq1==94
replace s1aq6a = s1aq4a if hid =="3240932442003"  & s1aq1==94
replace s1aq6b = s1aq4b if hid =="3240932442003"  & s1aq1==94
replace s1aq8a = . if hid =="3240932442003"  & s1aq1==94
replace s1aq8b = . if hid =="3240932442003"  & s1aq1==94


//3241332469010
replace s1aq3b = s1aq4b if hid =="3241332469010"  & s1aq1==94
replace s1aq8a = . if hid =="3241332469010"  & s1aq1==94
replace s1aq8b = . if hid =="3241332469010"  & s1aq1==94


*******************************Cream********************************************

br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 95 & ( s1aq4a!=. & s1aq4b!=. & s1aq5!=. & s1aq6a!=. & s1aq6b!=. & s1aq7a==. & s1aq8a==. & s1aq4a==s1aq6a) & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if s1aq1  == 95 & ( s1aq4a!=. & s1aq4b!=. & s1aq5!=. & s1aq6a!=. & s1aq6b!=. & s1aq7a==. & s1aq8a==. & s1aq4a==s1aq6a) & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq3a = s1aq4a if issue == 1
replace s1aq3b = s1aq4b if issue == 1


drop issue


//3240432416011
replace s1aq3b = s1aq4b if hid =="3240432416011"  & s1aq1==95
replace s1aq6a = s1aq4a if hid =="3240432416011"  & s1aq1==95
replace s1aq6b = s1aq4b if hid =="3240432416011"  & s1aq1==95


//3133631305001
replace s1aq3b = s1aq4b if hid =="3133631305001"  & s1aq1==95
replace s1aq6a = s1aq4a if hid =="3133631305001"  & s1aq1==95
replace s1aq6b = s1aq4b if hid =="3133631305001"  & s1aq1==95
replace s1aq7a = . if hid =="3133631305001"  & s1aq1==95
replace s1aq7b = . if hid =="3133631305001"  & s1aq1==95


//1110111112015
replace s1aq3a = .5 if hid =="1110111112015"  & s1aq1==95
replace s1aq4a = .5 if hid =="1110111112015"  & s1aq1==95
replace s1aq6a = .5 if hid =="1110111112015"  & s1aq1==95


**************************Cheese, Processed*************************************
//1210112104002
replace s1aq3b = 6 if hid =="1210112104002"  & s1aq1==97
replace s1aq8a = s1aq3a if hid =="1210112104002"  & s1aq1==97
replace s1aq8b = 6 if hid =="1210112104002"  & s1aq1==97

*******************************Plain Yoghurt*************************************

//3130231348014
replace s1aq3b = s1aq4b if hid =="3130231348014"  & s1aq1==99
replace s1aq6a = s1aq4a if hid =="3130231348014"  & s1aq1==99

//3022130267002
replace s1aq3b = s1aq4b if hid =="3022130267002"  & s1aq1==99
replace s1aq4a = s1aq3a if hid =="3022130267002"  & s1aq1==99
replace s1aq6a = s1aq3a if hid =="3022130267002"  & s1aq1==99


//2110321101009
replace s1aq3b = 5 if hid =="2110321101009"  & s1aq1==99
replace s1aq8a = s1aq3a if hid =="2110321101009"  & s1aq1==99
replace s1aq8b = 5 if hid =="2110321101009"  & s1aq1==99

***********************Eggs of hen local breed**********************************

//2420224209005
replace s1aq3b = 6 if hid =="2420224209005"  & s1aq1==101
replace s1aq8a = s1aq3a if hid =="2420224209005"  & s1aq1==101
replace s1aq8b = 6 if hid =="2420224209005"  & s1aq1==101


**********************Eggs of hen industrial breed******************************

br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 102 & ( s1aq4a==. & s1aq4b==. & s1aq5==. & s1aq6a==. & s1aq6b==.) & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if s1aq1  == 102 & ( s1aq4a==. & s1aq4b==. & s1aq5==. & s1aq6a==. & s1aq6b==.) & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq8a = s1aq3a if issue == 1
replace s1aq3b = 6 if issue == 1
replace s1aq8b = 6 if issue == 1

drop issue


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 102 & ( s1aq4a!=. & s1aq4b!=. & s1aq5!=. & s1aq6a!=. & s1aq6b!=. & s1aq7a==. & s1aq8a==. & s1aq4a==s1aq3a) & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if s1aq1  == 102 & ( s1aq4a!=. & s1aq4b!=. & s1aq5!=. & s1aq6a!=. & s1aq6b!=. & s1aq7a==. & s1aq8a==. & s1aq4a==s1aq3a) & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq6a = s1aq4a if issue == 1
replace s1aq3b = s1aq4b if issue == 1
replace s1aq6b = s1aq4b if issue == 1

drop issue



br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 102 & ( s1aq4a!=. & s1aq4b!=. & s1aq5!=. & s1aq6a!=. & s1aq6b!=. & s1aq7a==. & s1aq8a==. & s1aq4a==s1aq6a) & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if s1aq1  == 102 & ( s1aq4a!=. & s1aq4b!=. & s1aq5!=. & s1aq6a!=. & s1aq6b!=. & s1aq7a==. & s1aq8a==. & s1aq4a==s1aq6a) & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq3a = s1aq4a if issue == 1
replace s1aq3b = s1aq4b if issue == 1


drop issue



br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 102 & ( s1aq4a!=. & s1aq4b!=. & s1aq5!=. & s1aq6a==. & s1aq7a==. & s1aq8a==. & s1aq4a==s1aq3a) & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if s1aq1  == 102 & ( s1aq4a!=. & s1aq4b!=. & s1aq5!=. & s1aq6a==. & s1aq7a==. & s1aq8a==. & s1aq4a==s1aq3a) & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq6a = s1aq4a if issue == 1
replace s1aq3b = s1aq4b if issue == 1
replace s1aq6b = s1aq4b if issue == 1


drop issue



//3240232403008
replace s1aq3b = s1aq4b if hid =="3240232403008"  & s1aq1==102
replace s1aq8a = . if hid =="3240232403008"  & s1aq1==102
replace s1aq8b = . if hid =="3240232403008"  & s1aq1==102


//3050230524009
replace s1aq3b = 6 if hid =="3050230524009"  & s1aq1==102
replace s1aq4a = . if hid =="3050230524009"  & s1aq1==102
replace s1aq4b = . if hid =="3050230524009"  & s1aq1==102
replace s1aq8a = s1aq3b if hid =="3050230524009"  & s1aq1==102
replace s1aq8b = 6 if hid =="3050230524009"  & s1aq1==102

//1120111210003
replace s1aq3b = s1aq4b if hid =="1120111210003"  & s1aq1==102
replace s1aq4a = 10 if hid =="1120111210003"  & s1aq1==102
replace s1aq8a = . if hid =="1120111210003"  & s1aq1==102
replace s1aq8b = . if hid =="1120111210003"  & s1aq1==102


//3222432230007
replace s1aq3b = 6 if hid =="3222432230007"  & s1aq1==102
replace s1aq4b = 6 if hid =="3222432230007"  & s1aq1==102
replace s1aq6b = 6 if hid =="3222432230007"  & s1aq1==102

//3040130406009
replace s1aq3b = 6 if hid =="3040130406009"  & s1aq1==102
replace s1aq4b = 6 if hid =="3040130406009"  & s1aq1==102
replace s1aq6b = 6 if hid =="3040130406009"  & s1aq1==102


****************** 165 garlic ********************
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 165 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if  s1aq1  == 165 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq8a = s1aq3a if issue == 1
replace s1aq3b = 6 if issue == 1
replace s1aq8b = 6 if issue == 1

drop issue



br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 165 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if s1aq1  == 165 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = . if issue == 1
replace s1aq8a = . if issue == 1
replace s1aq7b = . if issue == 1
replace s1aq8b = . if issue == 1

replace s1aq6a = 7 if s1aq6a == 6 & hid == "1010110101012" & issue == 1
replace s1aq5 = 30 if s1aq5 == 3 & hid == "3110231139011" & issue == 1
replace s1aq6a = 2 if s1aq6a == 6 & hid == "3310333128009" & issue == 1
replace s1aq6a = 1 if s1aq6a == 21 & hid == "3110331130005" & issue == 1
replace s1aq5 = 5 if s1aq5 == 50 & hid == "3110331130005" & issue == 1
replace s1aq5 = 5 if s1aq5 == 1 & hid == "3134331356003" & issue == 1
replace s1aq5 = 30 if s1aq5 == 163 & hid == "3110331110011" & issue == 1
replace s1aq6a = 2 if s1aq6a == 6 & hid == "3321433202012" & issue == 1
replace s1aq6a = 1 if s1aq6a == 26 & hid == "3133631323001" & issue == 1
replace s1aq5 = 15 if s1aq5 == 6 & hid == "3321433202013" & issue == 1
replace s1aq6a = 1 if s1aq6a == 26 & hid == "3210432144004" & issue == 1
replace s1aq6a = 2 if s1aq6a == 6 & hid == "3210932108002" & issue == 1
replace s1aq6a = 2 if s1aq6a == 26 & hid == "3222832216007" & issue == 1
replace s1aq5 = 10 if s1aq5 == 17 & hid == "3222832216007" & issue == 1
replace s1aq5 = 30 if s1aq5 == 3 & hid == "3141931431009" & issue == 1
replace s1aq6a = 3 if s1aq6a == 36 & hid == "3222632243006" & issue == 1
replace s1aq5 = 15 if s1aq5 == 16 & hid == "3222632243006" & issue == 1
replace s1aq6a = 1 if s1aq6a == 2 & hid == "3210632121005" & issue == 1
replace s1aq5 = 30 if s1aq5 == 802 & hid == "3222632243004" & issue == 1
replace s1aq6a = 1 if s1aq6a == 6 & hid == "2340123436012" & issue == 1
replace s1aq5 = 10 if s1aq5 == 101 & hid == "2340123436012" & issue == 1

replace s1aq3a = s1aq6a if issue == 1
replace s1aq4a = s1aq6a if issue == 1
replace s1aq3b = 6 if issue == 1
replace s1aq4b = 6 if issue == 1
replace s1aq6b = 6 if issue == 1

drop issue



br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 165 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if  s1aq1  == 165 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq4a = s1aq3a if issue == 1
replace s1aq6a = s1aq3a if issue == 1
replace s1aq5 = 5 if s1aq5 == 40 & issue ==1 
replace s1aq5 = 25 if s1aq5 == 6 & issue ==1 

replace s1aq3b = 6 if issue == 1
replace s1aq4b = 6 if issue == 1
replace s1aq6b = 6 if issue == 1

drop issue


///3321433202010
br hid-s1aq8b  if hid =="3321433202010" & s1aq1==165
recode s1aq4a (0=.) if hid =="3321433202010"  & s1aq1==165
recode s1aq6a (6=.) if hid =="3321433202010"  & s1aq1==165
recode s1aq7a (11=.) if hid =="3321433202010"  & s1aq1==165
recode s1aq8a (6=4) if hid =="3321433202010"  & s1aq1==165
recode s1aq3b (0=6) if hid =="3321433202010"  & s1aq1==165
recode s1aq4b (11=.) if hid =="3321433202010"  & s1aq1==165
recode s1aq6b (4=.) if hid =="3321433202010"  & s1aq1==165
recode s1aq7b (0=.) if hid =="3321433202010"  & s1aq1==165
recode s1aq8b (0=6) if hid =="3321433202010"  & s1aq1==165



///3330133313010
br hid-s1aq8b  if hid =="3330133313010" & s1aq1==165
recode s1aq3a (2=6) if hid =="3330133313010"  & s1aq1==165
recode s1aq3b (0=6) if hid =="3330133313010"  & s1aq1==165


**************** 163 carrot **************** 
///1220112208005
br hid-s1aq8b  if hid =="1220112208005" & s1aq1==163
recode s1aq8a (.=1) if hid =="1220112208005"  & s1aq1==163
recode s1aq8b (.=6) if hid =="1220112208005"  & s1aq1==163
recode s1aq3b (0=6) if hid =="1220112208005"  & s1aq1==163



///3080730851004
br hid-s1aq8b  if hid =="3080730851004" & s1aq1==163
recode s1aq5 (75=120) if hid =="3080730851004"  & s1aq1==163
recode s1aq8a (2=.) if hid =="3080730851004"  & s1aq1==163
recode s1aq8b (2=.) if hid =="3080730851004"  & s1aq1==163
recode s1aq3b (0=11) if hid =="3080730851004"  & s1aq1==163




///2410124122008
br hid-s1aq8b  if hid =="2410124122008" & s1aq1==163
recode s1aq4a (35=6) if hid =="2410124122008"  & s1aq1==163
recode s1aq6a (35=6) if hid =="2410124122008"  & s1aq1==163
recode s1aq7a (6=.) if hid =="2410124122008"  & s1aq1==163
recode s1aq3a (1=6) if hid =="2410124122008"  & s1aq1==163
recode s1aq3b (0=6) if hid =="2410124122008"  & s1aq1==163
recode s1aq4b (7=6) if hid =="2410124122008"  & s1aq1==163
recode s1aq6b (7=6) if hid =="2410124122008"  & s1aq1==163
recode s1aq7b (0=.) if hid =="2410124122008"  & s1aq1==163
recode s1aq5 (6=30) if hid =="2410124122008"  & s1aq1==163



***************** 159 fresh green pepper **************
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 159 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if s1aq1  == 159 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = . if issue == 1 
replace s1aq7b = . if issue == 1 
replace s1aq8a = s1aq3a if issue == 1
replace s1aq3b = 11 if issue == 1
replace s1aq8b = 11 if issue == 1

drop issue



br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 159 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if s1aq1  == 159 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = . if issue == 1
replace s1aq7b = . if issue == 1

replace s1aq5 = 20 if s1aq5 ==  40 & hid == "3090230903010" & issue ==1 
replace s1aq5 = 20 if s1aq5 ==  18 & hid == "3081730807001" & issue ==1 
replace s1aq5 = 10 if s1aq5 ==  1 & hid == "3060130659003" & issue ==1 
replace s1aq5 = 5 if s1aq5 ==  6 & hid == "1120111204015" & issue ==1 
replace s1aq5 = 60 if s1aq5 ==  7 & hid == "1110111112015" & issue ==1 
replace s1aq5 = 10 if s1aq5 ==  102 & hid == "3230232347013" & issue ==1 

replace s1aq4a = s1aq3a if issue == 1
replace s1aq6a = s1aq3a if issue == 1
replace s1aq3b = 11 if issue == 1
replace s1aq4b = 11 if issue == 1
replace s1aq6b = 11 if issue == 1

drop issue


///3240832455001
br hid-s1aq8b  if hid =="3240832455001" & s1aq1==159
recode s1aq6a (.=1) if hid =="3240832455001"  & s1aq1==159
recode s1aq6b (.=11) if hid =="3240832455001"  & s1aq1==159
recode s1aq3b (0=11) if hid =="3240832455001"  & s1aq1==159
recode s1aq4b (6=11) if hid =="3240832455001"  & s1aq1==159



******************* 156 okra *******************
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 156 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if s1aq1  == 156 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq8a = . if issue == 1
replace s1aq8b = . if issue == 1
replace s1aq7a = s1aq3a if issue == 1
replace s1aq3b = 11 if issue == 1
replace s1aq7b = 11 if issue == 1

drop issue 



br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 156 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if  s1aq1  == 156 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = . if issue == 1
replace s1aq8a = . if issue == 1
replace s1aq7b = . if issue == 1
replace s1aq8b = . if issue == 1

replace s1aq6a = 1 if s1aq6a == 6 & hid == "3311033106005" & issue == 1
replace s1aq6a = 1 if s1aq6a == 16 & hid == "3134331356014" & issue == 1
replace s1aq6a = 1 if s1aq6a == 6 & hid == "3120731204010" & issue == 1
replace s1aq6a = 3 if s1aq6a == 8 & hid == "3010430146009" & issue == 1
replace s1aq6a = 1 if s1aq6a == 11 & hid == "3060530617014" & issue == 1
replace s1aq6a = 4 if s1aq6a == 3 & hid == "1020110201008" & issue == 1
replace s1aq5 = 30 if s1aq5 == 25 & hid == "3144131471002" & issue == 1
replace s1aq5 = 50 if s1aq5 == 38 & hid == "3133631305010" & issue == 1
replace s1aq5 = 50 if s1aq5 == 30 & hid == "3143531411008" & issue == 1
replace s1aq5 = 40 if s1aq5 == 30 & hid == "3060130659016" & issue == 1

replace s1aq4a = s1aq6a if issue == 1
replace s1aq3a = s1aq6a if issue == 1
replace s1aq3b = 11 if issue == 1
replace s1aq4b = 11 if issue == 1
replace s1aq6b = 11 if issue == 1

drop issue 


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 156 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if  s1aq1  == 156 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq5 = 40 if s1aq5 == 200 & issue == 1
replace s1aq5 = 50 if s1aq5 == 10 & issue == 1
replace s1aq5 = 50 if s1aq5 == 11 & hid == "3143531411010" & issue == 1
replace s1aq5 = 10 if s1aq5 == 11 & hid == "3080730874004" & issue == 1
replace s1aq3a = 1 if s1aq3a == 511

replace s1aq4a = s1aq3a if issue ==1 
replace s1aq6a = s1aq3a if issue ==1 
replace s1aq3b = 11 if issue == 1
replace s1aq4b = 11 if issue == 1
replace s1aq6b = 11 if issue == 1

drop issue 


///3310533123015
br hid-s1aq8b  if hid =="3310533123015" & s1aq1==156
recode s1aq4a (0=.) if hid =="3310533123015"  & s1aq1==156
recode s1aq7a (.=5) if hid =="3310533123015"  & s1aq1==156
recode s1aq4b (11=.) if hid =="3310533123015"  & s1aq1==156
recode s1aq3b (0=11) if hid =="3310533123015"  & s1aq1==156
recode s1aq7b (.=11) if hid =="3310533123015"  & s1aq1==156



///3110331130013
br hid-s1aq8b  if hid =="3110331130013" & s1aq1==156
recode s1aq7a (3=.) if hid =="3110331130013"  & s1aq1==156
recode s1aq7b (11=.) if hid =="3110331130013"  & s1aq1==156
recode s1aq3b (0=11) if hid =="3110331130013"  & s1aq1==156



///3121231235012
br hid-s1aq8b  if hid =="3121231235012" & s1aq1==156
recode s1aq7a (.=3) if hid =="3121231235012"  & s1aq1==156
recode s1aq4a (3=.) if hid =="3121231235012"  & s1aq1==156
recode s1aq4b (11=.) if hid =="3121231235012"  & s1aq1==156
recode s1aq7b (.=11) if hid =="3121231235012"  & s1aq1==156
recode s1aq3b (0=11) if hid =="3121231235012"  & s1aq1==156
recode s1aq8b (0=.) if hid =="3121231235012"  & s1aq1==156
recode s1aq8a (11=.) if hid =="3121231235012"  & s1aq1==156



///2020120213010
br hid-s1aq8b  if hid =="2020120213010" & s1aq1==156
recode s1aq3a (1=5) if hid =="2020120213010"  & s1aq1==156


****************** 154 bitter tomato **************
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 154 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if s1aq1  == 154 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = s1aq3a if issue == 1
replace s1aq3b = 6 if issue == 1
replace s1aq7b = 6 if issue == 1

drop issue 



br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 154 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if s1aq1  == 154 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = . if issue == 1
replace s1aq8a = . if issue == 1
replace s1aq7b = . if issue == 1
replace s1aq8b = . if issue == 1

replace s1aq3a = 5 if s1aq3a == 6 & hid == "3120731204004" & issue ==1 
replace s1aq3a = 5 if s1aq3a == 6 & hid == "3133631305011" & issue ==1 
replace s1aq3a = 6 if s1aq3a == 3 & hid == "3210532170016" & issue ==1 
replace s1aq3a = 6 if s1aq3a == 66 & hid == "1110111102005" & issue ==1 
replace s1aq3a = 4 if s1aq3a == 2 & hid == "3240232403009" & issue ==1 
replace s1aq3a = 2 if s1aq3a == 11 & hid == "3240432429014" & issue ==1 
replace s1aq3a = 5 if s1aq3a == 17 & hid == "3060130659014" & issue ==1 
replace s1aq3a = 4 if s1aq3a == 6 & hid == "3240432429005" & issue ==1 
replace s1aq3a = 5 if s1aq3a == 6 & hid == "3144131452014" & issue ==1 
replace s1aq3a = 6 if s1aq3a == 7 & hid == "3050330565005" & issue ==1 
replace s1aq3a = 1 if s1aq3a == 7 & hid == "3311033106003" & issue ==1 
replace s1aq3a = 2 if s1aq3a == 3 & hid == "3210932108011" & issue ==1 
replace s1aq3a = 5 if s1aq3a == 7 & hid == "3133931341010" & issue ==1 
replace s1aq5 = 25 if s1aq5 == 257 & hid == "3133931341010" & issue ==1 
replace s1aq5 = 30 if s1aq5 == 3 & hid == "3230132368002" & issue ==1 
replace s1aq3a = 3 if s1aq3a == 6 & hid == "3211032132004" & issue ==1 
replace s1aq3a = 12 if s1aq3a == 3 & hid == "3060130659007" & issue ==1 
replace s1aq3a = 10 if s1aq3a == 2 & hid == "3060530638008" & issue ==1 
replace s1aq5 = 50 if s1aq5 == 2 & hid == "3060530638008" & issue ==1 
replace s1aq3a = 5 if s1aq3a == 6 & hid == "3144131452010" & issue ==1 
replace s1aq3a = 1 if s1aq3a == 2 & hid == "3130231348014" & issue ==1 
replace s1aq3a = 5 if s1aq3a == 4 & hid == "3110331110004" & issue ==1 

replace s1aq4a = s1aq3a if issue == 1
replace s1aq6a = s1aq3a if issue == 1
replace s1aq3b = 6 if issue == 1
replace s1aq4b = 6 if issue == 1
replace s1aq6b = 6 if issue == 1

drop issue 


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 154 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if s1aq1  == 154 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = . if issue == 1
replace s1aq8a = . if issue == 1
replace s1aq7b = . if issue == 1
replace s1aq8b = . if issue == 1

replace s1aq5 = 60 if s1aq5 == 1 & issue == 1
replace s1aq5 = 10 if s1aq5 == 11 & issue == 1
replace s1aq4a = 1 if s1aq4a == 10 & issue == 1
replace s1aq3a = s1aq4a if issue ==1
replace s1aq6a = s1aq4a if issue ==1

replace s1aq3b = 6 if issue == 1
replace s1aq4b = 6 if issue == 1
replace s1aq6b = 6 if issue == 1


drop issue 


///3050330565004
br hid-s1aq8b  if hid =="3050330565004" & s1aq1==154
recode s1aq7a (.=7) if hid =="3050330565004"  & s1aq1==154
recode s1aq7b (.=6) if hid =="3050330565004"  & s1aq1==154
recode s1aq3b (0=6) if hid =="3050330565004"  & s1aq1==154


///3222832216007
br hid-s1aq8b  if hid =="3222832216007" & s1aq1==154
recode s1aq7a (.=7) if hid =="3222832216007"  & s1aq1==154
recode s1aq7b (.=6) if hid =="3222832216007"  & s1aq1==154
recode s1aq3b (0=6) if hid =="3222832216007"  & s1aq1==154


///3330433304006
br hid-s1aq8b  if hid =="3330433304006" & s1aq1==154
recode s1aq7a (14=.) if hid =="3330433304006"  & s1aq1==154
recode s1aq7b (6=.) if hid =="3330433304006"  & s1aq1==154
recode s1aq3a (14=6) if hid =="3330433304006"  & s1aq1==154
recode s1aq3b (0=6) if hid =="3330433304006"  & s1aq1==154

***************** 150 potato leaves **************
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 150 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq7a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if s1aq1  == 150 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq7a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq5 =  40 if s1aq5 == 10 & issue == 1
replace s1aq3a =  4 if s1aq3a == 6 & issue == 1
replace s1aq3a =  5 if s1aq3a == 15 & issue == 1
replace s1aq3a =  1 if s1aq3a == 11 & issue == 1
replace s1aq3a =  2 if s1aq3a == 10 & issue == 1

replace s1aq4a = s1aq3a if issue == 1
replace s1aq6a = s1aq3a if issue == 1
replace s1aq3b = 11 if issue == 1
replace s1aq4b = 11 if issue == 1
replace s1aq6b = 11 if issue == 1

drop issue 


///3310333128014
br hid-s1aq8b  if hid =="3310333128014" & s1aq1==150
recode s1aq8a (11=4) if hid =="3310333128014"  & s1aq1==150
recode s1aq8b (0=11) if hid =="3310333128014"  & s1aq1==150
recode s1aq3b (0=11) if hid =="3310333128014"  & s1aq1==150


************** 152 small pepper fresh ******************
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 152 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq7a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if  s1aq1  == 152 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq7a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq3a = 1 if s1aq3a == 11 & hid == "3080730851002" & issue == 1
replace s1aq3a = 7 if s1aq3a == 11 & hid == "3321433202004" & issue == 1
replace s1aq3a = 3 if s1aq3a == 25 & issue == 1
replace s1aq3a = 1 if s1aq3a == 2 & issue == 1
replace s1aq5 = 35 if s1aq5 == 9 & issue == 1
replace s1aq5 = 15 if s1aq5 == 6 & issue == 1

replace s1aq4a = s1aq3a if issue == 1
replace s1aq6a = s1aq3a if issue == 1
replace s1aq3b = 11 if issue == 1
replace s1aq4b = 11 if issue == 1
replace s1aq6b = 11 if issue == 1

drop issue 


///3330133313002
br hid-s1aq8b  if hid =="3330133313002" & s1aq1==152
recode s1aq8a (14=.) if hid =="3330133313002"  & s1aq1==152
recode s1aq7a (14=.) if hid =="3330133313002"  & s1aq1==152
recode s1aq8b (6=.) if hid =="3330133313002"  & s1aq1==152
recode s1aq7b (1=.) if hid =="3330133313002"  & s1aq1==152
recode s1aq3b (0=11) if hid =="3330133313002"  & s1aq1==152
recode s1aq5 (14=35) if hid =="3330133313002"  & s1aq1==152



///3320733231010
br hid-s1aq8b  if hid =="3320733231010" & s1aq1==152
recode s1aq6a (.=7) if hid =="3320733231010"  & s1aq1==152
recode s1aq6b (.=11) if hid =="3320733231010"  & s1aq1==152
recode s1aq3b (0=11) if hid =="3320733231010"  & s1aq1==152



*************** 164 sorrel *******************
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 146 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq7a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if s1aq1  == 146 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq7a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.


replace s1aq5 = 15 if s1aq5 == 3 & issue == 1
replace s1aq5 = 5 if s1aq5 == 11 & issue == 1
replace s1aq5 = 15 if s1aq5 == 153 & issue == 1
replace s1aq5 = 20 if s1aq5 == 30 & issue == 1
replace s1aq3a = 4 if s1aq3a == 14 & issue == 1
replace s1aq3a = 3 if s1aq3a == 311 & issue == 1
replace s1aq3a = 3 if s1aq3a == 33 & issue == 1
replace s1aq3a = 4 if s1aq3a == 411 & issue == 1

replace s1aq4a = s1aq3a if issue == 1
replace s1aq6a = s1aq3a if issue == 1

replace s1aq3b = 11 if issue == 1
replace s1aq4b = 11 if issue == 1
replace s1aq6b = 11 if issue == 1

drop issue 


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 146 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if s1aq1  == 146 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = s1aq3a if s1aq7a == . & issue == 1
replace s1aq3a = s1aq7a if issue == 1

replace s1aq3b = 11 if issue == 1 
replace s1aq7b = 11 if issue == 1 

drop issue 


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 146 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if s1aq1  == 146 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq4a = s1aq3a if issue == 1
replace s1aq6a = s1aq3a if issue == 1

replace s1aq3b = 11 if issue == 1
replace s1aq7b = 11 if issue == 1

drop issue 


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 146 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if s1aq1  == 146 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = . if issue == 1
replace s1aq7b = . if issue == 1
replace s1aq5 = 15 if s1aq5 == 3 & issue == 1
replace s1aq5 = 5 if s1aq5 == 11 & hid == "2340123436013" & issue == 1
replace s1aq5 = 10 if s1aq5 == 5 & hid == "3143531402004" & issue == 1

replace s1aq4a = s1aq3a if issue == 1
replace s1aq6a = s1aq3a if issue == 1

replace s1aq3b = 11 if issue == 1
replace s1aq4b = 11 if issue == 1
replace s1aq6b = 11 if issue == 1

drop issue 


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 146 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a==. & s1aq7a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if s1aq1  == 146 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a==. & s1aq7a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq8a = . if issue == 1
replace s1aq8b = . if issue == 1
replace s1aq5 = 10 if s1aq5 == 11 & issue == 1

replace s1aq4a = s1aq3a if issue == 1
replace s1aq6a = s1aq3a if issue == 1
replace s1aq3b = 11 if issue == 1
replace s1aq4b = 11 if issue == 1
replace s1aq6b = 11 if issue == 1

drop issue 


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 146 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if s1aq1  == 146 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = . if issue == 1
replace s1aq7b = . if issue == 1

replace s1aq4a = s1aq3a if issue == 1 
replace s1aq6a = s1aq3a if issue == 1 
replace s1aq3b = 11 if issue == 1

drop issue 


///3321433202007
br hid-s1aq8b  if hid =="3321433202007" & s1aq1==146
recode s1aq6a (23=.) if hid =="3321433202007"  & s1aq1==146
recode s1aq6b (11=.) if hid =="3321433202007"  & s1aq1==146
recode s1aq7a (3=4) if hid =="3321433202007"  & s1aq1==146
recode s1aq3b (0=11) if hid =="3321433202007"  & s1aq1==146


************* 145 lettuce *********************
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 145 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if s1aq1  == 145 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = . if issue == 1
replace s1aq7b = . if issue == 1
replace s1aq6a = 1 if s1aq6a == 11 & issue == 1
replace s1aq5 = 30 if s1aq5 == 180 & issue == 1
replace s1aq5 = 10 if s1aq5 == 100 & issue == 1
replace s1aq5 = 5 if s1aq5 == 15 & issue == 1

replace s1aq3a = s1aq6a if issue == 1
replace s1aq4a = s1aq6a if issue == 1

replace s1aq3b = 11 if issue == 1
replace s1aq4b = 11 if issue == 1
replace s1aq6b = 11 if issue == 1

drop issue 


///3330133313009
br hid-s1aq8b  if hid =="3330133313009" & s1aq1==145
recode s1aq7a (18=.) if hid =="3330133313009"  & s1aq1==145
recode s1aq7b (11=.) if hid =="3330133313009"  & s1aq1==145
recode s1aq3a (18=1) if hid =="3330133313009"  & s1aq1==145
recode s1aq4a (11=1) if hid =="3330133313009"  & s1aq1==145
recode s1aq6a (11=1) if hid =="3330133313009"  & s1aq1==145
recode s1aq3b (0=11) if hid =="3330133313009"  & s1aq1==145



///3320333211004
br hid-s1aq8b  if hid =="3320333211004" & s1aq1==145
recode s1aq6a (11=.) if hid =="3320333211004"  & s1aq1==145
recode s1aq6b (11=.) if hid =="3320333211004"  & s1aq1==145
recode s1aq3b (0=11) if hid =="3320333211004"  & s1aq1==145



///2410124101006
br hid-s1aq8b  if hid =="2410124101006" & s1aq1==145
recode s1aq6a (.=4) if hid =="2410124101006"  & s1aq1==145
recode s1aq6b (.=11) if hid =="2410124101006"  & s1aq1==145
recode s1aq3b (0=11) if hid =="2410124101006"  & s1aq1==145



************** 144 spinarch *******************
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 144 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if s1aq1  == 144 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = . if issue == 1
replace s1aq7b = . if issue == 1
replace s1aq8a = . if issue == 1
replace s1aq8b = . if issue == 1

replace s1aq3a = 2 if s1aq3a == 6 & hid == "3060530638015" & issue ==1 
replace s1aq5 = 60 if s1aq5 == 6 & hid == "2230122310004" & issue ==1 
replace s1aq5 = 30 if s1aq5 == 6 & hid == "3120731204002" & issue ==1 
replace s1aq5 = 30 if s1aq5 == 10 & issue ==1 
replace s1aq4a = s1aq3a if issue == 1
replace s1aq6a = s1aq3a if issue == 1

replace s1aq3b = 11 if issue == 1

drop issue 


////3040130466008
br hid-s1aq8b  if hid =="3040130466008" & s1aq1==144
recode s1aq6a (.=4) if hid =="3040130466008"  & s1aq1==144
recode s1aq6b (.=11) if hid =="3040130466008"  & s1aq1==144
recode s1aq3b (0=11) if hid =="3040130466008"  & s1aq1==144



///2410124101006
br hid-s1aq8b  if hid =="2410124101006" & s1aq1==144
recode s1aq6a (.=10) if hid =="2410124101006"  & s1aq1==144
recode s1aq6b (.=11) if hid =="2410124101006"  & s1aq1==144
recode s1aq3b (0=11) if hid =="2410124101006"  & s1aq1==144



///3320433220016
br hid-s1aq8b  if hid =="3320433220016" & s1aq1==144
recode s1aq6a (11=.) if hid =="3320433220016"  & s1aq1==144
recode s1aq4a (0=.) if hid =="3320433220016"  & s1aq1==144
recode s1aq6b (0=.) if hid =="3320433220016"  & s1aq1==144
recode s1aq4b (11=.) if hid =="3320433220016"  & s1aq1==144
recode s1aq3b (0=11) if hid =="3320433220016"  & s1aq1==144




br  hid s1aq2 s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b tot_consumed if s1aq1==164 & s1aq3a!=tot_consumed & s1aq3a!=.

********************************1010110103010
replace s1aq5 = . if hid=="1010110103010" & s1aq1==164 
replace s1aq3a = 5 if hid=="1010110103010" & s1aq1==164 
replace s1aq3b= 1 if hid=="1010110103010" & s1aq1==164 


gen issue = 3  if s1aq1  == 164 & s1aq5==120
replace s1aq3a = 3 if issue == 3
replace s1aq3b = 1 if issue == 3
replace s1aq4a = 3 if issue == 3
replace s1aq4b = 1 if issue == 3
replace s1aq6a = 3 if issue == 3
replace s1aq6b = 1 if issue == 3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3  
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3  


drop issue
gen issue = 3  if s1aq1  == 164 & s1aq5==10
replace s1aq3a = 1 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 1 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 1 if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3  
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3  

drop issue
gen issue = 3  if s1aq1  == 164 & (s1aq5==80|s1aq5==800)
replace s1aq3a = 4 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 4 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 4 if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3  
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3  
replace s1aq5 = 80 if issue == 3  

drop issue
gen issue = 3  if s1aq1  == 164 & (s1aq5==60|s1aq5==600)
replace s1aq3a = 6 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 6 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 6 if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3  
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3  
replace s1aq5 = 60 if issue == 3  

drop issue
gen issue = 3  if s1aq1  == 164 & s1aq5==140
replace s1aq3a = 14 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 14 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 14 if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3  
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3  

drop issue
gen issue = 3  if s1aq1  == 164 & (s1aq5==30|s1aq5==35|s1aq5==350)
replace s1aq3a = 1 if issue == 3
replace s1aq3b = 1 if issue == 3
replace s1aq4a = 1 if issue == 3
replace s1aq4b = 1 if issue == 3
replace s1aq6a = 1 if issue == 3
replace s1aq6b = 1 if issue == 3
replace s1aq5 = . if hid=="3221532255016" & s1aq1==164 

drop issue
gen issue = 3  if s1aq1  == 164 & (s1aq5==50|s1aq5==250|s1aq5==500)
replace s1aq3a = 5 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 5 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 5 if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3  
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3  
replace s1aq5 = 50 if issue == 3  

drop issue
gen issue = 3  if s1aq1  == 164 & (s1aq5==400|s1aq5==40)
replace s1aq3a = 4 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 4 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 4 if issue == 3
replace s1aq6b = 11 if issue == 3

drop issue
gen issue = 3  if s1aq1  == 164 & s1aq5==70
replace s1aq3a = 7 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 7 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 7 if issue == 3
replace s1aq6b = 11 if issue == 3

drop issue
gen issue = 3  if s1aq1  == 164 & s1aq5==75
replace s1aq3a = 2.5 if issue == 3
replace s1aq3b = 1 if issue == 3
replace s1aq4a = 2.5 if issue == 3
replace s1aq4b = 1 if issue == 3
replace s1aq6a = 2.5 if issue == 3
replace s1aq6b = 1 if issue == 3
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3  

drop issue
gen issue = 3  if s1aq1  == 164 & (s1aq5==450|s1aq5==4521|s1aq5==45)
replace s1aq3a = 1.5 if issue == 3
replace s1aq3b = 1 if issue == 3
replace s1aq4a = 1.5 if issue == 3
replace s1aq4b = 1 if issue == 3
replace s1aq6a = 1.5 if issue == 3
replace s1aq6b = 1 if issue == 3
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3  
replace s1aq5 = 45 if issue == 3  


drop issue
gen issue = 3  if s1aq1  == 164 & s1aq5==20
replace s1aq3a = 2 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 2 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 2 if issue == 3
replace s1aq6b = 11 if issue == 3

drop issue
gen issue = 3  if s1aq1  == 164 & s1aq5==25
replace s1aq3a = 5 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 5 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 5 if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3  


*************************1020110205004, 3110231139008, 3230232347007
replace s1aq7a=. if  (hid=="1020110205004"|hid== "3110231139008"|hid=="3230232347007") & s1aq1==164 
replace s1aq7b=. if  (hid=="1020110205004"|hid== "3110231139008"|hid=="3230232347007") & s1aq1==164 

replace s1aq5 = . if hid=="2410124101006" & s1aq1==164 

*************************3320333211003,3321433202010, 
replace s1aq6a=. if  (hid=="3320333211003"|hid== "3321433202010") & s1aq1==164 
replace s1aq6b=. if  (hid=="3320333211003"|hid== "3321433202010") & s1aq1==164 

*******************2410124101006, 2010120117008
replace s1aq4a=. if  (hid=="2410124101006"|hid== "2010120117008") & s1aq1==164 
replace s1aq4b=. if  (hid=="2410124101006"|hid== "2010120117008") & s1aq1==164 


drop issue
gen issue = 3  if s1aq1  == 164 & s1aq5==. & s1aq3a!=. & s1aq3b==0 & s1aq4a!=. & s1aq4b!=. & s1aq6a==. & s1aq6b==. & s1aq7a==. & s1aq7b ==. & s1aq8a==. & s1aq8b==.
replace s1aq3b = s1aq4b if issue == 3
replace s1aq4a = s1aq3a if issue == 3
replace s1aq6a = s1aq3a if issue == 3
replace s1aq6b = s1aq4b if issue == 3

***********************1020110205007, 1020110208015
replace s1aq3a=5 if  (hid=="1020110205007"|hid=="1020110208015") & s1aq1==164 

drop issue
gen issue = 3  if s1aq1  == 164 & (s1aq5==. & s1aq3a!=. & s1aq3b==0 & s1aq4a==. & s1aq4b==. & s1aq6a==. & s1aq6b==. & s1aq7a==. & s1aq7b ==. & s1aq8a==. & s1aq8b==.)
replace s1aq3b = 11 if issue == 3
replace s1aq7a = s1aq3a if issue == 3
replace s1aq7b = 11 if issue == 3


********************2420224209005, 2340123412007, 2340123412010, 1220112208007
replace s1aq3b=1 if  (hid=="2420224209005"|hid== "2340123412007"|hid=="2340123412010"|hid=="1220112208007") & s1aq1==164 
replace s1aq7b=1 if  (hid=="2420224209005"|hid== "2340123412007"|hid=="2340123412010"|hid=="1220112208007") & s1aq1==164 

**********************************************************************
******************************RED BIG PEPPER
br  hid s1aq2 s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b tot_consumed if s1aq1==158 & s1aq3a!=tot_consumed & s1aq3a!=.

drop issue
gen issue = 3  if s1aq1  == 158 & (s1aq5==15|s1aq5==150)
replace s1aq3a = 3 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 3 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 3 if issue == 3
replace s1aq6b = 11 if issue == 3


*************3060530638008
replace s1aq5 = 25  if hid =="3060530638008" & s1aq1  == 158

drop issue
gen issue = 3  if s1aq1  == 158 & (s1aq5==25|s1aq5==50)
replace s1aq3a = 5 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 5 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 5 if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3  
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3  

drop issue
gen issue = 3  if s1aq1  == 158 & s1aq5==100
replace s1aq3a = 1 if issue == 3
replace s1aq3b = 9 if issue == 3

drop issue
gen issue = 3  if s1aq1  == 158 & s1aq5==30
replace s1aq3a = 3 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 3 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 3 if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3  

drop issue
gen issue = 3  if s1aq1  == 158 & s1aq5==10
replace s1aq3a = 2 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 2 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 2 if issue == 3
replace s1aq6b = 11 if issue == 3


replace s1aq5 = 35  if (hid =="3050230524006"|hid=="3230632337010") & s1aq1  == 158

drop issue
gen issue = 3  if s1aq1  == 158 & s1aq5==35
replace s1aq3a = 7 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 7 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 7 if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3  
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3  

***********************2230122330012
replace s1aq5 = 20  if hid =="2230122330012" & s1aq1  == 158

drop issue
gen issue = 3  if s1aq1  == 158 & s1aq5==20
replace s1aq3a = 4 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 4 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 4 if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3  

*******************1110111112014
replace s1aq7b = 11 if hid== "1110111112014" & s1aq1  == 158
replace s1aq3a = 4  if hid== "1110111112014" & s1aq1  == 158

drop issue
gen issue = 3  if s1aq1  == 158 & (s1aq5==70|s1aq5==14)
replace s1aq3a = 7 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 7 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 7 if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3  
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3
replace s1aq5 = 70  if hid =="3240232403002" & s1aq1  == 158

drop issue
gen issue = 3  if s1aq1  == 158 & s1aq5==250
replace s1aq3a = 6 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 6 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 6 if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3  
replace s1aq5 = . if issue == 3  

drop issue
gen issue = 3  if s1aq1  == 158 & s1aq5==28
replace s1aq3a = 14 if issue == 3
replace s1aq3b = 6  if issue == 3
replace s1aq4a = 14 if issue == 3
replace s1aq4b = 6  if issue == 3
replace s1aq6a = 14 if issue == 3
replace s1aq6b = 6  if issue == 3


**********************1220112208006, 1020110205001, 2320123251004, 1220112208005, 2220122208014, 3144131452014, 2010120117003
replace s1aq5 = 20000  if (hid =="1220112208006"|hid=="1020110205001"|hid=="2320123251004"|hid=="1220112208005") & s1aq1  == 158
replace s1aq5 = 20000  if (hid =="2220122208014"|hid=="3144131452014"|hid=="2010120117003") & s1aq1  == 158

replace s1aq3a = 2  if hid =="2320123251004" & s1aq1  == 158

drop issue
gen issue = 3  if s1aq1  == 158 & s1aq5==20000
replace s1aq3b = 11 if issue == 3
replace s1aq7a =  s1aq3a if issue == 3
replace s1aq7b = 11 if issue == 3
replace s1aq4a = . if issue == 3
replace s1aq4b = . if issue == 3
replace s1aq5 = . if issue == 3  


******************************************************************************************************
***********************************PUMPKIN
br  hid s1aq2 s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b tot_consumed if s1aq1==157 & s1aq3a!=tot_consumed & s1aq3a!=.

drop issue 
gen issue = 3  if s1aq1  == 157 & s1aq5==25
replace s1aq3a = 5 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 5 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 5 if issue == 3
replace s1aq6b = 6 if issue == 3

drop issue 
gen issue = 3  if s1aq1  == 157 & s1aq5==15
replace s1aq3a = 3 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 3 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 3 if issue == 3
replace s1aq6b = 6 if issue == 3

********************************************************
***************************Garden Eggs
br  hid s1aq2 s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b tot_consumed if s1aq1==155 & s1aq3a!=tot_consumed & s1aq3a!=.

*******************3090230919013
replace s1aq5 = 25  if hid =="3090230919013" & s1aq1  == 155

drop issue 
gen issue = 3  if s1aq1  == 155 & s1aq5==25
replace s1aq3a = 5 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 5 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 5 if issue == 3
replace s1aq6b = 6 if issue == 3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3

replace s1aq5 = 35  if (hid =="3222432230016"|hid=="3081830829010"|hid=="3240432429005") & s1aq1  == 155
drop issue 
gen issue = 3  if s1aq1  == 155 & s1aq5==35
replace s1aq3a = 7 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 7 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 7 if issue == 3
replace s1aq6b = 6 if issue == 3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3

drop issue 
gen issue = 3  if s1aq1  == 155 & s1aq5==30
replace s1aq3a = 3 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 3 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 3 if issue == 3
replace s1aq6b = 6 if issue == 3


drop issue 
gen issue = 3  if s1aq1  == 155 & s1aq5==20
replace s1aq3a = 4 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 4 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 4 if issue == 3
replace s1aq6b = 6 if issue == 3


*************************3320433220010, 3050330585010, 1220112208005, 2010120117003, 1220112208006

replace s1aq5 = 20000  if (hid =="3320433220010"|hid=="3050330585010"|hid=="1220112208005"|hid=="2010120117003"|hid=="1220112208006") & s1aq1  == 155
drop issue
gen issue = 3  if s1aq1  == 155 & s1aq5==20000
replace s1aq3b = 6 if issue == 3
replace s1aq7a =  s1aq3a if issue == 3
replace s1aq7b = 6 if issue == 3
replace s1aq4a = . if issue == 3
replace s1aq4b = . if issue == 3
replace s1aq5 = . if issue == 3  


***************************************************************
***************** Tomato Fresh
br  hid s1aq2 s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b tot_consumed if s1aq1==153 & s1aq3a!=tot_consumed & s1aq3a!=.
 
drop issue
gen issue = 3  if s1aq1  == 153 & s1aq5==30
replace s1aq3a = 3 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 3 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 3 if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3

drop issue
gen issue = 3  if s1aq1  == 153 & (s1aq5==50|s1aq5==25)
replace s1aq3a = 5 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 5 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 5 if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3

drop issue
gen issue = 3  if s1aq1  == 153 & s1aq5==20
replace s1aq3a = 2 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 2 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 2 if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3

drop issue
gen issue = 3  if s1aq1  == 153 & (s1aq5==11|s1aq5==15)
replace s1aq3a = 2  if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 2  if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 2  if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq5 = .  if issue ==  3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3


drop issue
gen issue = 3  if s1aq1  == 153 & (s1aq5==5|s1aq5==10|s1aq5==1)
replace s1aq3a = 1 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 1 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 1 if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3


drop issue
gen issue = 3  if s1aq1  == 153 & (s1aq5==40|s1aq5==4)
replace s1aq3a = 4 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 4 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 4 if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3

drop issue
gen issue = 3  if s1aq1  == 153 & s1aq5==70
replace s1aq3a = 7 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 7 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 7 if issue == 3
replace s1aq6b = 11 if issue == 3

****************1020110205001, 1220112208005, 1220112208006, 3050330585010, 3311633110008, 3320433220002, 3320433220016

replace s1aq5 = 20000  if (hid =="1020110205001"|hid=="1220112208005"|hid=="1220112208006"|hid=="3050330585010") & s1aq1  == 153
replace s1aq5 = 20000  if (hid =="3311633110008"|hid=="3320433220002"|hid=="3320433220016") & s1aq1  == 153

drop issue
gen issue = 3  if s1aq1  == 153 & s1aq5==20000
replace s1aq3b = 11 if issue == 3
replace s1aq7a = s1aq3a if issue == 3
replace s1aq7b = 11 if issue == 3
replace s1aq6a =. if issue == 3
replace s1aq6b = . if issue == 3
replace s1aq4a = . if issue == 3
replace s1aq4b = . if issue == 3
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3
replace s1aq5 = . if issue == 3

**************************************************************************147.  Parsley
drop issue
gen issue = 3  if s1aq1  == 147 & s1aq5==11
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 3 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 3 if issue == 3
replace s1aq6b = 6 if issue == 3
replace s1aq5 = 15 if issue == 3
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3

drop issue
gen issue = 3  if s1aq1  == 147 & s1aq5==35
replace s1aq3b = 6 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 7 if issue == 3
replace s1aq6b = 6 if issue == 3

**************************************************************************148 CASSAVA LEAVES
drop issue
gen issue = 3  if s1aq1  == 148 & s1aq5==10
replace s1aq3b = 6 if issue == 3
replace s1aq3a = 2 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6b = 6 if issue == 3

drop issue
gen issue = 3  if s1aq1  == 148 & s1aq5==20
replace s1aq3b = 6 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 4 if issue == 3
replace s1aq6b = 6 if issue == 3

********************************************************************************
*************************ONION LEAVES
br  hid s1aq2 s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b tot_consumed if s1aq1==149 & s1aq3a!=tot_consumed & s1aq3a!=.
drop issue 
gen issue = 3  if s1aq1  == 149 & s1aq5==10
replace s1aq3a = 3 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 3 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 3 if issue == 3
replace s1aq6b = 6 if issue == 3


drop issue 
gen issue = 3  if s1aq1  == 149 & (s1aq5==20|s1aq5==40)
replace s1aq3a = 4 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 4 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 4  if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq7a = .  if issue == 3
replace s1aq7b = . if issue == 3
replace s1aq8a = .  if issue == 3
replace s1aq8b = . if issue == 3

drop issue 
gen issue = 3  if s1aq1  == 149 & s1aq5==15
replace s1aq3a = 3 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 3 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 3  if issue == 3
replace s1aq6b = 11 if issue == 3


drop issue 
gen issue = 3  if s1aq1  == 149 & s1aq5==5
replace s1aq3a = 1 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 1 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 1  if issue == 3
replace s1aq6b = 11 if issue == 3

drop issue 
gen issue = 3  if s1aq1  == 149 & s1aq5==3
replace s1aq3a = 1 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 1 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 1  if issue == 3
replace s1aq6b = 6 if issue == 3


drop issue 
gen issue = 3  if s1aq1  == 149 & s1aq5==21
replace s1aq3a = 7 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 7 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 7  if issue == 3
replace s1aq6b = 6 if issue == 3
replace s1aq7a = .  if issue == 3
replace s1aq7b = . if issue == 3


replace s1aq5 = 50 if hid =="3230132368016" & s1aq1  == 149

drop issue 
gen issue = 3  if s1aq1  == 149 & (s1aq5==25|s1aq5==50)
replace s1aq3a = 5 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 5 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 5  if issue == 3
replace s1aq6b = 11 if issue == 3
 
 
drop issue 
gen issue = 3  if s1aq1  == 149 & s1aq5==35
replace s1aq3a = 7 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 7 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 7  if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq8a = .  if issue == 3
replace s1aq8b = . if issue == 3

**********************3320433220016
replace s1aq4a = . if hid =="3320433220016" & s1aq1  == 149
replace s1aq4b = . if hid =="3320433220016" & s1aq1  == 149
replace s1aq6a = . if hid =="3320433220016" & s1aq1  == 149
replace s1aq6b = . if hid =="3320433220016" & s1aq1  == 149
replace s1aq3b = 11 if hid =="3320433220016" & s1aq1  == 149

*************************2010120117003, 1220112208005, 1220112208006
replace s1aq5 = 20000 if (hid =="2010120117003"|hid=="1220112208005"|hid=="1220112208006") & s1aq1  == 149
replace s1aq3b = 11 if (hid =="2010120117003"|hid=="1220112208005") & s1aq1  == 149
replace s1aq3b = 6 if hid =="1220112208006" & s1aq1  == 149

drop issue 
gen issue = 3  if s1aq1  == 149 & s1aq5==20000
replace s1aq4a = s1aq3a if issue == 3
replace s1aq4b = s1aq3b if issue == 3
replace s1aq6a = s1aq3a  if issue == 3
replace s1aq6b = s1aq3b if issue == 3
replace s1aq5 = .  if issue == 3

********************************************************************************
*************************POTATO LEAVES
br  hid s1aq2 s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b tot_consumed if s1aq1==150 & s1aq3a!=tot_consumed & s1aq3a!=.
drop issue 
gen issue = 3  if s1aq1  == 150 & s1aq5==10
replace s1aq3a = 3 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 3 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 3 if issue == 3
replace s1aq6b = 6 if issue == 3


drop issue 
gen issue = 3  if s1aq1  == 150 & s1aq5==5
replace s1aq3a = 1 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 1 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 1 if issue == 3
replace s1aq6b = 6 if issue == 3

drop issue 
gen issue = 3  if s1aq1  == 150 & s1aq5==40
replace s1aq3a = 4 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 4 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 4 if issue == 3
replace s1aq6b = 11 if issue == 3

drop issue 
gen issue = 3  if s1aq1  == 150 & s1aq5==30
replace s1aq3a = 3 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 3 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 3 if issue == 3
replace s1aq6b = 11 if issue == 3

drop issue 
gen issue = 3  if s1aq1  == 150 & s1aq5==20
replace s1aq3a = 2 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 2 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 2 if issue == 3
replace s1aq6b = 11 if issue == 3

*************************3310333128014
replace s1aq8a = 4 if hid =="3310333128014" & s1aq1  == 150
replace s1aq8b = 11 if hid =="3310333128014" & s1aq1  == 150
replace s1aq3b = 11 if hid =="3310333128014" & s1aq1  == 150


********************************************************************************
*************************CABBAGES
br  hid s1aq2 s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b tot_consumed if s1aq1==143 & s1aq3a!=tot_consumed & s1aq3a!=.
drop issue 
gen issue = 3  if s1aq1  == 143 & (s1aq5==10|s1aq5==14|s1aq5==50)
replace s1aq3a = 2 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 2 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 2 if issue == 3
replace s1aq6b = 6 if issue == 3
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3

**********************3320433220009 ,2320123228012
replace s1aq5 = s1aq4a  if (hid =="3320433220009"|hid=="2320123228012") & s1aq1  == 143


drop issue 
gen issue = 3  if s1aq1  == 143 & (s1aq5==15|s1aq5==30)
replace s1aq3a = 3 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 3 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 3 if issue == 3
replace s1aq6b = 6 if issue == 3
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3

drop issue 
gen issue = 3  if s1aq1  == 143 & s1aq5==25
replace s1aq3a = 5 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 5 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 5 if issue == 3
replace s1aq6b = 6 if issue == 3
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3

*******************************3133631305011
replace s1aq3a =4 if hid=="3133631305011" & s1aq1  == 143

drop issue 
gen issue = 3  if s1aq1  == 143 & s1aq5==20 
replace s1aq3b = 6 if issue == 3
replace s1aq4a = s1aq3a if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = s1aq3a if issue == 3
replace s1aq6b = 6 if issue == 3
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3

drop issue 
gen issue = 3  if s1aq1  == 143 & s1aq5==60
replace s1aq3a = 4 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 4 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 4 if issue == 3
replace s1aq6b = 6 if issue == 3
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3

*********************************1220112208005, 1120111204012
replace s1aq4a = s1aq3a  if (hid =="1220112208005"|hid=="1120111204012") & s1aq1  == 143
replace s1aq4b = 6       if (hid =="1220112208005"|hid=="1120111204012") & s1aq1  == 143
replace s1aq6a = s1aq3a  if (hid =="1220112208005"|hid=="1120111204012") & s1aq1  == 143
replace s1aq6b = 6       if (hid =="1220112208005"|hid=="1120111204012") & s1aq1  == 143
replace s1aq3b = 6       if (hid =="1220112208005"|hid=="1120111204012") & s1aq1  == 143

*******************************151. Other  Leafy or stem vegetables, fresh or chilled  Please Specify
***************3311033102012
replace s1aq3b = 11 if hid =="3311033102012" & s1aq1  == 151
replace s1aq7a = 2  if hid =="3311033102012" & s1aq1  == 151
replace s1aq7b = 11 if hid =="3311033102012" & s1aq1  == 151
replace s1aq4a = .  if hid =="3311033102012" & s1aq1  == 151
replace s1aq4b = .  if hid =="3311033102012" & s1aq1  == 151
replace s1aq6a = .  if hid =="3311033102012" & s1aq1  == 151
replace s1aq6b = .  if hid =="3311033102012" & s1aq1  == 151
replace s1aq5  = .  if hid =="3311033102012" & s1aq1  == 151



tempfile janneh
save `janneh'


*************************************
********** Davies:
*************************************
use revised_task_distribution_dta_file.dta, clear

keep if responsible == 2

**** CODE
sort s1aq1

br



******* 34 Life Goat*****************
///4311543108012
br hid-s1aq8b tot_consumed if hid =="4311543108012"  & s1aq1==34
recode s1aq4b (.=1) if hid =="4311543108012" & s1aq1==34
recode s1aq6a (.=1) if hid =="4311543108012" & s1aq1==34
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 34 & hid == "4311543108012"
replace s1aq4b = 6 if s1aq4b == . & s1aq1 == 34 & hid == "4311543108012"
replace s1aq6b = 6 if s1aq6b == . & s1aq1 == 34 & hid == "4311543108012"


///4021340214011
br hid-s1aq8b tot_consumed if hid =="4021340214011"  & s1aq1==34
recode s1aq6a (.=1) if hid =="4021340214011" & s1aq1==34
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 34 & hid == "4021340214011"
replace s1aq6b = 6 if s1aq6b == . & s1aq1 == 34 & hid == "4021340214011"



br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 37 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.


gen issue = 1 if s1aq1 == 37 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq8a = . if s1aq8a == 3 & hid == "4021340217004" & issue ==1
replace s1aq4a = s1aq3a if hid == "4120441209003" & issue ==1
replace s1aq8a = 1 if s1aq8a ==6 & hid == "4110341105006" & issue ==1 
replace s1aq8a = 1 if s1aq8a ==6 & hid == "4011340112003" & issue ==1 
replace s1aq4b = s1aq3b if issue ==1 
replace s1aq8b = . if s1aq8b == 6 & hid == "4021340217004" & issue ==1
replace s1aq8b = 6 if s1aq8b == 0 & hid == "4110341105006" & issue ==1
replace s1aq8b = 6 if s1aq8b == 0 & hid == "4011340112003" & issue ==1
replace s1aq4a = s1aq7a if hid == "4120441209003" & issue ==1 

drop issue


///3821038204013
br hid-s1aq8b tot_consumed if hid =="3821038204013"  & s1aq1==37
recode s1aq7a (.=1) if hid =="3821038204013" & s1aq1==37
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 37 & hid == "3821038204013"
replace s1aq7b = 6 if s1aq7b == . & s1aq1 == 37 & hid == "3821038204013"


///4120441209003
br hid-s1aq8b tot_consumed if hid =="4120441209003"  & s1aq1==37
recode s1aq3a (6=1) if hid =="4120441209003" & s1aq1==37
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 37 & hid == "4120441209003"
replace s1aq4b = 6 if s1aq4b == 0 & s1aq1 == 37 & hid == "4120441209003"


///4110341105010
br hid-s1aq8b tot_consumed if hid =="4110341105010"  & s1aq1==37
recode s1aq4a (60=6) if hid =="4110341105010" & s1aq1==37
recode s1aq6a (60=.) if hid =="4110341105010" & s1aq1==37
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 37 & hid == "4110341105010"
replace s1aq4b = 6 if s1aq4b == 0 & s1aq1 == 37 & hid == "4110341105010"
replace s1aq6b = . if s1aq6b == . & s1aq1 == 37 & hid == "4110341105010"


///4010240101006
br hid-s1aq8b tot_consumed if hid =="4010240101006"  & s1aq1==38
recode s1aq5 (500=50) if hid =="4010240101006" & s1aq1==38
recode s1aq8a (.=2) if hid =="4010240101006" & s1aq1==38
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 38 & hid == "4010240101006"
replace s1aq8b = 6 if s1aq8b == . & s1aq1 == 38 & hid == "4010240101006"


////3721137209007
br hid-s1aq8b tot_consumed if hid =="3721137209007"  & s1aq1==38
recode s1aq5 (240=20) if hid =="3721137209007" & s1aq1==38
recode s1aq6a (1=2) if hid =="3721137209007" & s1aq1==38
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 38 & hid == "3721137209007"
replace s1aq4b = 6 if s1aq4b == 1 & s1aq1 == 38 & hid == "3721137209007"
replace s1aq6b = 6 if s1aq6b == 1 & s1aq1 == 38 & hid == "3721137209007"


///4210142109013
br hid-s1aq8b tot_consumed if hid =="4210142109013"  & s1aq1==40
recode s1aq3a (16=1) if hid =="4210142109013" & s1aq1==40
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 40 & hid == "4210142109013"



*********** 42 beef and bone **************
///3410834116005// verify price
br hid-s1aq8b tot_consumed if hid =="3410834116005"  & s1aq1==42
recode s1aq6a (.=2) if hid =="3410834116005" & s1aq1==42
replace s1aq3b = 1 if s1aq3b == 0 & s1aq1 == 42 & hid == "3410834116005"
replace s1aq6b = 1 if s1aq6b == . & s1aq1 == 42 & hid == "3410834116005"



///4210242107001
br hid-s1aq8b tot_consumed if hid =="4210242107001"  & s1aq1==42
recode s1aq6a (.=4) if hid =="4210242107001" & s1aq1==42
replace s1aq3b = 1 if s1aq3b == 0 & s1aq1 == 42 & hid == "4210242107001"
replace s1aq6b = 1 if s1aq6b == . & s1aq1 == 42 & hid == "4210242107001"


///3410834116016
br hid-s1aq8b tot_consumed if hid =="3410834116016"  & s1aq1==42
recode s1aq7a (2=.) if hid =="3410834116016" & s1aq1==42
recode s1aq8a (2=.) if hid =="3410834116016" & s1aq1==42
replace s1aq3b = 1 if s1aq3b == 0 & s1aq1 == 42 & hid == "3410834116016"
replace s1aq7b = . if s1aq7b == 1 & s1aq1 == 42 & hid == "3410834116016"
replace s1aq8b = . if s1aq8b == 1 & s1aq1 == 42 & hid == "3410834116016"


///3522535219002
br hid-s1aq8b tot_consumed if hid =="3522535219002"  & s1aq1==42
recode s1aq6a (1=2) if hid =="3522535219002" & s1aq1==42
replace s1aq3b = 1 if s1aq3b == 0 & s1aq1 == 42 & hid == "3522535219002"


///4111241103009
br hid-s1aq8b tot_consumed if hid =="4111241103009"  & s1aq1==42
recode s1aq8a (1=.) if hid =="4111241103009" & s1aq1==42
recode s1aq4a (.=3) if hid =="4111241103009" & s1aq1==42
recode s1aq5 (6=.) if hid =="4111241103009" & s1aq1==42
replace s1aq3b = 1 if s1aq3b == 0 & s1aq1 == 42 & hid == "4111241103009"
replace s1aq8b = . if s1aq8b == 1 & s1aq1 == 42 & hid == "4111241103009"


///3410334105010
br hid-s1aq8b tot_consumed if hid =="3410334105010"  & s1aq1==42
recode s1aq3a (3=3.5) if hid =="3410334105010" & s1aq1==42
replace s1aq3b = 1 if s1aq3b == 0 & s1aq1 == 42 & hid == "3410334105010"


///4510345114006// verify price
br hid-s1aq8b tot_consumed if hid =="4510345114006"  & s1aq1==42
recode s1aq4a (800=8) if hid =="4510345114006" & s1aq1==42
recode s1aq6a (800=4) if hid =="4510345114006" & s1aq1==42
replace s1aq3b = 1 if s1aq3b == 0 & s1aq1 == 42 & hid == "4510345114006"


///4011440105007
br hid-s1aq8b tot_consumed if hid =="4011440105007"  & s1aq1==43
recode s1aq5 (2=.) if hid =="4011440105007" & s1aq1==43
recode s1aq7a (2=.) if hid =="4011440105007" & s1aq1==43
recode s1aq8a (2=.) if hid =="4011440105007" & s1aq1==43
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 43 & hid == "4011440105007"
replace s1aq6b = 6 if s1aq6b == 2 & s1aq1 == 43 & hid == "4011440105007"
replace s1aq7b = . if s1aq7b == 2 & s1aq1 == 43 & hid == "4011440105007"
replace s1aq8b = . if s1aq8b == 2 & s1aq1 == 43 & hid == "4011440105007"


///3820238208009
br hid-s1aq8b tot_consumed if hid =="3820238208009"  & s1aq1==43
recode s1aq3a (10=1) if hid =="3820238208009" & s1aq1==43
recode s1aq6a (10=.) if hid =="3820238208009" & s1aq1==43
replace s1aq3b = 1 if s1aq3b == 0 & s1aq1 == 43 & hid == "3820238208009"
replace s1aq6b = . if s1aq6b == 1 & s1aq1 == 43 & hid == "3820238208009"



****** fixing multiple issues for chicken legs****
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 44 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.


gen issue = 2 if s1aq1  == 44 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq3a = s1aq6a if issue ==2
replace s1aq3b = 1 if s1aq3b == 0 & issue ==2 
replace s1aq3b = s1aq6b if issue ==2

drop issue 



///3610536105005
br hid-s1aq8b tot_consumed if hid =="3610536105005"  & s1aq1==44
recode s1aq4a (200=2) if hid =="3610536105005" & s1aq1==44
recode s1aq6a (200=2) if hid =="3610536105005" & s1aq1==44
replace s1aq3b = 1 if s1aq3b == 0 & s1aq1 == 44 & hid == "3610536105005"


///3820238208015
br hid-s1aq8b tot_consumed if hid =="3820238208015"  & s1aq1==44
recode s1aq6a (1=1.5) if hid =="3820238208015" & s1aq1==44
recode s1aq5 (1.5=150) if hid =="3820238208015" & s1aq1==44
replace s1aq3b = 1 if s1aq3b == 0 & s1aq1 == 44 & hid == "3820238208015"
replace s1aq4b = 1 if s1aq4b == 15 & s1aq1 == 44 & hid == "3820238208015"
replace s1aq6b = 1 if s1aq6b == 0 & s1aq1 == 44 & hid == "3820238208015"


///3710137101001
br hid-s1aq8b tot_consumed if hid =="3710137101001"  & s1aq1==44
recode s1aq4a (200=2) if hid =="3710137101001" & s1aq1==44
recode s1aq6a (200=2) if hid =="3710137101001" & s1aq1==44
recode s1aq5 (1=200) if hid =="3710137101001" & s1aq1==44
replace s1aq3b = 1 if s1aq3b == 0 & s1aq1 == 44 & hid == "3710137101001"


****** 44 chicken legs (fixing multiple issues)**********
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 44 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=s1aq3a & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 3 if s1aq1  == 44 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=s1aq3a & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq3a = s1aq6a if issue == 3
replace s1aq3b = 11 if s1aq3b ==0 & hid == "4111041113014" & issue ==3
replace s1aq6b = s1aq3b if issue ==3

drop issue



///4110741108006
br hid-s1aq8b tot_consumed if hid =="4110741108006"  & s1aq1==44
recode s1aq3a (.1=1) if hid =="4110741108006" & s1aq1==44
recode s1aq6a (.1=1) if hid =="4110741108006" & s1aq1==44
recode s1aq4a (.1=1) if hid =="4110741108006" & s1aq1==44
replace s1aq3b = 1 if s1aq3b == 0 & s1aq1 == 44 & hid == "4110741108006"



///4121141207006
br hid-s1aq8b tot_consumed if hid =="4121141207006"  & s1aq1==44
recode s1aq3a (.1=1) if hid =="4121141207006" & s1aq1==44
recode s1aq6a (.1=1) if hid =="4121141207006" & s1aq1==44
recode s1aq4a (.1=1) if hid =="4121141207006" & s1aq1==44
replace s1aq3b = 1 if s1aq3b == 0 & s1aq1 == 44 & hid == "4121141207006"



///4121141207008
br hid-s1aq8b tot_consumed if hid =="4121141207008"  & s1aq1==44
recode s1aq3a (.1=1) if hid =="4121141207008" & s1aq1==44
recode s1aq6a (.1=1) if hid =="4121141207008" & s1aq1==44
recode s1aq4a (.1=1) if hid =="4121141207008" & s1aq1==44
replace s1aq3b = 1 if s1aq3b == 0 & s1aq1 == 44 & hid == "4121141207008"




********** 45 chicken (local)**********
///3511835102011
br hid-s1aq8b tot_consumed if hid =="3511835102011"  & s1aq1==45
recode s1aq6a (1=.) if hid =="3511835102011" & s1aq1==45
recode s1aq7a (1=6) if hid =="3511835102011" & s1aq1==45
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 45 & hid == "3511835102011"
replace s1aq6b = . if s1aq6b == 6 & s1aq1 == 45 & hid == "3511835102011"


///3511835102015
br hid-s1aq8b tot_consumed if hid =="3511835102015"  & s1aq1==45
recode s1aq7a (6=1) if hid =="3511835102015" & s1aq1==45
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 45 & hid == "3511835102015"
replace s1aq7b = 6 if s1aq7b == 0 & s1aq1 == 45 & hid == "3511835102015"


///3510135113006
br hid-s1aq8b tot_consumed if hid =="3510135113006"  & s1aq1==45
recode s1aq6a (1=.) if hid =="3510135113006" & s1aq1==45
recode s1aq7a (1=6) if hid =="3510135113006" & s1aq1==45
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 45 & hid == "3510135113006"
replace s1aq6b = . if s1aq6b == 6 & s1aq1 == 45 & hid == "3510135113006"



///3820638202006
br hid-s1aq8b tot_consumed if hid =="3820638202006"  & s1aq1==45
recode s1aq7a (200=.) if hid =="3820638202006" & s1aq1==45
recode s1aq3a (2=1) if hid =="3820638202006" & s1aq1==45
recode s1aq5 (2=8) if hid =="3820638202006" & s1aq1==45
replace s1aq3b = 6 if s1aq3b == 1 & s1aq1 == 45 & hid == "3820638202006"
replace s1aq4b = 6 if s1aq4b == 1 & s1aq1 == 45 & hid == "3820638202006"
replace s1aq6b = 6 if s1aq6b == 1 & s1aq1 == 45 & hid == "3820638202006"
replace s1aq7b = . if s1aq7b == 1 & s1aq1 == 45 & hid == "3820638202006"


///3410334106014
br hid-s1aq8b tot_consumed if hid =="3410334106014"  & s1aq1==45
recode s1aq4a (0=2) if hid =="3410334106014" & s1aq1==45
recode s1aq6a (6=2) if hid =="3410334106014" & s1aq1==45
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 45 & hid == "3410334106014"


///4210642110002
br hid-s1aq8b tot_consumed if hid =="4210642110002"  & s1aq1==45
recode s1aq3a (6=1) if hid =="4210642110002" & s1aq1==45
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 45 & hid == "4210642110002"


///3410334110009
br hid-s1aq8b tot_consumed if hid =="3410334110009"  & s1aq1==45
recode s1aq4a (0=.) if hid =="3410334110009" & s1aq1==45
recode s1aq7a (.=1) if hid =="3410334110009" & s1aq1==45
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 45 & hid == "3410334110009"
replace s1aq4b = . if s1aq4b == 6 & s1aq1 == 45 & hid == "3410334110009"
replace s1aq7b = 6 if s1aq7b == . & s1aq1 == 45 & hid == "3410334110009"


///3510935104008
br hid-s1aq8b tot_consumed if hid =="3510935104008"  & s1aq1==45
recode s1aq4a (0=.) if hid =="3510935104008" & s1aq1==45
recode s1aq3a (6=2) if hid =="3510935104008" & s1aq1==45
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 45 & hid == "3510935104008"
replace s1aq4b = . if s1aq4b == 6 & s1aq1 == 45 & hid == "3510935104008"


///4311543131001
br hid-s1aq8b tot_consumed if hid =="4311543131001"  & s1aq1==45
recode s1aq3a (2=3) if hid =="4311543131001" & s1aq1==45
recode s1aq5 (600=60) if hid =="4311543131001" & s1aq1==45
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 45 & hid == "4311543131001"


///3410334106014
br hid-s1aq8b tot_consumed if hid =="3410334106014"  & s1aq1==45
recode s1aq7a (2=.) if hid =="3410334106014" & s1aq1==45
recode s1aq7b (6=.) if hid =="3410334106014" & s1aq1==45
recode s1aq6b (0=6) if hid =="3410334106014" & s1aq1==45


///4011140114004
br hid-s1aq8b tot_consumed if hid =="4011140114004"  & s1aq1==45
recode s1aq7a (1=.) if hid =="4011140114004" & s1aq1==45
recode s1aq7b (1=.) if hid =="4011140114004" & s1aq1==45
recode s1aq6b (1=6) if hid =="4011140114004" & s1aq1==45
recode s1aq4b (1=6) if hid =="4011140114004" & s1aq1==45
recode s1aq3b (0=6) if hid =="4011140114004" & s1aq1==45


///3810838102014
br hid-s1aq8b tot_consumed if hid =="3810838102014"  & s1aq1==45
recode s1aq7a (1=.) if hid =="3810838102014" & s1aq1==45
recode s1aq7b (1=.) if hid =="3810838102014" & s1aq1==45
recode s1aq6b (1=6) if hid =="3810838102014" & s1aq1==45
recode s1aq4b (1=6) if hid =="3810838102014" & s1aq1==45
recode s1aq3b (0=6) if hid =="3810838102014" & s1aq1==45


***************** 47 chicken wings **************
///3810638106002
br hid-s1aq8b tot_consumed if hid =="3810638106002"  & s1aq1==47
recode s1aq6a (1=2) if hid =="3810638106002" & s1aq1==47
recode s1aq5 (200=20) if hid =="3810638106002" & s1aq1==47
replace s1aq3b = 1 if s1aq3b == 0 & s1aq1 == 47 & hid == "3810638106002"


///4021340217004
br hid-s1aq8b tot_consumed if hid =="4021340217004"  & s1aq1==47
recode s1aq7a (.=4) if hid =="4021340217004" & s1aq1==47
replace s1aq3b = 1 if s1aq3b == 0 & s1aq1 == 47 & hid == "4021340217004"
replace s1aq7b = 1 if s1aq7b == . & s1aq1 == 47 & hid == "4021340217004"



******* 48 goat meat**************
////3610236101001
br hid-s1aq8b tot_consumed if hid =="3610236101001"  & s1aq1==48
recode s1aq4a (0=.) if hid =="3610236101001" & s1aq1==48
recode s1aq6a (1=.) if hid =="3610236101001" & s1aq1==48
replace s1aq3b = 1 if s1aq3b == 0 & s1aq1 == 48 & hid == "3610236101001"
replace s1aq6b = . if s1aq6b == 0 & s1aq1 == 48 & hid == "3610236101001"


////3810438110012
br hid-s1aq8b tot_consumed if hid =="3810438110012"  & s1aq1==48
recode s1aq7a (2=.) if hid =="3810438110012" & s1aq1==48
recode s1aq8a (2=.) if hid =="3810438110012" & s1aq1==48
replace s1aq3b = 1 if s1aq3b == 0 & s1aq1 == 48 & hid == "3810438110012"
replace s1aq7b = . if s1aq7b == 2 & s1aq1 == 48 & hid == "3810438110012"
replace s1aq8b = . if s1aq8b == 2 & s1aq1 == 48 & hid == "3810438110012"


*************** 49 beef without bone ****************
///3722237213009
br hid-s1aq8b tot_consumed if hid =="3722237213009"  & s1aq1==49
recode s1aq4a (225=1) if hid =="3722237213009" & s1aq1==49
recode s1aq6a (225=1) if hid =="3722237213009" & s1aq1==49
recode s1aq7a (1=.) if hid =="3722237213009" & s1aq1==49
recode s1aq5 (1=225) if hid =="3722237213009" & s1aq1==49
replace s1aq3b = 1 if s1aq3b == 0 & s1aq1 == 49 & hid == "3722237213009"
replace s1aq7b = . if s1aq7b == 1 & s1aq1 == 49 & hid == "3722237213009"


********* 50 chicken whole frozen *************
////4311043137005
br hid-s1aq8b tot_consumed if hid =="4311043137005"  & s1aq1==50
recode s1aq3a (2=3) if hid =="4311043137005" & s1aq1==50
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 50 & hid == "4311043137005"


///3520435201007
br hid-s1aq8b tot_consumed if hid =="3520435201007"  & s1aq1==50
recode s1aq6a (1=2) if hid =="3520435201007" & s1aq1==50
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 50 & hid == "3520435201007"


*************** 56 corn beef****************
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 56 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a==. & s1aq3a & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 5 if s1aq1  == 56 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a==. & s1aq3a & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq3a = s1aq6a if issue == 5
replace s1aq3b = 12 if s1aq3b == 0 & issue == 5
replace s1aq3b = s1aq6b if issue == 5

drop issue


///3810338108001
br hid-s1aq8b tot_consumed if hid =="3810338108001"  & s1aq1==56
recode s1aq3a (12=1) if hid =="3810338108001" & s1aq1==56
recode s1aq4a (12=1) if hid =="3810338108001" & s1aq1==56
replace s1aq3b = 12 if s1aq3b == 0 & s1aq1 == 56 & hid == "3810338108001"


///4021240209007
br hid-s1aq8b tot_consumed if hid =="4021240209007"  & s1aq1==56
recode s1aq3a (12=1) if hid =="4021240209007" & s1aq1==56
replace s1aq3b = 12 if s1aq3b == 0 & s1aq1 == 56 & hid == "4021240209007"


///4410544103016
br hid-s1aq8b tot_consumed if hid =="4410544103016"  & s1aq1==56
recode s1aq8a (.=2) if hid =="4410544103016" & s1aq1==56
replace s1aq3b = 12 if s1aq3b == 0 & s1aq1 == 56 & hid == "4410544103016"
replace s1aq8b = 12 if s1aq8b == . & s1aq1 == 56 & hid == "4410544103016"


****************** 57 susages *********
///4311543118004
br hid-s1aq8b tot_consumed if hid =="4311543118004"  & s1aq1==57
recode s1aq3a (12=1) if hid =="4311543118004" & s1aq1==57
recode s1aq4a (12=1) if hid =="4311543118004" & s1aq1==57
replace s1aq3b = 5 if s1aq3b == 0 & s1aq1 == 57 & hid == "4311543118004"
replace s1aq4b = 5 if s1aq4b == 12 & s1aq1 == 57 & hid == "4311543118004"
replace s1aq6b = 5 if s1aq6b == 12 & s1aq1 == 57 & hid == "4311543118004"


***************** 59 fresh bonga ************
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 59 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq7a!=. & s1aq8a!=. & s1aq3a & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 6 if s1aq1  == 59 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq7a!=. & s1aq8a!=. & s1aq3a & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a =. if issue == 6
replace s1aq7a = s1aq8a if issue == 6
replace s1aq7b =. if issue == 6
replace s1aq7b = s1aq8b if issue == 6

drop issue 


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 59 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq7a!=. & s1aq3a & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 7 if s1aq1  == 59 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq7a!=. & s1aq3a & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a =. if s1aq7a ==2 & issue == 7
replace s1aq7a = s1aq8a if s1aq8a == 2 & issue == 7
replace s1aq7a =. if s1aq7a == 5 & issue  ==7
replace s1aq7a =. if s1aq7a ==90 & issue == 7
replace s1aq7a =. if s1aq7a == 11 & issue == 7 
replace s1aq8a=. if s1aq8a == 11 & issue == 7

replace s1aq7b =. if s1aq7b ==0 & issue == 7
replace s1aq7b = s1aq8b if s1aq8b == 0 & issue == 7
replace s1aq7b =. if s1aq7b == 6 & issue == 7
replace s1aq7b =. if s1aq7b == 2 & issue == 7
replace s1aq7b = s1aq8b if s1aq8b ==2 & issue == 7

drop issue


///3520735220001
br hid-s1aq8b tot_consumed if hid =="3520735220001"  & s1aq1==59
recode s1aq8a (2=.) if hid =="3520735220001" & s1aq1==59
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 59 & hid == "3520735220001"
replace s1aq7b = . if s1aq7b == 0 & s1aq1 == 59 & hid == "3520735220001"
replace s1aq8b = . if s1aq8b == 0 & s1aq1 == 59 & hid == "3520735220001"


///3810438110012
br hid-s1aq8b tot_consumed if hid =="3810438110012"  & s1aq1==59
recode s1aq8a (2=.) if hid =="3810438110012" & s1aq1==59
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 59 & hid == "3520735220001"
replace s1aq7b = . if s1aq7b == 2 & s1aq1 == 59 & hid == "3810438110012"
replace s1aq8b = . if s1aq8b == 2 & s1aq1 == 59 & hid == "3810438110012"

///3512135108015
br hid-s1aq8b tot_consumed if hid =="3512135108015"  & s1aq1==59
recode s1aq3a (16=6) if hid =="3512135108015" & s1aq1==59
recode s1aq4a (16=6) if hid =="3512135108015" & s1aq1==59
recode s1aq6a (16=6) if hid =="3512135108015" & s1aq1==59
recode s1aq8a (6=.) if hid =="3512135108015" & s1aq1==59
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 59 & hid == "3512135108015"
replace s1aq4b = 11 if s1aq4b == 6 & s1aq1 == 59 & hid == "3512135108015"
replace s1aq6b = 11 if s1aq6b == 6 & s1aq1 == 59 & hid == "3512135108015"
replace s1aq8b = . if s1aq8b == 6 & s1aq1 == 59 & hid == "3512135108015"



///3521035222014
br hid-s1aq8b tot_consumed if hid =="3521035222014"  & s1aq1==59
recode s1aq6a (6=5) if hid =="3810438110012" & s1aq1==59
recode s1aq5 (25=50) if hid =="3810438110012" & s1aq1==59
recode s1aq7a (5=.) if hid =="3810438110012" & s1aq1==59
recode s1aq8a (5=.) if hid =="3810438110012" & s1aq1==59
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 59 & hid == "3521035222014"
replace s1aq4b = 11 if s1aq4b == 6 & s1aq1 == 59 & hid == "3521035222014"
replace s1aq6b = 11 if s1aq6b == 5 & s1aq1 == 59 & hid == "3521035222014"


///3520735220011
br hid-s1aq8b tot_consumed if hid =="3520735220011"  & s1aq1==59
recode s1aq3a (28=14) if hid =="3520735220011" & s1aq1==59
recode s1aq4a (28=14) if hid =="3520735220011" & s1aq1==59
recode s1aq6a (.=14) if hid =="3520735220011" & s1aq1==59
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 59 & hid == "3520735220011"
replace s1aq4b = 11 if s1aq4b == 6 & s1aq1 == 59 & hid == "3520735220011"
replace s1aq6b = 11 if s1aq6b == . & s1aq1 == 59 & hid == "3520735220011"



///4010840110002
br hid-s1aq8b tot_consumed if hid =="4010840110002"  & s1aq1==59
recode s1aq3a (140=7) if hid =="4010840110002" & s1aq1==59
recode s1aq4a (140=7) if hid =="4010840110002" & s1aq1==59
recode s1aq6a (.=7) if hid =="4010840110002" & s1aq1==59
recode s1aq5 (700=70) if hid =="4010840110002" & s1aq1==59
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 59 & hid == "4010840110002"
replace s1aq4b = 11 if s1aq4b == 6 & s1aq1 == 59 & hid == "4010840110002"
replace s1aq6b = 11 if s1aq6b == . & s1aq1 == 59 & hid == "4010840110002"


///4020540221016
br hid-s1aq8b tot_consumed if hid =="4020540221016"  & s1aq1==59
recode s1aq3a (10=2) if hid =="4020540221016" & s1aq1==59
recode s1aq6a (.=2) if hid =="4020540221016" & s1aq1==59
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 59 & hid == "4020540221016"
replace s1aq6b = 11 if s1aq6b == . & s1aq1 == 59 & hid == "4020540221016"



///3522535215015
br hid-s1aq8b tot_consumed if hid =="3522535215015"  & s1aq1==59
recode s1aq8a (2=.) if hid =="3522535215015" & s1aq1==59
recode s1aq6a (.=3) if hid =="3522535215015" & s1aq1==59
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 59 & hid == "3522535215015"
replace s1aq6b = 11 if s1aq6b == . & s1aq1 == 59 & hid == "3522535215015"
replace s1aq8b = . if s1aq8b == 11 & s1aq1 == 59 & hid == "3522535215015"


///4021040223016
br hid-s1aq8b tot_consumed if hid =="4021040223016"  & s1aq1==59
recode s1aq6a (.=7) if hid =="4021040223016" & s1aq1==59
recode s1aq4a (280=7) if hid =="4021040223016" & s1aq1==59
recode s1aq5 (11=70) if hid =="4021040223016" & s1aq1==59
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 59 & hid == "4021040223016"
replace s1aq4b = 11 if s1aq4b == 7 & s1aq1 == 59 & hid == "4021040223016"
replace s1aq6b = . if s1aq6b == 11 & s1aq1 == 59 & hid == "4021040223016"



br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 59 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 8 if s1aq1  == 59 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq6a = s1aq3a if issue == 8 

drop issue



br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 59 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq7a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 77 if s1aq1  == 59 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq7a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq3a = 5 if s1aq3a == 23 & hid == "3511335106003" & issue == 77
replace s1aq5 = 250 if s1aq5 == 245 & hid == "3511335106003" & issue == 77
replace s1aq3a = 2 if s1aq3a == 28 & hid == "3610236101010" & issue == 77
replace s1aq5 = 100 if s1aq5 == 140 & hid == "3610236101010" & issue == 77
replace s1aq3a = 1 if s1aq3a == 11 & hid == "4311543108005" & issue == 77
replace s1aq3a = 3 if s1aq3a == 31 & hid == "4121041204011" & issue == 77
replace s1aq5 = 150 if s1aq5 == 170 & hid == "4121041204011" & issue == 77
replace s1aq5 = 150 if s1aq5 == 20 & hid == "3410234119016" & issue == 77
replace s1aq5 = 20 if s1aq5 == 280 & hid == "3721837205014" & issue == 77
replace s1aq3a = 3 if s1aq3a == 35 & hid == "3410134112006" & issue == 77
replace s1aq5 = 75 if s1aq5 == 175 & hid == "3410134112006" & issue == 77
replace s1aq5 = 50 if s1aq5 == 80 & hid == "3720737207001" & issue == 77
replace s1aq3a = 2 if s1aq3a == 21 & hid == "4020340202013" & issue == 77
replace s1aq5 = 50 if s1aq5 == 280 & hid == "4020340202013" & issue == 77
replace s1aq5 = 140 if s1aq5 == 80 & hid == "3520335204007" & issue == 77
replace s1aq5 = 250 if s1aq5 == 25 & hid == "3510235111011" & issue == 77
replace s1aq5 = 250 if s1aq5 == 25 & hid == "3521035222014" & issue == 77
replace s1aq3a = 6 if s1aq3a == 3 & hid == "3421234207005" & issue == 77
replace s1aq3a = 2 if s1aq3a == 20 & hid == "4420644206013" & issue == 77
replace s1aq5 = 325 if s1aq5 == 65 & hid == "3610236101011" & issue == 77
replace s1aq5 = 100 if s1aq5 == 1002 & hid == "4410544103005" & issue == 77
replace s1aq3a = 2 if s1aq3a == 21 & hid == "3522535219001" & issue == 77
replace s1aq5 = 100 if s1aq5 == 14 & hid == "3522535219001" & issue == 77
replace s1aq5 = 140 if s1aq5 == 11 & hid == "3520535211007" & issue == 77
replace s1aq3a = 1 if s1aq3a == 11 & hid == "4111041112003" & issue == 77
replace s1aq5 = 200 if s1aq5 == 110 & hid == "4121141207006" & issue == 77
replace s1aq3a = 1 if s1aq3a == 11 & hid == "4120541202004" & issue == 77
replace s1aq3a = 1 if s1aq3a == 11 & hid == "3820638202002" & issue == 77
replace s1aq5 = 20 if s1aq5 == 210 & hid == "3820638202002" & issue == 77
replace s1aq5 = 150 if s1aq5 == 25 & hid == "3610236101006" & issue == 77
replace s1aq3a = 3 if s1aq3a == 35 & hid == "3520235213010" & issue == 77
replace s1aq5 = 75 if s1aq5 == 350 & hid == "3520235213010" & issue == 77

replace s1aq6a = s1aq3a if issue == 77
replace s1aq4a = s1aq3a if issue == 77

replace s1aq3b = 11 if issue == 77
replace s1aq4b = 11 if issue == 77
replace s1aq6b = 11 if issue == 77

drop issue


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 59 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq7a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 78 if s1aq1  == 59 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq7a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = . if issue == 78

replace s1aq3b = 11 if issue == 78

drop issue 


///4120441209002
br hid-s1aq8b tot_consumed if hid =="4120441209002"  & s1aq1==59
recode s1aq8a (2=.) if hid =="4120441209002" & s1aq1==59
recode s1aq8a (2=.) if hid =="4120441209002" & s1aq1==59
replace s1aq8b = . if s1aq8b == 2 & s1aq1 == 59 & hid == "4120441209002"


************* 60 cat fish *******************
///4021240209002
br hid-s1aq8b tot_consumed if hid =="4021240209002"  & s1aq1==60
recode s1aq6a (7=.) if hid =="4021240209002" & s1aq1==60
recode s1aq8a (1=.) if hid =="4021240209002" & s1aq1==60
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 60 & hid == "4021240209002"
replace s1aq6b = . if s1aq6b == 11 & s1aq1 == 60 & hid == "4021240209002"
replace s1aq8b = . if s1aq8b == 11 & s1aq1 == 60 & hid == "4021240209002"



///3810638106011
br hid-s1aq8b tot_consumed if hid =="3810638106011"  & s1aq1==60
recode s1aq8a (6=4) if hid =="3810638106011" & s1aq1==60
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 60 & hid == "3810638106011"
replace s1aq8b = 11 if s1aq8b == 0 & s1aq1 == 60 & hid == "3810638106011"



///4210242105005
br hid-s1aq8b tot_consumed if hid =="4210242105005"  & s1aq1==60
recode s1aq7a (2=.) if hid =="4210242105005" & s1aq1==60
recode s1aq8a (2=.) if hid =="4210242105005" & s1aq1==60
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 60 & hid == "4210242105005"
replace s1aq7b = . if s1aq7b == 2 & s1aq1 == 60 & hid == "4210242105005"
replace s1aq8b = . if s1aq8b == 2 & s1aq1 == 60 & hid == "4210242105005"



///4021240209012
br hid-s1aq8b tot_consumed if hid =="4021240209012"  & s1aq1==60
recode s1aq3a (2=1) if hid =="4021240209012" & s1aq1==60
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 60 & hid == "4021240209012"
replace s1aq4b = 6 if s1aq4b == 1 & s1aq1 == 60 & hid == "4021240209012"
replace s1aq6b = 6 if s1aq6b == 1 & s1aq1 == 60 & hid == "4021240209012"


///4121141207005
br hid-s1aq8b tot_consumed if hid =="4121141207005"  & s1aq1==60
recode s1aq8a (.=7) if hid =="4121141207005" & s1aq1==60
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 60 & hid == "4121141207005"
replace s1aq4b = 6 if s1aq4b == 0 & s1aq1 == 60 & hid == "4121141207005"
replace s1aq8b = 6 if s1aq8b == . & s1aq1 == 60 & hid == "4121141207005"


///4111341101015
br hid-s1aq8b tot_consumed if hid =="4111341101015"  & s1aq1==60
recode s1aq3a (6=2) if hid =="4111341101015" & s1aq1==60
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 60 & hid == "4111341101015"


///4111241103004
br hid-s1aq8b tot_consumed if hid =="4111241103004"  & s1aq1==60
recode s1aq3a (6=1) if hid =="4111241103004" & s1aq1==60
recode s1aq6a (16=1) if hid =="4111241103004" & s1aq1==60
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 60 & hid == "4111241103004"
replace s1aq6b = 6 if s1aq6b == 0 & s1aq1 == 60 & hid == "4111241103004"


///3710137101014
br hid-s1aq8b tot_consumed if hid =="3710137101014"  & s1aq1==60
recode s1aq3a (6=1) if hid =="3710137101014" & s1aq1==60
recode s1aq4a (6=1) if hid =="3710137101014" & s1aq1==60
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 60 & hid == "3710137101014"
replace s1aq4b = 6 if s1aq4b == 1 & s1aq1 == 60 & hid == "3710137101014"


**************** 61 fresh grouper/ladyfish ************
////4121141207005
br hid-s1aq8b tot_consumed if hid =="4121141207005"  & s1aq1==61
recode s1aq8a (6=5) if hid =="4121141207005" & s1aq1==61
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 61 & hid == "4121141207005"
replace s1aq4b = 11 if s1aq4b == 6 & s1aq1 == 61 & hid == "4121141207005"
replace s1aq8b = 11 if s1aq8b == 0 & s1aq1 == 61 & hid == "4121141207005"


////4120341210004
br hid-s1aq8b tot_consumed if hid =="4120341210004"  & s1aq1==61
recode s1aq6a (7=.) if hid =="4120341210004" & s1aq1==61
recode s1aq7a (1=.) if hid =="4120341210004" & s1aq1==61
recode s1aq8a (.=7) if hid =="4120341210004" & s1aq1==61
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 61 & hid == "4120341210004"
replace s1aq6b = . if s1aq6b == 1 & s1aq1 == 61 & hid == "4120341210004"
replace s1aq7b = . if s1aq7b == 1 & s1aq1 == 61 & hid == "4120341210004"
replace s1aq8b = 11 if s1aq8b == . & s1aq1 == 61 & hid == "4120341210004"



///3710137101008
br hid-s1aq8b tot_consumed if hid =="3710137101008"  & s1aq1==61
recode s1aq8a (2=.) if hid =="3710137101008" & s1aq1==61
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 61 & hid == "3710137101008"
replace s1aq8b = . if s1aq8b == 2 & s1aq1 == 61 & hid == "3710137101008"


///4210242105004
br hid-s1aq8b tot_consumed if hid =="4210242105004"  & s1aq1==61
recode s1aq6a (2=15) if hid =="4210242105004" & s1aq1==61
recode s1aq8a (2=.) if hid =="4210242105004" & s1aq1==61
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 61 & hid == "4210242105004"
replace s1aq4b = 11 if s1aq4b == 6 & s1aq1 == 61 & hid == "4210242105004"
replace s1aq6b = 11 if s1aq6b == 0 & s1aq1 == 61 & hid == "4210242105004"
replace s1aq8b = . if s1aq8b == 6 & s1aq1 == 61 & hid == "4210242105004"



////3520535211002
br hid-s1aq8b tot_consumed if hid =="3520535211002"  & s1aq1==61
recode s1aq6a (11=.) if hid =="3520535211002" & s1aq1==61
recode s1aq4a (11=.) if hid =="3520535211002" & s1aq1==61
recode s1aq7a (4=.) if hid =="3520535211002" & s1aq1==61
recode s1aq8a (.=4) if hid =="3520535211002" & s1aq1==61
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 61 & hid == "3520535211002"
replace s1aq4b = . if s1aq4b == 11 & s1aq1 == 61 & hid == "3520535211002"
replace s1aq6b = . if s1aq6b == 11 & s1aq1 == 61 & hid == "3520535211002"
replace s1aq7b = . if s1aq7b == 11 & s1aq1 == 61 & hid == "3520535211002"
replace s1aq8b = 11 if s1aq8b == . & s1aq1 == 61 & hid == "3520535211002"


************* 62 fresh baracuda ************
////4410244105014
br hid-s1aq8b tot_consumed if hid =="4410244105014"  & s1aq1==62
recode s1aq8a (2=.) if hid =="4410244105014" & s1aq1==62
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 62 & hid == "4410244105014"
replace s1aq8b = . if s1aq8b == 0 & s1aq1 == 62 & hid == "4410244105014"


************ 63 tilapia ****************
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 63 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.


gen issue = 9 if s1aq1  == 63 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq8a = s1aq3a if hid == "3810638106001" & issue == 9
replace s1aq7a = s1aq3a if hid == "3710137101014" & issue == 9

drop issue


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 63 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq7a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 79 if s1aq1  == 63 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq7a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq3a = 2 if s1aq3a == 20 & issue == 79
replace s1aq3a = 1 if s1aq3a == 11 & issue == 79
replace s1aq4a = s1aq3a if issue == 79
replace s1aq6a = s1aq3a if issue == 79
replace s1aq5 = 200 if s1aq5 == 20 & issue == 79
replace s1aq5 = 100 if s1aq5 == 60 & issue == 79
replace s1aq5 = 200 if s1aq5 == 140 & issue == 79

replace s1aq3b = 11 if issue == 79
replace s1aq4b = 11 if issue == 79
replace s1aq6b = 11 if issue == 79

drop issue


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 63 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a==.  & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 80 if s1aq1  == 63 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a==.  & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq8a = s1aq3a if issue == 80 
replace s1aq3b = 11 if issue == 80
replace s1aq8b = 11 if issue == 80

drop issue


///4021840212016
br hid-s1aq8b tot_consumed if hid =="4021840212016"  & s1aq1==63
recode s1aq7a (1=14) if hid =="4021840212016" & s1aq1==63
recode s1aq6a (14=.) if hid =="4021840212016" & s1aq1==63
recode s1aq6b (11=.) if hid =="4021840212016" & s1aq1==63
recode s1aq3b (11=0) if hid =="4021840212016" & s1aq1==63


///4210142109016
br hid-s1aq8b tot_consumed if hid =="4210142109016"  & s1aq1==63
recode s1aq6a (.=7) if hid =="4210142109016" & s1aq1==63
recode s1aq6b (.=11) if hid =="4210142109016" & s1aq1==63
recode s1aq3b (0=11) if hid =="4210142109016" & s1aq1==63



///4021340215004
br hid-s1aq8b tot_consumed if hid =="4021340215004"  & s1aq1==63
recode s1aq8a (1=.) if hid =="4021340215004" & s1aq1==63
recode s1aq8b (11=.) if hid =="4021340215004" & s1aq1==63
recode s1aq3b (0=11) if hid =="4021340215004" & s1aq1==63



////3711637103004
br hid-s1aq8b tot_consumed if hid =="3711637103004"  & s1aq1==63
recode s1aq8a (1=2) if hid =="3711637103004" & s1aq1==63
recode s1aq6a (2=.) if hid =="3711637103004" & s1aq1==63
recode s1aq6b (11=.) if hid =="3711637103004" & s1aq1==63
recode s1aq3b (0=11) if hid =="3711637103004" & s1aq1==63


///4110741108002
br hid-s1aq8b tot_consumed if hid =="4110741108002"  & s1aq1==63
recode s1aq7a (11=.) if hid =="4110741108002" & s1aq1==63
recode s1aq5 (60=150) if hid =="4110741108002" & s1aq1==63
recode s1aq6a (120=3) if hid =="4110741108002" & s1aq1==63
recode s1aq7b (0=.) if hid =="4110741108002" & s1aq1==63
recode s1aq6b (3=11) if hid =="4110741108002" & s1aq1==63
recode s1aq3b (0=11) if hid =="4110741108002" & s1aq1==63


///3810438110012
br hid-s1aq8b tot_consumed if hid =="3810438110012"  & s1aq1==63
recode s1aq7a (2=.) if hid =="3810438110012" & s1aq1==63
recode s1aq7b (2=.) if hid =="3810438110012" & s1aq1==63
recode s1aq8a (2=.) if hid =="3810438110012" & s1aq1==63
recode s1aq8b (2=.) if hid =="3810438110012" & s1aq1==63
recode s1aq5 (250=150) if hid =="3810438110012" & s1aq1==63
recode s1aq3b (0=11) if hid =="3810438110012" & s1aq1==63


**************** 64 red snapper ****************
///4311543108004
br hid-s1aq8b tot_consumed if hid =="4311543108004"  & s1aq1==64
recode s1aq7a (2=.) if hid =="4311543108004" & s1aq1==64
recode s1aq8a (2=.) if hid =="4311543108004" & s1aq1==64
recode s1aq5 (2=100) if hid =="4311543108004" & s1aq1==64
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 64 & hid == "4311543108004"
replace s1aq4b = 11 if s1aq4b == 2 & s1aq1 == 64 & hid == "4311543108004"
replace s1aq6b = 11 if s1aq6b == 2 & s1aq1 == 64 & hid == "4311543108004"
replace s1aq7b = . if s1aq7b == 2 & s1aq1 == 64 & hid == "4311543108004"
replace s1aq8b = . if s1aq8b == 2 & s1aq1 == 64 & hid == "4311543108004"



///4311543108001
br hid-s1aq8b tot_consumed if hid =="4311543108001"  & s1aq1==64
recode s1aq3a (3=1) if hid =="4311543108001" & s1aq1==64
recode s1aq5 (300=30) if hid =="4311543108001" & s1aq1==64
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 64 & hid == "4311543108001"
replace s1aq4b = 11 if s1aq4b == 1 & s1aq1 == 64 & hid == "4311543108001"
replace s1aq6b = 11 if s1aq6b == 1 & s1aq1 == 64 & hid == "4311543108001"



///3522535218004
br hid-s1aq8b tot_consumed if hid =="3522535218004"  & s1aq1==64
recode s1aq3a (11=1) if hid =="3522535218004" & s1aq1==64
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 64 & hid == "3522535218004"


************** 65 fresh mackerel sardine ***********
///4022440219011
br hid-s1aq8b tot_consumed if hid =="4022440219011"  & s1aq1==65
recode s1aq3a (1=2) if hid =="4022440219011" & s1aq1==65
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 65 & hid == "4022440219011"
replace s1aq4b = 6 if s1aq4b == 11 & s1aq1 == 65 & hid == "4022440219011"
replace s1aq6b = 6 if s1aq6b == 11 & s1aq1 == 65 & hid == "4022440219011"


**************** 67 fresh mackerel fish ****************
///3620736202003
br hid-s1aq8b tot_consumed if hid =="3620736202003"  & s1aq1==67
recode s1aq7a (1=.) if hid =="3620736202003" & s1aq1==67
recode s1aq6a (75=3) if hid =="3620736202003" & s1aq1==67
recode s1aq5 (3=75) if hid =="3620736202003" & s1aq1==67
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 67 & hid == "3620736202003"
replace s1aq4b = 11 if s1aq4b == 1 & s1aq1 == 67 & hid == "3620736202003"
replace s1aq6b = 11 if s1aq6b == 3 & s1aq1 == 67 & hid == "3620736202003"
replace s1aq7b = . if s1aq7b == 0 & s1aq1 == 67 & hid == "3620736202003"



***************** 69 dried fish ******************
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 69 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 9 if s1aq1  == 69 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq8a = s1aq3a if issue == 9
replace s1aq3b = 11 if s1aq3b == 0 & issue == 9
replace s1aq8b = s1aq3b if issue == 9

drop issue

br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 69 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 10 if  s1aq1  == 69 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq6a = . if s1aq6a == 5 & issue == 10
replace s1aq6a = . if s1aq6a == 3 & issue == 10
replace s1aq8a = s1aq3a if issue == 10

replace s1aq3b = 11 if s1aq3b == 0 & issue ==10
replace s1aq8b = s1aq3b if issue == 10 
replace s1aq6b = . if s1aq6b == 6 & issue ==10

drop issue



br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 69 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq7a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 11 if s1aq1  == 69 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq7a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = . if s1aq7a == 6 & issue == 11
replace s1aq8a = s1aq7a if s1aq8a == 6 & issue == 11
replace s1aq7a = . if s1aq7a == 2 & issue == 11
replace s1aq8a = s1aq7a if s1aq8a == 2 & issue == 11

replace s1aq6a = s1aq3a if s1aq6a == 6 & issue == 11
replace s1aq3b = 6 if s1aq3b == 0 & issue == 11
replace s1aq6b = s1aq3b if s1aq6b ==0 & issue == 11

replace s1aq7b = . if s1aq7b == 0 & issue == 11
replace s1aq8b = s1aq7b if s1aq8b == 0 & issue ==11
replace s1aq7b = . if s1aq7b == 2 & issue == 11
replace s1aq8b = s1aq7b if s1aq8b == 2 & issue ==11

drop issue


///4220642204009
br hid-s1aq8b tot_consumed if hid =="4220642204009"  & s1aq1==69
recode s1aq8a (90=.) if hid =="4220642204009" & s1aq1==69
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 69 & hid == "4220642204009"
replace s1aq8b = . if s1aq8b == 0 & s1aq1 == 69 & hid == "4220642204009"


///4311543116015
br hid-s1aq8b tot_consumed if hid =="4311543116015"  & s1aq1==69
recode s1aq3a (4=3) if hid =="4311543116015" & s1aq1==69
recode s1aq4a (4=3) if hid =="4311543116015" & s1aq1==69
recode s1aq6a (4=3) if hid =="4311543116015" & s1aq1==69
recode s1aq8a (2=.) if hid =="4311543116015" & s1aq1==69
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 69 & hid == "4311543116015"
replace s1aq8b = . if s1aq8b == 0 & s1aq1 == 69 & hid == "4311543116015"


////3610536109005
br hid-s1aq8b tot_consumed if hid =="3610536109005"  & s1aq1==69
recode s1aq8a (2=.) if hid =="3610536109005" & s1aq1==69
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 69 & hid == "3610536109005"
replace s1aq8b = . if s1aq8b == 0 & s1aq1 == 69 & hid == "3610536109005"



br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 69 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!= s1aq3a & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 12 if s1aq1  == 69 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!= s1aq3a & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq3a = s1aq6a if s1aq3a == 6 & issue == 12
replace s1aq6a = s1aq3a if s1aq6a == 26 & issue  == 12
replace s1aq4a = s1aq6a if s1aq4a == 26 & issue == 12
replace s1aq6a = s1aq3a if s1aq6a == . & issue == 12
replace s1aq3a = s1aq6a if s1aq3a == 10 & issue == 12

drop issue 


////4410644110001
br hid-s1aq8b tot_consumed if hid =="4410644110001"  & s1aq1==69
recode s1aq3a (1=7) if hid =="4410644110001" & s1aq1==69
recode s1aq4a (6=7) if hid =="4410644110001" & s1aq1==69
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 69 & hid == "4410644110001"
replace s1aq4b = 6 if s1aq4b == 7 & s1aq1 == 69 & hid == "4410644110001"


////3720737207010
br hid-s1aq8b tot_consumed if hid =="3720737207010"  & s1aq1==69
recode s1aq3a (2=6) if hid =="3720737207010" & s1aq1==69
recode s1aq5 (20=30) if hid =="3720737207010" & s1aq1==69
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 69 & hid == "3720737207010"



///3420934212007
br hid-s1aq8b tot_consumed if hid =="3420934212007"  & s1aq1==69
recode s1aq3a (3=4) if hid =="3420934212007" & s1aq1==69
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 69 & hid == "3420934212007"


///3610836112002
br hid-s1aq8b tot_consumed if hid =="3610836112002"  & s1aq1==69
recode s1aq6a (6=1) if hid =="3610836112002" & s1aq1==69
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 69 & hid == "3610836112002"
replace s1aq6b = 6 if s1aq6b == 10 & s1aq1 == 69 & hid == "3610836112002"


///3512535115011
br hid-s1aq8b tot_consumed if hid =="3512535115011"  & s1aq1==69
recode s1aq6a (12=3) if hid =="3512535115011" & s1aq1==69
recode s1aq5 (3=15) if hid =="3512535115011" & s1aq1==69
recode s1aq4a (12=3) if hid =="3512535115011" & s1aq1==69
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 69 & hid == "3512535115011"


////3820238208014
br hid-s1aq8b tot_consumed if hid =="3820238208014"  & s1aq1==69
recode s1aq3a (17=14) if hid =="3820238208014" & s1aq1==69
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 69 & hid == "3820238208014"


////3410334103010
br hid-s1aq8b tot_consumed if hid =="3410334103010"  & s1aq1==69
recode s1aq6a (6=4) if hid =="3410334103010" & s1aq1==69
recode s1aq5 (4=40) if hid =="3410334103010" & s1aq1==69
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 69 & hid == "3410334103010"
replace s1aq6b = 6 if s1aq6b == 0 & s1aq1 == 69 & hid == "3410334103010"


///3420934212013
br hid-s1aq8b tot_consumed if hid =="3420934212013"  & s1aq1==69
recode s1aq6a (6=3) if hid =="3420934212013" & s1aq1==69
recode s1aq5 (3=30) if hid =="3420934212013" & s1aq1==69
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 69 & hid == "3420934212013"
replace s1aq4b = 6 if s1aq4b == 15 & s1aq1 == 69 & hid == "3420934212013"
replace s1aq6b = 6 if s1aq6b == 0 & s1aq1 == 69 & hid == "3420934212013"


///3410234119008
br hid-s1aq8b tot_consumed if hid =="3410234119008"  & s1aq1==69
recode s1aq6a (6=1) if hid =="3410234119008" & s1aq1==69
recode s1aq5 (1=10) if hid =="3410234119008" & s1aq1==69
recode s1aq4a (6=1) if hid =="3410234119008" & s1aq1==69
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 69 & hid == "3410234119008"


///4011240118007
br hid-s1aq8b tot_consumed if hid =="4011240118007"  & s1aq1==69
recode s1aq6a (5=1) if hid =="4011240118007" & s1aq1==69
recode s1aq5 (1=10) if hid =="4011240118007" & s1aq1==69
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 69 & hid == "4011240118007"


///3512135108003
br hid-s1aq8b tot_consumed if hid =="3512135108003"  & s1aq1==69
recode s1aq3a (3=12) if hid =="3512135108003" & s1aq1==69
recode s1aq5 (9=60) if hid =="3512135108003" & s1aq1==69
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 69 & hid == "3512135108003"


///3810438110014
br hid-s1aq8b tot_consumed if hid =="3810438110014"  & s1aq1==69
recode s1aq3a (7=6) if hid =="3810438110014" & s1aq1==69
recode s1aq5 (9=60) if hid =="3810438110014" & s1aq1==69
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 69 & hid == "3810438110014"



br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 69 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=.  & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 81 if s1aq1  == 69 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=.  & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq5 = 15 if s1aq5 == 12 & issue == 81
replace s1aq5 = 20 if s1aq5 == 15 & issue == 81
replace s1aq6a = 2 if s1aq6a == 26 & issue == 81

replace s1aq3a = s1aq6a if issue == 81
replace s1aq4a = s1aq6a if issue == 81

replace s1aq3b = 6 if issue == 81
replace s1aq4b = 6 if issue == 81
replace s1aq6b = 6 if issue == 81

replace s1aq8a = . if issue == 81
replace s1aq8b = . if issue == 81

drop issue


///3520635209006
br hid-s1aq8b tot_consumed if hid =="3520635209006"  & s1aq1==69
recode s1aq6a (.=2) if hid =="3520635209006" & s1aq1==69
recode s1aq3b (0=6) if hid =="3520635209006" & s1aq1==69
replace s1aq4b = 6 if s1aq4b == 5 & s1aq1 == 69 & hid == "3520635209006"
replace s1aq6b = 6 if s1aq6b == . & s1aq1 == 69 & hid == "3520635209006"



///4022440219003
br hid-s1aq8b tot_consumed if hid =="4022440219003"  & s1aq1==69
recode s1aq6a (.=5) if hid =="4022440219003" & s1aq1==69
recode s1aq3b (0=6) if hid =="4022440219003" & s1aq1==69
replace s1aq6b = 6 if s1aq6b == . & s1aq1 == 69 & hid == "4022440219003"


///4120441209015
br hid-s1aq8b tot_consumed if hid =="4120441209015"  & s1aq1==69
recode s1aq6a (.=2) if hid =="4120441209015" & s1aq1==69
recode s1aq3b (0=6) if hid =="4120441209015" & s1aq1==69
replace s1aq6b = 6 if s1aq6b == . & s1aq1 == 69 & hid == "4120441209015"


***************** 70 smoked bonga *************
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 70 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq7a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 13 if s1aq1  == 70 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq7a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = . if s1aq7a == 2 & issue == 13
replace s1aq8a = s1aq7a if s1aq8a == 2 & issue == 13
replace s1aq7a = s1aq8a if s1aq7a == 300 & issue == 13
replace s1aq7a = s1aq8a if s1aq7a == 15 & issue == 13

replace s1aq3b = 11 if s1aq3b == 0 & issue == 13
replace s1aq4b = s1aq3b if s1aq4b == 6 & issue == 13
replace s1aq6b = s1aq3b if s1aq6b == 6 & issue == 13

drop issue


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 70 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a==.  & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 14 if s1aq1  == 70 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a==.  & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq6a = s1aq3a if issue == 14
replace s1aq5 = 50 if s1aq5 == 25 & issue == 14
replace s1aq5 = 30 if s1aq5 == 25 & issue == 14
replace s1aq5 = 30 if s1aq5 == 15 & issue == 14

replace s1aq3b = 11 if s1aq3b == 0 & issue == 14
replace s1aq4b = 11 if s1aq4b == 6 & issue == 14
replace s1aq6b = s1aq3b if issue == 14

drop issue


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 70 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!= s1aq3a  & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 15 if  s1aq1  == 70 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!= s1aq3a  & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq6a = 6 if s1aq6a == 1 & hid == "3720737207007" & issue == 15
replace s1aq5 = 10  if s1aq5 == 5 & hid == "3720737207007" & issue == 15
replace s1aq3a = 6 if s1aq3a == 3 & hid == "3610636104004" & issue == 15
replace s1aq5 = 30 if  s1aq5 == 15 & hid == "3610636104004" & issue == 15
replace s1aq6a = 21 if  s1aq6a == 14 & hid == "3610236101010" & issue == 15
replace s1aq5 = 140 if s1aq5 == 147 & hid == "3610236101010" & issue == 15
replace s1aq3a = 17 if  s1aq3a == 14 & hid == "4220142208009"& issue == 15
replace s1aq5 = 170 if  s1aq5  == 140 & hid == "4220142208009"& issue == 15
replace s1aq3a = 6 if  s1aq3a == 2 & hid == "3610636104006"& issue == 15
replace s1aq5 = 60 if s1aq5 == 12 & hid == "3610636104006" & issue == 15
replace s1aq6a = 7 if s1aq6a == 6 & hid == "4220442209009" & issue == 15
replace s1aq5 = 70 if s1aq5 == 100 & hid == "4220442209009" & issue == 15
replace s1aq6a = 12 if s1aq6a == 1 & hid == "4510345116012" & issue == 15
replace s1aq5 = 120 if s1aq5 == 96 & hid == "4510345116012" & issue == 15
replace s1aq6a = 5 if s1aq6a == 7 & hid == "3410334106011" & issue == 15
replace s1aq5 = 50 if s1aq5 == 35 & hid == "3410334106011" & issue == 15
replace s1aq3a = 1 if s1aq3a == 6 & hid == "3510135113016" & issue == 15
replace s1aq5 = 10 if s1aq5 == 5 & hid == "3510135113016" & issue == 15
replace s1aq6a = 4 if s1aq6a == 3 & hid == "3410434118008" & issue == 15
replace s1aq5 = 40 if s1aq5 == 28 & hid == "3410434118008" & issue == 15
replace s1aq6a = 3 if s1aq6a == 30 & hid == "4021040223004" & issue == 15
replace s1aq5 = 30 if s1aq5 == 3 & hid == "4021040223004" & issue == 15
replace s1aq3a = 2 if s1aq3a == 1 & hid == "3820638202008" & issue == 15


replace s1aq3b = 11 if s1aq3b == 0 & issue == 15
replace s1aq4a = 11 if s1aq4a == 6 & issue == 15
replace s1aq4a = 11 if s1aq4a == 1 & issue == 15
replace s1aq4a = 11 if s1aq4a == 7 & issue == 15

replace s1aq6b = 11 if s1aq6b == 6 & issue == 15
replace s1aq6b = 11 if s1aq6b == 7 & issue == 15
replace s1aq6b = 11 if s1aq6b == 3 & issue == 15

drop issue


///3720737207007
br hid-s1aq8b tot_consumed if hid =="3720737207007"  & s1aq1==70
recode s1aq5 (5=60) if hid =="3720737207007" & s1aq1==70
recode s1aq6a (1=6) if hid =="3720737207007" & s1aq1==70
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 70 & hid == "3720737207007"


///4510345116012
br hid-s1aq8b tot_consumed if hid =="4510345116012"  & s1aq1==70
recode s1aq5 (96=120) if hid =="4510345116012" & s1aq1==70
recode s1aq6a (1=12) if hid =="4510345116012" & s1aq1==70


///3410334106011
br hid-s1aq8b tot_consumed if hid =="3410334106011"  & s1aq1==70
recode s1aq5 (35=50) if hid =="3410334106011" & s1aq1==70
recode s1aq6a (7=5) if hid =="3410334106011" & s1aq1==70


///3610136115014
br hid-s1aq8b tot_consumed if hid =="3610136115014"  & s1aq1==70
recode s1aq5 (30=50) if hid =="3610136115014" & s1aq1==70
recode s1aq8a (2=.) if hid =="3610136115014" & s1aq1==70
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 70 & hid == "3720737207007"
replace s1aq8b = 11 if s1aq8b == 6 & s1aq1 == 70 & hid == "3720737207007"
replace s1aq4b = 11 if s1aq4b == 6 & s1aq1 == 70 & hid == "3720737207007"
replace s1aq6b = 11 if s1aq6b == 6 & s1aq1 == 70 & hid == "3720737207007"


////3720437211012
br hid-s1aq8b tot_consumed if hid =="3720437211012"  & s1aq1==70
recode s1aq6a (21=.) if hid =="3720437211012" & s1aq1==70
recode s1aq7a (1=.) if hid =="3720437211012" & s1aq1==70
recode s1aq8a (.=21) if hid =="3720437211012" & s1aq1==70
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 70 & hid == "3720437211012"
replace s1aq8b = 11 if s1aq8b == . & s1aq1 == 70 & hid == "3720437211012"
replace s1aq7b = . if s1aq7b == 6 & s1aq1 == 70 & hid == "3720437211012"
replace s1aq6b = . if s1aq6b == 11 & s1aq1 == 70 & hid == "3720437211012"


////4021040223011
br hid-s1aq8b tot_consumed if hid =="4021040223011"  & s1aq1==70
recode s1aq7a (1=.) if hid =="4021040223011" & s1aq1==70
recode s1aq8a (.=3) if hid =="4021040223011" & s1aq1==70
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 70 & hid == "4021040223011"
replace s1aq7b = . if s1aq7b == 11 & s1aq1 == 70 & hid == "4021040223011"
replace s1aq8b = 11 if s1aq8b == . & s1aq1 == 70 & hid == "4021040223011"


///3510135113016
br hid-s1aq8b tot_consumed if hid =="3510135113016"  & s1aq1==70
recode s1aq3a (6=1) if hid =="3510135113016" & s1aq1==70
recode s1aq5 (5=10) if hid =="3510135113016" & s1aq1==70



///3511335106012
br hid-s1aq8b tot_consumed if hid =="3511335106012"  & s1aq1==70
recode s1aq8a (2=.) if hid =="3511335106012" & s1aq1==70
recode s1aq5 (15=45) if hid =="3511335106012" & s1aq1==70
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 70 & hid == "3511335106012"
replace s1aq4b = 11 if s1aq4b == 6 & s1aq1 == 70 & hid == "3511335106012"
replace s1aq6b = 11 if s1aq6b == 6 & s1aq1 == 70 & hid == "3511335106012"
replace s1aq8b = . if s1aq8b == 2 & s1aq1 == 70 & hid == "3511335106012"



******************* 71 smoked fish ************8
///3421234207014
br hid-s1aq8b tot_consumed if hid =="3421234207014"  & s1aq1==71
recode s1aq8a (2=.) if hid =="3421234207014" & s1aq1==71
recode s1aq5 (20=30) if hid =="3421234207014" & s1aq1==71
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 71 & hid == "3421234207014"
replace s1aq4b = 11 if s1aq4b == 6 & s1aq1 == 71 & hid == "3421234207014"
replace s1aq6b = 11 if s1aq6b == 6 & s1aq1 == 71 & hid == "3421234207014"
replace s1aq8b = . if s1aq8b == 2 & s1aq1 == 71 & hid == "3421234207014"


////4021340214003
br hid-s1aq8b tot_consumed if hid =="4021340214003"  & s1aq1==71
recode s1aq5 (50=40) if hid =="4021340214003" & s1aq1==71
recode s1aq7a (6=.) if hid =="4021340214003" & s1aq1==71
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 71 & hid == "4021340214003"
replace s1aq4b = 11 if s1aq4b == 6 & s1aq1 == 71 & hid == "4021340214003"
replace s1aq6b = 11 if s1aq6b == 4 & s1aq1 == 71 & hid == "4021340214003"
replace s1aq7b = . if s1aq7b == 0 & s1aq1 == 71 & hid == "4021340214003"



////4021340214007
br hid-s1aq8b tot_consumed if hid =="4021340214007"  & s1aq1==71
recode s1aq8a (.=3) if hid =="4021340214007" & s1aq1==71
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 71 & hid == "4021340214007"
replace s1aq8b = 11 if s1aq8b == . & s1aq1 == 71 & hid == "4021340214007"



**************** 72 dried couta/ tenny ************
///4110241106009
br hid-s1aq8b tot_consumed if hid =="4110241106009"  & s1aq1==72
recode s1aq8a (.=1) if hid =="4110241106009" & s1aq1==72
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 72 & hid == "4110241106009"
replace s1aq8b = 6 if s1aq8b == . & s1aq1 == 72 & hid == "4110241106009"


///4021340214016
br hid-s1aq8b tot_consumed if hid =="4021340214016"  & s1aq1==72
recode s1aq3a (6=1) if hid =="4021340214016" & s1aq1==72
recode s1aq4a (6=1) if hid =="4021340214016" & s1aq1==72
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 72 & hid == "4021340214016"
replace s1aq4b = 6 if s1aq4b == 1 & s1aq1 == 72 & hid == "4021340214016"


****************** 74 sardine tin in oil *************
///3820638202009
br hid-s1aq8b tot_consumed if hid =="3820638202009"  & s1aq1==74
recode s1aq8a (12=.) if hid =="3820638202009" & s1aq1==74
recode s1aq4a (25=1) if hid =="3820638202009" & s1aq1==74
recode s1aq6a (25=1) if hid =="3820638202009" & s1aq1==74
recode s1aq5 (25=15) if hid =="3820638202009" & s1aq1==74
replace s1aq3b = 12 if s1aq3b == 0 & s1aq1 == 74 & hid == "3820638202009"
replace s1aq4b = 12 if s1aq4b == 1 & s1aq1 == 74 & hid == "3820638202009"
replace s1aq6b = 12 if s1aq6b == 1 & s1aq1 == 74 & hid == "3820638202009"
replace s1aq8b = . if s1aq8b == 9 & s1aq1 == 74 & hid == "3820638202009"


////3820638202006
br hid-s1aq8b tot_consumed if hid =="3820638202006"  & s1aq1==74
recode s1aq3a (75=3) if hid =="3820638202006" & s1aq1==74
recode s1aq4a (75=3) if hid =="3820638202006" & s1aq1==74
recode s1aq6a (75=3) if hid =="3820638202006" & s1aq1==74
recode s1aq5 (3=75) if hid =="3820638202006" & s1aq1==74
replace s1aq3b = 12 if s1aq3b == 0 & s1aq1 == 74 & hid == "3820638202006"


************ 75 tuna flakes in tin *************
///4010440103007
br hid-s1aq8b tot_consumed if hid =="4010440103007"  & s1aq1==75
recode s1aq8a (.=2) if hid =="4010440103007" & s1aq1==75
recode s1aq4a (50=2) if hid =="4010440103007" & s1aq1==75
replace s1aq3b = 12 if s1aq3b == 0 & s1aq1 == 75 & hid == "4010440103007"
replace s1aq8b = 12 if s1aq8b == . & s1aq1 == 75 & hid == "4010440103007"


******************* 80 shrimps **************
///3520535211009
br hid-s1aq8b tot_consumed if hid =="3520535211009"  & s1aq1==80
recode s1aq8a (1=2) if hid =="3520535211009" & s1aq1==80
replace s1aq3b = 1 if s1aq3b == 0 & s1aq1 == 80 & hid == "3520535211009"
replace s1aq8b = 1 if s1aq8b == 0 & s1aq1 == 80 & hid == "3520535211009"


///3610536109006
br hid-s1aq8b tot_consumed if hid =="3610536109006"  & s1aq1==80
recode s1aq6a (1=2) if hid =="3610536109006" & s1aq1==80
replace s1aq3b = 1 if s1aq3b == 0 & s1aq1 == 80 & hid == "3610536109006"


////4021240209007
br hid-s1aq8b tot_consumed if hid =="4021240209007"  & s1aq1==80
recode s1aq3a (11=1) if hid =="4021240209007" & s1aq1==80
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 80 & hid == "4021240209007"

************** 81 oyster *************
///4020540221011
br hid-s1aq8b tot_consumed if hid =="4020540221011"  & s1aq1==81
recode s1aq8a (.=1) if hid =="4020540221011" & s1aq1==81
replace s1aq3b = 7 if s1aq3b == 0 & s1aq1 == 81 & hid == "4020540221011"
replace s1aq8b = 7 if s1aq8b == . & s1aq1 == 81 & hid == "4020540221011"


***************** 82 snail ****************
////3820638202008
br hid-s1aq8b tot_consumed if hid =="3820638202008"  & s1aq1==82
recode s1aq3a (1=2) if hid =="3820638202008" & s1aq1==82
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 82 & hid == "3820638202008"


///3410834114005
br hid-s1aq8b tot_consumed if hid =="3410834114005"  & s1aq1==82
recode s1aq6a (6=3) if hid =="3410834114005" & s1aq1==82
recode s1aq5 (3=15) if hid =="3410834114005" & s1aq1==82
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 82 & hid == "3410834114005"
replace s1aq6b = 6 if s1aq6b == 0 & s1aq1 == 82 & hid == "3410834114005"


///4020540221002
br hid-s1aq8b tot_consumed if hid =="4020540221002"  & s1aq1==82
recode s1aq4a (11=1) if hid =="4020540221002" & s1aq1==82
recode s1aq6a (11=1) if hid =="4020540221002" & s1aq1==82
recode s1aq3a (2=1) if hid =="4020540221002" & s1aq1==82
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 82 & hid == "4020540221002"


**************** 84 fresh cow milk **********
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 84 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 16 if s1aq1  == 84 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq6a = s1aq4a if s1aq6a ==3 & issue == 16
replace s1aq6a = s1aq4a if s1aq6a ==6 & issue == 16
replace s1aq6a = s1aq4a if s1aq6a ==70 & issue == 16

replace s1aq6b =s1aq4b if s1aq6b == 6 & issue == 16
replace s1aq6b =s1aq4b if s1aq6b == 3 & issue == 16
replace s1aq6b =s1aq4b if s1aq6b == 13 & issue == 16


replace s1aq7a = s1aq3a if s1aq7a ==. & issue == 16
replace s1aq3a = s1aq7a if s1aq3a == 6 & issue == 16
replace s1aq3a = s1aq7a if s1aq3a == 70 & issue == 16

replace s1aq3b = 3 if s1aq3b == 0 & issue == 16
replace s1aq7b = s1aq3b if s1aq7b ==. & issue == 16
replace s1aq7b = s1aq3b if s1aq7b ==13 & issue == 16

drop issue


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 84 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!= s1aq3a & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 17 if s1aq1  == 84 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!= s1aq3a & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq3a = s1aq6a if s1aq3a == 1 & issue == 17
replace s1aq3a = s1aq3a if s1aq3a == 1 & issue == 17
replace s1aq6a = s1aq3a if s1aq7a == 7 & issue == 17
replace s1aq8a = 5 if s1aq8a ==. & issue == 17

replace s1aq3b = 3 if s1aq3b == 0 & issue == 17
replace s1aq4b = s1aq3b if s1aq4b == 13 & issue == 17
replace s1aq6b = s1aq3b if s1aq6b == 6 & issue == 17
replace s1aq8b = s1aq3b if s1aq8b == . & issue == 17

drop issue


////4011140114004
br hid-s1aq8b tot_consumed if hid =="4011140114004"  & s1aq1==84
recode s1aq7a (1=.) if hid =="4011140114004" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0 & s1aq1 == 84 & hid == "4011140114004"
replace s1aq7b = 3 if s1aq7b == . & s1aq1 == 84 & hid == "4011140114004"


///4110741108011
br hid-s1aq8b tot_consumed if hid =="4110741108011"  & s1aq1==84
recode s1aq4a (1=2) if hid =="4110741108011" & s1aq1==84
recode s1aq8a (5=.) if hid =="4110741108011" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0 & s1aq1 == 84 & hid == "4110741108011"
replace s1aq8b = . if s1aq8b == 3 & s1aq1 == 84 & hid == "4110741108011"


////4121441205012// verify price
br hid-s1aq8b tot_consumed if hid =="4121441205012"  & s1aq1==84
recode s1aq8a (5=.) if hid =="4121441205012" & s1aq1==84
replace s1aq8b = . if s1aq8b == 3 & s1aq1 == 84 & hid == "4121441205012"


///3520735220005
br hid-s1aq8b tot_consumed if hid =="3520735220005"  & s1aq1==84
recode s1aq7a (1=.) if hid =="3520735220005" & s1aq1==84
recode s1aq8a (1=.) if hid =="3520735220005" & s1aq1==84
replace s1aq7b = 8 if s1aq8b == . & s1aq1 == 84 & hid == "3520735220005"
replace s1aq8b = 8 if s1aq8b == . & s1aq1 == 84 & hid == "3520735220005"
replace s1aq3b = 8 if s1aq3b == 0 & s1aq1 == 84 & hid == "3520735220005"



///4010440103013
br hid-s1aq8b tot_consumed if hid =="4010440103013"  & s1aq1==84
recode s1aq3a (.1=1) if hid =="4010440103013" & s1aq1==84
recode s1aq8a (.1=1) if hid =="4010440103013" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0 & s1aq1 == 84 & hid == "4010440103013"



////3721937201016
br hid-s1aq8b tot_consumed if hid =="3721937201016"  & s1aq1==84
recode s1aq7a (1=.) if hid =="3721937201016" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0 & s1aq1 == 84 & hid == "3721937201016"
replace s1aq7b = . if s1aq7b == 3 & s1aq1 == 84 & hid == "3721937201016"


///3621636211004
br hid-s1aq8b tot_consumed if hid =="3621636211004"  & s1aq1==84
recode s1aq3a (.1=1) if hid =="3621636211004" & s1aq1==84
recode s1aq4a (.1=1) if hid =="3621636211004" & s1aq1==84
recode s1aq6a (.1=1) if hid =="3621636211004" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0 & s1aq1 == 84 & hid == "3621636211004"

******************* 85 sour cow milk *************8
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 85 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=.  & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.


gen issue = 82 if s1aq1  == 85 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=.  & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq3a = 1 if s1aq3a ==.1 & issue == 82
replace s1aq3a = 3 if s1aq3a == 10 & issue == 82
replace s1aq5 = 450 if s1aq5 == 3 & issue == 82

replace s1aq6a = s1aq3a if issue == 82
replace s1aq4a = s1aq3a if issue == 82

replace s1aq3b = 3 if issue == 82
replace s1aq3b = 13 if s1aq3b == 3 & hid == "4020340202007" & issue == 82
replace s1aq6b = 13 if s1aq6b == 8 & issue == 82

drop issue 

////4021340217016
br hid-s1aq8b tot_consumed if hid =="4021340217016"  & s1aq1==85
recode s1aq6a (.=3) if hid =="4021340217016" & s1aq1==85
recode s1aq5 (60=450) if hid =="4021340217016" & s1aq1==85
recode s1aq6b (.=3) if hid =="4021340217016" & s1aq1==85
recode s1aq4b (6=3) if hid =="4021340217016" & s1aq1==85
replace s1aq3b = 3 if s1aq3b == 0 & s1aq1 == 85 & hid == "4021340217016"



///3722237213014
br hid-s1aq8b tot_consumed if hid =="3722237213014"  & s1aq1==85
recode s1aq6a (7=.) if hid =="3722237213014" & s1aq1==85
recode s1aq7a (.=1) if hid =="3722237213014" & s1aq1==85
recode s1aq6b (3=.) if hid =="3722237213014" & s1aq1==85
recode s1aq7b (.=3) if hid =="3722237213014" & s1aq1==85
replace s1aq3b = 3 if s1aq3b == 0 & s1aq1 == 85 & hid == "3722237213014"


************** 102 eggs industrial **************
///3820638202013
br hid-s1aq8b tot_consumed if hid =="3820638202013"  & s1aq1==102
recode s1aq7a (.=10) if hid =="3820638202013" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 102 & hid == "3820638202013"
replace s1aq7b = 6 if s1aq7b == . & s1aq1 == 102 & hid == "3820638202013"


///4021340214006
br hid-s1aq8b tot_consumed if hid =="4021340214006"  & s1aq1==102
recode s1aq7a (.=15) if hid =="4021340214006" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 102 & hid == "4021340214006"
replace s1aq7b = 6 if s1aq7b == . & s1aq1 == 102 & hid == "4021340214006"


///4011440105006
br hid-s1aq8b tot_consumed if hid =="4011440105006"  & s1aq1==102
recode s1aq7a (60=.) if hid =="4011440105006" & s1aq1==102
recode s1aq5 (20=32) if hid =="4011440105006" & s1aq1==102
replace s1aq7b = . if s1aq7b == 0 & s1aq1 == 102 & hid == "4011440105006"


**************** 143 cabbages ***************
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 143 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 18 if s1aq1  == 143 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq6a =s1aq3a if issue == 18
replace s1aq3b = 6 if s1aq3b == 0 & issue == 18
replace s1aq6b = s1aq3b if issue == 18
replace s1aq4b = s1aq3b if s1aq4b == 11 & issue == 18

drop issue

br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 143 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a!=. & s1aq8a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 19 if s1aq1  == 143 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a!=. & s1aq8a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq4a = . if s1aq4a == 0 & issue == 19
replace s1aq4a = . if s1aq4a == 6 & issue == 19
replace s1aq6a = s1aq4a if s1aq6a == 6 & issue == 19
replace s1aq7a = s1aq4a if s1aq7a == 6 & issue == 19

replace s1aq3b = 6 if s1aq3b == 0 & issue == 19
replace s1aq4b = . if s1aq4b == 6 & issue == 19
replace s1aq6b = . if s1aq6b == 6 & issue == 19
replace s1aq6b = . if s1aq6b == 0 & issue == 19
replace s1aq7b = . if s1aq7b == 0 & issue == 19

drop issue

////3520935207010
br hid-s1aq8b tot_consumed if hid =="3520935207010"  & s1aq1==143
recode s1aq7a (1=6) if hid =="3520935207010" & s1aq1==143
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 143 & hid == "3520935207010"


////4311743142007
br hid-s1aq8b tot_consumed if hid =="4311743142007"  & s1aq1==143
recode s1aq5 (7=35) if hid =="4311743142007" & s1aq1==143
recode s1aq6a (35=7) if hid =="4311743142007" & s1aq1==143
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 143 & hid == "4311743142007"
replace s1aq6b = 6 if s1aq6b == 7 & s1aq1 == 143 & hid == "4311743142007"


///4111041113014
br hid-s1aq8b tot_consumed if hid =="4111041113014"  & s1aq1==143
recode s1aq3a (1=2) if hid =="4111041113014" & s1aq1==143
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 143 & hid == "4111041113014"


////4311543124002
br hid-s1aq8b tot_consumed if hid =="4311543124002"  & s1aq1==143
recode s1aq7a (6=.) if hid =="4311543124002" & s1aq1==143
recode s1aq6a (20=2) if hid =="4311543124002" & s1aq1==143
recode s1aq5 (6=20) if hid =="4311543124002" & s1aq1==143
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 143 & hid == "4311543124002"
replace s1aq7b = . if s1aq7b == 0 & s1aq1 == 143 & hid == "4311543124002"


///4111041113004
br hid-s1aq8b tot_consumed if hid =="4111041113004"  & s1aq1==143
recode s1aq7a (1=.) if hid =="4111041113004" & s1aq1==143
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 143 & hid == "4111041113004"
replace s1aq7b = . if s1aq7b == 6 & s1aq1 == 143 & hid == "4111041113004"


///3410334108004
br hid-s1aq8b tot_consumed if hid =="3410334108004"  & s1aq1==143
recode s1aq6a (6=3) if hid =="3410334108004" & s1aq1==143
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 143 & hid == "3410334108004"


////3421234203002
br hid-s1aq8b tot_consumed if hid =="3421234203002"  & s1aq1==143
recode s1aq8a (6=.) if hid =="3421234203002" & s1aq1==143
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 143 & hid == "3421234203002"
replace s1aq8b = . if s1aq8b == 6 & s1aq1 == 143 & hid == "3421234203002"


////3810438110003
br hid-s1aq8b tot_consumed if hid =="3810438110003"  & s1aq1==143
recode s1aq7a (1=.) if hid =="3810438110003" & s1aq1==143
recode s1aq8a (.=3) if hid =="3810438110003" & s1aq1==143
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 143 & hid == "3810438110003"
replace s1aq7b = . if s1aq7b == 6 & s1aq1 == 143 & hid == "3810438110003"
replace s1aq8b = 6 if s1aq8b == . & s1aq1 == 143 & hid == "3810438110003"


///3511335106006
br hid-s1aq8b tot_consumed if hid =="3511335106006"  & s1aq1==143
recode s1aq6a (6=2) if hid =="3511335106006" & s1aq1==143
recode s1aq5 (2=20) if hid =="3511335106006" & s1aq1==143
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 143 & hid == "3511335106006"
replace s1aq6b = 6 if s1aq6b == 0 & s1aq1 == 143 & hid == "3511335106006"



************** 145 lettuce *************
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 145 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a!=. & s1aq7a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 20 if s1aq1  == 145 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a!=. & s1aq7a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = . if s1aq7a == 1 & issue == 20 
replace s1aq7b = . if s1aq7b == 6 & issue == 20

drop issue 




////3520735220016
br hid-s1aq8b tot_consumed if hid =="3520735220016"  & s1aq1==145
recode s1aq6a (.=4) if hid =="3520735220016" & s1aq1==145
recode s1aq5 (20=40) if hid =="3520735220016" & s1aq1==145
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 145 & hid == "3520735220016"
replace s1aq6b = 6 if s1aq6b == . & s1aq1 == 145 & hid == "3520735220016"


////4011440105005
br hid-s1aq8b tot_consumed if hid =="4011440105005"  & s1aq1==145
recode s1aq7a (1=11) if hid =="4011440105005" & s1aq1==145
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 145 & hid == "4011440105005"


////3721137208002
br hid-s1aq8b tot_consumed if hid =="3721137208002"  & s1aq1==145
recode s1aq3a (2=3) if hid =="3721137208002" & s1aq1==145
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 145 & hid == "3721137208002"
replace s1aq4b = 11 if s1aq4b == 6 & s1aq1 == 145 & hid == "3721137208002"
replace s1aq6b = 11 if s1aq6b == 6 & s1aq1 == 145 & hid == "3721137208002"


////4311543116003
br hid-s1aq8b tot_consumed if hid =="4311543116003"  & s1aq1==145
recode s1aq6a (3=4) if hid =="4311543116003" & s1aq1==145
recode s1aq5 (15=40) if hid =="4311543116003" & s1aq1==145
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 145 & hid == "4311543116003"


///3610536105008
br hid-s1aq8b tot_consumed if hid =="3610536105008"  & s1aq1==145
recode s1aq3a (1=2) if hid =="3610536105008" & s1aq1==145
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 145 & hid == "3610536105008"


/////3610636104012
br hid-s1aq8b tot_consumed if hid =="3610636104012"  & s1aq1==145
recode s1aq5 (5=10) if hid =="3610636104012" & s1aq1==145
recode s1aq7a (1=.) if hid =="3610636104012" & s1aq1==145
recode s1aq8a (1=.) if hid =="3610636104012" & s1aq1==145
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 145 & hid == "3610636104012"
replace s1aq4b = 11 if s1aq4b == 6 & s1aq1 == 145 & hid == "3610636104012"
replace s1aq6b = 11 if s1aq6b == 6 & s1aq1 == 145 & hid == "3610636104012"
replace s1aq7b = . if s1aq7b == 6 & s1aq1 == 145 & hid == "3610636104012"
replace s1aq8b = . if s1aq8b == 6 & s1aq1 == 145 & hid == "3610636104012"



**************** 151 leafy or stem vegetables ****************
///4011440105015
br hid-s1aq8b tot_consumed if hid =="4011440105015"  & s1aq1==151
recode s1aq7a (1=.) if hid =="4011440105015" & s1aq1==151
recode s1aq3a (6=7) if hid =="4011440105015" & s1aq1==151
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 151 & hid == "4011440105015"
replace s1aq7b = . if s1aq7b == 6 & s1aq1 == 151 & hid == "4011440105015"


///3610236101001
br hid-s1aq8b tot_consumed if hid =="3610236101001"  & s1aq1==151
recode s1aq7a (10=.) if hid =="3610236101001" & s1aq1==151
recode s1aq6a (11=10) if hid =="3610236101001" & s1aq1==151
recode s1aq4a (0=10) if hid =="3610236101001" & s1aq1==151
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 151 & hid == "3610236101001"
replace s1aq7b = . if s1aq7b == 10 & s1aq1 == 151 & hid == "3610236101001"
replace s1aq6b = 11 if s1aq6b == 0 & s1aq1 == 151 & hid == "3610236101001"



************** 157 pumpkin ***************
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 157 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a!=. & s1aq7a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 21 if s1aq1  == 157 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a!=. & s1aq7a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = s1aq6a if s1aq7a == 1 & issue == 21
replace s1aq6a = s1aq4a if s1aq6a == 2 & issue == 21
replace s1aq6a = s1aq4a if s1aq6a == 4 & issue == 21
replace s1aq6a = s1aq4a if s1aq6a == 21 & issue == 21
replace s1aq6a = s1aq4a if s1aq6a == 28 & issue == 21

replace s1aq3b = 6 if s1aq3b == 0 & issue == 21
replace s1aq6b = s1aq4b if s1aq6b == 6 & issue == 21

drop issue

///4022440219016
br hid-s1aq8b tot_consumed if hid =="4022440219016"  & s1aq1==157
recode s1aq8a (6=2) if hid =="4022440219016" & s1aq1==157
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 157 & hid == "4022440219016"
replace s1aq8b = 6 if s1aq8b == 0 & s1aq1 == 157 & hid == "4022440219016"


///3721237203009
br hid-s1aq8b tot_consumed if hid =="3721237203009"  & s1aq1==157
recode s1aq6a (6=.) if hid =="3721237203009" & s1aq1==157
recode s1aq8a (1=6) if hid =="3721237203009" & s1aq1==157
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 157 & hid == "3721237203009"
replace s1aq6b = . if s1aq6b == 6 & s1aq1 == 157 & hid == "3721237203009"


////3720437211011
br hid-s1aq8b tot_consumed if hid =="3720437211011"  & s1aq1==157
recode s1aq4a (0=2) if hid =="3720437211011" & s1aq1==157
recode s1aq8a (1=.) if hid =="3720437211011" & s1aq1==157
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 157 & hid == "3720437211011"
replace s1aq4b = 6 if s1aq4b == 8 & s1aq1 == 157 & hid == "3720437211011"
replace s1aq8b = . if s1aq8b == 6 & s1aq1 == 157 & hid == "3720437211011"


///3610536108014
br hid-s1aq8b tot_consumed if hid =="3610536108014"  & s1aq1==157
recode s1aq6a (4=3) if hid =="3610536108014" & s1aq1==157
recode s1aq5 (15=30) if hid =="3610536108014" & s1aq1==157
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 157 & hid == "3610536108014"
replace s1aq4b = 6 if s1aq4b == 3 & s1aq1 == 157 & hid == "3610536108014"


///3810438110012
br hid-s1aq8b tot_consumed if hid =="3810438110012"  & s1aq1==157
recode s1aq7a (2=.) if hid =="3810438110012" & s1aq1==157
recode s1aq8a (2=.) if hid =="3810438110012" & s1aq1==157
recode s1aq5 (15=30) if hid =="3810438110012" & s1aq1==157
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 157 & hid == "3810438110012"
replace s1aq7b = . if s1aq7b == 2 & s1aq1 == 157 & hid == "3810438110012"
replace s1aq8b = . if s1aq8b == 2 & s1aq1 == 157 & hid == "3810438110012"


////3710537105002
br hid-s1aq8b tot_consumed if hid =="3710537105002"  & s1aq1==157
recode s1aq6a (2=.) if hid =="3710537105002" & s1aq1==157
recode s1aq8a (1=2) if hid =="3710537105002" & s1aq1==157
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 157 & hid == "3710537105002"
replace s1aq6b = . if s1aq6b == 6 & s1aq1 == 157 & hid == "3710537105002"


////4210342104015
br hid-s1aq8b tot_consumed if hid =="4210342104015"  & s1aq1==157
recode s1aq6a (.=7) if hid =="4210342104015" & s1aq1==157
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 157 & hid == "4210342104015"
replace s1aq6b = 6 if s1aq6b == . & s1aq1 == 157 & hid == "4210342104015"


////4111241102006
br hid-s1aq8b tot_consumed if hid =="4111241102006"  & s1aq1==157
recode s1aq8a (6=7) if hid =="4111241102006" & s1aq1==157
replace s1aq3b = 6 if s1aq3b == 0 & s1aq1 == 157 & hid == "4111241102006"
replace s1aq8b = 6 if s1aq8b == 0 & s1aq1 == 157 & hid == "4111241102006"



**************** 144 spinarch ( kerenkren **********
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 144 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 22 if s1aq1  == 144 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = . if s1aq7a == 11 & issue == 22
replace s1aq7a = s1aq3a if s1aq7a == . & issue == 22
replace s1aq8a = . if s1aq8a == 11 & issue == 22

replace s1aq3b = 11 if s1aq3b == 0 & issue == 22
replace s1aq7b = 11 if s1aq7b == . & issue == 22
replace s1aq7b = 11 if s1aq7b == 0 & issue == 22
replace s1aq8b = . if s1aq8b == 0 & issue == 22

drop issue


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 144 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 23 if s1aq1  == 144 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = s1aq3a if s1aq7a == 1 & issue == 23
replace s1aq6a = s1aq4a if s1aq6a == 21 & issue == 23
replace s1aq6a = s1aq4a if s1aq6a == 12 & issue == 23
replace s1aq6a = s1aq4a if s1aq6a == 9 & issue == 23
replace s1aq6a = s1aq4a if s1aq6a == 4 & issue == 23


replace s1aq3b = 11 if s1aq3b == 0 & issue == 23
replace s1aq7b = s1aq3b if s1aq7b == 6 & issue == 23
replace s1aq6b = . if s1aq6b == 6 & issue == 23


drop issue


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 144 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 24 if s1aq1  == 144 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq6a = s1aq3a if issue == 24
replace s1aq5 = 50 if s1aq5 == 10 & issue == 24

replace s1aq3b = 11 if s1aq3b == 0 & issue == 24
replace s1aq6b = 11 if s1aq6b == . & issue == 24

drop issue


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 144 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a!=. & s1aq7a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 25 if  s1aq1  == 144 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a!=. & s1aq7a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq4a  = s1aq3a if s1aq4a ==0 & issue == 25
replace s1aq6a  = s1aq3a if s1aq6a ==1 & issue == 25
replace s1aq6a  = s1aq3a if s1aq6a ==11 & issue == 25
replace s1aq7a  = s1aq8a if s1aq7a ==1 & issue == 25
replace s1aq7a  = s1aq8a if s1aq7a ==2 & issue == 25
replace s1aq7a  = s1aq8a if s1aq7a ==6 & issue == 25


replace s1aq3b = 11 if s1aq3b  == 0 & issue == 25
replace s1aq4b = s1aq3b if s1aq4b == 6 & issue == 25
replace s1aq6b = s1aq3b if s1aq6b == 6 & issue == 25
replace s1aq6b = s1aq3b if s1aq6b == 0 & issue == 25
replace s1aq7b = . if s1aq7b == 6 & issue == 25
replace s1aq7b = . if s1aq7b == 11 & issue == 25

drop issue




**br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 144 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a==. & s1aq7a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

**gen issue = 26 if s1aq1  == 144 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a==. & s1aq7a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

/*replace s1aq7a = 1 if s1aq7a == 11 & issue == 26
replace s1aq3a = s1aq7a if s1aq3a == 11 & issue == 26
replace s1aq3a = s1aq7a if s1aq3a == 4 & issue == 26

replace s1aq3b = 11 if s1aq3b == 0 & issue == 26
replace s1aq4b = s1aq3b if s1aq4b == 6 & issue == 26
replace s1aq7b = s1aq3b if s1aq7b == 6 & issue == 26
replace s1aq7b = s1aq3b if s1aq7b == 0 & issue == 26

drop issue
*/


/*br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 144 & s1aq3a!=. & s1aq4a==. & s1aq5!=. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 27 if s1aq1  == 144 & s1aq3a!=. & s1aq4a==. & s1aq5!=. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq5 = . if s1aq5 == 30 & issue == 27
replace s1aq5 = . if s1aq5 == 18 & issue == 27
replace s1aq7a = 9 if s1aq7a == 11 & issue == 27
replace s1aq8a =. if s1aq8a == 15 & issue == 27

replace s1aq3b = 11 if s1aq3b == 0 & issue == 27
replace s1aq7b = s1aq3b if s1aq7b == 0 & issue == 27

drop issue 
*/

/*br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 144 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!= s1aq3a & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 28 if s1aq1  == 144 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!= s1aq3a & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq6a = 7 if s1aq6a == 14 & issue == 28
replace s1aq5 = 70 if s1aq5 == 14 & issue == 28
replace s1aq3a = 2 if s1aq3a == 20 & issue == 28
replace s1aq4a = 2 if s1aq4a == 20 & issue == 28
replace s1aq3a = 1 if s1aq3a == 11 & issue == 28
replace s1aq4a = 1 if s1aq4a == 11 & issue == 28
replace s1aq6a = 1 if s1aq6a == 5 & issue == 28
replace s1aq5 = 10 if s1aq5 == 95 & issue == 28

replace s1aq3b = 11 if s1aq3b == 0 & issue == 28
replace s1aq4b = s1aq3b if s1aq4b == 5 & issue == 28
replace s1aq6b = s1aq3b if s1aq6b == 7 & issue == 28
drop issue
*/



///3810638106001
br hid-s1aq8b tot_consumed if hid =="3810638106001"  & s1aq1==144
recode s1aq7a (.=11) if hid =="3810638106001" & s1aq1==144
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 144 & hid == "3810638106001"
replace s1aq7b = 11 if s1aq7b == . & s1aq1 == 144 & hid == "3810638106001"
replace s1aq4b = 11 if s1aq4b == 0 & s1aq1 == 144 & hid == "3810638106001"


******************** 146 sorrel (bisap) ***************

br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 146 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!= s1aq3a & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 29 if s1aq1  == 146 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!= s1aq3a & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq6a = 3 if s1aq6a == 2 & hid == "4311143106006" & issue == 29
replace s1aq5 = 30 if s1aq5 == 6 & hid == "4311143106006"& issue == 29
replace s1aq3a = 6 if s1aq3a == 1 & hid == "3821038204004" & issue == 29
replace s1aq4a = 6 if  s1aq4a == 11 & hid == "3821038204004"& issue == 29
replace s1aq6a = 4 if s1aq6a == . & hid == "3520935207003" & issue == 29
replace s1aq5 = 40 if s1aq5 == 20 & hid == "3520935207003" & issue == 29
replace s1aq3a = 3 if s1aq3a == 2 & hid == "3511335106016" & issue == 29
replace s1aq5 = 40 if s1aq5 == 20 & hid == "3511335106016" & issue == 29
replace s1aq6a = 8 if s1aq6a == 11 & hid == "4311543131008" & issue == 29
replace s1aq5 = 80 if s1aq5 == 8 & hid == "4311543131008" & issue == 29
replace s1aq6a = 2 if s1aq6a == . & hid == "4311543108004" & issue == 29
replace s1aq3a = 7 if s1aq3a == 6 & hid == "3522535216001" & issue == 29
replace s1aq5 = 70 if s1aq5 == 35 & hid == "3522535216001" & issue == 29
replace s1aq6a = 7 if s1aq6a == 140 & hid == "3821038204012" & issue == 29
replace s1aq4a = 7 if s1aq4a == 140 & hid == "3821038204012" & issue == 29
replace s1aq5 = 70 if s1aq5 == 7 & hid == "3821038204012"& issue == 29
replace s1aq3a = 6 if s1aq3a == 5 & hid == "3610536105005" & issue == 29
replace s1aq5 = 60 if s1aq5 == 25 &  hid == "3610536105005" & issue == 29
replace s1aq3a = 1 if s1aq3a == 11 & hid == "4220642204003" & issue == 29
replace s1aq6a = 2 if s1aq6a == . & hid == "4010240101006" & issue == 29
replace s1aq3a = 4 if s1aq3a == 8 & hid == "3410334103009" & issue == 29
replace s1aq4a = 4 if s1aq4a == 8 & hid == "3410334103009" & issue == 29
replace s1aq6a = 9 if s1aq6a == 11 & hid == "4311543131012" & issue == 29
replace s1aq5 = 90 if s1aq5 == 9 & hid == "4311543131012" & issue == 29
replace s1aq3a = 1 if s1aq3a == 11 & hid == "4010840110003" & issue == 29
replace s1aq5 = 10 if s1aq5 == 5 & hid == "4010840110003" & issue == 29

replace s1aq3b = 11 if s1aq3b == 0 & issue == 29
replace s1aq4b = 11 if s1aq4b == 1 & issue == 29
replace s1aq6b = 11 if s1aq6b == . & issue == 29
replace s1aq6b = 11 if s1aq6b == 0 & issue == 29


drop issue

br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 146 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 30 if s1aq1  == 146 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = s1aq3a if s1aq7a == . & issue == 30
replace s1aq7a = 10 if s1aq7a == 11 & issue == 30
replace s1aq7a = 6 if s1aq7a == 3 & issue == 30
replace s1aq8a = . if s1aq8a == 11 & issue == 30
replace s1aq8a = . if s1aq8a == 2 & issue == 30

replace s1aq3b = 11 if s1aq3b == 0 & issue == 30
replace s1aq7b = 11 if s1aq7b == . & issue == 30
replace s1aq7b = 11 if s1aq7b == 0 & issue == 30
replace s1aq8b = . if s1aq8b == 11 & issue == 30
replace s1aq8b = . if s1aq8b == 0 & issue == 30
replace s1aq8b = . if s1aq8b == 2 & issue == 30

drop issue


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 146 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 31 if s1aq1  == 146 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = s1aq3a if s1aq7a == 1 & issue == 31
replace s1aq7a = s1aq3a if s1aq7a == 3 & issue == 31

replace s1aq6a = s1aq4a if s1aq6a == 2 & issue == 31
replace s1aq6a = s1aq4a if s1aq6a == 3 & issue == 31
replace s1aq6a = s1aq4a if s1aq6a == 4 & issue == 31
replace s1aq6a = s1aq4a if s1aq6a == 6 & issue == 31
replace s1aq6a = s1aq4a if s1aq6a == 7 & issue == 31
replace s1aq6a = s1aq4a if s1aq6a == 8 & issue == 31
replace s1aq6a = s1aq4a if s1aq6a == 14 & issue == 31
replace s1aq6a = s1aq4a if s1aq6a == 28 & issue == 31
replace s1aq6a = s1aq4a if s1aq6a == 17 & issue == 31
replace s1aq6a = s1aq4a if s1aq6a == 21 & issue == 31

replace s1aq3b = 11 if s1aq3b == 0 & issue == 31
replace s1aq6b = . if s1aq6b == 6 & issue == 31
replace s1aq6b = . if s1aq6b == 11 & issue == 31
replace s1aq7b = 11 if s1aq7b == 6 & issue == 31

drop issue

br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 146 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 32 if s1aq1  == 146 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = . if s1aq7a == 1 & issue == 32
replace s1aq7a = . if s1aq7a == 2 & issue == 32
replace s1aq7a = . if s1aq7a == 5 & issue == 32
replace s1aq7a = . if s1aq7a == 6 & issue == 32
replace s1aq7a = . if s1aq7a == 7 & issue == 32
replace s1aq7a = . if s1aq7a == 8 & issue == 32
replace s1aq7a = . if s1aq7a == 11 & issue == 32
replace s1aq7a = . if s1aq7a == 12 & issue == 32

replace s1aq3a = 11 if s1aq3a == 7 & hid == "4021340215004" & issue == 32
replace s1aq3a = 11 if s1aq3a == 3 & hid == "3330533320010" & issue == 32
replace s1aq4a = 11 if s1aq4a == 0 & hid == "3330533320010" & issue == 32
replace s1aq6a = 5 if s1aq6a == 11 & hid == "3610236101001" & issue == 32
replace s1aq4a = 5 if s1aq4a == 0 & hid == "3610236101001" & issue == 32
replace s1aq3a = 10 if s1aq3a == 8 & issue == 32
replace s1aq6a = 6 if s1aq6a == 11 & hid == "3410234119015" & issue == 32
replace s1aq4a = 6 if s1aq4a == 0 & hid == "3410234119015" & issue == 32
replace s1aq3a = 10 if s1aq3a == 12 & hid == "3520335204007" & issue == 32
replace s1aq6a = 2 if s1aq6a == 11 & hid == "3421034211009" & issue == 32
replace s1aq4a = 2 if s1aq4a == 0 & hid == "3421034211009" & issue == 32
replace s1aq6a = 7 if s1aq6a == 20 & hid == "3621636211002" & issue == 32

replace s1aq3b = 11 if s1aq3b == 0 & issue == 32
replace s1aq4b = 11 if s1aq4b == 6 & issue == 32
replace s1aq6b = 11 if s1aq6b == 6 & issue == 32
replace s1aq6b = 11 if s1aq6b == 0 & issue == 32
replace s1aq6b = 11 if s1aq6b == 7 & issue == 32

replace s1aq7b = . if s1aq7b == 11 & issue == 32
replace s1aq7b = . if s1aq7b == 0 & issue == 32
replace s1aq7b = . if s1aq7b == 6 & issue == 32
replace s1aq7b = . if s1aq7b == 3 & issue == 32

replace s1aq8a = . if s1aq8a == 11 & issue == 32
replace s1aq8b = . if s1aq8b == 0 & issue == 32

drop issue 


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 146 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq7a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 33 if s1aq1  == 146 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq7a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq8a = . if s1aq8a == 2 & issue == 33
replace s1aq6a = 4 if s1aq6a == 8 & hid == "3520935207003" & issue == 33
replace s1aq3a = 3 if s1aq3a == 2 & hid == "3511335106016" & issue == 33
replace s1aq5 = 40 if s1aq5 == 20 & hid == "3520935207003" & issue == 33
replace s1aq5 = 80 if s1aq5 == 10 & hid == "4320443201009" & issue == 33
replace s1aq6a = 2 if s1aq6a  == 3 & hid == "4311543108004" & issue == 33
replace s1aq3a = 1 if s1aq3a == 7 & hid == "4220642204003" & issue == 33
replace s1aq6a = 2 if s1aq6a == 3 & hid == "4010240101006" & issue == 33
replace s1aq3a = 1 if s1aq3a == 7 & hid == "4010840110003" & issue == 33

replace s1aq3b = 11 if s1aq3b == 0 & issue == 33
replace s1aq4b = 11 if s1aq4b == 1 & issue == 33
replace s1aq6b = 11 if s1aq6b == . & issue == 33
replace s1aq8b = . if s1aq8b == 11 & issue == 33

drop issue


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 146 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a==. & s1aq7a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 34 if  s1aq1  == 146 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a==. & s1aq7a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = s1aq3a if s1aq7a ==. & issue == 34
replace s1aq3b = 11 if s1aq3b == 0 & issue == 34
replace s1aq7b = s1aq3b if s1aq7b == . & issue == 34
replace s1aq8a = . if s1aq8a == 11 & issue == 34
replace s1aq8b = . if s1aq8b == 0 & issue == 34

drop issue


///4021840212014
br hid-s1aq8b tot_consumed if hid =="4021840212014"  & s1aq1==146
recode s1aq4a (.=4) if hid =="4021840212014" & s1aq1==146
recode s1aq7a (1=.) if hid =="4021840212014" & s1aq1==146
recode s1aq5 (90=40) if hid =="4021840212014" & s1aq1==146
replace s1aq3b = 11 if s1aq3b == 0 & s1aq1 == 146 & hid == "4021840212014"
replace s1aq4b = 11 if s1aq4b == . & s1aq1 == 146 & hid == "4021840212014"
replace s1aq6b = 11 if s1aq6b == 6 & s1aq1 == 146 & hid == "4021840212014"
replace s1aq7b = . if s1aq7b == 6 & s1aq1 == 146 & hid == "4021840212014"


///4021340215004
br hid-s1aq8b tot_consumed if hid =="4021340215004"  & s1aq1==146
recode s1aq3a (11=7) if hid =="4021340215004" & s1aq1==146


///3510235111007
br hid-s1aq8b tot_consumed if hid =="3510235111007"  & s1aq1==146
recode s1aq3a (7=11) if hid =="3510235111007" & s1aq1==146



///4320443201009
br hid-s1aq8b tot_consumed if hid =="4320443201009"  & s1aq1==146
recode s1aq8a (2=.) if hid =="4320443201009" & s1aq1==146
recode s1aq8b (11=.) if hid =="4320443201009" & s1aq1==146


///4021840212003
br hid-s1aq8b tot_consumed if hid =="4021840212003"  & s1aq1==146
recode s1aq5 (22=20) if hid =="4021840212003" & s1aq1==146
recode s1aq7a (2=.) if hid =="4021840212003" & s1aq1==146
recode s1aq8a (2=.) if hid =="4021840212003" & s1aq1==146
recode s1aq7b (2=.) if hid =="4021840212003" & s1aq1==146
recode s1aq8b (2=.) if hid =="4021840212003" & s1aq1==146
recode s1aq6b (2=11) if hid =="4021840212003" & s1aq1==146
recode s1aq4b (2=11) if hid =="4021840212003" & s1aq1==146
recode s1aq3a (11=0) if hid =="4021840212003" & s1aq1==146



///4311743142010
br hid-s1aq8b tot_consumed if hid =="4311743142010"  & s1aq1==146
recode s1aq7a (3=2) if hid =="4311743142010" & s1aq1==146
recode s1aq3b (0=11) if hid =="4311743142010" & s1aq1==146


///4210442101014
br hid-s1aq8b tot_consumed if hid =="4210442101014"  & s1aq1==146
recode s1aq7a (3=2) if hid =="4210442101014" & s1aq1==146
recode s1aq3b (0=11) if hid =="4210442101014" & s1aq1==146
recode s1aq8a (3=.) if hid =="4210442101014" & s1aq1==146
recode s1aq8b (11=.) if hid =="4210442101014" & s1aq1==146



///4010840110001
br hid-s1aq8b tot_consumed if hid =="4010840110001"  & s1aq1==146
recode s1aq7a (2=4) if hid =="4010840110001" & s1aq1==146
recode s1aq3b (0=11) if hid =="4010840110001" & s1aq1==146


///4210242106008
br hid-s1aq8b tot_consumed if hid =="4210242106008"  & s1aq1==146
recode s1aq3a (7=1) if hid =="4210242106008" & s1aq1==146
recode s1aq3b (0=11) if hid =="4210242106008" & s1aq1==146
recode s1aq4a (0=.) if hid =="4210242106008" & s1aq1==146
recode s1aq4b (6=.) if hid =="4210242106008" & s1aq1==146
recode s1aq7b (6=11) if hid =="4210242106008" & s1aq1==146


///3610636103004
br hid-s1aq8b tot_consumed if hid =="3610636103004"  & s1aq1==146
recode s1aq7a (3=4) if hid =="3610636103004" & s1aq1==146
recode s1aq3b (0=11) if hid =="3610636103004" & s1aq1==146
recode s1aq4a (0=.) if hid =="3610636103004" & s1aq1==146
recode s1aq4b (11=.) if hid =="3610636103004" & s1aq1==146


************* 84 fresh cow milk ************
///3721137209003
br hid-s1aq8b tot_consumed if hid =="3721137209003"  & s1aq1==84
recode s1aq6a (2=1) if hid =="3721137209003" & s1aq1==84
replace s1aq3b = 13 if s1aq3b == 0 & s1aq1 == 84 & hid == "3721137209003"


///3821338205004
br hid-s1aq8b tot_consumed if hid =="3821338205004"  & s1aq1==84
recode s1aq6a (2=1) if hid =="3821338205004" & s1aq1==84
replace s1aq3b = 13 if s1aq3b == 0 & s1aq1 == 84 & hid == "3821338205004"

///6210262113011
br hid-s1aq8b tot_consumed if hid =="6210262113011"  & s1aq1==84
recode s1aq3a (10.5=21) if hid =="6210262113011" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0 & s1aq1 == 84 & hid == "6210262113011"

///6210362118007
br hid-s1aq8b tot_consumed if hid =="6210362118007"  & s1aq1==84
recode s1aq3a (7=9) if hid =="6210362118007" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "6210362118007"
replace s1aq6b = 3 if s1aq6b == 0  & s1aq1 == 84 & hid == "6210362118007"

///6211662120014
br hid-s1aq8b tot_consumed if hid =="6211662120014"  & s1aq1==84
recode s1aq3a (2=8) if hid =="6211662120014" & s1aq1==84
recode s1aq6a (3=2) if hid =="6211662120014" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "6211662120014"
replace s1aq6b = 3 if s1aq6b == 0  & s1aq1 == 84 & hid == "6211662120014"

///8220182233010
br hid-s1aq8b tot_consumed if hid =="8220182233010"  & s1aq1==84
recode s1aq8a (2=.) if hid =="8220182233010" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "8220182233010"

///5211652115014
br hid-s1aq8b tot_consumed if hid =="5211652115014"  & s1aq1==84
recode s1aq3a (31=5) if hid =="5211652115014" & s1aq1==84
recode s1aq4a (21=5) if hid =="5211652115014" & s1aq1==84
recode s1aq6a (21=5) if hid =="5211652115014" & s1aq1==84
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 84 & hid == "5211652115014"

////5211452119006
br hid-s1aq8b tot_consumed if hid =="5211452119006"  & s1aq1==84
recode s1aq4a (22=2) if hid =="5211452119006" & s1aq1==84
recode s1aq6a (22=2) if hid =="5211452119006" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "5211452119006"

///6122661205001
br hid-s1aq8b tot_consumed if hid =="6122661205001"  & s1aq1==84
recode s1aq7a (.=3) if hid =="6122661205001" & s1aq1==84
replace s1aq3b = 1 if s1aq3b == 0  & s1aq1 == 84 & hid == "6122661205001"


///5542255410014
br hid-s1aq8b tot_consumed if hid =="5542255410014"  & s1aq1==84
recode s1aq3a (191=1) if hid =="5542255410014" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "5542255410014"

///3810338108005
br hid-s1aq8b tot_consumed if hid =="3810338108005"  & s1aq1==84
recode s1aq8a (1=.) if hid =="3810338108005" & s1aq1==84
replace s1aq3b = 13 if s1aq3b == 0  & s1aq1 == 84 & hid == "3810338108005"

///6121661217008
br hid-s1aq8b tot_consumed if hid =="6121661217008"  & s1aq1==84
recode s1aq3a (25=1) if hid =="6121661217008" & s1aq1==84
replace s1aq3b = 4 if s1aq3b == 0  & s1aq1 == 84 & hid == "6121661217008"


///7012570110009
br hid-s1aq8b tot_consumed if hid =="7012570110009"  & s1aq1==84
recode s1aq3a (12=3) if hid =="7012570110009" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "7012570110009"

///4220442209005
br hid-s1aq8b tot_consumed if hid =="4220442209005"  & s1aq1==84
recode s1aq8a (1=.) if hid =="4220442209005" & s1aq1==84
replace s1aq3b = 13 if s1aq3b == 0  & s1aq1 == 84 & hid == "4220442209005"
replace s1aq8b = . if s1aq8b == 13  & s1aq1 == 84 & hid == "4220442209005"

///4021040223014
br hid-s1aq8b tot_consumed if hid =="4021040223014"  & s1aq1==84
recode s1aq3a (.1=1) if hid =="4021040223014" & s1aq1==84
recode s1aq7a (.=1) if hid =="4021040223014" & s1aq1==84
recode s1aq8a (.1=.) if hid =="4021040223014" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "4021040223014"


///4120341211016
br hid-s1aq8b tot_consumed if hid =="4120341211016"  & s1aq1==84
recode s1aq3a (1=7) if hid =="4120341211016" & s1aq1==84
recode s1aq4a (1=7) if hid =="4120341211016" & s1aq1==84
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 84 & hid == "4120341211016"
replace s1aq4b = 6 if s1aq4b == 13  & s1aq1 == 84 & hid == "4120341211016"


///8620186223006
br hid-s1aq8b tot_consumed if hid =="8620186223006"  & s1aq1==84
recode s1aq7a (15=12) if hid =="8620186223006" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "8620186223006"

///6010160108004
br hid-s1aq8b tot_consumed if hid =="6010160108004"  & s1aq1==84
recode s1aq6a (2=3) if hid =="6010160108004" & s1aq1==84
replace s1aq3b = 2 if s1aq3b == 0  & s1aq1 == 84 & hid == "6010160108004"


///6120461201009
br hid-s1aq8b tot_consumed if hid =="6120461201009"  & s1aq1==84
recode s1aq4a (44=4) if hid =="6120461201009" & s1aq1==84
recode s1aq6a (44=4) if hid =="6120461201009" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "6120461201009"

///4010840108011
br hid-s1aq8b tot_consumed if hid =="4010840108011"  & s1aq1==84
recode s1aq6a (1=6) if hid =="4010840108011" & s1aq1==84
replace s1aq3b = 7 if s1aq3b == 0  & s1aq1 == 84 & hid == "4010840108011"


///4022440219001
br hid-s1aq8b tot_consumed if hid =="4022440219001"  & s1aq1==84
recode s1aq4a (.=3) if hid =="4022440219001" & s1aq1==84
recode s1aq5 (3=75) if hid =="4022440219001" & s1aq1==84
recode s1aq6a (75=3) if hid =="4022440219001" & s1aq1==84
recode s1aq7a (3=.) if hid =="4022440219001" & s1aq1==84
replace s1aq7b = . if s1aq7b == 0  & s1aq1 == 84 & hid == "4022440219001"
replace s1aq3b = 1 if s1aq3b == 0  & s1aq1 == 84 & hid == "4022440219001"


///3511835102014
br hid-s1aq8b tot_consumed if hid =="3511835102014"  & s1aq1==84
recode s1aq6a (3=.) if hid =="3511835102014" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "3511835102014"


///5222252205016
br hid-s1aq8b tot_consumed if hid =="5222252205016"  & s1aq1==84
recode s1aq7a (3=.) if hid =="5222252205016" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "5222252205016"

///4520745203001
br hid-s1aq8b tot_consumed if hid =="4520745203001"  & s1aq1==84
recode s1aq7a (.=2) if hid =="4520745203001" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "4520745203001"
replace s1aq7b = 3 if s1aq7b == .  & s1aq1 == 84 & hid == "4520745203001"

///4020340202003// verify with Janneh
br hid-s1aq8b tot_consumed if hid =="4020340202003"  & s1aq1==84
recode s1aq3a (.1=1) if hid =="4020340202003" & s1aq1==84
recode s1aq4a (.1=1) if hid =="4020340202003" & s1aq1==84
recode s1aq6a (.1=1) if hid =="4020340202003" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "4020340202003"

///4121041204001
br hid-s1aq8b tot_consumed if hid =="4121041204001"  & s1aq1==84
recode s1aq7a (1=.) if hid =="4121041204001" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "4121041204001"

///6020160224006
br hid-s1aq8b tot_consumed if hid =="6020160224006"  & s1aq1==84
recode s1aq7a (21=.) if hid =="6020160224006" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "6020160224006"


///7440574420012
br hid-s1aq8b tot_consumed if hid =="7440574420012"  & s1aq1==84
recode s1aq3a (10=1) if hid =="7440574420012" & s1aq1==84
replace s1aq3b = 1 if s1aq3b == 0  & s1aq1 == 84 & hid == "7440574420012"

///3721137209014
br hid-s1aq8b tot_consumed if hid =="3721137209014"  & s1aq1==84
recode s1aq6a (1=3) if hid =="3721137209014" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "3721137209014"

///6022260212015
br hid-s1aq8b tot_consumed if hid =="6022260212015"  & s1aq1==84
recode s1aq4a (3=2) if hid =="6022260212015" & s1aq1==84
recode s1aq6a (3=2) if hid =="6022260212015" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "6022260212015"


///5121251218012
br hid-s1aq8b tot_consumed if hid =="5121251218012"  & s1aq1==84
recode s1aq6a (.=5) if hid =="5121251218012" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "5121251218012"

///3421234208009
br hid-s1aq8b tot_consumed if hid =="3421234208009"  & s1aq1==84
recode s1aq7a (.=1) if hid =="3421234208009" & s1aq1==84
replace s1aq3b = 13 if s1aq3b == 0  & s1aq1 == 84 & hid == "3421234208009"
replace s1aq7b = 13 if s1aq7b == .  & s1aq1 == 84 & hid == "3421234208009"


///4020540221007
br hid-s1aq8b tot_consumed if hid =="4020540221007"  & s1aq1==84
recode s1aq6a (.=5) if hid =="4020540221007" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "4020540221007"
replace s1aq6b = 3 if s1aq6b == .  & s1aq1 == 84 & hid == "4020540221007"

///5321053215005// verify with Janneh no unit of measurement
br hid-s1aq8b tot_consumed if hid =="5321053215005"  & s1aq1==84
recode s1aq8a (.=1) if hid =="5321053215005" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "5321053215005"
replace s1aq8b = 3 if s1aq8b == .  & s1aq1 == 84 & hid == "5321053215005"


///6411864118007// verify with Janneh why this is bunch/heap
br hid-s1aq8b tot_consumed if hid =="6411864118007"  & s1aq1==84
recode s1aq8a (8=.) if hid =="6411864118007" & s1aq1==84
replace s1aq3b = 11 if s1aq3b == 0  & s1aq1 == 84 & hid == "6411864118007"

///5321053215008
br hid-s1aq8b tot_consumed if hid =="5321053215008"  & s1aq1==84
recode s1aq4a (7=1) if hid =="5321053215008" & s1aq1==84
recode s1aq6a (7=1) if hid =="5321053215008" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "5321053215008"


///5612056108009// 
br hid-s1aq8b tot_consumed if hid =="5612056108009"  & s1aq1==84
recode s1aq8a (.=1) if hid =="5612056108009" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "5612056108009"
replace s1aq8b = 3 if s1aq8b == .  & s1aq1 == 84 & hid == "5612056108009"



///6112161122005
br hid-s1aq8b tot_consumed if hid =="6112161122005"  & s1aq1==84
recode s1aq4a (3=.) if hid =="6112161122005" & s1aq1==84
recode s1aq6a (3=.) if hid =="6112161122005" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "6112161122005"
replace s1aq4b = . if s1aq4b == 3  & s1aq1 == 84 & hid == "6112161122005"
replace s1aq6b = . if s1aq6b == 3  & s1aq1 == 84 & hid == "6112161122005"

///3522535215012
br hid-s1aq8b tot_consumed if hid =="3522535215012"  & s1aq1==84
recode s1aq6a (2=.) if hid =="3522535215012" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "3522535215012"
replace s1aq6b = . if s1aq6b == 3  & s1aq1 == 84 & hid == "3522535215012"

///3520935207016
br hid-s1aq8b tot_consumed if hid =="3520935207016"  & s1aq1==84
recode s1aq4a (0=.) if hid =="3520935207016" & s1aq1==84
recode s1aq7a (3=5) if hid =="3520935207016" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "3520935207016"
replace s1aq4b = . if s1aq4b == 3  & s1aq1 == 84 & hid == "3520935207016"
replace s1aq7b = 3 if s1aq7b == 5  & s1aq1 == 84 & hid == "3520935207016"

///8410684119004/
br hid-s1aq8b tot_consumed if hid =="8410684119004"  & s1aq1==84
recode s1aq8a (3=1) if hid =="8410684119004" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "8410684119004"
replace s1aq8b = 3 if s1aq8b == 0  & s1aq1 == 84 & hid == "8410684119004"


///3810438110012// verify unit with Janneh
br hid-s1aq8b tot_consumed if hid =="3810438110012"  & s1aq1==84
recode s1aq3a (1=5) if hid =="3810438110012" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "3810438110012"

///8622086232009
br hid-s1aq8b tot_consumed if hid =="8622086232009"  & s1aq1==84
recode s1aq6a (6=.) if hid =="8622086232009" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "8622086232009"
replace s1aq6b = . if s1aq6b == 3  & s1aq1 == 84 & hid == "8622086232009"

///4121441205008// verify price with Janneh
br hid-s1aq8b tot_consumed if hid =="4121441205008"  & s1aq1==84
recode s1aq3a (.1=1) if hid =="4121441205008" & s1aq1==84
recode s1aq4a (.1=1) if hid =="4121441205008" & s1aq1==84
recode s1aq6a (.1=1) if hid =="4121441205008" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "4121441205008"

///5111851133016
br hid-s1aq8b tot_consumed if hid =="5111851133016"  & s1aq1==84
recode s1aq6a (3=5) if hid =="5111851133016" & s1aq1==84
recode s1aq7a (5=1) if hid =="5111851133016" & s1aq1==84
recode s1aq5 (5=.) if hid =="5111851133016" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "5111851133016"


///3711637103002
br hid-s1aq8b tot_consumed if hid =="3711637103002"  & s1aq1==84
recode s1aq6a (3=4) if hid =="3711637103002" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "3711637103002"
replace s1aq6b = 3 if s1aq6b == 0  & s1aq1 == 84 & hid == "3711637103002"

///6430164315015
br hid-s1aq8b tot_consumed if hid =="6430164315015"  & s1aq1==84
recode s1aq7a (3=.) if hid =="6430164315015" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "6430164315015"
replace s1aq7b = . if s1aq7b == 3  & s1aq1 == 84 & hid == "6430164315015"


///8212982117010
br hid-s1aq8b tot_consumed if hid =="8212982117010"  & s1aq1==84
recode s1aq8a (2=.) if hid =="8212982117010" & s1aq1==84
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 84 & hid == "8212982117010"
replace s1aq8b = . if s1aq8b == 2  & s1aq1 == 84 & hid == "8212982117010"


///3711637103005
br hid-s1aq8b tot_consumed if hid =="3711637103005"  & s1aq1==84
recode s1aq3a (1=5) if hid =="3711637103005" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "3711637103005"


///3320433220002
br hid-s1aq8b tot_consumed if hid =="3320433220002"  & s1aq1==84
recode s1aq4a (2.5=2) if hid =="3320433220002" & s1aq1==84
recode s1aq6a (2.5=2) if hid =="3320433220002" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "3320433220002"

///4021140205016
br hid-s1aq8b tot_consumed if hid =="4021140205016"  & s1aq1==84
recode s1aq3a (.1=1) if hid =="4021140205016" & s1aq1==84
recode s1aq4a (.1=1) if hid =="4021140205016" & s1aq1==84
recode s1aq6a (.1=1) if hid =="4021140205016" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "4021140205016"



///8420684201015
br hid-s1aq8b tot_consumed if hid =="8420684201015"  & s1aq1==84
recode s1aq8a (1=.) if hid =="8420684201015" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "8420684201015"
replace s1aq8b = . if s1aq8b == 3  & s1aq1 == 84 & hid == "8420684201015"

///4220142208001
br hid-s1aq8b tot_consumed if hid =="4220142208001"  & s1aq1==84
recode s1aq3a (.1=1) if hid =="4220142208001" & s1aq1==84
recode s1aq8a (.=1) if hid =="4220142208001" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "4220142208001"
replace s1aq8b = 3 if s1aq8b == .  & s1aq1 == 84 & hid == "4220142208001"


************** 91 -powdered milk ********8
///8610986122004
br hid-s1aq8b tot_consumed if hid =="8610986122004"  & s1aq1==91
recode s1aq4a (150=1) if hid =="8610986122004" & s1aq1==91
recode s1aq6a (.=1) if hid =="8610986122004" & s1aq1==91
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 91 & hid == "8610986122004"
replace s1aq6b = 12 if s1aq6b == .  & s1aq1 == 91 & hid == "8610986122004"


///1110111109005
br hid-s1aq8b tot_consumed if hid =="1110111109005"  & s1aq1==91
recode s1aq8a (.=21) if hid =="1110111109005" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "1110111109005"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "1110111109005"


///2450224544014
br hid-s1aq8b tot_consumed if hid =="2450224544014"  & s1aq1==91
recode s1aq8a (.=6) if hid =="2450224544014" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "2450224544014"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "2450224544014"


///2010120117008
br hid-s1aq8b tot_consumed if hid =="2010120117008"  & s1aq1==91
recode s1aq8a (.=21) if hid =="2010120117008" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "2010120117008"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "2010120117008"


///6320963209015
br hid-s1aq8b tot_consumed if hid =="6320963209015"  & s1aq1==91
recode s1aq4a (200=20) if hid =="6320963209015" & s1aq1==91
recode s1aq6a (.=20) if hid =="6320963209015" & s1aq1==91
replace s1aq3b = 1 if s1aq3b == 0  & s1aq1 == 91 & hid == "6320963209015"
replace s1aq6b = 1 if s1aq6b == .  & s1aq1 == 91 & hid == "6320963209015"


///2210122167011
br hid-s1aq8b tot_consumed if hid =="2210122167011"  & s1aq1==91
recode s1aq8a (.=14) if hid =="2210122167011" & s1aq1==91
replace s1aq3b = 1 if s1aq3b == 0  & s1aq1 == 91 & hid == "2210122167011"
replace s1aq8b = 1 if s1aq8b == .  & s1aq1 == 91 & hid == "2210122167011"

///6122661205002
br hid-s1aq8b tot_consumed if hid =="6122661205002"  & s1aq1==91
recode s1aq3a (.4=4) if hid =="6122661205002" & s1aq1==91
recode s1aq4a (.4=4) if hid =="6122661205002" & s1aq1==91
recode s1aq6a (.4=4) if hid =="6122661205002" & s1aq1==91
replace s1aq3b = 1 if s1aq3b == 0  & s1aq1 == 91 & hid == "6122661205002"


///6430764302004
br hid-s1aq8b tot_consumed if hid =="6430764302004"  & s1aq1==91
recode s1aq4a (200=14) if hid =="6430764302004" & s1aq1==91
recode s1aq6a (.=14) if hid =="6430764302004" & s1aq1==91
replace s1aq3b = 1 if s1aq3b == 0  & s1aq1 == 91 & hid == "6430764302004"
replace s1aq6b = 1 if s1aq6b == .  & s1aq1 == 91 & hid == "6430764302004"


///4111241102015
br hid-s1aq8b tot_consumed if hid =="4111241102015"  & s1aq1==91
recode s1aq6a (5=7) if hid =="4111241102015" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "4111241102015"
replace s1aq6b = 5 if s1aq6b == 0  & s1aq1 == 91 & hid == "4111241102015"


///3090230903010
br hid-s1aq8b tot_consumed if hid =="3090230903010"  & s1aq1==91
recode s1aq8a (.=7) if hid =="3090230903010" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "3090230903010"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "3090230903010"

///7112071111013
br hid-s1aq8b tot_consumed if hid =="7112071111013"  & s1aq1==91
recode s1aq3a (21=12) if hid =="7112071111013" & s1aq1==91
recode s1aq4a (21=12) if hid =="7112071111013" & s1aq1==91
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 91 & hid == "7112071111013"


///2010120117009
br hid-s1aq8b tot_consumed if hid =="2010120117009"  & s1aq1==91
recode s1aq8a (.=14) if hid =="2010120117009" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "2010120117009"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "2010120117009"

////6430764305006// verify price with Janneh
br hid-s1aq8b tot_consumed if hid =="6430764305006"  & s1aq1==91
recode s1aq6a (1=2) if hid =="6430764305006" & s1aq1==91
replace s1aq3b = 1 if s1aq3b == 0  & s1aq1 == 91 & hid == "6430764305006"
replace s1aq8b = 1 if s1aq8b == 0  & s1aq1 == 91 & hid == "6430764305006"
replace s1aq6b = 1 if s1aq6b == 3  & s1aq1 == 91 & hid == "6430764305006"

///3020630210013
br hid-s1aq8b tot_consumed if hid =="3020630210013"  & s1aq1==91
recode s1aq8a (.=14) if hid =="3020630210013" & s1aq1==91
replace s1aq3b = 1 if s1aq3b == 0  & s1aq1 == 91 & hid == "3020630210013"
replace s1aq8b = 1 if s1aq8b == .  & s1aq1 == 91 & hid == "3020630210013"

///2130121308002
br hid-s1aq8b tot_consumed if hid =="2130121308002"  & s1aq1==91
recode s1aq8a (.=21) if hid =="2130121308002" & s1aq1==91
replace s1aq3b = 1 if s1aq3b == 0  & s1aq1 == 91 & hid == "2130121308002"
replace s1aq8b = 1 if s1aq8b == .  & s1aq1 == 91 & hid == "2130121308002"


///1230112304010
br hid-s1aq8b tot_consumed if hid =="1230112304010"  & s1aq1==91
recode s1aq8a (.=21) if hid =="1230112304010" & s1aq1==91
replace s1aq3b = 1 if s1aq3b == 0  & s1aq1 == 91 & hid == "1230112304010"
replace s1aq8b = 1 if s1aq8b == .  & s1aq1 == 91 & hid == "1230112304010"


///2310123112014
br hid-s1aq8b tot_consumed if hid =="2310123112014"  & s1aq1==91
recode s1aq8a (.=7) if hid =="2310123112014" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "2310123112014"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "2310123112014"

///5310953113015
br hid-s1aq8b tot_consumed if hid =="5310953113015"  & s1aq1==91
recode s1aq8a (21=.) if hid =="5310953113015" & s1aq1==91
replace s1aq3b = 99 if s1aq3b == 0  & s1aq1 == 91 & hid == "5310953113015"
replace s1aq8b = . if s1aq8b == 0  & s1aq1 == 91 & hid == "5310953113015"


///3090530966001
br hid-s1aq8b tot_consumed if hid =="3090530966001"  & s1aq1==91
recode s1aq8a (.=7) if hid =="3090530966001" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "3090530966001"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "3090530966001"


///8620486219005
br hid-s1aq8b tot_consumed if hid =="8620486219005"  & s1aq1==91
recode s1aq8a (.=1) if hid =="8620486219005" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "8620486219005"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "8620486219005"

////5530155356006
br hid-s1aq8b tot_consumed if hid =="5530155356006"  & s1aq1==91
recode s1aq3a (150=1) if hid =="5530155356006" & s1aq1==91
recode s1aq4a (150=.) if hid =="5530155356006" & s1aq1==91
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 91 & hid == "5530155356006"
replace s1aq4b = . if s1aq4b == 12  & s1aq1 == 91 & hid == "5530155356006"

///6311963130002
br hid-s1aq8b tot_consumed if hid =="6311963130002"  & s1aq1==91
recode s1aq8a (.=1) if hid =="6311963130002" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "6311963130002"
replace s1aq4b = 5 if s1aq4b == 0  & s1aq1 == 91 & hid == "6311963130002"
replace s1aq6b = 5 if s1aq6b == 0  & s1aq1 == 91 & hid == "6311963130002"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "6311963130002"


///6410864115005
br hid-s1aq8b tot_consumed if hid =="6410864115005"  & s1aq1==91
recode s1aq3a (500=50) if hid =="6410864115005" & s1aq1==91
recode s1aq4a (200=20) if hid =="6410864115005" & s1aq1==91
recode s1aq6a (.=20) if hid =="6410864115005" & s1aq1==91
recode s1aq8a (.=30) if hid =="6410864115005" & s1aq1==91
replace s1aq3b = 1 if s1aq3b == 0  & s1aq1 == 91 & hid == "6410864115005"
replace s1aq6b = 1 if s1aq6b == .  & s1aq1 == 91 & hid == "6410864115005"
replace s1aq8b = 1 if s1aq8b == .  & s1aq1 == 91 & hid == "6410864115005"


///4010440103007
br hid-s1aq8b tot_consumed if hid =="4010440103007"  & s1aq1==91
recode s1aq4a (4=1) if hid =="4010440103007" & s1aq1==91
recode s1aq6a (4=1) if hid =="4010440103007" & s1aq1==91
replace s1aq3b = 1 if s1aq3b == 0  & s1aq1 == 91 & hid == "4010440103007"

///6320963209009
br hid-s1aq8b tot_consumed if hid =="6320963209009"  & s1aq1==91
recode s1aq8a (2=.) if hid =="6320963209009" & s1aq1==91
replace s1aq3b = 2 if s1aq3b == 0  & s1aq1 == 91 & hid == "6320963209009"
replace s1aq8b = . if s1aq8b == 2  & s1aq1 == 91 & hid == "6320963209009"

///1110111102008
br hid-s1aq8b tot_consumed if hid =="1110111102008"  & s1aq1==91
recode s1aq8a (.=7) if hid =="1110111102008" & s1aq1==91 // check before submitting
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "1110111102008"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "1110111102008"

///8410284108008
br hid-s1aq8b tot_consumed if hid =="8410284108008"  & s1aq1==91
recode s1aq3a (35=3) if hid =="8410284108008" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "8410284108008"


///1110111102007
br hid-s1aq8b tot_consumed if hid =="1110111102007"  & s1aq1==91
recode s1aq8a (.=7) if hid =="1110111102007" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "1110111102007"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "1110111102007"

///3030130321015
br hid-s1aq8b tot_consumed if hid =="3030130321015"  & s1aq1==91
recode s1aq8a (.=21) if hid =="3030130321015" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "3030130321015"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "3030130321015"

///2220122208014
br hid-s1aq8b tot_consumed if hid =="2220122208014"  & s1aq1==91
recode s1aq8a (.=28) if hid =="2220122208014" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "2220122208014"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "2220122208014"

////8320583241010
br hid-s1aq8b tot_consumed if hid =="8320583241010"  & s1aq1==91
recode s1aq3a (1.4=14) if hid =="8320583241010" & s1aq1==91
recode s1aq6a (1.4=14) if hid =="8320583241010" & s1aq1==91
replace s1aq3b = 2 if s1aq3b == 0  & s1aq1 == 91 & hid == "8320583241010"


///6114561107009
br hid-s1aq8b tot_consumed if hid =="6114561107009"  & s1aq1==91
recode s1aq6a (5=7) if hid =="6114561107009" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "6114561107009"

///4010240101008
br hid-s1aq8b tot_consumed if hid =="4010240101008"  & s1aq1==91
recode s1aq3a (1=7) if hid =="4010240101008" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "4010240101008"


///1020110201015
br hid-s1aq8b tot_consumed if hid =="1020110201015"  & s1aq1==91
recode s1aq8a (.=21) if hid =="1020110201015" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "1020110201015"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "1020110201015"

///2130121308003
br hid-s1aq8b tot_consumed if hid =="2130121308003"  & s1aq1==91
recode s1aq8a (.=21) if hid =="2130121308003" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "2130121308003"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "2130121308003"

///5211052111009
br hid-s1aq8b tot_consumed if hid =="5211052111009"  & s1aq1==91
recode s1aq8a (20=.) if hid =="5211052111009" & s1aq1==91
replace s1aq3b = 1 if s1aq3b == 0  & s1aq1 == 91 & hid == "5211052111009"
replace s1aq8b = . if s1aq8b == 0  & s1aq1 == 91 & hid == "5211052111009"

///8311583128012
br hid-s1aq8b tot_consumed if hid =="8311583128012"  & s1aq1==91
recode s1aq6a (7=1) if hid =="8311583128012" & s1aq1==91
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 91 & hid == "8311583128012"
replace s1aq6b = 12 if s1aq6b == 1  & s1aq1 == 91 & hid == "8311583128012"


///1220112211009
br hid-s1aq8b tot_consumed if hid =="1220112211009"  & s1aq1==91
recode s1aq8a (.=7) if hid =="1220112211009" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "1220112211009"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "1220112211009"


///2230122310016
br hid-s1aq8b tot_consumed if hid =="2230122310016"  & s1aq1==91
recode s1aq8a (.=21) if hid =="2230122310016" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "2230122310016"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "2230122310016"


///2120121201007
br hid-s1aq8b tot_consumed if hid =="2120121201007"  & s1aq1==91
recode s1aq8a (.=14) if hid =="2120121201007" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "2120121201007"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "2120121201007"


///3330533320009
br hid-s1aq8b tot_consumed if hid =="3330533320009"  & s1aq1==91
recode s1aq6a (5=10) if hid =="3330533320009" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "3330533320009"


///3090230903008
br hid-s1aq8b tot_consumed if hid =="3090230903008"  & s1aq1==91
recode s1aq8a (.=7) if hid =="3090230903008" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "3090230903008"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "3090230903008"


///2230122330002
br hid-s1aq8b tot_consumed if hid =="2230122330002"  & s1aq1==91
recode s1aq8a (.=14) if hid =="2230122330002" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "2230122330002"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "2230122330002"

///2110321101009
br hid-s1aq8b tot_consumed if hid =="2110321101009"  & s1aq1==91
recode s1aq8a (.=8) if hid =="2110321101009" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "2110321101009"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "2110321101009"

///2320123203010
br hid-s1aq8b tot_consumed if hid =="2320123203010"  & s1aq1==91
recode s1aq8a (.=6) if hid =="2320123203010" & s1aq1==91
replace s1aq3b = 2 if s1aq3b == 0  & s1aq1 == 91 & hid == "2320123203010"
replace s1aq8b = 2 if s1aq8b == .  & s1aq1 == 91 & hid == "2320123203010"

///2230122330003
br hid-s1aq8b tot_consumed if hid =="2230122330003"  & s1aq1==91
recode s1aq8a (.=14) if hid =="2230122330003" & s1aq1==91
replace s1aq3b = 2 if s1aq3b == 0  & s1aq1 == 91 & hid == "2230122330003"
replace s1aq8b = 2 if s1aq8b == .  & s1aq1 == 91 & hid == "2230122330003"


///2440124414009
br hid-s1aq8b tot_consumed if hid =="2440124414009"  & s1aq1==91
recode s1aq8a (.=21) if hid =="2440124414009" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "2440124414009"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "2440124414009"


///3030330362009
br hid-s1aq8b tot_consumed if hid =="3030330362009"  & s1aq1==91
recode s1aq8a (.=7) if hid =="3030330362009" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "3030330362009"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "3030330362009"


///6420364203012
br hid-s1aq8b tot_consumed if hid =="6420364203012"  & s1aq1==91
recode s1aq4a (0=1) if hid =="6420364203012" & s1aq1==91
recode s1aq6a (.=1) if hid =="6420364203012" & s1aq1==91
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 91 & hid == "6420364203012"
replace s1aq6b = 12 if s1aq6b == .  & s1aq1 == 91 & hid == "6420364203012"

///7410374105014// verify unit of measurement
br hid-s1aq8b tot_consumed if hid =="7410374105014"  & s1aq1==91
recode s1aq3a (11=1) if hid =="7410374105014" & s1aq1==91
replace s1aq3b = 11 if s1aq3b == 0  & s1aq1 == 91 & hid == "7410374105014"


///1110111106008
br hid-s1aq8b tot_consumed if hid =="1110111106008"  & s1aq1==91
recode s1aq8a (.=4) if hid =="1110111106008" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "1110111106008"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "1110111106008"


///2320123275006
br hid-s1aq8b tot_consumed if hid =="2320123275006"  & s1aq1==91
recode s1aq8a (.=14) if hid =="2320123275006" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "2320123275006"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "2320123275006"

///2310123112016
br hid-s1aq8b tot_consumed if hid =="2310123112016"  & s1aq1==91
recode s1aq8a (.=16) if hid =="2310123112016" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "2310123112016"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "2310123112016"


///1210112104001
br hid-s1aq8b tot_consumed if hid =="1210112104001"  & s1aq1==91
recode s1aq8a (.=7) if hid =="1210112104001" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "1210112104001"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "1210112104001"

///8410784114011
br hid-s1aq8b tot_consumed if hid =="8410784114011"  & s1aq1==91
recode s1aq5 (150=.) if hid =="8410784114011" & s1aq1==91
recode s1aq8a (.=1) if hid =="8410784114011" & s1aq1==91
replace s1aq3b = 1 if s1aq3b == 0  & s1aq1 == 91 & hid == "8410784114011"
replace s1aq8b = 1 if s1aq8b == .  & s1aq1 == 91 & hid == "8410784114011"


///1120111202015
br hid-s1aq8b tot_consumed if hid =="1120111202015"  & s1aq1==91
recode s1aq8a (.=14) if hid =="1120111202015" & s1aq1==91
replace s1aq3b = 1 if s1aq3b == 0  & s1aq1 == 91 & hid == "1120111202015"
replace s1aq8b = 1 if s1aq8b == .  & s1aq1 == 91 & hid == "1120111202015"


///2320123251006
br hid-s1aq8b tot_consumed if hid =="2320123251006"  & s1aq1==91
recode s1aq3a (.5=5) if hid =="2320123251006" & s1aq1==91
recode s1aq8a (1=5) if hid =="2320123251006" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "2320123251006"
replace s1aq8b = 5 if s1aq8b == 0  & s1aq1 == 91 & hid == "2320123251006"


///6120261210003
br hid-s1aq8b tot_consumed if hid =="6120261210003"  & s1aq1==91
recode s1aq3a (.2=2) if hid =="6120261210003" & s1aq1==91
recode s1aq4a (.2=2) if hid =="6120261210003" & s1aq1==91
recode s1aq6a (.2=2) if hid =="6120261210003" & s1aq1==91
replace s1aq3b = 1 if s1aq3b == 0  & s1aq1 == 91 & hid == "6120261210003"


////6430764305008
br hid-s1aq8b tot_consumed if hid =="6430764305008"  & s1aq1==91
recode s1aq8a (2=.) if hid =="6430764305008" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "6430764305008"
replace s1aq8b = . if s1aq8b == 2  & s1aq1 == 91 & hid == "6430764305008"


///5622156219016
br hid-s1aq8b tot_consumed if hid =="5622156219016"  & s1aq1==91
recode s1aq4a (35=3) if hid =="5622156219016" & s1aq1==91
recode s1aq6a (35=3) if hid =="5622156219016" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "5622156219016"

///1120111202016
br hid-s1aq8b tot_consumed if hid =="1120111202016"  & s1aq1==91
recode s1aq8a (.=21) if hid =="1120111202016" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "1120111202016"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "1120111202016"


///6410864115003
br hid-s1aq8b tot_consumed if hid =="6410864115003"  & s1aq1==91
recode s1aq4a (200=20) if hid =="6410864115003" & s1aq1==91
recode s1aq6a (.=20) if hid =="6410864115003" & s1aq1==91
replace s1aq3b = 1 if s1aq3b == 0  & s1aq1 == 91 & hid == "6410864115003"
replace s1aq6b = 1 if s1aq6b == .  & s1aq1 == 91 & hid == "6410864115003"


///2130121308011// verify price
br hid-s1aq8b tot_consumed if hid =="2130121308011"  & s1aq1==91
recode s1aq3a (1=2) if hid =="2130121308011" & s1aq1==91
replace s1aq3b = 1 if s1aq3b == 0  & s1aq1 == 91 & hid == "2130121308011"


///6310563139011
br hid-s1aq8b tot_consumed if hid =="6310563139011"  & s1aq1==91
recode s1aq5 (150=.) if hid =="6310563139011" & s1aq1==91
recode s1aq8a (.=5) if hid =="6310563139011" & s1aq1==91
replace s1aq3b = 1 if s1aq3b == 0  & s1aq1 == 91 & hid == "6310563139011"
replace s1aq8b = 1 if s1aq8b == .  & s1aq1 == 91 & hid == "6310563139011"

///2110321101008
br hid-s1aq8b tot_consumed if hid =="2110321101008"  & s1aq1==91
recode s1aq8a (.=7) if hid =="2110321101008" & s1aq1==91
replace s1aq3b = 1 if s1aq3b == 0  & s1aq1 == 91 & hid == "2110321101008"
replace s1aq8b = 1 if s1aq8b == .  & s1aq1 == 91 & hid == "2110321101008"


///5611756102013// verify price
br hid-s1aq8b tot_consumed if hid =="5611756102013"  & s1aq1==91
recode s1aq3a (.5=1) if hid =="5611756102013" & s1aq1==91
recode s1aq8a (7=.) if hid =="5611756102013" & s1aq1==91
replace s1aq3b = 1 if s1aq3b == 0  & s1aq1 == 91 & hid == "5611756102013"

///8610986122006
br hid-s1aq8b tot_consumed if hid =="8610986122006"  & s1aq1==91
recode s1aq4a (150=14) if hid =="8610986122006" & s1aq1==91
recode s1aq6a (.=14) if hid =="8610986122006" & s1aq1==91
recode s1aq5 (150=.) if hid =="8610986122006" & s1aq1==91
replace s1aq3b = 1 if s1aq3b == 0  & s1aq1 == 91 & hid == "8610986122006"
replace s1aq6b = 1 if s1aq6b == .  & s1aq1 == 91 & hid == "8610986122006"


///4111241102011
br hid-s1aq8b tot_consumed if hid =="4111241102011"  & s1aq1==91
recode s1aq3a (20=28) if hid =="4111241102011" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "4111241102011"


////2120121223011
br hid-s1aq8b tot_consumed if hid =="2120121223011"  & s1aq1==91
recode s1aq8a (.=28) if hid =="2120121223011" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "2120121223011"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "2120121223011"


///4110241106003
br hid-s1aq8b tot_consumed if hid =="4110241106003"  & s1aq1==91
recode s1aq6a (1=7) if hid =="4110241106003" & s1aq1==91
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 91 & hid == "4110241106003"

///6421564215006
br hid-s1aq8b tot_consumed if hid =="6421564215006"  & s1aq1==91
recode s1aq8a (.=7) if hid =="6421564215006" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "6421564215006"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "6421564215006"

///2340123436003
br hid-s1aq8b tot_consumed if hid =="2340123436003"  & s1aq1==91
recode s1aq8a (.=7) if hid =="2340123436003" & s1aq1==91
replace s1aq3b = 1 if s1aq3b == 0  & s1aq1 == 91 & hid == "2340123436003"
replace s1aq8b = 1 if s1aq8b == .  & s1aq1 == 91 & hid == "2340123436003"


///4311543129013
br hid-s1aq8b tot_consumed if hid =="4311543129013"  & s1aq1==91
recode s1aq4a (100=1) if hid =="4311543129013" & s1aq1==91
recode s1aq6a (100=1) if hid =="4311543129013" & s1aq1==91
recode s1aq8a (1=.) if hid =="4311543129013" & s1aq1==91
replace s1aq3b = 1 if s1aq3b == 0  & s1aq1 == 91 & hid == "4311543129013"
replace s1aq8b = . if s1aq8b == 0  & s1aq1 == 91 & hid == "4311543129013"

///4210242108009
br hid-s1aq8b tot_consumed if hid =="4210242108009"  & s1aq1==91
recode s1aq3a (.1=1) if hid =="4210242108009" & s1aq1==91
recode s1aq4a (.1=1) if hid =="4210242108009" & s1aq1==91
recode s1aq6a (.1=1) if hid =="4210242108009" & s1aq1==91
replace s1aq3b = 1 if s1aq3b == 0  & s1aq1 == 91 & hid == "4210242108009"

///1020110208012
br hid-s1aq8b tot_consumed if hid =="1020110208012"  & s1aq1==91
recode s1aq8a (.=21) if hid =="1020110208012" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "1020110208012"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "1020110208012"

///8520385216008
br hid-s1aq8b tot_consumed if hid =="8520385216008"  & s1aq1==91
recode s1aq4a (250=20) if hid =="8520385216008" & s1aq1==91
recode s1aq6a (.=20) if hid =="8520385216008" & s1aq1==91
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 91 & hid == "8520385216008"
replace s1aq6b = 12 if s1aq6b == .  & s1aq1 == 91 & hid == "8520385216008"


///5620156228016
br hid-s1aq8b tot_consumed if hid =="5620156228016"  & s1aq1==91
recode s1aq4a (2=1) if hid =="5620156228016" & s1aq1==91
recode s1aq6a (2=1) if hid =="5620156228016" & s1aq1==91
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 91 & hid == "5620156228016"

///3020630210008
br hid-s1aq8b tot_consumed if hid =="3020630210008"  & s1aq1==91
recode s1aq8a (.=7) if hid =="3020630210008" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "3020630210008"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "3020630210008"

///3211032132004
br hid-s1aq8b tot_consumed if hid =="3211032132004"  & s1aq1==91
recode s1aq3a (.5=5) if hid =="3211032132004" & s1aq1==91
recode s1aq4a (.5=5) if hid =="3211032132004" & s1aq1==91
recode s1aq6a (.4=5) if hid =="3211032132004" & s1aq1==91
replace s1aq3b = 1 if s1aq3b == 0  & s1aq1 == 91 & hid == "3211032132004"

///5122551211007
br hid-s1aq8b tot_consumed if hid =="5122551211007"  & s1aq1==91
recode s1aq5 (200=.) if hid =="5122551211007" & s1aq1==91
recode s1aq8a (.=1) if hid =="5122551211007" & s1aq1==91
replace s1aq3b = 1 if s1aq3b == 0  & s1aq1 == 91 & hid == "5122551211007"
replace s1aq8b = 1 if s1aq8b == .  & s1aq1 == 91 & hid == "5122551211007"

///6314263133005
br hid-s1aq8b tot_consumed if hid =="6314263133005"  & s1aq1==91
recode s1aq5 (90=.) if hid =="6314263133005" & s1aq1==91
recode s1aq8a (.=6) if hid =="6314263133005" & s1aq1==91
replace s1aq3b = 1 if s1aq3b == 0  & s1aq1 == 91 & hid == "6314263133005"
replace s1aq8b = 1 if s1aq8b == .  & s1aq1 == 91 & hid == "6314263133005"

///3330133313011
br hid-s1aq8b tot_consumed if hid =="3330133313011"  & s1aq1==91
recode s1aq6a (.=5) if hid =="3330133313011" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "3330133313011"
replace s1aq6b = 5 if s1aq6b == .  & s1aq1 == 91 & hid == "3330133313011"


///1020110205002
br hid-s1aq8b tot_consumed if hid =="1020110205002"  & s1aq1==91
recode s1aq8a (.=21) if hid =="1020110205002" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "1020110205002"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "1020110205002"

///2320123203009
br hid-s1aq8b tot_consumed if hid =="2320123203009"  & s1aq1==91
recode s1aq8a (.=8) if hid =="2320123203009" & s1aq1==91
replace s1aq3b = 1 if s1aq3b == 0  & s1aq1 == 91 & hid == "2320123203009"
replace s1aq8b = 1 if s1aq8b == .  & s1aq1 == 91 & hid == "2320123203009"

///1210112104002
br hid-s1aq8b tot_consumed if hid =="1210112104002"  & s1aq1==91
recode s1aq8a (.=21) if hid =="1210112104002" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "1210112104002"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "1210112104002"


///2020120213013
br hid-s1aq8b tot_consumed if hid =="2020120213013"  & s1aq1==91
recode s1aq6a (.=14) if hid =="2020120213013" & s1aq1==91
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 91 & hid == "2020120213013"
replace s1aq6b = 6 if s1aq6b == .  & s1aq1 == 91 & hid == "2020120213013"


///1130111303014
br hid-s1aq8b tot_consumed if hid =="1130111303014"  & s1aq1==91
recode s1aq8a (.=7) if hid =="1130111303014" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "1130111303014"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "1130111303014"


///3030530383003
br hid-s1aq8b tot_consumed if hid =="3030530383003"  & s1aq1==91
recode s1aq8a (.=7) if hid =="3030530383003" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "3030530383003"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "3030530383003"

///3511335106003
br hid-s1aq8b tot_consumed if hid =="3511335106003"  & s1aq1==91
recode s1aq3a (1=14) if hid =="3511335106003" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "3511335106003"


///1010110103008
br hid-s1aq8b tot_consumed if hid =="1010110103008"  & s1aq1==91
recode s1aq8a (.=7) if hid =="1010110103008" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "1010110103008"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "1010110103008"

///3030130321016
br hid-s1aq8b tot_consumed if hid =="3030130321016"  & s1aq1==91
recode s1aq8a (.=14) if hid =="3030130321016" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "3030130321016"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "3030130321016"


///1120111204012
br hid-s1aq8b tot_consumed if hid =="1120111204012"  & s1aq1==91
recode s1aq8a (.=7) if hid =="1120111204012" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "1120111204012"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "1120111204012"


///8211082125014
br hid-s1aq8b tot_consumed if hid =="8211082125014"  & s1aq1==91
recode s1aq6a (.=1) if hid =="8211082125014" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "8211082125014"
replace s1aq6b = 5 if s1aq6b == .  & s1aq1 == 91 & hid == "8211082125014"


///2130121308004
br hid-s1aq8b tot_consumed if hid =="2130121308004"  & s1aq1==91
recode s1aq8a (.=7) if hid =="2130121308004" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "2130121308004"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "2130121308004"


///3521135203010
br hid-s1aq8b tot_consumed if hid =="3521135203010"  & s1aq1==91
recode s1aq6a (5=10) if hid =="3521135203010" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "3521135203010"

///3511335106008
br hid-s1aq8b tot_consumed if hid =="3511335106008"  & s1aq1==91
recode s1aq8a (1=.) if hid =="3511335106008" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "3511335106008"
replace s1aq8b = . if s1aq8b == 5  & s1aq1 == 91 & hid == "3511335106008"

///6110361117009
br hid-s1aq8b tot_consumed if hid =="6110361117009"  & s1aq1==91
recode s1aq6a (3=5) if hid =="6110361117009" & s1aq1==91
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 91 & hid == "6110361117009"

///2430124317007
br hid-s1aq8b tot_consumed if hid =="2430124317007"  & s1aq1==91
recode s1aq8a (.=21) if hid =="2430124317007" & s1aq1==91
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 91 & hid == "2430124317007"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 91 & hid == "2430124317007"

************* evaporated milk *************
///3820638202013
br hid-s1aq8b tot_consumed if hid =="3820638202013"  & s1aq1==92
recode s1aq8a (.=5) if hid =="3820638202013" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "3820638202013"
replace s1aq8b = 12 if s1aq8b == .  & s1aq1 == 92 & hid == "3820638202013"

///4121141207001
br hid-s1aq8b tot_consumed if hid =="4121141207001"  & s1aq1==92
recode s1aq3a (12=1) if hid =="4121141207001" & s1aq1==92
recode s1aq4a (12=1) if hid =="4121141207001" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "4121141207001"


///8212982117005// verify price
br hid-s1aq8b tot_consumed if hid =="8212982117005"  & s1aq1==92
recode s1aq3a (4=5) if hid =="8212982117005" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "8212982117005"


///4120341210001
br hid-s1aq8b tot_consumed if hid =="4120341210001"  & s1aq1==92
recode s1aq3a (12=1) if hid =="4120341210001" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "4120341210001"


///6113161102010
br hid-s1aq8b tot_consumed if hid =="6113161102010"  & s1aq1==92
recode s1aq4a (15=2) if hid =="6113161102010" & s1aq1==92
recode s1aq6a (15=2) if hid =="6113161102010" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "6113161102010"

///8610686120009
br hid-s1aq8b tot_consumed if hid =="8610686120009"  & s1aq1==92
recode s1aq4a (1=2) if hid =="8610686120009" & s1aq1==92
recode s1aq6a (1=2) if hid =="8610686120009" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "8610686120009"

////6312263137010
br hid-s1aq8b tot_consumed if hid =="6312263137010"  & s1aq1==92
recode s1aq6a (.=1) if hid =="6312263137010" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "6312263137010"
replace s1aq4b = 12 if s1aq4b == 6  & s1aq1 == 92 & hid == "6312263137010"
replace s1aq6b = 12 if s1aq6b == .  & s1aq1 == 92 & hid == "6312263137010"

////8621086206010
br hid-s1aq8b tot_consumed if hid =="8621086206010"  & s1aq1==92
recode s1aq6a (1=2) if hid =="8621086206010" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "8621086206010"


////3810338108005
br hid-s1aq8b tot_consumed if hid =="3810338108005"  & s1aq1==92
recode s1aq8a (2=.) if hid =="3810338108005" & s1aq1==92
replace s1aq3b = 13 if s1aq3b == 0  & s1aq1 == 92 & hid == "3810338108005"
replace s1aq8b = . if s1aq8b == 2  & s1aq1 == 92 & hid == "3810338108005"

////2130121308002
br hid-s1aq8b tot_consumed if hid =="2130121308002"  & s1aq1==92
recode s1aq8a (.=2) if hid =="2130121308002" & s1aq1==92
replace s1aq3b = 13 if s1aq3b == 0  & s1aq1 == 92 & hid == "2130121308002"
replace s1aq8b = 13 if s1aq8b == .  & s1aq1 == 92 & hid == "2130121308002"

///8610586117014
br hid-s1aq8b tot_consumed if hid =="8610586117014"  & s1aq1==92
recode s1aq3a (5=4) if hid =="8610586117014" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "8610586117014"


////4311543108007
br hid-s1aq8b tot_consumed if hid =="4311543108007"  & s1aq1==92
recode s1aq8a (1=.) if hid =="4311543108007" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "4311543108007"
replace s1aq8b = . if s1aq8b == 12  & s1aq1 == 92 & hid == "4311543108007"

///3321033216009
br hid-s1aq8b tot_consumed if hid =="3321033216009"  & s1aq1==92
recode s1aq4a (3=2) if hid =="3321033216009" & s1aq1==92
recode s1aq6a (3=2) if hid =="3321033216009" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "3321033216009"

///3090330950011
br hid-s1aq8b tot_consumed if hid =="3090330950011"  & s1aq1==92
recode s1aq8a (.=1) if hid =="3090330950011" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "3090330950011"
replace s1aq8b = 12 if s1aq8b == .  & s1aq1 == 92 & hid == "3090330950011"

///8120681207006
br hid-s1aq8b tot_consumed if hid =="8120681207006"  & s1aq1==92
recode s1aq3a (4=3) if hid =="8120681207006" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "8120681207006"

///4311743142012
br hid-s1aq8b tot_consumed if hid =="4311743142012"  & s1aq1==92
recode s1aq3a (10=5) if hid =="4311743142012" & s1aq1==92
recode s1aq6a (.=5) if hid =="4311743142012" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "4311743142012"
replace s1aq6b = 12 if s1aq6b == .  & s1aq1 == 92 & hid == "4311743142012"

///6211662120006
br hid-s1aq8b tot_consumed if hid =="6211662120006"  & s1aq1==92
recode s1aq8a (5=.) if hid =="6211662120006" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "6211662120006"
replace s1aq8b = . if s1aq8b == 12  & s1aq1 == 92 & hid == "6211662120006"

///3071930721003
br hid-s1aq8b tot_consumed if hid =="3071930721003"  & s1aq1==92
recode s1aq3a (77=7) if hid =="3071930721003" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "3071930721003"

///4311543108004
br hid-s1aq8b tot_consumed if hid =="4311543108004"  & s1aq1==92
recode s1aq8a (2=.) if hid =="4311543108004" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "4311543108004"
replace s1aq4b = 12 if s1aq4b == 13  & s1aq1 == 92 & hid == "4311543108004"
replace s1aq8b = . if s1aq8b == 2  & s1aq1 == 92 & hid == "4311543108004"

///6311763117014
br hid-s1aq8b tot_consumed if hid =="6311763117014"  & s1aq1==92
recode s1aq6a (2=6) if hid =="6311763117014" & s1aq1==92
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 92 & hid == "6311763117014"
replace s1aq4b = 6 if s1aq4b == 2  & s1aq1 == 92 & hid == "6311763117014"

///6210562110003
br hid-s1aq8b tot_consumed if hid =="6210562110003"  & s1aq1==92
recode s1aq4a (3=2) if hid =="6210562110003" & s1aq1==92
recode s1aq6a (3=2) if hid =="6210562110003" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "6210562110003"
replace s1aq4b = 6 if s1aq4b == 2  & s1aq1 == 92 & hid == "6210562110003"

///1020110205004
br hid-s1aq8b tot_consumed if hid =="1020110205004"  & s1aq1==92
recode s1aq3a (12=2) if hid =="1020110205004" & s1aq1==92
recode s1aq4a (1=2) if hid =="1020110205004" & s1aq1==92
recode s1aq6a (1=2) if hid =="1020110205004" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "1020110205004"

///5530155311001
br hid-s1aq8b tot_consumed if hid =="5530155311001"  & s1aq1==92
recode s1aq4a (50=15) if hid =="5530155311001" & s1aq1==92
recode s1aq6a (50=15) if hid =="5530155311001" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "5530155311001"

////6022360207007
br hid-s1aq8b tot_consumed if hid =="6022360207007"  & s1aq1==92
recode s1aq3a (12=1) if hid =="6022360207007" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "6022360207007"

///3810938107011
br hid-s1aq8b tot_consumed if hid =="3810938107011"  & s1aq1==92
recode s1aq6a (.=10) if hid =="3810938107011" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "3810938107011"
replace s1aq6b = 12 if s1aq6b == .  & s1aq1 == 92 & hid == "3810938107011"

///5013050117006
br hid-s1aq8b tot_consumed if hid =="5013050117006"  & s1aq1==92
recode s1aq8a (10=13) if hid =="5013050117006" & s1aq1==92
replace s1aq3b = 13 if s1aq3b == 0  & s1aq1 == 92 & hid == "5013050117006"

///8411184117016
br hid-s1aq8b tot_consumed if hid =="8411184117016"  & s1aq1==92
recode s1aq4a (1=2) if hid =="8411184117016" & s1aq1==92
recode s1aq6a (1=2) if hid =="8411184117016" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "8411184117016"


///7111071106015
br hid-s1aq8b tot_consumed if hid =="7111071106015"  & s1aq1==92
recode s1aq5 (7=105) if hid =="7111071106015" & s1aq1==92
recode s1aq6a (105=7) if hid =="7111071106015" & s1aq1==92
recode s1aq8a (12=.) if hid =="7111071106015" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "7111071106015"
replace s1aq6b = 12 if s1aq6b == 7  & s1aq1 == 92 & hid == "7111071106015"
replace s1aq8b = . if s1aq8b == 0  & s1aq1 == 92 & hid == "7111071106015"


///7442274402016
br hid-s1aq8b tot_consumed if hid =="7442274402016"  & s1aq1==92
recode s1aq4a (15=5) if hid =="7442274402016" & s1aq1==92
recode s1aq6a (15=5) if hid =="7442274402016" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "7442274402016"


///8520385218013
br hid-s1aq8b tot_consumed if hid =="8520385218013"  & s1aq1==92
recode s1aq8a (2=.) if hid =="8520385218013" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "8520385218013"
replace s1aq8b = . if s1aq8b == 2  & s1aq1 == 92 & hid == "8520385218013"

///5222352218003
br hid-s1aq8b tot_consumed if hid =="5222352218003"  & s1aq1==92
recode s1aq3a (1=2) if hid =="5222352218003" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "5222352218003"


///8620386216015
br hid-s1aq8b tot_consumed if hid =="8620386216015"  & s1aq1==92
recode s1aq4a (150=10) if hid =="8620386216015" & s1aq1==92
recode s1aq8a (10=.) if hid =="8620386216015" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "8620386216015"
replace s1aq8b = . if s1aq8b == 12  & s1aq1 == 92 & hid == "8620386216015"


////6311063114012
br hid-s1aq8b tot_consumed if hid =="6311063114012"  & s1aq1==92
recode s1aq4a (1=2) if hid =="6311063114012" & s1aq1==92
recode s1aq6a (1=2) if hid =="6311063114012" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "6311063114012"


///3090530966004
br hid-s1aq8b tot_consumed if hid =="3090530966004"  & s1aq1==92
recode s1aq8a (.=3) if hid =="3090530966004" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "3090530966004"
replace s1aq8b = 12 if s1aq8b == .  & s1aq1 == 92 & hid == "3090530966004"


////3810438110012
br hid-s1aq8b tot_consumed if hid =="3810438110012"  & s1aq1==92
recode s1aq8a (2=.) if hid =="3810438110012" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "3810438110012"
replace s1aq8b = . if s1aq8b == 2  & s1aq1 == 92 & hid == "3810438110012"


////6320963209013
br hid-s1aq8b tot_consumed if hid =="6320963209013"  & s1aq1==92
recode s1aq4a (65=1) if hid =="6320963209013" & s1aq1==92
recode s1aq6a (.=1) if hid =="6320963209013" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "6320963209013"
replace s1aq6b = 12 if s1aq6b == .  & s1aq1 == 92 & hid == "6320963209013"

///3810138105012
br hid-s1aq8b tot_consumed if hid =="3810138105012"  & s1aq1==92
recode s1aq4a (16=1) if hid =="3810138105012" & s1aq1==92
recode s1aq6a (16=1) if hid =="3810138105012" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "3810138105012"

///8620286226008
br hid-s1aq8b tot_consumed if hid =="8620286226008"  & s1aq1==92
recode s1aq6a (.=1) if hid =="8620286226008" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "8620286226008"
replace s1aq6b = 12 if s1aq6b == .  & s1aq1 == 92 & hid == "8620286226008"

///4111241103003
br hid-s1aq8b tot_consumed if hid =="4111241103003"  & s1aq1==92
recode s1aq3a (12=1) if hid =="4111241103003" & s1aq1==92
recode s1aq4a (12=1) if hid =="4111241103003" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "4111241103003"


////6411164123011
br hid-s1aq8b tot_consumed if hid =="6411164123011"  & s1aq1==92
recode s1aq6a (.=5) if hid =="6411164123011" & s1aq1==92
recode s1aq8a (.=2) if hid =="6411164123011" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "6411164123011"
replace s1aq6b = 12 if s1aq6b == .  & s1aq1 == 92 & hid == "6411164123011"
replace s1aq8b = 12 if s1aq8b == .  & s1aq1 == 92 & hid == "6411164123011"

///5110551108005
br hid-s1aq8b tot_consumed if hid =="5110551108005"  & s1aq1==92
recode s1aq8a (2=.) if hid =="5110551108005" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "5110551108005"
replace s1aq8b = . if s1aq8b == 2  & s1aq1 == 92 & hid == "5110551108005"


////8610586117011
br hid-s1aq8b tot_consumed if hid =="8610586117011"  & s1aq1==92
recode s1aq4a (5=4) if hid =="8610586117011" & s1aq1==92
recode s1aq6a (5=4) if hid =="8610586117011" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "8610586117011"
replace s1aq8b = . if s1aq8b == 2  & s1aq1 == 92 & hid == "8610586117011"

///5310353120014
br hid-s1aq8b tot_consumed if hid =="5310353120014"  & s1aq1==92
recode s1aq8a (4=.) if hid =="5310353120014" & s1aq1==92
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 92 & hid == "5310353120014"
replace s1aq8b = . if s1aq8b == 6  & s1aq1 == 92 & hid == "5310353120014"

///1220112208005
br hid-s1aq8b tot_consumed if hid =="1220112208005"  & s1aq1==92
recode s1aq8a (.=7) if hid =="1220112208005" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "1220112208005"
replace s1aq8b = 12 if s1aq8b == .  & s1aq1 == 92 & hid == "1220112208005"

///5310253102005
br hid-s1aq8b tot_consumed if hid =="5310253102005"  & s1aq1==92
recode s1aq6a (12=4) if hid =="5310253102005" & s1aq1==92
recode s1aq5 (604=60) if hid =="5310253102005" & s1aq1==92
recode s1aq6a (12=4) if hid =="5310253102005" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "5310253102005"


////8410684119014
br hid-s1aq8b tot_consumed if hid =="8410684119014"  & s1aq1==92
recode s1aq4a (15=3) if hid =="8410684119014" & s1aq1==92
recode s1aq6a (15=3) if hid =="8410684119014" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "8410684119014"


///5420754217014
br hid-s1aq8b tot_consumed if hid =="5420754217014"  & s1aq1==92
recode s1aq4a (2=1) if hid =="5420754217014" & s1aq1==92
recode s1aq6a (2=1) if hid =="5420754217014" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "5420754217014"


////2110321101009
br hid-s1aq8b tot_consumed if hid =="2110321101009"  & s1aq1==92
recode s1aq8a (.=3) if hid =="2110321101009" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "2110321101009"
replace s1aq8b = 12 if s1aq8b == .  & s1aq1 == 92 & hid == "2110321101009"

////4210642110004
br hid-s1aq8b tot_consumed if hid =="4210642110004"  & s1aq1==92
recode s1aq3a (12=1) if hid =="4210642110004" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "4210642110004"


///2340123412005
br hid-s1aq8b tot_consumed if hid =="2340123412005"  & s1aq1==92
recode s1aq8a (1=7) if hid =="2340123412005" & s1aq1==92
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 92 & hid == "2340123412005"

////8521685202015
br hid-s1aq8b tot_consumed if hid =="8521685202015"  & s1aq1==92
recode s1aq3a (1=14) if hid =="8521685202015" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "8521685202015"


////5420554201009
br hid-s1aq8b tot_consumed if hid =="5420554201009"  & s1aq1==92
recode s1aq3a (15=2) if hid =="5420554201009" & s1aq1==92
recode s1aq4a (30=2) if hid =="5420554201009" & s1aq1==92
recode s1aq6a (30=2) if hid =="5420554201009" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "5420554201009"


///4021340214001
br hid-s1aq8b tot_consumed if hid =="4021340214001"  & s1aq1==92
recode s1aq6a (12=1) if hid =="4021340214001" & s1aq1==92
recode s1aq8a (1=.) if hid =="4021340214001" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "4021340214001"
replace s1aq6b = 12 if s1aq6b == 0  & s1aq1 == 92 & hid == "4021340214001"
replace s1aq8b = . if s1aq8b == 12  & s1aq1 == 92 & hid == "4021340214001"


///6311063114006
br hid-s1aq8b tot_consumed if hid =="6311063114006"  & s1aq1==92
recode s1aq3a (3=2) if hid =="6311063114006" & s1aq1==92
recode s1aq4a (30=2) if hid =="6311063114006" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "6311063114006"

///8020280230007
br hid-s1aq8b tot_consumed if hid =="8020280230007"  & s1aq1==92
recode s1aq8a (5=.) if hid =="8020280230007" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "8020280230007"
replace s1aq8b = . if s1aq8b == 12  & s1aq1 == 92 & hid == "8020280230007"


///4210242105005
br hid-s1aq8b tot_consumed if hid =="4210242105005"  & s1aq1==92
recode s1aq8a (2=.) if hid =="4210242105005" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "4210242105005"
replace s1aq8b = . if s1aq8b == 2  & s1aq1 == 92 & hid == "4210242105005"

///5310253102010
br hid-s1aq8b tot_consumed if hid =="5310253102010"  & s1aq1==92
recode s1aq4a (13=3) if hid =="5310253102010" & s1aq1==92
recode s1aq6a (13=3) if hid =="5310253102010" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "5310253102010"


///3321433202009// verify price
br hid-s1aq8b tot_consumed if hid =="3321433202009"  & s1aq1==92
recode s1aq8a (2=.) if hid =="3321433202009" & s1aq1==92
replace s1aq3b = 2 if s1aq3b == 0  & s1aq1 == 92 & hid == "3321433202009"
replace s1aq8b = . if s1aq8b == 2  & s1aq1 == 92 & hid == "3321433202009"


///6022960213006
br hid-s1aq8b tot_consumed if hid =="6022960213006"  & s1aq1==92
recode s1aq6a (2=1) if hid =="6022960213006" & s1aq1==92
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 92 & hid == "6022960213006"
replace s1aq6b = 12 if s1aq6b == 1  & s1aq1 == 92 & hid == "6022960213006"


///5530155311010
br hid-s1aq8b tot_consumed if hid =="5530155311010"  & s1aq1==92
recode s1aq4a (200=4) if hid =="5530155311010" & s1aq1==92
recode s1aq6a (200=4) if hid =="5530155311010" & s1aq1==92
replace s1aq3b = 4 if s1aq3b == 0  & s1aq1 == 92 & hid == "5530155311010"

*******************93 condensed milk*********************
///3711637103013
br hid-s1aq8b tot_consumed if hid =="3711637103013"  & s1aq1==93
recode s1aq4a (.=1) if hid =="3711637103013" & s1aq1==93
recode s1aq6a (7=1) if hid =="3711637103013" & s1aq1==93
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 93 & hid == "3711637103013"
replace s1aq4b = 12 if s1aq4b == .  & s1aq1 == 93 & hid == "3711637103013"


///8014580109016
br hid-s1aq8b tot_consumed if hid =="8014580109016"  & s1aq1==93
recode s1aq8a (.=3) if hid =="8014580109016" & s1aq1==93
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 93 & hid == "8014580109016"
replace s1aq8b = 12 if s1aq8b == .  & s1aq1 == 93 & hid == "8014580109016"


///4020540221001
br hid-s1aq8b tot_consumed if hid =="4020540221001"  & s1aq1==93
recode s1aq4a (30=2) if hid =="4020540221001" & s1aq1==93
recode s1aq6a (.=2) if hid =="4020540221001" & s1aq1==93
replace s1aq3b = 2 if s1aq3b == 0  & s1aq1 == 93 & hid == "4020540221001"
replace s1aq6b = 2 if s1aq6b == .  & s1aq1 == 93 & hid == "4020540221001"


///3810838102008
br hid-s1aq8b tot_consumed if hid =="3810838102008"  & s1aq1==93
recode s1aq5 (4=75) if hid =="3810838102008" & s1aq1==93
recode s1aq6a (75=4) if hid =="3810838102008" & s1aq1==93
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 93 & hid == "3810838102008"
replace s1aq6b = 12 if s1aq6b == 4  & s1aq1 == 93 & hid == "3810838102008"


///4110241106013
br hid-s1aq8b tot_consumed if hid =="4110241106013"  & s1aq1==93
recode s1aq4a (7=1) if hid =="4110241106013" & s1aq1==93
recode s1aq6a (7=1) if hid =="4110241106013" & s1aq1==93
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 93 & hid == "4110241106013"


///4111241102005
br hid-s1aq8b tot_consumed if hid =="4111241102005"  & s1aq1==93
recode s1aq4a (.=1) if hid =="4111241102005" & s1aq1==93
recode s1aq6a (3=1) if hid =="4111241102005" & s1aq1==93
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 93 & hid == "4111241102005"
replace s1aq4b = 6 if s1aq4b == .  & s1aq1 == 93 & hid == "4111241102005"


////4010740116003
br hid-s1aq8b tot_consumed if hid =="4010740116003"  & s1aq1==93
recode s1aq4a (7=1) if hid =="4010740116003" & s1aq1==93
recode s1aq6a (7=1) if hid =="4010740116003" & s1aq1==93
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 93 & hid == "4010740116003"


///4021240209005
br hid-s1aq8b tot_consumed if hid =="4021240209005"  & s1aq1==93
recode s1aq4a (7=1) if hid =="4021240209005" & s1aq1==93
recode s1aq6a (7=1) if hid =="4021240209005" & s1aq1==93
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 93 & hid == "4021240209005"


///8110281119012
br hid-s1aq8b tot_consumed if hid =="8110281119012"  & s1aq1==93
recode s1aq4a (200=2) if hid =="8110281119012" & s1aq1==93
recode s1aq5 (1=.) if hid =="8110281119012" & s1aq1==93
recode s1aq6a (.=2) if hid =="8110281119012" & s1aq1==93
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 93 & hid == "8110281119012"
replace s1aq4b = 12 if s1aq4b == 2  & s1aq1 == 93 & hid == "8110281119012"
replace s1aq6b = 12 if s1aq6b == .  & s1aq1 == 93 & hid == "8110281119012"

///5122551211003
br hid-s1aq8b tot_consumed if hid =="5122551211003"  & s1aq1==93
recode s1aq3a (12=1) if hid =="5122551211003" & s1aq1==93
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 93 & hid == "5122551211003"


///8221382211016
br hid-s1aq8b tot_consumed if hid =="8221382211016"  & s1aq1==93
recode s1aq6a (.=2) if hid =="8221382211016" & s1aq1==93
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 93 & hid == "8221382211016"
replace s1aq6b = 12 if s1aq6b == .  & s1aq1 == 93 & hid == "8221382211016"


///4021340214014
br hid-s1aq8b tot_consumed if hid =="4021340214014"  & s1aq1==93
recode s1aq6a (.=1) if hid =="4021340214014" & s1aq1==93
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 93 & hid == "4021340214014"
replace s1aq6b = 12 if s1aq6b == .  & s1aq1 == 93 & hid == "4021340214014"


///4311743142006
br hid-s1aq8b tot_consumed if hid =="4311743142006"  & s1aq1==93
recode s1aq6a (60=1) if hid =="4311743142006" & s1aq1==93
recode s1aq8a (8=.) if hid =="4311743142006" & s1aq1==93
replace s1aq3b = 8 if s1aq3b == 0  & s1aq1 == 93 & hid == "4311743142006"
replace s1aq6b = 8 if s1aq6b == 1  & s1aq1 == 93 & hid == "4311743142006"
replace s1aq8b = . if s1aq8b == 0  & s1aq1 == 93 & hid == "4311743142006"


///3711637103015
br hid-s1aq8b tot_consumed if hid =="3711637103015"  & s1aq1==93
recode s1aq4a (7=1) if hid =="3711637103015" & s1aq1==93
recode s1aq6a (7=1) if hid =="3711637103015" & s1aq1==93
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 93 & hid == "3711637103015"

///4021340217001
br hid-s1aq8b tot_consumed if hid =="4021340217001"  & s1aq1==93
recode s1aq3a (12=1) if hid =="4021340217001" & s1aq1==93
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 93 & hid == "4021340217001"


///3710137101013
br hid-s1aq8b tot_consumed if hid =="3710137101013"  & s1aq1==93
recode s1aq4a (7=1) if hid =="3710137101013" & s1aq1==93
recode s1aq6a (7=1) if hid =="3710137101013" & s1aq1==93
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 93 & hid == "3710137101013"


////4210242107015
br hid-s1aq8b tot_consumed if hid =="4210242107015"  & s1aq1==93
recode s1aq4a (7=1) if hid =="4210242107015" & s1aq1==93
recode s1aq6a (7=1) if hid =="4210242107015" & s1aq1==93
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 93 & hid == "4210242107015"


///5420754218010
br hid-s1aq8b tot_consumed if hid =="5420754218010"  & s1aq1==93
recode s1aq3a (12=1) if hid =="5420754218010" & s1aq1==93
recode s1aq4a (12=1) if hid =="5420754218010" & s1aq1==93
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 93 & hid == "5420754218010"


///5410454119006
br hid-s1aq8b tot_consumed if hid =="5410454119006"  & s1aq1==93
recode s1aq4a (3=2) if hid =="5410454119006" & s1aq1==93
recode s1aq6a (3=2) if hid =="5410454119006" & s1aq1==93
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 93 & hid == "5410454119006"


///4121441205012
br hid-s1aq8b tot_consumed if hid =="4121441205012"  & s1aq1==93
recode s1aq4a (7=1) if hid =="4121441205012" & s1aq1==93
recode s1aq6a (7=1) if hid =="4121441205012" & s1aq1==93
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 93 & hid == "4121441205012"


///3810738103010
br hid-s1aq8b tot_consumed if hid =="3810738103010"  & s1aq1==93
recode s1aq4a (4=1) if hid =="3810738103010" & s1aq1==93
recode s1aq6a (4=1) if hid =="3810738103010" & s1aq1==93
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 93 & hid == "3810738103010"


///4120441209006
br hid-s1aq8b tot_consumed if hid =="4120441209006"  & s1aq1==93
recode s1aq6a (7=.) if hid =="4120441209006" & s1aq1==93
recode s1aq8a (.=1) if hid =="4120441209006" & s1aq1==93
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 93 & hid == "4120441209006"
replace s1aq6b = . if s1aq6b == 12  & s1aq1 == 93 & hid == "4120441209006"
replace s1aq8b = 12 if s1aq8b == .  & s1aq1 == 93 & hid == "4120441209006"


///3010430108012
br hid-s1aq8b tot_consumed if hid =="3010430108012"  & s1aq1==93
recode s1aq3a (12=1) if hid =="3010430108012" & s1aq1==93
recode s1aq4a (12=1) if hid =="3010430108012" & s1aq1==93
replace s1aq3b = 12 if s1aq3b == 0  & s1aq1 == 93 & hid == "3010430108012"
replace s1aq6b = . if s1aq6b == 12  & s1aq1 == 93 & hid == "3010430108012"
replace s1aq8b = 12 if s1aq8b == .  & s1aq1 == 93 & hid == "3010430108012"


************** Milk Sacket *******************
///5310253106004
br hid-s1aq8b tot_consumed if hid =="5310253106004"  & s1aq1==94
recode s1aq6a (4=6) if hid =="5310253106004" & s1aq1==94
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 94 & hid == "5310253106004"
replace s1aq4b = 6 if s1aq4b == 5  & s1aq1 == 94 & hid == "5310253106004"

///4210242105005
br hid-s1aq8b tot_consumed if hid =="4210242105005"  & s1aq1==94
recode s1aq4a (75=7) if hid =="4210242105005" & s1aq1==94
recode s1aq8a (20=.) if hid =="4210242105005" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "4210242105005"
replace s1aq6b = 5 if s1aq6b == 0  & s1aq1 == 94 & hid == "4210242105005"
replace s1aq8b = . if s1aq8b == 0  & s1aq1 == 94 & hid == "4210242105005"


////4311743142012
br hid-s1aq8b tot_consumed if hid =="4311743142012"  & s1aq1==94
recode s1aq4a (14=7) if hid =="4311743142012" & s1aq1==94
recode s1aq6a (14=7) if hid =="4311743142012" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "4311743142012"
replace s1aq6b = 5 if s1aq6b == 0  & s1aq1 == 94 & hid == "4311743142012"
replace s1aq8b = . if s1aq8b == 0  & s1aq1 == 94 & hid == "4311743142012"


///6320363219011
br hid-s1aq8b tot_consumed if hid =="6320363219011"  & s1aq1==94
recode s1aq8a (2=.) if hid =="6320363219011" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "6320363219011"
replace s1aq8b = . if s1aq8b == 5  & s1aq1 == 94 & hid == "6320363219011"


///3211032132005
br hid-s1aq8b tot_consumed if hid =="3211032132005"  & s1aq1==94
recode s1aq6a (5=6) if hid =="3211032132005" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "3211032132005"


///3130231348002
br hid-s1aq8b tot_consumed if hid =="3130231348002"  & s1aq1==94
recode s1aq4a (5=3) if hid =="3130231348002" & s1aq1==94
recode s1aq6a (5=3) if hid =="3130231348002" & s1aq1==94
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 94 & hid == "3130231348002"


////3241332469010
br hid-s1aq8b tot_consumed if hid =="3241332469010"  & s1aq1==94
recode s1aq8a (2=.) if hid =="3241332469010" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "3241332469010"
replace s1aq8b = . if s1aq8b == 2  & s1aq1 == 94 & hid == "3241332469010"

///8020480214011
br hid-s1aq8b tot_consumed if hid =="8020480214011"  & s1aq1==94
recode s1aq6a (.=6) if hid =="8020480214011" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "8020480214011"
replace s1aq6b = 5 if s1aq6b == .  & s1aq1 == 94 & hid == "8020480214011"

///2130121308004
br hid-s1aq8b tot_consumed if hid =="2130121308004"  & s1aq1==94
recode s1aq8a (.=5) if hid =="2130121308004" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "2130121308004"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 94 & hid == "2130121308004"


///8211082125014
br hid-s1aq8b tot_consumed if hid =="8211082125014"  & s1aq1==94
recode s1aq6a (.=1) if hid =="8211082125014" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "8211082125014"
replace s1aq6b = 5 if s1aq6b == .  & s1aq1 == 94 & hid == "8211082125014"


///6420364203007
br hid-s1aq8b tot_consumed if hid =="6420364203007"  & s1aq1==94
recode s1aq6a (5=14) if hid =="6420364203007" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "6420364203007"


///8310283111016
br hid-s1aq8b tot_consumed if hid =="8310283111016"  & s1aq1==94
recode s1aq6a (.3=1) if hid =="8310283111016" & s1aq1==94
recode s1aq8a (.=2) if hid =="8310283111016" & s1aq1==94
replace s1aq3b = 1 if s1aq3b == 0  & s1aq1 == 94 & hid == "8310283111016"
replace s1aq8b = 1 if s1aq8b == .  & s1aq1 == 94 & hid == "8310283111016"


///8321583228006
br hid-s1aq8b tot_consumed if hid =="8321583228006"  & s1aq1==94
recode s1aq8a (2=.) if hid =="8321583228006" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "8321583228006"
replace s1aq8b = . if s1aq8b == 2  & s1aq1 == 94 & hid == "8321583228006"


///8013380113003
br hid-s1aq8b tot_consumed if hid =="8013380113003"  & s1aq1==94
recode s1aq4a (35=14) if hid =="8013380113003" & s1aq1==94
recode s1aq6a (35=14) if hid =="8013380113003" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "8013380113003"


///6430164315006
br hid-s1aq8b tot_consumed if hid =="6430164315006"  & s1aq1==94
recode s1aq4a (10=5) if hid =="6430164315006" & s1aq1==94
recode s1aq6a (10=5) if hid =="6430164315006" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "6430164315006"


///3721737202002
br hid-s1aq8b tot_consumed if hid =="3721737202002"  & s1aq1==94
recode s1aq6a (4=14) if hid =="3721737202002" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "3721737202002"

///8510185117015
br hid-s1aq8b tot_consumed if hid =="8510185117015"  & s1aq1==94
recode s1aq5 (14028=140) if hid =="8510185117015" & s1aq1==94
recode s1aq6a (5=28) if hid =="8510185117015" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "8510185117015"
replace s1aq6b = 5 if s1aq6b == 0  & s1aq1 == 94 & hid == "8510185117015"


///8013680119007
br hid-s1aq8b tot_consumed if hid =="8013680119007"  & s1aq1==94
recode s1aq6a (.=14) if hid =="8013680119007" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "8013680119007"
replace s1aq6b = 5 if s1aq6b == .  & s1aq1 == 94 & hid == "8013680119007"


///4410544103016
br hid-s1aq8b tot_consumed if hid =="4410544103016"  & s1aq1==94
recode s1aq6a (7=.) if hid =="4410544103016" & s1aq1==94
recode s1aq8a (.=6) if hid =="4410544103016" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "4410544103016"
replace s1aq6b = . if s1aq6b == 5  & s1aq1 == 94 & hid == "4410544103016"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 94 & hid == "4410544103016"


///4110341105011
br hid-s1aq8b tot_consumed if hid =="4110341105011"  & s1aq1==94
recode s1aq8a (8=.) if hid =="4110341105011" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "4110341105011"
replace s1aq8b = . if s1aq8b == 0  & s1aq1 == 94 & hid == "4110341105011"


///3223632201004
br hid-s1aq8b tot_consumed if hid =="3223632201004"  & s1aq1==94
recode s1aq8a (.=4) if hid =="3223632201004" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "3223632201004"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 94 & hid == "3223632201004"


///3720437211003
br hid-s1aq8b tot_consumed if hid =="3720437211003"  & s1aq1==94
recode s1aq8a (5=.) if hid =="3720437211003" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "3720437211003"
replace s1aq8b = . if s1aq8b == 5  & s1aq1 == 94 & hid == "3720437211003"


///3222432230001
br hid-s1aq8b tot_consumed if hid =="3222432230001"  & s1aq1==94
recode s1aq6a (12=7) if hid =="3222432230001" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "3222432230001"
replace s1aq6b = 5 if s1aq6b == 0  & s1aq1 == 94 & hid == "3222432230001"


////5310253107016
br hid-s1aq8b tot_consumed if hid =="5310253107016"  & s1aq1==94
recode s1aq6a (5=6) if hid =="5310253107016" & s1aq1==94
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 94 & hid == "5310253107016"
replace s1aq6b = 6 if s1aq6b == .  & s1aq1 == 94 & hid == "5310253107016"
replace s1aq4b = 6 if s1aq4b == 5  & s1aq1 == 94 & hid == "5310253107016"


////8110281136019
br hid-s1aq8b tot_consumed if hid =="8110281136019"  & s1aq1==94
recode s1aq6a (.=4) if hid =="8110281136019" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "8110281136019"
replace s1aq6b = 5 if s1aq6b == .  & s1aq1 == 94 & hid == "8110281136019"


///3421234208011
br hid-s1aq8b tot_consumed if hid =="3421234208011"  & s1aq1==94
recode s1aq6a (2=3) if hid =="3421234208011" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "3421234208011"


///8611886107002
br hid-s1aq8b tot_consumed if hid =="8611886107002"  & s1aq1==94
recode s1aq6a (5=15) if hid =="8611886107002" & s1aq1==94
recode s1aq8a (5=.) if hid =="8611886107002" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "8611886107002"
replace s1aq6b = 5 if s1aq6b == 15  & s1aq1 == 94 & hid == "8611886107002"
replace s1aq8b = . if s1aq8b == 0  & s1aq1 == 94 & hid == "8611886107002"

///3211032132009
br hid-s1aq8b tot_consumed if hid =="3211032132009"  & s1aq1==94
recode s1aq8a (1=.) if hid =="3211032132009" & s1aq1==94
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 94 & hid == "3211032132009"
replace s1aq8b = . if s1aq8b == 6  & s1aq1 == 94 & hid == "3211032132009"


///3022130267005
br hid-s1aq8b tot_consumed if hid =="3022130267005"  & s1aq1==94
recode s1aq3a (228=28) if hid =="3022130267005" & s1aq1==94
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 94 & hid == "3022130267005"


////7321373205004
br hid-s1aq8b tot_consumed if hid =="7321373205004"  & s1aq1==94
recode s1aq3a (2=4) if hid =="7321373205004" & s1aq1==94
recode s1aq6a (.=4) if hid =="7321373205004" & s1aq1==94
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 94 & hid == "7321373205004"
replace s1aq6b = 6 if s1aq6b == .  & s1aq1 == 94 & hid == "7321373205004"


///6313963104002
br hid-s1aq8b tot_consumed if hid =="6313963104002"  & s1aq1==94
recode s1aq3a (10=5) if hid =="6313963104002" & s1aq1==94
recode s1aq4a (10=5) if hid =="6313963104002" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "6313963104002"


///5121251218013
br hid-s1aq8b tot_consumed if hid =="5121251218013"  & s1aq1==94
recode s1aq6a (2=14) if hid =="5121251218013" & s1aq1==94
recode s1aq8a (2=.) if hid =="5121251218013" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "5121251218013"
replace s1aq6b = 5 if s1aq6b == 2  & s1aq1 == 94 & hid == "5121251218013"
replace s1aq8b = . if s1aq8b == 2  & s1aq1 == 94 & hid == "5121251218013"


///4311743142010
br hid-s1aq8b tot_consumed if hid =="4311743142010"  & s1aq1==94
recode s1aq3a (3=4) if hid =="4311743142010" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "4311743142010"


///4011440105008
br hid-s1aq8b tot_consumed if hid =="4011440105008"  & s1aq1==94
recode s1aq3a (6=5) if hid =="4011440105008" & s1aq1==94
recode s1aq4a (6=5) if hid =="4011440105008" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "4011440105008"
replace s1aq6b = 5 if s1aq6b == 12  & s1aq1 == 94 & hid == "4011440105008"


///5410454119006
br hid-s1aq8b tot_consumed if hid =="5410454119006"  & s1aq1==94
recode s1aq3a (.5=5) if hid =="5410454119006" & s1aq1==94
recode s1aq5 (800=80) if hid =="5410454119006" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "5410454119006"


////3010430146015
br hid-s1aq8b tot_consumed if hid =="3010430146015"  & s1aq1==94
recode s1aq3a (5=4) if hid =="3010430146015" & s1aq1==94
recode s1aq4a (5=4) if hid =="3010430146015" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "3010430146015"


///3210532170006
br hid-s1aq8b tot_consumed if hid =="3210532170006"  & s1aq1==94
recode s1aq4a (6=5) if hid =="3210532170006" & s1aq1==94
recode s1aq6a (6=5) if hid =="3210532170006" & s1aq1==94
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 94 & hid == "3210532170006"


///3144131462014
br hid-s1aq8b tot_consumed if hid =="3144131462014"  & s1aq1==94
recode s1aq8a (5=.) if hid =="3144131462014" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "3144131462014"
replace s1aq8b = . if s1aq8b == 0  & s1aq1 == 94 & hid == "3144131462014"


///3022130267006
br hid-s1aq8b tot_consumed if hid =="3022130267006"  & s1aq1==94
recode s1aq3a (26=2) if hid =="3022130267006" & s1aq1==94
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 94 & hid == "3022130267006"


///8020480225011
br hid-s1aq8b tot_consumed if hid =="8020480225011"  & s1aq1==94
recode s1aq6a (1=10) if hid =="8020480225011" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "8020480225011"


///3210432144010
br hid-s1aq8b tot_consumed if hid =="3210432144010"  & s1aq1==94
recode s1aq6a (5=6) if hid =="3210432144010" & s1aq1==94
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 94 & hid == "3210432144010"
replace s1aq4b = 6 if s1aq4b == 5  & s1aq1 == 94 & hid == "3210432144010"


///5121251218011
br hid-s1aq8b tot_consumed if hid =="5121251218011"  & s1aq1==94
recode s1aq6a (.=14) if hid =="5121251218011" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "5121251218011"
replace s1aq6b = 5 if s1aq6b == .  & s1aq1 == 94 & hid == "5121251218011"


////3820638202013
br hid-s1aq8b tot_consumed if hid =="3820638202013"  & s1aq1==94
recode s1aq8a (.=15) if hid =="3820638202013" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "3820638202013"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 94 & hid == "3820638202013"

///5530155356004
br hid-s1aq8b tot_consumed if hid =="5530155356004"  & s1aq1==94
recode s1aq4a (20=10) if hid =="5530155356004" & s1aq1==94
recode s1aq6a (20=10) if hid =="5530155356004" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "5530155356004"


///8520685220010
br hid-s1aq8b tot_consumed if hid =="8520685220010"  & s1aq1==94
recode s1aq8a (90=.) if hid =="8520685220010" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "8520685220010"
replace s1aq8b = . if s1aq8b == 0  & s1aq1 == 94 & hid == "8520685220010"


///4311543118012
br hid-s1aq8b tot_consumed if hid =="4311543118012"  & s1aq1==94
recode s1aq4a (122=12) if hid =="4311543118012" & s1aq1==94
recode s1aq6a (122=12) if hid =="4311543118012" & s1aq1==94
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 94 & hid == "4311543118012"


///3230232347005
br hid-s1aq8b tot_consumed if hid =="3230232347005"  & s1aq1==94
recode s1aq3a (1414=14) if hid =="3230232347005" & s1aq1==94
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 94 & hid == "3230232347005"


///3310733120008
br hid-s1aq8b tot_consumed if hid =="3310733120008"  & s1aq1==94
recode s1aq8a (14=.) if hid =="3310733120008" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "3310733120008"
replace s1aq8b = . if s1aq8b == 5  & s1aq1 == 94 & hid == "3310733120008"


///5411254109013
br hid-s1aq8b tot_consumed if hid =="5411254109013"  & s1aq1==94
recode s1aq4a (25=5) if hid =="5411254109013" & s1aq1==94
recode s1aq6a (25=5) if hid =="5411254109013" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "5411254109013"


///5220952204009
br hid-s1aq8b tot_consumed if hid =="5220952204009"  & s1aq1==94
recode s1aq3a (5=14) if hid =="5220952204009" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "5220952204009"


///8010180140011
br hid-s1aq8b tot_consumed if hid =="8010180140011"  & s1aq1==94
recode s1aq6a (.=28) if hid =="8010180140011" & s1aq1==94
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 94 & hid == "8010180140011"
replace s1aq6b = 6 if s1aq6b == .  & s1aq1 == 94 & hid == "8010180140011"


////4111241102005
br hid-s1aq8b tot_consumed if hid =="4111241102005"  & s1aq1==94
recode s1aq6a (.=3) if hid =="4111241102005" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "4111241102005"
replace s1aq6b = 5 if s1aq6b == .  & s1aq1 == 94 & hid == "4111241102005"


///8410284108002
br hid-s1aq8b tot_consumed if hid =="8410284108002"  & s1aq1==94
recode s1aq6a (5=4) if hid =="8410284108002" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "8410284108002"
replace s1aq6b = 5 if s1aq6b == 0  & s1aq1 == 94 & hid == "8410284108002"


///8011980136014
br hid-s1aq8b tot_consumed if hid =="8011980136014"  & s1aq1==94
recode s1aq8a (5=.) if hid =="8011980136014" & s1aq1==94
recode s1aq3a (1=5) if hid =="8011980136014" & s1aq1==94
recode s1aq4a (50=5) if hid =="8011980136014" & s1aq1==94
recode s1aq6a (50=5) if hid =="8011980136014" & s1aq1==94
recode s1aq5 (5=50) if hid =="8011980136014" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "8011980136014"
replace s1aq8b = . if s1aq8b == 0  & s1aq1 == 94 & hid == "8011980136014"


///7220472230008
br hid-s1aq8b tot_consumed if hid =="7220472230008"  & s1aq1==94
recode s1aq8a (.=3) if hid =="7220472230008" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "7220472230008"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 94 & hid == "7220472230008"


///3080730851015
br hid-s1aq8b tot_consumed if hid =="3080730851015"  & s1aq1==94
recode s1aq6a (.=4) if hid =="3080730851015" & s1aq1==94
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 94 & hid == "3080730851015"
replace s1aq6b = 6 if s1aq6b == .  & s1aq1 == 94 & hid == "3080730851015"


///8020480221004
br hid-s1aq8b tot_consumed if hid =="8020480221004"  & s1aq1==94
recode s1aq8a (.=3) if hid =="8020480221004" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "8020480221004"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 94 & hid == "8020480221004"


///4020540221002
br hid-s1aq8b tot_consumed if hid =="4020540221002"  & s1aq1==94
recode s1aq6a (35=49) if hid =="4020540221002" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "4020540221002"


///3210632121002
br hid-s1aq8b tot_consumed if hid =="3210632121002"  & s1aq1==94
recode s1aq8a (5=.) if hid =="3210632121002" & s1aq1==94
recode s1aq5 (25=35) if hid =="3210632121002" & s1aq1==94
recode s1aq6a (35=7) if hid =="3210632121002" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "3210632121002"
replace s1aq8b = . if s1aq8b == 0  & s1aq1 == 94 & hid == "3210632121002"
replace s1aq6b = 5 if s1aq6b == 7  & s1aq1 == 94 & hid == "3210632121002"


///3240932442003
br hid-s1aq8b tot_consumed if hid =="3240932442003"  & s1aq1==94
recode s1aq6a (1=5) if hid =="3240932442003" & s1aq1==94
recode s1aq8a (1=.) if hid =="3240932442003" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "3240932442003"
replace s1aq6b = 5 if s1aq6b == 1  & s1aq1 == 94 & hid == "3240932442003"
replace s1aq8b = . if s1aq8b == 1  & s1aq1 == 94 & hid == "3240932442003"


///4022440219009
br hid-s1aq8b tot_consumed if hid =="4022440219009"  & s1aq1==94
recode s1aq4a (35=7) if hid =="4022440219009" & s1aq1==94
recode s1aq5 (5=35) if hid =="4022440219009" & s1aq1==94
recode s1aq6a (35=7) if hid =="4022440219009" & s1aq1==94
recode s1aq8a (5=.) if hid =="4022440219009" & s1aq1==94
replace s1aq3b = 7 if s1aq3b == 0  & s1aq1 == 94 & hid == "4022440219009"
replace s1aq8b = . if s1aq8b == 0  & s1aq1 == 94 & hid == "4022440219009"
replace s1aq8b = . if s1aq8b == 1  & s1aq1 == 94 & hid == "4022440219009"

///8211082125016****** start of new dofile*****
br hid-s1aq8b tot_consumed if hid =="8211082125016"  & s1aq1==94
recode s1aq6a (.=6) if hid =="8211082125016" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "8211082125016"
replace s1aq6b = 5 if s1aq6b == .  & s1aq1 == 94 & hid == "8211082125016"


////8020580247002
br hid-s1aq8b tot_consumed if hid =="8020580247002"  & s1aq1==94
recode s1aq6a (.=14) if hid =="8020580247002" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "8020580247002"
replace s1aq6b = 5 if s1aq6b == .  & s1aq1 == 94 & hid == "8020580247002"


///4121441205015
br hid-s1aq8b tot_consumed if hid =="4121441205015"  & s1aq1==94
recode s1aq6a (4=5) if hid =="4121441205015" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "4121441205015"
replace s1aq6b = 5 if s1aq6b == .  & s1aq1 == 94 & hid == "4121441205015"


///4021240209004
br hid-s1aq8b tot_consumed if hid =="4021240209004"  & s1aq1==94
recode s1aq6a (5=7) if hid =="4021240209004" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "4021240209004"
replace s1aq6b = 5 if s1aq6b == .  & s1aq1 == 94 & hid == "4021240209004"


///5012950104004
br hid-s1aq8b tot_consumed if hid =="5012950104004"  & s1aq1==94
recode s1aq3a (5=14) if hid =="5012950104004" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "5012950104004"


///5320953206016
br hid-s1aq8b tot_consumed if hid =="5320953206016"  & s1aq1==94
recode s1aq6a (2=3) if hid =="5320953206016" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "5320953206016"


///1230112304012
br hid-s1aq8b tot_consumed if hid =="1230112304012"  & s1aq1==94
recode s1aq6a (.=14) if hid =="1230112304012" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "1230112304012"
replace s1aq6b = 5 if s1aq6b == .  & s1aq1 == 94 & hid == "1230112304012"


///3144131452016
br hid-s1aq8b tot_consumed if hid =="3144131452016"  & s1aq1==94
recode s1aq4a (10=6) if hid =="3144131452016" & s1aq1==94
recode s1aq6a (10=6) if hid =="3144131452016" & s1aq1==94
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 94 & hid == "3144131452016"


///5013050113013
br hid-s1aq8b tot_consumed if hid =="5013050113013"  & s1aq1==94
recode s1aq8a (20=.) if hid =="5013050113013" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "5013050113013"
replace s1aq8b = . if s1aq8b == 0  & s1aq1 == 94 & hid == "5013050113013"


///3133631313011
br hid-s1aq8b tot_consumed if hid =="3133631313011"  & s1aq1==94
recode s1aq3a (5=1) if hid =="3133631313011" & s1aq1==94
recode s1aq4a (5=1) if hid =="3133631313011" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "3133631313011"


///8220282217016
br hid-s1aq8b tot_consumed if hid =="8220282217016"  & s1aq1==94
recode s1aq8a (6=.) if hid =="8220282217016" & s1aq1==94
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 94 & hid == "8220282217016"
replace s1aq6b = 6 if s1aq6b == 10  & s1aq1 == 94 & hid == "8220282217016"
replace s1aq8b = . if s1aq8b == 0  & s1aq1 == 94 & hid == "8220282217016"


////4021340214009
br hid-s1aq8b tot_consumed if hid =="4021340214009"  & s1aq1==94
recode s1aq8a (5=.) if hid =="4021340214009" & s1aq1==94
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 94 & hid == "4021340214009"
replace s1aq4b = 6 if s1aq4b == 5  & s1aq1 == 94 & hid == "4021340214009"
replace s1aq8b = . if s1aq8b == 0  & s1aq1 == 94 & hid == "4021340214009"


///3421234208009
br hid-s1aq8b tot_consumed if hid =="3421234208009"  & s1aq1==94
recode s1aq8a (4=.) if hid =="3421234208009" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "3421234208009"
replace s1aq8b = . if s1aq8b == 5  & s1aq1 == 94 & hid == "3421234208009"


////2410124101006
br hid-s1aq8b tot_consumed if hid =="2410124101006"  & s1aq1==94
recode s1aq6a (.=70) if hid =="2410124101006" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "2410124101006"
replace s1aq6b = 5 if s1aq6b == .  & s1aq1 == 94 & hid == "2410124101006"


///3010430146010
br hid-s1aq8b tot_consumed if hid =="3010430146010"  & s1aq1==94
recode s1aq8a (.=14) if hid =="3010430146010" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "3010430146010"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 94 & hid == "3010430146010"


///3060530617008
br hid-s1aq8b tot_consumed if hid =="3060530617008"  & s1aq1==94
recode s1aq6a (5=3) if hid =="3060530617008" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "3060530617008"
replace s1aq6b = 5 if s1aq6b == 3  & s1aq1 == 94 & hid == "3060530617008"


///3410334108015/// verify price
br hid-s1aq8b tot_consumed if hid =="3410334108015"  & s1aq1==94
recode s1aq6a (5=7) if hid =="3410334108015" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "3410334108015"
replace s1aq6b = 5 if s1aq6b == 0  & s1aq1 == 94 & hid == "3410334108015"

///5020150236011
br hid-s1aq8b tot_consumed if hid =="5020150236011"  & s1aq1==94
recode s1aq6a (46=4) if hid =="5020150236011" & s1aq1==94
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 94 & hid == "5020150236011"
replace s1aq6b = 6 if s1aq6b == 0  & s1aq1 == 94 & hid == "5020150236011"


///8110281136009
br hid-s1aq8b tot_consumed if hid =="8110281136009"  & s1aq1==94
recode s1aq6a (.=7) if hid =="8110281136009" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "8110281136009"
replace s1aq6b = 5 if s1aq6b == .  & s1aq1 == 94 & hid == "8110281136009"


///7321573207015
br hid-s1aq8b tot_consumed if hid =="7321573207015"  & s1aq1==94
recode s1aq6a (5=2) if hid =="7321573207015" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "7321573207015"
replace s1aq6b = 5 if s1aq6b == 6  & s1aq1 == 94 & hid == "7321573207015"


///8013680119001
br hid-s1aq8b tot_consumed if hid =="8013680119001"  & s1aq1==94
recode s1aq3a (5=14) if hid =="8013680119001" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "8013680119001"


///5320953203002
br hid-s1aq8b tot_consumed if hid =="5320953203002"  & s1aq1==94
recode s1aq4a (5=4) if hid =="5320953203002" & s1aq1==94
recode s1aq6a (5=4) if hid =="5320953203002" & s1aq1==94
recode s1aq5 (29=20) if hid =="5320953203002" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "5320953203002"


///5310253107002
br hid-s1aq8b tot_consumed if hid =="5310253107002"  & s1aq1==94
recode s1aq6a (5=2) if hid =="5310253107002" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "5310253107002"
replace s1aq6b = 5 if s1aq6b == 2  & s1aq1 == 94 & hid == "5310253107002"


///6122961212010
br hid-s1aq8b tot_consumed if hid =="6122961212010"  & s1aq1==94
recode s1aq8a (4=.) if hid =="6122961212010" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "6122961212010"
replace s1aq8b = . if s1aq8b == 5  & s1aq1 == 94 & hid == "6122961212010"



///5111951130014
br hid-s1aq8b tot_consumed if hid =="5111951130014"  & s1aq1==94
recode s1aq3a (1=3) if hid =="5111951130014" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "5111951130014"


///4311543134006
br hid-s1aq8b tot_consumed if hid =="4311543134006"  & s1aq1==94
recode s1aq3a (4=5) if hid =="4311543134006" & s1aq1==94
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 94 & hid == "4311543134006"


********* 95 Cream ************
///8020580247018
br hid-s1aq8b tot_consumed if hid =="8020580247018"  & s1aq1==95
recode s1aq7a (3=.) if hid =="8020580247018" & s1aq1==95
replace s1aq3b = 4 if s1aq3b == 0  & s1aq1 == 95 & hid == "8020580247018"
replace s1aq7b = . if s1aq7b == 4  & s1aq1 == 95 & hid == "8020580247018"


///3020230247001
br hid-s1aq8b tot_consumed if hid =="3020230247001"  & s1aq1==95
recode s1aq3a (3=2) if hid =="3020230247001" & s1aq1==95
replace s1aq3b = 11 if s1aq3b == 0  & s1aq1 == 95 & hid == "3020230247001"


///8321783202013
br hid-s1aq8b tot_consumed if hid =="8321783202013"  & s1aq1==95
recode s1aq6a (4=14) if hid =="8321783202013" & s1aq1==95
replace s1aq3b = 11 if s1aq3b == 0  & s1aq1 == 95 & hid == "8321783202013"


///8621086206011
br hid-s1aq8b tot_consumed if hid =="8621086206011"  & s1aq1==95
recode s1aq8a (90=.) if hid =="8621086206011" & s1aq1==95
replace s1aq3b = 11 if s1aq3b == 0  & s1aq1 == 95 & hid == "8621086206011"
replace s1aq8b = . if s1aq8b == 0  & s1aq1 == 95 & hid == "8621086206011"


///3133631305001
br hid-s1aq8b tot_consumed if hid =="3133631305001"  & s1aq1==95
recode s1aq6a (6=5) if hid =="3133631305001" & s1aq1==95
recode s1aq7a (5=.) if hid =="3133631305001" & s1aq1==95
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 95 & hid == "3133631305001"
replace s1aq7b = . if s1aq7b == 6  & s1aq1 == 95 & hid == "3133631305001"


////3240432416011
br hid-s1aq8b tot_consumed if hid =="3240432416011"  & s1aq1==95
recode s1aq6a (1=6) if hid =="3240432416011" & s1aq1==95
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 95 & hid == "3240432416011"


///8410784115008
br hid-s1aq8b tot_consumed if hid =="8410784115008"  & s1aq1==95
recode s1aq3a (11=1) if hid =="8410784115008" & s1aq1==95
recode s1aq4a (11=1) if hid =="8410784115008" & s1aq1==95
replace s1aq3b = 11 if s1aq3b == 0  & s1aq1 == 95 & hid == "8410784115008"


////1110111112015
br hid-s1aq8b tot_consumed if hid =="1110111112015"  & s1aq1==95
recode s1aq3a (.4=4) if hid =="1110111112015" & s1aq1==95
recode s1aq4a (.4=4) if hid =="1110111112015" & s1aq1==95
recode s1aq6a (.4=4) if hid =="1110111112015" & s1aq1==95
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 95 & hid == "1110111112015"
replace s1aq4b = 5 if s1aq4b == 3  & s1aq1 == 95 & hid == "1110111112015"
replace s1aq6b = 5 if s1aq6b == 3  & s1aq1 == 95 & hid == "1110111112015"


////3240232403007
br hid-s1aq8b tot_consumed if hid =="3240232403007"  & s1aq1==95
recode s1aq4a (10=5) if hid =="3240232403007" & s1aq1==95
recode s1aq6a (10=5) if hid =="3240232403007" & s1aq1==95
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 95 & hid == "3240232403007"



///4311743142009
br hid-s1aq8b tot_consumed if hid =="4311743142009"  & s1aq1==95
recode s1aq3a (6=10) if hid =="4311743142009" & s1aq1==95
replace s1aq3b = 10 if s1aq3b == 0  & s1aq1 == 95 & hid == "4311743142009"


///5622156219016
br hid-s1aq8b tot_consumed if hid =="5622156219016"  & s1aq1==95
recode s1aq3a (10=1) if hid =="5622156219016" & s1aq1==95
recode s1aq4a (10=1) if hid =="5622156219016" & s1aq1==95
replace s1aq3b = 10 if s1aq3b == 0  & s1aq1 == 95 & hid == "5622156219016"


///5411654115009
br hid-s1aq8b tot_consumed if hid =="5411654115009"  & s1aq1==95
recode s1aq8a (2=.) if hid =="5411654115009" & s1aq1==95
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 95 & hid == "5411654115009"
replace s1aq8b = . if s1aq6b == 6 & s1aq1 == 95 & hid == "5411654115009"


///5320653207001
br hid-s1aq8b tot_consumed if hid =="5320653207001"  & s1aq1==95
recode s1aq6a (12=14) if hid =="5320653207001" & s1aq1==95
replace s1aq3b = 11 if s1aq3b == 0  & s1aq1 == 95 & hid == "5320653207001"


///3720737207012
br hid-s1aq8b tot_consumed if hid =="3720737207012"  & s1aq1==95
recode s1aq6a (2=4) if hid =="3720737207012" & s1aq1==95
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 95 & hid == "3720737207012"


////8211082125016
br hid-s1aq8b tot_consumed if hid =="8211082125016"  & s1aq1==95
recode s1aq6a (.=2) if hid =="8211082125016" & s1aq1==95
replace s1aq3b = 99 if s1aq3b == 0  & s1aq1 == 95 & hid == "8211082125016"
replace s1aq6b = 99 if s1aq6b == .  & s1aq1 == 95 & hid == "8211082125016"


///8322383234013
br hid-s1aq8b tot_consumed if hid =="8322383234013"  & s1aq1==95
recode s1aq4a (9=7) if hid =="8322383234013" & s1aq1==95
recode s1aq6a (9=7) if hid =="8322383234013" & s1aq1==95
recode s1aq5 (140=35) if hid =="8322383234013" & s1aq1==95
replace s1aq3b = 99 if s1aq3b == 0  & s1aq1 == 95 & hid == "8322383234013"


///5320653207009
br hid-s1aq8b tot_consumed if hid =="5320653207009"  & s1aq1==95
recode s1aq4a (3.5=3) if hid =="5320653207009" & s1aq1==95
recode s1aq6a (3.5=3) if hid =="5320653207009" & s1aq1==95
recode s1aq5 (35=30) if hid =="5320653207009" & s1aq1==95
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 95 & hid == "5320653207009"
replace s1aq4b = 5 if s1aq4b == 3  & s1aq1 == 95 & hid == "5320653207009"
replace s1aq6b = 5 if s1aq6b == 3  & s1aq1 == 95 & hid == "5320653207009"


////8110281136009
br hid-s1aq8b tot_consumed if hid =="8110281136009"  & s1aq1==95
recode s1aq6a (.=4) if hid =="8110281136009" & s1aq1==95
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 95 & hid == "8110281136009"
replace s1aq4b = 5 if s1aq4b == 0  & s1aq1 == 95 & hid == "8110281136009"
replace s1aq6b = 5 if s1aq6b == .  & s1aq1 == 95 & hid == "8110281136009"


///5611756102014
br hid-s1aq8b tot_consumed if hid =="5611756102014"  & s1aq1==95
recode s1aq3a (2=3) if hid =="5611756102014" & s1aq1==95
replace s1aq3b = 10 if s1aq3b == 0  & s1aq1 == 95 & hid == "5611756102014"


///5420754217001
br hid-s1aq8b tot_consumed if hid =="5420754217001"  & s1aq1==95
recode s1aq6a (2=4) if hid =="5420754217001" & s1aq1==95
replace s1aq3b = 11 if s1aq3b == 0  & s1aq1 == 95 & hid == "5420754217001"


///5310953114014
br hid-s1aq8b tot_consumed if hid =="5310953114014"  & s1aq1==95
recode s1aq7a (8=.) if hid =="5310953114014" & s1aq1==95
recode s1aq8a (8=.) if hid =="5310953114014" & s1aq1==95
replace s1aq3b = 11 if s1aq3b == 0  & s1aq1 == 95 & hid == "5310953114014"
replace s1aq7b = . if s1aq7b == 0  & s1aq1 == 95 & hid == "5310953114014"
replace s1aq8b = . if s1aq8b == 8  & s1aq1 == 95 & hid == "5310953114014"


////5023050213007
br hid-s1aq8b tot_consumed if hid =="5023050213007"  & s1aq1==95
recode s1aq3a (20=2) if hid =="5023050213007" & s1aq1==95
replace s1aq3b = 10 if s1aq3b == 0  & s1aq1 == 95 & hid == "5023050213007"


////3240932442012
br hid-s1aq8b tot_consumed if hid =="3240932442012"  & s1aq1==95
recode s1aq3a (5=15) if hid =="3240932442012" & s1aq1==95
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 95 & hid == "3240932442012"


///3810438110014
br hid-s1aq8b tot_consumed if hid =="3810438110014"  & s1aq1==95
recode s1aq3a (77=7) if hid =="3810438110014" & s1aq1==95
replace s1aq3b = 7 if s1aq3b == 0  & s1aq1 == 95 & hid == "3810438110014"


/*
************* 97 ********* //was not in my data file but if need be you can use it//

///1210112104002
br hid-s1aq8b tot_consumed if hid =="1210112104002"  & s1aq1==97
recode s1aq8a (.=10) if hid =="1210112104002" & s1aq1==97
replace s1aq3b = 99 if s1aq3b == 0  & s1aq1 == 97 & hid == "1210112104002"
replace s1aq8b = 99 if s1aq8b == .  & s1aq1 == 97 & hid == "1210112104002"


****** 99 Plain Yoghurt *************
///3022130267002
br hid-s1aq8b tot_consumed if hid =="3022130267002"  & s1aq1==99
recode s1aq4a (55=5) if hid =="3022130267002" & s1aq1==99
recode s1aq6a (55=5) if hid =="3022130267002" & s1aq1==99
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 99 & hid == "3022130267002"


////2110321101009
br hid-s1aq8b tot_consumed if hid =="2110321101009"  & s1aq1==99
recode s1aq8a (.=5) if hid =="2110321101009" & s1aq1==99
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 99 & hid == "2110321101009"
replace s1aq8b = 5 if s1aq8b == .  & s1aq1 == 99 & hid == "2110321101009"


///3130231348014
br hid-s1aq8b tot_consumed if hid =="3130231348014"  & s1aq1==99
recode s1aq6a (1=2) if hid =="3130231348014" & s1aq1==99
recode s1aq5 (100=10) if hid =="3130231348014" & s1aq1==99
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 99 & hid == "3130231348014"
*/



******* 101 Eggs of hen local breed***************
////2420224209005
br hid-s1aq8b tot_consumed if hid =="2420224209005"  & s1aq1==101
recode s1aq8a (.=12) if hid =="2420224209005" & s1aq1==101
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 101 & hid == "2420224209005"
replace s1aq8b = 6 if s1aq8b == .  & s1aq1 == 101 & hid == "2420224209005"


///5120651225002
br hid-s1aq8b tot_consumed if hid =="5120651225002"  & s1aq1==101
recode s1aq8a (.=1) if hid =="5120651225002" & s1aq1==101
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 101 & hid == "5120651225002"
replace s1aq8b = 6 if s1aq8b == .  & s1aq1 == 101 & hid == "5120651225002"


///6211662120010
br hid-s1aq8b tot_consumed if hid =="6211662120010"  & s1aq1==101
recode s1aq8a (6=.) if hid =="6211662120010" & s1aq1==101
recode s1aq4a (0=.) if hid =="6211662120010" & s1aq1==101
recode s1aq7a (6=5) if hid =="6211662120010" & s1aq1==101
replace s1aq3b = 5 if s1aq3b == 0  & s1aq1 == 101 & hid == "6211662120010"
replace s1aq8b = . if s1aq8b == 0  & s1aq1 == 101 & hid == "6211662120010"
replace s1aq4b = . if s1aq4b == 6  & s1aq1 == 101 & hid == "6211662120010"


///4220442209005
br hid-s1aq8b tot_consumed if hid =="4220442209005"  & s1aq1==101
recode s1aq7a (1=.) if hid =="4220442209005" & s1aq1==101
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 101 & hid == "4220442209005"
replace s1aq7b = . if s1aq7b == 6  & s1aq1 == 101 & hid == "4220442209005"


///4010840110010
br hid-s1aq8b tot_consumed if hid =="4010840110010"  & s1aq1==101
recode s1aq8a (1=.) if hid =="4010840110010" & s1aq1==101
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 101 & hid == "4010840110010"
replace s1aq8b = . if s1aq8b == 6  & s1aq1 == 101 & hid == "4010840110010"


///4210242106004
br hid-s1aq8b tot_consumed if hid =="4210242106004"  & s1aq1==101
recode s1aq7a (1=.) if hid =="4210242106004" & s1aq1==101
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 101 & hid == "4210242106004"
replace s1aq7b = . if s1aq7b == 6  & s1aq1 == 101 & hid == "4210242106004"


///5211052111005
br hid-s1aq8b tot_consumed if hid =="5211052111005"  & s1aq1==101
recode s1aq7a (12=.) if hid =="5211052111005" & s1aq1==101
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 101 & hid == "5211052111005"
replace s1aq7b = . if s1aq7b == 6  & s1aq1 == 101 & hid == "5211052111005"


///4120341211004
br hid-s1aq8b tot_consumed if hid =="4120341211004"  & s1aq1==101
recode s1aq3a (6=5) if hid =="4120341211004" & s1aq1==101
recode s1aq4a (6=5) if hid =="4120341211004" & s1aq1==101
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 101 & hid == "4120341211004"
replace s1aq4b = 6 if s1aq4b == 5  & s1aq1 == 101 & hid == "4120341211004"
replace s1aq6b = 6 if s1aq6b == 5  & s1aq1 == 101 & hid == "4120341211004"


///5121251218014
br hid-s1aq8b tot_consumed if hid =="5121251218014"  & s1aq1==101
recode s1aq7a (5=.) if hid =="5121251218014" & s1aq1==101
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 101 & hid == "5121251218014"
replace s1aq7b = . if s1aq7b == 6  & s1aq1 == 101 & hid == "5121251218014"


///8511285124010
br hid-s1aq8b tot_consumed if hid =="8511285124010"  & s1aq1==101
recode s1aq6a (1=10) if hid =="8511285124010" & s1aq1==101
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 101 & hid == "8511285124010"


////5310253111007
br hid-s1aq8b tot_consumed if hid =="5310253111007"  & s1aq1==101
recode s1aq6a (.=4) if hid =="5310253111007" & s1aq1==101
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 101 & hid == "5310253111007"
replace s1aq6b = 6 if s1aq6b == .  & s1aq1 == 101 & hid == "5310253111007"


///3710137101016
br hid-s1aq8b tot_consumed if hid =="3710137101016"  & s1aq1==101
recode s1aq8a (6=.) if hid =="3710137101016" & s1aq1==101
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 101 & hid == "3710137101016"
replace s1aq8b = . if s1aq8b == 0  & s1aq1 == 101 & hid == "3710137101016"


///4120441209013
br hid-s1aq8b tot_consumed if hid =="4120441209013"  & s1aq1==101
recode s1aq7a (1=.) if hid =="4120441209013" & s1aq1==101
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 101 & hid == "4120441209013"
replace s1aq7b = . if s1aq7b == 6  & s1aq1 == 101 & hid == "4120441209013"


///3520735220006
br hid-s1aq8b tot_consumed if hid =="3520735220006"  & s1aq1==101
recode s1aq7a (3=.) if hid =="3520735220006" & s1aq1==101
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 101 & hid == "3520735220006"
replace s1aq7b = . if s1aq7b == 0  & s1aq1 == 101 & hid == "3520735220006"


///4011140114003
br hid-s1aq8b tot_consumed if hid =="4011140114003"  & s1aq1==101
recode s1aq8a (1=.) if hid =="4011140114003" & s1aq1==101
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 101 & hid == "4011140114003"
replace s1aq8b = . if s1aq8b == 6  & s1aq1 == 101 & hid == "4011140114003"


///5211652115006
br hid-s1aq8b tot_consumed if hid =="5211652115006"  & s1aq1==101
recode s1aq6a (.=5) if hid =="5211652115006" & s1aq1==101
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 101 & hid == "5211652115006"
replace s1aq6b = 6 if s1aq6b == .  & s1aq1 == 101 & hid == "5211652115006"


///6022260212013
br hid-s1aq8b tot_consumed if hid =="6022260212013"  & s1aq1==101
recode s1aq7a (3=.) if hid =="6022260212013" & s1aq1==101
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 101 & hid == "6022260212013"
replace s1aq7b = . if s1aq7b == 6  & s1aq1 == 101 & hid == "6022260212013"


///6020160224008
br hid-s1aq8b tot_consumed if hid =="6020160224008"  & s1aq1==101
recode s1aq4a (0=.) if hid =="6020160224008" & s1aq1==101
recode s1aq8a (2=.) if hid =="6020160224008" & s1aq1==101
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 101 & hid == "6020160224008"
replace s1aq4b = . if s1aq4b == 6  & s1aq1 == 101 & hid == "6020160224008"
replace s1aq8b = . if s1aq8b == 6  & s1aq1 == 101 & hid == "6020160224008"


///7010870115003
br hid-s1aq8b tot_consumed if hid =="7010870115003"  & s1aq1==101
recode s1aq4a (9=5) if hid =="7010870115003" & s1aq1==101
recode s1aq6a (9=5) if hid =="7010870115003" & s1aq1==101
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 101 & hid == "7010870115003"



****************** 102 Eggs of hen industrial breed ************
///5210452105009
br hid-s1aq8b tot_consumed if hid =="5210452105009"  & s1aq1==102
recode s1aq7a (.=6) if hid =="5210452105009" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "5210452105009"
replace s1aq7b = 6 if s1aq7b == .  & s1aq1 == 102 & hid == "5210452105009"


///2310123112016
br hid-s1aq8b tot_consumed if hid =="2310123112016"  & s1aq1==102
recode s1aq7a (.=8) if hid =="2310123112016" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "2310123112016"
replace s1aq7b = 6 if s1aq7b == .  & s1aq1 == 102 & hid == "2310123112016"


///1220112205011
br hid-s1aq8b tot_consumed if hid =="1220112205011"  & s1aq1==102
recode s1aq3a (1=10) if hid =="1220112205011" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "1220112205011"
replace s1aq7b = 6 if s1aq7b == .  & s1aq1 == 102 & hid == "1220112205011"


//2010120117009
br hid-s1aq8b tot_consumed if hid =="2010120117009"  & s1aq1==102
recode s1aq8a (.=8) if hid =="2010120117009" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "2010120117009"
replace s1aq8b = 6 if s1aq8b == .  & s1aq1 == 102 & hid == "2010120117009"


///3040130406009
br hid-s1aq8b tot_consumed if hid =="3040130406009"  & s1aq1==102
recode s1aq4a (24=3) if hid =="3040130406009" & s1aq1==102
recode s1aq5 (6=8) if hid =="3040130406009" & s1aq1==102
recode s1aq6a (24=3) if hid =="3040130406009" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "3040130406009"
replace s1aq4b = 6 if s1aq4b == 3  & s1aq1 == 102 & hid == "3040130406009"
replace s1aq6b = 6 if s1aq6b == 3  & s1aq1 == 102 & hid == "3040130406009"


///5211652115014
br hid-s1aq8b tot_consumed if hid =="5211652115014"  & s1aq1==102
recode s1aq3a (6=1) if hid =="5211652115014" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "5211652115014"


//2120121223011
br hid-s1aq8b tot_consumed if hid =="2120121223011"  & s1aq1==102
recode s1aq7a (.=15) if hid =="2120121223011" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "2120121223011"
replace s1aq7b = 6 if s1aq7b == .  & s1aq1 == 102 & hid == "2120121223011"


///2010120117003
br hid-s1aq8b tot_consumed if hid =="2010120117003"  & s1aq1==102
recode s1aq7a (.=10) if hid =="2010120117003" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "2010120117003"
replace s1aq7b = 6 if s1aq7b == .  & s1aq1 == 102 & hid == "2010120117003"


///2010120117008
br hid-s1aq8b tot_consumed if hid =="2010120117008"  & s1aq1==102
recode s1aq7a (.=8) if hid =="2010120117008" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "2010120117008"
replace s1aq7b = 6 if s1aq7b == .  & s1aq1 == 102 & hid == "2010120117008"


////5420554201007
br hid-s1aq8b tot_consumed if hid =="5420554201007"  & s1aq1==102
recode s1aq3a (16=4) if hid =="5420554201007" & s1aq1==102
recode s1aq4a (32=4) if hid =="5420554201007" & s1aq1==102
recode s1aq6a (32=4) if hid =="5420554201007" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "5420554201007"


///2230122330016
br hid-s1aq8b tot_consumed if hid =="2230122330016"  & s1aq1==102
recode s1aq7a (.=10) if hid =="2230122330016" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "2230122330016"
replace s1aq7b = 6 if s1aq7b == .  & s1aq1 == 102 & hid == "2230122330016"


///5610956110001
br hid-s1aq8b tot_consumed if hid =="5610956110001"  & s1aq1==102
recode s1aq4a (8=3) if hid =="5610956110001" & s1aq1==102
recode s1aq6a (8=3) if hid =="5610956110001" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "5610956110001"


////3060530617009
br hid-s1aq8b tot_consumed if hid =="3060530617009"  & s1aq1==102
recode s1aq4a (76=7) if hid =="3060530617009" & s1aq1==102
recode s1aq6a (76=7) if hid =="3060530617009" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "3060530617009"


///2230122330002
br hid-s1aq8b tot_consumed if hid =="2230122330002"  & s1aq1==102
recode s1aq7a (.=8) if hid =="2230122330002" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "2230122330002"
replace s1aq7b = 6 if s1aq7b == .  & s1aq1 == 102 & hid == "2230122330002"


///1110111102008
br hid-s1aq8b tot_consumed if hid =="1110111102008"  & s1aq1==102
recode s1aq7a (.=10) if hid =="1110111102008" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "1110111102008"
replace s1aq7b = 6 if s1aq7b == .  & s1aq1 == 102 & hid == "1110111102008"


///3050230524009
br hid-s1aq8b tot_consumed if hid =="3050230524009"  & s1aq1==102
recode s1aq4a (120=6) if hid =="3050230524009" & s1aq1==102
recode s1aq6a (.=6) if hid =="3050230524009" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "3050230524009"
replace s1aq6b = 6 if s1aq6b == .  & s1aq1 == 102 & hid == "3050230524009"


///1020110201007
br hid-s1aq8b tot_consumed if hid =="1020110201007"  & s1aq1==102
recode s1aq7a (.=24) if hid =="1020110201007" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "1020110201007"
replace s1aq7b = 6 if s1aq7b == .  & s1aq1 == 102 & hid == "1020110201007"


///3133631305012// verify price
br hid-s1aq8b tot_consumed if hid =="3133631305012"  & s1aq1==102
recode s1aq6a (2=6) if hid =="3133631305012" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "3133631305012"


///5013050117006
br hid-s1aq8b tot_consumed if hid =="5013050117006"  & s1aq1==102
recode s1aq8a (.=20) if hid =="5013050117006" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "5013050117006"
replace s1aq8b = 6 if s1aq8b == .  & s1aq1 == 102 & hid == "5013050117006"


///1020110201005
br hid-s1aq8b tot_consumed if hid =="1020110201005"  & s1aq1==102
recode s1aq8a (.=12) if hid =="1020110201005" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "1020110201005"
replace s1aq8b = 6 if s1aq8b == .  & s1aq1 == 102 & hid == "1020110201005"


///1010110103016
br hid-s1aq8b tot_consumed if hid =="1010110103016"  & s1aq1==102
recode s1aq8a (.=12) if hid =="1010110103016" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "1010110103016"
replace s1aq8b = 6 if s1aq8b == .  & s1aq1 == 102 & hid == "1010110103016"


///3421234203006
br hid-s1aq8b tot_consumed if hid =="3421234203006"  & s1aq1==102
recode s1aq6a (.=10) if hid =="3421234203006" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "3421234203006"
replace s1aq6b = 6 if s1aq6b == .  & s1aq1 == 102 & hid == "3421234203006"


///6111261113014
br hid-s1aq8b tot_consumed if hid =="6111261113014"  & s1aq1==102
recode s1aq8a (2=.) if hid =="6111261113014" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "6111261113014"
replace s1aq8b = . if s1aq8b == 2  & s1aq1 == 102 & hid == "6111261113014"


///3022130267005// verify price
br hid-s1aq8b tot_consumed if hid =="3022130267005"  & s1aq1==102
recode s1aq3a (1=10) if hid =="3022130267005" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "3022130267005"


///1010110103010
br hid-s1aq8b tot_consumed if hid =="1010110103010"  & s1aq1==102
recode s1aq3a (1=18) if hid =="1010110103010" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "1010110103010"


///3030530383014
br hid-s1aq8b tot_consumed if hid =="3030530383014"  & s1aq1==102
recode s1aq4a (1=12) if hid =="3030530383014" & s1aq1==102
recode s1aq6a (1=12) if hid =="3030530383014" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "3030530383014"
replace s1aq4b = 6 if s1aq4b == 99  & s1aq1 == 102 & hid == "3030530383014"
replace s1aq6b = 6 if s1aq6b == 99  & s1aq1 == 102 & hid == "3030530383014"


///1020110205007
br hid-s1aq8b tot_consumed if hid =="1020110205007"  & s1aq1==102
recode s1aq7a (.=12) if hid =="1020110205007" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "1020110205007"
replace s1aq7b = 6 if s1aq7b == .  & s1aq1 == 102 & hid == "1020110205007"


///3522535218009
br hid-s1aq8b tot_consumed if hid =="3522535218009"  & s1aq1==102
recode s1aq3a (12=16) if hid =="3522535218009" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "3522535218009"


///3240932442001
br hid-s1aq8b tot_consumed if hid =="3240932442001"  & s1aq1==102
recode s1aq3a (6=5) if hid =="3240932442001" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "3240932442001"


///2130121308004
br hid-s1aq8b tot_consumed if hid =="2130121308004"  & s1aq1==102
recode s1aq8a (.=8) if hid =="2130121308004" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "2130121308004"
replace s1aq8b = 6 if s1aq8b == .  & s1aq1 == 102 & hid == "2130121308004"


///5530155356005
br hid-s1aq8b tot_consumed if hid =="5530155356005"  & s1aq1==102
recode s1aq7a (.=4) if hid =="5530155356005" & s1aq1==102
replace s1aq3b = 99 if s1aq3b == 0  & s1aq1 == 102 & hid == "5530155356005"
replace s1aq7b =99 if s1aq7b == .  & s1aq1 == 102 & hid == "5530155356005"


///3210432144004
br hid-s1aq8b tot_consumed if hid =="3210432144004"  & s1aq1==102
recode s1aq7a (4=.) if hid =="3210432144004" & s1aq1==102
recode s1aq5 (2=.) if hid =="3210432144004" & s1aq1==102
recode s1aq6a (26=2) if hid =="3210432144004" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "3210432144004"
replace s1aq6b = 6 if s1aq6b == 0  & s1aq1 == 102 & hid == "3210432144004"


///1210112104002
br hid-s1aq8b tot_consumed if hid =="1210112104002"  & s1aq1==102
recode s1aq7a (.=12) if hid =="1210112104002" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "1210112104002"
replace s1aq7b = 6 if s1aq7b == .  & s1aq1 == 102 & hid == "1210112104002"


///3030330362009
br hid-s1aq8b tot_consumed if hid =="3030330362009"  & s1aq1==102
recode s1aq7a (.=8) if hid =="3030330362009" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "3030330362009"
replace s1aq7b = 6 if s1aq7b == .  & s1aq1 == 102 & hid == "3030330362009"


////5420754218012
br hid-s1aq8b tot_consumed if hid =="5420754218012"  & s1aq1==102
recode s1aq6a (4=5) if hid =="5420754218012" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "5420754218012"


///1110111106007
br hid-s1aq8b tot_consumed if hid =="1110111106007"  & s1aq1==102
recode s1aq8a (.=8) if hid =="1110111106007" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "1110111106007"
replace s1aq8b = 6 if s1aq8b == .  & s1aq1 == 102 & hid == "1110111106007"


///3020630210013
br hid-s1aq8b tot_consumed if hid =="3020630210013"  & s1aq1==102
recode s1aq8a (.=4) if hid =="3020630210013" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "3020630210013"
replace s1aq8b = 6 if s1aq8b == .  & s1aq1 == 102 & hid == "3020630210013"


///2230122310009
br hid-s1aq8b tot_consumed if hid =="2230122310009"  & s1aq1==102
recode s1aq8a (.=12) if hid =="2230122310009" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "2230122310009"
replace s1aq8b = 6 if s1aq8b == .  & s1aq1 == 102 & hid == "2230122310009"


///3022130267004
br hid-s1aq8b tot_consumed if hid =="3022130267004"  & s1aq1==102
recode s1aq3a (6=3) if hid =="3022130267004" & s1aq1==102
recode s1aq4a (6=3) if hid =="3022130267004" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "3022130267004"


///4311043137005
br hid-s1aq8b tot_consumed if hid =="4311043137005"  & s1aq1==102
recode s1aq3a (26=6) if hid =="4311043137005" & s1aq1==102
recode s1aq4a (32=6) if hid =="4311043137005" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "4311043137005"



///8110281136009
br hid-s1aq8b tot_consumed if hid =="8110281136009"  & s1aq1==102
recode s1aq6a (.=4) if hid =="8110281136009" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "8110281136009"
replace s1aq6b = 6 if s1aq6b == .  & s1aq1 == 102 & hid == "8110281136009"


///1120111210003// verify price
br hid-s1aq8b tot_consumed if hid =="1120111210003"  & s1aq1==102
recode s1aq4a (24=10) if hid =="1120111210003" & s1aq1==102
recode s1aq8a (2=.) if hid =="1120111210003" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "1120111210003"
replace s1aq8b = . if s1aq8b == 2  & s1aq1 == 102 & hid == "1120111210003"


///2440124414009
br hid-s1aq8b tot_consumed if hid =="2440124414009"  & s1aq1==102
recode s1aq7a (.=21) if hid =="2440124414009" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "2440124414009"
replace s1aq7b = 6 if s1aq7b == .  & s1aq1 == 102 & hid == "2440124414009"


///5013050117010
br hid-s1aq8b tot_consumed if hid =="5013050117010"  & s1aq1==102
recode s1aq4a (1=5) if hid =="5013050117010" & s1aq1==102
recode s1aq5 (160=40) if hid =="5013050117010" & s1aq1==102
recode s1aq6a (1=5) if hid =="5013050117010" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "5013050117010"
replace s1aq4b = 6 if s1aq4b == 99  & s1aq1 == 102 & hid == "5013050117010"
replace s1aq6b = 6 if s1aq6b == 99  & s1aq1 == 102 & hid == "5013050117010"


///5211052111015
br hid-s1aq8b tot_consumed if hid =="5211052111015"  & s1aq1==102
recode s1aq7a (.=6) if hid =="5211052111015" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "5211052111015"
replace s1aq7b = 6 if s1aq7b == .  & s1aq1 == 102 & hid == "5211052111015"


///1220112208007
br hid-s1aq8b tot_consumed if hid =="1220112208007"  & s1aq1==102
recode s1aq3a (12=1) if hid =="1220112208007" & s1aq1==102
recode s1aq5 (200=8) if hid =="1220112208007" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "1220112208007"
replace s1aq4b = 6 if s1aq4b == 99  & s1aq1 == 102 & hid == "1220112208007"
replace s1aq6b = 6 if s1aq6b == 99  & s1aq1 == 102 & hid == "1220112208007"


///1030110302014
br hid-s1aq8b tot_consumed if hid =="1030110302014"  & s1aq1==102
recode s1aq7a (.=8) if hid =="1030110302014" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "1030110302014"
replace s1aq7b = 6 if s1aq7b == .  & s1aq1 == 102 & hid == "1030110302014"


///8620686221015
br hid-s1aq8b tot_consumed if hid =="8620686221015"  & s1aq1==102
recode s1aq4a (444=4) if hid =="8620686221015" & s1aq1==102
recode s1aq6a (444=4) if hid =="8620686221015" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "8620686221015"


///3240832455015
br hid-s1aq8b tot_consumed if hid =="3240832455015"  & s1aq1==102
recode s1aq4a (86=8) if hid =="3240832455015" & s1aq1==102
recode s1aq6a (86=8) if hid =="3240832455015" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "3240832455015"


///5420754218010
br hid-s1aq8b tot_consumed if hid =="5420754218010"  & s1aq1==102
recode s1aq3a (1=10) if hid =="5420754218010" & s1aq1==102
recode s1aq6a (6=10) if hid =="5420754218010" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "5420754218010"


///5530155315004
br hid-s1aq8b tot_consumed if hid =="5530155315004"  & s1aq1==102
recode s1aq6a (6=3) if hid =="5530155315004" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "5530155315004"
replace s1aq6b = 6 if s1aq6b == 8  & s1aq1 == 102 & hid == "5530155315004"


///2130121308003
br hid-s1aq8b tot_consumed if hid =="2130121308003"  & s1aq1==102
recode s1aq7a (.=7) if hid =="2130121308003" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "2130121308003"
replace s1aq7b = 6 if s1aq7b == .  & s1aq1 == 102 & hid == "2130121308003"


///2320123275006
br hid-s1aq8b tot_consumed if hid =="2320123275006"  & s1aq1==102
recode s1aq7a (.=5) if hid =="2320123275006" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "2320123275006"
replace s1aq7b = 6 if s1aq7b == .  & s1aq1 == 102 & hid == "2320123275006"


///8411084111002
br hid-s1aq8b tot_consumed if hid =="8411084111002"  & s1aq1==102
recode s1aq3a (1=20) if hid =="8411084111002" & s1aq1==102
recode s1aq4a (1=20) if hid =="8411084111002" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "8411084111002"
replace s1aq4b = 6 if s1aq4b == 99  & s1aq1 == 102 & hid == "8411084111002"


///2420224209014
br hid-s1aq8b tot_consumed if hid =="2420224209014"  & s1aq1==102
recode s1aq7a (.=8) if hid =="2420224209014" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "2420224209014"
replace s1aq7b = 6 if s1aq7b == .  & s1aq1 == 102 & hid == "2420224209014"


///1020110208012
br hid-s1aq8b tot_consumed if hid =="1020110208012"  & s1aq1==102
recode s1aq8a (.=12) if hid =="1020110208012" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "1020110208012"
replace s1aq8b = 6 if s1aq8b == .  & s1aq1 == 102 & hid == "1020110208012"


///2210122167011
br hid-s1aq8b tot_consumed if hid =="2210122167011"  & s1aq1==102
recode s1aq8a (.=14) if hid =="2210122167011" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "2210122167011"
replace s1aq8b = 6 if s1aq8b == .  & s1aq1 == 102 & hid == "2210122167011"


///5420554201006
br hid-s1aq8b tot_consumed if hid =="5420554201006"  & s1aq1==102
recode s1aq4a (8=2) if hid =="5420554201006" & s1aq1==102
recode s1aq6a (8=2) if hid =="5420554201006" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "5420554201006"


///3010430146010
br hid-s1aq8b tot_consumed if hid =="3010430146010"  & s1aq1==102
recode s1aq7a (.=3) if hid =="3010430146010" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "3010430146010"
replace s1aq7b = 6 if s1aq7b == .  & s1aq1 == 102 & hid == "3010430146010"


///3040130406001
br hid-s1aq8b tot_consumed if hid =="3040130406001"  & s1aq1==102
recode s1aq6a (1=2) if hid =="3040130406001" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "3040130406001"


///3240232403008
br hid-s1aq8b tot_consumed if hid =="3240232403008"  & s1aq1==102
recode s1aq8a (9=.) if hid =="3240232403008" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "3240232403008"
replace s1aq8b = . if s1aq8b == 0  & s1aq1 == 102 & hid == "3240232403008"


///1120111202016
br hid-s1aq8b tot_consumed if hid =="1120111202016"  & s1aq1==102
recode s1aq8a (1=8) if hid =="1120111202016" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "1120111202016"
replace s1aq8b = 6 if s1aq8b == 0  & s1aq1 == 102 & hid == "1120111202016"


///2420224209016
br hid-s1aq8b tot_consumed if hid =="2420224209016"  & s1aq1==102
recode s1aq8a (.=6) if hid =="2420224209016" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "2420224209016"
replace s1aq8b = 6 if s1aq8b == .  & s1aq1 == 102 & hid == "2420224209016"


///1010110103008
br hid-s1aq8b tot_consumed if hid =="1010110103008"  & s1aq1==102
recode s1aq8a (.=8) if hid =="1010110103008" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "1010110103008"
replace s1aq8b = 6 if s1aq8b == .  & s1aq1 == 102 & hid == "1010110103008"


///3721737202011
br hid-s1aq8b tot_consumed if hid =="3721737202011"  & s1aq1==102
recode s1aq7a (1=.) if hid =="3721737202011" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "3721737202011"
replace s1aq7b = . if s1aq7b == 6  & s1aq1 == 102 & hid == "3721737202011"


///3030130341002
br hid-s1aq8b tot_consumed if hid =="3030130341002"  & s1aq1==102
recode s1aq7a (.=6) if hid =="3030130341002" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "3030130341002"
replace s1aq7b = 6 if s1aq7b == .  & s1aq1 == 102 & hid == "3030130341002"


////8010880106006
br hid-s1aq8b tot_consumed if hid =="8010880106006"  & s1aq1==102
recode s1aq3a (2=4) if hid =="8010880106006" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "8010880106006"


///2320123203010
br hid-s1aq8b tot_consumed if hid =="2320123203010"  & s1aq1==102
recode s1aq7a (.=5) if hid =="2320123203010" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "2320123203010"
replace s1aq7b = 6 if s1aq7b == .  & s1aq1 == 102 & hid == "2320123203010"


///2230122310016
br hid-s1aq8b tot_consumed if hid =="2230122310016"  & s1aq1==102
recode s1aq7a (.=6) if hid =="2230122310016" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "2230122310016"
replace s1aq7b = 6 if s1aq7b == .  & s1aq1 == 102 & hid == "2230122310016"


///7210372119016
br hid-s1aq8b tot_consumed if hid =="7210372119016"  & s1aq1==102
recode s1aq4a (6=2) if hid =="7210372119016" & s1aq1==102
recode s1aq6a (6=2) if hid =="7210372119016" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "7210372119016"


///3222432230001
br hid-s1aq8b tot_consumed if hid =="3222432230001"  & s1aq1==102
recode s1aq3a (8=6) if hid =="3222432230001" & s1aq1==102
recode s1aq4a (8=6) if hid =="3222432230001" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "3222432230001"


////1110111109011
br hid-s1aq8b tot_consumed if hid =="1110111109011"  & s1aq1==102
recode s1aq3a (1=15) if hid =="1110111109011" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "1110111109011"


///8410784114011
br hid-s1aq8b tot_consumed if hid =="8410784114011"  & s1aq1==102
recode s1aq3a (6=21) if hid =="8410784114011" & s1aq1==102
recode s1aq4a (.=21) if hid =="8410784114011" & s1aq1==102
recode s1aq6a (.=21) if hid =="8410784114011" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "8410784114011"
replace s1aq4b = 6 if s1aq4b == .  & s1aq1 == 102 & hid == "8410784114011"
replace s1aq6b = 6 if s1aq6b == .  & s1aq1 == 102 & hid == "8410784114011"


////3030530383013
br hid-s1aq8b tot_consumed if hid =="3030530383013"  & s1aq1==102
recode s1aq4a (1=20) if hid =="3030530383013" & s1aq1==102
recode s1aq6a (1=20) if hid =="3030530383013" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "3030530383013"
replace s1aq4b = 6 if s1aq4b == 99  & s1aq1 == 102 & hid == "3030530383013"
replace s1aq6b = 6 if s1aq6b == 99  & s1aq1 == 102 & hid == "3030530383013"


///4011440105006
br hid-s1aq8b tot_consumed if hid =="4011440105006"  & s1aq1==102
recode s1aq4a (1=20) if hid =="4011440105006" & s1aq1==102
recode s1aq6a (1=20) if hid =="4011440105006" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "4011440105006"
replace s1aq4b = 6 if s1aq4b == 99  & s1aq1 == 102 & hid == "4011440105006"
replace s1aq6b = 6 if s1aq6b == 99  & s1aq1 == 102 & hid == "4011440105006"


///5420554201009
br hid-s1aq8b tot_consumed if hid =="5420554201009"  & s1aq1==102
recode s1aq3a (35=5) if hid =="5420554201009" & s1aq1==102
recode s1aq4a (75=5) if hid =="5420554201009" & s1aq1==102
recode s1aq6a (75=5) if hid =="5420554201009" & s1aq1==102
recode s1aq5 (75=40) if hid =="5420554201009" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "5420554201009"


///3030530383016
br hid-s1aq8b tot_consumed if hid =="3030530383016"  & s1aq1==102
recode s1aq4a (1=12) if hid =="3030530383016" & s1aq1==102
recode s1aq6a (1=12) if hid =="3030530383016" & s1aq1==102
recode s1aq5 (150=96) if hid =="3030530383016" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "3030530383016"
replace s1aq4b = 6 if s1aq4b == 99  & s1aq1 == 102 & hid == "3030530383016"
replace s1aq6b = 6 if s1aq6b == 99  & s1aq1 == 102 & hid == "3030530383016"


///4021040223012
br hid-s1aq8b tot_consumed if hid =="4021040223012"  & s1aq1==102
recode s1aq3a (1=2) if hid =="4021040223012" & s1aq1==102
recode s1aq4a (1=2) if hid =="4021040223012" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "4021040223012"
replace s1aq6b = 6 if s1aq6b == 12  & s1aq1 == 102 & hid == "4021040223012"


///3222432230007
br hid-s1aq8b tot_consumed if hid =="3222432230007"  & s1aq1==102
recode s1aq3a (6=12) if hid =="3222432230007" & s1aq1==102
recode s1aq4a (6=12) if hid =="3222432230007" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "3222432230007"
replace s1aq4b = 6 if s1aq4b == 12  & s1aq1 == 102 & hid == "3222432230007"


///2020120213011
br hid-s1aq8b tot_consumed if hid =="2020120213011"  & s1aq1==102
recode s1aq6a (6=2) if hid =="2020120213011" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "2020120213011"
replace s1aq6b = 6 if s1aq6b == 2  & s1aq1 == 102 & hid == "2020120213011"


///5310253111010
br hid-s1aq8b tot_consumed if hid =="5310253111010"  & s1aq1==102
recode s1aq6a (8=9) if hid =="5310253111010" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "5310253111010"


///4311443145015
br hid-s1aq8b tot_consumed if hid =="4311443145015"  & s1aq1==102
recode s1aq5 (1=8) if hid =="4311443145015" & s1aq1==102
recode s1aq6a (6=1) if hid =="4311443145015" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "4311443145015"
replace s1aq4b = 6 if s1aq4b == 99  & s1aq1 == 102 & hid == "4311443145015"
replace s1aq6b = 6 if s1aq6b == 0  & s1aq1 == 102 & hid == "4311443145015"


///3230232347011
br hid-s1aq8b tot_consumed if hid =="3230232347011"  & s1aq1==102
recode s1aq6a (6=7) if hid =="3230232347011" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "3230232347011"


///3050230544004
br hid-s1aq8b tot_consumed if hid =="3050230544004"  & s1aq1==102
recode s1aq4a (6=5) if hid =="3050230544004" & s1aq1==102
recode s1aq6a (6=5) if hid =="3050230544004" & s1aq1==102
recode s1aq5 (36=35) if hid =="3050230544004" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "3050230544004"


///8111181109008
br hid-s1aq8b tot_consumed if hid =="8111181109008"  & s1aq1==102
recode s1aq4a (13=12) if hid =="8111181109008" & s1aq1==102
recode s1aq6a (13=12) if hid =="8111181109008" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "8111181109008"


///2130121308011
br hid-s1aq8b tot_consumed if hid =="2130121308011"  & s1aq1==102
recode s1aq3a (10=1) if hid =="2130121308011" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "2130121308011"
replace s1aq4b = 6 if s1aq4b == 99  & s1aq1 == 102 & hid == "2130121308011"
replace s1aq6b = 6 if s1aq6b == 99  & s1aq1 == 102 & hid == "2130121308011"


///3330133313006
br hid-s1aq8b tot_consumed if hid =="3330133313006"  & s1aq1==102
recode s1aq4a (6=3) if hid =="3330133313006" & s1aq1==102
recode s1aq6a (6=3) if hid =="3330133313006" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "3330133313006"


///4120341210007
br hid-s1aq8b tot_consumed if hid =="4120341210007"  & s1aq1==102
recode s1aq6a (5=.) if hid =="4120341210007" & s1aq1==102
recode s1aq7a (.=1) if hid =="4120341210007" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "4120341210007"
replace s1aq6b = . if s1aq6b == 6  & s1aq1 == 102 & hid == "4120341210007"
replace s1aq7b = 6 if s1aq7b == .  & s1aq1 == 102 & hid == "4120341210007"


///3320633224012
br hid-s1aq8b tot_consumed if hid =="3320633224012"  & s1aq1==102
recode s1aq8a (21=.) if hid =="3320633224012" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "3320633224012"
replace s1aq8b = . if s1aq8b == 6  & s1aq1 == 102 & hid == "3320633224012"


///3142031442010
br hid-s1aq8b tot_consumed if hid =="3142031442010"  & s1aq1==102
recode s1aq8a (.=1) if hid =="3142031442010" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "3142031442010"
replace s1aq8b = 6 if s1aq8b == .  & s1aq1 == 102 & hid == "3142031442010"


///3310333128010
br hid-s1aq8b tot_consumed if hid =="3310333128010"  & s1aq1==102
recode s1aq4a (6=2) if hid =="3310333128010" & s1aq1==102
recode s1aq6a (6=2) if hid =="3310333128010" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "3310333128010"


////1220112208005
br hid-s1aq8b tot_consumed if hid =="1220112208005"  & s1aq1==102
recode s1aq7a (.=3) if hid =="1220112208005" & s1aq1==102
recode s1aq5 (20=10) if hid =="1220112208005" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "1220112208005"
replace s1aq7b = 6 if s1aq7b == .  & s1aq1 == 102 & hid == "1220112208005"


///3721737202003
br hid-s1aq8b tot_consumed if hid =="3721737202003"  & s1aq1==102
recode s1aq3a (7=6) if hid =="3721737202003" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "3721737202003"


///1010110106003
br hid-s1aq8b tot_consumed if hid =="1010110106003"  & s1aq1==102
recode s1aq3a (6=10) if hid =="1010110106003" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "1010110106003"


///5320953203007
br hid-s1aq8b tot_consumed if hid =="5320953203007"  & s1aq1==102
recode s1aq3a (3=2) if hid =="5320953203007" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "5320953203007"


///3241332469011
br hid-s1aq8b tot_consumed if hid =="3241332469011"  & s1aq1==102
recode s1aq4a (66=6) if hid =="3241332469011" & s1aq1==102
recode s1aq6a (66=6) if hid =="3241332469011" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "3241332469011"


///5310253111011
br hid-s1aq8b tot_consumed if hid =="5310253111011"  & s1aq1==102
recode s1aq3a (1=4) if hid =="5310253111011" & s1aq1==102
recode s1aq4a (32=4) if hid =="5310253111011" & s1aq1==102
recode s1aq5 (6=32) if hid =="5310253111011" & s1aq1==102
recode s1aq6a (32=4) if hid =="5310253111011" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "5310253111011"
replace s1aq4b = 6 if s1aq4b == 4  & s1aq1 == 102 & hid == "5310253111011"
replace s1aq4b = 6 if s1aq4b == 4  & s1aq1 == 102 & hid == "5310253111011"


////6430764305006
br hid-s1aq8b tot_consumed if hid =="6430764305006"  & s1aq1==102
recode s1aq4a (3=6) if hid =="6430764305006" & s1aq1==102
recode s1aq6a (3=6) if hid =="6430764305006" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "6430764305006"



////5310253102014
br hid-s1aq8b tot_consumed if hid =="5310253102014"  & s1aq1==102
recode s1aq3a (21=2) if hid =="5310253102014" & s1aq1==102
recode s1aq4a (.=2) if hid =="5310253102014" & s1aq1==102
recode s1aq6a (.=2) if hid =="5310253102014" & s1aq1==102
recode s1aq5 (160=16) if hid =="5310253102014" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "5310253102014"
replace s1aq4b = 6 if s1aq4b == .  & s1aq1 == 102 & hid == "5310253102014"
replace s1aq6b = 6 if s1aq6b == .  & s1aq1 == 102 & hid == "5310253102014"


///5310253102011
br hid-s1aq8b tot_consumed if hid =="5310253102011"  & s1aq1==102
recode s1aq3a (21=2) if hid =="5310253102011" & s1aq1==102
recode s1aq4a (.=2) if hid =="5310253102011" & s1aq1==102
recode s1aq6a (.=2) if hid =="5310253102011" & s1aq1==102
recode s1aq5 (160=16) if hid =="5310253102011" & s1aq1==102
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 102 & hid == "5310253102011"
replace s1aq4b = 6 if s1aq4b == .  & s1aq1 == 102 & hid == "5310253102011"
replace s1aq6b = 6 if s1aq6b == .  & s1aq1 == 102 & hid == "5310253102011"



//*****Fixing a general issue for 102- Eggs - industrial****
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 102 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if s1aq1  == 102 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq3b = 6 if s1aq3b == 0 & issue == 1
replace s1aq4a = s1aq3a if issue == 1
replace s1aq4b = s1aq3b if issue == 1

replace s1aq7a = s1aq3a if issue == 1
replace s1aq7b = s1aq3b if issue == 1

drop issue 


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 102 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a!=. & s1aq7a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 2 if s1aq1  == 102 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq7a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = . if s1aq7a!=. & issue ==2
replace s1aq3b = 6 if s1aq3b == 0 & issue ==2
replace s1aq7b = . if s1aq7b == 0 & issue ==2
replace s1aq7b = . if s1aq7b == 6 & issue ==2


drop issue


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 102 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.


gen issue = 3 if s1aq1  == 102 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq3a = s1aq6a if hid == "3310733120009" & issue == 3
replace s1aq3a = s1aq6a if hid == "8020580247002" & issue == 3
replace s1aq3a = s1aq6a if hid == "8110281136006" & issue == 3
replace s1aq3a = s1aq6a if hid == "3311633110009" & issue == 3


drop issue



************** 148 cassava leave ******
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 148 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 35 if  s1aq1  == 148 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq6a = . if s1aq6a == 3 & issue == 35
replace s1aq6a = . if s1aq6a == 5 & issue == 35
replace s1aq6a = . if s1aq6a == 2 & issue == 35
replace s1aq6a = . if s1aq6a == 8 & issue == 35
replace s1aq6a = . if s1aq6a == 4 & issue == 35
replace s1aq6a = . if s1aq6a == 6 & issue == 35
replace s1aq6a = . if s1aq6a == 10 & issue == 35
replace s1aq6a = . if s1aq6a == 12 & issue == 35

replace s1aq7a = s1aq3a if s1aq7a == 1 & issue == 35
replace s1aq7a = s1aq3a if s1aq7a == . & issue == 35
replace s1aq7a = s1aq3a if s1aq7a == 5 & issue == 35

replace s1aq8a = . if s1aq8a == 1 & issue == 35

replace s1aq3b = 11 if s1aq3b == 0 & issue == 35
replace s1aq6b = . if s1aq6b == 6 & issue == 35
replace s1aq7b = 11 if s1aq7b == 6 & issue == 35
replace s1aq7b = 11 if s1aq7b == . & issue == 35
replace s1aq8b = . if s1aq8b == 6 & issue == 35

drop issue 



br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 148 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 36 if s1aq1  == 148 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = . if s1aq7a == 1 & issue == 36
replace s1aq8a = . if s1aq8a == 1 & issue == 36

replace s1aq7b = . if s1aq7b == 6 & issue == 36
replace s1aq7b = . if s1aq7b == 11 & issue == 36
replace s1aq8b = . if s1aq8b == 6 & issue == 36
replace s1aq8b = . if s1aq8b == 11 & issue == 36

drop issue 


///3721737202016
br hid-s1aq8b tot_consumed if hid =="3721737202016"  & s1aq1==148
recode s1aq5 (7=35) if hid =="3721737202016" & s1aq1==148
recode s1aq6a (21=7) if hid =="3721737202016" & s1aq1==148
replace s1aq3b = 11 if s1aq3b == 0  & s1aq1 == 148 & hid == "3721737202016"
replace s1aq6b = 11 if s1aq6b == 7  & s1aq1 == 148 & hid == "3721737202016"


///3520735220016
br hid-s1aq8b tot_consumed if hid =="3520735220016"  & s1aq1==148
recode s1aq5 (5=25) if hid =="3520735220016" & s1aq1==148
recode s1aq6a (.=5) if hid =="3520735220016" & s1aq1==148
replace s1aq3b = 11 if s1aq3b == 0  & s1aq1 == 148 & hid == "3520735220016"
replace s1aq6b = 11 if s1aq6b == .  & s1aq1 == 148 & hid == "3520735220016"


///3810438110012
br hid-s1aq8b tot_consumed if hid =="3810438110012"  & s1aq1==148
recode s1aq7a (2=.) if hid =="3810438110012" & s1aq1==148
recode s1aq8a (2=.) if hid =="3810438110012" & s1aq1==148
replace s1aq3b = 11 if s1aq3b == 0  & s1aq1 == 148 & hid == "3810438110012"
replace s1aq7b = . if s1aq7b == 2  & s1aq1 == 148 & hid == "3810438110012"
replace s1aq8b = . if s1aq8b == 2  & s1aq1 == 148 & hid == "3810438110012"
replace s1aq6b = 11 if s1aq6b == 6  & s1aq1 == 148 & hid == "3810438110012"
replace s1aq4b = 11 if s1aq4b == 6  & s1aq1 == 148 & hid == "3810438110012"


///4210242106008
br hid-s1aq8b tot_consumed if hid =="4210242106008"  & s1aq1==148
recode s1aq4a (0=.) if hid =="4210242106008" & s1aq1==148
recode s1aq7a (1=2) if hid =="4210242106008" & s1aq1==148
replace s1aq3b = 11 if s1aq3b == 0  & s1aq1 == 148 & hid == "4210242106008"
replace s1aq4b = . if s1aq4b == 6  & s1aq1 == 148 & hid == "4210242106008"
replace s1aq7b = 11 if s1aq7b == 6  & s1aq1 == 148 & hid == "4210242106008"



****************** 149 onion leaves *****************
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 149 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 37 if s1aq1  == 149 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = . if s1aq7a == 1 & issue == 37
replace s1aq7a = . if s1aq7a == 2 & issue == 37
replace s1aq7a = . if s1aq7a == 3 & issue == 37
replace s1aq7a = . if s1aq7a == 5 & issue == 37
replace s1aq8a = . if s1aq8a == 1 & issue == 37

replace s1aq3a = 10 if s1aq3a == 3 & hid == "3410134112002"& issue == 37
replace s1aq4a = 2 if s1aq4a == 0 & hid == "3421234208007" & issue == 37
replace s1aq6a = 2 if s1aq6a == 11 & hid == "3421234208007" & issue == 37

replace s1aq3b = 11 if s1aq3b == 0 & issue == 37
replace s1aq4b = 11 if s1aq4b == 6 & issue == 37
replace s1aq6b = 11 if s1aq6b == 6 & issue == 37
replace s1aq6b = 11 if s1aq6b == 0 & issue == 37
replace s1aq7b = . if s1aq7b == 6 & issue == 37
replace s1aq7b = . if s1aq7b == 11 & issue == 37
replace s1aq8b = . if s1aq8b == 6 & issue == 37

drop issue 


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 149 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!= s1aq3a & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 38 if s1aq1  == 149 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!= s1aq3a & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq3a = 3 if s1aq3a == 5 & hid == "3522535216004" & issue == 38
replace s1aq6a = 35 if s1aq6a == 45 & hid == "3810138105005" & issue == 38
replace s1aq6a = 6 if s1aq6a == 1 & hid == "4021340214002" & issue == 38
replace s1aq6a = 6 if s1aq6a == 1 & hid == "3810838102015" & issue == 38

replace s1aq5 = 30 if s1aq5 == 2 & issue == 38
replace s1aq5 = 30 if s1aq5 == 3 & issue == 38

replace  s1aq3b = 11 if s1aq3b == 0 & issue == 38
replace  s1aq4b = 11 if s1aq4b == 6 & issue == 38
replace  s1aq4b = 11 if s1aq4b == 1 & issue == 38
replace  s1aq6b = 11 if s1aq6b == 6 & issue == 38

drop issue 



br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 149 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a!=. & s1aq7a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.


gen issue = 44 if s1aq1  == 149 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a!=. & s1aq7a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.


replace s1aq7a = s1aq6a if issue == 44
replace s1aq6a = s1aq8a if issue == 44

replace s1aq3b = 11 if s1aq3b == 0 & issue == 44
replace s1aq7b = 11 if s1aq7b == 6 & issue == 44
replace s1aq6b = . if s1aq6b == 6 & issue == 44
replace s1aq6b = . if s1aq6b == 11 & issue == 44

drop issue



br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 149 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 84 if s1aq1  == 149 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = . if issue == 84
replace s1aq8a = . if issue == 84

replace s1aq7b = . if issue == 84
replace s1aq8b = . if issue == 84

replace  s1aq5 = 20 if  s1aq5 == 8 & issue == 84
replace  s1aq5 = 10 if  s1aq5 == 2 & issue == 84
replace s1aq3b = 11 if issue == 84

drop issue

///3410134112003
br hid-s1aq8b tot_consumed if hid =="3410134112003"  & s1aq1==149
recode s1aq3a (5=10) if hid =="3410134112003" & s1aq1==149



///4210242105011
br hid-s1aq8b tot_consumed if hid =="4210242105011"  & s1aq1==149
recode s1aq7a (411=4) if hid =="4210242105011" & s1aq1==149
recode s1aq3b (0=11) if hid =="4210242105011" & s1aq1==149
recode s1aq7b (0=11) if hid =="4210242105011" & s1aq1==149



///3520735220010
br hid-s1aq8b tot_consumed if hid =="3520735220010"  & s1aq1==149
recode s1aq7a (22=2) if hid =="3520735220010" & s1aq1==149



///4210142109015
br hid-s1aq8b tot_consumed if hid =="4210142109015"  & s1aq1==149
recode s1aq7a (.=7) if hid =="4210142109015" & s1aq1==149
recode s1aq3b (0=11) if hid =="4210142109015" & s1aq1==149
recode s1aq7b (.=11) if hid =="4210142109015" & s1aq1==149
recode s1aq6b (6=11) if hid =="4210142109015" & s1aq1==149



///4210242106008
br hid-s1aq8b tot_consumed if hid =="4210242106008"  & s1aq1==149
recode s1aq7a (1=7) if hid =="4210242106008" & s1aq1==149
recode s1aq6a (0=.) if hid =="4210242106008" & s1aq1==149
recode s1aq6b (6=.) if hid =="4210242106008" & s1aq1==149
recode s1aq3b (0=11) if hid =="4210242106008" & s1aq1==149
recode s1aq7b (6=11) if hid =="4210242106008" & s1aq1==149



************* 152 small pepper fresh **************
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 152 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 39 if s1aq1  == 152 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = . if s1aq7a == 1 & issue ==39
replace s1aq7a = . if s1aq7a == 5 & issue ==39

replace s1aq3b = 11 if s1aq3b == 0 & issue == 39
replace s1aq7b = . if s1aq7b == 11 & issue ==39
replace s1aq7b = . if s1aq7b == 7 & issue ==39

drop issue 


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 152 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 40 if s1aq1  == 152 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = s1aq3a if issue == 40
replace s1aq4a = 7 if s1aq4a == 0 & issue == 40

replace s1aq3b = 11 if s1aq3b == 0 & issue == 40
replace s1aq4b = 11 if s1aq4b == 0 & issue == 40
replace s1aq7b = 11 if s1aq7b == . & issue == 40

drop issue 


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 152 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 45 if s1aq1  == 152 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = . if s1aq7a == 2 & issue == 45
replace s1aq7a = . if s1aq7a == 3 & issue == 45
replace s1aq7a = . if s1aq7a == 8 & issue == 45
replace s1aq7a = . if s1aq7a == 6 & issue == 45
replace s1aq7a = . if s1aq7a == 35 & issue == 45
replace s1aq7a = . if s1aq7a == 70 & issue == 45

replace s1aq8a = . if s1aq8a == 2 & issue == 45
replace s1aq8a = . if s1aq8a == 3 & issue == 45
replace s1aq8a = . if s1aq8a == 8 & issue == 45
replace s1aq8a = . if s1aq8a == 35 & issue == 45

replace s1aq7b = . if s1aq7b == 2 & issue == 45
replace s1aq7b = . if s1aq7b == 0 & issue == 45
replace s1aq7b = . if s1aq7b == 6 & issue == 45
replace s1aq7b = . if s1aq7b == 11 & issue == 45
replace s1aq7b = . if s1aq7b == 7 & issue == 45

replace s1aq8b = . if s1aq8b == 7 & issue == 45
replace s1aq8b = . if s1aq8b == 2 & issue == 45
replace s1aq8b = . if s1aq8b == 6 & issue == 45
replace s1aq8b = . if s1aq8b == 11 & issue == 45

replace s1aq6a = 7 if s1aq6a == 8 & hid == "3410134112006" & issue == 45
replace s1aq3a = 14 if s1aq3a == 35 & hid == "4110941110015" & issue == 45
replace s1aq4a = 14 if s1aq4a == 35 & hid == "4110941110015" & issue == 45
replace s1aq6a = 14 if s1aq6a == 35 & hid == "4110941110015" & issue == 45
replace s1aq3a = 11 if s1aq3a == 7 & hid == "4121441205015" & issue == 45
replace s1aq5 = 55 if s1aq5 == 7 & hid == "4121441205015" & issue == 45
replace s1aq6a = 1 if s1aq6a == 7 & hid == "3710137101011" & issue == 45
replace s1aq3a = 7 if s1aq3a == 1 & hid == "3620736202002" & issue == 45
replace s1aq6a = 70 if s1aq6a == 11 & hid == "4111041113003" & issue == 45
replace s1aq3a = 7 if s1aq3a == 8 & hid == "3512535115012" & issue == 45
replace s1aq5 = 35 if s1aq5 == 36 & hid == "3512535115012" & issue == 45
replace s1aq3a = 7 if s1aq3a == 8 & hid == "3610636104015" & issue == 45
replace s1aq3a = 11 if s1aq3a == 7 & hid == "4210242106001" & issue == 45
replace s1aq5 = 5 if s1aq5 == 14 & hid == "4210242106001" & issue == 45
replace s1aq3a = 7 if s1aq3a == 5 & hid == "4311543116012" & issue == 45
replace s1aq6a = 3 if s1aq6a == 2 & hid == "4410644108014" & issue == 45
replace s1aq6a = 7 if s1aq6a == 8 & hid == "3610536108011" & issue == 45
replace s1aq6a = 7 if s1aq6a == 8 & hid == "3420934214008" & issue == 45
replace s1aq6a = 7 if s1aq6a == 11 & hid == "4210242105004" & issue == 45
replace s1aq5 = 35 if s1aq5 == 7 & hid == "4210242105004" & issue == 45
replace s1aq5 = 35 if s1aq5 == 14 & hid == "3610236101014" & issue == 45
replace s1aq5 = 35 if s1aq5 == 14 & hid == "4010840110003" & issue == 45
replace s1aq6a = 1 if s1aq6a == 7 & hid == "4021240209006" & issue == 45
replace s1aq6a = 7 if s1aq6a == 14 & hid == "4210142109002" & issue == 45
replace s1aq5 = 35 if s1aq5 == 14 & hid == "4210142109002" & issue == 45
replace s1aq6a = 1 if s1aq6a == 3 & hid == "4510145118011" & issue == 45
replace s1aq3a = 4 if s1aq3a == 14 & hid == "3520735220003" & issue == 45
replace s1aq4a = 4 if s1aq4a == 14 & hid == "3520735220003" & issue == 45
replace s1aq6a = 7 if s1aq6a == 5 & hid == "3620736202008" & issue == 45
replace s1aq3a = 4 if s1aq3a == 5 & hid == "3721237203001" & issue == 45
replace s1aq6a = 7 if s1aq6a == 35 & hid == "3721137208007" & issue == 45
replace s1aq4a = 7 if s1aq4a == 35 & hid == "3721137208007" & issue == 45
replace s1aq5 = 35 if s1aq5 == 6 & hid == "3721137208007" & issue == 45

replace s1aq3b = 11 if s1aq3b == 0 & issue == 45
replace s1aq3b = 9 if s1aq3b == 11 & hid == "4021240209006" & issue == 45
replace s1aq3b = 8 if s1aq3b == 11 & hid == "4510145118011" & issue == 45
replace s1aq6b = 9 if s1aq6b == 8 & hid == "4021240209006" & issue == 45
replace s1aq6b = 8 if s1aq6b == 11 & hid == "4510145118011" & issue == 45

drop issue 


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 152 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 46 if s1aq1  == 152 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = s1aq3a if issue == 46
replace s1aq6a = s1aq4a if issue == 46

replace s1aq3b = 11 if s1aq3b == 0 & issue == 46

drop issue


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 152 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a==. & s1aq7a==. & s1aq8a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 85 if s1aq1  == 152 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a==. & s1aq7a==. & s1aq8a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq6a = s1aq3a if issue == 85
replace s1aq3b = 11 if issue == 85
replace s1aq6b = 11 if issue == 85

drop issue 


///4111041113003
br hid-s1aq8b tot_consumed if hid =="4111041113003"  & s1aq1==152
recode s1aq6a (70=7) if hid =="4111041113003" & s1aq1==152
recode s1aq7b (0=11) if hid =="4111041113003" & s1aq1==152


///3820238208010
br hid-s1aq8b tot_consumed if hid =="3820238208010"  & s1aq1==152
recode s1aq7a (.=7) if hid =="3820238208010" & s1aq1==152
recode s1aq7b (.=11) if hid =="3820238208010" & s1aq1==152
recode s1aq3b (0=11) if hid =="3820238208010" & s1aq1==152


///3410134112002
br hid-s1aq8b tot_consumed if hid =="3410134112002"  & s1aq1==152
recode s1aq7a (7=.) if hid =="3410134112002" & s1aq1==152
recode s1aq3a (5=10) if hid =="3410134112002" & s1aq1==152

////3410234119008
br hid-s1aq8b tot_consumed if hid =="3410234119008"  & s1aq1==152
recode s1aq7a (2=4) if hid =="3410234119008" & s1aq1==152
recode s1aq3b (0=11) if hid =="3410234119008" & s1aq1==152



///3620336207004
br hid-s1aq8b tot_consumed if hid =="3620336207004"  & s1aq1==152
recode s1aq6a (8=7) if hid =="3620336207004" & s1aq1==152
recode s1aq3b (0=11) if hid =="3620336207004" & s1aq1==152




***************** 150 potatoe leaves ********
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 150 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 41 if s1aq1  == 150 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = s1aq3a if issue == 41
replace s1aq4a = s1aq3a if issue == 41
replace s1aq8a = . if s1aq8a == 11 & issue == 41

replace s1aq3b = 11 if issue == 41
replace s1aq4b = 11 if s1aq4b == 6 & issue == 41
replace s1aq7b = 11 if s1aq7b == 6 & issue == 41
replace s1aq7b = 11 if s1aq7b == . & issue == 41
replace s1aq8b = . if s1aq8b == 11 & issue == 41

drop issue 


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 150 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 42 if s1aq1  == 150 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = s1aq5 if issue == 42
replace s1aq8a = s1aq5 if issue == 42

replace s1aq7b = s1aq5 if issue == 42
replace s1aq8b = s1aq5 if issue == 42

replace s1aq3b = 11 if s1aq3b == 0 & issue == 42
replace s1aq4b = 11 if s1aq4b == 6 & issue == 42
replace s1aq6b = 11 if s1aq6b == 6 & issue == 42

drop issue


 
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 150 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 43 if s1aq1  == 150 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = s1aq3a if s1aq7a == 1 & issue == 43
replace s1aq7a = s1aq3a if s1aq7a == . & issue == 43
replace s1aq6a = s1aq4a if issue == 43
replace s1aq8a = . if s1aq8a == 1 & issue == 43


replace s1aq3b = 11 if s1aq3b == 0 & issue == 43
replace s1aq7b = 11 if s1aq7b == 6 & issue == 43
replace s1aq7b = 11 if s1aq7b == 12 & issue == 43
replace s1aq7b = 11 if s1aq7b == . & issue == 43
replace s1aq8b = . if s1aq8b == 6 & issue == 43
replace s1aq6b = . if s1aq6b == 6 & issue == 43

drop issue 


///4410244105011
br hid-s1aq8b tot_consumed if hid =="4410244105011"  & s1aq1==150
recode s1aq5 (11=10) if hid =="4410244105011" & s1aq1==150
recode s1aq6a (30=1) if hid =="4410244105011" & s1aq1==150
recode s1aq4a (30=1) if hid =="4410244105011" & s1aq1==150
recode s1aq7a (11=.) if hid =="4410244105011" & s1aq1==150
replace s1aq3b = 11 if s1aq3b == 0  & s1aq1 == 150 & hid == "4410244105011"
replace s1aq4b = 11 if s1aq4b == 3  & s1aq1 == 150 & hid == "4410244105011"
replace s1aq6b = 11 if s1aq6b == 3  & s1aq1 == 150 & hid == "4410244105011"
replace s1aq7b = . if s1aq7b == 0  & s1aq1 == 150 & hid == "4410244105011"


///3510935104015
br hid-s1aq8b tot_consumed if hid =="3510935104015"  & s1aq1==150
recode s1aq8a (5=.) if hid =="3510935104015" & s1aq1==150
replace s1aq3b = 11 if s1aq3b == 0  & s1aq1 == 150 & hid == "3510935104015"
replace s1aq8b = . if s1aq8b == 11  & s1aq1 == 150 & hid == "3510935104015"
replace s1aq7b = 11 if s1aq7b == 5  & s1aq1 == 150 & hid == "3510935104015"


///3510935104007
br hid-s1aq8b tot_consumed if hid =="3510935104007"  & s1aq1==150
recode s1aq3a (10=6) if hid =="3510935104007" & s1aq1==150


///3622436204012
br hid-s1aq8b tot_consumed if hid =="3622436204012"  & s1aq1==150
recode s1aq8a (11=4) if hid =="3622436204012" & s1aq1==150
replace s1aq3b = 11 if s1aq3b == 0  & s1aq1 == 150 & hid == "3622436204012"
replace s1aq8b = 11 if s1aq8b == 0  & s1aq1 == 150 & hid == "3622436204012"


///4120441209001
br hid-s1aq8b tot_consumed if hid =="4120441209001"  & s1aq1==150
recode s1aq3a (11=1) if hid =="4120441209001" & s1aq1==150
replace s1aq3b = 11 if s1aq3b == 0  & s1aq1 == 150 & hid == "4120441209001"

///4410744106008
br hid-s1aq8b tot_consumed if hid =="4410744106008"  & s1aq1==150
recode s1aq7a (11=3) if hid =="4410744106008" & s1aq1==150
replace s1aq3b = 11 if s1aq3b == 0  & s1aq1 == 150 & hid == "4410744106008"
replace s1aq7b = 11 if s1aq7b == 0  & s1aq1 == 150 & hid == "4410744106008"




********************* 153 tomato fresh *********
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 153 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq8a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 47 if  s1aq1  == 153 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq8a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = s1aq8a if issue == 47
replace s1aq3a = s1aq6a if issue == 47

replace s1aq3a = 2 if s1aq3a == 32 & hid == "4210142109015" & issue == 47
replace s1aq6a = 2 if s1aq6a == 32 & hid == "4210142109015" & issue == 47
replace s1aq3a = 1 if s1aq3a == 11 & hid == "3410234119013" & issue == 47
replace s1aq6a = 1 if s1aq6a == 11 & hid == "3410234119013" & issue == 47
replace s1aq3a = 7 if s1aq3a == 11 & hid == "4020540221005" & issue == 47
replace s1aq6a = 7 if s1aq6a == 11 & hid == "4020540221005" & issue == 47
replace s1aq3a = 5 if s1aq3a == 4 & hid == "3810138105012" & issue == 47
replace s1aq6a = 5 if s1aq6a == 4 & hid == "3810138105012" & issue == 47
replace s1aq3a = 7 if s1aq3a == 8 & hid == "3512535115012" & issue == 47
replace s1aq6a = 7 if s1aq6a == 8 & hid == "3512535115012" & issue == 47
replace s1aq3a = 7 if s1aq3a == 11 & hid == "4020540221012" & issue == 47
replace s1aq6a = 7 if s1aq6a == 11 & hid == "4020540221012" & issue == 47
replace s1aq3a = 7 if s1aq3a == 8 & hid == "3421234205013" & issue == 47
replace s1aq6a = 7 if s1aq6a == 8 & hid == "3421234205013" & issue == 47
replace s1aq3a = 7 if s1aq3a == 8 & hid == "3520235213011" & issue == 47
replace s1aq6a = 7 if s1aq6a == 8 & hid == "3520235213011" & issue == 47
replace s1aq3a = 14 if s1aq3a == 7 & hid == "4420644206014" & issue == 47
replace s1aq6a = 14 if s1aq6a == 7 & hid == "4420644206014" & issue == 47
replace s1aq3a = 7 if s1aq3a == 8 & hid == "3510935104002" & issue == 47
replace s1aq6a = 7 if s1aq6a == 8 & hid == "3510935104002" & issue == 47
replace s1aq3a = 7 if s1aq3a == 8 & hid == "3510935104001" & issue == 47
replace s1aq6a = 7 if s1aq6a == 8 & hid == "3510935104001" & issue == 47
replace s1aq3a = 4 if s1aq3a == 12 & hid == "3721837205006" & issue == 47
replace s1aq6a = 4 if s1aq6a == 12 & hid == "3721837205006" & issue == 47


replace s1aq7b = s1aq8b if issue == 47
replace s1aq3b = 11 if s1aq3b == 0 & issue == 47
replace s1aq3b = 7 if s1aq3b == 11 & hid == "4420644206014" & issue == 47 
replace s1aq6b = 11 if s1aq6b == 6 & issue == 47
replace s1aq6b = 11 if s1aq6b == 0 & issue == 47

drop issue


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 153 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a!=. & s1aq7a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 48 if s1aq1  == 153 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a!=. & s1aq7a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = s1aq3a if issue == 48
replace s1aq6a = s1aq4a if issue == 48

replace s1aq6b = s1aq4b if issue == 48
replace s1aq3b = 11 if s1aq3b == 0 & issue == 48

drop issue 


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 153 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 49 if s1aq1  == 153 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq6a = s1aq3a if issue == 49
replace s1aq7a = s1aq8a if issue ==49

replace s1aq3b = 11 if s1aq3b == 0 & issue == 49
replace s1aq6b = 11 if s1aq6b == . & issue == 49

replace s1aq3a = 7 if s1aq3a == 37 & hid == "3810138105010" & issue == 49
replace s1aq4a = 7 if s1aq4a == 37 & hid == "3810138105010" & issue == 49
replace s1aq6a = 7 if s1aq6a == 37 & hid == "3810138105010" & issue == 49

replace s1aq4b = 7 if s1aq4b == 11 & hid == "3810438110006" & issue == 49
replace s1aq3b = 7 if s1aq3b == 11 & hid == "3810438110006" & issue == 49
replace s1aq6b = 7 if s1aq6b == 11 & hid == "3810438110006" & issue == 49
replace s1aq3b = 7 if s1aq3b == 11 & hid == "3520735220016" & issue == 49
replace s1aq6b = 7 if s1aq6b == 11 & hid == "3520735220016" & issue == 49
replace s1aq5 = 60 if s1aq5 == 25 & hid == "4210242105005" & issue == 49

drop issue 




br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 153 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 50 if s1aq1  == 153 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = s1aq8a if issue ==50
replace s1aq7b= s1aq8b if issue ==50

replace s1aq3a = 11 if s1aq3a == 10 & issue == 50
replace s1aq3b = 11 if s1aq3b == 0 & issue ==50

drop issue 


///4210242106008
br hid-s1aq8b tot_consumed if hid =="4210242106008"  & s1aq1==153
recode s1aq7a (1=14) if hid =="4210242106008" & s1aq1==153
recode s1aq6a (0=.) if hid =="4210242106008" & s1aq1==153
recode s1aq6b (6=.) if hid =="4210242106008" & s1aq1==153
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 153 & hid == "4210242106008"


///4021840212002
br hid-s1aq8b tot_consumed if hid =="4021840212002"  & s1aq1==153
recode s1aq8a (.=1) if hid =="4021840212002" & s1aq1==153
recode s1aq3b (0=6) if hid =="4021840212002" & s1aq1==153
recode s1aq8b (.=6) if hid =="4021840212002" & s1aq1==153
recode s1aq4b (0=6) if hid =="4021840212002" & s1aq1==153


///4111341101015
br hid-s1aq8b tot_consumed if hid =="4111341101015"  & s1aq1==153
recode s1aq8a (11=3) if hid =="4111341101015" & s1aq1==153
recode s1aq3b (0=11) if hid =="4111341101015" & s1aq1==153
recode s1aq8b (0=11) if hid =="4111341101015" & s1aq1==153


///3721137208004
br hid-s1aq8b tot_consumed if hid =="3721137208004"  & s1aq1==153
recode s1aq4a (11=4) if hid =="3721137208004" & s1aq1==153
recode s1aq6a (11=4) if hid =="3721137208004" & s1aq1==153
recode s1aq7a (4=.) if hid =="3721137208004" & s1aq1==153
recode s1aq8a (4=.) if hid =="3721137208004" & s1aq1==153
recode s1aq5 (4=40) if hid =="3721137208004" & s1aq1==153
recode s1aq3b (0=11) if hid =="3721137208004" & s1aq1==153
recode s1aq7b (11=.) if hid =="3721137208004" & s1aq1==153
recode s1aq8b (11=.) if hid =="3721137208004" & s1aq1==153


///4210442101013
br hid-s1aq8b tot_consumed if hid =="4210442101013"  & s1aq1==153
recode s1aq3a (11=1) if hid =="4210442101013" & s1aq1==153
recode s1aq3b (0=11) if hid =="4210442101013" & s1aq1==153



*************** 154 bitter tomato ****************
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 154 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq7a ==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 51 if s1aq1  == 154 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq7a ==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq8a = . if s1aq8a == 1 & issue == 51
replace s1aq8b = . if s1aq8b == 5 & issue == 51

replace s1aq6a = s1aq3a if issue == 51
replace s1aq3b = s1aq4b if issue == 51

replace s1aq5 = 350 if s1aq5 == 112 & hid == "3721137208002" & issue == 51
replace s1aq3a = 7 if s1aq3a == 8 & hid == "3410334103013" & issue == 51
replace s1aq6a = 7 if s1aq6a == 8 & hid == "3410334103013" & issue == 51
replace s1aq5 = 350 if s1aq5 == 7 & hid == "3621636209015" & issue == 51
replace s1aq5 = 350 if s1aq5 == 35 & hid == "3622436204015" & issue == 51
replace s1aq5 = 40 if s1aq5 == 30 & hid == "4420644205003" & issue == 51
replace s1aq3a = 35 if s1aq3a == 7 & hid == "4311743142010" & issue == 51
replace s1aq6a = 35 if s1aq6a == 7 & hid == "4311743142010" & issue == 51

drop issue 


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 154 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 52 if s1aq1  == 154 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = . if issue == 52
replace s1aq8a = . if issue == 52
replace s1aq7b = . if issue == 52
replace s1aq8b = . if issue == 52
replace s1aq3b = 6 if s1aq3b ==0 & issue == 52
replace s1aq4b = 6 if s1aq4b ==11 & issue == 52
replace s1aq6b = 6 if s1aq6b == 11 & issue == 52

drop issue 


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 154 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!= s1aq3a & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 53 if s1aq1  == 154 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!= s1aq3a & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq6a = s1aq3a if issue == 53
replace s1aq5 = 45 if s1aq5 == 30 & issue == 53
replace s1aq3b = 6 if s1aq3b == 0 & issue == 53
replace s1aq6b = s1aq3b if issue == 53
replace s1aq4b = 6 if s1aq4b == 11 & issue ==53

drop issue 


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 154 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 54 if s1aq1  == 154 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = s1aq3a if issue == 54
replace s1aq6a = s1aq4a if issue == 54
replace s1aq3b = 6 if s1aq3b == 0 & issue == 54
replace s1aq7b = s1aq3b if issue == 54
replace s1aq6b = s1aq4b if issue == 54

drop issue 

///3710537105008
br hid-s1aq8b tot_consumed if hid =="3710537105008"  & s1aq1==154
recode s1aq7a (.=14) if hid =="3710537105008" & s1aq1==154
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 154 & hid == "3710537105008"
replace s1aq7b = 6 if s1aq7b == .  & s1aq1 == 154 & hid == "3710537105008"


///4010240101007
br hid-s1aq8b tot_consumed if hid =="4010240101007"  & s1aq1==154
recode s1aq7a (1=.) if hid =="4010240101007" & s1aq1==154
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 154 & hid == "4010240101007"
replace s1aq7b = . if s1aq7b == 6  & s1aq1 == 154 & hid == "4010240101007"


///3421234207014
br hid-s1aq8b tot_consumed if hid =="3421234207014"  & s1aq1==154
recode s1aq7a (7=6) if hid =="3421234207014" & s1aq1==154
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 154 & hid == "3421234207014"


************* 155 garden eggs **************
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 155 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.


gen issue = 55 if  s1aq1  == 155 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = s1aq3a if issue == 55
replace s1aq6a = s1aq4a if issue == 55

replace s1aq3b = 6 if issue == 55
replace s1aq7b = s1aq3b if issue == 55
replace s1aq6b = s1aq4b if issue == 55

drop issue 



br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 155 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 56 if s1aq1  == 155 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = s1aq8a if issue == 56
replace s1aq6a = s1aq3a if issue == 56 

replace s1aq3b = 6 if issue == 56
replace s1aq7b = s1aq8b if issue == 56

drop issue 


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 155 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 57 if s1aq1  == 155 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = . if issue == 57
replace s1aq8a = . if issue == 57
replace s1aq7b = . if issue == 57
replace s1aq8b = . if issue == 57

replace s1aq6a = s1aq4a if issue == 57
replace s1aq5 = 60 if s1aq5 == 15 & hid == "4010240101006" & issue == 57
replace s1aq4a = 14 if s1aq4a == 41 & hid == "4010840108007" & issue == 57
replace s1aq6a = 14 if s1aq6a == 41 & hid == "4010840108007" & issue == 57
replace s1aq4a = 1 if s1aq4a == 6 & hid == "4010440103009" & issue == 57
replace s1aq6a = 1 if s1aq6a == 6 & hid == "4010440103009" & issue == 57
replace s1aq4a = 1 if s1aq4a == .1 & hid == "4210442101004" & issue == 57
replace s1aq6a = 1 if s1aq6a == .1 & hid == "4210442101004" & issue == 57
replace s1aq5 = 60 if s1aq5 == 5 & hid == "4510345114012" & issue == 57
replace s1aq4a = 3 if s1aq4a == 5 & hid == "3520335204014" & issue == 57

replace s1aq3a = s1aq6a if issue == 57
replace s1aq3b = 6 if issue == 57
replace s1aq4b = 6 if issue == 57
replace s1aq6b = 6 if issue == 57

drop issue 


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 155 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 58 if  s1aq1  == 155 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq6a = s1aq3a if issue == 58
replace s1aq3b = 6 if issue == 58
replace s1aq6b = 6 if issue == 58
replace s1aq4b = 6 if issue == 58

drop issue


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 155 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 59 if s1aq1  == 155 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq3a = 7 if s1aq3a == 76 & issue == 59
replace s1aq4a = s1aq3a if issue == 59
replace s1aq7a = s1aq3a if issue == 59 

replace s1aq3b = 6 if issue == 59
replace s1aq7b = 6 if issue == 59

drop issue 


********************** 156 okra **************
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 156 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 60 if s1aq1  == 156 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = . if issue == 60
replace s1aq8a = . if issue == 60

replace s1aq4a = s1aq3a if s1aq4a == 0 & issue == 60
replace s1aq4a = s1aq3a if s1aq4a == 11 & issue == 60
replace s1aq6a = s1aq3a if issue == 60

replace s1aq3b = 11 if issue == 60
replace s1aq4b = 11 if s1aq4b == 11 & issue == 60
replace s1aq6b = 11 if s1aq6b == 11 & issue == 60
replace s1aq6b = 11 if s1aq6b == 0 & issue == 60
replace s1aq7b = . if issue == 60
replace s1aq8b = . if issue == 60

drop issue 


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 156 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 61 if s1aq1  == 156 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = s1aq3a if issue == 61
replace s1aq6a = . if issue == 61

replace s1aq3b = 11 if issue == 61
*replace s1aq7b = 6 if issue == 61
replace s1aq6b = . if issue == 61

drop issue 



br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 156 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 62 if s1aq1  == 156 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = . if issue == 62
replace s1aq8a = . if issue == 62
replace s1aq7b = . if issue == 62
replace s1aq8b = . if issue == 62

replace s1aq5 = 40 if s1aq5 == 2 & issue ==62
replace s1aq6a = 2 if s1aq6a == 40 & hid == "4010740116002" & issue ==62
replace s1aq6a = 3 if s1aq6a == 1 & hid == "3410834116005" & issue ==62
replace s1aq6a = 1 if s1aq6a == 6 & hid == "3520535211005" & issue ==62
replace s1aq4a = 1 if s1aq4a == 6 & hid == "3520535211005" & issue ==62
replace s1aq6a = 4 if s1aq6a == 11 & hid == "3520335204007" & issue ==62
replace s1aq6a = 7 if s1aq6a == 140 & hid == "3721137208005" & issue ==62
replace s1aq4a = 7 if s1aq4a == 140 & hid == "3721137208005" & issue ==62
replace s1aq6a = 1 if s1aq6a == 15 & hid == "4311543134014" & issue ==62
replace s1aq4a = 1 if s1aq4a == 15 & hid == "4311543134014" & issue ==62
replace s1aq6a = 7 if s1aq6a == 4 & hid == "3520335204008" & issue ==62

replace s1aq3a = s1aq6a if issue == 62

replace s1aq3b = 11 if issue == 62
replace s1aq3b = 8 if s1aq3b == 11 & hid == "4020540221015" & issue == 62
replace s1aq4b = 11 if s1aq4b == 6 & issue == 62
replace s1aq6b = 11 if s1aq6b == 2 & issue == 62
replace s1aq6b = 11 if s1aq6b == 6 & issue == 62
replace s1aq6b = 11 if s1aq6b == 0 & issue == 62

drop issue 

////3810738103009
br hid-s1aq8b tot_consumed if hid =="3810738103009"  & s1aq1==156
recode s1aq7a (.=3) if hid =="3810738103009" & s1aq1==156
replace s1aq3b = 11 if s1aq3b == 0  & s1aq1 == 156 & hid == "3810738103009"
replace s1aq7b = 11 if s1aq7b == .  & s1aq1 == 156 & hid == "3810738103009"


///3410834116009
br hid-s1aq8b tot_consumed if hid =="3410834116009"  & s1aq1==156
recode s1aq7a (.=4) if hid =="3410834116009" & s1aq1==156
replace s1aq3b = 11 if s1aq3b == 0  & s1aq1 == 156 & hid == "3410834116009"
replace s1aq7b = 11 if s1aq7b == .  & s1aq1 == 156 & hid == "3410834116009"


////4010440103002
br hid-s1aq8b tot_consumed if hid =="4010440103002"  & s1aq1==156
recode s1aq8a (11=6) if hid =="4010440103002" & s1aq1==156
replace s1aq3b = 11 if s1aq3b == 0  & s1aq1 == 156 & hid == "4010440103002"
replace s1aq8b = 11 if s1aq8b == 0  & s1aq1 == 156 & hid == "4010440103002"


****************** 158 big red pepper ***************
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 158 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 63 if s1aq1  == 158 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = s1aq6a if issue == 63
replace s1aq6a = s1aq4a if issue == 63

replace s1aq3b = 11 if issue == 63
replace s1aq7b = s1aq3b if issue == 63
replace s1aq6b = . if issue == 63

drop issue 




br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 158 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.


gen issue = 63 if s1aq1  == 158 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq6a = s1aq3a if issue == 63
replace s1aq5 = 70 if s1aq5 == 49 & issue == 63
replace s1aq5 = 20 if s1aq5 == 12 & issue == 63

replace s1aq3b = 11 if issue == 63
replace s1aq4b = 11 if issue == 63
replace s1aq6b = 11 if issue == 63

drop issue 


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 158 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq7a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 64 if s1aq1  == 158 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq7a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = . if issue == 64
replace s1aq8a = . if issue == 64

replace s1aq7b = . if issue == 64
replace s1aq8b = . if issue == 64
replace s1aq4b = 11 if s1aq4b == 6 & issue == 64
replace s1aq6b = 11 if s1aq6b == 6 & issue == 64

drop issue 

br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 158 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq7a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 65 if s1aq1  == 158 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq7a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq8a = . if issue == 65
replace s1aq5 = 10 if s1aq5 == 100 & hid == "4121141207007" & issue ==65
replace s1aq4a = 4 if s1aq4a == 11 & hid == "4311543116001" & issue ==65
replace s1aq5 = 10 if s1aq5 == 100 & hid == "4021340217007" & issue ==65
replace s1aq3a = 1 if s1aq3a == 6 & hid == "4210142109014" & issue == 65
replace s1aq4a = 1 if s1aq4a == 6 & hid == "4210142109014" & issue == 65
replace s1aq3a = 1 if s1aq3a == 6 & hid == "4120341210013" & issue == 65
replace s1aq4a = 1 if s1aq4a == 6 & hid == "4120341210013" & issue == 65
replace s1aq3a = 7 if s1aq3a == 79 & hid == "4210142109013" & issue ==65
replace s1aq5 = 35 if s1aq5 == 7 & hid == "4111241102014" & issue == 65
replace s1aq3a = 3 if s1aq3a == 10 & hid == "3421234203015" & issue ==65
replace s1aq5 = 30 if s1aq5 == 3 & hid == "3522535218001" & issue == 65
replace s1aq5 = 35 if s1aq5 == 21 & hid == "3410334106013" & issue == 65
replace s1aq4a = 7 if s1aq4a == 1111 & hid == "3410334106013" & issue ==65
replace s1aq4a = 14 if s1aq4a == 41 & hid == "4010840108007" & issue ==65
replace s1aq4a = 1 if s1aq4a == 11 & hid == "3421234208009" & issue ==65
replace s1aq3a = 1 if s1aq3a == 6 & hid == "3810738103001" & issue == 65
replace s1aq4a = 1 if s1aq4a == 6 & hid == "3810738103001" & issue == 65
replace s1aq3a = 2 if s1aq3a == 3 & hid == "3520735220010" & issue == 65
replace s1aq5 = 20 if s1aq5 == 8 & hid == "3520735220010" & issue == 65
replace s1aq3a = 21 if s1aq3a == 7 & hid == "4311743142010" & issue == 65
replace s1aq5 = 42 if s1aq5 == 105 & hid == "4311743142010" & issue == 65
replace s1aq5 = 35 if s1aq5 == 7 & hid == "4010840110009" & issue == 65
replace s1aq6a = s1aq3a if issue == 65

replace s1aq8b = . if issue == 65
replace s1aq3b = 11 if issue == 65
replace s1aq4b = 11 if s1aq4b == 6 & issue == 65
replace s1aq4b = 11 if s1aq4b == 9 & issue == 65
replace s1aq6b = 11 if s1aq6b == 6 & issue == 65
replace s1aq6b = 11 if s1aq6b == 7 & issue == 65
replace s1aq6b = 11 if s1aq6b == 1 & issue == 65
replace s1aq6b = 11 if s1aq6b == 0 & issue == 65

drop issue 


///3710537105008
br hid-s1aq8b tot_consumed if hid =="3710537105008"  & s1aq1==158
recode s1aq7a (.=14) if hid =="3710537105008" & s1aq1==158
replace s1aq3b = 11 if s1aq3b == 0  & s1aq1 == 158 & hid == "3710537105008"
replace s1aq7b = 11 if s1aq7b == .  & s1aq1 == 158 & hid == "3710537105008"



///4220442209016
br hid-s1aq8b tot_consumed if hid =="4220442209016"  & s1aq1==158
recode s1aq7a (6=1) if hid =="4220442209016" & s1aq1==158
replace s1aq3b = 11 if s1aq3b == 0  & s1aq1 == 158 & hid == "4220442209016"


///3710537105008
br hid-s1aq8b tot_consumed if hid =="3710537105008"  & s1aq1==158
recode s1aq7a (.=14) if hid =="3710537105008" & s1aq1==158
replace s1aq3b = 11 if s1aq3b == 0  & s1aq1 == 158 & hid == "3710537105008"
replace s1aq7b = 11 if s1aq7b == .  & s1aq1 == 158 & hid == "3710537105008"


****************88 159 fresh green pepper *************
///3810438110007
br hid-s1aq8b tot_consumed if hid =="3810438110007"  & s1aq1==159
recode s1aq7a (1=.) if hid =="3810438110007" & s1aq1==159
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 159 & hid == "3810438110007"
replace s1aq4b = 6 if s1aq4b == 11 & s1aq1 == 159 & hid == "3810438110007"
replace s1aq6b = 6 if s1aq6b == 11 & s1aq1 == 159 & hid == "3810438110007"
replace s1aq7b = . if s1aq7b == 11  & s1aq1 == 159 & hid == "3810438110007"

////4010840110005
br hid-s1aq8b tot_consumed if hid =="4010840110005"  & s1aq1==159
recode s1aq6a (6=2) if hid =="4010840110005" & s1aq1==159
recode s1aq5 (2=20) if hid =="4010840110005" & s1aq1==159
recode s1aq7a (6=.) if hid =="4010840110005" & s1aq1==159
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 159 & hid == "4010840110005"
replace s1aq4b = 6 if s1aq4b == 11 & s1aq1 == 159 & hid == "4010840110005"
replace s1aq6b = 6 if s1aq6b == 2 & s1aq1 == 159 & hid == "4010840110005"
replace s1aq7b = . if s1aq7b == 0  & s1aq1 == 159 & hid == "4010840110005"


************ 163  carrot *************
///4311543108010
br hid-s1aq8b tot_consumed if hid =="4311543108010"  & s1aq1==163
recode s1aq3a (18=28) if hid =="4311543108010" & s1aq1==163
replace s1aq3b = 6 if s1aq3b == 0  & s1aq1 == 163 & hid == "4311543108010"


******************* 164 onion ***********
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 164 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq7a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 66 if s1aq1  == 164 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq7a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = . if issue == 66
replace s1aq8a = . if issue == 66
replace s1aq6a = 7 if s1aq6a == 35 & issue == 66
replace s1aq5 = 35 if s1aq5 == 7 & issue == 66
replace s1aq5 = 100 if s1aq5 ==50 & issue == 66
replace s1aq5 = 175 if s1aq5 == 87.5 & issue == 66
replace s1aq3a = 6 if s1aq3a == 27 & issue == 66
replace s1aq4a = 6 if s1aq4a == 27 & issue == 66
replace s1aq6a = 6 if s1aq6a == 27 & issue == 66

replace s1aq3a = 3 if s1aq3a == 35 & issue == 66
replace s1aq4a = 3 if s1aq4a == 35 & issue == 66
replace s1aq6a = 3 if s1aq6a == 6 & issue == 66
replace s1aq5 = 15 if s1aq5 == 35 & issue == 66
replace s1aq3a = 2 if s1aq3a == 5 & hid == "4210242107009" & issue == 66
replace s1aq4a = 1 if s1aq4a == 50 & hid == "4510445101002" & issue ==66
replace s1aq5 = 50 if s1aq5 == 1 & hid == "4510445101002" & issue == 66
replace s1aq6a = 1 if s1aq6a == 50 & hid == "4510445101002" & issue ==66

replace s1aq6b = 1 if s1aq6b == 6 & hid == "4210242107009" & issue == 66
replace s1aq3b = 1 if s1aq3b == 0 & hid == "4210242107009" & issue == 66
replace s1aq4b = 1 if s1aq4b == 6 & hid == "4210242107009" & issue == 66
replace s1aq6b = 6 if s1aq6b == 7 & hid == "401044103001" & issue == 66
replace s1aq3b = 6 if s1aq3b == 0 & hid == "401044103001" & issue == 66
replace s1aq3b = 11 if s1aq3b == 0 & hid == "3421234207002" & issue ==66
replace s1aq3b = 6 if s1aq3b == 0 & hid == "3410334103015" & issue ==66
replace s1aq6b = 6 if s1aq6b == 0 & hid == "3410334103015" & issue ==66
replace s1aq3b = 1 if s1aq3b == 0 & hid == "4510445101002" & issue ==66
replace s1aq3b = 6 if s1aq3b == 0 & hid == "3520735220011" & issue ==66
replace s1aq3b = 1 if s1aq3b == 0 & hid == "3810438110012" & issue ==66
replace s1aq3b = 6 if s1aq3b == 0 & hid == "4020740207004" & issue ==66
replace s1aq3b = 1 if s1aq3b == 0 & hid == "4311543108002" & issue ==66
replace s1aq7b = . if issue == 66
replace s1aq8b = . if issue == 66

drop issue 



br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 164 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 67 if s1aq1  == 164 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = s1aq3a if issue == 67
replace s1aq3b = 11 if s1aq3b == 0 & issue == 67
replace s1aq7b = s1aq3b if issue == 67
replace s1aq4b = 11 if issue == 67
replace s1aq6b = . if issue == 67

drop issue 


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 164 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 68 if  s1aq1  == 164 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = . if issue == 68
replace s1aq3a = s1aq6a if issue == 68
replace s1aq4a = s1aq6a if issue == 68

replace s1aq3b = 11 if issue == 68
replace s1aq4b = 11 if issue == 68
replace s1aq6b = 11 if issue == 68
replace s1aq7b = . if issue == 68

drop issue


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 164 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 69 if s1aq1  == 164 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq6a = 7 if s1aq6a == 8 & hid == "3410334103013" & issue == 69
replace s1aq6a = 4 if s1aq6a == 44 & hid == "3512535115003" & issue == 69
replace s1aq5 = 40 if s1aq5 == 85 & hid == "3512535115003" & issue == 69
replace s1aq6a = 1 if s1aq6a == .1 & hid == "3720737207016" & issue == 69
replace s1aq6a = 7 if s1aq6a == 350 & hid == "3810138105010" & issue == 69
replace s1aq6a = 4 if s1aq6a == 46 & hid == "3610236101006" & issue == 69
replace s1aq6a = 2 if s1aq6a == 1 & hid == "4210242106008" & issue == 69
replace s1aq6a = 7 if s1aq6a == 17 & hid == "3810438110007" & issue == 69
replace s1aq6a = 5 if s1aq6a == 50 & hid == "3610136115002" & issue == 69
replace s1aq5 = 50 if s1aq5 == 11 & hid == "3610136115002" & issue == 69
replace s1aq6a = 7 if s1aq6a == 1 & hid == "3820238208014" & issue == 69
replace s1aq6a = 5 if s1aq6a == 56 & hid == "4011140114007" & issue == 69
replace s1aq5 = 5 if s1aq5 == 550 & hid == "4011140114007" & issue == 69
replace s1aq6a = 7 if s1aq6a == 77 & hid == "3610636103015" & issue == 69
replace s1aq6a = 21 if s1aq6a == 2 & hid == "3420934212009" & issue == 69
replace s1aq6a = 12 if s1aq6a == 1 & hid == "4021340215014" & issue == 69
replace s1aq6a = 4 if s1aq6a == 3 & hid == "3722237213013" & issue == 69
replace s1aq6a = 9 if s1aq6a == 1 & hid == "3810438110010" & issue == 69
replace s1aq5 = 90 if s1aq5 == 900 & hid == "3810438110010" & issue == 69
replace s1aq6a = 1 if s1aq6a == 7 & hid == "4010240101008" & issue == 69
replace s1aq5 = 160 if s1aq5 == 140 & hid == "3620336207007" & issue == 69
replace s1aq5 = 160 if s1aq5 == 140 & hid == "3410334103012" & issue == 69
replace s1aq5 = 70 if s1aq5 == 60 & hid == "4010240101009" & issue == 69
replace s1aq5 = 70 if s1aq5 == 50 & hid == "4011140114014" & issue == 69
replace s1aq5 = 15 if s1aq5 == 150 & hid == "4410644110011" & issue == 69
replace s1aq5 = 80 if s1aq5 == 140 & hid == "3520235213011" & issue == 69
replace s1aq5 = 210 if s1aq5 == 140 & hid == "4320443201008" & issue == 69
replace s1aq5 = 70 if s1aq5 == 7070 & hid == "4011140114002" & issue == 69
replace s1aq5 = 25 if s1aq5 == 250 & hid == "4010240101008" & issue == 69

replace s1aq3a = s1aq6a if issue == 69
replace s1aq4a = s1aq6a if issue == 69

replace s1aq3b = 11 if issue == 69
replace s1aq4b = 11 if issue == 69
replace s1aq6b = 11 if issue == 69

drop issue 


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 164 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 70 if s1aq1  == 164 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq3a = 3 if s1aq3a == 35 & issue == 70
replace s1aq3a = 15 if s1aq3a == 1.5 & issue == 70
replace s1aq7a = s1aq3a if issue == 70
replace s1aq6a = . if issue == 70

replace s1aq3b = 11 if issue == 70
replace s1aq6b = . if issue == 70
replace s1aq7b = 11 if issue == 70

drop issue 



br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 164 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 71 if s1aq1  == 164 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq8a = . if issue == 71
replace s1aq8b = . if issue == 71
replace s1aq3a = 10 if s1aq3a == 10.5 & issue == 71
replace s1aq7a = s1aq3a if issue == 71
replace s1aq3b = 11 if issue == 71
replace s1aq7b = 11 if issue == 71

drop issue 


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 164 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 72 if s1aq1  == 164 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq5 = 100 if s1aq5 == 30 & issue == 72
replace s1aq5 = 280 if s1aq5 == 112 & issue == 72
replace s1aq6a = s1aq3a if issue == 72
replace s1aq3b = 11 if issue == 72
replace s1aq4b = 11 if issue == 72
replace s1aq6b = 11 if issue == 72

drop issue 


///4210242107016
br hid-s1aq8b tot_consumed if hid =="4210242107016"  & s1aq1==164
recode s1aq5 (400=.) if hid =="4210242107016" & s1aq1==164
recode s1aq6a (7=.) if hid =="4210242107016" & s1aq1==164
recode s1aq7a (.=1) if hid =="4210242107016" & s1aq1==164
replace s1aq3b = 11 if s1aq3b == 0  & s1aq1 == 164 & hid == "4210242107016"
replace s1aq6b = . if s1aq3b == 14  & s1aq1 == 164 & hid == "4210242107016"
replace s1aq7b = 11 if s1aq3b == .  & s1aq1 == 164 & hid == "4210242107016"



///4010840108003
br hid-s1aq8b tot_consumed if hid =="4010840108003"  & s1aq1==164
recode s1aq8a (2=.) if hid =="4010840108003" & s1aq1==164
replace s1aq3b = 11 if s1aq3b == 0  & s1aq1 == 164 & hid == "4010840108003"
replace s1aq8b = . if s1aq3b == 0  & s1aq1 == 164 & hid == "4010840108003"



****************** 165 garlic ***************
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 165 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 73 if s1aq1  == 165 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq5 = 21 if s1aq5 == 14 & issue == 73
replace s1aq4a = 2 if s1aq4a == 10 & issue == 73
replace s1aq6a = s1aq3a if issue == 73

replace s1aq3b = 6 if issue == 73
replace s1aq4b = 6 if issue == 73
replace s1aq6b = 6 if issue == 73

drop issue 



br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 165 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 74 if s1aq1  == 165 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq3a = 4 if s1aq3a == 14 & issue == 74
replace s1aq8a = s1aq3a if issue == 74

replace s1aq3b = 6 if issue == 74
replace s1aq8b = 6 if issue == 74

drop issue 



br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 165 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 75 if s1aq1  == 165 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.


replace s1aq3a = s1aq6a if issue == 75
replace s1aq6a = . if issue == 75
replace s1aq8a = s1aq3a if issue == 75

replace s1aq3b = 6 if issue == 75
replace s1aq8b = 6 if issue == 75

drop issue 



br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 165 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 76 if s1aq1  == 165 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = . if issue == 76
replace s1aq8a = . if issue == 76
replace s1aq5 = 18 if s1aq5 == 14 & hid == "4311543131009" & issue == 76
replace s1aq6a = 5 if s1aq6a == 15 & hid == "4210142109005" & issue == 76
replace s1aq5 = 50 if s1aq5 == 10 & hid == "4210142109005" & issue == 76
replace s1aq5 = 18 if s1aq5 == 6 & hid == "3621636209002" & issue == 76
replace s1aq5 = 18 if s1aq5 == 4 & hid == "4010740116001" & issue == 76
replace s1aq5 = 18 if s1aq5 == 2 & hid == "4311043137001" & issue == 76
replace s1aq5 = 15 if s1aq5 == 6 & hid == "4311143106002" & issue == 76
replace s1aq5 = 18 if s1aq5 == 2 & hid == "4021340214008" & issue == 76
replace s1aq5 = 21 if s1aq5 == 10 & hid == "4021240209005" & issue == 76
replace s1aq5 = 18 if s1aq5 == 6 & hid == "4311543114011" & issue == 76
replace s1aq5 = 24 if s1aq5 == 25 & hid == "4111041113007" & issue == 76
replace s1aq5 = 18 if s1aq5 == 8 & hid == "3621636211013" & issue == 76
replace s1aq5 = 18 if s1aq5 == 5 & hid == "4010740116008" & issue == 76
replace s1aq6a = 1 if s1aq6a == 3 & hid == "4010240101009" & issue == 76
replace s1aq6a = 1 if s1aq6a == 3 & hid == "3721137208003" & issue == 76
replace s1aq6a = 1 if s1aq6a == 6 & hid == "4022440219009" & issue == 76
replace s1aq6a = 1 if s1aq6a == 6 & hid == "3330433309005" & issue == 76
replace s1aq6a = 1 if s1aq6a == 5 & hid == "4210242108011" & issue == 76
replace s1aq6a = 1 if s1aq6a == 6 & hid == "3410334108004" & issue == 76
replace s1aq6a = 1 if s1aq6a == 6 & hid == "4210642110013" & issue == 76

replace s1aq3a = s1aq6a if issue == 76
replace s1aq4a = s1aq6a if issue == 76

replace s1aq3b = 6 if issue == 76
replace s1aq4b = 6 if issue == 76 
replace s1aq6b = 6 if issue == 76  
replace s1aq7b = . if issue == 76
replace s1aq8b = . if issue == 76

drop issue 



br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 165 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.


gen issue  = 77 if s1aq1  == 165 & s1aq3a!=. & s1aq4a!=. & s1aq5==. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq6a = s1aq3a if issue == 77
replace s1aq4a = s1aq3a if issue == 77
replace s1aq3b = 6 if issue == 77 

drop issue



************** 166 other vegetables ********
///3610136115002
br hid-s1aq8b tot_consumed if hid =="3610136115002"  & s1aq1==166
recode s1aq3a (11=3) if hid =="3610136115002" & s1aq1==166
recode s1aq5 (6=15) if hid =="3610136115002" & s1aq1==166
replace s1aq3b = 11 if s1aq3b == 0  & s1aq1 == 166 & hid == "3610136115002"




tempfile davies
save `davies'

*************************************
********** Isatou:
*************************************
use revised_task_distribution_dta_file.dta, clear

keep if responsible == 3

**** CODE
*****CASSAVA****************
************5311253117004 
replace s1aq7a =3    if hid =="5311253117004" & s1aq1==148
replace s1aq7b =11   if hid =="5311253117004" & s1aq1==148
replace s1aq3b =11   if hid =="5311253117004" & s1aq1==148

************5023050213001,
replace s1aq4b =6   if hid =="5023050213001" & s1aq1==148
replace s1aq6a =4   if hid =="5023050213001" & s1aq1==148
replace s1aq6b =6   if hid =="5023050213001" & s1aq1==148
replace s1aq3b =6   if hid =="5023050213001" & s1aq1==148

*****************5220152222007,5530155356006
*forvalues i=1/1335 {
replace s1aq4a =3   if (hid =="5220152222007"|hid =="5530155356006") & s1aq1==148
replace s1aq6a =3   if (hid =="5220152222007"|hid =="5530155356006") & s1aq1==148
replace s1aq6b =11  if (hid =="5220152222007"|hid =="5530155356006") & s1aq1==148
replace s1aq3b =11  if (hid =="5220152222007"|hid =="5530155356006") & s1aq1==148
replace s1aq3a =3   if hid =="5530155356006" & s1aq1==148

 *}

*******************5310953113015
replace s1aq6a =.   if hid =="5310953113015" & s1aq1==148
replace s1aq6b =.   if hid =="5310953113015" & s1aq1==148
replace s1aq4a =.   if hid =="5310953113015" & s1aq1==148
replace s1aq4b =.   if hid =="5310953113015" & s1aq1==148
replace s1aq8a =.   if hid =="5310953113015" & s1aq1==148
replace s1aq8b =.   if hid =="5310953113015" & s1aq1==148
replace s1aq7a =3   if hid =="5310953113015" & s1aq1==148
replace s1aq7b =11  if hid =="5310953113015" & s1aq1==148
replace s1aq3b =11  if hid =="5310953113015" & s1aq1==148

*****************5530155356014
replace s1aq4a =2   if hid =="5530155356014" & s1aq1==148
replace s1aq6a =2   if hid =="5530155356014" & s1aq1==148
replace s1aq3b =11  if hid =="5530155356014" & s1aq1==148
replace s1aq3a =2  if hid =="5530155356014" & s1aq1==148

*****************5530155311001
replace s1aq4a =1   if hid =="5530155311001" & s1aq1==148
replace s1aq6a =1   if hid =="5530155311001" & s1aq1==148
replace s1aq3b =11  if hid =="5530155311001" & s1aq1==148
replace s1aq3a =1   if hid =="5530155311001" & s1aq1==148

*****************LIFE GOAT 
// change the no unit to pieace/number
***************5022650224011
replace s1aq3b =6  if hid =="5022650224011" & s1aq1==34
replace s1aq3a =1  if hid =="5022650224011" & s1aq1==34

*****************5321053215016  
**********please confirm this case. bougght 3 but cons 1
replace s1aq6a =1   if hid =="5321053215016" & s1aq1==34
replace s1aq6b =6   if hid =="5321053215016" & s1aq1==34
replace s1aq4a =3   if hid =="5321053215016" & s1aq1==34
replace s1aq4b =6   if hid =="5321053215016" & s1aq1==34
replace s1aq7a =.   if hid =="5321053215016" & s1aq1==34
replace s1aq7b =.   if hid =="5321053215016" & s1aq1==34
replace s1aq3b =6   if hid =="5321053215016" & s1aq1==34
replace s1aq3a =1   if hid =="5321053215016" & s1aq1==34

******************5530155311012
replace s1aq4a =1   if hid =="5530155311012" & s1aq1==34
replace s1aq4b =6   if hid =="5530155311012" & s1aq1==34
replace s1aq7a =.   if hid =="5530155311012" & s1aq1==34
replace s1aq7b =.   if hid =="5530155311012" & s1aq1==34
replace s1aq3b =6   if hid =="5530155311012" & s1aq1==34
replace s1aq3a =1   if hid =="5530155311012" & s1aq1==34

*****************life chicken(local)
***********5511155116002, 6022960213012
replace s1aq3b =6  if (hid =="5511155116002"|hid =="6022960213012") & s1aq1==37
replace s1aq3a =1  if (hid =="5511155116002"|hid =="6022960213012") & s1aq1==37

**********6211662120016
replace s1aq3b =6  if hid =="6211662120016" & s1aq1==37
replace s1aq6a =1  if hid =="6211662120016" & s1aq1==37
replace s1aq6b =6  if hid =="6211662120016" & s1aq1==37
*********************6321663215016, 5020750230002
replace s1aq4a =4  if hid =="6321663215016" & s1aq1==37
replace s1aq4a =2  if hid =="5020750230002" & s1aq1==37

***************5211152102011, 6321663215016, 5111651120009
replace s1aq6b =6   if hid =="5211152102011"|hid=="6321663215016"|hid=="5111651120009"|hid =="5020750230002" & s1aq1==37
replace s1aq6a =s1aq4b   if hid =="5211152102011"|hid=="6321663215016"|hid=="5111651120009"|hid =="5020750230002" & s1aq1==37
replace s1aq3b =6   if hid =="5211152102011"|hid=="6321663215016"|hid=="5111651120009"| hid =="5020750230002" & s1aq1==37
replace s1aq3a =s1aq4b   if hid =="5211152102011"|hid=="6321663215016"|hid=="5111651120009"|hid =="5020750230002"  & s1aq1==37
replace s1aq7a =.   if hid =="5211152102011"|hid=="6321663215016"|hid=="5111651120009" & s1aq1==37
replace s1aq7b =.   if hid =="5211152102011"|hid=="6321663215016"|hid=="5111651120009" & s1aq1==37
replace s1aq8a =.   if hid =="5211152102011"|hid=="6321663215016"|hid=="5111651120009" & s1aq1==37
replace s1aq8b =.   if hid =="5211152102011"|hid=="6321663215016"|hid=="5111651120009" & s1aq1==37


*****************life chicken(Industrial)
***********5020150236016, 5122551211002, 5530155356010(**confirm prices (150, 160, 180)for these cases)5012150173013,5622156219012 
replace s1aq4a =1   if (hid =="5020150236016"|hid =="5122551211002"|hid =="5530155356010"|hid =="5622156219012") & s1aq1==38
replace s1aq4b =6   if (hid =="5020150236016"|hid =="5122551211002"|hid =="5530155356010"|hid =="5622156219012") & s1aq1==38
replace s1aq6a =1   if (hid =="5020150236016"|hid =="5122551211002"|hid =="5530155356010"|hid =="5622156219012") & s1aq1==38
replace s1aq6b =6   if (hid =="5020150236016"|hid =="5122551211002"|hid =="5530155356010"|hid =="5622156219012") & s1aq1==38
replace s1aq3a =1   if (hid =="5020150236016"|hid =="5122551211002"|hid =="5530155356010"|hid =="5012150173013"|hid =="5622156219012") & s1aq1==38
replace s1aq3b =6   if (hid =="5020150236016"|hid =="5122551211002"|hid =="5530155356010"|hid =="5012150173013"|hid =="5622156219012") & s1aq1==38
replace s1aq5 =.   if  hid =="5622156219012 " & s1aq1==38 // please confirm whether to change s1aq5 

************5420554201009,5622156219012
replace s1aq4a =2   if hid =="5420554201009" & s1aq1==38
replace s1aq4b =6   if hid =="5420554201009" & s1aq1==38
replace s1aq6a =1   if hid =="5420554201009" & s1aq1==38
replace s1aq6b =6   if hid =="5420554201009" & s1aq1==38
replace s1aq3a =1   if hid =="5420554201009" & s1aq1==38
replace s1aq3b =6   if hid =="5420554201009" & s1aq1==38

************4520145212007
replace s1aq4a =4   if hid =="4520145212007" & s1aq1==38
replace s1aq6a =4   if hid =="4520145212007" & s1aq1==38
replace s1aq3b =6   if hid =="4520145212007" & s1aq1==38

****************************
*************Beef with bones
******5420754220003, 6311163120009
replace s1aq7a =.   if hid =="5420754220003" & s1aq1==42
replace s1aq7b =.   if hid =="5420754220003" & s1aq1==42
replace s1aq8a =1   if hid =="5420754220003" & s1aq1==42
replace s1aq8b =1   if hid =="5420754220003" & s1aq1==42
replace s1aq3a =1   if hid =="5420754220003" & s1aq1==42
replace s1aq3b =1   if hid =="5420754220003" & s1aq1==42

*************5220952204005
replace s1aq4a =1   if hid =="5220952204005" & s1aq1==42
replace s1aq6a =1   if hid =="5220952204005" & s1aq1==42
replace s1aq3a =1   if hid =="5220952204005" & s1aq1==42
replace s1aq3b =1   if hid =="5220952204005" & s1aq1==42

************************5420754218005
replace s1aq6a =2.5   if hid =="5420754218005" & s1aq1==42
replace s1aq6b =1   if hid =="5420754218005" & s1aq1==42
replace s1aq3b =1   if hid =="5420754218005" & s1aq1==42
*******************5022650224014, 
replace s1aq3a =3   if hid =="5022650224014" & s1aq1==42
replace s1aq3b =1   if hid =="5022650224014" & s1aq1==42  
*************5530155347011
replace s1aq3a =2 if hid == "5530155347011"  & s1aq1==42 // check for the price 1=100
replace s1aq3a =2   if hid == "5530155347011"  & s1aq1==42 // check for the price 1=100

***************5420554201009
replace s1aq4a =4   if hid =="5420554201009" & s1aq1==42
replace s1aq6a =4   if hid =="5420554201009" & s1aq1==42
replace s1aq3a =4   if hid =="5420554201009" & s1aq1==42
replace s1aq3b =1   if hid =="5420554201009" & s1aq1==42

*********************6313963107011
replace s1aq4a =3   if hid =="6313963107011" & s1aq1==42
replace s1aq6a =3   if hid =="6313963107011" & s1aq1==42
replace s1aq3b =1   if hid =="6313963107011" & s1aq1==42

 *********5610556118014 and 6311363126016 * price at 200
replace s1aq3b =1   if (hid =="5610556118014" |hid=="6311363126016") & s1aq1==42
********************6311163120009
replace s1aq7a =.   if hid =="6311163120009" & s1aq1==42
replace s1aq7b =.   if hid =="6311163120009" & s1aq1==42
replace s1aq4a =1   if hid =="6311163120009" & s1aq1==42
replace s1aq6b =1   if hid =="6311163120009" & s1aq1==42
replace s1aq3a =1   if hid =="6311163120009" & s1aq1==42
replace s1aq3b =1   if hid =="6311163120009" & s1aq1==42

************************5530155356010
replace s1aq6a =2   if hid =="5530155356010" & s1aq1==42
replace s1aq6b =1   if hid =="5530155356010" & s1aq1==42
replace s1aq3b =1   if hid =="5530155356010" & s1aq1==42

**********************5610556118014
replace s1aq4a =1.5   if hid =="5610556118014" & s1aq1==42
replace s1aq6a =1.5   if hid =="5610556118014" & s1aq1==42
replace s1aq3a =1.5   if hid =="5610556118014" & s1aq1==42


gen issue = 3  if s1aq1  == 42 & (s1aq5==600|s1aq5==6000|s1aq5==750)
replace s1aq3a = 3 if issue == 3
replace s1aq3b = 1 if issue == 3
replace s1aq4a = 3 if issue == 3
replace s1aq4b = 1 if issue == 3
replace s1aq6a = 3 if issue == 3
replace s1aq6b = 1 if issue == 3
replace s1aq5 = 600 if issue == 3

replace s1aq5 =750   if hid =="5530155328007" & s1aq1==42

drop issue 
gen issue = 3  if s1aq1  == 42 & (s1aq5==400|s1aq5==1)
replace s1aq3a = 2 if issue == 3
replace s1aq3b = 1 if issue == 3
replace s1aq4a = 2 if issue == 3
replace s1aq4b = 1 if issue == 3
replace s1aq6a = 2 if issue == 3
replace s1aq6b = 1 if issue == 3
replace s1aq5 = 400 if issue == 3

****************6311363126016
replace s1aq3a =2   if hid =="6311363126016" & s1aq1==42

drop issue
gen issue = 3  if s1aq1  == 42 & (s1aq5==2000|s1aq5==.)
replace s1aq3b = 1 if issue == 3
replace s1aq4a =s1aq3a if issue == 3
replace s1aq4b = 1 if issue == 3
replace s1aq6a = s1aq3a if issue == 3
replace s1aq6b = 1 if issue == 3
replace s1aq5 = 400 if hid =="6311363126016" & s1aq1==42
replace s1aq8a =. if issue == 3
replace s1aq8b =.  if issue == 3

******************CHICKEN LEG(IMPORTED)
***********6022260212009
replace s1aq6a =.5   if hid =="6022260212009" & s1aq1==44
replace s1aq6b =1   if hid =="6022260212009" & s1aq1==44
replace s1aq3b =1   if hid =="6022260212009" & s1aq1==44

************6022260210008, 5010550185010
replace s1aq6a =3   if hid =="6022260210008" & s1aq1==44
replace s1aq6b =1   if (hid =="6022260210008"|hid == "5010550185010") & s1aq1==44
replace s1aq3b =1   if (hid =="6022260210008"|hid == "5010550185010") & s1aq1==44
replace s1aq8a =.   if hid =="5010550185010" & s1aq1==44
replace s1aq8b =.   if hid =="5010550185010" & s1aq1==44

***************5111751123005
replace s1aq6a =.5    if hid =="5111751123005" & s1aq1==44
replace s1aq4a =.5    if hid =="5111751123005" & s1aq1==44
replace s1aq3b =1     if hid =="5111751123005" & s1aq1==44
 *********5222152223010 , 6211662120003, 
replace s1aq6a =1   if (hid =="5222152223010" |hid == "6211662120003") &  s1aq1==44 
replace s1aq6b =1   if (hid =="5222152223010" |hid == "6211662120003") &  s1aq1==44 
replace s1aq3b =1   if (hid =="5222152223010" |hid == "6211662120003") &  s1aq1==44 

*****************5420754218004,5110751101013, 6010660111003, 6112561121011 ,5622556221001// only s1aq4 was recorded so transferred same to s1aq6
replace s1aq6a =2    if  hid =="5420754218004" & s1aq1==44
replace s1aq6a =4    if  hid =="5110751101013" & s1aq1==44
replace s1aq6a =3    if  hid =="6112561121011" & s1aq1==44
replace s1aq6a =1    if  (hid =="6010660111003"|hid =="5622556221001") & s1aq1==44
replace s1aq6b =1    if (hid =="5420754218004" |hid =="5110751101013"|hid =="6010660111003"|hid =="6112561121011"|hid =="5622556221001") & s1aq1==44
replace s1aq3b =1    if (hid =="5420754218004" |hid =="5110751101013"|hid =="6010660111003"|hid =="6112561121011"|hid =="5622556221001") & s1aq1==44
replace s1aq5 =.     if  hid =="5622556221001" & s1aq1==44
replace s1aq4a =1    if  hid =="5622556221001" & s1aq1==44
replace s1aq5 = 85    if hid =="5622556221001" & s1aq1==44  //check the original amt and ask Janneh (line 185 and 187)

**************5012950104006
replace s1aq5 =.     if hid =="5012950104006" & s1aq1==44
replace s1aq3b =1    if hid =="5012950104006" & s1aq1==44
replace s1aq3a =1    if hid =="5012950104006" & s1aq1==44

**********************5530155311001
replace s1aq6a =2    if hid =="5530155311001" & s1aq1==44
replace s1aq4a =2    if hid =="5530155311001" & s1aq1==44
replace s1aq3b =1    if hid =="5530155311001" & s1aq1==44
replace s1aq3a =2    if hid =="5530155311001" & s1aq1==44

***************************6120461201012
replace s1aq6a =3    if hid =="6120461201012" & s1aq1==44
replace s1aq4a =3    if hid =="6120461201012" & s1aq1==44
replace s1aq3b =1    if hid =="6120461201012" & s1aq1==44

***************5520255205003, 5221052226001 // ask btw total cons and s1a6 which one to retained, if total then change to 2 but only for the first case
replace s1aq3a =1    if (hid =="5520255205003"|hid=="5221052226001") & s1aq1==44
replace s1aq3b =1    if (hid =="5520255205003"|hid=="5221052226001") & s1aq1==44

**************************5013050117004, 6311963130002, 4520745203010
replace s1aq3a=2  if hid=="5013050117004"|hid=="4520745203010" & s1aq1==44
replace s1aq3b=1  if hid=="5013050117004"|hid=="4520745203010" & s1aq1==44
replace s1aq4a=2  if hid=="5013050117004"|hid=="4520745203010" & s1aq1==44
replace s1aq4b=1  if hid=="5013050117004"|hid=="4520745203010" & s1aq1==44
replace s1aq6a=2  if hid=="5013050117004"|hid=="4520745203010" & s1aq1==44
replace s1aq6b=1  if hid=="5013050117004"|hid=="4520745203010" & s1aq1==44

************************** 6311963130002, 
replace s1aq3b=6  if hid=="6311963130002" & s1aq1==44
replace s1aq4a=6  if hid=="6311963130002" & s1aq1==44
replace s1aq6a=4  if hid=="6311963130002" & s1aq1==44
replace s1aq6b=6  if hid=="6311963130002" & s1aq1==44

**************************5122251233009,5121851236002 ,5013450178011, 5222152223014
replace s1aq8a=.  if hid=="5122251233009"|hid=="5121851236002"|hid== "5013450178011"|hid=="5222152223014" & s1aq1==45
replace s1aq8b=.  if hid=="5122251233009"|hid=="5121851236002"|hid=="5013450178011"|hid=="5222152223014" & s1aq1==45

********************************************************
********************************************************* chicken local
br  hid s1aq2 s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b tot_consumed if s1aq1==45 |s1aq1==45 & s1aq3a!=tot_consumed & s1aq3a!=.

drop issue 
gen issue = 3  if s1aq1  == 45 & (s1aq5==. & s1aq4a==. & s1aq4b==.  & s1aq6a==.  & s1aq7a!=. & s1aq8a==. ) 
replace s1aq3b = 6 if issue == 3
replace s1aq3a = s1aq7a if issue == 3
replace s1aq7b = 6 if issue == 3

*******************************5621956214003
replace s1aq7b=.  if hid=="5621956214003" & s1aq1==45
replace s1aq7a=.  if hid=="5621956214003" & s1aq1==45

drop issue 
gen issue = 3  if s1aq1  == 45 & s1aq5==125|s1aq5==200
replace s1aq3a = 1 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 1 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 1 if issue == 3
replace s1aq6b = 6 if issue == 3

************************5222152223014, 5511855110015
replace s1aq7a = s1aq3a if hid=="5222152223014"|hid=="5511855110015" & s1aq1==45

************************5121851236002
replace s1aq3b=6  if hid=="5121851236002" & s1aq1==45
replace s1aq7b=6  if hid=="5121851236002" & s1aq1==45
replace s1aq6a=.  if hid=="5121851236002" & s1aq1==45
replace s1aq6b=.  if hid=="5121851236002" & s1aq1==45
replace s1aq4a=.  if hid=="5121851236002" & s1aq1==45
replace s1aq4b=.  if hid=="5121851236002" & s1aq1==45
replace s1aq5=.  if hid=="5121851236002" & s1aq1==45

****************5110351125013, 5013450178011
drop issue
gen issue = 3  if s1aq1  == 45 & (s1aq5==9|s1aq5==3)
replace s1aq3b = 6 if issue == 3
replace s1aq7a =s1aq3a if issue == 3
replace s1aq7b = 6 if issue == 3
replace s1aq4a =.  if issue == 3
replace s1aq4b =.  if issue == 3
replace s1aq6a =.  if issue == 3
replace s1aq6b =.  if issue == 3
replace s1aq5 =.   if issue == 3

****************PORK
********************************5211452117002
replace s1aq5 =.     if hid =="5211452117002" & s1aq1==46
replace s1aq3b =1    if hid =="5211452117002" & s1aq1==46
replace s1aq6b =1    if hid =="5211452117002" & s1aq1==46
replace s1aq8a =.   if hid =="5211452117002" & s1aq1==46
replace s1aq8b =.   if hid =="5211452117002" & s1aq1==46
replace s1aq7a =.   if hid =="5211452117002" & s1aq1==46
replace s1aq7b =.   if hid =="5211452117002" & s1aq1==46
****************CHIKEN WINGS
********************************5111851133001
replace s1aq5 =.     if hid =="5111851133001" & s1aq1==47
replace s1aq3b =1    if hid =="5111851133001" & s1aq1==47
replace s1aq6b =1    if hid =="5111851133001" & s1aq1==47
replace s1aq4b =1    if hid =="5111851133001" & s1aq1==47
replace s1aq6a =3   if hid =="5111851133001" & s1aq1==47
replace s1aq8a =.   if hid =="5111851133001" & s1aq1==47
replace s1aq8b =.    if hid =="5111851133001" & s1aq1==47


************************************************
***********BEEF WITHOUT BONES
************5410454119003
replace s1aq6a =1    if hid =="5410454119003" & s1aq1==49
replace s1aq4a =1    if hid =="5410454119003" & s1aq1==49
replace s1aq3b =1    if hid =="5410454119003" & s1aq1==49

*************5122851222006 // check for price at 150
replace s1aq7a =.    if hid =="5122851222006" & s1aq1==49
replace s1aq7b =.    if hid =="5122851222006" & s1aq1==49
replace s1aq3b =1    if hid =="5122851222006" & s1aq1==49
 
***************5530155347009 // check for price at 125
replace s1aq3a =1    if hid =="5530155347009" & s1aq1==49
replace s1aq3b =1    if hid =="5530155347009" & s1aq1==49 

*************************************
************corned beef
*******5011850150001
replace s1aq6a =2    if hid =="5011850150001" & s1aq1==56
replace s1aq4a =2    if hid =="5011850150001" & s1aq1==56
replace s1aq3b =12    if hid =="5011850150001" & s1aq1==56

*******5122251233006
replace s1aq6a =3    if hid =="5122251233006" & s1aq1==56
replace s1aq6b =12    if hid =="5122251233006" & s1aq1==56
replace s1aq3b =12   if hid =="5122251233006" & s1aq1==56

*****************************************
*************SNAILS           
*******5420654212009
replace s1aq6a =3   if hid =="5420654212009" & s1aq1==82
replace s1aq6b =6   if hid =="5420654212009" & s1aq1==82
replace s1aq3b =6   if hid =="5420654212009" & s1aq1==82

************5622156219015
replace s1aq3a =2   if hid =="5622156219015" & s1aq1==82
replace s1aq3b =6   if hid =="5622156219015" & s1aq1==82

*************5420554201008, 5221052226015
replace s1aq6a =2   if (hid =="5420554201008" |hid =="5221052226015") & s1aq1==82
replace s1aq4a =2   if (hid =="5420554201008" |hid =="5221052226015") & s1aq1==82
replace s1aq3b =6   if (hid =="5420554201008" |hid =="5221052226015") & s1aq1==82
replace s1aq3a =2   if hid =="5420554201008" & s1aq1==82

*************5310553123010
replace s1aq6b =6   if hid =="5310553123010" & s1aq1==82
replace s1aq4a =6   if hid =="5310553123010" & s1aq1==82
replace s1aq3b =6   if hid =="5310553123010" & s1aq1==82
replace s1aq3a =6   if hid =="5310553123010" & s1aq1==82

*************5122251233010
replace s1aq6a =1   if hid =="5122251233010" & s1aq1==82
replace s1aq6b =6   if hid =="5122251233010" & s1aq1==82
replace s1aq4a =1   if hid =="5122251233010" & s1aq1==82
replace s1aq4b =6   if hid =="5122251233010" & s1aq1==82
replace s1aq3b =6   if hid =="5122251233010" & s1aq1==82

*************5420554201009
replace s1aq6a =4   if hid =="5420554201009" & s1aq1==82
replace s1aq6b =6   if hid =="5420554201009" & s1aq1==82
replace s1aq4a =4   if hid =="5420554201009" & s1aq1==82
replace s1aq4b =6   if hid =="5420554201009" & s1aq1==82
replace s1aq3b =6   if hid =="5420554201009" & s1aq1==82
replace s1aq5  =.   if hid =="5420554201009" & s1aq1==82

***********************************
***********SHRIMPS
**********5310253111007
replace s1aq6a =2    if hid =="5310253111007" & s1aq1==80
replace s1aq6b =11   if hid =="5310253111007" & s1aq1==80
replace s1aq4b =11   if hid =="5310253111007" & s1aq1==80
replace s1aq3b =11   if hid =="5310253111007" & s1aq1==80

*********************5013050125008
replace s1aq3a =3    if hid =="5013050125008" & s1aq1==80
replace s1aq3b =11   if hid =="5013050125008" & s1aq1==80

**********5013050117011
replace s1aq8b =1   if hid =="5013050117011" & s1aq1==80
replace s1aq3b =1   if hid =="5013050117011" & s1aq1==80
replace s1aq3a =tot_consumed  if hid =="5013050117011" & s1aq1==80

*********************5120151204005
replace s1aq6a =1   if hid =="5120151204005" & s1aq1==80
replace s1aq6b =1   if hid =="5120151204005" & s1aq1==80
replace s1aq3b =1   if hid =="5120151204005" & s1aq1==80
**********************************
***************SARDINE TIN IN VEG. OIL
***************5622156219005
replace s1aq6a =2   if hid =="5622156219005" & s1aq1==74
replace s1aq4a =2   if hid =="5622156219005" & s1aq1==74
replace s1aq3b =12  if hid =="5622156219005" & s1aq1==74
replace s1aq5 =.    if hid =="5622156219005" & s1aq1==74  // plz check amt=25

******************5020150236005
replace s1aq4a =1   if hid =="5020150236005" & s1aq1==74
replace s1aq3b =12  if hid =="5020150236005" & s1aq1==74
replace s1aq3a =1   if hid =="5020150236005" & s1aq1==74

**************************
***********Other fish preparation please specify
************5420754218010
replace s1aq3a =tot_consumed  if hid =="5420754218010" & s1aq1==78

********************SMOKED FISH 
****************5420554201007 , 5530155356004

replace s1aq3a =2   if (hid =="5420554201007" |hid =="5530155356004") & s1aq1==71
replace s1aq4a =2   if (hid =="5420554201007" |hid =="5530155356004") & s1aq1==71
replace s1aq3b =11    if (hid =="5420554201007" |hid =="5530155356004") & s1aq1==71
replace s1aq6a =2   if (hid =="5420554201007" |hid =="5530155356004") & s1aq1==71
replace s1aq4b =11   if (hid =="5420554201007" |hid =="5530155356004") & s1aq1==71
replace s1aq3b =11    if (hid =="5420554201007" |hid =="5530155356004") & s1aq1==71

***********************5420554201009
replace s1aq6a =3   if hid =="5420554201009" & s1aq1==71
replace s1aq4a =3   if hid =="5420554201009" & s1aq1==71
replace s1aq3b =11    if hid =="5420554201009" & s1aq1==71
replace s1aq3a =3  if hid =="5420554201009" & s1aq1==71

*************************************
************CRABS
*************6320763212009

***********************************
**************CONDENSED MILK
*********** 5122551211003  , 5420754218010
replace s1aq4a =1   if hid =="5420754218010"  & s1aq1==93
replace s1aq3a =1   if (hid =="5122551211003" |hid =="5420754218010") & s1aq1==93
replace s1aq3b =12  if (hid =="5122551211003" |hid == "5410454119006"|hid =="5420754218010") & s1aq1==93
 ******************5410454119006
replace s1aq3a =tot_consumed   if hid == "5410454119006" & s1aq1==93
replace s1aq3b =12  if hid == "5410454119006" & s1aq1==93


**************************************
*************Sorrel(bisab)
foreach var in  s1aq3b s1aq4b s1aq6b s1aq7b s1aq8b {
replace `var' = 11 if (`var'==0|`var'==3|`var'==4 | `var'==5|`var'==6) & s1aq1 == 146
} 

************5310953113014
replace s1aq6a =7   if hid =="5310953113014" & s1aq1==146

*************6320363219003
replace s1aq4a =.   if hid =="6320363219003" & s1aq1==146
replace s1aq4b =.   if hid =="6320363219003" & s1aq1==146
replace s1aq6a =.   if hid =="6320363219003" & s1aq1==146
replace s1aq6b =.   if hid =="6320363219003" & s1aq1==146

*********6021160215010, 5310253107004, 5620656225008 
replace s1aq4a =.   if (hid =="6021160215010"|hid=="5310253107004"|hid=="5620656225008") & s1aq1==146
replace s1aq4b =.   if (hid =="6021160215010"|hid=="5310253107004"|hid=="5620656225008") & s1aq1==146
replace s1aq3a =tot_consumed if (hid =="6021160215010"|hid=="5310253107004"|hid=="5620656225008") & s1aq1==146

*****************5420754215009
replace s1aq6a =4   if hid =="5420754215009" & s1aq1==146
replace s1aq6b =11  if hid =="5420754215009" & s1aq1==146

*****************5420554201007
replace s1aq4a =6   if hid =="5420554201007" & s1aq1==146
replace s1aq6a =6   if hid =="5420554201007" & s1aq1==146 // verify price at D12

************************5530155356014
replace s1aq4a =4   if hid =="5530155356014" & s1aq1==146
replace s1aq6a =4   if hid =="5530155356014" & s1aq1==146
replace s1aq3a =4  if  hid == "5530155356014" & s1aq1==146

****************6110361117011, 5210452105011, 4520145212006, 5110351125013, 5221652215006, 5211452119011
replace s1aq3a =tot_consumed if(hid =="6110361117011"|hid =="5210452105011"|hid=="4520145212006"|hid=="5110351125013"|hid=="5221652215006"|hid=="5211452119011"|hid=="5411654117010") & s1aq1==146

****************5530155356006   
replace s1aq4a =7   if hid =="5530155356006" & s1aq1==146
replace s1aq6a =7   if hid =="5530155356006" & s1aq1==146
replace s1aq3a =7   if hid =="5530155356006" & s1aq1==146

 ******************5320953205005, 5320653207005 ,6213262115014, 5420754215012// plz check the  note
replace s1aq4a =.   if (hid =="5320953205005"|hid=="5320653207005"|hid=="6213262115014"|hid=="5420754215012")  & s1aq1==146
replace s1aq4b =.   if (hid =="5320953205005"|hid=="5320653207005"|hid=="6213262115014"|hid=="5420754215012")  & s1aq1==146
replace s1aq8a =5   if (hid =="5320953205005"|hid=="5320653207005"|hid=="5420754215012")  & s1aq1==146 // could change to 7a too 
replace s1aq8b =11  if (hid =="5320953205005"|hid=="5320653207005"|hid=="6213262115014"|hid=="5420754215012")  & s1aq1==146
replace s1aq8a =4   if hid=="6213262115014"  & s1aq1==146 // could change to 7a too 

*/
**********************5620656225003 // only s1aq3 was recorded 0 for the 4 and the rest empty

**********************5211152102009
replace s1aq4a =3   if hid =="5211152102009" & s1aq1==146
replace s1aq6a =3   if hid =="5211152102009" & s1aq1==146

***********************5211152102003
replace s1aq4a =2   if hid =="5211152102003" & s1aq1==146
replace s1aq3a =tot_consumed   if hid =="5211152102003" & s1aq1==146

**************************5530155331012, 4511945122006
replace s1aq4a =1   if (hid =="5530155331012"|hid=="4511945122006") & s1aq1==146
replace s1aq6a =1   if (hid =="5530155331012"|hid=="4511945122006") & s1aq1==146
replace s1aq3a =1   if (hid =="5530155331012"|hid=="4511945122006") & s1aq1==146

************************6313963107006
replace s1aq4a =.   if hid =="5530155331012" & s1aq1==146
replace s1aq4b =.   if hid =="5530155331012" & s1aq1==146
replace s1aq7a =2   if hid =="5530155331012" & s1aq1==146

************************6113761127003
replace s1aq6a =4   if hid =="6113761127003" & s1aq1==146

************************6022460203008
replace s1aq6a =7   if hid =="6022460203008" & s1aq1==146

***********************6322163222012 
replace s1aq4a =4   if hid =="6322163222012" & s1aq1==146
replace s1aq3a =tot_consumed   if hid =="6322163222012" & s1aq1==146

************************6313963107006
replace s1aq4a =5   if hid =="6313963107006" & s1aq1==146
replace s1aq6a =5   if hid =="6313963107006" & s1aq1==146
replace s1aq7a =1   if hid =="6313963107006" & s1aq1==146
replace s1aq3a =1   if hid =="6313963107006" & s1aq1==146

************************5530155331012
replace s1aq7a =1   if hid =="5530155331012" & s1aq1==146

************************ 6022460203008
replace s1aq3a =7   if hid =="6022460203008" & s1aq1==146

************************6314263131004
replace s1aq4a =5   if hid =="6314263131004" & s1aq1==146
replace s1aq6a =5   if hid =="6314263131004" & s1aq1==146
replace s1aq7a =1   if hid =="6314263131004" & s1aq1==146
replace s1aq3a =6   if hid =="6314263131004" & s1aq1==146

************************ 5610956110001
replace s1aq7a =4   if hid =="5610956110001" & s1aq1==146

************************6323963202009
replace s1aq4a =.   if hid =="6323963202009" & s1aq1==146
replace s1aq4b =.   if hid =="6323963202009" & s1aq1==146
replace s1aq7a =5   if hid =="6323963202009" & s1aq1==146

****************5530155311003   
replace s1aq4a =2   if hid =="5530155311003" & s1aq1==146
replace s1aq6a =2   if hid =="5530155311003" & s1aq1==146
replace s1aq3a =2   if hid =="5530155311003" & s1aq1==146

*********************5620656225003, 
replace s1aq6a =1   if hid =="5620656225003" & s1aq1==146

******************5530155331012
replace s1aq6a =5   if hid =="5530155331012" & s1aq1==146
replace s1aq5  =.   if hid =="5530155331012" & s1aq1==146

replace s1aq3a =s1aq6a  if hid =="5620656225003"|hid=="5530155331012"|hid=="5121651214004"|hid=="6313963107006" & s1aq1==146
replace s1aq3b =11   if hid =="5620656225003"|hid=="5530155331012"|hid=="5121651214004"|hid=="6313963107006"  & s1aq1==146
replace s1aq4a =.   if hid =="5620656225003"|hid=="5530155331012"|hid=="5121651214004"|hid=="6313963107006"  & s1aq1==146
replace s1aq4b =.  if hid =="5620656225003"|hid=="5530155331012"|hid=="5121651214004"|hid=="6313963107006" & s1aq1==146
replace s1aq6a =.   if hid =="5620656225003"|hid=="5530155331012"|hid=="5121651214004"|hid=="6313963107006"  & s1aq1==146
replace s1aq6b =.   if hid =="5620656225003"|hid=="5530155331012"|hid=="5121651214004"|hid=="6313963107006"  & s1aq1==146
replace s1aq7a =s1aq6a   if hid =="5620656225003"|hid=="5530155331012"|hid=="5121651214004"|hid=="6313963107006"  & s1aq1==146
replace s1aq7b =s1aq6a   if hid =="5620656225003"|hid=="5530155331012"|hid=="5121651214004"|hid=="6313963107006"  & s1aq1==146

*********************************5121651214004","5530155331012","6313963107006","5620656225003"
replace s1aq5 = 200000 if(hid =="5121651214004"|hid=="5530155331012"| hid =="6313963107006"|hid=="5620656225003") & s1aq1==146 

drop issue
gen issue = 3  if s1aq1  == 146 & s1aq5==200000
replace s1aq3b = 11 if issue == 3
replace s1aq7a = s1aq3a if issue == 3
replace s1aq7b = 11 if issue == 3
replace s1aq4a = . if issue == 3
replace s1aq4b = . if issue == 3
replace s1aq6a = . if issue == 3
replace s1aq6b = . if issue == 3
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3
replace s1aq5 = . if issue == 3

**************************************************************************************
*******************PARSLEY
***************5420254209011
replace s1aq4a =3   if hid =="5420254209011" & s1aq1==147
replace s1aq6a =3   if hid =="5420254209011" & s1aq1==147
replace s1aq6b =6   if hid =="5420254209011" & s1aq1==147


******************************5420554203013
replace s1aq7a =.   if hid =="5420554203013" & s1aq1==147
replace s1aq7b =.   if hid =="5420554203013" & s1aq1==147

******************************5222252205007
replace s1aq6a =2   if hid =="5222252205007" & s1aq1==147
replace s1aq6b =6   if hid =="5222252205007" & s1aq1==147
replace s1aq4a =2   if hid =="5222252205007" & s1aq1==147

******************************5321053215016
replace s1aq3a =4   if hid =="5321053215016" & s1aq1==147
replace s1aq6a =4   if hid =="5321053215016" & s1aq1==147
replace s1aq4a =4   if hid =="5321053215016" & s1aq1==147

******************************5530155356004
replace s1aq3a =3   if hid =="5530155356004" & s1aq1==147
replace s1aq6a =3   if hid =="5530155356004" & s1aq1==147
replace s1aq4a =3   if hid =="5530155356004" & s1aq1==147
******************************5530155356006
replace s1aq3a =6   if hid =="5530155356006" & s1aq1==147
replace s1aq6a =6   if hid =="5530155356006" & s1aq1==147
replace s1aq4a =6   if hid =="5530155356006" & s1aq1==147

foreach var in  s1aq3b s1aq4b s1aq6b s1aq7b s1aq8b {
replace `var' = 6 if (`var'==0|`var'==11 | `var'==2) & s1aq1 == 147
} 

*****************************************************
*************POTATO LEAVES
**********5530155331011

******************6310563139001
replace s1aq4a =3   if hid =="6310563139001" & s1aq1==150
replace s1aq3a =3   if hid =="6310563139001" & s1aq1==150  //check msment
replace s1aq6b =11  if hid =="6310563139001" & s1aq1==150
replace s1aq3b =11  if hid =="6310563139001" & s1aq1==150 
replace s1aq4b =11  if hid =="6310563139001" & s1aq1==150 

********************5120151204010
replace s1aq7a =.   if hid =="5120151204010" & s1aq1==150
replace s1aq7b =.   if hid =="5120151204010" & s1aq1==150
replace s1aq3b =6   if hid =="5120151204010" & s1aq1==150
replace s1aq4b =6   if hid =="5120151204010" & s1aq1==150
replace s1aq6b =6   if hid =="5120151204010" & s1aq1==150

***************5122851222008
replace s1aq4a =.   if hid =="5122851222008" & s1aq1==150
replace s1aq4b =.   if hid =="5122851222008" & s1aq1==150
replace s1aq3a =4  if hid  =="5122851222008" & s1aq1==150 

******************5530155331011
replace s1aq6a =3   if hid =="5530155331011" & s1aq1==150
replace s1aq6b =11  if hid =="5530155331011" & s1aq1==150
replace s1aq3b =11  if hid =="5530155331011" & s1aq1==150 
replace s1aq7a =.  if hid =="5530155331011" & s1aq1==150
replace s1aq7b =.  if hid =="5530155331011" & s1aq1==150 
replace s1aq5 = 30  if hid =="5530155331011" & s1aq1==150 


*********************5110551105005, 5530155311003
replace s1aq3a =4  if hid  =="5530155311003" & s1aq1==150 
replace s1aq3b =6  if (hid  =="5110551105005" |hid  =="5530155311003") & s1aq1==150 
replace s1aq4a =4  if (hid  =="5110551105005" |hid  =="5530155311003") & s1aq1==150  
replace s1aq4b =6  if (hid  =="5110551105005" |hid  =="5530155311003") & s1aq1==150  
replace s1aq6a =4  if (hid  =="5110551105005" |hid  =="5530155311003") & s1aq1==150  
replace s1aq6b =6  if (hid  =="5110551105005" |hid  =="5530155311003") & s1aq1==150  

*********************************************
********************SMALL PEPPER-FRESH
***********5530155339008
replace s1aq3a =1   if hid  =="5530155339008" & s1aq1==152 
replace s1aq3b =11  if hid  =="5530155339008" & s1aq1==152 

***********6311963130009, 5120651225006, 5220752220001,5123051208005
replace s1aq4a =.   if (hid  =="6311963130009"|hid=="5120651225006"|hid=="5220752220001"|hid=="5123051208005") & s1aq1==152  
replace s1aq4b =.   if (hid  =="6311963130009"|hid=="5120651225006"|hid=="5220752220001"|hid=="5123051208005") & s1aq1==152 
replace s1aq6a =.   if (hid  =="6311963130009"|hid=="5120651225006"|hid=="5220752220001"|hid=="5123051208005") & s1aq1==152  
replace s1aq6b =.   if (hid  =="6311963130009"|hid=="5120651225006"|hid=="5220752220001"|hid=="5123051208005") & s1aq1==152 
replace s1aq3b =11  if (hid  =="6311963130009"|hid=="5120651225006"|hid=="5220752220001"|hid=="5123051208005") & s1aq1==152 
replace s1aq3a =2   if (hid  =="5120651225006"|hid=="5220752220001" |hid=="5123051208005")& s1aq1==152  
replace s1aq7b =11   if hid  =="5220752220001" & s1aq1==152
replace s1aq8a =.    if hid  =="5220752220001" & s1aq1==152 
replace s1aq8b =.    if hid  =="5220752220001" & s1aq1==152

********************5020750230010
replace s1aq6a =21   if hid  =="5020750230010" & s1aq1==152  
replace s1aq6b =11   if hid  =="5020750230010" & s1aq1==152 
replace s1aq3b =11   if hid  =="5020750230010" & s1aq1==152
 
***********5420554201009, 5420554201007, "5530155311003"
replace s1aq4a =2   if (hid  =="5420554201009"|hid=="5420554201007"|hid=="5530155311003") & s1aq1==152  
replace s1aq6a =2   if (hid  =="5420554201009"|hid=="5420554201007"|hid=="5530155311003") & s1aq1==152  
replace s1aq3b =11  if (hid  =="5420554201009"|hid=="5420554201007"|hid=="5530155311003") & s1aq1==152 
replace s1aq3a =2   if (hid  =="5420554201009"|hid=="5420554201007"|hid=="5530155311003") & s1aq1==152  

********************5310953113006
replace s1aq3a =7   if hid  =="5310953113006" & s1aq1==152  

********************5310953114009
replace s1aq4a =4   if hid  =="5310953114009" & s1aq1==152  
replace s1aq3a =4   if hid  =="5310953114009" & s1aq1==152 
replace s1aq3b =11  if hid  =="5310953114009" & s1aq1==152

*************6314263131010, 5210652125001
replace s1aq4a =1   if hid  =="6314263131010" |hid =="5210652125001" & s1aq1==152
replace s1aq4b =8   if hid  =="6314263131010"|hid =="5210652125001" & s1aq1==152  
replace s1aq6a =1   if hid  =="6314263131010"|hid =="5210652125001" & s1aq1==152
replace s1aq6b =8   if hid  =="6314263131010"|hid =="5210652125001" & s1aq1==152  
replace s1aq3a =1   if hid  =="6314263131010" |hid =="5210652125001"& s1aq1==152
replace s1aq3b =8   if hid  =="6314263131010" |hid =="5210652125001"& s1aq1==152

**********************6021160215005
replace s1aq4a =1   if hid  =="6021160215005" & s1aq1==152 
replace s1aq6a =1   if hid  =="6021160215005" & s1aq1==152  
replace s1aq3a =1   if hid  =="6021160215005" & s1aq1==152 
replace s1aq3b =7   if hid  =="6021160215005" & s1aq1==152

***********************4520745203007 // please confirm amt at 20 per small tomato cup
replace s1aq6a =1   if hid  =="4520745203007" & s1aq1==152 
replace s1aq6b =7   if hid  =="4520745203007" & s1aq1==152 
replace s1aq3b =7   if hid  =="4520745203007" & s1aq1==152

*****************6312063123003
replace s1aq6a =1   if hid  =="6312063123003" & s1aq1==152 
replace s1aq6b =8   if hid  =="6312063123003" & s1aq1==152 
replace s1aq3b =8   if hid  =="6312063123003" & s1aq1==152
**********************5530155311001, 5530155356006, 
replace s1aq4a =3   if (hid  =="5530155311001"|hid =="5530155356006") & s1aq1==152  
replace s1aq6a =3   if (hid  =="5530155311001"|hid =="5530155356006") & s1aq1==152  
replace s1aq3a =3   if (hid  =="5530155311001"|hid =="5530155356006") & s1aq1==152
replace s1aq3b =11  if (hid  =="5530155311001"|hid =="5530155356006") & s1aq1==152
**********************5320253210014
replace s1aq4a =5   if hid  =="5320253210014" & s1aq1==152  
replace s1aq6a =5   if hid  =="5320253210014" & s1aq1==152 
replace s1aq6b =11   if hid  =="5320253210014" & s1aq1==152
replace s1aq3b =11   if hid  =="5320253210014" & s1aq1==152

**********************5111951130006,5530155335014
replace s1aq4a =1   if (hid  =="5111951130006"|hid=="5530155335014") & s1aq1==152  
replace s1aq6a =1   if (hid  =="5111951130006"|hid=="5530155335014") & s1aq1==152 
replace s1aq6b =11  if (hid  =="5111951130006"|hid=="5530155335014") & s1aq1==152
replace s1aq3b =11  if (hid  =="5111951130006"|hid=="5530155335014") & s1aq1==152
replace s1aq3a =1   if (hid  =="5111951130006"|hid=="5530155335014") & s1aq1==152 
 replace s1aq5 =.   if  hid  =="5530155335014" & s1aq1==152  // please check amount
                                 

****************5530155356009
replace s1aq6a =7   if hid  =="5530155356009" & s1aq1==152  
replace s1aq3b =11  if hid  =="5530155356009" & s1aq1==152 

*************5121651214008
replace s1aq7a =.   if hid  =="5121651214008" & s1aq1==152 
replace s1aq7b =.   if hid  =="5121651214008" & s1aq1==152  
replace s1aq3b =11  if hid  =="5121651214008" & s1aq1==152 
******************4510745106011
replace s1aq6a =4    if hid  =="4510745106011" & s1aq1==152 
replace s1aq6b =11   if hid  =="4510745106011" & s1aq1==152
replace s1aq3b =11   if hid  =="4510745106011" & s1aq1==152

**********************5530155321007
replace s1aq4a =5   if hid  =="5530155321007" & s1aq1==152  
replace s1aq3a =5   if hid  =="5530155321007" & s1aq1==152 
replace s1aq3b =11  if hid  =="5530155321007" & s1aq1==152
**************5610656115005
replace s1aq4a =.   if hid  =="5610656115005" & s1aq1==152 
replace s1aq4b =.   if hid  =="5610656115005" & s1aq1==152  
replace s1aq7a =4   if hid  =="5610656115005" & s1aq1==152 
replace s1aq7b =11  if hid  =="5610656115005" & s1aq1==152  
replace s1aq3b =11  if hid  =="5610656115005" & s1aq1==152 

**************6211662120003
replace s1aq8a =.   if hid  =="6211662120003" & s1aq1==152 
replace s1aq8b =.   if hid  =="6211662120003" & s1aq1==152  
replace s1aq3b =11  if hid  =="6211662120003" & s1aq1==152 

**************5221652215006
replace s1aq4a =.   if hid  =="5221652215006" & s1aq1==152 
replace s1aq4b =.   if hid  =="5221652215006" & s1aq1==152  
replace s1aq7a =2   if hid  =="5221652215006" & s1aq1==152 
replace s1aq7b =11  if hid  =="5221652215006" & s1aq1==152  
replace s1aq3b =11  if hid  =="5221652215006" & s1aq1==152 

********************5222352218004, 6110361117001, 5620156230004, 5310253103001
replace s1aq6a =2    if (hid  =="5222352218004"|hid=="6110361117001"|hid=="5620156230004"|hid=="5310253103001") & s1aq1==152  
replace s1aq6b =11   if (hid  =="5222352218004"|hid=="6110361117001"|hid=="5620156230004"|hid=="5310253103001") & s1aq1==152 
replace s1aq4a =2    if (hid  =="5222352218004"|hid=="6110361117001"|hid=="5620156230004"|hid=="5310253103001")& s1aq1==152  
replace s1aq4b =11   if (hid  =="5222352218004"|hid=="6110361117001"|hid=="5620156230004"|hid=="5310253103001") & s1aq1==152 
replace s1aq3b =11   if (hid  =="5222352218004"|hid=="6110361117001"|hid=="5620156230004"|hid=="5310253103001") & s1aq1==152
replace s1aq3a =2    if (hid  =="5222352218004"|hid=="6110361117001"|hid=="5620156230004"|hid=="5310253103001") & s1aq1==152  
replace s1aq5 =.     if (hid  =="5222352218004"|hid=="6110361117001"|hid=="5620156230004"|hid=="5310253103001") & s1aq1==152   // please check amount

*********************5023050213001
replace s1aq4a =1   if hid  =="5023050213001" & s1aq1==152 
replace s1aq4b =11  if hid  =="5023050213001" & s1aq1==152  
replace s1aq6a =1   if hid  =="5023050213001" & s1aq1==152 
replace s1aq6b =11  if hid  =="5023050213001" & s1aq1==152  
replace s1aq3b =11  if hid  =="5023050213001" & s1aq1==152 
replace s1aq5 =5    if hid  =="5023050213001" & s1aq1==152 
*************5542255410007
replace s1aq3a =7   if hid  =="5542255410007" & s1aq1==152 
replace s1aq3b =11  if hid  =="5542255410007" & s1aq1==152

*********************5110151135013
replace s1aq4a =3   if hid  =="5110151135013" & s1aq1==152  
replace s1aq6a =3   if hid  =="5110151135013" & s1aq1==152 
replace s1aq3b =11  if hid  =="5110151135013" & s1aq1==152  

*********************5542255410010
replace s1aq4a =4   if hid  =="5542255410010" & s1aq1==152  
replace s1aq3a =4   if hid  =="5542255410010" & s1aq1==152 
replace s1aq3b =11  if hid  =="5542255410010" & s1aq1==152  
*********************5221652215005
replace s1aq4a =4   if hid  =="5221652215005" & s1aq1==152  
replace s1aq6a =4   if hid  =="5221652215005" & s1aq1==152 
replace s1aq3a =4   if hid  =="5221652215005" & s1aq1==152 
replace s1aq3b =11  if hid  =="5221652215005" & s1aq1==152  

*********************6022360208007
replace s1aq7a =.   if hid  =="6022360208007" & s1aq1==152  
replace s1aq7b =.   if hid  =="6022360208007" & s1aq1==152 
replace s1aq8a =.   if hid  =="6022360208007" & s1aq1==152  
replace s1aq8b =.   if hid  =="6022360208007" & s1aq1==152 
replace s1aq3b =11  if hid  =="6022360208007" & s1aq1==152  

*********************5420254209010, 5530155356004, 5530155356014
replace s1aq6a =3   if hid  =="5530155356004"|hid== "5530155356014" & s1aq1==152 
replace s1aq4a =3   if (hid  =="5420254209010"|hid=="5530155356004"|hid== "5530155356014") & s1aq1==152  
replace s1aq3a =3   if (hid  =="5420254209010"|hid=="5530155356004"|hid== "5530155356014") & s1aq1==152 
replace s1aq3b =11  if (hid  =="5420254209010"|hid=="5530155356004"|hid== "5530155356014") & s1aq1==152  

********************5320653207014
replace s1aq3a =5   if hid  =="5320653207014" & s1aq1==152 
replace s1aq3b =11  if hid  =="5320653207014" & s1aq1==152  

**********************5222152223008
replace s1aq4b =6   if hid  =="5222152223008" & s1aq1==152 
replace s1aq6a =3   if hid  =="5222152223008" & s1aq1==152  
replace s1aq6b =6   if hid  =="5222152223008" & s1aq1==152 
replace s1aq3b =6   if hid  =="5222152223008" & s1aq1==152  
*********************5111451111003
replace s1aq4a =10   if hid  =="5111451111003" & s1aq1==152  
replace s1aq6a =10   if hid  =="5111451111003" & s1aq1==152 
replace s1aq7b =.   if hid  =="5111451111003" & s1aq1==152 
replace s1aq7a =.   if hid  =="5111451111003" & s1aq1==152 
replace s1aq3b =11   if hid  =="5111451111003" & s1aq1==152 
replace s1aq3a =10   if hid  =="5111451111003" & s1aq1==152 
*************************5530155318016
replace s1aq6a =3    if hid  =="5530155318016" & s1aq1==152  
replace s1aq6b =11   if hid  =="5530155318016" & s1aq1==152 
replace s1aq3b =11   if hid  =="5530155318016" & s1aq1==152  

************************5222152223012
replace s1aq8a =.   if hid  =="5222152223012" & s1aq1==152  
replace s1aq8b =.   if hid  =="5222152223012" & s1aq1==152 
replace s1aq3b =11  if hid  =="5222152223012" & s1aq1==152  

*************************5621256211001
replace s1aq6a =7    if hid  =="5621256211001" & s1aq1==152  
replace s1aq6b =6    if hid  =="5621256211001" & s1aq1==152 
replace s1aq4a =7    if hid  =="5621256211001" & s1aq1==152  
replace s1aq4b =6    if hid  =="5621256211001" & s1aq1==152  
replace s1aq3b =6    if hid  =="5621256211001" & s1aq1==152  

********************5420754218015
replace s1aq3a =3   if hid  =="5420754218015" & s1aq1==152 
replace s1aq3b =6   if hid  =="5420754218015" & s1aq1==152  

*************************5310253111007
replace s1aq6a =1    if hid  =="5310253111007" & s1aq1==152  
replace s1aq6b =11    if hid  =="5310253111007" & s1aq1==152 
replace s1aq4a =1    if hid  =="5310253111007" & s1aq1==152  
replace s1aq3b =11   if hid  =="5310253111007" & s1aq1==152  
replace s1aq3a =1    if hid  =="5310253111007" & s1aq1==152  
*************************5610556118004
replace s1aq6b =6    if hid =="5610556118004" & s1aq1==152 
replace s1aq4b =6    if hid  =="5610556118004" & s1aq1==152  
replace s1aq3b =6    if hid  =="5610556118004" & s1aq1==152  
replace s1aq3a =12   if hid  =="5610556118004" & s1aq1==152  

**********************, 5610956110010
replace s1aq5 =.    if hid =="5610956110010" & s1aq1==152 


replace s1aq3a =3    if hid =="5011350157015" & s1aq1==152 
replace s1aq6a =3    if hid  =="5011350157015" & s1aq1==152  
replace s1aq6b =11    if hid =="5011350157015" & s1aq1==152 
replace s1aq4a =3    if hid  =="5011350157015" & s1aq1==152  
replace s1aq4b =11   if hid  =="5011350157015" & s1aq1==152  
replace s1aq3b =11   if hid  =="5011350157015" & s1aq1==152  

********************5010550185011,5310953113001, 5610956110010, 6111261113003
replace s1aq7a =7    if (hid  =="5010550185011"|hid=="5310953113001"|hid=="5610956110010"|hid=="6111261113003") & s1aq1==152  
replace s1aq7b =11    if (hid  =="5010550185011"|hid=="5310953113001"|hid=="5610956110010" |hid=="6111261113003") & s1aq1==152
replace s1aq4a =.    if (hid  =="5010550185011"|hid=="5310953113001"|hid=="5610956110010" |hid=="6111261113003") & s1aq1==152  
replace s1aq4b =.   if (hid  =="5010550185011"|hid=="5310953113001"|hid=="5610956110010" |hid=="6111261113003") & s1aq1==152  
replace s1aq3b =11   if (hid  =="5010550185011"|hid=="5310953113001"|hid=="5610956110010" |hid=="6111261113003") & s1aq1==152  
replace s1aq8a =.    if (hid  =="5310953113001"|hid=="6111261113003") & s1aq1==152  
replace s1aq8b =.    if (hid  =="5310953113001"|hid=="6111261113003") & s1aq1==152  
replace s1aq6a =.    if (hid  =="5010550185011"|hid=="5310953113001"|hid=="5610956110010" |hid=="6111261113003") & s1aq1==152  
replace s1aq6b =.   if (hid  =="5010550185011"|hid=="5310953113001"|hid=="5610956110010" |hid=="6111261113003") & s1aq1==152  

replace s1aq3a =5    if hid =="6311363126012" & s1aq1==152 
replace s1aq6a =5    if hid  =="6311363126012" & s1aq1==152  
replace s1aq6b =11    if hid =="6311363126012" & s1aq1==152 
replace s1aq4a =5    if hid  =="6311363126012" & s1aq1==152  
replace s1aq4b =11   if hid  =="6311363126012" & s1aq1==152  
replace s1aq3b =11   if hid  =="6311363126012" & s1aq1==152  

********************************6313963107013
replace s1aq3a =5     if hid =="6313963107013" & s1aq1==152  
replace s1aq3b =11    if hid =="6313963107013" & s1aq1==152 
replace s1aq5 =.      if hid =="6313963107013" & s1aq1==152 


********************************************************************************************EGGS
****************************fixing a general issue for 102-Eggs 
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 102 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

drop issue
gen issue = 1 if s1aq1  == 102 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq3b = 6 if s1aq3b == 0 & issue == 1
*replace s1aq4a = s1aq3a if issue == 1
*replace s1aq4b = s1aq3b if issue == 1

replace s1aq8a = s1aq3a if issue == 1
replace s1aq8b = s1aq3b if issue == 1

drop issue
****************************fixing a specific issue for 102-Eggs 
replace s1aq3a = s1aq6a if  hid  =="5211652115014"|hid=="5310253102011"|hid=="5320953203007"|hid=="5420754218010" & s1aq1==102  
replace s1aq3b = 6 if  hid  =="5211652115014"|hid=="5310253102011"|hid=="5320953203007"|hid=="5420754218010" & s1aq1==102  

gen issue = 1 if s1aq1  == 102 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a !=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq4a = s1aq3a if (hid =="5310253111010"|hid =="5530155356006"|hid =="5420554201006"|hid=="5530155315004"|hid=="5610956110001"|hid=="5420754218012") & s1aq1==102
replace s1aq6a = s1aq3a if (hid =="5310253111010"|hid =="5530155356006"|hid =="5420554201006"|hid=="5530155315004"|hid=="5610956110001"|hid=="5420754218012") & s1aq1==102  
replace s1aq3b = 6 if (hid =="5310253111010"|hid =="5530155356006"|hid =="5420554201006"|hid=="5530155315004"|hid=="5610956110001"|hid=="5420754218012") & s1aq1==102  


replace s1aq3a  =1 if hid  =="5310253102014"|hid=="5310253102011" & s1aq1==102
replace s1aq4a  =1 if hid  =="5310253102014"|hid=="5310253102011" & s1aq1==102
replace s1aq6a  =1 if hid  =="5310253102014" |hid=="5310253102011"& s1aq1==102
replace s1aq3b  =5 if hid  =="5310253102014"|hid=="5310253102011" & s1aq1==102
replace s1aq6b  =5 if hid  =="5310253102014" & s1aq1==102
replace s1aq4b  =5 if hid  =="5310253102014" & s1aq1==102

***************5310253111011
replace s1aq3a  =4 if hid  =="5310253111011" & s1aq1==102
replace s1aq4a  =4 if hid  =="5310253111011" & s1aq1==102
replace s1aq6a  =4 if hid  =="5310253111011" & s1aq1==102
replace s1aq3b  =6 if hid  =="5310253111011" & s1aq1==102
replace s1aq6b  =6 if hid  =="5310253111011" & s1aq1==102
replace s1aq7a  =. if hid  =="5310253111011" & s1aq1==102
replace s1aq7b  =. if hid  =="5310253111011" & s1aq1==102
replace s1aq3b  =6 if hid  =="5310253111011" & s1aq1==102

replace s1aq5 = 32 if hid  =="5310253111011" & s1aq1==102

**************5420554201007
replace s1aq3a  =2 if hid  =="5420554201007" & s1aq1==102
replace s1aq4a  =2 if hid  =="5420554201007" & s1aq1==102
replace s1aq6a  =2 if hid  =="5420554201007" & s1aq1==102
replace s1aq3b  =6 if hid  =="5420554201007" & s1aq1==102

*************** 5110551108008, 6111261113014
replace s1aq3b  =6 if hid  =="5110551108008" |hid == "6111261113014" & s1aq1==102
replace s1aq8a  =. if hid  =="5110551108008" & s1aq1==102
replace s1aq8b  =. if hid  =="5110551108008" & s1aq1==102
*********************5013050117010
replace s1aq6a  =5 if hid  =="5013050117010" & s1aq1==102
replace s1aq4a  =24 if hid  =="5013050117010" & s1aq1==102
replace s1aq4b  =6 if hid  =="5013050117010" & s1aq1==102
replace s1aq6b  =6 if hid  =="5013050117010" & s1aq1==102
replace s1aq3b  =6 if hid  =="5013050117010" & s1aq1==102

********************5420754218010
replace s1aq4a  =10 if hid  =="5420754218010" & s1aq1==102
replace s1aq4b  =6 if hid   =="5420754218010" & s1aq1==102

*********************5530155356005
replace s1aq8a  =5 if hid =="5530155356005" & s1aq1==102
replace s1aq8b  =6 if hid =="5530155356005" & s1aq1==102
replace s1aq6a  =. if hid  =="5530155356005" & s1aq1==102
replace s1aq6b  =. if hid  =="5530155356005" & s1aq1==102
replace s1aq3b  =6 if hid  =="5530155356005" & s1aq1==102

************************5420554201009
replace s1aq3a  =15 if hid  =="5420554201009" & s1aq1==102
replace s1aq4a  =15 if hid  =="5420554201009" & s1aq1==102
replace s1aq6a  =15 if hid  =="5420554201009" & s1aq1==102
replace s1aq3b  =6  if hid  =="5420554201009" & s1aq1==102

*************6111261113014
replace s1aq8a  =. if hid  =="6111261113014" & s1aq1==102
replace s1aq8b  =. if hid  =="6111261113014" & s1aq1==102

************************local eggs
**************5211652115006
replace s1aq6a  =5 if hid  =="5211652115006" & s1aq1==101
replace s1aq3b  =6  if hid =="5211652115006" & s1aq1==101

***************5310253111007
replace s1aq6a  =4 if hid  =="5310253111007" & s1aq1==101
replace s1aq3b  =6  if hid =="5310253111007" & s1aq1==101

***************6211662120010, 6020160224008
replace s1aq7b  =6 if hid  =="6211662120010" & s1aq1==101
replace s1aq4a  =.  if hid =="6211662120010" | hid =="6020160224008"& s1aq1==101
replace s1aq4b  =.  if hid =="6211662120010" | hid =="6020160224008"& s1aq1==101
replace s1aq8a  =.  if hid =="6211662120010" | hid =="6020160224008"& s1aq1==101
replace s1aq8b  =.  if hid =="6211662120010" | hid =="6020160224008"& s1aq1==101
replace s1aq3b  =6  if hid =="6211662120010" | hid =="6020160224008"& s1aq1==101
replace s1aq3a  =6  if hid =="6211662120010" & s1aq1==101

****************5120651225002
replace s1aq7a  =7 if hid  =="5120651225002" & s1aq1==101
replace s1aq3b  =6  if hid =="5120651225002" & s1aq1==101

*************************************************************103.  Other Eggs  Please Specify
*************************5610656115009
replace s1aq6b  =6  if hid =="5610656115009" & s1aq1==103

drop issue
gen issue = 3  if s1aq1  == 103 & (s1aq5==28|s1aq5==54)
replace s1aq3a = s1aq6a if issue == 3
replace s1aq3b = s1aq6b if issue == 3
replace s1aq4a = s1aq6a if issue == 3
replace s1aq4b = s1aq6b if issue == 3


*********************************************************************************************
****************CABBAGES
************************5310953114005, 5411654115012
replace s1aq6a  =7 if hid  =="5310953114005" | hid =="5411654115012" & s1aq1==143
replace s1aq6b  =6 if hid  =="5310953114005" | hid =="5411654115012" & s1aq1==143 
replace s1aq3b  =6 if hid  =="5310953114005" | hid =="5411654115012" & s1aq1==143

**********************5122551211012, 5012950107004
replace s1aq3a  =1 if hid  =="5122551211012"|hid =="5012950107004" & s1aq1==143
replace s1aq3b  =6  if hid =="5122551211012"|hid =="5012950107004" & s1aq1==143

**********************5110351125006
replace s1aq3a  =2 if hid  =="5110351125006" & s1aq1==143
replace s1aq3b  =6  if hid =="5110351125006" & s1aq1==143

drop issue
gen issue = 2 if s1aq1  == 143 & s1aq3a!=. & s1aq4a==. & s1aq5!=. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.
replace s1aq3b = 6 if s1aq3b == 0 & issue == 2
replace s1aq4a = s1aq3a if issue == 2
replace s1aq4b = s1aq3b if issue == 2
replace s1aq6a = s1aq3a if issue == 2
replace s1aq6b = s1aq3b if issue == 2
drop issue

*****************6111361111008, 5411654115014
replace s1aq6a  =7 if hid  =="6111361111008"|hid=="5411654115014" & s1aq1==143
replace s1aq3b  =6  if hid =="6111361111008"|hid=="5411654115014" & s1aq1==143
replace s1aq3a  =7  if hid=="5411654115014" & s1aq1==143

*********************5310953114005,5411654115012
replace s1aq6a  =. if hid  =="5310953114005"|hid =="5411654115012" & s1aq1==143
replace s1aq6b  =. if hid =="5310953114005"|hid =="5411654115012" & s1aq1==143
replace s1aq8b  =6 if hid  =="5310953114005"|hid =="5411654115012" & s1aq1==143
replace s1aq3a  =6  if hid =="5310953114005" |hid =="5411654115012"& s1aq1==143

*************************5511155116013
replace s1aq4b  =6 if hid  =="5511155116013" & s1aq1==143
replace s1aq6b  =6 if hid =="5511155116013" & s1aq1==143
replace s1aq3b  =6 if hid  =="5511155116013" & s1aq1==143
replace s1aq3a  =2  if hid =="5511155116013" & s1aq1==143

*************************5530155356004, 5622156219010, "5530155356006", 5530155311001
replace s1aq4a  =3 if (hid  =="5530155356004"|hid =="5530155356006"|hid=="5622156219010"|hid=="5530155311001") & s1aq1==143
replace s1aq3b  =6 if (hid  =="5530155356004"|hid =="5530155356006"|hid=="5622156219010" |hid=="5530155311001") & s1aq1==143
replace s1aq3a  =3  if (hid =="5530155356004"|hid =="5530155356006"|hid=="5622156219010"|hid=="5530155311001")  & s1aq1==143
replace s1aq6a  =3 if (hid =="5530155356006"|hid=="5622156219010"|hid=="5530155311001") & s1aq1==143

****************5211452117014
replace s1aq4a  =7 if hid  =="5211452117014" & s1aq1==143
replace s1aq4b  =6 if hid  =="5211452117014" & s1aq1==143
replace s1aq3b  =6  if hid =="5211452117014" & s1aq1==143
replace s1aq3a  =7  if hid =="5211452117014" & s1aq1==143

********************85321053215016
replace s1aq4b  =6 if hid  =="5321053215016" & s1aq1==143
replace s1aq6a  =5 if hid  =="5321053215016" & s1aq1==143
replace s1aq6b  =6 if hid  =="5321053215016" & s1aq1==143
replace s1aq3b  =5  if hid =="5321053215016" & s1aq1==143
replace s1aq5   =.  if hid =="5321053215016" & s1aq1==143 // verify amount

*************************5420554201007
replace s1aq4a  =5 if hid  =="5420554201007" & s1aq1==143
replace s1aq6a  =5 if hid =="5420554201007" & s1aq1==143
replace s1aq3b  =6 if hid  =="5420554201007" & s1aq1==143
replace s1aq3a  =5  if hid =="5420554201007" & s1aq1==143

*******************5210652125016
replace s1aq4b  =11 if hid  =="5210652125016" & s1aq1==143
replace s1aq6b  =11 if hid =="5210652125016" & s1aq1==143
replace s1aq6a  =2  if hid =="5210652125016" & s1aq1==143
replace s1aq3b  =11 if hid  =="5210652125016" & s1aq1==143

****************5120151204002
replace s1aq6a  =7 if hid  =="5120151204002" & s1aq1==143
replace s1aq6b  =6 if hid  =="5120151204002" & s1aq1==143
replace s1aq3b  =6  if hid =="5120151204002" & s1aq1==143

****************5310953114013 ,5310253107004
replace s1aq4a  =. if hid  =="5310953114013"|hid  =="5310253107004" & s1aq1==143
replace s1aq4b  =. if hid  =="5310953114013"|hid  =="5310253107004" & s1aq1==143
replace s1aq6a  =. if hid  =="5310953114013"|hid  =="5310253107004" & s1aq1==143
replace s1aq6b  =. if hid  =="5310953114013"|hid  =="5310253107004" & s1aq1==143
replace s1aq3b  =6  if hid =="5310953114013"|hid  =="5310253107004" & s1aq1==143

**************5221052226010
replace s1aq8a  =. if hid  =="5221052226010" & s1aq1==143
replace s1aq8b  =. if hid  =="5221052226010" & s1aq1==143
replace s1aq3b  =6  if hid =="5221052226010" & s1aq1==143

******************5530155356010
replace s1aq6b  =6  if hid =="5530155356010" & s1aq1==143
replace s1aq6a  =2  if hid =="5530155356010" & s1aq1==143
replace s1aq3b  = 6 if hid  =="5530155356010" & s1aq1==143

******************5410454119003
replace s1aq3a  =1  if hid =="5410454119003" & s1aq1==143
replace s1aq3b  = 11 if hid  =="5410454119003" & s1aq1==143

***********************5310953114009
replace s1aq4a  =. if hid  =="5310953114009" & s1aq1==143
replace s1aq4b  =. if hid  =="5310953114009" & s1aq1==143
replace s1aq8a  =4 if hid  =="5310953114009" & s1aq1==143
replace s1aq8b  =4 if hid  =="5310953114009" & s1aq1==143
replace s1aq3b  =6  if hid =="5310953114009" & s1aq1==143

********************5530155356014
replace s1aq4a  =4 if hid  =="5530155356014" & s1aq1==143
replace s1aq6a  =4 if hid  =="5530155356014" & s1aq1==143
replace s1aq3a  =4 if hid  =="5530155356014" & s1aq1==143
replace s1aq3b  =6  if hid =="5530155356014" & s1aq1==143

********************5530155331001
replace s1aq4a  =9 if hid  =="5530155331001" & s1aq1==143
replace s1aq6a  =9 if hid  =="5530155331001" & s1aq1==143
replace s1aq3a  =9 if hid  =="5530155331001" & s1aq1==143
replace s1aq3b  =6  if hid =="5530155331001" & s1aq1==143

********************6022260210014
replace s1aq3a  =5 if hid  =="6022260210014" & s1aq1==143
replace s1aq3b  =6  if hid =="6022260210014" & s1aq1==143

******************5222152223010
replace s1aq6b  =6  if hid =="5222152223010" & s1aq1==143
replace s1aq6a  =4  if hid =="5222152223010" & s1aq1==143
replace s1aq3b  = 6 if hid  =="5222152223010" & s1aq1==143

********************5310253105002
replace s1aq3a  =6 if hid  =="5310253105002" & s1aq1==143
replace s1aq3b  =6  if hid =="5310253105002" & s1aq1==143

*************************5111751123013
replace s1aq6b  =6  if hid =="5111751123013" & s1aq1==143
replace s1aq6a  =4  if hid =="5111751123013" & s1aq1==143
replace s1aq3b  = 6 if hid  =="5111751123013" & s1aq1==143
replace s1aq5   = . if hid  =="5111751123013" & s1aq1==143

*************************5320753202005, 5530155304007
replace s1aq7b  =6  if hid =="5320753202005" |hid=="5530155304007" & s1aq1==143
replace s1aq7a  =2  if hid =="5320753202005" |hid=="5530155304007" & s1aq1==143
replace s1aq3b  = 6 if hid  =="5320753202005" |hid=="5530155304007" & s1aq1==143
replace s1aq6a   = . if hid  =="5320753202005"|hid=="5530155304007" & s1aq1==143
replace s1aq6b   = . if hid  =="5320753202005"|hid=="5530155304007" & s1aq1==143
replace s1aq5   = . if hid  =="5320753202005"|hid=="5530155304007" & s1aq1==143

********************5420554201009
replace s1aq3a  =5  if hid =="5420554201009" & s1aq1==143
replace s1aq3b  = 6 if hid  =="5420554201009" & s1aq1==143
replace s1aq4a  = 5 if hid  =="5420554201009" & s1aq1==143
replace s1aq6a  = 5 if hid  =="5420554201009" & s1aq1==143

*****************************************************
*******************SPINARCH(KRENKREN)
***********************
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b  s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 144 & s1aq5==15

gen issue = 3  if s1aq1  == 144 & s1aq5==15
replace s1aq3a = 3 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 3 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 3 if issue == 3
replace s1aq6b = 6 if issue == 3

drop issue
gen issue = 3  if s1aq1  == 144 & s1aq5==10
replace s1aq3a = 1 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 1 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 1 if issue == 3
replace s1aq6b = 11 if issue == 3

drop issue

gen issue = 3  if s1aq1  == 144 & s1aq5==25
replace s1aq3a = 5 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 5 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 5 if issue == 3
replace s1aq6b = 6 if issue == 3
******************* 4521145208011, 5320653207002
replace s1aq8b  = 6  if hid =="4521145208011"|hid=="5320653207002" & s1aq1==144
replace s1aq3a  =tot_consumed  if hid == "4521145208011"|hid=="5320653207002" & s1aq1==144
replace s1aq3b  = 6 if hid =="4521145208011"|hid=="5320653207002" & s1aq1==144

*********************5320953205005
replace s1aq4a  =. if hid  =="5320953205005" & s1aq1==144
replace s1aq4b  =. if hid  =="5320953205005" & s1aq1==144
replace s1aq8a  =4 if hid  =="5320953205005" & s1aq1==144
replace s1aq8b  =6 if hid  =="5320953205005" & s1aq1==144
replace s1aq3b  =6  if hid =="5320953205005" & s1aq1==144

*********************5530155356001
replace s1aq4a  =2 if hid  =="5530155356001" & s1aq1==144
replace s1aq6a  =2 if hid  =="5530155356001" & s1aq1==144
replace s1aq6b  =11 if hid  =="5530155356001" & s1aq1==144
replace s1aq3a  =2  if hid =="5530155356001" & s1aq1==144
replace s1aq3b  =11  if hid =="5530155356001" & s1aq1==144

****************************5221652213011
replace s1aq4a  =. if hid  =="5221652213011" & s1aq1==144
replace s1aq4b  =. if hid  =="5221652213011" & s1aq1==144
replace s1aq6a  =. if hid  =="5221652213011" & s1aq1==144
replace s1aq6b  =. if hid  =="5221652213011" & s1aq1==144
replace s1aq3b  =11  if hid =="5221652213011" & s1aq1==144

*********************5530155311003
replace s1aq4a  =4 if hid  =="5530155311003" & s1aq1==144
replace s1aq6a  =4 if hid  =="5530155311003" & s1aq1==144
replace s1aq3a  =4  if hid =="5530155311003" & s1aq1==144
replace s1aq3b  =11  if hid =="5530155311003" & s1aq1==144

****************************6020960225012
replace s1aq4a  =. if hid  =="6020960225012" & s1aq1==144
replace s1aq4b  =. if hid  =="6020960225012" & s1aq1==144
replace s1aq6a  =. if hid  =="6020960225012" & s1aq1==144
replace s1aq6b  =. if hid  =="6020960225012" & s1aq1==144
replace s1aq3b  =11  if hid =="6020960225012" & s1aq1==144

***************************************************
*********************** Lettuce
replace s1aq5  =50 if hid  =="5310253111009" & s1aq1==145
replace s1aq5  =10 if hid  =="5420554201007" & s1aq1==145

drop issue
gen issue = 3  if s1aq1  == 145 & s1aq5==15
replace s1aq3a = 3 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 3 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 3 if issue == 3
replace s1aq6b = 6 if issue == 3

drop issue
gen issue = 3  if s1aq1  == 145 & s1aq5==10
replace s1aq3a = 1 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 1 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 1 if issue == 3
replace s1aq6b = 6 if issue == 3

drop issue
gen issue = 3  if s1aq1  == 145 & s1aq5==30
replace s1aq3a = 3 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 3 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 3 if issue == 3
replace s1aq6b = 6 if issue == 3

drop issue 
gen issue = 3  if s1aq1  == 145 & s1aq5==50
replace s1aq3a = 5 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 5 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 5 if issue == 3
replace s1aq6b = 6 if issue == 3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3

*******************5530155356006
replace s1aq4a  = 4 if hid  =="5530155356006" & s1aq1==145
replace s1aq4b  =6 if hid  =="5530155356006" & s1aq1==145
replace s1aq6a  =4 if hid  =="5530155356006" & s1aq1==145
replace s1aq6b  =6 if hid  =="5530155356006" & s1aq1==145
replace s1aq3a  =4  if hid =="5530155356006" & s1aq1==145
replace s1aq3b  =6  if hid =="5530155356006" & s1aq1==145

*******************5020850205006
replace s1aq4b  = 6 if hid  =="5020850205006" & s1aq1==145
replace s1aq6a  =5 if hid  =="5020850205006" & s1aq1==145
replace s1aq6b  =6 if hid  =="5020850205006" & s1aq1==145
replace s1aq3b  =6  if hid =="5020850205006" & s1aq1==145

*********************5022350219015
replace s1aq7a  =. if hid  =="5022350219015" & s1aq1==145
replace s1aq7b  =. if hid  =="5022350219015" & s1aq1==145
replace s1aq4b  =6 if hid  =="5022350219015" & s1aq1==145
replace s1aq6b  =6 if hid  =="5022350219015" & s1aq1==145
replace s1aq3b  =6 if hid  =="5022350219015" & s1aq1==145

*****************5221652215006
replace s1aq7a  =. if hid  =="5221652215006" & s1aq1==145
replace s1aq7b  =. if hid  =="5221652215006" & s1aq1==145

******************5530155356012
replace s1aq8a  =. if hid  =="5530155356012" & s1aq1==145
replace s1aq8b  =. if hid  =="5530155356012" & s1aq1==145


***************************************************************
***************** Tomato Fresh
br  hid s1aq2 s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b tot_consumed if s1aq1==153 & s1aq3a!=tot_consumed & s1aq3a!=.
 
drop issue
gen issue = 3  if s1aq1  == 153 & s1aq5==30
replace s1aq3a = 3 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 3 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 3 if issue == 3
replace s1aq6b = 11 if issue == 3
drop issue 

gen issue = 3  if s1aq1  == 153 & s1aq5==20
replace s1aq3a = 2 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 2 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 2 if issue == 3
replace s1aq6b = 11 if issue == 3

drop issue 

gen issue = 3  if s1aq1  == 153 & s1aq5==15
replace s1aq3a = 3 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 3 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 3 if issue == 3
replace s1aq6b = 11 if issue == 3

drop issue 

gen issue = 3  if s1aq1  == 153 & s1aq5==70
replace s1aq3a = 7 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 7 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 7 if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3

drop issue
gen issue = 3  if s1aq1  == 153 & s1aq5==35
replace s1aq3a = 7 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 7 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 7 if issue == 3
replace s1aq6b = 11 if issue == 3

drop issue

gen issue = 3  if s1aq1  == 153 & s1aq5==25
replace s1aq3a = 5 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 5 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 5 if issue == 3
replace s1aq6b = 11 if issue == 3

drop issue

gen issue = 3  if s1aq1  == 153 & s1aq5==10
replace s1aq3a = 1 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 1 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 1 if issue == 3
replace s1aq6b = 11 if issue == 3

****************************hid=="5310253111006"| hid=="5020850205011"
replace s1aq8a  =. if hid=="5310253111006"| hid=="5020850205011" |hid =="5220152222015" & s1aq1==153
replace s1aq8b  =. if hid=="5310253111006"| hid=="5020850205011"|hid =="5220152222015" & s1aq1==153
replace s1aq7a  =. if hid =="5220152222015"|hid =="6020260222007" & s1aq1==153
replace s1aq7b  =. if hid =="5220152222015"|hid =="6020260222007" & s1aq1==153

************************6010660111002
replace s1aq3a  =1 if hid =="6010660111002" & s1aq1==153
replace s1aq3b  =11 if hid =="6010660111002" & s1aq1==153

************************5511855110010, 6210262113014
replace s1aq4a  =. if hid =="5511855110010"|hid =="6210262113014" & s1aq1==153
replace s1aq4b  =. if hid =="5511855110010"|hid =="6210262113014" & s1aq1==153
replace s1aq3a  =7 if hid =="5511855110010" 
replace s1aq3b  =11 if hid =="5511855110010"|hid =="6210262113014" & s1aq1==153
replace s1aq3a  =2 if hid =="6210262113014"& s1aq1==153
************************5320253212007
replace s1aq4a  =. if hid =="5320253212007" & s1aq1==153
replace s1aq4b  =. if hid =="5320253212007" & s1aq1==153
replace s1aq7a  =8 if hid =="5320253212007" & s1aq1==153
replace s1aq7b  =11 if hid =="5320253212007" & s1aq1==153
replace s1aq3b  =11 if hid =="5320253212007" & s1aq1==153
replace s1aq5   =.  if hid =="5320253212007" & s1aq1==153 

************************5013050113014
replace s1aq4b  =11 if hid =="5013050113014" & s1aq1==153
replace s1aq6b  =11 if hid =="5013050113014" & s1aq1==153
replace s1aq3a  =4  if hid =="5013050113014" & s1aq1==153
replace s1aq3b  =11 if hid =="5013050113014" & s1aq1==153
replace s1aq5   =.  if hid =="5013050113014" & s1aq1==153  // amount ==160

************************6323963202003
replace s1aq6a  =3 if hid =="6323963202003" & s1aq1==153
replace s1aq6b  =11 if hid =="6323963202003" & s1aq1==153
replace s1aq3a  =3  if hid =="6323963202003" & s1aq1==153
replace s1aq3b  =11 if hid =="6323963202003" & s1aq1==153
replace s1aq5   =.  if hid =="6323963202003" & s1aq1==153  // amount ==3

***********************5621856206004
replace s1aq4a  =.  if hid =="5621856206004" & s1aq1==153
replace s1aq4b  =.  if hid =="5621856206004" & s1aq1==153
replace s1aq8a  =7  if hid =="5621856206004" & s1aq1==153
replace s1aq8b  =11 if hid =="5621856206004" & s1aq1==153
replace s1aq3b  =11  if hid =="5621856206004" & s1aq1==153  

***********************5111651120009
replace s1aq7a  =.  if hid =="5111651120009" & s1aq1==153
replace s1aq7b  =.  if hid =="5111651120009" & s1aq1==153
replace s1aq3b  =11  if hid =="5111651120009" & s1aq1==153  

**********************6022460203002
replace s1aq4a  =5   if hid =="6022460203002" & s1aq1==153
replace s1aq4b  =11  if hid =="6022460203002" & s1aq1==153
replace s1aq6a  =5   if hid =="6022460203002" & s1aq1==153
replace s1aq6b  =11  if hid =="6022460203002" & s1aq1==153
replace s1aq3b  =11  if hid =="6022460203002" & s1aq1==153  
replace s1aq3a  =5   if hid =="6022460203002" & s1aq1==153  

***********************5610656115005
replace s1aq4a  =.  if hid =="5610656115005" & s1aq1==153
replace s1aq4b  =.  if hid =="5610656115005" & s1aq1==153
replace s1aq7a  =3  if hid =="5610656115005" & s1aq1==153
replace s1aq7b  =11 if hid =="5610656115005" & s1aq1==153
replace s1aq3b  =11  if hid =="5610656115005" & s1aq1==153  

*************************6022460203001
replace s1aq4a  =4   if hid =="6022460203001" & s1aq1==153
replace s1aq4b  =11  if hid =="6022460203001" & s1aq1==153
replace s1aq6a  =4   if hid =="6022460203001" & s1aq1==153
replace s1aq6b  =11  if hid =="6022460203001" & s1aq1==153
replace s1aq3b  =11  if hid =="6022460203001" & s1aq1==153  
replace s1aq3a  =4   if hid =="6022460203001" & s1aq1==153  

***********************5221652215005
replace s1aq4a  =7   if hid =="5221652215005" & s1aq1==153
replace s1aq4b  =11  if hid =="5221652215005" & s1aq1==153
replace s1aq6a  =7   if hid =="5221652215005" & s1aq1==153
replace s1aq6b  =11  if hid =="5221652215005" & s1aq1==153
replace s1aq3b  =11  if hid =="5221652215005" & s1aq1==153  
replace s1aq3a  =7   if hid =="5221652215005" & s1aq1==153  
replace s1aq7a  =.   if hid =="5221652215005" & s1aq1==153
replace s1aq7b  =.   if hid =="5221652215005" & s1aq1==153
replace s1aq5  =.    if hid =="5221652215005" & s1aq1==153 // amount 125

***************************************************************
***************** Bitter Tomato
br  hid s1aq2 s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b tot_consumed if s1aq1==154 & s1aq3a!=tot_consumed & s1aq3a!=.
drop issue 

gen issue = 3  if s1aq1  == 154 & s1aq5==40
replace s1aq3a = 4 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 4 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 4 if issue == 3
replace s1aq6b = 11 if issue == 3

drop issue 

gen issue = 3  if (s1aq1  == 154 & s1aq5==10 | s1aq5==11)
replace s1aq3a = 2 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 2 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 2 if issue == 3
replace s1aq6b = 11 if issue == 3

drop issue 

gen issue = 3  if s1aq1  == 154 & s1aq5==15
replace s1aq3a = 3 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 3 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 3 if issue == 3
replace s1aq6b = 11 if issue == 3

drop issue 

gen issue = 3  if s1aq1  == 154 & s1aq5==30
replace s1aq3a = 3 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 3 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 3 if issue == 3
replace s1aq6b = 11 if issue == 3

drop issue 

gen issue = 3  if (s1aq1  == 154 & s1aq5==70 | s1aq5==35 | s1aq5==280)
replace s1aq3a = 7 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 7 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 7 if issue == 3
replace s1aq6b = 11 if issue == 3

drop issue 

gen issue = 3  if s1aq1  == 154 & s1aq5==20
replace s1aq3a = 4 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 4 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 4 if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3

drop issue
gen issue = 3  if (s1aq1  == 154 & s1aq4a!=. & s1aq6a ==. & s1aq7a==. & s1aq8a==.)
replace s1aq3b = 11 if issue == 3
replace s1aq4a = . if issue == 3
replace s1aq4b = . if issue == 3
replace s1aq7a = s1aq3a if issue == 3
replace s1aq7b = 11 if issue == 3
replace s1aq5 = . if issue == 3 // amount too high

drop issue

gen issue = 3  if s1aq1  == 154 & s1aq5==25
replace s1aq3a = 5 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 5 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 5 if issue == 3
replace s1aq6b = 11 if issue == 3

**************************6111261113011, 5020750230005, 5121251218013", "5013450178015
replace s1aq8a  =.   if hid =="6111261113011" |hid =="5020750230005"|hid=="5121251218013"|hid =="5013450178015"|hid=="5530155339013" & s1aq1==154
replace s1aq8b  =.   if hid =="6111261113011" |hid =="5020750230005"|hid=="5121251218013"|hid =="5013450178015"|hid=="5530155339013" & s1aq1==154

************************5122551211012
replace s1aq7a  =1   if hid =="5122551211012"  & s1aq1==154

**********************5220752220010
replace s1aq7b  =11   if hid =="5220752220010"  & s1aq1==154
replace s1aq3a  =tot_consumed   if hid =="5220752220010"  & s1aq1==154

**********************5211152102016
replace s1aq5 = . if hid =="5211152102016"  & s1aq1==154 // amount too high

******************************5110151135015, 5020750230011, hid =="5110151135008"|5612056108001
replace s1aq7a  =.   if hid =="5110151135015"|hid=="5020750230011"|hid =="5110151135008"|hid =="5612056108001" & s1aq1==154
replace s1aq7b  =.   if hid =="5110151135015"|hid=="5020750230011"|hid =="5110151135008"|hid =="5612056108001"  & s1aq1==154

************************5420754218010
replace s1aq4a  =1    if hid =="5420754218010"  & s1aq1==154
replace s1aq4b  =11   if hid =="5420754218010"  & s1aq1==154
replace s1aq6b  =11   if hid =="5420754218010"  & s1aq1==154
replace s1aq3b  =11   if hid =="5420754218010"  & s1aq1==154
replace s1aq3a  =1    if hid =="5420754218010"  & s1aq1==154

*********************5020850205006
replace s1aq4a  =5    if hid =="5020850205006"  & s1aq1==154
replace s1aq3b  =11   if hid =="5020850205006"  & s1aq1==154
replace s1aq3a  =5    if hid =="5020850205006"  & s1aq1==154

*************************5013050117002
replace s1aq6a  =4    if hid =="5013050117002"  & s1aq1==154
replace s1aq3b  =6    if hid =="5013050117002"  & s1aq1==154
replace s1aq3a  =5    if hid =="5013050117002"  & s1aq1==154
replace s1aq5 = .     if hid =="5013050117002"  & s1aq1==154 // amount too low

*************************5020750230011
replace s1aq6a  =2    if hid =="5020750230011"  & s1aq1==154
replace s1aq6b  =11   if hid =="5020750230011"  & s1aq1==154
replace s1aq3b  =11   if hid =="5020750230011"  & s1aq1==154
replace s1aq3a  =2    if hid =="5020750230011"  & s1aq1==154
replace s1aq5 = .     if hid =="5020750230011"  & s1aq1==154 // amount too low

***********************5010550185011
replace s1aq7a  =7    if hid =="5010550185011"  & s1aq1==154
replace s1aq7b  =6   if hid =="5010550185011"  & s1aq1==154
replace s1aq3b  =6    if hid =="5010550185011"  & s1aq1==154

************************6321663215014, 5123051208007
replace s1aq4a  =.   if hid =="6321663215014" |hid =="5123051208007" & s1aq1==154
replace s1aq4b  =.   if hid =="6321663215014"|hid =="5123051208007"& s1aq1==154
replace s1aq6a  =.   if hid =="6321663215014" |hid =="5123051208007" & s1aq1==154
replace s1aq6b  =.   if hid =="6321663215014" |hid =="5123051208007" & s1aq1==154
replace s1aq3b  =11  if hid =="6321663215014" & s1aq1==154
replace s1aq3b  =6   if hid =="5123051208007" & s1aq1==154
replace s1aq3a  =7   if hid =="5123051208007" & s1aq1==154
replace s1aq5   =.   if hid =="5123051208007" & s1aq1==154

************************6210662104002
replace s1aq4b  =11   if hid =="6210662104002"  & s1aq1==154
replace s1aq6a  =2    if hid =="6210662104002"  & s1aq1==154
replace s1aq6b  =11   if hid =="6210662104002"  & s1aq1==154
replace s1aq3b  =11   if hid =="6210662104002"  & s1aq1==154
replace s1aq5   =.    if hid =="6210662104002"  & s1aq1==154 

*************************5111951130014, 5110151135008
replace s1aq6a  =14    if hid =="5111951130014"|hid == "5110151135008"  & s1aq1==154
replace s1aq6b  =6    if hid =="5111951130014" |hid == "5110151135008"  & s1aq1==154
replace s1aq3b  =6    if hid =="5111951130014"|hid == "5110151135008"   & s1aq1==154

***************************5612056108001
replace s1aq4a  =4    if hid =="5612056108001"  & s1aq1==154
replace s1aq4b  =11   if hid =="5612056108001"  & s1aq1==154
replace s1aq6a  =4    if hid =="5612056108001"  & s1aq1==154
replace s1aq6b  =11   if hid =="5612056108001"  & s1aq1==154
replace s1aq3b  =11   if hid =="5612056108001"  & s1aq1==154
replace s1aq3a  =4    if hid =="5612056108001"  & s1aq1==154
replace s1aq5 = .     if hid =="5612056108001"  & s1aq1==154 // amount too low

*******************************************************************************************
***************** ********************************milk sachet
br  hid s1aq2 s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b tot_consumed if s1aq1==94 & s1aq3a!=tot_consumed & s1aq3a!=.
drop issue 

gen issue = 3  if s1aq1  == 94 & s1aq5==15
replace s1aq3a = 3 if issue == 3
replace s1aq3b = 5 if issue == 3
replace s1aq4a = 3 if issue == 3
replace s1aq4b = 5 if issue == 3
replace s1aq6a = 3 if issue == 3
replace s1aq6b = 5 if issue == 3

drop issue 

gen issue = 3  if s1aq1  == 94 & s1aq5==20
replace s1aq3a = 4 if issue == 3
replace s1aq3b = 5 if issue == 3
replace s1aq4a = 4 if issue == 3
replace s1aq4b = 5 if issue == 3
replace s1aq6a = 4 if issue == 3
replace s1aq6b = 5 if issue == 3

drop issue 

gen issue = 3  if s1aq1  == 94 & s1aq5==70
replace s1aq3a = 14 if issue == 3
replace s1aq3b = 5 if issue == 3
replace s1aq4a = 14 if issue == 3
replace s1aq4b = 5 if issue == 3
replace s1aq6a = 14 if issue == 3
replace s1aq6b = 5 if issue == 3

drop issue 

gen issue = 3  if s1aq1  == 94 & s1aq5==30
replace s1aq3a = 6 if issue == 3
replace s1aq3b = 5 if issue == 3
replace s1aq4a = 6 if issue == 3
replace s1aq4b = 5 if issue == 3
replace s1aq6a = 6 if issue == 3
replace s1aq6b = 5 if issue == 3
drop issue 

gen issue = 3  if s1aq1  == 94 & s1aq5==25
replace s1aq3a = 5 if issue == 3
replace s1aq3b = 5 if issue == 3
replace s1aq4a = 5 if issue == 3
replace s1aq4b = 5 if issue == 3
replace s1aq6a = 5 if issue == 3
replace s1aq6b = 5 if issue == 3

*******************************5220952204009
replace s1aq3b  =5   if hid =="5220952204009"  & s1aq1==94
replace s1aq3a  =14  if hid =="5220952204009"  & s1aq1==94

*******************************5310253107002
replace s1aq6b  =5   if hid =="5310253107002"  & s1aq1==94
replace s1aq6a  =2   if hid =="5310253107002"  & s1aq1==94
replace s1aq3b  =5   if hid =="5310253107002"  & s1aq1==94

*******************************5320953203002, "5410454119006"
replace s1aq3b  =5   if hid =="5320953203002"|hid =="5410454119006"  & s1aq1==94
replace s1aq3a  =5   if hid =="5320953203002"|hid =="5410454119006"  & s1aq1==94
replace s1aq5   =.   if hid =="5410454119006"  & s1aq1==94 // amount too high =800

*******************************6320363219011
replace s1aq3a  =tot_consumed  if hid =="6320363219011"  & s1aq1==94

************************5013050113013
replace s1aq8b  =.   if hid =="5013050113013"  & s1aq1==94
replace s1aq8a  =.   if hid =="5013050113013"  & s1aq1==94

********************************************************
***************************TILAPIA
**********6022260210013|6121161214008
replace s1aq3a  =tot_consumed  if hid =="6022260210013" |hid=="6121161214008"  & s1aq1==63
replace s1aq3b  =11  if hid =="6022260210013" |hid=="6121161214008" & s1aq1==63

***************************4521145208012
replace s1aq7b  =.   if hid =="4521145208012"  & s1aq1==63
replace s1aq7a  =.   if hid =="4521145208012"  & s1aq1==63
replace s1aq5  =.   if hid =="4521145208012"  & s1aq1==63

drop issue 

gen issue = 3  if s1aq1  == 63 & s1aq5==150 |s1aq5==75
replace s1aq3a = 3 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 3 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 3 if issue == 3
replace s1aq6b = 11 if issue == 3

drop issue 

gen issue = 3  if s1aq1  == 63 & s1aq5==200
replace s1aq3a = 4 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 4 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 4 if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3

drop issue 

gen issue = 3  if s1aq1  == 63 & s1aq5==50
replace s1aq3a = 2 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 2 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 2 if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3


***************************6210462101004
replace s1aq4b  =.   if hid =="6210462101004"  & s1aq1==63
replace s1aq4a  =.   if hid =="6210462101004"  & s1aq1==63
replace s1aq6b  =.   if hid =="6210462101004"  & s1aq1==63
replace s1aq6a  =.   if hid =="6210462101004"  & s1aq1==63
replace s1aq3b  =6   if hid =="6210462101004"  & s1aq1==63


*********************6121161214016, 5620156228005
replace s1aq8b  =.   if hid =="6121161214016"|hid=="5620156228005"  & s1aq1==63
replace s1aq8a  =.   if hid =="6121161214016"|hid=="5620156228005"  & s1aq1==63
replace s1aq3a  =tot_consumed  if hid =="6121161214016"|hid=="5620156228005"  & s1aq1==63

*************************6211662120016
replace s1aq6b  =11   if hid =="6211662120016"  & s1aq1==63
replace s1aq6a  =2    if hid =="6211662120016"  & s1aq1==63
replace s1aq3b  =11   if hid =="6211662120016"  & s1aq1==63

***************************5620156228005
replace s1aq3a  =2  if hid =="5620156228005"  & s1aq1==63
**********************6210462101004
replace s1aq7b  =6   if hid =="6210462101004"  & s1aq1==63
replace s1aq6a  =.   if hid =="6210462101004"  & s1aq1==63
replace s1aq6b  =.   if hid =="6210462101004"  & s1aq1==63

****************5011850150001
replace s1aq4b  =.   if hid =="5011850150001"  & s1aq1==63
replace s1aq4a  =.   if hid =="5011850150001"  & s1aq1==63
replace s1aq6b  =.   if hid =="5011850150001"  & s1aq1==63
replace s1aq6a  =.   if hid =="5011850150001"  & s1aq1==63
replace s1aq3b  =11  if hid =="5011850150001"  & s1aq1==63
replace s1aq8b  =.   if hid =="5011850150001"  & s1aq1==63
replace s1aq8a  =.   if hid =="5011850150001"  & s1aq1==63
replace s1aq7b  =11  if hid =="5011850150001"  & s1aq1==63
replace s1aq3a  =1   if hid =="5011850150001"  & s1aq1==63


********************************************************
***************************dried fish
br  hid s1aq2 s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b tot_consumed if s1aq1==69 & s1aq3a!=tot_consumed & s1aq3a!=.
drop issue 
gen issue = 3  if s1aq1  == 69 & (s1aq5==10|s1aq5==20|s1aq5==100)
replace s1aq3a = 2 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 2 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 2 if issue == 3
replace s1aq6b = 6 if issue == 3

drop issue 
gen issue = 3  if s1aq1  == 69 & (s1aq5==40|s1aq5==6)
replace s1aq3a = 4 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 4 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 4 if issue == 3
replace s1aq6b = 6 if issue == 3

drop issue 
gen issue = 3  if s1aq1  == 69 & (s1aq5==15|s1aq5==3|s1aq5==60)
replace s1aq3a = 3 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 3 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 3 if issue == 3
replace s1aq6b = 6 if issue == 3

drop issue
gen issue = 3  if s1aq1  == 69 & (s1aq5==5|s1aq5==500|s1aq5==90)
replace s1aq3b = 6 if issue == 3
replace s1aq4a = s1aq3a  if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = s1aq3a if issue == 3
replace s1aq6b = 6 if issue == 3

************************5120651225014
replace s1aq5  =25   if hid =="5120651225014"  & s1aq1==69
drop issue 
gen issue = 3  if s1aq1  == 69 & s1aq5==25
replace s1aq3a = 5 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 5 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 5 if issue == 3
replace s1aq6b = 6 if issue == 3

drop issue
gen issue = 3  if s1aq1  == 69 & s1aq5==. & s1aq4a==. & s1aq6a==. & s1aq7a==. & s1aq8a==.
replace s1aq3b = 6 if issue == 3
replace s1aq7a = s1aq3a  if issue == 3
replace s1aq7b = 6 if issue == 3

*************************6321163233004, "5621856206013", 5211552122001, 6312063123003
replace s1aq5 =.   if hid =="6321163233004"|hid=="5621856206013"|hid=="5211552122001"|hid=="6312063123003"|hid=="6314263133007"|hid=="5222152223007" & s1aq1==69
**********************5110351125015, 5320653207002
replace s1aq8a  =.   if hid =="5110351125015"|hid=="5320653207002" & s1aq1==69
replace s1aq8b  =.   if hid =="5110351125015"|hid=="5320653207002"   & s1aq1==69

*************************5310253106001,5310553123014 , 5310353120006, 5121251218012
replace s1aq7a  =.   if hid =="5310253106001"|hid=="5310553123014"|hid=="5310353120006"|hid=="5121251218012" & s1aq1==69
replace s1aq7b  =.   if hid =="5310253106001"|hid=="5310553123014" |hid=="5310353120006"|hid=="5121251218012"  & s1aq1==69

************************5310353120006
replace s1aq6b  =6   if hid =="5310353120006"  & s1aq1==69
replace s1aq4b  =6   if hid =="5310353120006"  & s1aq1==69
replace s1aq3b  =6   if hid =="5310353120006"  & s1aq1==69

****************************5411654115011
replace s1aq6a  =.   if hid =="5411654115011"  & s1aq1==69
replace s1aq6b  =.    if hid =="5411654115011" & s1aq1==69
replace s1aq7a  =2   if hid =="5411654115011"  & s1aq1==69
replace s1aq7b  =6   if hid =="5411654115011"  & s1aq1==69
replace s1aq3b  =6    if hid =="5411654115011" & s1aq1==69

******************5530155311001
replace s1aq6a  =5     if hid =="5530155311001"  & s1aq1==69
replace s1aq6b  =6    if hid =="5530155311001"  & s1aq1==69
replace s1aq4a  =5    if hid =="5530155311001"  & s1aq1==69
replace s1aq4b  =6    if hid =="5530155311001"  & s1aq1==69
replace s1aq3a  =5    if hid =="5530155311001"  & s1aq1==69
replace s1aq3b  =6    if hid =="5530155311001"  & s1aq1==69

************************5222152223007
replace s1aq3a  =3   if hid =="5222152223007"  & s1aq1==69
replace s1aq3b  =6   if hid =="5222152223007"  & s1aq1==69

*********************6113161102013
replace s1aq4a  =.   if hid =="6113161102013"  & s1aq1==69
replace s1aq4b  =.   if hid =="6113161102013" & s1aq1==69
replace s1aq7a  =3   if hid =="6113161102013"  & s1aq1==69
replace s1aq7b  =6   if hid =="6113161102013"  & s1aq1==69
replace s1aq3b  =6    if hid =="6113161102013" & s1aq1==69

****************************5621856206013
replace s1aq4a  =.   if hid =="5621856206013"  & s1aq1==69
replace s1aq4b  =.    if hid =="5621856206013" & s1aq1==69
replace s1aq7a  =4   if hid =="5621856206013"  & s1aq1==69
replace s1aq7b  =6   if hid =="5621856206013"  & s1aq1==69
replace s1aq6a  =.   if hid =="5621856206013"  & s1aq1==69
replace s1aq6b  =.    if hid =="5621856206013" & s1aq1==69
replace s1aq8a  =.   if hid =="5621856206013"  & s1aq1==69
replace s1aq8b  =.    if hid =="5621856206013" & s1aq1==69

******************************hid=="6320663227015
replace s1aq7a  =9   if hid=="6320663227015"  & s1aq1==69
replace s1aq7b  =6   if hid=="6320663227015"  & s1aq1==69
replace s1aq3b  =6   if hid=="6320663227015"  & s1aq1==69
replace s1aq5  =.    if hid=="6320663227015"  & s1aq1==69

********************************************************
***************************onion leaves
br  hid s1aq2 s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b tot_consumed if s1aq1==149 & s1aq3a!=tot_consumed & s1aq3a!=.
drop issue 
gen issue = 3  if s1aq1  == 149 & s1aq5==10
replace s1aq3a = 2 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 2 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 2 if issue == 3
replace s1aq6b = 11 if issue == 3

drop issue
gen issue = 3  if s1aq1  == 149 & s1aq5==. & s1aq4a==. & s1aq6a==. & s1aq7a==. & s1aq8a==.
replace s1aq3b = 6 if issue == 3
replace s1aq7a = s1aq3a  if issue == 3
replace s1aq7b = 6 if issue == 3

drop issue
gen issue = 3  if s1aq1  == 149 & s1aq5==. & s1aq4a!=. & s1aq6a==. & s1aq7a==. & s1aq8a==.
replace s1aq3b = 6 if issue == 3
replace s1aq7a = s1aq3a  if issue == 3
replace s1aq7b = 6 if issue == 3
replace s1aq4a = . if issue == 3
replace s1aq4b = . if issue == 3

drop issue 
gen issue = 3  if s1aq1  == 149 & s1aq5==5
replace s1aq3a = 1 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 1 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 1 if issue == 3
replace s1aq6b = 11 if issue == 3

drop issue 
gen issue = 3  if s1aq1  == 149 & s1aq5==18
replace s1aq3a = 6 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 6 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 6 if issue == 3
replace s1aq6b = 6 if issue == 3

drop issue 
gen issue = 3  if s1aq1  == 149 & s1aq5==30
replace s1aq3a = 6 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 6 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 6 if issue == 3
replace s1aq6b = 11 if issue == 3

drop issue 
gen issue = 3  if s1aq1  == 149 & s1aq5==20
replace s1aq3a = 4 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 4 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 4  if issue == 3
replace s1aq6b = 11 if issue == 3

************************5013050129012, 5111751123006
replace s1aq7a =.   if hid=="5013050129012"|hid=="5111751123006"|hid=="5530155356010"  & s1aq1==149
replace s1aq7b =.   if hid=="5013050129012"|hid=="5111751123006"|hid=="5530155356010"  & s1aq1==149

************************5123051208012, 5530155335003, 6210462101013
replace s1aq6a =7   if hid=="5123051208012"  & s1aq1==149
replace s1aq6a =4   if hid=="5530155335003"|hid=="5530155331003" & s1aq1==149
replace s1aq3a =3   if hid=="5211452117006"  & s1aq1==149
replace s1aq6b =6   if hid=="5123051208012"|hid=="5530155335003"|hid=="5530155331003"|hid=="5211452117006"  & s1aq1==149
replace s1aq4b =6   if hid=="5123051208012"|hid=="5530155335003"|hid=="5530155331003" |hid=="5211452117006" & s1aq1==149
replace s1aq3b =6   if hid=="5123051208012"|hid=="5530155335003" |hid=="5530155331003"|hid=="5211452117006"  & s1aq1==149

*************************6323563229006
replace s1aq3b =11  if hid=="6323563229006"  & s1aq1==149
replace s1aq8a =.   if hid=="6323563229006"  & s1aq1==149
replace s1aq8b =.   if hid=="6323563229006"  & s1aq1==149

*******************************5420554201002
replace s1aq3b =11  if hid=="5420554201002"  & s1aq1==149
replace s1aq3a =1   if hid=="5420554201002"  & s1aq1==149
replace s1aq7a =1   if hid=="5420554201002"  & s1aq1==149
replace s1aq7b =11  if hid=="5420554201002"  & s1aq1==149
replace s1aq6a =.   if hid=="5420554201002"  & s1aq1==149
replace s1aq6b =.   if hid=="5420554201002"  & s1aq1==149

*****************************5420554201005
replace s1aq3b =6  if hid=="5420554201005"  & s1aq1==149
replace s1aq3a =7   if hid=="5420554201005"  & s1aq1==149
replace s1aq7b =6   if hid=="5420554201005"  & s1aq1==149

****************************5530155356006
replace s1aq3b =11  if hid=="5530155356006"  & s1aq1==149
replace s1aq3a =5   if hid=="5530155356006"  & s1aq1==149
replace s1aq4a =5   if hid=="5530155356006"  & s1aq1==149
replace s1aq6a =5   if hid=="5530155356006"  & s1aq1==149

********************************************************
***************************smoked Bonga
br  hid s1aq2 s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b tot_consumed if s1aq1==70 & s1aq3a!=tot_consumed & s1aq3a!=.
drop issue 
*************5020150236016
replace s1aq5 =50  if hid=="5020150236016"  & s1aq1==70

gen issue = 3  if s1aq1  == 70 & (s1aq5==50|s1aq5==250|s1aq5==150) 
replace s1aq3a = 5 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 5 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 5 if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3
replace s1aq5 = 50 if issue == 3

drop issue 
gen issue = 3  if s1aq1 == 70 & (s1aq5==20|s1aq5==266)
replace s1aq3a = 2 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 2 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 2 if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3
replace s1aq5 = 20 if issue == 3

drop issue 
gen issue = 3  if s1aq1 == 70 & s1aq5==25
replace s1aq3a = 5 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 5 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 5 if issue == 3
replace s1aq6b = 6 if issue == 3

drop issue 
gen issue = 3  if s1aq1 == 70 & s1aq5==40
replace s1aq3a = 4 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 4 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 4 if issue == 3
replace s1aq6b = 11 if issue == 3

drop issue
gen issue = 3  if s1aq1  == 70 & s1aq5==. & s1aq4a==. & s1aq6a==.  & s1aq8a==. 
replace s1aq3b = 6 if issue == 3
replace s1aq7a = s1aq3a  if issue == 3
replace s1aq7b = 6 if issue == 3

drop issue 
gen issue = 3  if s1aq1 == 70 & (s1aq5==7|s1aq5==70)
replace s1aq3a = 7 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 7 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 7 if issue == 3
replace s1aq6b = 11 if issue == 3

********************************** 6311363126011,
replace s1aq5 =.   if hid=="6311363126011" & s1aq1==70

*****************************4520145209006 *
replace s1aq7b =.  if hid=="4520145209006"|hid=="6312063123008" & s1aq1==70
replace s1aq7a =.  if hid=="4520145209006"|hid=="6312063123008"   & s1aq1==70
replace s1aq8a =.  if hid=="6312063123008"   & s1aq1==70
replace s1aq8b =.  if hid=="6312063123008"   & s1aq1==70

**********************6314263131013 *
replace s1aq4b =11  if hid=="6314263131013"  & s1aq1==70
replace s1aq6b =11  if hid=="6314263131013"  & s1aq1==70
replace s1aq3b =11  if hid=="6314263131013"  & s1aq1==70
replace s1aq3a =4   if hid=="6314263131013"  & s1aq1==70


**********************6311163120016*
replace s1aq4a =6  if hid=="6311163120016"  & s1aq1==70
replace s1aq4b =6  if hid=="6311163120016"  & s1aq1==70
replace s1aq6a =6  if hid=="6311163120016"  & s1aq1==70
replace s1aq6b =6  if hid=="6311163120016"  & s1aq1==70
replace s1aq3b =6  if hid=="6311163120016"  & s1aq1==70

**********************6311363126011*
replace s1aq4a =2  if hid=="6311363126011"  & s1aq1==70
replace s1aq4b =11  if hid=="6311363126011"  & s1aq1==70
replace s1aq6a =2  if hid=="6311363126011"  & s1aq1==70
replace s1aq6b =11  if hid=="6311363126011"  & s1aq1==70
replace s1aq3b =11  if hid=="6311363126011"  & s1aq1==70
replace s1aq3a =2  if hid=="6311363126011"  & s1aq1==70

***************6311363126012
replace s1aq5 =60  if hid=="6311363126012"  & s1aq1==70

drop issue 
gen issue = 3  if s1aq1 == 70 & s1aq5==60
replace s1aq3a = 6 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 6 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 6 if issue == 3
replace s1aq6b = 11 if issue == 3

drop issue 
gen issue = 3  if s1aq1 == 70 & s1aq5==100
replace s1aq3a = 10 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 10 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 10 if issue == 3
replace s1aq6b = 11 if issue == 3



********************************************************
***************************Evaporated milk
br  hid s1aq2 s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b tot_consumed if s1aq1==92 & s1aq3a!=tot_consumed & s1aq3a!=.
drop issue 
gen issue = 3  if s1aq1  == 92 & s1aq5==30 
replace s1aq3a = 2 if issue == 3
replace s1aq3b = 12 if issue == 3
replace s1aq4a = 2 if issue == 3
replace s1aq4b = 12 if issue == 3
replace s1aq6a = 2 if issue == 3
replace s1aq6b = 12 if issue == 3

drop issue 
gen issue = 3  if s1aq1  == 92 & s1aq5==15
replace s1aq3a = 1 if issue == 3
replace s1aq3b = 12 if issue == 3
replace s1aq4a = 1 if issue == 3
replace s1aq4b = 12 if issue == 3
replace s1aq6a = 1 if issue == 3
replace s1aq6b = 12 if issue == 3

drop issue 
gen issue = 3  if s1aq1  == 92 & s1aq5==50
replace s1aq3a = 2 if issue == 3
replace s1aq3b = 12 if issue == 3
replace s1aq4a = 2 if issue == 3
replace s1aq4b = 12 if issue == 3
replace s1aq6a = 2 if issue == 3
replace s1aq6b = 12 if issue == 3

**************************5310253102005, 
replace s1aq5 =60   if hid=="5310253102005"  & s1aq1==92

drop issue
gen issue = 3  if s1aq1  == 92 & (s1aq5==200 |s1aq5==45|s1aq5==60) 
replace s1aq3b = 12 if issue == 3
replace s1aq4a = s1aq3a  if issue == 3
replace s1aq6a = s1aq3a  if issue == 3
replace s1aq4b = 12 if issue == 3
replace s1aq6b = 12 if issue == 3

drop issue 
gen issue = 3  if s1aq1  == 92 & s1aq5==65
replace s1aq3a = 3 if issue == 3
replace s1aq3b = 12 if issue == 3
replace s1aq4a = 3 if issue == 3
replace s1aq4b = 12 if issue == 3
replace s1aq6a = 3 if issue == 3
replace s1aq6b = 12 if issue == 3

**************************5110551108005
replace s1aq8a =.   if hid=="5110551108005"  & s1aq1==92
replace s1aq8b =.   if hid=="5110551108005"  & s1aq1==92

**************************5530155311010
replace s1aq5 =.   if hid=="5530155311010"  & s1aq1==92


***********************5013050117006
replace s1aq8b =12   if hid=="5013050117006"  & s1aq1==92
replace s1aq3b =12   if hid=="5013050117006"  & s1aq1==92
replace s1aq3a =10   if hid=="5013050117006"  & s1aq1==92


********************************************************
***************************okra
br  hid s1aq2 s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b tot_consumed if s1aq1==156 & s1aq3a!=tot_consumed & s1aq3a!=.

drop issue 
gen issue = 3  if s1aq1  == 156 & s1aq5==50 
replace s1aq3a = 5 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 5 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 5 if issue == 3
replace s1aq6b = 11 if issue == 3

drop issue 
gen issue = 3  if s1aq1  == 156 & (s1aq5==15| s1aq5==30)
replace s1aq3a = 3 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 3 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 3 if issue == 3
replace s1aq6b = 11 if issue == 3

***********************5530155347008, 6211662120015"  
replace s1aq7a =.   if hid=="5530155347008" |hid=="6211662120015" & s1aq1==156
replace s1aq7b =.   if hid=="5530155347008" |hid=="6211662120015" & s1aq1==156

*************************5010550185011
replace s1aq7a =2   if hid=="5010550185011"  & s1aq1==156
replace s1aq3b =6   if hid=="5010550185011"  & s1aq1==156
replace s1aq3a =2   if hid=="5010550185011"  & s1aq1==156

*********************5013050129007, 6211662120003
replace s1aq8a =.   if hid=="5013050129007"|hid=="6211662120003"  & s1aq1==156
replace s1aq8b =.   if hid=="5013050129007"|hid=="6211662120003"  & s1aq1==156

*************************6211662120003
replace s1aq7a =3    if hid=="6211662120003"  & s1aq1==156
replace s1aq3b =11   if hid=="6211662120003"  & s1aq1==156
replace s1aq3a =3    if hid=="6211662120003"  & s1aq1==156

************************************5320953206014
replace s1aq6a =8     if hid=="5320953206014"  & s1aq1==156
replace s1aq4a =8     if hid=="5320953206014"  & s1aq1==156
replace s1aq3b =11    if hid=="5320953206014"  & s1aq1==156
replace s1aq5  =40    if hid=="5320953206014"  & s1aq1==156

************************************6211662120015
replace s1aq6a =10     if hid=="6211662120015"  & s1aq1==156
replace s1aq4a =10     if hid=="6211662120015"  & s1aq1==156
replace s1aq3a =10     if hid=="6211662120015"  & s1aq1==156
replace s1aq3b =11     if hid=="6211662120015"  & s1aq1==156
replace s1aq5  =100    if hid=="6211662120015"  & s1aq1==156

*************************4520145212016
replace s1aq6a =17    if hid=="4520145212016"  & s1aq1==156
replace s1aq6b =11    if hid=="4520145212016"  & s1aq1==156
replace s1aq3b =11    if hid=="4520145212016"  & s1aq1==156

**************************5111551117008
replace s1aq8a =2     if hid=="5111551117008"  & s1aq1==156
replace s1aq8b =11    if hid=="5111551117008"  & s1aq1==156
replace s1aq3b =11    if hid=="5111551117008"  & s1aq1==156

**************************6211962107009
replace s1aq8a =1     if hid=="6211962107009"  & s1aq1==156
replace s1aq8b =11    if hid=="6211962107009"  & s1aq1==156
replace s1aq3b =11    if hid=="6211962107009"  & s1aq1==156
replace s1aq3a =2     if hid=="6211962107009"  & s1aq1==156

************************6314263133009
replace s1aq6a =4    if hid=="6314263133009"  & s1aq1==156
replace s1aq6b =6    if hid=="6314263133009"  & s1aq1==156
replace s1aq3b =6    if hid=="6314263133009"  & s1aq1==156
replace s1aq5  =.    if hid=="6314263133009"  & s1aq1==156

drop issue 
gen issue = 3  if s1aq1  == 156 & s1aq5==20
replace s1aq3a = 2 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 2 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 2 if issue == 3
replace s1aq6b = 11 if issue == 3

*****************6314263133011
replace s1aq7a =9     if hid=="6314263133011"  & s1aq1==156
replace s1aq7b =11    if hid=="6314263133011"  & s1aq1==156
replace s1aq3b =11    if hid=="6314263133011"  & s1aq1==156
replace s1aq3a =9     if hid=="6314263133011"  & s1aq1==156

********************************************************
***************************Pumpkin
br  hid s1aq2 s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b tot_consumed if s1aq1==157 & s1aq3a!=tot_consumed & s1aq3a!=.

drop issue 
gen issue = 3  if s1aq1  == 157 & (s1aq5==25|s1aq5==50)
replace s1aq3a = 5 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 5 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 5 if issue == 3
replace s1aq6b = 6 if issue == 3

drop issue 
gen issue = 3  if s1aq1  == 157 & s1aq5==30 
replace s1aq3a = 3 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 3 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 3 if issue == 3
replace s1aq6b = 6 if issue == 3


drop issue
gen issue = 3  if s1aq1  == 157 & s1aq5==70 
replace s1aq3b = 6 if issue == 3
replace s1aq6a = 14 if issue == 3
replace s1aq6b = 6 if issue == 3

*****************************5220152222015, 4512045110005, 4512045110005
replace s1aq8a =.   if hid=="5220152222015"|hid=="4512045110005" & s1aq1==157
replace s1aq8b =.   if hid=="5220152222015"|hid=="4512045110005"   & s1aq1==157

******************************5120151202006
replace s1aq7a =.    if hid=="5120151202006"  & s1aq1==157
replace s1aq7b =.    if hid=="5120151202006"  & s1aq1==157

*****************************6320663227015
replace s1aq7a =12   if hid=="6320663227015"  & s1aq1==157
replace s1aq3b =6    if hid=="6320663227015"  & s1aq1==157

****************************6320763212008
replace s1aq3a =14  if hid=="6320763212008"  & s1aq1==157
replace s1aq6a =.   if hid=="6320763212008"  & s1aq1==157
replace s1aq6b =.   if hid=="6320763212008"  & s1aq1==157
replace s1aq3b =6   if hid=="6320763212008"  & s1aq1==157

drop issue 
gen issue = 3  if s1aq1  == 157 & s1aq5==10
replace s1aq3a = 2 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 2 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 2 if issue == 3
replace s1aq6b = 6 if issue == 3

drop issue 
gen issue = 3  if s1aq1  == 157 & s1aq5==. & s1aq4a==. & s1aq6a==.  & s1aq8a==. 
replace s1aq3b = 6 if issue == 3
replace s1aq7a = s1aq3a if issue == 3
replace s1aq7b = 6 if issue == 3

drop issue 
gen issue = 3  if s1aq1  == 157 & s1aq5==20
replace s1aq3a = 4 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 4 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 4 if issue == 3
replace s1aq6b = 6 if issue == 3

********************************************************
***************************Garden Eggs
br  hid s1aq2 s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b tot_consumed if s1aq1==155 & s1aq3a!=tot_consumed & s1aq3a!=.

drop issue 
gen issue = 3  if s1aq1  == 155 & s1aq5==25
replace s1aq3a = 5 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 5 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 5 if issue == 3
replace s1aq6b = 6 if issue == 3

drop issue 
gen issue = 3  if s1aq1  == 155 & s1aq5==15
replace s1aq3a = 3 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 3 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 3 if issue == 3
replace s1aq6b = 6 if issue == 3

drop issue 
gen issue = 3  if s1aq1  == 155 & (s1aq5==20|s1aq5==21)
replace s1aq3a = 4 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 4 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 4 if issue == 3
replace s1aq6b = 6 if issue == 3

drop issue 
gen issue = 3  if s1aq1  == 155 & s1aq5==10
replace s1aq3a = 2 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 2 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 2 if issue == 3
replace s1aq6b = 6 if issue == 3

drop issue 
gen issue = 3  if s1aq1  == 155 & s1aq5==30
replace s1aq3a = 6 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 6 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 6 if issue == 3
replace s1aq6b = 6 if issue == 3

drop issue 
gen issue = 3  if s1aq1  == 155 & s1aq5==5
replace s1aq3a = 1 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 1 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 1 if issue == 3
replace s1aq6b = 6 if issue == 3

drop issue
gen issue = 3  if s1aq1  == 155 & s1aq5==357
replace s1aq3b = 6 if issue == 3
replace s1aq6a = 7 if issue == 3
replace s1aq6b = 6 if issue == 3

*********************5022350219003
replace s1aq3a =3   if hid=="5022350219003"  & s1aq1==155
*****************************************5022350219003,5013050129002
replace s1aq8a =.   if (hid=="5022350219003" |hid=="5013050129002") & s1aq1==155
replace s1aq8b =.   if (hid=="5022350219003" |hid=="5013050129002") & s1aq1==155


drop issue 
gen issue = 3  if s1aq1  == 155 & s1aq5==. & s1aq4a==. & s1aq6a==.  & s1aq7a==. & s1aq8a==. 
replace s1aq3b = 6 if issue == 3
replace s1aq8a = s1aq3a if issue == 3
replace s1aq8b = 6 if issue == 3

/* drop issue 
gen issue = 3  if s1aq1  == 155 & (s1aq5==. & s1aq4a==. & s1aq6a==. & s1aq7a!=. & s1aq7b!=. & s1aq8a==. & s1aq8b==. ) 
replace s1aq3b = 6 if issue == 3
replace s1aq7a = s1aq3a if issue == 3
replace s1aq7b = 6 if issue == 3 */

 drop issue 
gen issue = 3  if s1aq1  == 155 & (s1aq5==. & s1aq4a==. & s1aq6a==.  & s1aq7a==. & s1aq8a!=. & s1aq8b!=. ) 
replace s1aq3b = 6 if issue == 3
replace s1aq3a = s1aq8a if issue == 3
replace s1aq8b = 6 if issue == 3

drop issue 
gen issue = 3  if s1aq1  == 155 & (s1aq5==. & s1aq4a!=. & s1aq4b!=.  & s1aq6a==.  & s1aq7a==. & s1aq8a==. ) 
replace s1aq3b = 6 if issue == 3
replace s1aq3a = s1aq8a if issue == 3
replace s1aq8b = 6 if issue == 3
replace s1aq4a = . if issue == 3
replace s1aq4b = . if issue == 3

drop issue 
gen issue = 3  if s1aq1  == 155 & s1aq5==70 
replace s1aq3b = 6 if issue == 3
replace s1aq4a = s1aq3a if issue == 3
replace s1aq8b = 6 if issue == 3
replace s1aq6a = s1aq3a if issue == 3
replace s1aq4b = 6 if issue == 3

drop issue 
gen issue = 3  if s1aq1  == 155 & s1aq5==7 
replace s1aq3b = 6 if issue == 3
replace s1aq6a = s1aq3a if issue == 3
replace s1aq6b = 6 if issue == 3

*******************************5411654111011
replace s1aq3a =3   if hid=="5411654111011"  & s1aq1==155
replace s1aq3b =6   if hid=="5411654111011"  & s1aq1==155

*******************************5211052109012, 5012950104004, 5520255205003|hid=="5011050163012"
replace s1aq7a =.   if hid=="5211052109012"|hid=="5012950104004"|hid=="5520255205003"|hid=="5011050163012" & s1aq1==155
replace s1aq7b =.   if hid=="5211052109012"|hid=="5012950104004"|hid=="5520255205003"|hid=="5011050163012" & s1aq1==155

*******************************5411654115003, 5310953113003
replace s1aq8a =.   if hid=="5411654115003" |hid=="5310953113003" & s1aq1==155
replace s1aq8b =.   if hid=="5411654115003" |hid=="5310953113003" & s1aq1==155

replace s1aq3b =6   if hid=="5411654115003"  & s1aq1==155

***********************************6121661217006
replace s1aq4a =.   if hid=="6121661217006"  & s1aq1==155
replace s1aq4b =.   if hid=="6121661217006"  & s1aq1==155
replace s1aq6a =.   if hid=="6121661217006"  & s1aq1==155
replace s1aq6b =.   if hid=="6121661217006"  & s1aq1==155
replace s1aq3b =6   if hid=="6121661217006"  & s1aq1==155

**********************************5013050121014, 5012950104004
replace s1aq5 =35   if hid=="5013050121014"|hid=="5012950104004"  & s1aq1==155
**************************5110351125007
replace s1aq7a =4   if hid=="5110351125007"  & s1aq1==155

********************|hid=="5011050163012"
replace s1aq6a =14   if hid=="5011050163012"  & s1aq1==155
replace s1aq3b =6   if hid=="5011050163012"  & s1aq1==155
replace s1aq5 =.   if hid=="5011050163012"  & s1aq1==155

*********************5320653207002
replace s1aq4a =.   if hid=="5320653207002"  & s1aq1==155
replace s1aq4b =.   if hid=="5320653207002"  & s1aq1==155
replace s1aq7a =7   if hid=="5320653207002"  & s1aq1==155
replace s1aq3b =6   if hid=="5320653207002"  & s1aq1==155

******************************************************** 
***************************Fresh cow Milk
br  hid s1aq2 s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b tot_consumed if s1aq1==84 & s1aq3a!=tot_consumed & s1aq3a!=.

drop issue 
gen issue = 3  if s1aq1  == 84 & (s1aq5==150|s1aq5==175|s1aq5==1200)
replace s1aq3a = 5 if issue == 3
replace s1aq3b = 3 if issue == 3
replace s1aq4a = 5 if issue == 3
replace s1aq4b = 3 if issue == 3
replace s1aq6a = 5 if issue == 3
replace s1aq6b = 3 if issue == 3

drop issue 
gen issue = 3  if s1aq1  == 84 & s1aq5==225
replace s1aq3a = 7.5 if issue == 3
replace s1aq3b = 3 if issue == 3
replace s1aq4a = 7.5 if issue == 3
replace s1aq4b = 3 if issue == 3
replace s1aq6a = 7.5 if issue == 3
replace s1aq6b = 3 if issue == 3

*************************6121661217008
replace s1aq5 =25   if hid=="6121661217008"  & s1aq1==84

drop issue 
gen issue = 3  if s1aq1  == 84 & s1aq5==25
replace s1aq3a = 1 if issue == 3
replace s1aq3b = 3 if issue == 3
replace s1aq4a = 1 if issue == 3
replace s1aq4b = 3 if issue == 3
replace s1aq6a = 1 if issue == 3
replace s1aq6b = 3 if issue == 3

**********************************6112161122005, 6112161122006
replace s1aq4a =.   if hid=="6112161122005"|hid=="6112161122006"|hid=="6211662120014"|hid=="5111851133016"|hid=="6321163233014"  & s1aq1==84
replace s1aq4b =.   if hid=="6112161122005"|hid=="6112161122006"|hid=="6211662120014"|hid=="5111851133016"|hid=="6321163233014"  & s1aq1==84
replace s1aq6a =.   if hid=="6112161122005" |hid=="6112161122006"|hid=="6211662120014"|hid=="5111851133016"|hid=="6321163233014" & s1aq1==84
replace s1aq6b =.   if hid=="6112161122005" |hid=="6112161122006"|hid=="6211662120014"|hid=="5111851133016"|hid=="6321163233014"& s1aq1==84
replace s1aq3b =3   if hid=="6112161122005" |hid=="6112161122006"|hid=="6211662120014"|hid=="5111851133016"|hid=="6321163233014"& s1aq1==84

drop issue 
gen issue = 3  if s1aq1  == 84 & (s1aq5==. & s1aq4a==0 & s1aq4b!=.  ) 
replace s1aq6a = . if issue == 3
replace s1aq6b = . if issue == 3
replace s1aq4a = . if issue == 3
replace s1aq4b = . if issue == 3

***********************************6210662104001, 6112161122013, |hid=="6210262113014", 6210662104010
replace s1aq3b = 3 if hid=="6210662104001"|hid=="6112161122013"|hid=="6210262113014"|hid=="6210662104010" & s1aq1==84
replace s1aq3a = s1aq7a if hid=="6210662104001"|hid=="6112161122013"|hid=="6210262113014" |hid=="6210662104010" & s1aq1==84

***********************************6320763212013
replace s1aq3b = 3 if hid=="6320763212013"|hid=="6020260222001"|hid=="6120761209011" & s1aq1==84
replace s1aq3a = s1aq8a if hid=="6320763212013"|hid=="6020260222001"|hid=="6120761209011" & s1aq1==84


**********************hid=="6211662120014, 5111851133016, 6311163120016, 6112161122006, 5310353120005, 5321053215005, 5612056108009, 6210362118007, 6321163233014
replace s1aq3b = 3 if hid=="6211662120014"|hid=="5111851133016"|hid=="6311163120016"|hid=="6112161122006"|hid=="5310353120005"|hid=="5321053215005" & s1aq1==84
replace s1aq3a = s1aq7a if hid=="6211662120014"|hid=="5111851133016"|hid=="6311163120016"|hid=="6112161122006"|hid=="5310353120005"|hid=="5321053215005" & s1aq1==84

replace s1aq3b = 3 if hid=="5612056108009"|hid=="6210362118007"|hid=="6321163233014" & s1aq1==84
replace s1aq3a = s1aq7a  if hid=="5612056108009"|hid=="6210362118007"|hid=="6321163233014" & s1aq1==84

****************5111851133016
replace s1aq5=.  if hid=="5111851133016" & s1aq1==84

*************************6211662120014, 6311163120016, 6210362118007
replace s1aq8b = . if hid=="6211662120014"|hid=="6311163120016"|hid=="6210362118007" & s1aq1==84
replace s1aq8a = .  if hid=="6211662120014"|hid=="6311163120016"|hid=="6210362118007" & s1aq1==84

drop issue 
gen issue = 3  if s1aq1  == 84 & s1aq5==60
replace s1aq3a = 2 if issue == 3
replace s1aq3b = 3 if issue == 3
replace s1aq4a = 2 if issue == 3
replace s1aq4b = 3 if issue == 3
replace s1aq6a = 2 if issue == 3
replace s1aq6b = 3 if issue == 3

drop issue 
gen issue = 3  if s1aq1  == 84 & s1aq5==100
replace s1aq3a = 4 if issue == 3
replace s1aq3b = 3 if issue == 3
replace s1aq4a = 4 if issue == 3
replace s1aq4b = 3 if issue == 3
replace s1aq6a = 4 if issue == 3
replace s1aq6b = 3 if issue == 3

**************************5420654212015
replace s1aq7a=3  if hid=="5420654212015" & s1aq1==84
replace s1aq3b=3  if hid=="5420654212015" & s1aq1==84
replace s1aq3a=3  if hid=="5420654212015" & s1aq1==84

************************************6311163120004
replace s1aq3a=8  if hid=="6311163120004" & s1aq1==84
replace s1aq3b=3  if hid=="6311163120004" & s1aq1==84
replace s1aq7a=8  if hid=="6311163120004" & s1aq1==84
replace s1aq7b=3  if hid=="6311163120004" & s1aq1==84


********************************************************
***************************Fresh Gropper(Lady Fish)
br  hid s1aq2 s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b tot_consumed if s1aq1==61 & s1aq3a!=tot_consumed & s1aq3a!=.

drop issue 
gen issue = 3  if s1aq1  == 61 & (s1aq5==202|s1aq5==300)
replace s1aq3a = 2 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 2 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 2 if issue == 3
replace s1aq6b = 11 if issue == 3

************************5011850150013
replace s1aq5=200  if hid=="5011850150013" & s1aq1==61

******************************5221852211007
replace s1aq3b=11  if hid=="5221852211007" & s1aq1==61
replace s1aq8a=1   if hid=="5221852211007" & s1aq1==61
replace s1aq8b=11  if hid=="5221852211007" & s1aq1==61

*****************************6321163233004
replace s1aq3b=11  if hid=="6321163233004" & s1aq1==61
replace s1aq8b=11  if hid=="6321163233004" & s1aq1==61
replace s1aq4a=.   if hid=="6321163233004" & s1aq1==61
replace s1aq4b=.   if hid=="6321163233004" & s1aq1==61
replace s1aq6a=.   if hid=="6321163233004" & s1aq1==61
replace s1aq6b=.   if hid=="6321163233004" & s1aq1==61
replace s1aq7a=.   if hid=="6321163233004" & s1aq1==61
replace s1aq7b=.   if hid=="6321163233004" & s1aq1==61

********************************************************
***************************Fresh Bonga
br  hid s1aq2 s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b tot_consumed if s1aq1==59 & s1aq3a!=tot_consumed & s1aq3a!=.
****************5011350157002
replace s1aq5=20    if hid=="5011350157002" & s1aq1==59

drop issue 
gen issue = 3  if s1aq1  == 59 & (s1aq5==50|s1aq5==100|s1aq5==2|s1aq5==20)
replace s1aq3a = 2 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 2 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 2 if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3


drop issue
gen issue = 3  if s1aq1  == 59 & (s1aq5==125|s1aq5==250)
replace s1aq3a = 5 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 5 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 5 if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq5 = 50 if issue == 3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3

drop issue
gen issue = 3  if s1aq1  == 59 & (s1aq5==140)
replace s1aq3a = 14 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 14 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 14 if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3

drop issue
gen issue = 3  if s1aq1  == 59 & (s1aq5==30|s1aq5==330|s1aq5==750|s1aq5==105)
replace s1aq3a = 3 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 3 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 3 if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3

****************5311253117001
replace s1aq5=160    if hid=="5311253117001" & s1aq1==59

drop issue
gen issue = 3  if s1aq1  == 59 & (s1aq5==40|s1aq5==160|s1aq5==210)
replace s1aq3a = 4 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 4 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 4 if issue == 3
replace s1aq6b = 11 if issue == 3

drop issue
gen issue = 3  if s1aq1  == 59 & (s1aq5==80|s1aq5==88)
replace s1aq3a = 8 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 8 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 8 if issue == 3
replace s1aq6b = 11 if issue == 3

replace s1aq5=.    if hid=="5542255410013" & s1aq1==59
replace s1aq5=70    if hid=="5542255410003" & s1aq1==59

drop issue
gen issue = 3  if s1aq1  == 59 & (s1aq5==175|s1aq5==245|s1aq5==70)
replace s1aq3a = 7 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 7 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 7 if issue == 3
replace s1aq6b = 11 if issue == 3

drop issue
gen issue = 3  if s1aq1  == 59 & (s1aq5==150|s1aq5==60)
replace s1aq3a = 6 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 6 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 6 if issue == 3
replace s1aq6b = 11 if issue == 3

drop issue
gen issue = 3  if s1aq1  == 59 & (s1aq5==120|s1aq5==300)
replace s1aq3a = 12 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 12 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 12 if issue == 3
replace s1aq6b = 11 if issue == 3

********************************5220752220014, 5530155311010, 5123051208013,|hid=="6011360102013"
replace s1aq7a=.   if hid=="5220752220014"|hid=="5530155311010"|hid=="5123051208013"|hid=="6011360102013"|hid=="5012950107006"| hid=="5220952204007" & s1aq1==59
replace s1aq7b=.   if hid=="5220752220014"|hid=="5530155311010"|hid=="5123051208013"|hid=="6011360102013" |hid=="5012950107006"| hid=="5220952204007" & s1aq1==59

********************************6212762108008, 5612056108012, 5123051208013,|hid=="6011360102013", 6120261210015, 5122251233014, ,
replace s1aq8a=. if hid=="6212762108008"|hid=="5612056108012"|hid=="5123051208013"|hid=="6011360102013" |hid=="6120261210015"|hid=="5122251233014" & s1aq1==59
replace s1aq8b=. if hid=="6212762108008"|hid=="5612056108012"|hid=="5123051208013" |hid=="6011360102013"|hid=="6120261210015"|hid=="5122251233014" & s1aq1==59

*************************="5622056216006" |hid=="6212762108008
replace s1aq5=30   if hid=="5622056216006" |hid=="6212762108008" & s1aq1==59

*****************6011360102013
replace s1aq5=80   if hid=="6011360102013" & s1aq1==59

*************************5211452117005, 6022360207007, 5622056216006, 6323563229010
replace s1aq8a=. if hid=="5211452117005"|hid=="6022360207007" |hid=="5622056216006"|hid=="6323563229010" & s1aq1==59
replace s1aq8b=. if hid=="5211452117005" |hid=="6022360207007"|hid=="5622056216006"|hid=="6323563229010" & s1aq1==59

*************************5110751101016, 6022360207007, 6323563229010
replace s1aq7a=. if hid=="5110751101016"|hid=="6022360207007"|hid=="6323563229010"|hid=="6323563229010" & s1aq1==59
replace s1aq7b=. if hid=="5110751101016" |hid=="6022360207007" |hid=="6323563229010"& s1aq1==59

***********************5542255410013
replace s1aq3a=4    if hid=="5542255410013" & s1aq1==59
replace s1aq3b=11   if hid=="5542255410013" & s1aq1==59
replace s1aq4a=4    if hid=="5542255410013" & s1aq1==59
replace s1aq4b=11   if hid=="5542255410013" & s1aq1==59
replace s1aq6b=11   if hid=="5542255410013" & s1aq1==59
replace s1aq8a=.   if hid=="5542255410013" & s1aq1==59
replace s1aq8b=.   if hid=="5542255410013" & s1aq1==59


****************************5211452117004
replace s1aq5=175   if hid=="5211452117004" & s1aq1==59           

*****************************5542255410003, 5311253117001,5310353120009
replace s1aq5=.    if hid=="5542255410003"|hid=="5311253117001"|hid=="5310353120009" & s1aq1==59


**********************5620156228016,5542255410003, 5121251218014, 5310553123002,5311253117001,5211152102013
replace s1aq5=.  if hid=="5620156228016"|hid=="5542255410003"|hid=="5121251218014"|hid=="5310553123002"|hid=="5311253117001"|hid=="5211152102013" & s1aq1==59



******************************************************** 
***************************BIG RED PEPPER
br  hid s1aq2 s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b tot_consumed if s1aq1==158 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq5 = 15 if s1aq5 ==105 & s1aq1==158 
drop issue
gen issue = 3  if s1aq1  == 158 & (s1aq5==15|s1aq5==150)
replace s1aq3a = 3 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 3 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 3 if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq5 = .  if hid =="5011850150009" & s1aq1  == 158
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3

drop issue
gen issue = 3  if s1aq1  == 158 & s1aq5==35
replace s1aq7a = . if issue == 3
replace s1aq8b = . if issue == 3
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3

drop issue
gen issue = 3  if s1aq1  == 158 & s1aq5==25
replace s1aq3a = 5 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 5 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 5 if issue == 3
replace s1aq6b = 11 if issue == 3

drop issue
gen issue = 3  if s1aq1  == 158 & (s1aq5==10|s1aq5==5)
replace s1aq3a = 1 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 1 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 1 if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3

drop issue
gen issue = 3  if s1aq1  == 158 & s1aq5==30
replace s1aq3a = 6 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 6 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 6 if issue == 3
replace s1aq6b = 11 if issue == 3

drop issue
gen issue = 3  if s1aq1  == 158 & (s1aq5==6|s1aq5 == 40)
replace s1aq3a = 4 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 4 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 4 if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq5 = 40 if issue == 3
*************************5210652125001, 5222152223013, 5220952204012
replace s1aq7a=.    if hid=="5210652125001"|hid=="5222152223013"|hid=="5220952204012" & s1aq1==158
replace s1aq7b=.    if hid=="5210652125001" |hid=="5222152223013"|hid=="5220952204012"& s1aq1==158
****************************6320963209014
replace s1aq3a=4    if hid=="6320963209014" & s1aq1==158

drop issue
gen issue = 3  if s1aq1  == 158 & s1aq5==70
replace s1aq3a = 14 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 14 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 14 if issue == 3
replace s1aq6b = 11 if issue == 3

**************************6323963202007, 5621856206013
replace s1aq8a=.    if hid=="6323963202007"|hid=="5621856206013" & s1aq1==158
replace s1aq8b=.    if hid=="6323963202007" |hid=="5621856206013"& s1aq1==158

**************6321663215011
replace s1aq3b=6    if hid=="6321663215011" & s1aq1==158
replace s1aq4a=.    if hid=="6321663215011" & s1aq1==158
replace s1aq4b=.    if hid=="6321663215011" & s1aq1==158
replace s1aq6a=.    if hid=="6321663215011" & s1aq1==158
replace s1aq6b=.    if hid=="6321663215011" & s1aq1==158

***********************5110351125008
replace s1aq3b=7    if hid=="5110351125008" & s1aq1==158
replace s1aq7a=2    if hid=="5110351125008" & s1aq1==158
replace s1aq7b=7    if hid=="5110351125008" & s1aq1==158
replace s1aq4a=.    if hid=="5110351125008" & s1aq1==158
replace s1aq4b=.    if hid=="5110351125008" & s1aq1==158
replace s1aq6a=.    if hid=="5110351125008" & s1aq1==158
replace s1aq6b=.    if hid=="5110351125008" & s1aq1==158

*******************************6320363219003
replace s1aq8a=1     if hid=="6320363219003" & s1aq1==158
replace s1aq8b=11    if hid=="6320363219003" & s1aq1==158
replace s1aq3a=2     if hid=="6320363219003" & s1aq1==158

**********************5013050125012
replace s1aq7a=.    if hid=="5013050125012" & s1aq1==158
replace s1aq7b=.    if hid=="5013050125012" & s1aq1==158
replace s1aq5=.     if hid=="5013050125012"|hid=="5023050213011" & s1aq1==158

******************5023050213011, 6211662120006
replace s1aq7a = s1aq3a if hid =="5023050213011" |hid=="6211662120006"& s1aq1==158
replace s1aq3b = 11 if  hid =="5023050213011" |hid=="6211662120006"& s1aq1==158
replace s1aq4a = . if  hid =="5023050213011" |hid=="6211662120006"& s1aq1==158
replace s1aq4b = . if  hid =="5023050213011" |hid=="6211662120006"& s1aq1==158
replace s1aq6a = . if  hid =="5023050213011" |hid=="6211662120006"& s1aq1==158
replace s1aq6b = . if  hid =="5023050213011" |hid=="6211662120006"& s1aq1==158

drop issue
gen issue = 3  if s1aq1  == 158 & s1aq5==21
replace s1aq3a = 3 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 3 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 3 if issue == 3
replace s1aq6b = 11 if issue == 3

drop issue
gen issue = 3  if s1aq1  == 158 & s1aq5==20
replace s1aq3a = 2 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 2 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 2 if issue == 3
replace s1aq6b = 11 if issue == 3

drop issue
gen issue = 3  if s1aq1  == 158 & s1aq5==80
replace s1aq3a = 8 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 8 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 8 if issue == 3
replace s1aq6b = 11 if issue == 3

*************************, 5111651120006, 5111651120016, 5320653207011
replace s1aq7a = s1aq3a if hid =="5111651120006" |hid=="5111651120016"|hid=="5320653207011" & s1aq1==158
replace s1aq3b = 11   if  hid =="5111651120006" |hid=="5111651120016"|hid=="5320653207011"& s1aq1==158
replace s1aq4a = .    if  hid =="5111651120006" |hid=="5111651120016"|hid=="5320653207011"& s1aq1==158
replace s1aq4b = .    if  hid == "5111651120006" |hid=="5111651120016"|hid=="5320653207011"& s1aq1==158
replace s1aq6a = .    if  hid =="5111651120006" |hid=="5111651120016"|hid=="5320653207011" & s1aq1==158
replace s1aq6b = .    if  hid =="5111651120006" |hid=="5111651120016"|hid=="5320653207011" & s1aq1==158
replace s1aq8a = .    if  hid =="5111651120006" |hid=="5111651120016"|hid=="5320653207011" & s1aq1==158
replace s1aq8b = .    if  hid =="5111651120006" |hid=="5111651120016"|hid=="5320653207011" & s1aq1==158


****************************6122961212005, 6211662120007
replace s1aq3a = 11 if hid =="6122961212005" & s1aq1==158
replace s1aq3a = 2  if hid =="6211662120007" & s1aq1==158

replace s1aq5 = 200000 if(hid =="6122961212005"|hid=="6211662120002"| hid =="6024160214007"|hid=="6022260212009"| hid =="6211662120009"|hid=="6211662120007") & s1aq1==158 

drop issue
gen issue = 3  if s1aq1  == 158 & s1aq5==200000
replace s1aq3b = 11 if issue == 3
replace s1aq7a = s1aq3a if issue == 3
replace s1aq7b = 11 if issue == 3
replace s1aq4a = . if issue == 3
replace s1aq4b = . if issue == 3
replace s1aq6a = . if issue == 3
replace s1aq6b = . if issue == 3
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3
replace s1aq5 = . if issue == 3

*******************************6320963209014
replace s1aq3a = 3 if hid =="6320963209014" & s1aq1==158

***********************************************************************************
***************************ONION
br  hid s1aq2 s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b tot_consumed if s1aq1==164 & s1aq3a!=tot_consumed & s1aq3a!=.

drop issue
gen issue = 3  if s1aq1  == 164 & (s1aq5==70|s1aq5==315|s1aq5==600|s1aq5==7)
replace s1aq3a = 7 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 7 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 7 if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3  
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3  

replace s1aq5 = . if s1aq5 ==245 & s1aq1==164 

drop issue 
gen issue = 3  if s1aq1== 164 & (s1aq5==.)
replace s1aq5=s1aq3a if issue == 3 & hid=="5011850150006"|hid== "5013050117002"|hid=="5013050117006" 

drop issue
gen issue = 3  if s1aq1  == 164 & (s1aq5==50|s1aq5==250|s1aq5==500)
replace s1aq3a = 5 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 5 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 5 if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3  
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3  
replace s1aq5 = 50 if issue == 3  

drop issue
gen issue = 3  if s1aq1  == 164 & s1aq5==60
replace s1aq3a = 6 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 6 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 6 if issue == 3
replace s1aq6b = 11 if issue == 3

drop issue
gen issue = 3  if s1aq1  == 164 & (s1aq5==40|s1aq5==400)
replace s1aq3a = 1 if issue == 3
replace s1aq3b = 1 if issue == 3
replace s1aq4a = 1 if issue == 3
replace s1aq4b = 1 if issue == 3
replace s1aq6a = 1 if issue == 3
replace s1aq6b = 1 if issue == 3 
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3  
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3  
replace s1aq5 = 40 if issue == 3  


drop issue
gen issue = 3  if s1aq1  == 164 & (s1aq5==80|s1aq5==800|s1aq5==700)
replace s1aq3a = 2 if issue == 3
replace s1aq3b = 1 if issue == 3
replace s1aq4a = 2 if issue == 3
replace s1aq4b = 1 if issue == 3
replace s1aq6a = 2 if issue == 3
replace s1aq6b = 1 if issue == 3  
replace s1aq5 = 80 if issue == 3  

drop issue
gen issue = 3  if s1aq1  == 164 & (s1aq5==120|s1aq5==1200)
replace s1aq3a = 4 if issue == 3
replace s1aq3b = 1 if issue == 3
replace s1aq4a = 4 if issue == 3
replace s1aq4b = 1 if issue == 3
replace s1aq6a = 4 if issue == 3
replace s1aq6b = 1 if issue == 3  
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3  
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3  
replace s1aq5 = 120 if issue == 3  

drop issue
gen issue = 3  if s1aq1  == 164 & (s1aq5==150|s1aq5==140)
replace s1aq3a = 5 if issue == 3
replace s1aq3b = 1 if issue == 3
replace s1aq4a = 5 if issue == 3
replace s1aq4b = 1 if issue == 3
replace s1aq6a = 5 if issue == 3
replace s1aq6b = 1 if issue == 3  
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3  
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3  

drop issue
gen issue = 3  if s1aq1  == 164 & (s1aq5==35|s1aq5==105|s1aq5==280|s1aq5==210)
replace s1aq3a = 7 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 7 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 7 if issue == 3
replace s1aq6b = 11 if issue == 3  
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3  
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3  
replace s1aq5 = . if issue == 3  

drop issue
gen issue = 3  if s1aq1  == 164 & s1aq5==550
replace s1aq3a = 14 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 14 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 14 if issue == 3
replace s1aq6b = 11 if issue == 3  
replace s1aq5 = . if issue == 3  

drop issue
gen issue = 3  if s1aq1  == 164 & s1aq5==10
replace s1aq3a = 1 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 1 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 1 if issue == 3
replace s1aq6b = 11 if issue == 3 

drop issue
gen issue = 3  if s1aq1  == 164 & (s1aq5==300|s1aq5==3200)
replace s1aq3a = 3 if issue == 3
replace s1aq3b = 1 if issue == 3
replace s1aq4a = 3 if issue == 3
replace s1aq4b = 1 if issue == 3
replace s1aq6a = 3 if issue == 3
replace s1aq6b = 1 if issue == 3 
replace s1aq5 = .  if issue == 3
replace s1aq8a = .  if issue == 3
replace s1aq8b = .  if issue == 3
replace s1aq5 = . if issue == 3  

drop issue
gen issue = 3  if s1aq1  == 164 & s1aq5==350
replace s1aq3a = 7 if issue == 3
replace s1aq3b = 1 if issue == 3
replace s1aq4a = 7 if issue == 3
replace s1aq4b = 1 if issue == 3
replace s1aq6a = 7 if issue == 3
replace s1aq6b = 1 if issue == 3 
replace s1aq5 = . if issue == 3  

drop issue
gen issue = 3  if s1aq1  == 164 & s1aq5==20
replace s1aq3a = 2 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 2 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 2 if issue == 3
replace s1aq6b = 11 if issue == 3 
replace s1aq7a = . if issue == 3 
replace s1aq7b = . if issue == 3 

drop issue
gen issue = 3  if s1aq1  == 164 & s1aq5==100
replace s1aq3a = 10 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 10 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 10 if issue == 3
replace s1aq6b = 11 if issue == 3 
replace s1aq7a = . if issue == 3 
replace s1aq7b = . if issue == 3 

drop issue
gen issue = 3  if s1aq1  == 164 & (s1aq5==450|s1aq5==90)
replace s1aq3a = 9 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 9 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 9 if issue == 3
replace s1aq6b = 11 if issue == 3 
replace s1aq7a = . if issue == 3 
replace s1aq7b = . if issue == 3 
replace s1aq5 =  90 if issue == 3 


*******************4511945124011, 4511945124016 , 5012950109007
replace s1aq4b = 11 if hid =="4511945124011" |hid=="4511945124016"|hid=="5011850150009"|hid=="5012950109007"|hid=="5420754218006"|hid=="5310253111011" & s1aq1==164
replace s1aq4a = s1aq3a if hid =="4511945124011" |hid=="4511945124016"|hid=="5011850150009" |hid=="5012950109007"|hid=="5420754218006"|hid=="5310253111011"  & s1aq1==164
replace s1aq3b = 11 if hid =="4511945124011" |hid=="4511945124016"|hid=="5011850150009"|hid=="5012950109007" |hid=="5420754218006"|hid=="5310253111011" & s1aq1==164
replace s1aq6b = 11 if hid =="4511945124011" |hid=="4511945124016"|hid=="5011850150009"|hid=="5012950109007"|hid=="5420754218006"|hid=="5310253111011"  & s1aq1==164
replace s1aq6a = s1aq3a if hid =="4511945124011" |hid=="4511945124016" |hid=="5011850150009"|hid=="5012950109007"|hid=="5420754218006"|hid=="5310253111011"  & s1aq1==164

**********************************5310353120014, 5320653207014, hid=="5011850150009"  , 5012750140009, 5110151135009
replace s1aq5 = . if hid=="5310353120014" |hid=="5320653207014" |hid=="5011850150009"|hid=="5012750140009"|hid=="5020850205004"|hid=="5110151135009" & s1aq1==164 

**********************5110251114009, 5211152102016, 5211152102016, 5612056108011
replace s1aq5 = . if hid=="5110251114009"|hid=="5211152102016"|hid=="5612056108011" & s1aq1==164 

replace s1aq5 = . if s1aq5 ==800 & s1aq1==164 

replace s1aq5 = . if s1aq5 ==210 & s1aq1==164 

************************5120651225011
replace s1aq4b = 11 if hid =="5120651225011" & s1aq1==164 
replace s1aq6b = 11 if hid =="5120651225011" & s1aq1==164 
replace s1aq3b = 11 if hid =="5120651225011" & s1aq1==164
replace s1aq3a = 6  if hid =="5120651225011" & s1aq1==164 
replace s1aq7a = . if hid =="5120651225011" & s1aq1==164 
replace s1aq7b = . if hid =="5120651225011" & s1aq1==164 

*********************5111651120001
replace s1aq3b = 11 if hid =="5111651120001" & s1aq1==164
replace s1aq8a = . if hid =="5111651120001" & s1aq1==164 
replace s1aq8b = . if hid =="5111651120001" & s1aq1==164 

 **********************5120151204003
 replace s1aq5 = . if hid =="5120151204003" & s1aq1==164
replace s1aq7a = . if hid =="5120151204003" & s1aq1==164 
replace s1aq7b = . if hid =="5120151204003" & s1aq1==164 

 **********************5121851236007
 replace s1aq3b = 11 if hid =="5121851236007" & s1aq1==164
replace s1aq7a = 7 if hid =="5121851236007" & s1aq1==164 
replace s1aq7b = 11 if hid =="5121851236007" & s1aq1==164 

 **********************5310353120007
 replace s1aq5 = . if hid =="5310353120007" & s1aq1==164
replace s1aq3a = 6 if hid =="5310353120007" & s1aq1==164 
replace s1aq3b = 1 if hid =="5310353120007" & s1aq1==164 

 **********************5320653208001
 replace s1aq3b = 11 if hid =="5320653208001" & s1aq1==164
replace s1aq7a = 4 if hid =="5320653208001" & s1aq1==164 
replace s1aq7b = 11 if hid =="5320653208001" & s1aq1==164 

**********************5211052111005
 replace s1aq3b = 11 if hid =="5211052111005" & s1aq1==164
replace s1aq3a = 9 if hid =="5211052111005" & s1aq1==164 

******************5111751123006
replace s1aq3a = s1aq6a if hid =="5111751123006" & s1aq1==164 
drop issue
gen issue = 3  if s1aq1  == 164 & s1aq5==1
replace s1aq4a =s1aq3a if issue == 3
replace s1aq3b = 1 if issue == 3
replace s1aq6a =s1aq3a if issue == 3
replace s1aq4b = 1 if issue == 3
replace s1aq6b = 1 if issue == 3
replace s1aq5 =. if issue ==3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3  
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3  

 ***********************5211052111015
replace s1aq4b = 11 if hid =="5211052111015" & s1aq1==164 
replace s1aq6b = 11 if hid =="5211052111015" & s1aq1==164 
replace s1aq3b = 11 if hid =="5211052111015" & s1aq1==164
replace s1aq3a = 2  if hid =="5211052111015" & s1aq1==164 
replace s1aq4a = 2  if hid =="5211052111015" & s1aq1==164 
replace s1aq6a = 2  if hid =="5211052111015" & s1aq1==164 
replace s1aq7a = . if hid =="5211052111015" & s1aq1==164 
replace s1aq7b = . if hid =="5211052111015" & s1aq1==164 

***********************5211752113008
replace s1aq3a = 3  if hid =="5211752113008" & s1aq1==164 
replace s1aq3b = 11 if hid =="5211752113008" & s1aq1==164 
replace s1aq4a = . if hid =="5211752113008" & s1aq1==164 
replace s1aq4b = . if hid =="5211752113008" & s1aq1==164 

*********************5310253102015
replace s1aq3b = 11 if hid =="5310253102015" & s1aq1==164 
replace s1aq7a = 6 if hid =="5310253102015" & s1aq1==164 
replace s1aq7b = 11 if hid =="5310253102015" & s1aq1==164 

******************5420754220003
replace s1aq3a = 7  if hid =="5420754220003" & s1aq1==164 
replace s1aq3b = 11 if hid =="5420754220003" & s1aq1==164 
replace s1aq4a = 11 if hid =="5420754220003" & s1aq1==164 
replace s1aq6b = 11 if hid =="5420754220003" & s1aq1==164 

********************5530155311015
replace s1aq4b = 11 if hid =="5530155311015" & s1aq1==164
replace s1aq4a = s1aq3a if hid =="5530155311015"  & s1aq1==164
replace s1aq3b = 11 if hid =="5530155311015" & s1aq1==164
replace s1aq6b = 11 if hid =="5530155311015"  & s1aq1==164
replace s1aq6a = s1aq3a if hid == "5530155311015" & s1aq1==164

*********************5621856206013
replace s1aq3a = 3  if hid =="5621856206013" & s1aq1==164 
replace s1aq3b = 1 if hid =="5621856206013" & s1aq1==164 
replace s1aq4a = 3 if hid =="5621856206013" & s1aq1==164 
replace s1aq4b = 1 if hid =="5621856206013" & s1aq1==164 

*******************5612056108011
replace s1aq3b = 11 if hid =="5612056108011" & s1aq1==164 
replace s1aq4b = 11 if hid =="5612056108011" & s1aq1==164 
replace s1aq6a = 7  if hid =="5612056108011" & s1aq1==164 
replace s1aq6b = 11 if hid =="5612056108011" & s1aq1==164 

*****************6311063114009
replace s1aq3b = 11 if hid =="6311063114009" & s1aq1==164 
replace s1aq4a = 5  if hid =="6311063114009" & s1aq1==164 
replace s1aq4b = 11 if hid =="6311063114009" & s1aq1==164 
replace s1aq6a = 5  if hid =="6311063114009" & s1aq1==164 
replace s1aq6b = 11 if hid =="6311063114009" & s1aq1==164 

*********************6311063114016
replace s1aq3b = 11 if hid =="6311063114016" & s1aq1==164 
replace s1aq4a = 6  if hid =="6311063114016" & s1aq1==164 
replace s1aq4b = 11 if hid =="6311063114016" & s1aq1==164 
replace s1aq6a = 6  if hid =="6311063114016" & s1aq1==164 
replace s1aq6b = 11 if hid =="6311063114016" & s1aq1==164 

**********************6311963130011
replace s1aq3b = 11 if hid =="6311963130011" & s1aq1==164 
replace s1aq4a = 4  if hid =="6311963130011" & s1aq1==164 
replace s1aq4b = 11 if hid =="6311963130011" & s1aq1==164 
replace s1aq6a = 4  if hid =="6311963130011" & s1aq1==164 
replace s1aq6b = 11 if hid =="6311963130011" & s1aq1==164 

*******************************6321163233010
replace s1aq8a = . if hid =="6321163233010" & s1aq1==164 
replace s1aq8b = . if hid =="6321163233010" & s1aq1==164 

replace s1aq5 = . if s1aq5 ==475 & s1aq1==164 

drop issue
gen issue = 3  if s1aq1  == 164 & (s1aq5==. & s1aq4a==. & s1aq4b==. & s1aq6a==. & s1aq6b==. & s1aq7a ==. & s1aq7b==. & s1aq8b==. & s1aq8b==.)
replace s1aq3b = 11 if issue == 3
replace s1aq7a = s1aq3a if issue == 3
replace s1aq7b = 11 if issue == 3


**********************5121651214015, 5211152102009
replace s1aq5 = . if s1aq5 ==7014 & s1aq1==164 
replace s1aq5 = . if s1aq5 ==3 & s1aq1==164 

replace s1aq7a = . if hid =="5110351125013" & s1aq1==164 
replace s1aq7b = . if hid =="5110351125013" & s1aq1==164 
replace s1aq8a = . if hid =="5211152102016" & s1aq1==164 
replace s1aq8b = . if hid =="5211152102016" & s1aq1==164 

****************5110351125013, 5121651214015
replace s1aq6b = 11 if hid =="5110351125013"|hid=="5121651214015" & s1aq1==164 

replace s1aq5 = 200000 if(hid =="5110351125013"|hid=="5121651214015"| hid =="5211152102009"|hid=="5211152102016"| hid =="5530155356006"|hid=="6111361111013") & s1aq1==164 

drop issue
gen issue = 3  if s1aq1  == 164 & s1aq5==200000 
replace s1aq3b = s1aq6b if issue == 3
replace s1aq3a = s1aq6a if issue == 3
replace s1aq4a = s1aq6a if issue == 3
replace s1aq4b = s1aq6b if issue == 3
replace s1aq5 = . if issue ==3

********************5013050129002
replace s1aq3a = 1  if hid =="5013050129002" & s1aq1==164 
replace s1aq3b = 11 if hid =="5013050129002" & s1aq1==164 
replace s1aq4b = .  if hid =="5013050129002" & s1aq1==164 
replace s1aq6b = .  if hid =="5013050129002" & s1aq1==164 
replace s1aq4a = .  if hid =="5013050129002" & s1aq1==164 
replace s1aq6a = .  if hid =="5013050129002" & s1aq1==164 


*********************************************************166. Other vegetables, fresh or chilled Please Specify
*****************************5211052111006
replace s1aq3a = 1  if hid =="5211052111006" & s1aq1==166 
replace s1aq3b = 6  if hid =="5211052111006" & s1aq1==166 
replace s1aq4a = .  if hid =="5211052111006" & s1aq1==166 

********************************************************************************161.  Fresh Green Peas
***********************************5211152102009
replace s1aq3a = 3  if hid =="5211152102009" & s1aq1==164 
replace s1aq3b = 11 if hid =="5211152102009" & s1aq1==164 
replace s1aq4a = 3  if hid =="5211152102009" & s1aq1==164 
replace s1aq4b = 11 if hid =="5211152102009" & s1aq1==164 
replace s1aq6a = 3  if hid =="5211152102009" & s1aq1==164 
replace s1aq6b = 11 if hid =="5211152102009" & s1aq1==164 

************************************************************************************************
***************************GARLIC
br  hid s1aq2 s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b tot_consumed if s1aq1==165 & s1aq3a!=tot_consumed & s1aq3a!=.

drop issue
gen issue = 3  if s1aq1== 165 & (s1aq5==5|s1aq5==8)
replace s1aq3a = 1 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 1 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 1 if issue == 3
replace s1aq6b = 6 if issue == 3  

drop issue
gen issue = 3  if s1aq1== 165 & (s1aq5==15|s1aq5==24)
replace s1aq3a = 3 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 3 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 3 if issue == 3
replace s1aq6b = 6 if issue == 3  

drop issue
gen issue = 3  if s1aq1== 165 & (s1aq5==10|s1aq5==14)
replace s1aq3a = 2 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 2 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 2 if issue == 3
replace s1aq6b = 6 if issue == 3  

drop issue
gen issue = 3  if s1aq1== 165 & (s1aq5==25|s1aq5==125)
replace s1aq3a = 5 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 5 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 5 if issue == 3
replace s1aq6b = 6 if issue == 3  

drop issue
gen issue = 3  if s1aq1== 165 & (s1aq5==40|s1aq5==28|s1aq5==45)
replace s1aq3a = 4 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 4 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 4 if issue == 3
replace s1aq6b = 6 if issue == 3  

drop issue
gen issue = 3  if s1aq1== 165 & (s1aq5==70|s1aq5==7|s1aq5==287)
replace s1aq3a = 7 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 7 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 7 if issue == 3
replace s1aq6b = 6 if issue == 3  

drop issue
gen issue = 3  if s1aq1== 165 & s1aq5==30
replace s1aq3a = 6 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 6 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 6 if issue == 3
replace s1aq6b = 6 if issue == 3  

******************5120651225014, 5530155311015
replace s1aq3a = 8 if hid== "5530155311015" & s1aq1==165

drop issue 
gen issue = 3  if s1aq1  == 165 & (s1aq5==. & s1aq4a==. & s1aq4b==.  & s1aq6a==.  & s1aq7a==. & s1aq8a==. & s1aq7b==. & s1aq8b==.) 
replace s1aq3b = 6 if issue == 3
replace s1aq4a = s1aq3a if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = s1aq3a if issue == 3
replace s1aq6b = 6 if issue == 3

**************************5420554201002, 
replace s1aq3a = 3 if hid =="5420554201002" & s1aq1==165

************************5320653208001, 5420754218004
replace s1aq7b = . if hid =="5320653208001" |hid=="5420754218004" & s1aq1==165
replace s1aq7a = . if hid =="5320653208001" |hid=="5420754218004" & s1aq1==165

*************************6120561218016, 5542255410014
replace s1aq8b = . if hid =="6120561218016" |hid=="5542255410014" & s1aq1==165
replace s1aq8a = . if hid =="6120561218016" |hid=="5542255410014" & s1aq1==165

drop issue 
gen issue = 3  if s1aq1  == 165 & (s1aq5==.) 
replace s1aq3b = 6 if issue == 3
replace s1aq4a = s1aq3a if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = s1aq3a if issue == 3
replace s1aq6b = 6 if issue == 3

**********************************4520145212008, 5530155311006,6022460203002 
replace s1aq5 = . if hid =="4520145212008" |hid=="5530155311006" |hid=="6022460203002" & s1aq1==165 

drop issue
gen issue = 3  if s1aq1== 165 & s1aq5==20
replace s1aq3a = 2 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 2 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 2 if issue == 3
replace s1aq6b = 6 if issue == 3  


********************************************************
***************************Powdered milk
br  hid s1aq2 s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b tot_consumed if s1aq1==91 & s1aq3a!=tot_consumed & s1aq3a!=.
drop issue
gen issue = 3  if s1aq1== 91 & (s1aq5==.)
replace s1aq5=s1aq4a if issue == 3


drop issue
gen issue = 3  if s1aq1== 91 & (s1aq5==50)
replace s1aq3a = .5 if issue == 3
replace s1aq3b = 1 if issue == 3
replace s1aq4a = .5 if issue == 3
replace s1aq4b = 1 if issue == 3
replace s1aq6a = .5 if issue == 3
replace s1aq6b = 1 if issue == 3  

drop issue
gen issue = 3  if s1aq1== 91 & (s1aq5==25)
replace s1aq3a = .25 if issue == 3
replace s1aq3b = 1 if issue == 3
replace s1aq4a = .25 if issue == 3
replace s1aq4b = 1 if issue == 3
replace s1aq6a = .25 if issue == 3
replace s1aq6b = 1 if issue == 3  

drop issue
gen issue = 3  if s1aq1== 91 & (s1aq5==200|s1aq5==2)
replace s1aq3a = 2 if issue == 3
replace s1aq3b = 1 if issue == 3
replace s1aq4a = 2 if issue == 3
replace s1aq4b = 1 if issue == 3
replace s1aq6a = 2 if issue == 3
replace s1aq6b = 1 if issue == 3  
replace s1aq5 = 200 if issue == 3

drop issue
gen issue = 3  if s1aq1== 91 & (s1aq5==150)
replace s1aq3a = 1.5 if issue == 3
replace s1aq3b = 1 if issue == 3
replace s1aq4a = 1.5 if issue == 3
replace s1aq4b = 1 if issue == 3
replace s1aq6a = 1.5 if issue == 3
replace s1aq6b = 1 if issue == 3  

replace s1aq8b = . if hid =="5211052111009" |hid=="5530155356006" & s1aq1==91
replace s1aq8a = . if hid =="5211052111009" |hid=="5530155356006" & s1aq1==91

drop issue
gen issue = 3  if s1aq1== 91 & (s1aq5==125)
replace s1aq3a = 1.25 if issue == 3
replace s1aq3b = 1 if issue == 3
replace s1aq4a = 1.25 if issue == 3
replace s1aq4b = 1 if issue == 3
replace s1aq6a = 1.25 if issue == 3
replace s1aq6b = 1 if issue == 3  

drop issue
gen issue = 3  if s1aq1== 91 & (s1aq5==270)
replace s1aq3a = 2.75 if issue == 3
replace s1aq3b = 1 if issue == 3
replace s1aq4a = 2.75 if issue == 3
replace s1aq4b = 1 if issue == 3
replace s1aq6a = 2.75 if issue == 3
replace s1aq6b = 1 if issue == 3  

drop issue
gen issue = 3  if s1aq1== 91 & (s1aq5==90)
replace s1aq3a = 1 if issue == 3
replace s1aq3b = 1 if issue == 3
replace s1aq4a = 1 if issue == 3
replace s1aq4b = 1 if issue == 3
replace s1aq6a = 1 if issue == 3
replace s1aq6b = 1 if issue == 3  

drop issue
gen issue = 3  if s1aq1== 91 & (s1aq5==15)
replace s1aq3a = 3 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 3 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 3 if issue == 3
replace s1aq6b = 6 if issue == 3  
replace s1aq1 = 94 if issue == 3  


***********************************SHEEP
**********************5210652125002, 5122851222005
replace s1aq3b = 1 if hid =="5210652125002" |hid=="5122851222005" & s1aq1==43
replace s1aq4a = 2 if hid =="5210652125002" |hid=="5122851222005" & s1aq1==43
replace s1aq4b = 1 if hid =="5210652125002" |hid=="5122851222005" & s1aq1==43
replace s1aq6a = 2 if hid =="5210652125002" |hid=="5122851222005" & s1aq1==43
replace s1aq6b = 1 if hid =="5210652125002" |hid=="5122851222005" & s1aq1==43
replace s1aq5= . if hid =="5210652125002"   |hid=="5122851222005" & s1aq1==43

****************************GOAT MEAT(MUTTON)
**************************
drop issue
gen issue = 3  if s1aq1== 48 & (s1aq5==.)
replace s1aq3b = 1 if issue == 3
replace s1aq7a = s1aq3a if issue == 3
replace s1aq7b = 1 if issue == 3
replace s1aq6a = . if issue == 3
replace s1aq6b = . if issue == 3  
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3  
replace s1aq4a = . if issue == 3
replace s1aq4b = . if issue == 3  

****************6022360207001
replace s1aq3b = 1 if hid =="6022360207001" & s1aq1==48
replace s1aq6a = 2 if hid =="6022360207001" & s1aq1==48
replace s1aq6b = 1 if hid =="6022360207001" & s1aq1==48

*****************************************************************
************************WHOLE FROZEN
****************************5211452117011
drop issue
gen issue = 3  if s1aq1== 50 & (s1aq5==.)
replace s1aq3b = 6 if issue == 3
replace s1aq3a = s1aq8a if issue == 3
replace s1aq8b = . if issue == 3
replace s1aq6a = 1 if issue == 3
replace s1aq6b = 6 if issue == 3  
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3  
replace s1aq4a = 1 if issue == 3
replace s1aq4b = 6 if issue == 3  

********************************************************
***************************CARROT
br  hid s1aq2 s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b tot_consumed if s1aq1==163 & s1aq3a!=tot_consumed & s1aq3a!=.

drop issue
gen issue = 3  if s1aq1  == 163 & s1aq5==15
replace s1aq3a = 1 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 1 if issue == 3
replace s1aq4a = 1 if issue == 3
replace s1aq6a = 1 if issue == 3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3

drop issue
gen issue = 3  if s1aq1  == 163 & (s1aq5==204|s1aq5==20)
replace s1aq3a = 2 if issue == 3
replace s1aq3b = 1 if issue == 3
replace s1aq4a = 2 if issue == 3
replace s1aq4b = 1 if issue == 3
replace s1aq6a = 2 if issue == 3
replace s1aq6b = 1 if issue == 3
replace s1aq5 = 20 if issue == 3

*******************5013050129002, 5020150236007, 5022350219003, 5530155356006, 5530155356016
replace s1aq3b = 6     if hid =="5013050129002" |hid=="5020150236007"|hid=="5022350219003"|hid=="5530155356016"|hid=="5530155356006" & s1aq1==163
replace s1aq4a =s1aq3a if hid =="5013050129002" |hid=="5020150236007"|hid=="5022350219003"|hid=="5530155356016"|hid=="5530155356006" & s1aq1==163
replace s1aq4b = 6     if hid =="5013050129002" |hid=="5020150236007"|hid=="5022350219003"|hid=="5530155356016"|hid=="5530155356006" & s1aq1==163
replace s1aq6a = s1aq3a if hid =="5013050129002" |hid=="5020150236007"|hid=="5022350219003"|hid=="5530155356016"|hid=="5530155356006" & s1aq1==163
replace s1aq6b = 6      if hid =="5013050129002" |hid=="5020150236007"|hid=="5022350219003"|hid=="5530155356016"|hid=="5530155356006" & s1aq1==163
replace s1aq5= .        if hid=="5530155356006" & s1aq1==163
replace s1aq7a= .       if hid=="5530155356016" & s1aq1==163
replace s1aq7b= .       if hid=="5530155356016" & s1aq1==163

**************************************************************************************95.  Cream
drop issue
gen issue = 3  if s1aq1  == 95 & (s1aq5==30)
replace s1aq3a = 1 if issue == 3
replace s1aq3b = 3 if issue == 3
replace s1aq4a = 1 if issue == 3
replace s1aq4b = 3 if issue == 3
replace s1aq6a = 1 if issue == 3
replace s1aq6b = 3 if issue == 3

drop issue
gen issue = 3  if s1aq1  == 95 & (s1aq5==20)
replace s1aq3a = 0.75 if issue == 3
replace s1aq3b = 3 if issue == 3
replace s1aq4a = 0.75 if issue == 3
replace s1aq4b = 3 if issue == 3
replace s1aq6a = 0.75 if issue == 3
replace s1aq6b = 3 if issue == 3

drop issue
gen issue = 3  if s1aq1  == 95 & (s1aq5==80)
replace s1aq3a = 2.75 if issue == 3
replace s1aq3b = 3 if issue == 3
replace s1aq4a = 2.75 if issue == 3
replace s1aq4b = 3 if issue == 3
replace s1aq6a = 2.75 if issue == 3
replace s1aq6b = 3 if issue == 3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3

drop issue
gen issue = 3  if s1aq1  == 95 & (s1aq5==140)
replace s1aq3a = 5 if issue == 3
replace s1aq3b = 3 if issue == 3
replace s1aq4a = 5 if issue == 3
replace s1aq4b = 3 if issue == 3
replace s1aq6a = 5 if issue == 3
replace s1aq6b = 3 if issue == 3

******************************************************************88.  Skimmed milk
drop issue
gen issue = 3  if s1aq1  == 88 & (s1aq5==50)
replace s1aq3a = 2 if issue == 3
replace s1aq3b = 6 if issue == 3
replace s1aq4a = 2 if issue == 3
replace s1aq4b = 6 if issue == 3
replace s1aq6a = 2 if issue == 3
replace s1aq6b = 6 if issue == 3

********************************************************	79.  Crabs
******************************6320763212009
replace s1aq3a = 2   if hid =="6320763212009" & s1aq1==79 
replace s1aq3b = 11  if hid =="6320763212009" & s1aq1==79 
replace s1aq4b = 11  if hid =="6320763212009" & s1aq1==79 
replace s1aq6b = 11  if hid =="6320763212009" & s1aq1==79 
replace s1aq4a = 2   if hid =="6320763212009" & s1aq1==79 
replace s1aq6a = 2   if hid =="6320763212009" & s1aq1==79 
replace s1aq7a = .   if hid =="6320763212009" & s1aq1==79 
replace s1aq7b = .   if hid =="6320763212009" & s1aq1==79 
replace s1aq8a = .   if hid =="6320763212009" & s1aq1==79 
replace s1aq8b = .   if hid =="6320763212009" & s1aq1==79 


****************************************************	68.  Other Fish, live, fresh, chilled or frozen  Please Specify
***********************************************6311963130002
replace s1aq3b = 11  if hid =="6311963130002" & s1aq1==68 
replace s1aq4a = .   if hid =="6311963130002" & s1aq1==68 
replace s1aq4b = .   if hid =="6311963130002" & s1aq1==68 
replace s1aq7a = 2   if hid =="6311963130002" & s1aq1==68 
replace s1aq7b = 11  if hid =="6311963130002" & s1aq1==68

***********************************************67.  Fresh Mackerel Fish
drop issue
gen issue = 3  if s1aq1  == 67 & (s1aq5==100)
replace s1aq3a = 2 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 2 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6a = 2 if issue == 3
replace s1aq6b = 11 if issue == 3

drop issue
gen issue = 3  if s1aq1  == 67 & (s1aq5==25)
replace s1aq3a = 1 if issue == 3
replace s1aq3b = 11 if issue == 3
replace s1aq4a = 1 if issue == 3

***********************************************65.  Fresh small sardine
drop issue
gen issue = 3  if s1aq1  == 65 & (s1aq5==90)
replace s1aq3a = 3 if issue == 3
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3

drop issue
gen issue = 3  if s1aq1  == 65 & (s1aq5==30)
replace s1aq3b = 11 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq7a = . if issue == 3
replace s1aq7b = . if issue == 3
replace s1aq8a = . if issue == 3
replace s1aq8b = . if issue == 3

drop issue
gen issue = 3  if s1aq1  == 65 & (s1aq5==100)
replace s1aq3b = 11 if issue == 3
replace s1aq4b = 11 if issue == 3
replace s1aq6b = 11 if issue == 3
replace s1aq3a = 2 if issue == 3
replace s1aq4a = 2 if issue == 3


*********************************************************************************60.  Cat Fish
drop issue
gen issue = 3  if s1aq1  == 60 & (s1aq5==50)
replace s1aq3b = 6 if issue == 3
replace s1aq3a = 2 if issue == 3
replace s1aq4a = 2 if issue == 3
replace s1aq6a = 2 if issue == 3

***************************************************************************************5120151204002
replace s1aq3b = 6   if hid =="5120151204002" & s1aq1==60
replace s1aq3a = 4   if hid =="5120151204002" & s1aq1==60 
replace s1aq4a = 4   if hid =="5120151204002" & s1aq1==60 

***************************************************************************************6311963128011
replace s1aq3b = 11   if hid =="6311963128011" & s1aq1==60
replace s1aq3a = 1    if hid =="6311963128011" & s1aq1==60 

***************************************************************************161.Fresh Green Peas
*********************************5211152102009
replace s1aq3b = 11   if hid =="5211152102009" & s1aq1==161
replace s1aq3a = 3    if hid =="5211152102009" & s1aq1==161


 
**************** 85 sour milk *********************
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 85 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

drop issue
gen issue = 1 if s1aq1  == 85 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq5 = 500 if s1aq5 == 50 & issue == 1
replace s1aq5 = 50 if s1aq5 == 10 & issue == 1
replace s1aq5 = 50 if s1aq5 == 8 & issue == 1
replace s1aq5 = 50 if s1aq5 == 15 & issue == 1
replace s1aq5 = 300 if s1aq5 == 175 & issue == 1
replace s1aq5 = 150 if s1aq5 == 30 & issue == 1
replace s1aq5 = 100 if s1aq5 == 20 & issue == 1

replace s1aq3a = s1aq6a if issue == 1
replace s1aq3b = 3 if issue == 1
replace s1aq4b = 3 if issue == 1
replace s1aq6b = 3 if issue == 1

drop issue


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 85 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if  s1aq1  == 85 & s1aq3a!=. & s1aq4a==. & s1aq5==. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq3a = 8 if s1aq3a == 98 & issue == 1
replace s1aq7a = s1aq3a if issue == 1
replace s1aq8a = . if issue == 1

replace s1aq3b = 3 if issue == 1
replace s1aq7b = 3 if issue == 1
replace s1aq8b = . if issue == 1

drop issue


///6122661205005
br hid-s1aq8b tot_consumed if hid =="6122661205005"  & s1aq1==85
recode s1aq3a (21=3) if hid =="6122661205005" & s1aq1==85
recode s1aq4a (0=.) if hid =="6122661205005" & s1aq1==85
recode s1aq6a (3=.) if hid =="6122661205005" & s1aq1==85
recode s1aq3b (0=3) if hid =="6122661205005" & s1aq1==85
recode s1aq4b (3=.) if hid =="6122661205005" & s1aq1==85
recode s1aq6b (0=.) if hid =="6122661205005" & s1aq1==85



///4520145212016
br hid-s1aq8b tot_consumed if hid =="4520145212016"  & s1aq1==85
recode s1aq6a (.=7) if hid =="4520145212016" & s1aq1==85
recode s1aq3b (0=3) if hid =="4520145212016" & s1aq1==85
recode s1aq6b (.=3) if hid =="4520145212016" & s1aq1==85



///6120761209015
br hid-s1aq8b tot_consumed if hid =="6120761209015"  & s1aq1==85
recode s1aq3a (20=10) if hid =="6120761209015" & s1aq1==85
recode s1aq7a (.=10) if hid =="6120761209015" & s1aq1==85
recode s1aq3b (0=3) if hid =="6120761209015" & s1aq1==85
recode s1aq7b (.=3) if hid =="6120761209015" & s1aq1==85
recode s1aq4a (0=.) if hid =="6120761209015" & s1aq1==85
recode s1aq4b (3=.) if hid =="6120761209015" & s1aq1==85



*************** 81 oysters ******************
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 81 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if  s1aq1  == 81 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq5 = 200 if s1aq5 == 100 & hid == "5013050117006" & issue == 1
replace s1aq5 = 50 if s1aq5 == 40 & issue == 1
replace s1aq5 = 50 if s1aq5 == 80 & issue == 1
replace s1aq5 = 100 if s1aq5 == 50 & hid == "5612056108007" & issue == 1
replace s1aq3a = s1aq6a if issue == 1

replace s1aq3b = 10 if issue == 1
replace s1aq4b = 10 if issue == 1
replace s1aq6b = 10 if issue == 1

drop issue 


br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 81 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.


gen issue = 1 if s1aq1  == 81 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq5 = 50 if s1aq5 == 40 & issue == 1
replace s1aq5 = 100 if s1aq5 == 10 & issue == 1
replace s1aq6a = s1aq3a if issue == 1

replace s1aq3b = 10 if issue == 1
replace s1aq4b = 10 if issue == 1
replace s1aq6b = 10 if issue == 1

drop issue 



******************** 159 fresh green pepper ****************
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 159 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.


gen issue = 1 if s1aq1  == 159 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq8a = . if issue == 1
replace s1aq8b = . if issue == 1

replace s1aq3a = 5 if s1aq3a == 2 & hid == "5122551211002" & issue == 1
replace s1aq3a = 3 if s1aq3a == 5 & hid == "5211652115006" & issue == 1
replace s1aq3a = 3 if s1aq3a == 10 & hid == "5420554201009" & issue == 1
replace s1aq3a = 2 if s1aq3a == 10 & hid == "5530155356004" & issue == 1

replace s1aq4a = s1aq3a if issue == 1
replace s1aq6a = s1aq3a if issue == 1

replace s1aq3b = 6 if issue == 1
replace s1aq4b = 6 if issue == 1
replace s1aq6b = 6 if issue == 1

drop issue 


///5111951130002
br hid-s1aq8b tot_consumed if hid =="5111951130002"  & s1aq1==159
recode s1aq6a (.=2) if hid =="5111951130002" & s1aq1==159
recode s1aq5 (11=20) if hid =="5111951130002" & s1aq1==159
recode s1aq4a (10=2) if hid =="5111951130002" & s1aq1==159
recode s1aq6b (.=6) if hid =="5111951130002" & s1aq1==159
recode s1aq3b (0=6) if hid =="5111951130002" & s1aq1==159
recode s1aq4a (2=6) if hid =="5111951130002" & s1aq1==159


///5420754215012
br hid-s1aq8b tot_consumed if hid =="5420754215012"  & s1aq1==159
recode s1aq8a (.=3) if hid =="5420754215012" & s1aq1==159
recode s1aq4a (0=.) if hid =="5420754215012" & s1aq1==159
recode s1aq3b (0=6) if hid =="5420754215012" & s1aq1==159
recode s1aq4b (11=.) if hid =="5420754215012" & s1aq1==159
recode s1aq8b (.=6) if hid =="5420754215012" & s1aq1==159


///5530155339002
br hid-s1aq8b tot_consumed if hid =="5530155339002"  & s1aq1==159
recode s1aq8a (.=5) if hid =="5530155339002" & s1aq1==159
recode s1aq7a (4=.) if hid =="5530155339002" & s1aq1==159
recode s1aq8b (.=6) if hid =="5530155339002" & s1aq1==159
recode s1aq7b (11=.) if hid =="5530155339002" & s1aq1==159
recode s1aq3b (0=6) if hid =="5530155339002" & s1aq1==159



///5320653207008
br hid-s1aq8b tot_consumed if hid =="5320653207008"  & s1aq1==159
recode s1aq8a (.=8) if hid =="5320653207008" & s1aq1==159
recode s1aq7a (2=.) if hid =="5320653207008" & s1aq1==159
recode s1aq8b (.=6) if hid =="5320653207008" & s1aq1==159
recode s1aq7b (6=.) if hid =="5320653207008" & s1aq1==159
recode s1aq3b (0=6) if hid =="5320653207008" & s1aq1==159



****************** 72 dried couta/tanny *******************
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 72 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=.  & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if  s1aq1  == 72 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=.  & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = . if issue == 1 
replace s1aq8a = . if issue == 1 
replace s1aq7b = . if issue == 1 
replace s1aq8b = . if issue == 1 

replace s1aq5 = 5 if s1aq5 == 6 & issue == 1
replace s1aq5 = 40 if s1aq5 == 808 & issue == 1
replace s1aq5 = 15 if s1aq5 == 25 & issue == 1
replace s1aq3a = 3 if s1aq3a == .3 & issue == 1
replace s1aq3a = 1 if s1aq3a == 6 & issue == 1
replace s1aq3a = 5 if s1aq3a == .5 & issue == 1

replace s1aq4a = s1aq3a if issue == 1
replace s1aq6a = s1aq3a if issue == 1

replace s1aq3b = 6 if issue == 1
replace s1aq6b = 6 if issue == 1
replace s1aq4b = 6 if issue == 1

drop issue 



br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 72 & s1aq3a!=. & s1aq4a==. & s1aq5!=. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if s1aq1  == 72 & s1aq3a!=. & s1aq4a==. & s1aq5!=. & s1aq6a==. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq5 = . if issue == 1
replace s1aq8a = s1aq3a if issue == 1

replace s1aq3b = 6 if issue == 1
replace s1aq8b = 6 if issue == 1

drop issue 


///6322163222013
br hid-s1aq8b tot_consumed if hid =="6322163222013"  & s1aq1==72
recode s1aq8a (.=1) if hid =="6322163222013" & s1aq1==72
recode s1aq4a (50=.) if hid =="6322163222013" & s1aq1==72
recode s1aq8b (.=6) if hid =="6322163222013" & s1aq1==72
recode s1aq4b (1=.) if hid =="6322163222013" & s1aq1==72
recode s1aq3b (0=6) if hid =="6322163222013" & s1aq1==72



**************** 62 fresh baracuda ***************
br hid s1aq1 s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a s1aq7b s1aq8a s1aq8b if s1aq1  == 62 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

gen issue = 1 if s1aq1  == 62 & s1aq3a!=. & s1aq4a!=. & s1aq5!=. & s1aq6a!=. & s1aq2==1 & s1aq3a!=tot_consumed & s1aq3a!=.

replace s1aq7a = . if issue == 1
replace s1aq8a = . if issue == 1
replace s1aq7b = . if issue == 1
replace s1aq8b = . if issue == 1

replace s1aq3a = 4 if s1aq3a == 40 & issue == 1
replace s1aq3a = 5 if s1aq3a == 50 & issue == 1
replace s1aq3a = 1 if s1aq3a == 100 & issue == 1
replace s1aq3a = 7 if s1aq3a == 75 & issue == 1
replace s1aq5 = 350 if s1aq5 == 100 & hid == "5530155356004" & issue == 1
replace s1aq5 = 400 if s1aq5 == 50 & hid == "5420554201009" & issue == 1
replace s1aq5 = 100 if s1aq5 == 200 & issue == 1
replace s1aq5 = 500 if s1aq5 == 90 & issue == 1
replace s1aq5 = 500 if s1aq5 == 100  & hid == "5420554201007" & issue == 1

replace s1aq4a = s1aq3a if issue ==1 
replace s1aq6a = s1aq3a if issue ==1 

replace s1aq3b = 11 if issue ==1 
replace s1aq4b = 11 if issue ==1 
replace s1aq6b = 11 if issue ==1 

drop issue 


	*****************************************62.  Fresh Barracuda
**************************5310353120015
replace s1aq6a = 2  if hid =="5310353120015" & s1aq1==62 
replace s1aq6b = 11 if hid =="5310353120015" & s1aq1==62
replace s1aq3b = 11 if hid =="5310353120015" & s1aq1==62
replace s1aq4b = 11 if hid =="5310353120015" & s1aq1==62

***********************************onion
********************  5320653208001
replace s1aq7a = 4  if hid =="5320653208001" & s1aq1==164 
replace s1aq7b = 11 if hid =="5320653208001" & s1aq1==164 

****************************5013050129002
replace s1aq3a = 1  if hid =="5013050129002" & s1aq1==164 
replace s1aq3b = 11 if hid =="5013050129002" & s1aq1==164 
replace s1aq4a = .  if hid =="5013050129002" & s1aq1==164 
replace s1aq4b = . if hid =="5013050129002" & s1aq1==164 
replace s1aq6a = .  if hid =="5013050129002" & s1aq1==164 
replace s1aq6b = . if hid =="5013050129002" & s1aq1==164 

*******************************************************152.  Small Pepper-Fresh
*******************5320653208001
replace s1aq7a =7    if hid  =="5320653208001" & s1aq1==152 
replace s1aq7b =11   if hid  =="5320653208001" & s1aq1==152

*************************************GARDEN EGGS
****************************5022350219003, 5013050129002
replace s1aq8a =.    if (hid =="5022350219003"|hid=="5013050129002") & s1aq1==155 
replace s1aq8b =.    if  (hid =="5022350219003"|hid=="5013050129002") & s1aq1==155

********************************SMOKED FISH
**********************5530155356004
replace s1aq6a =2    if hid  =="5530155356004" & s1aq1==71
replace s1aq6b =11   if hid  =="5530155356004" & s1aq1==71

***************************Tilapia
*************************6121161214016
replace s1aq3a =4    if hid  =="6121161214016" & s1aq1==63




tempfile isatou
save `isatou'


****************************************************
************** COMPILE******************************
****************************************************
use cleaned_cases.dta, clear

******* Apennd
append using `isatou'

append using `davies'

append using `janneh'

append using `sering'

save "$temp\Food_1A_consumed_Mohammed_editted_April13_2022", replace



use "$temp\Food_1A_consumed_Mohammed_editted_April13_2022",clear

**** Additional fixes
drop tot_consumed 
egen tot_consumed = rowtotal( s1aq6a s1aq7a s1aq8a) 
 
br hid s1aq1 hhsize s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a  s1aq7b s1aq8a s1aq8b tot_consumed settlement_name settlement  lga if s1aq3a!=tot_consumed & s1aq3a!=.

*sort hid s1aq1
sort s1aq1

**************************
****** Remaining issues

//Remaining cases: Davies
///4220142208001
br hid-s1aq8b tot_consumed if hid =="4220142208001"  & s1aq1==84
recode s1aq3a (.1=1) if hid =="4220142208001" & s1aq1==84
recode s1aq8a (.1=1) if hid =="4220142208001" & s1aq1==84
replace s1aq3b = 3 if s1aq3b == 0  & s1aq1 == 84 & hid == "4220142208001"
replace s1aq8b = 3 if s1aq8b == .  & s1aq1 == 84 & hid == "4220142208001"

//3421234208009
replace s1aq4a = s1aq3a if s1aq1 == 84 & hid == "3421234208009"
replace s1aq4b = s1aq3b if s1aq1 == 84 & hid == "3421234208009"

replace s1aq6a = s1aq3a if s1aq1 == 84 & hid == "3421234208009"
replace s1aq6b = s1aq3b if s1aq1 == 84 & hid == "3421234208009"

replace s1aq7a = . if s1aq1 == 84 & hid == "3421234208009"
replace s1aq7b = . if s1aq1 == 84 & hid == "3421234208009"

replace s1aq8a = . if s1aq1 == 84 & hid == "3421234208009"
replace s1aq8b = . if s1aq1 == 84 & hid == "3421234208009"

//3721137209014
replace s1aq8a = . if s1aq1 == 84 & hid == "3721137209014"
replace s1aq8b = . if s1aq1 == 84 & hid == "3721137209014"

//3711637103005
replace s1aq8a = . if s1aq1 == 84 & hid == "3711637103005"
replace s1aq8b = . if s1aq1 == 84 & hid == "3711637103005"

//4120341211016
replace s1aq8a = . if s1aq1 == 84 & hid == "4120341211016"
replace s1aq8b = . if s1aq1 == 84 & hid == "4120341211016"

//4020540221007
replace s1aq8a = . if s1aq1 == 84 & hid == "4020540221007"
replace s1aq8b = . if s1aq1 == 84 & hid == "4020540221007"

//3711637103002
replace s1aq5 = 80 if s1aq1 == 84 & hid == "3711637103002"
replace s1aq8a = . if s1aq1 == 84 & hid == "3711637103002"
replace s1aq8b = . if s1aq1 == 84 & hid == "3711637103002"

//4022440219001
replace s1aq4a = s1aq3a if s1aq1 == 84 & hid == "4022440219001"
replace s1aq4b = s1aq3b if s1aq1 == 84 & hid == "4022440219001"

replace s1aq6a = s1aq3a if s1aq1 == 84 & hid == "4022440219001"
replace s1aq6b = s1aq3b if s1aq1 == 84 & hid == "4022440219001"

replace s1aq7a = . if s1aq1 == 84 & hid == "4022440219001"
replace s1aq7b = . if s1aq1 == 84 & hid == "4022440219001"

replace s1aq8a = . if s1aq1 == 84 & hid == "4022440219001"
replace s1aq8b = . if s1aq1 == 84 & hid == "4022440219001"

//Spinach
drop issue
gen issue = .

//3410334108015
replace s1aq3b = 11 if s1aq1 == 144 & hid == "3410334108015"
replace issue = 6 if s1aq1 == 144 & hid == "3410334108015"

//4021340217002
replace s1aq3a = 1 if s1aq1 == 144 & hid == "4021340217002"
replace s1aq3b = 11 if s1aq1 == 144 & hid == "4021340217002"
replace issue = 6 if s1aq1 == 144 & hid == "4021340217002"

//4010240101004
replace s1aq3a = 1 if s1aq1 == 144 & hid == "4010240101004"
replace s1aq3b = 11 if s1aq1 == 144 & hid == "4010240101004"
replace issue = 7 if s1aq1 == 144 & hid == "4010240101004"


//4021340214005
replace s1aq3a = 2 if s1aq1 == 144 & hid == "4021340214005"
replace s1aq3b = 11 if s1aq1 == 144 & hid == "4021340214005"
replace issue = 6 if s1aq1 == 144 & hid == "4021340214005"

//4410244105001
replace s1aq3a = 2 if s1aq1 == 144 & hid == "4410244105001"
replace s1aq3b = 11 if s1aq1 == 144 & hid == "4410244105001"
replace issue = 6 if s1aq1 == 144 & hid == "4410244105001"

//4410644110003
replace s1aq3a = 2 if s1aq1 == 144 & hid == "4410644110003"
replace s1aq3b = 11 if s1aq1 == 144 & hid == "4410644110003"
replace issue = 6 if s1aq1 == 144 & hid == "4410644110003"

//3621636211005
replace s1aq3a = 2 if s1aq1 == 144 & hid == "3621636211005"
replace s1aq3b = 11 if s1aq1 == 144 & hid == "3621636211005"
replace issue = 6 if s1aq1 == 144 & hid == "3621636211005"

//4110341105005
replace s1aq3a = 1 if s1aq1 == 144 & hid == "4110341105005"
replace s1aq3b = 11 if s1aq1 == 144 & hid == "4110341105005"
replace issue = 7 if s1aq1 == 144 & hid == "4110341105005"

//4121141207001
replace s1aq3a = 2 if s1aq1 == 144 & hid == "4121141207001"
replace s1aq3b = 11 if s1aq1 == 144 & hid == "4121141207001"
replace s1aq5 = 9.5 if s1aq1 == 144 & hid == "4121141207001"
replace issue = 6 if s1aq1 == 144 & hid == "4121141207001"

//4021340217001
replace s1aq3a = 1 if s1aq1 == 144 & hid == "4021340217001"
replace s1aq3b = 11 if s1aq1 == 144 & hid == "4021340217001"
replace issue = 7 if s1aq1 == 144 & hid == "4021340217001"

//4210242106008
replace s1aq3a = 4 if s1aq1 == 144 & hid == "4210242106008"
replace s1aq3b = 11 if s1aq1 == 144 & hid == "4210242106008"
replace issue = 7 if s1aq1 == 144 & hid == "4210242106008"

*4210442101014
*replace s1aq3a = 3 if s1aq1 == 144 & hid == "4210442101014"
*replace s1aq3b = 11 if s1aq1 == 144 & hid == "4210442101014"
*replace issue = 7 if s1aq1 == 144 & hid == "4210442101014"

//4210442101014
replace s1aq3a = 3 if s1aq1 == 146 & hid == "4210442101014"
replace s1aq3b = 11 if s1aq1 == 146 & hid == "4210442101014"
replace issue = 7 if s1aq1 == 146 & hid == "4210442101014"

**** general fix
replace s1aq4a = s1aq3a if issue == 6
replace s1aq4b = s1aq3b if issue == 6

replace s1aq6a = s1aq3a if issue == 6
replace s1aq6b = s1aq3b if issue == 6

replace s1aq7a = . if issue == 6
replace s1aq7b = . if issue == 6

replace s1aq8a = . if issue == 6
replace s1aq8b = . if issue == 6


replace s1aq4a = . if issue == 7
replace s1aq4b = . if issue == 7

replace s1aq6a = . if issue == 7
replace s1aq6b = . if issue == 7

replace s1aq5 = . if issue == 7

replace s1aq7a = s1aq3a if issue == 7
replace s1aq7b = s1aq3b if issue == 7

replace s1aq8a = . if issue == 7
replace s1aq8b = . if issue == 7

drop issue


**************************************************
********* Remaining cases assigned to Janneh

drop tot_consumed 
egen tot_consumed = rowtotal( s1aq6a s1aq7a s1aq8a) 
 
br hid s1aq1 hhsize s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a  s1aq7b s1aq8a s1aq8b tot_consumed settlement_name settlement  lga if s1aq3a!=tot_consumed & s1aq3a!=.

//3143531411012
replace s1aq8a = . if hid == "3143531411012" & s1aq1 == 59
replace s1aq8b = . if hid == "3143531411012" & s1aq1 == 59

//3240232403001 likely 5 pieces for 20
replace s1aq3b = 6 if hid == "3240232403001" & s1aq1 == 59

replace s1aq4a = s1aq3a if hid == "3240232403001" & s1aq1 == 59
replace s1aq4b = s1aq3b if hid == "3240232403001" & s1aq1 == 59

replace s1aq6a = s1aq3a if hid == "3240232403001" & s1aq1 == 59
replace s1aq6b = s1aq3b if hid == "3240232403001" & s1aq1 == 59

replace s1aq8a = . if hid == "3240232403001" & s1aq1 == 59
replace s1aq8b = . if hid == "3240232403001" & s1aq1 == 59

replace s1aq7a = . if hid == "3240232403001" & s1aq1 == 59
replace s1aq7b = . if hid == "3240232403001" & s1aq1 == 59

//3133631323013 maybe 8 pieces for 30
replace s1aq3a = 8 if s1aq3a == 28 & hid == "3133631323013" & s1aq1 == 59

replace s1aq4a = 8 if hid == "3133631323013" & s1aq1 == 59

replace s1aq6a = 8 if hid == "3133631323013" & s1aq1 == 59

replace s1aq8a = . if hid == "3133631323013" & s1aq1 == 59
replace s1aq8b = . if hid == "3133631323013" & s1aq1 == 59

//3143531421006 7 should be missing
replace s1aq7a = . if hid == "3143531421006" & s1aq1 == 59
replace s1aq7b = . if hid == "3143531421006" & s1aq1 == 59
 
 //3321433206010 7 should be missing
replace s1aq7a = . if hid == "3321433206010" & s1aq1 == 59
replace s1aq7b = . if hid == "3321433206010" & s1aq1 == 59

//3081730807010 7 should be missing
replace s1aq7a = . if hid == "3081730807010" & s1aq1 == 59
replace s1aq7b = . if hid == "3081730807010" & s1aq1 == 59

//3133631305010 7 should be missing
replace s1aq7a = . if hid == "3133631305010" & s1aq1 == 59
replace s1aq7b = . if hid == "3133631305010" & s1aq1 == 59

//3050330585007 missing unit
replace s1aq3b = 5 if hid == "3050330585007" & s1aq1 == 87
replace s1aq4a = s1aq3a if hid == "3050330585007" & s1aq1 == 87
replace s1aq6a = s1aq3a if hid == "3050330585007" & s1aq1 == 87
replace s1aq6b = s1aq3b if hid == "3050330585007" & s1aq1 == 87

//3311033102012 8 should be missing
replace s1aq8a = . if hid == "3311033102012" & s1aq1 == 151
replace s1aq8b = . if hid == "3311033102012" & s1aq1 == 151

//3090230919007 1 piece and gift
replace s1aq3b = 6 if hid == "3090230919007" & s1aq1 == 77
replace s1aq8a = s1aq3a if hid == "3090230919007" & s1aq1 == 77
replace s1aq8b = s1aq3b if hid == "3090230919007" & s1aq1 == 77

// 1120111202016 1 piece gift
replace s1aq3b = 6 if hid == "1120111202016" & s1aq1 == 78
replace s1aq8a = s1aq3a if hid == "1120111202016" & s1aq1 == 78
replace s1aq8b = s1aq3b if hid == "1120111202016" & s1aq1 == 78


** re-check
drop tot_consumed 
egen tot_consumed = rowtotal( s1aq6a s1aq7a s1aq8a) 
 
br hid s1aq1 hhsize s1aq3a s1aq3b s1aq4a s1aq4b s1aq5 s1aq6a s1aq6b s1aq7a  s1aq7b s1aq8a s1aq8b tot_consumed settlement_name settlement  lga if s1aq3a!=tot_consumed & s1aq3a!=.

sort hid s1aq1 

compress 
save "$temp\PART B Section 1A-Food_consumption expenditure-portion2_editted.dta", replace


********************************************************************************************************************************************************
********************************************************************************************************************************************************

