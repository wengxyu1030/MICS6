///// MICS6-dofiles
// Label variables

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
		label var hm_doi "Mortality: woman date of interview (cmc)"
		label var mor_dob "Mortality: child date of birth (cmc)"
		label var hm_dob "Mortality: woman date of birth (cmc)"
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
		label var c_hfa "Child: 0-4y HfA std.dev. from median (WHO)"
		label var c_underweight "Child: 0-4y WfA <-2 std.dev. from median (WHO) (1/0)"
		label var c_underweight_sev "Child: 0-4y WfA <-3 std.dev. from median (WHO) (1/0)"
		label var c_wfa "Child: 0-4y WfA std.dev. from median (WHO)"
		label var c_wasted "Child: 0-4y WfH <-2 std.dev. from median (WHO) (1/0)"
		label var c_wasted_sev "Child: 0-4y WfH <-3 std.dev. from median (WHO) (1/0)"
		label var c_wfh "Child: 0-4y WfH std.dev. from median (WHO)"	
		label var c_height "Child:  0-4y height in cm"
		label var c_weight "Child: 0-4y weight in kg"
		label var c_treatARI "Child: 0-4y with ARI in L2W seen by formal provider (1/0)"
		label var c_fullimm "Child: 15-23M had BCG, polio 1-3, DTP/Penta1-3 & measles/MMR (1/0)"
		label var c_measles "Child: 15-23M had measles/MMR vaccination (1/0)"
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
		label var c_sba_eff1 "Pregnancy: 15-49y SBA, facility, immediate breastfeeding"
		label var c_sba_eff1_q "Pregnancy: Among those with SBA, 15-49y SBA, facility, immediate breastfeeding"
		label var c_sba_eff2 "Pregnancy: 15-49y SBA, facility, immediate breastfeeding, skin2skin"
		label var c_sba_eff2_q "Pregnancy: Among those with SBA, 15-49y SBA, facility, immediate breastfeeding, skin2skin"		
		label var c_ITN "Child: 0-4y slept under an ITN the night before the survey (1/0)"
		label var c_caesarean "Pregnancy: 15-49y had caesarean for last birth in L2Y (1/0)"
		label var c_pnc_any "Pregnancy: 15-49y child OR woman received any postnatal care in first six weeks for last birth in L2Y (1/0)"
		label var c_pnc_eff "Pregnancy: 15-49y child AND women received any postnatal care in first 24 hours for last birth in L2Y (1/0)"
		label var c_pnc_eff2 "Pregnancy: 15-49y child AND women received any postnatal care in first 24 hours and cord and temperature check and breastfeeding counseling for last birth in L2Y (1/0)"
		label var c_pnc_eff_q "Pregnancy: Among PNC users: 15-49y child AND women received any postnatal care in first 24 hours for last birth in L2Y (1/0)"
		label var c_pnc_eff2_q "Pregnancy: Among PNC users 15-49y child AND women received any postnatal care in first 24 hours and cord and temperature check and breastfeeding counseling for last birth in L2Y (1/0)"		
		label var w_condom_conc "Woman: 18-49y, 2+ sex partners in L12M used condom in last sex (1/0)"
		label var w_CPR "Woman: 15-49y, married/in union currently uses modern contraceptives (1/0)"
		label var w_unmet_fp "Unmet need for contraception, percentage of fecund women who are married or in union and are not using any method of contraception, but who wish to postpone the next birth (spacing) or who wish to stop childbearing altogether (limiting)"
		label var w_need_fp "15-49y married or in union with need for family planning (1/0)"
		label var w_metany_fp "15-49y married or in union with need for family planning using any contraceptives (1/0)"
		label var w_metmod_fp "15-49y married or in union with need for family planning using modern contraceptives (1/0)"
		label var w_metany_fp_q "15-49y married or in union using modern contraceptives among those with need for family planning who use any contraceptives (1/0)"
		//label var h_drinkwater "HH: access to drinking water from an improved source with collection time < 30min round trip (1/0)"
		//label var h_san_facilities "HH: access to improved sanitation facilities that are not shared with other HHs (1/0)"
		label var hm_male "HH member: male (1/0)"
		label var ln "HH member: woman/pregnancy or child line number in HH (original)"
		label var w_sampleweight "HH member: woman/pregnancy or child sample weight"
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
