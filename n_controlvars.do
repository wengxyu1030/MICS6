// added to file 19_child_maternal.do
//===================================

	gen mat_ageatbrth = magebrt 				//mothers's age at birth
	
// added to file 9_child_anthro
//===================================
	gen c_motherln = uf4
	
	gen c_stuund = (c_stunted == 1 & c_underweight ==1) 
	replace c_stunted == . if c_stunted == . | c_underweight == . 
	label var c_sttund "1 if child both stunted and underweight"
	

	
// added to file 7_child_vax
//===================================
	//Child did not receive any vaccinations: 
	gen c_vaczero = (c_measles == 0 & c_polio1 == 0 & c_polio2 == 0 & c_polio3 == 0 & c_bcg == 0 & c_dtp1 == 0 & c_dtp2 == 0 & c_dtp3 == 0)
	foreach var in c_measles c_polio1 c_polio2 c_polio3 c_bcg c_dtp1 c_dtp2 c_dtp3{
		replace c_vaczero = . if `var' == .
	}
	label var c_vaczero "1 if child did not receive any vaccinations"
	
// added to file 20_household_sanitation?
//===================================
//hh.dta

	//Water source (hv201 in DHS HH dataset, already coded for MICS)
	gen h_watersource = ws1
	
	//Toilet type (hv205 “”, already coded for MICS)
	gen h_toilet = ws11
	
	//religion
	//religion might be hard since there is different charateristics in the religion and 
	//different countries are using different code - religion system
	
//bh.dta
	//Birth order (bord in DHS and brthord in MICS birth dataset)
	gen hm_birthorder = brthord

//wm.dta
	//1 if woman and mother currently married or living in union, 0 otherwise (v501 in DHS and ma1 in MICS woman dataset) – i.e. have it for both woman and child level observations
	//coded no response as .
	gen w_married = .
	replace w_married = 1 if mstatus == 1
	replace w_married = 0 if inrange(mstatus,2,8)
	

	
	