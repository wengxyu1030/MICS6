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

* hh_water
	rename ws1 hh_water
	label define l_ws1 11 "Piped into dwelling" 12 "Piped into Yard / Plot" 13 "Piped to Neighbour" ///
	14 "Public Tap / Standpipe" 21 "Tubewell / Borehole" 31 "Protected Well" 32 "Unprotecetd Well" ///
	41 "Protected Spring" 42 "Unprotected Spring" 51 "Rainwater" 61 "Tanker-Truck" 71 "Cart with Small Tank" ///
	81 "Surface Water (River, Dam, Lake, Pond, Stream, Canal, Irrigation Channel)" 91 "Bottled Water" ///
	93 "Jar Water" 96 "Others"
	label values hh_water l_ws1
	
* hh_toilet
	rename ws11 hh_toilet
	label define l_ws11 11 "Flush to Piped Sewer System" 12 "Flush to Septic Tank" 13 "Flush to Pit Latrine" ///
	14 "Flush to Open Drain" 18 "Flush to DK Where" 21 "Ventilated Improved Pit Latrine" ///
	22 "Pit Latrine with Slab" 23 "Pit Latrine without Slab / Open Pit" 31 "Composting Toilet" ///
	41 "Bucket" 95 "No Facility / Bush / Field" 96 "Other"
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
