////////////////////////////////
///// Generate Indicators  /////
////////////////////////////////


***for variables generated from 1_antenatal_care 2_delivery_care 3_postnatal_care
	foreach var of var c_anc	c_anc_any	c_anc_bp	c_anc_bp_q	c_anc_bs	c_anc_bs_q ///
	c_anc_ear	c_anc_ear_q	c_anc_eff	c_anc_eff_q	c_anc_eff2	c_anc_eff2_q ///
	c_anc_eff3	c_anc_eff3_q	c_anc_ir	c_anc_ir_q	c_anc_ski	c_anc_ski_q ///
	c_anc_tet	c_anc_tet_q	c_anc_ur	c_anc_ur_q	c_caesarean	c_earlybreast ///
	c_facdel	c_hospdel	c_sba	c_sba_eff1	c_sba_eff1_q	c_sba_eff2 ///
	c_sba_eff2_q	c_sba_q	c_skin2skin	c_pnc_any	c_pnc_eff	c_pnc_eff_q c_pnc_eff2	c_pnc_eff2_q {
    egen pop_`var' = wtmean(`var'), weight(w_sampleweight)
    }
	
	***for variables generated from 4_sexual_health
	foreach var of var w_CPR w_unmet_fp	w_need_fp w_metany_fp w_metmod_fp w_metany_fp_q {
	egen pop_`var' = wtmean(`var'), weight(w_sampleweight)
	}
	
	***for variables generated from 7_child_vaccination
	foreach var of var c_bcg c_dpt1 c_dpt2 c_dpt3 c_fullimm c_measles ///
	c_polio1 c_polio2 c_polio3{
    egen pop_`var' = wtmean(`var'), weight(w_sampleweight)
    }
	
	***for variables generated from 8_child_illness	
	foreach var of var c_ari* c_diarrhea 	c_diarrhea_hmf	c_diarrhea_medfor	c_diarrhea_mof	c_diarrhea_pro	c_diarrheaact ///
	c_diarrheaact_q	 c_illness* c_illtreat* c_sevdiarrhea	c_sevdiarrheatreat ///
	c_sevdiarrheatreat_q	c_treatAR* c_treatdiarrhea	c_diarrhea_med {
    egen pop_`var' = wtmean(`var'), weight(w_sampleweight)
    }
	
	***for variables generated from 9_child_anthropometrics
	foreach var of var c_underweight c_stunted	c_hfa c_wfa c_wfh {
    egen pop_`var' = wtmean(`var'),weight(w_sampleweight)
    }
	
	***for variables generated from 10_child_mortality
<<<<<<< Updated upstream
	foreach var of var mor_ali {
    egen pop_`var' = wtmean(`var'), weight(w_sampleweight)
=======
	foreach var of var hm_dob hm_doi mor_ade mor_afl mor_ali mor_bord ///
	mor_int mor_male mor_wght {
    egen pop_`var' = wtmean(`var'), weight(hh_sampleweight)
>>>>>>> Stashed changes
    }
	
	***for variables generated from 11_child_other
	foreach var of var c_mateduc c_ITN{
	egen pop_`var' = wtmean(`var'),weight(hh_sampleweight)
	}
	
	
	***for hm related indicators 
	foreach var of var hm_live hm_male hm_age_yrs hm_age_mon hm_headrel hm_stay {
	egen pop_`var' = wtmean(`var'),weight(w_sampleweight)    
	}


*Please add the sample size for the variables too.

    foreach var of var c_* w_* mor_* hm_* { 
	egen sd_`var' = sd(`var') //the standard deviation
    }

keep pop_* sd_* survey country iso3c iso2c year
keep if _n == 1

reshape long pop_ sd_ ,i(survey country iso3c iso2c year) j(varname) string
rename (pop_ sd_) (value sd)


