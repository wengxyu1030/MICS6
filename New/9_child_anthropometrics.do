///// Batch MICS6-dofiles
//Do-file for the indicator:
/// c_stunted
/// c_underweight

* c_height and c_weight
		gen c_height = .
		gen c_weight = .
		replace c_height = an11
		replace c_height = . if an11>900
		replace c_weight = an8
		replace c_weight = . if an8>90

*c_stunted: Child under 5 stunted
		gen c_haz = .
		gen c_stunted = .
		gen c_stunted_sev = .
		replace c_haz = haz2
		replace c_stunted = haz2 < -2						// stunted if child is more than 2 SDs below HAZ reference
		replace c_stunted_sev = haz2 < -3					// severly stunted if child is more than 3 SDs below HAZ reference
		for var c_stunted c_stunted_sev c_haz: replace X = . if inlist(hazflag,.,1)		// missing if height or age flagged
	

*c_underweight: Child under 5 underweight
		gen c_waz = .
		gen c_underweight = .
		gen c_underweight_sev = .
		replace c_waz = waz2
		replace c_underweight = waz2 < -2					// stunted if child is more than 2 SDs below WAZ reference
		replace c_underweight_sev = waz2 < -3					// severly stunted if child is more than 3 SDs below WAZ reference
		for var c_underweight c_underweight_sev c_waz: replace X = . if inlist(wazflag,.,1)	// missing if weight or age flagged

*c_wasted: Child under 5 wasted
		gen c_whz = .
		gen c_wasted = .
		gen c_wasted_sev = .
		replace c_whz = whz2
		replace c_wasted = whz2 < -2						// stunted if child is more than 2 SDs below WAZ reference
		replace c_wasted_sev = whz2 < -3						// stunted if child is more than 2 SDs below WAZ reference
		for var c_wasted c_wasted_sev c_whz: replace X = . if inlist(whzflag,.,1)	// missing if weight or age flagged
