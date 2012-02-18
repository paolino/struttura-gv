module pzx(dp,lt) {
	translate ([(lt - dp)/2,0,0]) child(0);
	translate ([(lt + dp)/2,0,0]) child(0);
	}
module pzz(dp,lt) {
	translate ([0,0,(lt - dp)/2]) child (0);
	translate ([0,0,(lt + dp)/2]) child (0);
	}

module fillx (dp,lt) {
	n = floor (lt/dp);
	dp_ = lt/n;
	for (i=[1:n-1]) translate ([i * dp_,0,0]) child (0);
	}

module fillz (dp,lt) {
	n = floor (lt/dp);
	dp_ = lt/n;
	for (i=[1:n-1]) translate ([0,0,i * dp_]) child (0);
	}

function ps1_(dad,l,x) = (l + dad - x)/2;
function ps2_(dad,l,x) = (l - dad - x)/2;

module dado() {
	cylinder(r = rtb, h = atba, $fn = 6);
	}

