include <costanti.scad>
include <funzioni.scad>


function ps1_(dad,l,x) = (l + dad - x)/2;
function ps2_(dad,l,x) = (l - dad - x)/2;


module ipe () {
	difference () {
		cube ([lipe,aipe,alcam]);
		translate ([(lipe + saipe)/2,slipe,-1])
			 cube ([(lipe - saipe)/2 + 1,aipe - 2 * slipe, alcam + 1]);
		translate ([-1,slipe,-1])
			 cube ([(lipe - saipe)/2 + 1,aipe - 2 * slipe, alcam + 1]);
		for (i  = [1,3]) for (j = [atubolare / 4 ,alcam - atubolare/4])  
			translate([-1 + lipe/2, slipe + ripe + i * (aipe - 2*(slipe + ripe))/4,j]) rotate ([0,90,0]) cylinder(h = spia + 2, r = rfa, $fn = 10);		
		translate([lipe/2 -1, aipe/2, 0]) pzz(dad,alcam) rotate(90, [0, 1, 0]) cylinder(h = spia + 2, r = rfa, $fn = 10);	
		}
	}

module filetto_v() {
	translate ([0, 0 ,- aaa/2]) {
		difference() {
			cube ([aaa + (lipe - saipe)/2 ,spia, aaa ]);
			translate([(aaa + gtel)/2 + (lipe - saipe)/2 , -1, aaa/2 ]) rotate(-90, [1, 0, 0]) cylinder(h = spia + 2, r = rfa, $fn = 10);	
			}
		difference() {
			cube ([spia, aipe - 2 * (slipe + ripe) - spia,aaa]);
			translate([-1, (aipe - 2 * (slipe + ripe))/2 -spia, aaa/2 ]) rotate(90, [0, 1, 0]) cylinder(h = spia + 2, r = rfa, $fn = 10);	
			}
		}
	}


module ipeconagganci () {
	ipe ();
	translate ([0, spia + slipe + ripe,0]) 
		pzz (dad,alcam) group () {
			translate ([(lipe + saipe)/2,0,0]) filetto_v ();
			translate ([(lipe - saipe)/2,0,0]) mirror ([1,0,0]) filetto_v ();
			}
	}

module piastragiunzione () {
	difference () {
		cube ([lipe/2 + 2*atubolare/3, aipe -  (slipe + ripe), atubolare + 2 * spia]);
		translate ([spia,-1,spia]) cube ([lipe/2 + ltubolare + 1,aipe + 1,atubolare]);
		translate ([-1,-1,-1]) cube ([lipe/2 + 1, slipe + ripe + 1,atubolare + 2 * spia +2]); 
		translate ([spia,4,-1]) cube ([aipe,aipe ,atubolare + 2 * spia +2]);
		for (i  = [1,3]) for (j = [1,3])  
			translate([-1, slipe + ripe + i * (aipe - 2 * (slipe + ripe)) /4, spia + j * atubolare / 4]) rotate ([0,90,0]) cylinder(h = spia + 2, r = rfa + grfa, $fn = 10);	
		hull () {
			translate([(lipe - saipe)/2 + atubolare/4 - gtrav,ltubolare/2,-1]) cylinder(h = atubolare + 2 * spia +2, r = rfa, $fn = 10);	
			translate([(lipe - saipe)/2 + 2*atubolare/4,ltubolare/2,-1]) cylinder(h = atubolare + 2 * spia +2, r = rfa, $fn = 10);
			}
			
		}
	}
	

module trave () {
	for (i= [0,alcam]) {
		translate ([(lipe + saipe)/2,0,i - (atubolare + 2 * spia) / 2]) piastragiunzione ();
		translate ([(lipe - saipe)/2,0,i - (atubolare + 2 * spia) / 2]) mirror ([1,0,0]) piastragiunzione ();
		}
	ipeconagganci ();
	}

module filetto_o() {
	difference() {
		cube ([aaa,spia,atubolare/2 + aaa ]);
		translate([aaa/2, -1, (atubolare + aaa + gtel)/2 ]) rotate(-90, [1, 0, 0]) cylinder(h = spia + 2, r = rfa, $fn = 10);	
		}
	translate ([0,0,atubolare/2]) mirror ([1,0,0]) rotate ([0,0,45]) cube ([ltubolare * sqrt(2),spia,aaa ]);
	translate ([aaa,0,atubolare/2]) rotate ([0,0,45])  cube ([ltubolare * sqrt (2),spia,aaa ]);
	}

module piastrafiletti () {
	filetto_o ();
	mirror ([0,0,1]) filetto_o ();
	}


module tubolare () {
	difference () {
		cube ([lutubolare, ltubolare, atubolare]);
		translate ([-1, stubolare, stubolare])
			cube ([lutubolare  + 2, ltubolare - 2 * stubolare, atubolare - 2 * stubolare]);
		translate([atubolare/4 ,ltubolare/2,-1]) cylinder(h = atubolare + 2 * spia +2, r = rfa, $fn = 10);	
		translate([lutubolare - atubolare/4 ,ltubolare/2,-1]) cylinder(h = atubolare + 2 * spia +2, r = rfa, $fn = 10);	
		
		}
	translate ([ps1_(dad,lutubolare,aaa), ltubolare + spia, atubolare/2]) mirror ([0,1,0]) piastrafiletti ();
	translate ([ps2_(dad,lutubolare,aaa), ltubolare + spia, atubolare/2]) mirror ([0,1,0]) piastrafiletti ();
	}


module travecontubi () {
	for (q = [0,1]) translate ([q * lacam,0,0]) trave ();
	for (i = [0,1]) translate ([lipe ,0,- atubolare / 2  + i * alcam]) tubolare();
	
	}



module grano (l) {
	rotate ([90,0,0]) cylinder(h = spiamu + l, r = rfa, $fn = 20);
	}
module bullone (l) {
	rotate ([90,0,0]) {
		cylinder(h = spiamu + l, r = rfa, $fn = 12);
		translate ([0,0,spiamu + l ]) cylinder (h = atba, r = rtb, $fn = 6);
		}
	}


module morso  () {
	translate ([0,almor/2,0]) difference () {
		cube (center = true,[lumor,almor,lamor]);
		hull () {
			translate ([0.255,-almor,0]) rotate ([-90,0,0]) cylinder(h = almor + 2, r = rfa + grfa, $fn = 20);
			translate ([-1.805,-almor,0]) rotate ([-90,0,0]) cylinder(h = almor + 2, r = rfa + grfa, $fn = 20);
			}
		}
	}
	  
module piastramuro () {
	difference () {
		cube ([lpiamu,spiamu,apiamu]);
		for (i = [rfa * 3, apiamu - rfa * 3]) for (j = [3:nfo - 3]) translate ([j * dfo, spiamu + 1, i])  grano (2);
		for (i = [lfpiamu, lpiamu - lfpiamu]) for (j = [1:nfv - 1]) translate ([i,spiamu + 1, j*dfv]) 
			rotate ([90,0,0]) cylinder(h = spiamu + 2, r = rpepia + 0.5, $fn = 20);
				
			
		}	
	angs = rands (-25,25,6*nfv);
	for (i = [0,1]) for (j = [1:nfv - 1]) translate ([lfpiamu + i* (lpiamu - 2 * lfpiamu) ,spiamu/2, j*dfv]) {
			rotate ([angs[i* (nfv * 3) + j],angs[ i* (nfv *3) + j + 1],angs[ i* (nfv *3) + j + 2]]) translate ([0,lpepia - 2.5 * rpepia,0])
			rotate ([90,0,0]) {
				cylinder(h = lpepia, r = rpepia, $fn = 20);
				translate ([0,0,lpepia - tpepia]) cylinder(h = tpepia, r = tpepia, $fn = 20);
				}
			}
	
	mnfo = floor (nfo/2);	
	for (i = [rfa * 3, apiamu - rfa * 3]) for (j = [mnfo, mnfo + 1]) translate ([j * dfo, spiamu, i])  grano (dtrapia);
	for (i = [rfa * 3, apiamu - rfa * 3]) translate ([(mnfo + 2) * dfo, spiamu, i])  
		{
		bullone (dtrapia + slipe + almor + 2 * gmor);
		translate ([0,-(dtrapia + almor + slipe + spiamu + gmor),0]) morso ();
		}
	for (i = [rfa * 3, apiamu - rfa * 3])  translate ([(mnfo -1) * dfo, spiamu, i])  
		{
		bullone (dtrapia + slipe + almor + 2 * gmor);
		translate ([0,-(dtrapia + almor + slipe + spiamu + gmor),0]) mirror ([1,0,0]) morso ();
		}
	for (i = [rfa * 3, apiamu - rfa * 3]) for (j = [mnfo - 2, mnfo + 3]) translate ([j * dfo, spiamu, i])  grano (dtrapia + slipe);
	}		


module piastramurocontrave () {
	piastramuro ();
	translate ([(lpiamu - lipe)/2,- (aipe + dtrapia),-10]) trave (1);
	}
//////////////////////////////////////////////////////////////////////


////////////////////////////////
/// travi /////////////////////
///////////////////////////////




