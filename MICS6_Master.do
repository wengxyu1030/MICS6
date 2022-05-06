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
	if "`c(username)'" == "crystalo"     local pc = 5
	
	if `pc' == 0 global root "/Users/zetianyuwang/Documents/PT_Data Whale/HEFPI/Data/MICS"
	if `pc' == 1 global root "C:/Users/XWeng/OneDrive - WBG/MEASURE UHC DATA - Sven Neelsen's files"
	if `pc' == 2 global root "D:/MEASURE UHC DATA"
	//if `pc' == 3 global root "/Users/ortsang/OneDrive - City University of New York/working/WB"
	if `pc' == 3 global root "D:/Drives/OneDrive - Cuny GradCenter/working/"
	if `pc' == 4 global root "/Users/robinwang/Documents/MEASURE UHC DATA"
	if `pc' == 5 global root "/Users/crystalo/Downloads"
	
* Define path for data sources
    global SOURCE "${root}/RAW DATA"
		if `pc' == 4 global SOURCE "/Volumes/Seagate Bas/HEFPI DATA/RAW DATA/"

* Define path for output data
	if `pc' == 0 global OUT "${root}/FINAL"
	if `pc' == 1 global OUT "${root}/STATA/DATA/SC/ADePT READY/MICS/New"
	if `pc' == 2 global OUT "${root}/STATA/DATA/SC/FINAL"
	if `pc' == 3 global OUT "${root}/etc/output"
	if `pc' == 4 global OUT "${root}/STATA/DATA/SC/FINAL"
	if `pc' == 5 global OUT "${root}/INTER"

* Define path for INTERMEDIATE
	if `pc' == 0 global INTER "${root}/INTER"
	if `pc' == 1 global INTER "${root}/STATA/DATA/SC/ADePT READY/MICS/Inter"
	if `pc' == 2 global INTER "${root}/STATA/DATA/SC/INTER"
	if `pc' == 3 global INTER "${root}/etc/inter"
	if `pc' == 4 global INTER "${root}/STATA/DATA/SC/INTER"
    if `pc' == 5 global INTER "${root}/INTER"
	
* Define path for do-files
	if `pc' == 0 global DO "/Users/zetianyuwang/Documents/PT_Data Whale/HEFPI/Code_github/MICS6"
	if `pc' == 1 global DO "${root}/STATA/DO/SC/06_Prepare_MICS6/MICS6_DW"
	if `pc' == 2 global DO "${root}/MICS6"
	//if `pc' == 3 global DO "/Users/ortsang/Documents/Github/MICS6"
	if `pc' == 3 global DO "D:/Drives/Github_Ortsang/MICS6"
	if `pc' == 4 global DO "/Users/robinwang/Documents/MEASURE UHC DATA/MICS6"
    if `pc' == 5 global DO "/Users/crystalo/Downloads/MICS6-main"
	
* Define the country names (in globals) by recode version

	global newMICS6countries "Algeria2018 Cuba2019 SaoTomeAndPrincipe2019 Kosovo2019 CentralAfricanRepublic2018 Nepal2019 StateofPalestine2019 Guinea-Bissau2018 Serbia2019 Turkmenistan2019 Tonga2019 Thailand2019 NorthMacedonia2018 Belarus2019 Chad2019 CostaRica2018 Ghana2017 Congodr2017 Bangladesh2019 Togo2017 Montenegro2018 Kiribati2018 Zimbabwe2019 Madagascar2018 LaoPDR2017 SierraLeone2017 Iraq2017 KyrgyzRepublic2018 Mongolia2018 Suriname2018 Gambia2018 Tunisia2018 Lesotho2018 Georgia2018"

foreach name in $newMICS6countries {
	clear 
	tempfile wm ch ch_itn bh

*******************************
***** Domains using WOMEN DATA*
*******************************

	use "${SOURCE}/MICS6-`name'/MICS6-`name'wm.dta", clear	

* Prepare
    cap drop country_name
	gen country_name = "`name'"
	cap drop bl2
	gen bl2 = 1 if wdoi - wdoblc < 25 // Birth in last two years
	
* Run do files for women data
    cap drop onedayfac
    cap drop pregPPA 
	cap drop infec 
	cap drop unmet_spc 
	cap drop unmet_lim 
	cap drop met_lim 
	cap drop met_spc 
	cap drop met 
	cap drop hm_male 
	cap drop hm_educ 
	cap drop hm_age_yrs 
	cap drop w_sampleweight 
    cap drop c_anc 
	cap drop c_anc_any 
	cap drop c_anc_ear 
	cap drop c_anc_ear_q 
	cap drop c_anc_eff 
	cap drop c_anc_eff_q 
	cap drop c_anc_ski 
	cap drop c_anc_ski_q 
	cap drop c_anc_bp 
	cap drop c_anc_bp_q 
	cap drop c_anc_bs 
	cap drop c_anc_bs_q  
	cap drop c_anc_ur 
	cap drop c_anc_ur_q 
	cap drop c_anc_ir 
	cap drop c_anc_ir_q 
	cap drop c_anc_tet 
	cap drop c_anc_tet_q 
	cap drop c_anc_eff2 
	cap drop c_anc_eff2_q 
	cap drop c_anc_eff3 
	cap drop c_anc_eff3_q
    do "${DO}/1_antenatal_care"
	
	cap drop c_hospdel 
	cap drop c_facdel 
	cap drop c_earlybreast
	cap drop c_skin2skin
	cap drop c_sba
	cap drop c_sba_q
	cap drop c_caesarean
	cap drop c_sba_eff1
	cap drop c_sba_eff1_q
	cap drop c_sba_eff2
	cap drop c_sba_eff2_q
    do "${DO}/2_delivery_care"
	
	cap drop c_pnc_any 
	cap drop c_pnc_eff 
	cap drop c_pnc_eff_q 
	cap drop c_pnc_eff2 
	cap drop c_pnc_eff2_q
    do "${DO}/3_postnatal_care"
	
	cap drop w_condom_conc 
	cap drop w_CPR 
	cap drop w_unmet_fp 
	cap drop w_need_fp 
	cap drop w_metany_fp 
	cap drop w_metmod_fp 
	cap drop w_metany_fp_q 
	cap drop w_married
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
    cap drop country_name
	gen country_name = "`name'"
		
* Run do files for child data
    cap drop c_measles c_bcg c_dpt1 c_dpt2 c_dpt3 c_polio1 c_polio2 c_polio3 c_fullimm c_vaczero
    do "${DO}/7_child_vaccination"
	
	cap drop c_diarrhea c_ari c_illness c_treatdiarrhea c_diarrhea_hmf c_diarrhea_med c_diarrhea_medfor c_diarrhea_pro c_diarrheaact c_diarrheaact_q c_diarrhea_mof c_sevdiarrhea c_sevdiarrheatreat c_sevdiarrheatreat_q c_treatARI c_illtreat
	do "${DO}/8_child_illness"
	
	cap drop c_underweight c_stuund c_motherln c_height c_weight c_hfa c_stunted c_stunted_sev c_wfa c_underweight c_underweight_sev c_wfh c_wasted c_wasted_sev 
    do "${DO}/9_child_anthropometrics"
	
* Housekeeping
    cap drop hm_male
	gen hm_male = hl4 // Child gender
	recode hm_male (2 = 0)	

	cap drop hm_age_yrs
	gen hm_age_yrs = ub2 // Child's age in years
	
	cap drop hm_age_mon
	gen hm_age_mon = cage // Child's age in months
	
	cap drop c_sampleweight
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
		global name = "`name'"
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
	mmerge hh1 hh2 hl1 using "${SOURCE}/MICS6-`name'/MICS6-`name'hl.dta"
	drop _merge

* Housekeeping
	replace hl1 = . if hl1 > 99	// "NOT listed" children in "bh" dataset
	rename hl1 ln
	replace hm_male = hl4
	recode hm_male (2 = 0)
	replace hm_age_yrs = hl6
	*gen hm_headrel = hl3   
	clonevar hm_headrel = hl3
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


	global trigger_change_structure = 1	
	
	if ${trigger_change_structure} == 1 {
		tempfile pre_hh
		save `pre_hh', replace

		use "${SOURCE}/MICS/MICS6-`name'/MICS6-`name'hh.dta", replace
		merge 1:m hh1 hh2 using `pre_hh'

		drop if _merge != 3 /*as the base is now HH.dta, must ensure _merge == 1 is screened out*/
		drop _merge		
	}
	if ${trigger_change_structure} == 0 {
	mmerge hh1 hh2 using "${SOURCE}/MICS/MICS6-`name'/MICS6-`name'hh.dta", nolabel
	drop if _merge == 2
	drop _merge
	}
	
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


