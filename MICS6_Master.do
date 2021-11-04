////////////////////////////////////////////////////////////////////////////////////////////////////
*** MICS MONITORING
////////////////////////////////////////////////////////////////////////////////////////////////////

version 14.0
clear all
set matsize 3956, permanent
set more off, permanent
set maxvar 32767, permanent
capture log close
sca drop _all
matrix drop _all
macro drop _all

******************************
*** Define main root paths ***
******************************

//NOTE FOR WINDOWS USERS : use "/" instead of "\" in your paths

* Define root depend on the stata user. 
	if "`c(username)'" == "zetianyuwang" local pc = 0
	if "`c(username)'" == "xweng"     local pc = 1
	if "`c(username)'" == "rwang"     local pc = 2
	//if "`c(username)'" == "ortsang"     local pc = 3
	if "`c(username)'" == "keicz"     local pc = 3
	if "`c(username)'" == "robinwang"     local pc = 4
	
	if `pc' == 0 global root "/Users/zetianyuwang/Documents/PT_Data Whale/HEFPI/Data/MICS"
	if `pc' == 1 global root "C:/Users/XWeng/OneDrive - WBG/MEASURE UHC DATA - Sven Neelsen's files"
	if `pc' == 2 global root "D:/MEASURE UHC DATA"
	//if `pc' == 3 global root "/Users/ortsang/OneDrive - City University of New York/working/WB"
	if `pc' == 3 global root "D:/Drives/OneDrive - Cuny GradCenter/working/"
	if `pc' == 4 global root "/Users/robinwang/Documents/MEASURE UHC DATA"
	
* Define path for data sources
    global SOURCE "${root}/RAW DATA"
	
* Define path for output data
	if `pc' == 0 global OUT "${root}/FINAL"
	if `pc' == 1 global OUT "${root}/STATA/DATA/SC/ADePT READY/MICS/New"
	if `pc' == 2 global OUT "${root}/STATA/DATA/SC/FINAL"
	if `pc' == 3 global OUT "${root}/etc/output"
	if `pc' == 4 global OUT "${root}/STATA/DATA/SC/FINAL"
	

* Define path for INTERMEDIATE
	if `pc' == 0 global INTER "${root}/INTER"
	if `pc' == 1 global INTER "${root}/STATA/DATA/SC/ADePT READY/MICS/Inter"
	if `pc' == 2 global INTER "${root}/STATA/DATA/SC/INTER"
	if `pc' == 3 global INTER "${root}/etc/inter"
	if `pc' == 4 global INTER "${root}/STATA/DATA/SC/INTER"

* Define path for do-files
	if `pc' == 0 global DO "/Users/zetianyuwang/Documents/PT_Data Whale/HEFPI/Code_github/MICS6"
	if `pc' == 1 global DO "${root}/STATA/DO/SC/06_Prepare_MICS6/MICS6_DW"
	if `pc' == 2 global DO "${root}/MICS6"
	//if `pc' == 3 global DO "/Users/ortsang/Documents/Github/MICS6"
	if `pc' == 3 global DO "D:/Drives/Github_Ortsang/MICS6"
	if `pc' == 4 global DO "/Users/robinwang/Documents/MEASURE UHC DATA/MICS6"

* Define the country names (in globals) by recode version
	global newMICS6countries "Nepal2019"


foreach name in $newMICS6countries {
	clear 
	tempfile wm ch ch_itn bh

*******************************
***** Domains using WOMEN DATA*
*******************************

	use "${SOURCE}/MICS/MICS6-`name'/MICS6-`name'wm.dta", clear	

* Prepare
	gen country_name = "`name'"
	gen bl2 = 1 if wdoi - wdoblc < 25 // Birth in last two years
	
* Run do files for women data
    do "${DO}/1_antenatal_care"
    do "${DO}/2_delivery_care"
    do "${DO}/3_postnatal_care"
	do "${DO}/4_sexual_health"

* Housekeeping for women data
	if inlist("`name'","Nepal2019") {
	drop welevel2  //there're both *level1 and *level2, to avoid the ambiguity of the specification, dropping the *level2 here. 
	}
	gen hm_male = 0 // Gender variable
	gen hm_educ = welevel // Educational level
	gen hm_age_yrs = wb4 // Age in years
	gen w_sampleweight = . // Woman's sample weight
	replace w_sampleweight = wmweight
	sort hh1 hh2 ln
	save `wm', replace

*******************************
***** Domains using CHILD DATA*
*******************************

	use "${SOURCE}/MICS/MICS6-`name'/MICS6-`name'ch.dta", clear	
* Prepare
	gen country_name = "`name'"
		
* Run do files for child data
    do "${DO}/7_child_vaccination"
	do "${DO}/8_child_illness"
    do "${DO}/9_child_anthropometrics"
	
* Housekeeping
	gen hm_male = hl4 // Child gender
	recode hm_male (2 = 0)	

	gen hm_age_yrs = ub2 // Child's age in years
	gen hm_age_mon = cage // Child's age in months
	gen c_sampleweight = chweight // Child's sample weight
		
	save `ch', replace

*******************************
***** Domains using ITN DATA*
*******************************	

	capture confirm file "${SOURCE}/MICS/MICS6-`name'/MICS6-`name'tn.dta"
	if !_rc {
	
		use "${SOURCE}/MICS/MICS6-`name'/MICS6-`name'tn.dta", clear	
	
* Prepare
		gen country_name = "`name'"
	
* Run do file
	do "${DO}/18_child_ITN.do"		
	}

* Housekeeping
	drop country_name
			
* Merge with child_temp
	merge 1:1 hh1 hh2 ln using `ch'
	drop _merge
	

	else{
	gen c_ITN = .
	}

	save `ch_itn', replace

***********************************
***** Domains using BIRTH DATA    *
***********************************
	
	capture confirm file "${SOURCE}/MICS/MICS6-`name'/MICS6-`name'bh.dta"
	if !_rc{					
		
	use "${SOURCE}/MICS/MICS6-`name'/MICS6-`name'bh.dta", clear
	do "${DO}/10_child_mortality.do"
	}
	
    //compared to old template: instead of specify the survey but in condition of the existence of bh.dta.
	else{
	foreach var in mor_dob mor_wln mor_ali mor_ade mor_afl hm_doi hm_dob mor_male mor_bord mor_int hm_live mor_wght hm_birthorder c_magebrt {
		gen `var' = .
		}
	}
	save `bh', replace
	

***********************************
***** Merge bh + ch + wm         **
***********************************	
	
	use `bh', clear
	
	// Give each birth unique line number - consistent with hh line number
	capture confirm var bh8
	if !_rc{
		rename bh8 ln
		}

	replace ln = 100 if (ln == 0 | ln == .)
	
	by hh1 hh2 ln, sort: gen check = _n
	forvalues i = 2 3 to 30 {
		replace ln = ln + `i' - 1 if check == `i'
	}                                       
	
	// Extra steps required for certain countries
	by hh1 hh2 ln, sort: gen check1 = _n
	if inlist("`name'","SierraLeone2017") {
	// they are two for the same line number, the one non-matching with the "hl" file has been deleted
		gen check2 = 1 if ((hh1 == 115 & hh2 == 24 & ln == 8) | (hh1 == 277 & hh2 == 15 & ln == 9) | (hh1 == 279 & hh2 == 12 & ln == 12) | (hh1 == 426 & hh2 == 10 & ln == 6) | (hh1 == 587 & hh2 == 25 & ln == 9))
		drop if check == 2 & check1 == 1 & check2 == 1
	}
	if inlist("`name'","Togo2017") {
		gen check2 = 1 if ((hh1 == 246 & hh2 == 11 & ln == 8 & mor_dob == 1372) | (hh1 == 246 & hh2 == 11 & ln == 7 & mor_dob == 1372))
		drop if check2 == 1
	}
	
	mmerge hh1 hh2 ln using `ch_itn'
	drop _merge

* merge with women
	mmerge hh1 hh2 ln using `wm'
	drop _merge
		
	if inlist("`name'","Nepal2019") {
	drop melevel2 //there're both *level1 and *level2, to avoid the ambiguity of the specification, dropping the *level2 here. 
	}

	do "${DO}/19_child_maternal_edu.do"

* Housekeeping
	keep hh1 hh2 hh7 ln c_* w_* mor_* hm_* 	
	rename ln hl1

***********************************
*****      Merge ind with hl     **
***********************************

* Merge individual level data with household listing
	mmerge hh1 hh2 hl1 using "${SOURCE}/MICS/MICS6-`name'/MICS6-`name'hl.dta"
	drop _merge

* Housekeeping
	replace hl1 = . if hl1 > 99	// "NOT listed" children in "bh" dataset
	rename hl1 ln
	replace hm_male = hl4
	recode hm_male (2 = 0)
	replace hm_age_yrs = hl6
	gen hm_headrel = hl3   
	gen country_name = "`name'"
	
	capture confirm variable hl7
	if !_rc {
		gen hm_stay = hl7
		recode hm_stay (7/9 = .)
		recode hm_stay (2 = 0)
	}
	else {
		gen hm_stay = .
	}
	
	keep hh1 hh2 ln c_* w_* mor_*  hm_*

***********************************
*****      Merge with hh         **
***********************************	

	mmerge hh1 hh2 using "${SOURCE}/MICS/MICS6-`name'/MICS6-`name'hh.dta"

	
	drop if _merge == 2
	drop _merge
	
	gen country_name = "`name'"
		
	if inlist("`name'","Nepal2019") {
		drop helevel2 //there're both *level1 and *level2, to avoid the ambiguity of the specification, dropping the *level2 here. 
	}	
	do "${DO}/20_hh_sanitation.do" 
	do "${DO}/15_household.do"
	do "${DO}/21_subnational_regions.do"

		
* Housekeeping
	keep hh1 hh2 ln hh_* c_* w_* mor_*  hm_* gl_adm1_code gl_adm0_code

***********************************
*****      Merge with iso        **
***********************************	
// StateofPalestine not availble in Countrycodes

	gen survey = "MICS"
	gen year = substr("`name'",-4,4)
	display "`name'"
	gen WB_cname = regexs(0) if regexm("`name'","([a-zA-Z]+)")
	
	replace WB_cname = "Lao PDR" if WB_cname == "LaoPDR"
	replace WB_cname = "Sierra Leone" if WB_cname == "SierraLeone"
	replace WB_cname = "Kyrgyz Republic" if WB_cname == "KyrgyzRepublic"
	replace WB_cname = "The Gambia" if WB_cname == "Gambia"
	replace WB_cname = "Dem. Rep. Congo" if WB_cname == "Congodr"
	replace WB_cname = "Costa Rica" if WB_cname == "CostaRica"
	replace WB_cname = "West Bank and Gaza" if WB_cname == "StateofPalestine"
	replace WB_cname = "Macedonia" if WB_cname == "NorthMacedonia"
	replace WB_cname = "Central African Republic" if WB_cname == "CentralAfricanRepublic"
	replace WB_cname = "Sao Tome and Principe" if WB_cname == "SaoTomeAndPrincipe"
	
	// Merges with country code data
	mmerge WB_cname using "${SOURCE}/CountryCodes.dta", ukeep(iso3c iso2c WB_cname WB_region) 
	egen x = max(_merge)   // this and following line are to assert that merge with country code worked -- if this produces an error, you need to align the country name with that in the country code dataset (WB_cname)
	
	assert x == 3
	drop if _merge == 2
	drop x _merge

	// Produces survey ID variable
	rename WB_cname country
	gen referenceid=iso3c+"_"+year+"_"+survey+"_v01"+"_M"  
	destring year, replace
			
	* Label variables
	do "${DO}/Lab_var.do"
		
	//rename (c_del_eff1 c_del_eff1_q c_del_eff2 c_del_eff2_q w_unmet c_measles_vacc c_mateduc ind_sampleweight mor_wdob mor_doi)(c_sba_eff1 c_sba_eff1_q c_sba_eff2 c_sba_eff2_q w_unmet_fp c_measles c_mateduc w_sampleweight hm_dob hm_doi)
		
* Save micro-dataset
	order survey year country hh1 hh2 ln  c_* w_* mor_* ln hm_* hh_*
	

	
	saveold "${OUT}/MICS6-`name'Adept.dta", replace

***********************************
*****      Quality Control       **
***********************************	
	do "${DO}/Quality_control.do" 
	save "${INTER}/Indicator_`name'.dta", replace  
*/
}		


