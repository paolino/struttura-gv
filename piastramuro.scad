include <costanti.scad>

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

