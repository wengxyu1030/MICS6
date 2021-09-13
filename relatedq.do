// related information might be useful
// HIV questions
// tonga2019
// questions in wm dataset
if inlist(country_name,"Tonga2019") {
    gen c_hiv_test = ha24 //ever been tested
    recode c_hiv_test (2 = 0) (9 = .)
    gen c_hiv_test_del = ha19 //tested during delivery
    recode c_hiv_test (2 = 0)
}

// question in mn dataset
// mha24 - ever been tested for HIV
// mhaa,b,c - tested HIV during pregnancy, delivery and breastfeeding

// Female Anthropometrics and Cancer Screening not available
// hospitalization and hypertenison not available
