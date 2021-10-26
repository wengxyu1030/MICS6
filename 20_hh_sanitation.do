///// MICS6-dofiles
// Household access to basic sanitation and drinking water
// Do-file for the indicators:
/*
h_drinkwater
h_san_facilities
h_watersource
h_toilet
*/


* h_drinkwater: HH access to drinking water from an improved source, collection time < 30min round trip
		gen h_drinkwater = .
		replace h_drinkwater = 0 if ws1 != .
		replace h_drinkwater = 1 if inlist(ws1,11,12)
		replace h_drinkwater = 1 if inlist(ws1,61,71,72) & inrange(ws4,0,30)
		replace h_drinkwater = 1 if inlist(ws1,13,14,21,31,41,51) & (inlist(ws3,1,2) | inrange(ws4,0,30))
		replace h_drinkwater = 1 if inlist(ws1,91,92) & inlist(ws2,11,12)
		replace h_drinkwater = 1 if inlist(ws1,91,92) & inlist(ws2,61,71,72) & inrange(ws4,0,30)
		replace h_drinkwater = 1 if inlist(ws1,91,92) & inlist(ws2,13,14,21,31,41,51) & (inlist(ws3,1,2) | inrange(ws4,0,30))
		replace h_drinkwater = . if h_drinkwater == 0 & ws1 == 96
		
		

* h_san_facilities: HH access to improved sanitation facilities that are not shared with other HHs
		gen h_san_facilities = .
		replace h_san_facilities = 0 if ws11 != .
		replace h_san_facilities = 1 if inlist(ws11,11,12,13,18,21,22,31) & ws15 == 2
		replace h_san_facilities = . if h_san_facilities == 0 & (ws11 == 99 | ws15 == 9)

* h_watersource: Water source (hv201 in DHS HH dataset, already coded for MICS)
		gen h_watersource = ws1
		
* h_toilet: Toilet type (hv205 “”, already coded for MICS)
		gen h_toilet = ws11
		
		
		
		
