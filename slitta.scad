include <costanti.scad>


module cursore(hba2) {
	difference() {
		cube([lba1 + 2 * (gslit + hba2), hba1 + 2 * (gslit + hba2), acg]);
		translate([hba2, hba2, -1]) cube([lba1 + 2 * gslit, hba1 + 2 * gslit, acg + 2]);
		}

	}


module gancio() {
	dx = hba2 + gslit + (lba1 - hba2)/2;// alt
	cursore(hba2);
	translate([dx, 0, 0]) rotate([90, 0, 0]) {
		cube([hba2, lba2, 2 * lds + ltu2 + span + gspin + spra]);
		translate([0, lba2, lds + ltu2 + span + gspin + spra]) cube([hba2, ads, lds]);
		translate([0, lba2, spra]) cube([hba2, ads, lds]);
   		}
	}

module stecca(l)	{
		cube([lba1, hba1, l]);
		}

module steccaefinale(l) {
	finale() stecca(l);
	}

module finale() {
	child(0);
	translate([-spia1, -spia1, -spia1]) cube([lba1 + 2 * spia1, hba1 + 2 * spia1, spia1]);
	}

module buca(luas, lucas, sce) {
	difference() {
		child(0) ;
		translate([-1, hba1/2, luas -sce - hba1/2 - lucas]) {
			rotate(90, [0, 1, 0]) cylinder(h = lba1 + 2, r = rfs, $fn = 20);
			translate([0, 0, lucas]) rotate(90, [0, 1, 0]) cylinder(h = lba1 + 2, r = rfs, $fn = 20);
			translate([0, -rfs, 0]) cube([lba1 + 2, rfs * 2, lucas]);
			}
		}
	}

module steccabucata(luas, lucas, sce) {
	buca(luas, lucas, sce) stecca(luas);
	}

module steccabucatatesta(luas, lucas) {
	steccabucata(luas, lucas, 0);
	}

module steccabucatacentro(luas, lucas) {
	steccabucata(luas, lucas,(luas - lucas)/2 - 2 * rfs);
	}



module peso(span, hp, sltu1) {
	child(0);
	translate([-span-gslit, -span-gslit, gslit + sltu1]) cursore(span, hp);
	}
module tubo(x, y, z) {
	difference() {
		cube([x, y, z]);
		translate([-1, sltu1, sltu1]) cube([x + 2, y - 2 * sltu1, z - 2 * sltu1]);
		}
	}
module giunto() {
	tubo(dml/2 - 5, hba1, hba1);
	
	}

///////////////// slitta /////////////////

module slitta() { 
	 	{
		dml2_ = dml/2;
		group() color("Green", 0.8) translate([dml2_ - hba2 - gslit, -hba2 - gslit, 0]) {
			// supporto destro
			gancio();

			//supporto sinistro
			translate([-dml, 0, 0]) gancio();

			// supporto centrale
			translate([-dml2_, 0, apan - 2 * ads - 2 * aaa - 2 * htu2 -  gslit ]) mirror([0, 0, 1]) gancio(); 
			}

		cl_ = 2 * hba1;// lunghezza supporti contrappeso
		group() color("Blue", 0.8) {
			//montante telaio destro
			translate([dml2_, 0, -gslit]) steccaefinale(aml);

			//montante telaio sinistro
			translate([-dml2_, 0, -gslit]) steccaefinale(aml); 
				
			//montante centrale
			translate([0, 0, aml - smlc - gslit]) {
				stecca(amc);
				//aggancio montante centrale
				translate([0, 0, amc]) steccabucatatesta(luas, lucas);
				//supporti contrappeso avantidietro
				translate([0, 0, smlc]) {
					translate([lba1, 0, hba1]) rotate([-90, 0, 0]) steccabucatatesta(cl_, 0);
					translate([-lba1, 0, hba1]) rotate([-90, 0, 0]) steccabucatatesta(cl_, 0);
					}
				//supporto carrucola
				translate([0, hba1, amc]) rotate([-90, 0, 0]) steccabucatatesta(lsc, 0);
				}
			}
		group() color("Brown", 0.8) {
			//stecca contrappeso avantidietro
			translate([0, cl_ - hba1, hba1 -gslit]) { 
				peso(scp, acp, 0) finale() steccabucatatesta(aml, 0);
				translate([0, scp + hba1 + gslit, gslit]) buca(hba1, 0, 0) stecca(hba1);
				translate ([- 2 * lba1, hba1/2, aml - hba1/2]) rotate ([0,90,0]) perno (5 * lba1);
				}

			}

		group() color("Orange", 0.8) translate([lba1, 0, aml - gslit]) {
			//passanti orizzontali telaio
			translate([0, 0, - hba1 ]) giunto();
			translate([0, 0, - smlc]) giunto();
			translate([-dml2_ , 0, - hba1]) giunto();
			translate([-dml2_ , 0, - smlc]) giunto();
			}


		group() color("Red", 0.8){
			translate([-dml2_ + lba1, 0, acl ]) rotate([0, 90, 0]) rotate([0, 0, 90])
				peso(scpl, acpl, 30) stecca(dml - lba1);
			}
		}
	}


