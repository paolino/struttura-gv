lipe = 5.5;
aipe = 10;
slipe = 0.57;
ripe = 0.7;
saipe = 0.41;
ltrav = 280;
spia = 0.6;
rfori = 0.65;
atubolare = 8;
ltubolare = 4;
apiatubolare = 16;
lacam = 203;
lutubolare = lacam - lipe;
stubolare = 0.3; // spessore tubolare

rpepia = 0.8; // raggio perni piastra
lfpiamu = 3*rpepia; // lato foro perni

nfo = 15;
dfo = lipe/2; // numero massimo di grani sotto la ipe
lpiamu = nfo * dfo; // larghezza piastra

nfv = 4;
dfv = 6; // interasse foro perni
apiamu = dfv * nfv; // altezza piastra
spiamu = 1.2; // spessore piastra
lpepia = 15; // raggio perni piastra
tpepia = rpepia + 0.4; // raggio perni piastra

echo ("peso piastra:");
echo (lpiamu * apiamu * spiamu * 7.85/1000);

dad = 0.6 * lacam; // distanza asola destra dall'inizio pannello

// ba1 : quadro pieno di dimensioni lba1 hba1

lba1 = 5; // 
hba1 = 10; // 

// ba2 : quadro pieno di dimensioni lba2 hba2 

hba2 = 3; // 
lba2 = 8; //

// tu1 : tubolare quadrato di dimensioni hba1 hba1

sltu1 = 0.5; // spessore tubolari quadrati 

// pia1 : piastra di spessore spia1

spia1 = 2; // spessore fermo montanti

gslit = 0.5; // gioco slitta
gspin = 1; // gioco ingombro/spina

acg = 2 * lba2 ; // altezza cursori ganci

ads = 3; // altezza denti spina
lds = hba2; // larghezza denti spina

ltu2 = 6; // larghezza tubolare telaio
htu2 = 3; // altezza tubolare telaio

span = 1.9; // spessore pannello forex
spra = 12; // ingombro prato

amc = 250;// altezza montante centrale
dml = 60;// distanza montanti laterali
dadf = dml ;
aml = 120;// altezza montanti laterali

smlc = 50; // sovrapposizione montanti laterali/montante centrale

luas = 20; // lunghezza aggancio slitta
lucas = 10; // lunghezza aggancio slitta

rfs = 2; // raggio fori slitta

scp = 8; // spessore contrappeso
acp = 20; // altezza contrappeso

acl = 2 * (aml - smlc)/3; //altezza cursore laterale

scpl = 4; // spessore contrappeso laterale
acpl = 25; // lunghezza contrappeso laterale

lsc = 5 * hba1; // lunghezza sostegno carrucola 

aaa = 7; // altezza asole agganci

rfa = 0.6; // raggio filetto
atba = 1; // altezza testa bullone
rtb = 1.05; // raggio testa bullone

grfa = 0.1; // gioco asole/filetto come delta raggio filetto
rop = rtb + 1; // raggio oblo pannello sulle asole/filetti

atra = 25; // altezza trave
ltra = 12; //spessore trave
gtrav = 0.5; // mezza tolleranza sulla distanza tra i travi

gtel = 1; // gioco telaio struttura

lpan = lacam; //larghezza pannello/telaio
apan = ltrav; // altezza pannello/telaio
gpan = 5; // gioco pannelli

topan = 60; // trama orizzontale pannello


lbp = 40;//lunghessa basamento piede
pbp = 2/3;  //prominenza basamento piede

gper = 0.1; // gioco perno




function ps1_(dad,l,x) = (l + dad - x)/2;
function ps2_(dad,l,x) = (l - dad - x)/2;
module pzx(dp,lt) {
	translate ([(lt - dp)/2,0,0]) child(0);
	translate ([(lt + dp)/2,0,0]) child(0);
	}
module pzz(dp,lt) {
	translate ([0,0,(lt - dp)/2]) child (0);
	translate ([0,0,(lt + dp)/2]) child (0);
	}
module ipe () {
	difference () {
		cube ([lipe,aipe,ltrav]);
		translate ([(lipe + saipe)/2,slipe,-1])
			 cube ([(lipe - saipe)/2 + 1,aipe - 2 * slipe, ltrav + 1]);
		translate ([-1,slipe,-1])
			 cube ([(lipe - saipe)/2 + 1,aipe - 2 * slipe, ltrav + 1]);
		for (i  = [1,3]) for (j = [atubolare / 4 ,ltrav - atubolare/4])  
			translate([-1 + lipe/2, slipe + ripe + i * (aipe - 2*(slipe + ripe))/4,j]) rotate ([0,90,0]) cylinder(h = spia + 2, r = rfa, $fn = 10);		
		translate([lipe/2 -1, aipe/2, 0]) pzz(dad,ltrav) rotate(90, [0, 1, 0]) cylinder(h = spia + 2, r = rfa, $fn = 10);	
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
		pzz (dad,ltrav) group () {
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
	for (i= [0,ltrav]) {
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
	for (i = [0,1]) translate ([lipe ,0,- atubolare / 2  + i * ltrav]) tubolare();
	
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

lumor = 6.7;
lamor = 3;
almor = 2;
gmor = 0.5;
dtrapia = 2;

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


///////////////////////////////////////
//  pannello   ///////////////////////
//////////////////////////////////////

module supportoT () {
	cube ([htu2,ltu2,aaa]);
	}
	
module supportoL () {
	cube ([lba2,hba2,aaa]);
	}

	
rw = 2 * hba2 + lds + 2 * gslit;
rh = lba2 + ads + 2 * gslit;
module femmina() {
	difference() {
		cube([rw, ltu2, rh + hba2]);
		translate([hba2, -1, -1]) cube([lds + 2 * gslit, ltu2 + 2, rh + 1]);
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
					supportoT(aaa); 
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
//////////////////////////////////////

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



////////////////////////////////
/// travi /////////////////////
///////////////////////////////

module dado() {
	cylinder(r = rtb, h = atba, $fn = 6);
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


///////////// disegni /////////////////////

*ipe ();
*filetto_v();
*ipeconagganci ();
*filetto_o();
*projection (cut = true) translate ([0,0,-0.5]) piastratesta ();
*piastrafiletti ();
*projection (cut = true) translate ([0,0,-0.5]) piastralato ();
*projection (cut = true) translate ([0,0,-4]) traveconpiastre ();
*projection (cut = true) translate ([0,0,-1]) rotate ([90,0,0]) traveconpiastre ();
*trave ();	
*projection (cut = true) translate ([0,0,0.5]) rotate ([0,90,0]) piastratubolare ();
*piastratubolare ();
*tubolare ();
*projection (cut = true) translate ([0,0,-2.5]) rotate ([90,0,0]) tubolareintestato ();
*projection (cut = true) translate ([0,0,-5]) tubolareintestato ();
*tubolareintestato ();
*travecontubi ();
*piastramuro ();
*piastramurocontrave ();

*giunto();
*slitta();
*asola_v();
*asola_o();
*femmina ();
*telaio();
*projection (cut = true) translate ([0,0,-2]) rotate ([90,0,0]) telaio();
*telaiosullastruttura ();
*pannello();
*projection (cut = true) rotate ([90,0,0]) pannello();
*telaioepannello();
for (i=[0,1]) for (j=[0,1]) translate ([i * lacam,0,j*ltrav]) pannellosullastruttura();
*slittasulpannello();
*dado();
*travi();
*pannellosuitravi();
*piede();
*pannellosuipiedi();
*perno (10);
*aggancioponte ();
*telaiocongancioponte ();
*pannellocongancioponte ();

*piastragiunzione ();
*asola_o ();

*projection (cut = true) translate ([0,0,lipe/2]) rotate ([0,90,0]) ipe ();

