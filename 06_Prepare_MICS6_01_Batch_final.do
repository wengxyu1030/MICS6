//// MASTER DO FILE (with do-files inside)
/// Project for batch MICS6
// Maxime

// Refer to MICS6.xlsx for comments

	*ssc inst missings

/* Define paths for raw survey data & micro-data output files 
	*global root "C:/Users/wb493196/WBG/Patrick Hoang-Vu Eozenou - MEASURE UHC DATA" 
	global root "/Users/maximeroche/Desktop/World Bank"
	* Maxime: enter your root folder above and *-out mine to use this file (no need to change anything else folderwise once you have set up the same folder structure)

	* Define path to raw data folder (the unzipped files) -- Maxime, Please use same folder names/structure
	global SOURCE "${root}/RAW DATA"

	* Define path to output folder -- Maxime, Please use same folder names/structure
	global OUT "${root}/STATA/DATA/SC"

	* Temporary global
	do "${root}/STATA/DO/SC/NewMICSglobals.do"
*/
* Produce micro-datasets $newMICS6countries


foreach name in $newMICS6countries {
clear

		/*
		foreach name in Bangladesh2019 Congodr2017 {
			
       	//only use one time to change variables to lower capital
			use "${SOURCE}/MICS/MICS6-`name'/MICS6-`name'wm.dta", clear	
			rename *, lower
			save "${SOURCE}/MICS/MICS6-`name'/MICS6-`name'wm.dta", replace
			use "${SOURCE}/MICS/MICS6-`name'/MICS6-`name'ch.dta", clear	
			rename *, lower
			save "${SOURCE}/MICS/MICS6-`name'/MICS6-`name'ch.dta", replace
			use "${SOURCE}/MICS/MICS6-`name'/MICS6-`name'hl.dta", clear	
			rename *, lower
			save "${SOURCE}/MICS/MICS6-`name'/MICS6-`name'hl.dta", replace
			use "${SOURCE}/MICS/MICS6-`name'/MICS6-`name'hh.dta", clear	
			rename *, lower
			save "${SOURCE}/MICS/MICS6-`name'/MICS6-`name'hh.dta", replace
			use "${SOURCE}/MICS/MICS6-`name'/MICS6-`name'bh.dta", clear	
			rename *, lower
			save "${SOURCE}/MICS/MICS6-`name'/MICS6-`name'bh.dta", replace
		}
      
		*/	 
		
		** Pregnancy & woman data
		use "${SOURCE}/MICS/MICS6-`name'/MICS6-`name'wm.dta", clear
		
		** generate a name variable to be reused in each do-file
		gen country_name = "`name'"
		
		* Birth in last two years
		gen bl2 = 1 if wdoi - wdoblc < 25 

		/// Antenatal care
		/// c_anc: 4+ antenatal care visits of births in last 2 years
		// c_anc_any: any antenatal care visits of births in last 2 years
		// c_anc_ear: First antenatal care visit in first trimester of pregnancy of births in last 2 years
		// c_anc_ear_q: First antenatal care visit in first trimester of pregnancy among ANC users of births in last 2 years
		// c_anc_eff: Effective ANC (4+ antenatal care visits, any skilled provider, blood pressure, blood and urine samples) of births in last 2 years
		// c_anc_eff_q: Effective ANC (4+ antenatal care visits, any skilled provider, blood pressure, blood and urine samples) among ANC users of births in last 2 years
		// c_anc_ski: antenatal care visit with skilled provider for pregnancy of births in last 2 years
		// c_anc_ski_q: antenatal care visit with skilled provider among ANC users for pregnancy of births in last 2 years
		// c_anc_bp: Blood pressure measured during pregnancy of births in last 2 years
		// c_anc_bp_q: Blood pressure measured during pregnancy among ANC users of births in last 2 years
		// c_anc_bs: Blood sample taken during pregnancy of births in last 2 years
		// c_anc_bs_q: Blood sample taken during pregnancy among ANC users of births in last 2 years
		// c_anc_ur: Urine sample taken during pregnancy of births in last 2 years
		// c_anc_ur_q: Urine sample taken during pregnancy among ANC users of births in last 2 years
		// c_anc_ir: iron supplements taken during pregnancy of births in last 2 years
		// c_anc_ir_q: iron supplements taken during pregnancy among ANC users of births in last 2 years
		// c_anc_tet: pregnant women vaccinated against tetanus for last birth in last 2 years
		// c_anc_tet_q: pregnant women vaccinated against tetanus among ANC users for last birth in last 2 years
		// c_anc_eff2: Effective ANC (4+ antenatal care visits, any skilled provider, blood pressure, blood and urine samples, tetanus vaccination) of births in last 2 years
		// c_anc_eff2_q: Effective ANC (4+ antenatal care visits, any skilled provider, blood pressure, blood and urine samples, tetanus vaccination) among ANC users of births in last 2 years
		// c_anc_eff3: Effective ANC (4+ antenatal care visits, any skilled provider, blood pressure, blood and urine samples, tetanus vaccination, start in first trimester) of births in last 2 years 
		// c_anc_eff3_q: Effective ANC (4+ antenatal care visits, any skilled provider, blood pressure, blood and urine samples, tetanus vaccination, start in first trimester) among ANC users of births in last 2 years
		do "${root}/STATA/DO/SC/06_Prepare_MICS/06_Prepare_MICS6/MICS6_do_antenatalcare.do"
		
		/// Delivery care
		// c_hospdel: child born in hospital of births in last 2 years
		// c_facdel: child born in formal health facility of births in last 2 years
		// c_earlybreast: child breastfed within 1 hours of birth of births in last 2 years
		// c_skin2skin: child placed on mother's bare skin immediately after birth of births in last 2 years
		/// c_sba: Skilled birth attendance of births in last 2 years: go to report to verify how "skilled is defined"
		/// c_sba_q: child placed on mother's bare skin and breastfeeding initiated immediately after birth among children with sba of births in last 2 years
		/// c_caesarean: Last birth in last 2 years delivered through caesarean
		///	c_del_eff1: Effective delivery care (baby delivered in facility, by skilled provider, mother and child stay in facility for min. 24h, breastfeeding initiated in first 1h after birth)
		/// c_del_eff1_q: Effective delivery care (baby delivered in facility, by skilled provider, mother and child stay in facility for min. 24h, breastfeeding initiated in first 1h after birth) among those with any SBA
		/// c_del_eff2: Effective delivery care (baby delivered in facility, by skilled provider, mother and child stay in facility for min. 24h, breastfeeding initiated in first 1h after birth, skin2skin contact)
		/// c_del_eff2_q: Effective delivery care (baby delivered in facility, by skilled provider, mother and child stay in facility for min. 24h, breastfeeding initiated in first 1h after birth, skin2skin contact) among those with any SBA
		do "${root}/STATA/DO/SC/06_Prepare_MICS/06_Prepare_MICS6/MICS6_do_deliverycare.do"
	
		/// Postnatal care
		// c_pnc_any : mother OR child receive PNC in first six weeks by skilled health worker
		// c_pnc_eff: mother AND child in first 24h weeks by skilled health worker
		// c_pnc_eff_q: mother AND child in first 24h weeks by skilled health worker among those with any PNC
		// c_pnc_eff2: mother AND child in first 24h weeks by skilled health worker and cord check, temperature check and breastfeeding counselling within first two days
		// c_pnc_eff2_q: mother AND child in first 24h weeks by skilled health worker and cord check, temperature check and breastfeeding counselling within first two days among those with any PNC
		do "${root}/STATA/DO/SC/06_Prepare_MICS/06_Prepare_MICS6/MICS6_do_postnatalcare.do"
		
		/// Reproductive health
		/// w_condom_conc: Condom use of at-risk women age 18-49
		/// w_CPR: Use of modern contraceptive methods of women age 15(!)-49 married or living in union
		/// w_unmet: Unmet need for contraception, percentage of fecund women who are married or in union and are not using any method of contraception, but who wish to postpone the next birth (spacing) or who wish to stop childbearing altogether (limiting).
		/// w_need_fp: 15-49y married or in union with need for family planning (1/0)
		/// w_metany_fp: 15-49y married or in union with need for family planning using any contraceptives (1/0)		
		/// w_metmod_fp: 15-49y married or in union with need for family planning using modern contraceptives (1/0)
		/// w_metany_fp_q: 15-49y married or in union using modern contraceptives among those with need for family planning who use any contraceptives (1/0)

		do "${root}/STATA/DO/SC/06_Prepare_MICS/06_Prepare_MICS6/MICS6_do_w_reproductive.do"
		
		* Gender variable
		gen hm_male = 0
	
		* Educational level
		gen hm_educ = welevel
		
		* Age in years
		gen hm_age_yrs = wb4 
		

		* Woman's sample weight
		gen ind_sampleweight = .
		replace ind_sampleweight = wmweight
		
		* Drop the name variable
		drop country_name
		
		tempfile `name'woman
		save ``name'woman', replace

	** Child data
		use "${SOURCE}/MICS/MICS6-`name'/MICS6-`name'ch.dta", clear
		** generate a name variable to be reused in each do-file
			gen country_name = "`name'"
			
		// Child immunization
		/// c_measles_vacc: Child age 15-23 immunized against measles
		/// c_bcg: Child: 15-23M had BCG vaccination (1/0)
		/// c_dpt1: Child: 15-23M had DPT1 or Pentavalent 1 vaccination (1/0)
		/// c_dpt2: Child: 15-23M had DPT2 or Pentavalent 2 vaccination (1/0)
		/// c_dpt3: Child: 15-23M had DPT3 or Pentavalent 3 vaccination (1/0)
		/// c_polio1: Child: 15-23M had polio1/OPV1 vaccination (1/0)
		/// c_polio2: Child: 15-23M had polio2/OPV2 vaccination (1/0)
		/// c_polio3: Child: 15-23M had polio3/OPV3 vaccination (1/0)	
		/// c_fullimm: Child age 15-23 months fully immunized
		do "${root}/STATA/DO/SC/06_Prepare_MICS/06_Prepare_MICS6/MICS6_do_c_vaccination.do"
		
		/// Child anthropometrics
		/// c_stunted: Child under 5 stunted
		/// c_underweight: Child under 5 underweight
		do "${root}/STATA/DO/SC/06_Prepare_MICS/06_Prepare_MICS6/MICS6_do_c_anthro.do"
		
		/// Childhood illness
		/// c_diarrhea: Child under 5 with diarrhea
		/// c_ari: Child under 5 with symptoms of acute respiratory infection (ARI)
		/// c_illness: Child with any illness symptoms (fever/ARI/diarrhea)
		/// c_treatdiarrhea: Child under 5 with diarrhea in last 2 weeks received oral rehydration saltes (ORS)
		/// c_diarrhea_hmf:  Child under 5 with diarrhea in last 2 weeks received	Government recommended homemade fluid (Coconut water or rice water with salt)		
		/// c_diarrhea_med: Child under 5 with diarrhea in last 2 weeks received any medicine treatment other than ORS and homemade fluid
		/// c_diarrhea_medfor: Child under 5 with diarrhea in last 2 weeks received any formal medicine treatment other than ORS and homemade fluid
		/// c_diarrhea_pro: Child under 5 with diarrhea in last 2 weeks seen by formal healthcare provider
		/// c_diarrheaact: Child under 5 with diarrhea in last 2 weeks seen by formal healthcare provider or given any form of treatment
		/// c_diarrheaact_q: Child under 5 with diarrhea in last 2 weeks seen by formal healthcare provider or given any form of treatment who received ORS
		/// c_diarrhea_mof: Child under 5 with diarrhea offered more than usual to drink
		/// c_sevdiarrhea: Child under 5 with severe diarrhea in last 2 weeks
		/// c_sevdiarrheatreat: Child under 5 with severe diarrhea in last 2 weeks seen by fromal healthcare provider
		/// c_sevdiarrheatreat_q: Child under 5 with severe diarrhea in last 2 weeks seen by fromal healthcare provider who received IV (intravenous) treatment
		/// c_treatARI: Child under 5 with acute respiratory infection (ARI) visited formal healthcare provider (not merely pharmacy) -- note that "dispensaries" are considered formal providers
		do "${root}/STATA/DO/SC/06_Prepare_MICS/06_Prepare_MICS6/MICS6_do_childhoodillness.do"
		/// c_ITN: Child under 5 - use of insecticide-treated bed nets (ITN)
		if inlist(country_name,"Iraq2017","KyrgyzRepublic2018","Mongolia2018","Suriname2018","Tunisia2018","Lesotho2018","Georgia2018","Bangladesh2019","Montenegro2018") {
			gen c_ITN = .
		}
		
		
		* Child gender
		gen hm_male = hl4
		recode hm_male (2 = 0)
		
		* Child's age in years
		gen hm_age_yrs = ub2
		
		* Child's age in months
		gen hm_age_mon = cage
		
		* Child's sample weight
		gen ind_sampleweight = chweight

		* Drop the name variable
		drop country_name
		
		* Save

		tempfile `name'child
		save ``name'child'

	** Bednets data
		
		if inlist("`name'","LaoPDR2017","SierraLeone2017","Gambia2018","Madagascar2018","Zimbabwe2019","Congodr2017","Ghana2017","Togo2017","Kiribati2018") {
		
			use "${SOURCE}/MICS/MICS6-`name'/MICS6-`name'tn.dta", clear
			
			** generate a name variable to be reused in each do-file
				
				gen country_name = "`name'"
		
			/// c_ITN: Child under 5 - use of insecticide-treated bed nets (ITN)
			do "${root}/STATA/DO/SC/06_Prepare_MICS/06_Prepare_MICS6/MICS6_do_c_ITN.do"
		
			* Drop the name variable
			drop country_name
			
			* Save
			tempfile `name'tn
			save ``name'tn'
		
			* Merge with child
			merge 1:1 hh1 hh2 ln using ``name'child'
			
			tab _merge
			drop _merge

			* Save final
			tempfile `name'child1
			save ``name'child1'
		}

	* Add data from birth history for mortality rate computation
		if ~inlist("`name'","Georgia2018","Montenegro2018") {						// there is no birth history dataset
		
			use "${SOURCE}/MICS/MICS6-`name'/MICS6-`name'bh.dta", clear
			gen mor_dob = bh4c						// child date of birth
			gen mor_wln = ln						// mother ln number to match children with mother
			recode bh5 (2=0),ge(mor_ali)			// indicator for child still alive
			gen mor_ade = bh9c						// child age at death in months
			gen mor_afl = .
			replace mor_afl = bh9f					// indicates if child's age at death was imputed
			gen hm_live = .
			replace hm_live = bh7                   // living with respondent
			recode hm_live (8/9 = .)
			recode hm_live (2 = 0)
			gen ind_sampleweight = wmweight			// sample weight
			gen mor_doi = wdoi
			gen mor_wdob = wdob
			gen mor_male = 1 if bh3 == 1
			replace mor_male = 0 if bh3 == 2
			clonevar mor_bord = bhln
			clonevar mor_int = birthint
			replace mor_int = 0 if mor_bord == 1  & mor_int!=.
			gen mor_wght = wmweight
			keep mor_doi mor_dob mor_wln mor_ali mor_ade mor_afl mor_doi mor_wdob mor_male mor_bord mor_int hh1 hh2 bh8 hm_live wm3 mor_wght

		// Merge child and birth history observations
			rename bh8 ln
			replace ln = 100 if (ln == 0 | ln == .)
			by hh1 hh2 ln, sort: gen check = _n
			forvalues i = 2 3 to 30 {
				replace ln = ln + `i' - 1 if check == `i'
			}                                       // give each child unique line number
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
			
			if inlist("`name'","LaoPDR2017","SierraLeone2017","Gambia2018","Madagascar2018","Zimbabwe2019","Congodr2017","Ghana2017","Togo2017","Kiribati2018") {
				merge 1:1 hh1 hh2 ln using ``name'child1'
				drop _merge
			}
			if inlist("`name'","Iraq2017","KyrgyzRepublic2018","Mongolia2018","Suriname2018","Tunisia2018","Lesotho2018","Georgia2018","Bangladesh2019","Montenegro2018") {
				merge 1:1 hh1 hh2 ln using ``name'child'
				drop _merge
			}
		// Save child + bh
			tempfile `name'childbh
			save ``name'childbh'	
		}
		
  		if inlist("`name'","Georgia2018","Montenegro2018") {		// creates mortality variables for survey's without the data for dofile to run smoothly
			foreach var in mor_dob mor_wln mor_ali mor_ade mor_afl mor_doi mor_wdob mor_male mor_bord mor_int hm_live mor_wght {
				gen `var' = .
			} 
		// Save child + bh
			tempfile `name'childbh
			save ``name'childbh'			
       }
		
		* Append woman dataset
		append using ``name'woman'
		
		* Assign maternal education variable to her children (ever born)
		
		recode hm_educ (0 = 1) (1 = 2) (2/6 = 3) (8/9 = .)     // recode woman education 
		recode melevel (0 = 1) (1 = 2) (2/6 = 3) (8/9 = .)		// recode mother education from child dataset
		label define w_label 1 "none" 2 "primary" 3 "lower sec or higher"
		label values hm_educ w_label
		label values melevel w_label
		
		gen matline = wm3                         // woman's line number
		bysort hh1 hh2 matline: egen mat_educ = max(hm_educ)  // assign maternal education to all of her children
		drop matline
		gen matline = uf4 
		bysort hh1 hh2 matline: egen helper = max(hm_educ)
		*order hh1 hh2 matline hm_educ mat_educ helper
		replace mat_educ = helper if mat_educ == .
		drop helper hm_educ 
		rename mat_educ c_mateduc
		replace c_mateduc = melevel if melevel!=.
		
		
		* Keep relevant variables
		keep hh1 hh2 hh7 ln c_* w_* mor_* ind_* hm_* 	

		* Save final
		rename ln hl1
		
		tempfile `name'final
		save ``name'final'
	
	* Merge children/bh/women data with hh listing
 	    
		merge m:1 hh1 hh2 hl1 using "${SOURCE}/MICS/MICS6-`name'/MICS6-`name'hl.dta", update
		drop _merge
		replace hl1 = . if hl1 > 99	// "NOT listed" children in "bh" dataset
		rename hl1 ln
		
		replace hm_male = hl4
		recode hm_male (2 = 0)
		replace hm_age_yrs = hl6
		cap gen mor_doi = .
		* replace mor_doi = 12 * (hh5y - 1900) + hh5m					// date of interview
		gen hm_headrel = hl3                       // relationship to the head
		
		gen country_name = "`name'"
	    #delimit ;
		if 	country_name == "LaoPDR2017" | 
			country_name == "SierraLeone2017" |
			country_name == "Gambia2018" |
			country_name == "Lesotho2018" |
		    country_name == "Madagascar2018" |
			country_name == "Zimbabwe2019" |
			country_name == "Congodr2017" |
			country_name == "Ghana2017" |
			country_name == "Togo2017" |
			country_name == "Kiribati2018" {;
	    #delimit cr	
		    gen hm_stay = hl7
		    recode hm_stay (7/9 = .)
		    recode hm_stay (2 = 0)
		}
		if inlist("`name'","Iraq2017","KyrgyzRepublic2018","Mongolia2018","Suriname2018","Tunisia2018","Georgia2018","Bangladesh2019","Montenegro2018") {
	        gen hm_stay = .
		}
		
		// Keep relevant variables
		keep hh1 hh2 hh7 ln c_* w_* mor_* ind_* hm_*

	* Merge household data with the final dataset
	   
		merge m:1 hh1 hh2 using "${SOURCE}/MICS/MICS6-`name'/MICS6-`name'hh.dta", update
		drop if _merge == 2
		drop _merge
	
	** Water and sanitation
		clonevar hh_water = ws1
		clonevar hh_toilet = ws11
		** generate a name variable to be reused in each do-file
			
		/// Household access to basic sanitation and drinking water
		// h_drinkwater: HH access to drinking water from an improved source, collection time < 30min round trip
		// h_san_facilities: HH access to improved sanitation facilities that are not shared with other HHs
		// do "${root}/STATA/DO/SC/06_Prepare_MICS/06_Prepare_MICS6/MICS6_do_hhsanitation.do"
	
	
	* Household and survey variables
		egen hh_id = concat(hh1 hh2), punct(_)	// creates unique household identifier variable
		gen hh_headed = helevel					// educational level of household head
		recode hh_headed (0 = 1) (1 = 2) (2/6 = 3) (8/9 = .)     // recode household head education 	
	
		gen  hh_region_num	= hh7				// region of residence numerical
		decode (hh7), gen(hh_region_lab)	// region of residence label
		gen country_name = "`name'"
		do "${root}/STATA/DO/SC/06_Prepare_MICS/06_Prepare_MICS6/MICS6_do_subnational_regions.do"		

		gen hh_size = hh48						// household size
		recode hh_size (97/99 = .)		
		gen hh_urban = hh6						// urban place of residence
		recode hh_urban (2 = 0)
		recode hh_urban (3 = 0)
	
		gen hh_sampleweight = hhweight 			// household sample weight
		gen survey = "MICS"						// survey name
		gen year = substr("`name'",-4,4)		// survey year
		gen hh_wealth_quintile = .				// wealth quintile
		gen hh_wealthscore = .					// wealth index score
		replace hh_wealth_quintile = windex5
		egen helper = min(wscore)
        replace hh_wealthscore = wscore - helper
        drop helper
		
	* Keep relevant variables and order
		keep hh1 hh2 ln hh_* c_* w_* mor_* ind_* hm_* survey year gl_adm1_code gl_adm0_code
		order c_* w_* mor_* ind_* ln hm_* hh_* hh1 hh2 
		
	* Merge in country information & produce survey ID
	    gen country_name = "`name'"
		#delimit ;
		if 	country_name == "Iraq2017" | 
			country_name == "Mongolia2018" |
			country_name == "Suriname2018" |
			country_name == "Tunisia2018" |
		    country_name == "Lesotho2018" |
			country_name == "Madagascar2018" |
			country_name == "Zimbabwe2019" |
			country_name == "Georgia2018" |
			country_name == "Bangladesh2019" |
			country_name == "Ghana2017" |
			country_name == "Togo2017" |
			country_name == "Kiribati2018" |
			country_name == "Montenegro2018" {;
	    #delimit cr 
			gen WB_cname = substr("`name'",1,length("`name'")-4)  // creates country name -- check if same as WB_cname in CountryCode file, if not, create country name accordingly
		}
		if inlist("`name'","LaoPDR2017") {
			gen WB_cname = "Lao PDR"  // creates country name -- check if same as WB_cname in CountryCode file, if not, create country name accordingly
		}
		if inlist("`name'","SierraLeone2017") {
			gen WB_cname = "Sierra Leone"  
		}
		if inlist("`name'","KyrgyzRepublic2018") {
			gen WB_cname = "Kyrgyz Republic"  
		}
		if inlist("`name'","Gambia2018") {
			gen WB_cname = "The Gambia"  
		}		
		if inlist("`name'","Congodr2017") {
			gen WB_cname = "Dem. Rep. Congo"  
		}
		merge m:1 WB_cname using "${SOURCE}/CountryCodes.dta", keepusing (iso3c iso2c WB_cname WB_region)  // merges with country code data
		egen x = max(_merge)   // this and following line are to assert that merge with country code worked -- if this produces an error, you need to align the country name with that in the country code dataset (WB_cname)
		assert x == 3
		drop if _merge == 2
		drop x _merge
		drop country_name
		rename WB_cname country
		gen referenceid=iso3c+"_"+year+"_"+survey+"_v01"+"_M"   // produces survey ID variable
		destring year, replace
			
	* Label variables
		label var referenceid "Survey: reference ID"
		label var iso2c "Survey: iso2 country code"
		label var iso3c "Survey: iso3c country code"
		label var country "Survey: WB country name "
		label var survey "Survey: survey name"
		label var WB_region "Survey: WB region"
		label var year "Survey: (first) year survey conducted"
		label var mor_afl "Mortality: child age at death imputation flag"
		label var mor_ade "Mortality: child age at death in months"
		label var mor_ali "Mortality: child still alive"
		label var mor_doi "Mortality: woman date of interview (cmc)"
		label var mor_dob "Mortality: child date of birth (cmc)"
		label var mor_wdob "Mortality: woman date of birth (cmc)"
		label var mor_wln "Mortality: woman ln number in HH to match child with mother (original)"
		label var mor_male "Mortality: child male"
		label var mor_bord "Mortality: child birth order"
		label var mor_int "Mortality: child birth interval"
		label var mor_wght "Mortality: mother's sample weight"
		label var c_diarrhea "Child under 5 with diarrhea"
		label var c_ari "Child under 5 with symptoms of acute respiratory infection (ARI)"
		label var c_illness "Child with any illness symptoms (fever/ARI/diarrhea)"
		label var c_diarrheaact "Child: 0-4y with diarrhea in L2W seen by formal healthcare provider or given any form of treatment(1/0)"
		label var c_diarrheaact_q "Child: 0-4y with diarrhea in L2W seen by formal healthcare provider or given any form of treatment who received ORS (1/0)"
		label var c_treatdiarrhea "Child: 0-4y with diarrhea in L2W got ORS (1/0)"
		label var c_diarrhea_hmf  "Child under 5 with diarrhea in last 2 weeks received Government recommended homemade fluid (Coconut water or rice water with salt)"		
		label var c_diarrhea_med "Child under 5 with diarrhea in last 2 weeks received any medicine treatment other than ORS and homemade fluid"
		label var c_diarrhea_medfor "Child under 5 with diarrhea in last 2 weeks received any formal medicine treatment other than ORS and homemade fluid"
		label var c_diarrhea_pro "Child under 5 with diarrhea in last 2 weeks seen by formal healthcare provider"
		label var c_diarrhea_mof "Child under 5 with diarrhea offered more than usual to drink"
		label var c_sevdiarrhea "Child under 5 with severe diarrhea in last 2 weeks"
		label var c_sevdiarrheatreat "Child: 0-4y with severe diarrhea in L2W seen by fromal healthcare provider (1/0)"
		label var c_sevdiarrheatreat_q "Child: 0-4y with severe diarrhea in L2W seen by fromal healthcare provider who received IV treatment (1/0)"
		label var c_illtreat "Child: 0-4 with diarrhea, rapid breathing and/or fever in L2W seen by formal healthcare provider"
		label var c_stunted "Child: 0-4y HfA <-2 std.dev. from median (WHO) (1/0)"
		label var c_stunted_sev "Child: 0-4y HfA <-3 std.dev. from median (WHO) (1/0)"
		label var c_haz "Child: 0-4y HfA std.dev. from median (WHO)"
		label var c_underweight "Child: 0-4y WfA <-2 std.dev. from median (WHO) (1/0)"
		label var c_underweight_sev "Child: 0-4y WfA <-3 std.dev. from median (WHO) (1/0)"
		label var c_waz "Child: 0-4y WfA std.dev. from median (WHO)"
		label var c_wasted "Child: 0-4y WfH <-2 std.dev. from median (WHO) (1/0)"
		label var c_wasted_sev "Child: 0-4y WfH <-3 std.dev. from median (WHO) (1/0)"
		label var c_whz "Child: 0-4y WfH std.dev. from median (WHO)"	
		label var c_height "Child:  0-4y height in cm"
		label var c_weight "Child: 0-4y weight in kg"
		label var c_treatARI "Child: 0-4y with ARI in L2W seen by formal provider (1/0)"
		label var c_fullimm "Child: 15-23M had BCG, polio 1-3, DTP/Penta1-3 & measles/MMR (1/0)"
		label var c_measles_vacc "Child: 15-23M had measles/MMR vaccination (1/0)"
		label var c_bcg "Child: 15-23M had BCG vaccination (1/0)"
		label var c_dpt1 "Child: 15-23M had DPT1 or Pentavalent 1 vaccination (1/0)"
		label var c_dpt2 "Child: 15-23M had DPT2 or Pentavalent 2 vaccination (1/0)"
		label var c_dpt3 "Child: 15-23M had DPT3 or Pentavalent 3 vaccination (1/0)"
		label var c_polio1 "Child: 15-23M had polio1/OPV1 vaccination (1/0)"
		label var c_polio2 "Child: 15-23M had polio2/OPV2 vaccination (1/0)"
		label var c_polio3 "Child: 15-23M had polio3/OPV3 vaccination (1/0)"	
		label var c_anc "Pregnancy: 15-49y had 4+ ANC visits in last pregnancy in L2Y (1/0)"
		label var c_anc_any "Pregnancy: 15-49y had any ANC visits in last pregnancy in L2Y (1/0)"
		label var c_anc_ear "Pregnancy: 15-49y had first ANC visit in first trimester of last pregnancy in L2Y (1/0)"
		label var c_anc_ear_q "Pregnancy: 15-49y among ANC users had first ANC visit in first trimester of last pregnancy in L2Y (1/0)"
		label var c_anc_eff "Pregnancy: 15-49y had effective ANC visits (4+ visits, skilled provider, blood pressure, blood and urine samples) in last pregnancy in L2Y (1/0)"
		label var c_anc_eff_q "Pregnancy: 15-49y among ANC users had effective ANC visits (4+ visits, skilled provider, blood pressure, blood and urine samples) in last pregnancy in L2Y (1/0)"
		label var c_anc_ski "Pregnancy: 15-49y had ANC visit with a skilled provider in last pregnancy in L2Y (1/0)"
		label var c_anc_ski_q "Pregnancy: 15-49y among ANC users had ANC visit with a skilled provider in last pregnancy in L2Y (1/0)"
		label var c_anc_bp "Pregnancy: 15-49y had blood pressure measured during last pregnancy in L2Y (1/0)"
		label var c_anc_bp_q "Pregnancy: 15-49y among ANC users had blood pressure measured during last pregnancy in L2Y (1/0)"
		label var c_anc_bs "Pregnancy: 15-49y had blood sample taken during last pregnancy in L2Y (1/0)"
		label var c_anc_bs_q "Pregnancy: 15-49y among ANC users had blood sample taken during last pregnancy in L2Y (1/0)"
		label var c_anc_ur "Pregnancy: 15-49y had urine sample taken during last pregnancy in L2Y (1/0)"
		label var c_anc_ur_q "Pregnancy: 15-49y among ANC users had urine sample taken during last pregnancy in L2Y (1/0)"
		label var c_anc_ir "Pregnancy: 15-49y took iron supplements during last pregnancy in L2Y (1/0)"
		label var c_anc_ir_q "Pregnancy: 15-49y among ANC users took iron supplements during last pregnancy in L2Y (1/0)"
		label var c_anc_tet "Pregnancy: 15-49y woman vaccinated against tetanus for last pregnancy in L2Y (1/0)"
		label var c_anc_tet_q "Pregnancy: 15-49y among ANC users woman vaccinated against tetanus for last pregnancy in L2Y (1/0)"
		label var c_anc_eff2 "Pregnancy: 15-49y had effective ANC2 (4+ antenatal care visits, any skilled provider, blood pressure, blood and urine samples, tetanus vaccination) of last pregnancy in last 2 years"
		label var c_anc_eff2_q "Pregnancy: 15-49y among ANC users had effective ANC2 (4+ antenatal care visits, any skilled provider, blood pressure, blood and urine samples, tetanus vaccination) for last pegnancy in last 2 years"
		label var c_anc_eff3 "Pregnancy: 15-49y had effective ANC3 (4+ antenatal care visits, any skilled provider, blood pressure, blood and urine samples, tetanus vaccination, start in first trimester) of last pregnancy in last 2 years" 
		label var c_anc_eff3_q "Pregnancy: 15-49y had effective ANC3 (4+ antenatal care visits, any skilled provider, blood pressure, blood and urine samples, tetanus vaccination, start in first trimester) of last pregnancy in last 2 years"
		label var c_hospdel "Pregnancy: 15-49y child born in hospital in last pregnancy in L2Y (1/0)"
		label var c_facdel "Pregnancy: 15-49y child born in formal health facility in last pregnancy in L2Y (1/0)"
		label var c_earlybreast "Pregnancy: 15-49y child breastfed within 1 hour of birth in last pregnancy in L2Y (1/0)"
		label var c_skin2skin "Pregnancy: 15-49y child placed on mother's bare skin immediately after birth in last pregnancy in L2Y (1/0)"
		label var c_sba "Pregnancy: 15-49y had SBA for last birth in L2Y (1/0)"
		label var c_sba_q "Pregnancy: 15-49y child placed on mother's bare skin and breastfeeding initiated immediately after birth among children with SBA for last birth in L2Y (1/0)"
		label var c_del_eff1 "Pregnancy: 15-49y SBA, facility, immediate breastfeeding"
		label var c_del_eff1_q "Pregnancy: Among those with SBA, 15-49y SBA, facility, immediate breastfeeding"
		label var c_del_eff2 "Pregnancy: 15-49y SBA, facility, immediate breastfeeding, skin2skin"
		label var c_del_eff2_q "Pregnancy: Among those with SBA, 15-49y SBA, facility, immediate breastfeeding, skin2skin"		
		label var c_ITN "Child: 0-4y slept under an ITN the night before the survey (1/0)"
		label var c_caesarean "Pregnancy: 15-49y had caesarean for last birth in L2Y (1/0)"
		label var c_pnc_any "Pregnancy: 15-49y child OR woman received any postnatal care in first six weeks for last birth in L2Y (1/0)"
		label var c_pnc_eff "Pregnancy: 15-49y child AND women received any postnatal care in first 24 hours for last birth in L2Y (1/0)"
		label var c_pnc_eff2 "Pregnancy: 15-49y child AND women received any postnatal care in first 24 hours and cord and temperature check and breastfeeding counseling for last birth in L2Y (1/0)"
		label var c_pnc_eff_q "Pregnancy: Among PNC users: 15-49y child AND women received any postnatal care in first 24 hours for last birth in L2Y (1/0)"
		label var c_pnc_eff2_q "Pregnancy: Among PNC users 15-49y child AND women received any postnatal care in first 24 hours and cord and temperature check and breastfeeding counseling for last birth in L2Y (1/0)"		
		label var w_condom_conc "Woman: 18-49y, 2+ sex partners in L12M used condom in last sex (1/0)"
		label var w_CPR "Woman: 15-49y, married/in union currently uses modern contraceptives (1/0)"
		label var w_unmet "Unmet need for contraception, percentage of fecund women who are married or in union and are not using any method of contraception, but who wish to postpone the next birth (spacing) or who wish to stop childbearing altogether (limiting)"
		label var w_need_fp "15-49y married or in union with need for family planning (1/0)"
		label var w_metany_fp "15-49y married or in union with need for family planning using any contraceptives (1/0)"
		label var w_metmod_fp "15-49y married or in union with need for family planning using modern contraceptives (1/0)"
		label var w_metany_fp_q "15-49y married or in union using modern contraceptives among those with need for family planning who use any contraceptives (1/0)"
		//label var h_drinkwater "HH: access to drinking water from an improved source with collection time < 30min round trip (1/0)"
		//label var h_san_facilities "HH: access to improved sanitation facilities that are not shared with other HHs (1/0)"
		label var hm_male "HH member: male (1/0)"
		label var ln "HH member: woman/pregnancy or child line number in HH (original)"
		label var ind_sampleweight "HH member: woman/pregnancy or child sample weight"
		label var c_mateduc "Child/pregnancy: mother's highest educational attainment: none/primary/lower sec./upper sec.+ (1-3)"
		label var hm_age_yrs "HH member: age in years" 
		label var hm_age_mon "HH member: age in months (children only)"
		label var hm_headrel "HH member: relationship with HH head"
		label var hm_stay "HH member: stayed in the HH the night before the survey (1/0)"
		label var hm_live "HH member: living with respondent in HH (1/0)"
		label var hh_sampleweight "HH: sample weight"
		label var hh_id "HH: ID (generated)" 
		label var hh_headed "HH: head's highest educational attainment"
		label var hh_region_num "HH: region of residence numerical"
		label var hh_region_lab "HH: region of residence label"
		label var hh_size "HH: # of members"
		label var hh_urban "HH: resides in urban area (1/0)"
		label var hh_wealth_quintile "HH: wealth quintile"
		label var hh_wealthscore "HH: wealth index score"
		label var hh1 "HH: cluster number (original)"
		label var hh2 "HH: household number (original)"
		label var hh_water "HH: water source type"
		label var hh_toilet "HH: toilet type"
        label var gl_adm1_code "Global Administrative Unit Layers(GAUL) Code"
		label var gl_adm0_code "Global Administrative Unit Layers(GAUL) Country Code"
		
		
	* Drop observations with missings on all outcomes
		// missings dropvars c_* w_* , force
		
	* Save micro-dataset
	 
	saveold "${OUT}/ADePT READY/MICS/New/MICS6-`name'Adept.dta", replace
			
}		


