include <costanti.scad>
include <funzioni.scad>


pfipe = 50;

module foro (l) {
	cylinder(h = l + 2, r = rfa, $fn = 10);
	}

module ipe (l) {
	difference () {
		cube ([lipe,aipe,l]);
		for (i=[(lipe + saipe)/2,-1]) translate ([i,slipe,-1])
			 cube ([(lipe - saipe)/2 + 1,aipe - 2 * slipe, l + 1]);
		for (i  = [1,3]) for (j = [atubolare / 4 ,l - atubolare/4])  
			translate([-1 + lipe/2, slipe + ripe + i * (aipe - 2*(slipe + ripe))/4,j]) rotate ([0,90,0]) foro(spia);	
		translate([lipe/2 -1, aipe/2, 0]) fillz (pfipe, l) rotate([0, 90, 0]) foro (spia);	
		}
	}

module filetto_v() {
	translate ([0, 0 ,- aaa/2]) {
		difference() {
			cube ([aaa + (lipe - saipe)/2 ,spia, aaa ]);
			translate([(aaa + gtel)/2 + (lipe - saipe)/2 , -1, aaa/2 ]) rotate([-90, 0, 0]) foro (spia); 
			}
		difference() {
			cube ([spia, aipe - 2 * (slipe + ripe) - spia,aaa]);
			translate([-1, (aipe - 2 * (slipe + ripe))/2 -spia, aaa/2 ]) rotate(90, [0, 1, 0]) cylinder(h = spia + 2, r = rfa , $fn = 10);	
			}
		}
	}


module ipeconagganci (l) {
	ipe (l);
	translate ([0, spia + slipe + ripe,0]) 
		fillz(pfipe,l) group (){
			translate ([(lipe + saipe)/2,0,0]) filetto_v ();
			translate ([(lipe - saipe)/2,0,0]) mirror ([1,0,0]) filetto_v ();
			}
	}

module piastragiunzione () {
	difference () {
		cube ([lipe/2 + 2*atubolare/3, aipe -  (slipe + ripe), atubolare + 2 * spia]);
		translate ([spia,-1,spia]) cube ([lipe/2 + ltubolare + 1,aipe + 1,atubolare]);
		//scasso ipe
		translate ([-1,-1,-1]) cube ([lipe/2 + 1, slipe + ripe + 1,atubolare + 2 * spia +2]); 
		//scasso morsi	
		translate ([spia,4,-1]) cube ([aipe,aipe ,atubolare + 2 * spia +2]);
		//fori ipe
		for (i  = [1,3]) for (j = [1,3])  
			translate([-1, slipe + ripe + i * (aipe - 2 * (slipe + ripe)) /4, spia + j * atubolare / 4]) rotate ([0,90,0]) cylinder(h = spia + 2, r = rfa + grfa, $fn = 12);	
		//asola passanti
		hull () {
			translate([(lipe - saipe)/2 + atubolare/4 - gtrav,ltubolare/2,-1]) cylinder(h = atubolare + 2 * spia +2, r = rfa + grfa, $fn = 12);	
			translate([(lipe - saipe)/2 + 2*atubolare/4,ltubolare/2,-1]) cylinder(h = atubolare + 2 * spia +2, r = rfa + grfa, $fn = 12);
			}
			
		}
	}

module piastragiunzioneD (alpha) {
	rotate ([0,alpha,0]) {
		translate ([-3,0,0]) mirror ([1,0,0]) piastragiunzione ();
		piastragiunzione ();
		}
	}
	
module trave (k,l,alpha) {  
	for (i= k ? [0,l] : [0]) {
		translate ([(lipe + saipe)/2,0,i - (atubolare + 2 * spia) / 2]) piastragiunzione ();
		translate ([(lipe - saipe)/2,0,i - (atubolare + 2 * spia) / 2]) mirror ([1,0,0]) piastragiunzioneD ();
		}
	ipeconagganci (l);
	}

module traveD (k,l,alpha) {  
	translate ([(lipe + saipe)/2,0,l - (atubolare + 2 * spia) / 2]) piastragiunzioneD (alpha);
	ipeconagganci (l);
	}

module filetto_o() {
	difference() {
		cube ([aaa,spia,atubolare/2 + aaa ]);
		translate([aaa/2, -1, (atubolare + aaa + gtel)/2 ]) rotate(-90, [1, 0, 0]) cylinder(h = spia + 2, r = rfa, $fn = 10);	
		}
	translate ([0,0,atubolare/2]) mirror ([1,0,0]) rotate ([0,0,45]) cube ([ltubolare * sqrt(2),spia,aaa ]);
	translate ([aaa,0,atubolare/2]) rotate ([0,0,45])  cube ([ltubolare * sqrt (2),spia,aaa ]);
	}

module piastrafiletti () translate ([-aaa/2,0,0]) {
	filetto_o ();
	mirror ([0,0,1]) filetto_o ();
	}


module tubolare (l,alpha) {
	dl =atubolare * tan(alpha);
	tx = atubolare * sin(alpha);
	difference () {
		translate ([0,0,atubolare]) rotate ([0,alpha,0]) translate ([0,0,-atubolare]) difference () {
			cube ([l + 2 * dl , ltubolare, atubolare]);
			translate ([-1, stubolare, stubolare])
				cube ([l + 2 * dl + 2, ltubolare - 2 * stubolare, atubolare - 2 * stubolare]);
			translate([atubolare/4 + dl,ltubolare/2,-1]) foro (atubolare);
			translate([l - (atubolare/4 + dl) ,ltubolare/2,-1]) foro (atubolare);
			}
		translate ([-atubolare,0,-l]) cube ([atubolare,ltubolare,2*l]);
		translate ([l * cos (alpha),0,-l]) cube ([atubolare,ltubolare,2*l]);
		}
	*translate ([0, ltubolare + spia, atubolare/2]) fillx (pfipe,l) mirror ([0,1,0]) piastrafiletti ();
	}


module strutturaregolare (n,m) {
	for (r = [0:m-1]) translate ([0,0,r * alcam]) trave (true, alcam);
	for (q = [0:n-1] ) translate ([q * lacam + lipe ,0,- atubolare / 2]) tubolare(lacam,0);
	if (n > 1) 
		for (r = [0:m - 1]) {
			for (q = [1:n-1]) translate ([q * lacam,0,r * alcam]) trave (false, alcam);
			for (q = [1:n-1] ) translate ([q * lacam + lipe ,0,- atubolare / 2  + r * alcam]) tubolare(lacam,0);
			}
	
	for (q = [0:n-1] ) translate ([q * lacam + lipe ,0,- atubolare / 2  + m * alcam]) tubolare(lacam,0);
	for (r = [0:m-1]) translate ([n * lacam,0,r * alcam]) trave (true, alcam);
	}


	





