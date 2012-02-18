include <struttura.scad>
include <pannello.scad>
include <costanti.scad>
include <funzioni.scad>


*ipe ();
*filetto_v();
*ipeconagganci ();
*filetto_o ();
*projection (cut = true) translate ([0,0,-0.5]) piastratesta ();
*piastrafiletti ();
*projection (cut = true) translate ([0,0,-0.5]) piastralato ();
*projection (cut = true) translate ([0,0,-4]) traveconpiastre ();
*projection (cut = true) translate ([0,0,-1]) rotate ([90,0,0]) traveconpiastre ();
*trave (false);	
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
*for (i=[0,1]) for (j=[0,1]) translate ([i * lacam,0,j*alcam]) pannellosullastruttura();
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
*projection (cut = true) translate ([0,0,spia/2]) rotate ([0,90,0]) piastragiunzione ();
*projection (cut = true) translate ([0,0,5]) rotate ([0,90,0]) piastragiunzione ();
projection (cut = true) translate ([0,0,-spia/2]) piastragiunzione ();
*asola_o ();

*projection (cut = true) translate ([0,0,lipe/2]) rotate ([0,90,0]) ipe ();
*strutturaregolare (1,1);
*fillx (10,100) dado ();
*ipeconagganci(150);
*piastragiunzioneD(25);
*piastrafiletti();
*translate ([(lipe + saipe)/2,0,spia]) tubolare(150,45);
*traveD (true, 100, 30);
