DROP DATABASE IF EXISTS Formula1;

create database Formula1;
use Formula1;
/*
tim (id_tim, id_ravnatelj, dobiveno_utrka, osvojeno_podija, sjediste, kod_sasija)
vozac(id_vozac, id_tim, ime, prezime, odabrani_broj, datum_rodenja, nacionalnost, osvojeno_naslova_prvaka, osvojeno_podija, osvojeno_bodova, odvozeno_najbrzih_krugova)
auto(id_auto, zavrseno_utrka, vrsta_motora, proizvodac_guma)
sponzor(id_sponzor, ime, isplacen_novac)
staza (id_staza, ime_staze, drzava, duzina, broj_drs_zona)
kvalifikacija(id_kvalifikacija, sesija_kvalifikacije, krugova_vozeno, izlazaka_na_stazu, datum)
trening (id_trening, odvozeno_krugova, najbrzi_krug, izlazaka_na_stazu, datum)
utrka(id_utrka, ime_nagrade, broj_krugova, vrijeme_vozeno, najbrzi_pitstop, datum)
sezona(id_sezona, prvak)
*/


		# tablice potrebno fixat i detaljno provjerit
CREATE TABLE tim(
   id_tim integer primary key,
   id_ravnatelj integer not null,
   dobiveno_utrka char(5) not null,
   osvojeno_podija char(5) not null,
   sjediste varchar(50) not null,
   kod_sasija varchar(30) not null
);
CREATE TABLE vozac(
    id_vozac integer primary key,
    id_tim integer not null,
    ime varchar(30) not null,
    prezime varchar(30) not null,
    odabrani_broj integer not null,
    datum_rodenja date not null, #fixat datum
    nacionalnost varchar(30) not null,
    osvojeno_naslova_prvaka integer not null,
    osvojeno_podija char(5) not null,
    osvojeno_bodova char(5) not null,
    odvozeno_najbrzih_krugova integer not null
);

CREATE TABLE auto(
   id_auto integer primary key,
   zavrseno_utrka char(5) not null ,
   vrsta_motora varchar(40) not null,
   proizvodac_guma varchar(30) not null
);
CREATE TABLE sponzor(
 id_sponzor integer primary key,
 ime varchar(20) not null,
 isplacen_novac char(5) not null
);
CREATE TABLE staza(
   id_staza integer primary key,
   ime_staze varchar(30) not null,
   drzava varchar(30) not null,
   duzina char(30) not null,
   broj_drs_zona char(5) not null
);
CREATE TABLE kvalifikacija(
 id_kvalifikacija integer primary key,
 sesija_kvalifikacije char(5) not null,
 krugova_vozeno char(5) not null,
 izlazaka_na_stazu char(5) not null,
 datum date #fixat datum
);
CREATE TABLE trening(
  id_trening integer primary key,
  odvozeno_krugova char(5) not null,
  najbrzi_krug char(5) not null,
  izlazaka_na_stazu char(5) not null,
  datum date not null #datum fixat
);
CREATE TABLE utrka(
   id_utrka integer primary key,
   ime_nagrade varchar(30),
   broj_krugova char(5) not null,
   vrijeme_vozeno time not null, # fixat
   najbrzi_pitstop char(5) not null,
   datum date not null #fixat
);
CREATE TABLE sezona(
 id_sezona integer primary key,
 prvak varchar(30) not null
);

						# tamplate za dodavanje
INSERT INTO tim VALUES (id_tim, id_ravnatelj, dobiveno_utrka, osvojeno_podija, sjediste, kod_sasija);
INSERT INTO vozac VALUES (id_vozac, id_tim, ime, prezime, odabrani_broj, datum_rodenja, nacionalnost, osvojeno_naslova_prvaka, osvojeno_podija, osvojeno_bodova, odvozeno_najbrzih_krugova);
INSERT INTO auto VALUES (id_auto, zavrseno_utrka, vrsta_motora, proizvodac_guma);
INSERT INTO sponzor VALUES (id_sponzor, ime, isplacen_novac);
INSERT INTO staza VALUES (id_staza, ime_staze, drzava, duzina, broj_drs_zona);
INSERT INTO kvalifikacija  VALUES (id_kvalifikacija, sesija_kvalifikacije, krugova_vozeno, izlazaka_na_stazu, datum);
INSERT INTO trening  VALUES (id_trening, odvozeno_krugova, najbrzi_krug, izlazaka_na_stazu, datum);
INSERT INTO utrka  VALUES (id_utrka, ime_nagrade, broj_krugova, vrijeme_vozeno, najbrzi_pitstop, datum);
INSERT INTO sezona  VALUES (id_sezona, prvak);

