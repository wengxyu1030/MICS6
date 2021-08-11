
//This file is to help convert the spss files to dta files.

clear

global SOURCE "C:\Users\XWeng\OneDrive - WBG\MEASURE UHC DATA - Sven Neelsen's files\RAW DATA\MICS" //please change the directory accordingly

local name CostaRica2018 //please list the surveys with raw data that need to be converted

foreach a in bh ch fg fs hh hl mn tn wm {
clear
 cap import spss using "${SOURCE}/MICS6-`name'/`a'.sav", case(lower)
cap saveold "${SOURCE}/MICS6-`name'/MICS6-`name'`a'.dta", replace
cap erase "${SOURCE}/MICS6-`name'/`a'.sav"
}

