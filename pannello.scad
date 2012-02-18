include <costanti.scad>
include <funzioni.scad>


rw = 2 * hba2 + lds + 2 * gslit;
rh = lba2 + ads + 2 * gslit;

module femmina() {
	difference() {
		cube([rw, ltu2, rh + hba2]);
		translate([hba2, -1, -1]) cube([lds + 2 * gslit, ltu2 + 2, rh + 1]);
		}	
	}


module asola_o() {
	difference() {
		cube ([aaa,spia,aaa ]);
		hull () {
			translate([aaa/2, -1, aaa/2  - 1.5 * gtel]) rotate(-90, [1, 0, 0]) cylinder(h = spia + 2, r = rfa + grfa, $fn = 10);	
			translate([aaa/2, -1, aaa/2  + 1.5 * gtel]) rotate(-90, [1, 0, 0]) cylinder(h = spia + 2, r = rfa + grfa, $fn = 10);	
			}
		}
	rotate ([0,0,135]) translate ([0,-spia,0]) cube ([(ltubolare - spia)* sqrt (2) ,spia,aaa ]);
	translate ([aaa,0,0]) rotate ([0,0,45])  cube ([(ltubolare - spia)* sqrt (2),spia,aaa ]);
	}

module asola_v() {
	translate ([0,0,-aaa/2]) {
		difference() {
			cube ([aaa,spia,aaa ]);
			hull () {
				translate([aaa/2 , -1, aaa/2 - gtel]) rotate(-90, [1, 0, 0]) cylinder(h = spia + 2, r = rfa + grfa, $fn = 10);	
				translate([aaa/2 , -1, aaa/2 + gtel]) rotate(-90, [1, 0, 0]) cylinder(h = spia + 2, r = rfa + grfa, $fn = 10);	
				}
			}
		cube ([spia,ltu2 - (slipe + ripe),aaa ]);
		}
		
	}
///////////////////////// telaio ///////////////

aip_ = apan - 2 * (htu2 + aaa) - atubolare +ltu2;
no_ = floor (aip_ / topan); 
topan_ = aip_ / no_ ;


module telaio() {
	ltel = lpan - lipe - gtel;
	atel = apan - atubolare - gtel;
	atelp = atel - 2 * aaa;
	ltelp = ltel - 2 * aaa;
	translate ([aaa + (lipe + gtel)/2, 0 , aaa +(atubolare  + gtel)/2]) {
		color("Gray", 0.6) group() {
			// telaio esterno
			difference() {
				cube([ltel - 2 * aaa, ltu2, atel - 2 * aaa]);
				translate([htu2, -1, htu2]) cube([ltel -2 * aaa - 2 * htu2 , ltu2 + 2, atel - 2 * aaa - 2 * htu2]);
				}	
			// accoglienza gancio destra
			translate([ps1_(dadf,ltel - 2 * aaa,rw), 0, htu2]) femmina(0);
			// accoglienza gancio sinistra
			translate([ps2_(dadf,ltel - 2 * aaa,rw), 0, htu2]) femmina(0);
			// accoglienza gancio superiore
			translate([(ltel - 2 * aaa - rw)/2, 0, atel - htu2 - 2 * aaa]) mirror([0, 0, 1]) femmina(0);
			

			// trama orizzontale
			translate ([htu2,0,htu2 - ltu2]) for (i = [1 : no_ - 1]) {
				translate ([0, 0, topan_ * i]) cube ([ltel - 2 * htu2 - 2 * aaa, htu2, ltu2]);
				}
			// trama verticale
			translate ([(ltel - 2 * aaa - ltu2)/2, 0, htu2]) {
				for (i=[0 : no_ - 2]) {
					translate ([0, 0, topan_ *  i]) cube ([ltu2, htu2, topan_ - ltu2]);
					}
				translate ([0, 0, topan_ *  (no_ - 1)]) cube ([ltu2, htu2, topan_ - ltu2 - (hba2 + lba2 + ads + 2 * gslit) ]);
				}
			//guide
			translate([(ltel  - 2 * aaa -  htu2)/2, 0, -aaa]) {
				// guida centrale superiore
				translate([0, 0, atel - aaa]) difference () {
					cube ([htu2,ltu2,aaa]); 
					group () {
						translate ([-1, ltu2/2, aaa/3]) rotate(90, [0, 1, 0]) cylinder(h = htu2 + 2, r = rfa, $fn = 20);
						translate ([-1, ltu2/2, 2*aaa/3]) rotate(90, [0, 1, 0]) cylinder(h = htu2 + 2, r = rfa, $fn = 20);
						}
					}
				}
			// asole
			translate([0, 0, - aaa]) { 
				translate([ps1_(dad,ltelp,aaa), ltubolare, 0]) mirror ([0,1,0]) asola_o();
			
				translate([ps2_(dad,ltelp ,aaa), ltubolare, 0]) mirror ([0,1,0])asola_o(); 
			
				translate([ps1_(dad,ltelp,aaa), ltubolare, atel]) mirror ([0,0,1]) mirror ([0,1,0])asola_o();
				translate([ps2_(dad,ltelp,aaa), ltubolare, atel]) mirror ([0,0,1]) mirror ([0,1,0])asola_o();
				}
			translate([-aaa, 0, 0]) { 
				translate([aaa,slipe + ripe,0]) pzz(dad,atelp) mirror ([1,0,0]) asola_v();
				translate([ltel - aaa,slipe + ripe,0]) pzz(dad,atelp) asola_v();
				}
			}
		}
	}
module telaiosullastruttura () {
	translate ([-lipe/2,0,0]) travecontubi ();
	telaio ();
	}
/////////////////// forex ///////////

module taglioforipannello() rotate(-90, [1, 0, 0]) hull () {
	translate ([0,-gtel,0]) cylinder(h = span + 2, r = rop, $fn = 30);
	translate ([0,+gtel,0]) cylinder(h = span + 2, r = rop, $fn = 30);
	}
	
	
module tagliofemminepannello() cube([lds + 2 * gslit, span + 2, lba2 + ads + 2 * gslit]);
module pannello() { 
	lpan_ = lpan - gtel;
	apan_ = apan - gtel;
	afem = htu2 + aaa + atubolare/2;
	translate ([gtel/2, 0, gtel/2]) color("Cyan", 0.8) difference() {
		cube([lpan_, span, apan_]);
		translate([0, -1, 0]) {
			// accoglienza gancio destra
			translate([ps1_(dadf,lpan_ ,lds + 2 * gslit), 0, afem]) tagliofemminepannello();
			// accoglienza gancio sinistra
			translate([ps2_(dadf,lpan_ ,lds + 2 * gslit), 0, afem]) tagliofemminepannello();
			// accoglienza gancio superiore
			translate([(lpan_ - (lds + 2 * gslit))/2, 0, apan_ - afem]) mirror([0, 0, 1]) tagliofemminepannello ();
			translate([ps1_(dad,lpan_,0), 0, (aaa + atubolare)/2]) taglioforipannello(); 
			translate([ps2_(dad,lpan_,0), 0, (aaa + atubolare)/2]) taglioforipannello();
			translate([ps1_(dad,lpan_,0), 0, apan_ - (aaa + atubolare)/2]) taglioforipannello(); 
			translate([ps2_(dad,lpan_,0), 0, apan_ - (aaa + atubolare)/2]) taglioforipannello(); 
			translate([(aaa + lipe)/2,0,0]) pzz (dad,apan_) taglioforipannello(); 
			translate([lpan_ - (aaa + lipe)/2,0,0]) pzz (dad,apan_) taglioforipannello(); 
			}
		}
	}

///////////// piedi /////////////////////

af_ = (lbp/pbp - hba2)/2; //attacco filetto sul piede
module piede() {
		rotate([0, 0, -90]) mirror([1, 0, 0]) tubo(lbp, hba1, hba1);
		translate([0, af_, hba1]) filetto();
		}

module pannellosuipiedi() {
	translate([0, 0, hba1 + gtrav]) telaioepannello();
	translate([ps1_(hba1), span + atba + hba2 - af_, 0]) piede();
	translate([ps2_(hba1), span + atba + hba2 - af_, 0]) piede();
	}


///////////// gancio movimento capannone ////////

module aggancioponte () {
	difference () {
		cube ([3*htu2,ltu2,atra]);
		translate ([htu2, -1, 0]) cube ([htu2, ltu2 + 2, atra - htu2]);
		translate ([-1, ltu2/2, aaa/3]) rotate(90, [0, 1, 0]) cylinder(h = 3*htu2 + 2, r = rfs, $fn = 20);
		translate ([-1, ltu2/2, 2*aaa/3]) rotate(90, [0, 1, 0]) cylinder(h = 3*htu2 + 2, r = rfs, $fn = 20);
		}
	translate ([0,0,atra]) femmina ();
	translate ([- htu2, ltu2/2, aaa/3]) rotate ([0,90,0]) perno (5 * htu2);
	translate ([- htu2, ltu2/2, 2*aaa/3]) rotate ([0,90,0]) perno (5 * htu2);
	}
module telaiocongancioponte () {
	telaio ();
	translate ([(lpan - 3 * htu2) / 2, 0 , apan - 2 * aaa]) aggancioponte () ;
	}

module perno (l) {
	cylinder (h = l, r = rfs - gper, $fn = 20);
	translate ([- rfs - 2*gper,0,rfs]) rotate ([0,90,0]) cylinder (h = 2 * (rfs + 2*gper), r = rfs/4, $fn = 10);
	translate ([- rfs - 2*gper,0,l - rfs]) rotate ([0,90,0]) cylinder (h = 2 * (rfs + 2*gper), r = rfs/4, $fn = 10);
	}	

module pannellocongancioponte () {
	translate([0, span, aaa]) telaiocongancioponte();
	pannello();
	}


module telaioepannello() {
	telaio();
	translate ([0,-span,0]) pannello();
	}

module pannellosullastruttura () {
	telaiosullastruttura ();
	translate ([0,-span,0]) pannello();
	}
module slittasulpannello() {
	translate([-lba1/2, -hba2 - gslit -spra - lds - gspin/2, aaa + htu2 + ads]) mirror([0, 1, 0]) slitta();
	translate([-lpan/2, 0, 0]) telaioepannello();
	}




