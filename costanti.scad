gtel = 1; // gioco telaio struttura

lipe = 5.5; 	//larghezza ipe
aipe = 10; 	//altezza ipe
slipe = 0.57; 	//spessore ali ipe
ripe = 0.7;	//raggio giunzioni costa ali ipe
saipe = 0.41;	//spessore costa ipe

alcam = 280 + gtel;	//altezza campata
lacam = 203 + gtel;	//larghezza campata

spia = 0.6;	//spessore piastre collegamento struttura
rfori = 0.65;	//raggio fori assemblaggio
atubolare = 8;	//altezza tubolare struttura
ltubolare = 4;	//larghezza tubolare struttura

lutubolare = lacam - lipe;
stubolare = 0.3; // spessore tubolare

rpepia = 0.8; // raggio perni piastra muro
lfpiamu = 3*rpepia; // raggio foro perni piastra muro

lumor = 6.7; 	// lunghezza morsi
lamor = 3;	// larghezza morsi
almor = 2;	// altezza morsi
gmor = 0.5;	// gioco morsi
dtrapia = 2;	// distanza trave piastra

nfo = 15;	// numero fori orizzontali piastra muro
dfo = lipe/2; 	// distanza fori orizzontali piastra muro
lpiamu = nfo * dfo; // larghezza piastra

nfv = 4;	// numero fori verticali
dfv = 6; 	// interasse fori verticali
apiamu = dfv * nfv; 	// altezza piastra
spiamu = 1.2; 		// spessore piastra
lpepia = 15; 		// lunghezza  perni piastra muro
tpepia = rpepia + 0.4; 	// raggio testa perni piastra muro

dad = 0.6 * lacam; // distanza asole doppie

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


lpan = lacam; //larghezza pannello/telaio
apan = alcam; // altezza pannello/telaio
gpan = 5; // gioco pannelli

topan = 60; // trama orizzontale pannello


lbp = 40;//lunghessa basamento piede
pbp = 2/3;  //prominenza basamento piede

gper = 0.1; // gioco perno


