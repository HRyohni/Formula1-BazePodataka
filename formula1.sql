DROP DATABASE IF EXISTS Formula1;

CREATE DATABASE Formula1;
USE Formula1;
/*
tim (id_tim, id_SEF, pobjede, osvojeno_podija, sjediste, kod_sasija)
vozac(id_vozac, id_tim, ime, prezime, odabrani_broj, datum_rodenja, nacionalnost, osvojeno_naslova_prvaka, osvojeno_podija, osvojeno_bodova, odvozeno_najbrzih_krugova)
auto(id_auto, zavrseno_utrka, vrsta_motora, proizvodac_guma)
sponzor(id_sponzor, ime, isplacen_novac)
staza (id_staza, ime_staze, drzava, duzina, broj_drs_zona)
kvalifikacija(id_kvalifikacija, sesija_kvalifikacije, krugova_vozeno, izlazaka_na_stazu, datum)
trening (id_trening, odvozeno_krugova, najbrzi_krug, izlazaka_na_stazu, datum)
utrka(id_utrka, ime_nagrade, broj_krugova, vrijeme_vozeno, najbrzi_pitstop, datum)
sezona(id_sezona, prvak)
*/


-- DEKLARACIJA TABLICA // PROVJERITI!
CREATE TABLE tim(
   id INTEGER PRIMARY KEY,
   naziv VARCHAR(50),
   sef VARCHAR(50),
   pobjede CHAR(5) NOT NULL,
   osvojeno_podija CHAR(5) NOT NULL,
   sjediste VARCHAR(50) NOT NULL,
   kod_sasija VARCHAR(30) NOT NULL,
   utrke CHAR(5)
);

CREATE TABLE vozac(
   id INTEGER PRIMARY KEY,
   id_tim INTEGER NOT NULL,
   id_auto INTEGER NOT NULL;
   ime VARCHAR(30) NOT NULL,
   prezime VARCHAR(30) NOT NULL,
   odabrani_broj INTEGER NOT NULL,
   datum_rodenja DATE NOT NULL, #fixat datum
   nacionalnost VARCHAR(30) NOT NULL,
   osvojeno_naslova_prvaka INTEGER NOT NULL,
   osvojeno_podija CHAR(5) NOT NULL,
   osvojeno_bodova CHAR(5) NOT NULL,
   odvozeno_najbrzih_krugova INTEGER NOT NULL,

   FOREIGN KEY (id_tim) REFERENCES tim(id)
);

  


CREATE TABLE auto(
   id INTEGER PRIMARY KEY,
   id_vozac INTEGER NOT NULL,
   zavrseno_utrka CHAR(5) NOT NULL ,
   vrsta_motora VARCHAR(40) NOT NULL,
   proizvodac_guma VARCHAR(30) NOT NULL
);

CREATE TABLE sponzor(
   id INTEGER PRIMARY KEY,
   ime VARCHAR(20) NOT NULL,
   isplacen_novac INTEGER NOT NULL
);

CREATE TABLE staza(
   id NUMERIC(4,0) PRIMARY KEY,
   ime_staze VARCHAR(30) NOT NULL,
   drzava VARCHAR(30) NOT NULL,
   duzina_m INTEGER NOT NULL,
   broj_drs_zona INTEGER NOT NULL
);

CREATE TABLE kvalifikacija(
   id INTEGER PRIMARY KEY,
   sesija_kvalifikacije CHAR(5) NOT NULL,
   krugova_vozeno CHAR(5) NOT NULL,
   izlazaka_na_stazu CHAR(5) NOT NULL,
   datum DATE #fixat datum
);

CREATE TABLE trening(
   id INTEGER PRIMARY KEY,
   odvozeno_krugova CHAR(5) NOT NULL,
   najbrzi_krug CHAR(5) NOT NULL,
   izlazaka_na_stazu CHAR(5) NOT NULL,
   datum DATE NOT NULL #datum fixat
);

CREATE TABLE utrka(
   id INTEGER PRIMARY KEY,
   ime_nagrade VARCHAR(30),
   pobjednik INTEGER,
   broj_krugova INTEGER NOT NULL,
   vrijeme_vozeno TIME NOT NULL, # fixat
   najbrzi_krug TIME NOT NULL,
   datum DATE NOT NULL, #fixat
   FOREIGN KEY (pobjednik) REFERENCES vozac(id)
);

CREATE TABLE sezona(
   id INTEGER PRIMARY KEY,
   prvak VARCHAR(30) NOT NULL
);


-- PROMJENE I OGRANIČENJA NA TABLICAMA
ALTER TABLE staza
	ADD CONSTRAINT id_len_ck CHECK (length(id) = 4),
   ADD CONSTRAINT id_rng_ck CHECK (id >= 1000 AND id <= 1999),
   ADD CONSTRAINT duzina_rng_ck CHECK (duzina_m >= 1000 AND duzina_m <= 99999);
   
ALTER TABLE tim
	ADD CONSTRAINT id_len_ck CHECK (length(id) = 3),
   ADD CONSTRAINT id_rng_ck CHECK (id >= 100 AND id <= 999);

ALTER TABLE sponzor
   ADD CONSTRAINT id_len_ck CHECK (length(id) = 4),
   ADD CONSTRAINT id_rng_ck CHECK (id> = 2000 AND id <= 2999),
   ADD CONSTRAINT payout_ck CHECK (isplacen_novac >= 500000);

ALTER TABLE utrka
   ADD CONSTRAINT id_len_ck CHECK (length(id) = 4),
   ADD CONSTRAINT id_rng_ck CHECK (id >= 3000 AND id <= 3999);


-- POPUNJAVANJE TABLICE // WIP
INSERT INTO tim VALUES  (101,'McLaren F1 Team', 'Andreas Seidl', 182, 488, 'Woking, Surrey, Velika Britanija', 'MCL35M', 880),
                        (102,'Mercedes AMG Petronas F1 Team', 'Toto Wolff', 124, 264, 'Brackley, Northamptonshire, Velika Britanija', 'Mercedes F1 W12', 249),
                        (103,'Scuderia Ferrari', 'Mattia Binotto', 238, 778, 'Maranello, Italija', '	F1-75', 1030),
                        (104,'Williams Racing', '	Jost Capito', 114, 312, 'Grove, Oxfordshire, Velika Britanija', 'Williams FW43', 744),
                        (105,'Scuderia AlphaTauri Honda', 'Franz Tost', 1, 1, 'Faenza, Italija', 'AlphaTauri AT02', 17),
                        (107,'Aston Martin Cognizant Formula One Team',' Lawrence Stroll I Otmar Szafnauer', 0, 1, 'Silverstone, Velika Britanija','Aston Martin AMR21', 11),
                        (108,'Alpine F1 Team', 'Laurent Rossi i Davide Brivio', 1, 22, 'Enstone, Engleska, Velika Britanija', '	Alpine A521', 20),
                        (111,'Sauber F1 Team', NULL, 0, 10, 'Hinwil, Švicarska', 'Sauber C37', 373),
                        (112,'Force India F1 Team', NULL, 0, 6, 'Silverstone, Northamptonshire, Velika Britanija', 'Force India VJM11', 212),
                        (113,'Red Bull Toro Rosso Honda', 'Franz Tost', 1, 2, 'Faenza, Italija', 'Toro Rosso STR14', 259),
                        (114,'Team Penske', 'Tim Cindric', 1, 0, 'Mooresville, North Carolina', 'sasija', 41), # koji kurac
                        (115,'Haas F1 Team', 'Günther Steiner', 0, 0, 'Banbury, Oxfordshire, Velika Britanija', 'VF-22', 122);
                        (111,'Manor Racing MRT', NULL,0,0, 'sjediste', 'sasija', 21),
                        (111,'Marussia F1 Team', NULL, 0, 0, 'Banbury, Oxfordshire, Velika Britanija', 'MR03B', 74),
                        (111,'HRT Formula 1 Team', NULL, 0, 0, 'Madrid, Španjolska', 'F112', 56),
                        (111,'Caterham F1 Team', NULL, 0, 0, 'Leafield, Oxfordshire, Velika Britanija', 'Caterham CT5', 94),
                        (111,'Lotus F1 Team', NULL, 2, 25, 'Enstone, Oxfordshire, Velika Britanija', 'E23', 77);

                         

                      /*
                      (111,'naziv', sef, pobjede, podij, 'sjediste', 'sasija', utrke),
                      (100,'Red Bull Racing Oracle', 'Christian Horner', 62, 170, 'Christian Horner', 'Red Bull RB18',286),
                      (106,'Alfa Romeo Racing Orlen', 'Frédéric Vasseur', 10, 26, 'Hinwil, Švicarska', 'Alfa Romeo C39', 131),
                       (109,'Renault DP World F1 Team', 'Cyril Abiteboul', 35, 100, ' Enstone, Oxfordshire, Velika Britanija', '	Renault R.S.20', 383),
                        (110,'BWT Racing Point F1 Team',NULL, 1, 4, 'Silverstone, Velika Britanija', 'Racing Point RP19', 47),
                      */


INSERT INTO vozac VALUES   (id_vozac, id_tim,id_auta, 'Charles', 'Leclerc', 16, '16.10.1997.', 'Monako', 0, 16, 631, 7),
                           (id_vozac, id_tim,id_auta, 'Max', 'Verstappen', 1, '30.0.1997.', 'nizozemsko', 1, 62, 1616.5, 17),
                           (id, id_tim,   id_auto,  'Sergio', 'Pérez', 11,  '26.1.1990', 0, 15, 896, 6),
                           (id, id_tim,   id_auto,  'George','Russell', 63,  '15.2.1998.', 0, 1, 19, 1),
                           (id, id_tim,   id_auto,  'Carlos', 'Sainz', 55,'1.9.1994.', 0, 7, 554.5, 1),
                           (id, id_tim,   id_auto,  'Lewis', 'Hamilton', 44,'7.1.1985.', 7, 182, 4165.5, 59),
                           (id, id_tim,   id_auto,  'Lando', 'Norris', 4,'13.11.1999.', 0, 5, 312, 3),
                           (id, id_tim,   id_auto,  'Valtteri', 'Bottas', 77,'28.8.1989.', 0, 67, 1697, 19),
                           (id, id_tim,   id_auto,  'Esteban', 'Ocon', '31,  17.9.1996', 0, 2, 272, 0),
                           (id, id_tim,   id_auto,  'Kevin', 'Magnussen',   ,  'datum_rodenja','nacionalnost', osvojeno_naslova_prvaka, osvojeno_podija, osvojeno_bodova, odvozeno_najbrzih_krugova),
                           (id, id_tim,   id_auto,  'ime', 'prezime', odabrani_broj,  'datum_rodenja','nacionalnost', osvojeno_naslova_prvaka, osvojeno_podija, osvojeno_bodova, odvozeno_najbrzih_krugova)
INSERT INTO auto VALUES (id_auto, zavrseno_utrka, vrsta_motora, proizvodac_guma);


-- SPONZORI // LISTA JE SMANJENA ZBOG OGROMNE KOLIČINE PODATAKA GLEDAJUĆI DA SVAKI TIM IMA PO MINIMALNO 20 SPONZORA.
INSERT INTO sponzor VALUES (2001, 'Petronas', 100000000),
                           (2002, 'Tommy Hilfiger', 24000000),
                           (2003, 'Monster Energy',56000000),
                           (2004, 'Oracle', 96500000),
                           (2005, 'Cash App', 76000000),
                           (2006, 'AT&T', 23760000),
                           (2007, 'Shell', 136758000),
                           (2008, 'Santander', 12000000),
                           (2009, 'VELAS', 57000000),
                           (2010, 'Snapdragon', 9000000),
                           (2011, 'Google', 194986000),
                           (2012, 'Dell', 29000000),
                           (2013, 'Alienware', 19000000),
                           (2014, 'Logitech G', 38760000),
                           (2015, 'SunGod', 560000),
                           (2016, 'BWT', 112000000),
                           (2017, 'RCI Bank and Services', 98760000),
                           (2018, 'Yahoo', 56000000),
                           (2019, 'Kappa', 780000),
                           (2020, 'Sprinklr', 520000),
                           (2021, 'AlphaTauri', 230670000),
                           (2022, 'Honda', 73187500),
                           (2023, 'Pirelli', 4167940000),
                           (2024, 'Ray Ban', 10000000),
                           (2025, 'Siemens', 13000000),
                           (2026, 'Aramco', 79000000),
                           (2027, 'TikTok', 20000000),
                           (2028, 'Hackett London',6780000),
                           (2029, 'Lavazza', 30000000),
                           (2030, 'DURACELL', 24000000),
                           (2031, 'Acronis', 53000000),
                           (2032, 'Alfa Romeo', 45600000),
                           (2033, 'PKN ORLEN', 39876500),
                           (2034, 'Iveco', 12000000),
                           (2035, 'Puma', 40123000),
                           (2036, 'Haas Automation', 36000000),
                           (2037, 'Maui Jim', 980760),
                           (2038, 'Alpinestars', 63000000),
                           (2039, 'TeamViewer', 5000000),
                           (2040, 'Richard Mille', 16400300),
                           (2041, 'Police', 5600000),
                           (2042, 'Philip Morris International', 13873900),
                           (2043, 'Rauch', 97655980),
                           (2044, 'UPS', 37000000),
                           (2045, 'Dupont', 19050000),
                           (2046, 'Marlboro', 160753100),
                           (2047, 'Martini', 75000000),
                           (2048, 'Rexona', 80000000),
                           (2049, 'NOVA Chemicals', 93000000),
                           (2050, 'TAGHeuer', 60000000);


-- STAZE // SVE OD 2012 DO 2022 // NEKE SU SE MJENJALE KROZ GODINE ALI "FOR SAKE OF BREVITY" NECEMO IH UBACIVATI KAO ODVOJENE STAZE.
INSERT INTO staza VALUES  (1001, 'Bahrain International Circuit 2005-2022', 'Sakhir, Bahrain', 5412, 3),
                          (1002, 'Jeddah Corniche Circuit', 'Jeddah, Saudi Arabia', 6174, 3),
                          (1003, 'Albert Park Circuit', 'Melbourne, Australia', 5278, 3),
                          (1004, 'Autodromo Enzo e Dino Ferrari 2008-2022', 'Imola, Italy', 4909, 1),
                          (1005, 'Miami International Autodrome', 'Miami, USA', 5412, 3),
                          (1006, 'Circuit de Barcelona-Catalunya 2021-2022', 'Montmeló, Spain', 4675, 2),
                          (1007, 'Circuit de Monte Carlo 2015-2022', 'Monte Carlo, Monaco', 3337, 1),
                          (1008, 'Baku City Circuit', 'Baku, Azerbaijan', 6003, 2),
                          (1009, 'Circuit Gilles-Villeneuve', 'Montreal, Canada', 4361, 2),
                          (1010, 'Silverstone Circuit', 'Silverstone, UK', 5891, 2),
                          (1011, 'Red Bull Ring', 'Spielberg, Austria', 4318, 2),
                          (1012, 'Circuit Paul Ricard', 'Le Castellet, France', 5842, 2),
                          (1013, 'Hungaroring', 'Mogyoród, Hungary', 4381, 1),
                          (1014, 'Circuit Spa-Francorchamps', 'Stavelot, Belgium', 7004, 2),
                          (1015, 'Circuit Zandvoort', 'Zandvoort, Netherlands', 4259, 2),
                          (1016, 'Autodromo Nazionale Monza', 'Monza, Italy', 5793, 2),
                          (1017, 'Sochi Autodrom', 'Sochi, Russia', 5848, 2),
                          (1018, 'Marina Bay Circuit', 'Marina Bay, Singapore', 5063, 3),
                          (1019, 'Suzuka Circuit', 'Suzuka, Japan', 5807, 1),
                          (1020, 'Circuit of the Americas', 'Austin, USA', 5514, 2),
                          (1021, 'Autódromo Hermanos Rodríguez', 'Mexico City, Mexico', 4304, 1),
                          (1022, 'Autódromo José Carlos Pace', 'São Paulo, Brazil', 4309, 2),
                          (1023, 'Yas Marina Circuit', 'Yas Island', 5281, 2),
                          (1023, 'Autodromo do Algarve 2008-2022', 'Portimão, Portugal', 4653, 2),
                          (1024, 'Istanbul Park 2005-2022', 'Istanbul, Turkey', 5338, 2),
                          (1025, 'Losail International Circuit 2004-2022', 'Lusail, Qatar', 5380, 1),
                          (1026, 'Mugello 1974-2022', 'Scarperia e San Piero, Italy', 5245, 1),
                          (1027, 'Nürburgring 2002-2022', 'Nürburg, Germany', 5148, 2),
                          (1028, 'Bahrain International Circuit (OUTER)', 'Sakhir, Bahrain', 3543, 2),
                          (1029, 'Hockenheimring 2002-2022', 'Hockenheim, Germany', 4574, 2),
                          (1030, 'Shanghai International Circuit 2004-2022', 'Shanghai, China', 5451, 2),
                          (1031, 'Sepang International Circuit 1999-2022', 'Sepang, Malaysia', 5543, 2),
                          (1032, 'Korean International Circuit 2010-2022', 'Yeongam, South Korea', 5615, 2),
                          (1033, 'Buddh International Circuit 2011-2022', 'Greater Noida, India', 5125, 2),
                          (1034, 'Valencia Street Circuit 2008-2012', 'Valencia, Spain', 5419, 2);


INSERT INTO kvalifikacija  VALUES (id_kvalifikacija, sesija_kvalifikacije, krugova_vozeno, izlazaka_na_stazu, datum);
INSERT INTO trening  VALUES (id_trening, odvozeno_krugova, najbrzi_krug, izlazaka_na_stazu, datum);


-- UTRKE //
INSERT INTO utrka  VALUES (id, ime_nagrade, pobjednik, broj_krugova, vrijeme_vozeno, najbrzi_krug, datum),
                          (3001, '2012 Australian GP', pobjednik, 58, 01:34:09.565, 00:01:29.187, 2012-03-18),
                          (3002, '2012 Malaysian GP', pobjednik, 56, 02:44:51.812, 00:01:41.680, 2012-03-25),
                          (3002, '2012 Chinese GP', pobjednik, 56, 01:36:26.929, 00:01:40.967, 2012-04-15),
                          (3002, '2012 Bahrain GP', pobjednik, 57, 01:35:10.990, 00:01:36.379, 2012-04-22),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),
                          (3002, '', pobjednik, , , , ),

-- SEZONE // 
INSERT INTO sezona  VALUES (id, prvak);
                           (, ),
                           (, ),
                           (, ),
                           (, ),
                           (, ),
                           (, ),
                           (, ),
                           (, ),
                           (, ),
                           (, ),