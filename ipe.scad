
module ipe () {
	difference () {
		cube ([lipe,aipe,ltrav - 2 * spia]);
		translate ([(lipe + saipe)/2,slipe,-1])
			 cube ([(lipe - saipe)/2 + 1,aipe - 2 * slipe, ltrav - 2 * spia + 1]);
		translate ([-1,slipe,-1])
			 cube ([(lipe - saipe)/2 + 1,aipe - 2 * slipe, ltrav - 2 * spia + 1]);
		}
	}


module piastratesta () {
	spa_ = (lipe - saipe) / 4;
	echo  (spa_);
	difference () {
		cube ([lipe,aipe,spia]);
		for (i = [spa_,lipe - spa_]) {
			for (j = [1,3]) {
				translate ([i,j* aipe/4,-1])
					cylinder (r = rfori, h = spia + 2, $fn = 16);
					}
				}
		
		}

	}

module traveintestata () {
	piastratesta ();
	translate ([0,0,spia]) ipe ();
	translate ([0,0,ltrav - spia]) piastratesta ();
	}

apl = apiatubolare/2;
dfbpl = (apl - atubolare/2)/2;

module piastralato () {
	difference () {
		cube ([apl,ltubolare,spia]);
			translate ([dfbpl, ltubolare/2,-1])
					cylinder (r = rfori, h = spia + 2, $fn = 16);
					}
		

	}


module traveconpiastre () {
	traveintestata ();
	translate ([-spia,0,apiatubolare/2]) rotate ([0,90,0]) piastralato ();
	translate ([lipe - spia,0,0]) 
		translate ([spia,0,apiatubolare/2]) rotate ([0,90,0]) piastralato ();
	translate ([0,0,ltrav]) mirror ([0,0,1])
		translate ([-spia,0,apiatubolare/2]) rotate ([0,90,0]) piastralato ();
	translate ([0,0,ltrav]) mirror ([0,0,1]) translate ([lipe - spia,0,0])
		translate ([spia,0,apiatubolare/2]) rotate ([0,90,0]) piastralato ();
	} 

module trave (n) {
	for (i = [1:n]) {
		translate ([0,0,ltrav * (i - 1)]) traveconpiastre ();
		}
	}

module piastratubolare () {
	difference () {
		cube ([spia, ltubolare , apiatubolare]);
		for (i = [dfbpl, apiatubolare - dfbpl]) {
			for (j = [2]) {
				translate ([-1,j * ltubolare/4,i])
				rotate ([0,90,0])
				cylinder (r = rfori, h = spia + 2, $fn = 16);

				}
			}
		}

	}

function ps1_(l,x) = (l + dad - x)/2;
function ps2_(l,x) = (l - dad - x)/2;

module tubolare () {
	difference () {
		cube ([lutubolare - 4 * spia, ltubolare, atubolare]);
		translate ([-1, stubolare, stubolare])
			cube ([lutubolare - 4 * spia + 2, ltubolare - 2 * stubolare, atubolare - 2 * stubolare]);
		}
	}

module tubolareintestato () {
	translate ([spia, 0, (apiatubolare - atubolare) / 2]) 	tubolare ();
	piastratubolare ();
	translate ([lutubolare - 3*spia,0,0]) piastratubolare ();
	}

module travecontubi (k,n,m) {
	for (q = [0 : k - 1]) {
		translate ([q * lacam,0,0]) {
			trave (n);
			for (i = [0:m]) {
				translate ([lipe + spia,0,-apiatubolare/2 + i * ltrav])
					tubolareintestato ();
				}
			}
		}
	translate ([k * lacam,0,0]) trave (n);
	
	}

module piastramuro () {
	cube ([lpiamu,spia,apiamu]);
	}		
*ipe ();
*projection (cut = true) translate ([0,0,-0.5]) piastratesta ();
*piastratesta ();
*traveintestata ();
*piastralato ();
*projection (cut = true) translate ([0,0,-0.5]) piastralato ();
*traveconpiastre ();
*projection (cut = true) translate ([0,0,-4]) traveconpiastre ();
*projection (cut = true) translate ([0,0,-1]) rotate ([90,0,0]) traveconpiastre ();
*trave (3);	
*projection (cut = true) translate ([0,0,0.5]) rotate ([0,90,0]) piastratubolare ();
*piastratubolare ();
*tubolare ();
*projection (cut = true) translate ([0,0,-3]) rotate ([90,0,0]) tubolareintestato ();
*projection (cut = true) translate ([0,0,-5]) tubolareintestato ();
*tubolareintestato ();
*travecontubi (1,1,1);
*piastramuro ();
