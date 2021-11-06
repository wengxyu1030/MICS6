///// MICS6-dofiles
// Household variables
// Do-file for the indicators:
/*
hh_water
hh_toilet
hh_id
hh_headed
hh_size
hh_urban
hh_sampleweight
hh_wealth_quintile
hh_wealthscore
hh_region_num
hh_region_lab
hh_religion
*/

	levelsof country_name, local(name) clean
preserve
	use "${SOURCE}/MICS/MICS6-`name'/MICS6-`name'hh.dta", clear
	local varnames "hc1a ws1 ws11"
	desc `varnames', replace	
	cd "${SOURCE}/MICS/MICS6-`name'"
	
	levelsof vallab, local(vallabelnames) clean
	di "`vallabelnames'"
	local i = 1
	foreach vallabelname in `vallabelnames' {
		local varname: word `i' of `varnames'
		cap label drop l_`varname'
		di "`vallabelname' to be applied to l_`varname'"
		label copy `vallabelname' l_`varname'
		local i = `i' + 1
	}
	
	label save l_hc1a l_ws1 l_ws11 using labelhh_`name'.do, replace
restore
run labelhh_`name'.do

* hh_water
	rename ws1 hh_water
	label values hh_water l_ws1
	
* hh_toilet
	rename ws11 hh_toilet
	label values hh_toilet l_ws11
	
* hh_id
	egen hh_id = concat(hh1 hh2), punct(_)
	
* hh_headed: educational level of household head
	gen hh_headed = helevel					
	recode hh_headed (0 = 1) (1 = 2) (2/6 = 3) (8/9 = .)    

* hh_size
	gen hh_size = hh48						
	recode hh_size (97/99 = .)	

* hh_urban:urban place of residence
	gen hh_urban = hh6						
	recode hh_urban (2 = 0)
	recode hh_urban (3 = 0)

* hh_sampleweight
	gen hh_sampleweight = hhweight 			

* hh_wealth_quintile; hh_wealthscore
	gen hh_wealth_quintile = .				
	gen hh_wealthscore = .					
	replace hh_wealth_quintile = windex5
	egen helper = min(wscore)
	replace hh_wealthscore = wscore - helper
	drop helper
	
* hh_region_num; hh_region_lab
	gen  hh_region_num	= hh7				
	decode (hh7), gen(hh_region_lab)
	
* hh_religion: religion of household head (DW Team Oct 2021)
	cap rename hc1a hh_religion
	cap label values hh_religion l_hc1a
