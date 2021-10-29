/////  MICS6-dofiles
// Child mortality
// Do-file for the indicators:
/*
mor_dob
mor_wln
mor_ade
mor_afl
mor_ali

hm_birthorder
*/

* mor_dob: child date of birth
	gen mor_dob = bh4c					
	
* mor_wln: mother ln number to match children with mother
	gen mor_wln = ln						
	
* mor_ali: indicator for child still alive
	recode bh5 (2=0),ge(mor_ali)			// indicator for child still alive
			
* mor_ade: child age at death in months
	gen mor_ade = bh9c						// child age at death in months
			
* mor_afl: indicator for whether child's age at death was imputed
	gen mor_afl = .
	replace mor_afl = bh9f					

* hm_live: living with respondent
	gen hm_live = .
	replace hm_live = bh7                   // living with respondent
	recode hm_live (8/9 = .)
	recode hm_live (2 = 0)

* hm_birthorder: Birth order 
	gen hm_birthorder = brthord
	
* c_magebrt: Mother's age at birth [DW - OCT2021]
	gen c_magebrt = magebrt
	
* housekeeping
	gen hm_doi = wdoi
	
	gen hm_dob = wdob
	
	gen mor_male = 1 if bh3 == 1
	replace mor_male = 0 if bh3 == 2
	
	clonevar mor_bord = bhln
	
	clonevar mor_int = birthint
	replace mor_int = 0 if mor_bord == 1  & mor_int!=.
	
	gen mor_wght = wmweight
	
	gen w_sampleweight = wmweight			// sample weight
	
	keep mor_dob hm_dob mor_wln mor_ali mor_ade mor_afl hm_doi hm_dob mor_male mor_bord mor_int hh1 hh2 bh8 bhln hm_live wm3 mor_wght w_sampleweight hm_birthorder c_magebrt
