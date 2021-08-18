
//////////////////////////////
** Preliminary Quality Check *
//////////////////////////////


******************************
*** Define main root paths ***
******************************

//NOTE FOR WINDOWS USERS : use "/" instead of "\" in your paths

* Define root depend on the stata user. 
	if "`c(username)'" == "zetianyuwang" local pc = 0
	*if "`c(username)'" == ""     local pc = 1
	if `pc' == 0 global root "/Users/zetianyuwang/Documents/PT_Data Whale/HEFPI/Data/MICS"
	*if `pc' == 1 global root ""

* Define path for data sources
	global SOURCE "${root}/RAW DATA"

* Define path for output data
	global OUT "${root}/FINAL"

* Define path for INTERMEDIATE
	global INTER "${root}/INTER"

* Define path for do-files
	if `pc' == 0 global DO "/Users/zetianyuwang/Documents/PT_Data Whale/HEFPI/Code_local"
	*if `pc' != 0 global DO ""

* Define the country names (in globals) by recode version
	global MICS6countries "Zimbabwe2019"
	
	use "${OUT}/MICS6-${MICS6countries}Adept", clear
	*use "/Users/zetianyuwang/Desktop/MICS6-Bangladesh2019Adept.dta", clear
******************************
*** MICS indicators ***
******************************

* WM module	
	table country [iw = hh_sampleweight], c(mean c_anc mean c_anc_any mean c_facdel mean c_sba)
	
* Child module
	table country [iw = hh_sampleweight], c(mean c_bcg mean c_fullimm mean c_treatdiarrhea)
	
* Anthro module
	table country [iw = hh_sampleweight], c(mean c_stunted mean c_underweight)







