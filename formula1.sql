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
   id_tim INTEGER PRIMARY KEY,
   naziv VARCHAR(50),
   voditelj VARCHAR(50),
   pobjede CHAR(5) NOT NULL,
   osvojeno_podija CHAR(5) NOT NULL,
   sjediste VARCHAR(50) NOT NULL,
   kod_sasija VARCHAR(30) NOT NULL,
   utrke CHAR(5)
);

CREATE TABLE vozac(
   id_vozac INTEGER PRIMARY KEY,
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

CREATE TABLE vozac_u_timu(
   id_vozac FOREIGN KEY,
   id_tim FOREIGN KEY,
   godina INTEGER NOT NULL
);

CREATE TABLE automobil(
   id_auto INTEGER PRIMARY KEY,
   id_vozac INTEGER NOT NULL,
   zavrseno_utrka CHAR(5) NOT NULL ,
   vrsta_motora VARCHAR(40) NOT NULL,
   proizvodac_guma VARCHAR(30) NOT NULL
);

CREATE TABLE sponzor(
   id_sponzor INTEGER PRIMARY KEY,
   ime VARCHAR(20) NOT NULL,
   isplacen_novac INTEGER NOT NULL
);

CREATE TABLE staza(
   id_staza NUMERIC(4,0) PRIMARY KEY,
   ime_staze VARCHAR(50) NOT NULL,
   drzava VARCHAR(30) NOT NULL,
   duzina_m INTEGER NOT NULL,
   broj_drs_zona INTEGER NOT NULL
);

CREATE TABLE kvalifikacija(
   id_quali INTEGER PRIMARY KEY,
   sesija_kvalifikacije CHAR(5) NOT NULL,
   krugova_vozeno CHAR(5) NOT NULL,
   izlazaka_na_stazu CHAR(5) NOT NULL,
   datum DATE #fixat datum
);

CREATE TABLE trening(
   id_trening INTEGER PRIMARY KEY,
   odvozeno_krugova CHAR(5) NOT NULL,
   najbrzi_krug CHAR(5) NOT NULL,
   izlazaka_na_stazu CHAR(5) NOT NULL,
   datum DATE NOT NULL #datum fixat
);

CREATE TABLE utrka(
   id_utrka INTEGER PRIMARY KEY,
   ime_nagrade VARCHAR(30),
   pobjednik INTEGER,
   broj_krugova INTEGER NOT NULL,
   vrijeme_vozeno TIME NOT NULL, # fixat
   najbrzi_krug TIME NOT NULL,
   datum DATE NOT NULL, #fixat
   FOREIGN KEY (pobjednik) REFERENCES vozac(id)
);

CREATE TABLE sezona(
   id_sezona INTEGER PRIMARY KEY,
   prvak VARCHAR(30) NOT NULL
);

CREATE TABLE vikend(
   id_vikend INTEGER PRIMARY KEY,
   id_trening FOREIGN KEY,
   id_quali FOREIGN KEY,
   id_utrka FOREIGN KEY
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
   ADD CONSTRAINT id_rng_ck CHECK (id >= 4000 AND id <= 4999),
   ADD CONSTRAINT payout_ck CHECK (isplacen_novac >= 500000);

ALTER TABLE utrka
   ADD CONSTRAINT id_len_ck CHECK (length(id) = 4),
   ADD CONSTRAINT id_rng_ck CHECK (id >= 3000 AND id <= 3999);


-- POPUNJAVANJE TABLICE // WIP 
INSERT INTO tim VALUES  (id_tim, naziv, voditelj, pobjede, osvojeno_podija, sjediste, kod_sasija, utrke),
                        (101, 'McLaren F1 Team', 'Andreas Seidl', 182, 488, 'Woking, Surrey, Velika Britanija', 'MCL35M', 880),
                        (102, 'Mercedes AMG Petronas F1 Team', 'Toto Wolff', 124, 264, 'Brackley, Northamptonshire, Velika Britanija', 'Mercedes F1 W12', 249),
                        (103, 'Scuderia Ferrari', 'Mattia Binotto', 238, 778, 'Maranello, Italija', '	F1-75', 1030),
                        (104, 'Williams Racing', '	Jost Capito', 114, 312, 'Grove, Oxfordshire, Velika Britanija', 'Williams FW43', 744),
                        (105, 'Scuderia AlphaTauri Honda', 'Franz Tost', 1, 1, 'Faenza, Italija', 'AlphaTauri AT02', 17),
                        (107, 'Aston Martin Cognizant Formula One Team',' Lawrence Stroll I Otmar Szafnauer', 0, 1, 'Silverstone, Velika Britanija','Aston Martin AMR21', 11),
                        (108, 'Alpine F1 Team', 'Laurent Rossi / Davide Brivio', 1, 22, 'Enstone, Engleska, Velika Britanija', '	Alpine A521', 20),
                        (111, 'Sauber F1 Team', 'Monisha Kaltenborn', 0, 10, 'Hinwil, Švicarska', 'Sauber C37', 373),
                        (112, 'Force India F1 Team', 'Colin Kolles', 0, 6, 'Silverstone, Northamptonshire, Velika Britanija', 'Force India VJM11', 212),
                        (113, 'Red Bull Toro Rosso Honda', 'Franz Tost', 1, 2, 'Faenza, Italija', 'Toro Rosso STR14', 259),
                        -- (114,'Team Penske', 'Tim Cindric', 1, 0, 'Mooresville, North Carolina, Sjedinjene Američke Države', 'sasija', 41)  <- Tim iz 1970-ih
                        (115, 'Haas F1 Team', 'Günther Steiner', 0, 0, 'Banbury, Oxfordshire, Velika Britanija', 'VF-22', 122);
                        (111, 'Manor Racing MRT', 'Dave Ryan', 0, 0, 'Banbury, Oxfordshire, Velika Britanija', 'MRT05', 21),
                        (111, 'Marussia F1 Team', 'John Booth', 0, 0, 'Banbury, Oxfordshire, Velika Britanija', 'MR03B', 74),
                        (111, 'HRT Formula 1 Team', 'Colin Kolles', 0, 0, 'Madrid, Španjolska', 'F112', 56),
                        (111, 'Caterham F1 Team', 'Tony Fernandes', 0, 0, 'Leafield, Oxfordshire, Velika Britanija', 'Caterham CT5', 94),
                        (111, 'Lotus F1 Team', 'Gérard Lopez', 2, 25, 'Enstone, Oxfordshire, Velika Britanija', 'E23', 77);

                         

                      /*
                      (100,'Red Bull Racing Oracle', 'Christian Horner', 62, 170, 'Christian Horner', 'Red Bull RB18',286),
                      (106,'Alfa Romeo Racing Orlen', 'Frédéric Vasseur', 10, 26, 'Hinwil, Švicarska', 'Alfa Romeo C39', 131),
                       (109,'Renault DP World F1 Team', 'Cyril Abiteboul', 35, 100, ' Enstone, Oxfordshire, Velika Britanija', '	Renault R.S.20', 383),
                        (110,'BWT Racing Point F1 Team',NULL, 1, 4, 'Silverstone, Velika Britanija', 'Racing Point RP19', 47),
                      */


INSERT INTO vozac VALUES   /*2017*/
                           (id, id_tim,   id_auto,  'Felipe', 'Massa', 19,  '25.4.1981.','brazilsko', 0, 41, 1167, 15),
                           (id, id_tim,   id_auto,  'Jolyon', 'Palmer', 30,  '20.1.1991.','britansko', 0, 0, 35, 0)
                           (id, id_tim,   id_auto,  'Pascal', 'Wehrlein', 94,  '18.10.1994.','njemačko', 0, 3, 6, 3),
                           (id, id_tim,   id_auto,  'Daniil', 'Kvyat', 26,  '26.4.1994.','ruska', 0, 3, 202, 1),
                           (id, id_tim,   id_auto,  'Antonio' , 'Giovinazzi', 99,  '14.12.1993.','talijanska', 0, 0, 21, 0),

                           /*2016*/
                           (id, id_tim,   id_auto,  'Jenson', 'Button', 22,  '19.1.1980.','britanska', 1, 50, 1235, 8)                           
                           (id, id_tim,   id_auto,  'Esteban', 'Gutierrez', 21,  '5.8.1991.','meksički', 0, 0, 6, 1),                           
                           (id, id_tim,   id_auto,  'Rio', 'Haryanto', 88,  '22.1.1993.','indonezijsko', 0, 0, 0, 0),

                           /*2015*/
                           (id, id_tim,   id_auto,  'Roberto', 'Merhi', 98,  '22.3.1991.','španjolsko', 0, 0, 0, 0),
                           (id, id_tim,   id_auto,  'Nico', 'Rosberg', 6,  '27.6.1985.','njemačko', 1, 57, 1594.5, 20),
                           (id, id_tim,   id_auto,  'Felipe', 'Nasr', 12,  '21.8.1992.','brazilsko', 0, 0, 29, 0),
                           (id, id_tim,   id_auto,  'Pastor', 'Maldonado', 13,  '9.3.1985.','venecuelanski', 0, 1, 76, 0)
                           (id, id_tim,   id_auto,  'Alexander', 'Rossi', 53,  '25.9.1991.','američko', 0, 25, osvojeno_bodova, odvozeno_najbrzih_krugova)x
                           (id, id_tim,   id_auto,  'ime', 'prezime', odabrani_broj,  'datum_rodenja','nacionalnost', osvojeno_naslova_prvaka, osvojeno_podija, osvojeno_bodova, odvozeno_najbrzih_krugova)
                           (id, id_tim,   id_auto,  'ime', 'prezime', odabrani_broj,  'datum_rodenja','nacionalnost', osvojeno_naslova_prvaka, osvojeno_podija, osvojeno_bodova, odvozeno_najbrzih_krugova)

INSERT INTO auto VALUES (id_auto, zavrseno_utrka, vrsta_motora, proizvodac_guma);


-- SPONZORI // LISTA JE SMANJENA ZBOG OGROMNE KOLIČINE PODATAKA GLEDAJUĆI DA SVAKI TIM IMA PO MINIMALNO 20 SPONZORA.
INSERT INTO sponzor VALUES (4001, 'Petronas', 100000000),
                           (4002, 'Tommy Hilfiger', 24000000),
                           (4003, 'Monster Energy',56000000),
                           (4004, 'Oracle', 96500000),
                           (4005, 'Cash App', 76000000),
                           (4006, 'AT&T', 23760000),
                           (4007, 'Shell', 136758000),
                           (4008, 'Santander', 12000000),
                           (4009, 'VELAS', 57000000),
                           (4010, 'Snapdragon', 9000000),
                           (4011, 'Google', 194986000),
                           (4012, 'Dell', 29000000),
                           (4013, 'Alienware', 19000000),
                           (4014, 'Logitech G', 38760000),
                           (4015, 'SunGod', 560000),
                           (4016, 'BWT', 112000000),
                           (4017, 'RCI Bank and Services', 98760000),
                           (4018, 'Yahoo', 56000000),
                           (4019, 'Kappa', 780000),
                           (4020, 'Sprinklr', 520000),
                           (4021, 'AlphaTauri', 230670000),
                           (4022, 'Honda', 73187500),
                           (4023, 'Pirelli', 4167940000),
                           (4024, 'Ray Ban', 10000000),
                           (4025, 'Siemens', 13000000),
                           (4026, 'Aramco', 79000000),
                           (4027, 'TikTok', 20000000),
                           (4028, 'Hackett London',6780000),
                           (4029, 'Lavazza', 30000000),
                           (4030, 'DURACELL', 24000000),
                           (4031, 'Acronis', 53000000),
                           (4032, 'Alfa Romeo', 45600000),
                           (4033, 'PKN ORLEN', 39876500),
                           (4034, 'Iveco', 12000000),
                           (4035, 'Puma', 40123000),
                           (4036, 'Haas Automation', 36000000),
                           (4037, 'Maui Jim', 980760),
                           (4038, 'Alpinestars', 63000000),
                           (4039, 'TeamViewer', 5000000),
                           (4040, 'Richard Mille', 16400300),
                           (4041, 'Police', 5600000),
                           (4042, 'Philip Morris International', 13873900),
                           (4043, 'Rauch', 97655980),
                           (4044, 'UPS', 37000000),
                           (4045, 'Dupont', 19050000),
                           (4046, 'Marlboro', 160753100),
                           (4047, 'Martini', 75000000),
                           (4048, 'Rexona', 80000000),
                           (4049, 'NOVA Chemicals', 93000000),
                           (4050, 'TAGHeuer', 60000000);


-- STAZE // SVE OD 2012 DO 2022 // NEKE SU SE MJENJALE KROZ GODINE ALI "FOR SAKE OF BREVITY" NECEMO IH UBACIVATI KAO ODVOJENE STAZE.
INSERT INTO staza VALUES  (1001, 'Bahrain International Circuit 2005-2022', 'Sakhir, Bahrain', 5412, 3),
                          -- (1002, 'Jeddah Corniche Circuit', 'Jeddah, Saudi Arabia', 6174, 3),
                          (1003, 'Albert Park Circuit', 'Melbourne, Australia', 5278, 3),
                          -- (1004, 'Autodromo Enzo e Dino Ferrari 2008-2022', 'Imola, San Marino', 4909, 1),
                          -- (1005, 'Miami International Autodrome', 'Miami, USA', 5412, 3),
                          (1006, 'Circuit de Barcelona-Catalunya 2021-2022', 'Montmeló, Spain', 4675, 2),
                          (1007, 'Circuit de Monte Carlo 2015-2022', 'Monte Carlo, Monaco', 3337, 1),
                          (1008, 'Baku City Circuit', 'Baku, Azerbaijan', 6003, 2),
                          (1009, 'Circuit Gilles-Villeneuve', 'Montreal, Canada', 4361, 2),
                          (1010, 'Silverstone Circuit', 'Silverstone, UK', 5891, 2),
                          (1011, 'Red Bull Ring', 'Spielberg, Austria', 4318, 2),
                          (1012, 'Circuit Paul Ricard', 'Le Castellet, France', 5842, 2),
                          (1013, 'Hungaroring', 'Mogyoród, Hungary', 4381, 1),
                          (1014, 'Circuit Spa-Francorchamps', 'Stavelot, Belgium', 7004, 2),
                          -- (1015, 'Circuit Zandvoort', 'Zandvoort, Netherlands', 4259, 2),
                          (1016, 'Autodromo Nazionale Monza', 'Monza, Italy', 5793, 2),
                          (1017, 'Sochi Autodrom', 'Sochi, Russia', 5848, 2),
                          (1018, 'Marina Bay Circuit', 'Marina Bay, Singapore', 5063, 3),
                          (1019, 'Suzuka Circuit', 'Suzuka, Japan', 5807, 1),
                          (1020, 'Circuit of the Americas', 'Austin, USA', 5514, 2),
                          (1021, 'Autódromo Hermanos Rodríguez', 'Mexico City, Mexico', 4304, 1),
                          (1022, 'Autódromo José Carlos Pace', 'São Paulo, Brazil', 4309, 2),
                          (1023, 'Yas Marina Circuit', 'Yas Island', 5281, 2),
                          (1023, 'Autodromo do Algarve 2008-2022', 'Portimão, Portugal', 4653, 2),
                          -- (1024, 'Istanbul Park 2005-2022', 'Istanbul, Turkey', 5338, 2),
                          (1025, 'Losail International Circuit 2004-2022', 'Lusail, Qatar', 5380, 1),
                          -- (1026, 'Mugello 1974-2022', 'Scarperia e San Piero, Italy', 5245, 1),
                          (1027, 'Nürburgring 2002-2022', 'Nürburg, Germany', 5148, 2),
                          -- (1028, 'Bahrain International Circuit (OUTER)', 'Sakhir, Bahrain', 3543, 2),
                          (1029, 'Hockenheimring 2002-2022', 'Hockenheim, Germany', 4574, 2),
                          (1030, 'Shanghai International Circuit 2004-2022', 'Shanghai, China', 5451, 2),
                          (1031, 'Sepang International Circuit 1999-2022', 'Sepang, Malaysia', 5543, 2),
                          (1032, 'Korean International Circuit 2010-2022', 'Yeongam, South Korea', 5615, 2),
                          (1033, 'Buddh International Circuit 2011-2022', 'Greater Noida, India', 5125, 2),
                          (1034, 'Valencia Street Circuit 2008-2012', 'Valencia, Spain', 5419, 2);


INSERT INTO kvalifikacija  VALUES (id_kvalifikacija, sesija_kvalifikacije, krugova_vozeno, izlazaka_na_stazu, datum);
INSERT INTO trening  VALUES (id_trening, odvozeno_krugova, najbrzi_krug, izlazaka_na_stazu, datum);


-- UTRKE
INSERT INTO utrka  VALUES -- // GODINA: 2012 \\
                          (3001, '2012 Australia GP', pobjednik, 58, 01:34:09.565, 00:01:29.187, 2012-03-18),
                          (3002, '2012 Malaysia GP', pobjednik, 56, 02:44:51.812, 00:01:41.680, 2012-03-25),
                          (3003, '2012 China GP', pobjednik, 56, 01:36:26.929, 00:01:40.967, 2012-04-15),
                          (3004, '2012 Bahrain GP', pobjednik, 57, 01:35:10.990, 00:01:36.379, 2012-04-22),
                          (3005, '2012 Spain GP', pobjednik, 66, 01:39:09.145, 00:01:27.906, 2012-05-13),
                          (3006, '2012 Monaco GP', pobjednik, 78, 01:46:06.557, 00:01:18.805, 2012-05-27),
                          (3007, '2012 Canada GP', pobjednik, 70, 01:32:29.586, 00:01:15.752, 2012-06-10),
                          (3008, '2012 Europe GP', pobjednik, 57, 01:44:16.649, 00:01:42.163, 2012-06-24),
                          (3009, '2012 Great Britain GP', pobjednik, 52, 01:25:11.288, 00:01:34.934, 2012-07-08),
                          (3010, '2012 Germany GP', pobjednik, 67, 01:31:05.682, 00:01:19.044, 2012-07-22),
                          (3011, '2012 Hungary GP', pobjednik, 69, 01:41:05.503, 00:01:24.136, 2012-07-29),
                          (3012, '2012 Belgium GP', pobjednik, 44, 01:29:08.530, 00:01:52.822, 2012-09-02),
                          (3013, '2012 Italy GP', pobjednik, 53, 01:19:41.221, 00:01:27.239, 2012-09-09),
                          (3014, '2012 Singapore GP', pobjednik, 59, 02:00:26.144, 00:01:51.033, 2012-09-23),
                          (3015, '2012 Japan GP', pobjednik, 53, 01:28:56.242, 00:01:35.774, 2012-10-07),
                          (3016, '2012 Korea GP', pobjednik, 55, 01:36:28.651, 00:01:42.037, 2012-10-14),
                          (3017, '2012 India GP', pobjednik, 60, 01:31:10.77, 00:01:28.203, 2012-10-28),
                          (3018, '2012 Abu Dhabi GP', pobjednik, 55, 01:45:58.667, 00:01:43.964, 2012-11-04),
                          (3019, '2012 United States GP', pobjednik, 56, 01:35:55.269, 00:01:39.347, 2012-11-18),
                          (3020, '2012 Brazil GP', pobjednik, 71, 01:45:22.656, 00:01:18.069, 2012-11-25),

--                         // GODINA: 2013 \\
                          (3101, '2013 Australia GP', pobjednik, 58, 01:30:03.225, 00:01:29.274, 2013-03-17),
                          (3102, '2013 Malaysia GP', pobjednik, 56, 01:38:56.681, 00:01:39.199, 2013-03-24),
                          (3103, '2013 China GP', pobjednik, 56, 01:36:26.945, 00:01:36.808, 2013-04-14),
                          (3104, '2013 Bahrain GP', pobjednik, 57, 01:36:00.498, 00:01:36.961, 2013-04-21),
                          (3105, '2013 Spain GP', pobjednik, 66, 01:39:16.596, 00:01:26.217, 2013-05-12),
                          (3106, '2013 Monaco GP', pobjednik, 78, 02:17:52.056, 00:01:18.133, 2013-05-26),
                          (3107, '2013 Canada GP', pobjednik, 70, 01:32:09.143, 00:01:16.182, 2013-06-09),
                          (3108, '2013 Great Britain GP', pobjednik, 52, 01:32:59.456, 00:01:33.401, 2013-06-30),
                          (3109, '2013 Germany GP', pobjednik, 60, 01:41:14.711, 00:01:33.468, 2013-07-07),
                          (3110, '2013 Hungary GP', pobjednik, 70, 01:42:29.445, 00:01:24.069, 2013-07-28),
                          (3111, '2013 Belgium GP', pobjednik, 44, 01:23:42.196, 00:01:50.756, 2013-08-25),
                          (3112, '2013 Italy GP', pobjednik, 53, 01:18:33.352, 00:01:25.849, 2013-09-08),
                          (3113, '2013 Singapore GP', pobjednik, 61, 01:59:13.132, 00:01:48.574, 2013-09-22),
                          (3114, '2013 Korea GP', pobjednik, 55, 01:43:13.701, 00:01:41.380, 2013-10-06),
                          (3115, '2013 Japan GP', pobjednik, 53, 01:26:49.301, 00:01:34.587, 2013-10-13),
                          (3116, '2013 India GP', pobjednik, 60, 01:31:12.187, 00:01:27:679, 2013-10-27),
                          (3117, '2013 Abu Dhabi GP', pobjednik, 55, 01:38:06.106, 00:01:43:434, 2013-11-03),
                          (3118, '2013 United States GP', pobjednik, 56, 01:39:17.148, 00:01:39.856, 2013-11-17),
                          (3119, '2013 Brazil GP', pobjednik, 71, 01:32:26.300, 00:01:15.436, 2013-11-24),

--                         // GODINA: 2014 \\
                          (3200, '2014 Australia GP', pobjednik, 57, 01:32:58.710, 00:01:32.478, 2014-03-16),
                          (3201, '2014 Malaysia GP', pobjednik, 56, 01:40:25.974, 00:01:43.066, 2014-03-30),
                          (3202, '2014 Bahrain GP', pobjednik, 57, 01:39:42.743, 00:01:37.020, 2014-04-06),
                          (3203, '2014 China GP', pobjednik, 54, 01:33:28.338, 00:01:40.402, 2014-04-20),
                          (3204, '2014 Spain GP', pobjednik, 66, 01:41:05.155, 00:01:28.198, 2014-05-11),
                          (3205, '2014 Monaco GP', pobjednik, 78, 01:49:27.661, 00:01:18.479, 2014-05-25),
                          (3206, '2014 Canada GP', pobjednik, 70, 01:39:12.830, 00:01:18.504, 2014-06-08),
                          (3207, '2014 Austria GP', pobjednik, 71, 01:27:54.976, 00:01:12.142, 2014-06-22),
                          (3208, '2014 Great Britain GP', pobjednik, 52, 02:26:52.094, 00:01:37.176, 2014-07-06),
                          (3209, '2014 Germany GP', pobjednik, 67, 01:33:42.914, 00:01:19.908, 2014-07-20),
                          (3210, '2014 Hungary GP', pobjednik, 70, 01:53:05.058, 00:01:25.724, 2014-07-27),
                          (3211, '2014 Belgium GP', pobjednik, 44, 01:24:36.556, 00:01:50.511, 2014-08-24),
                          (3212, '2014 Italy GP', pobjednik, 53, 01:19:10.236, 00:01:28.004, 2014-09-07),
                          (3213, '2014 Singapore GP', pobjednik, 60, 02:00:04.795, 00:01:50.417, 2014-09-21),
                          (3214, '2014 Japan GP', pobjednik, 44, 01:51:43.021, 00:01:51.600, 2014-10-05),
                          (3215, '2014 Russia GP', pobjednik, 53, 01:31:50.744, 00:01:40.896, 2014-10-12),
                          (3216, '2014 United States GP', pobjednik, 56, 01:40:04.785, 00:01:41.379, 2014-11-02),
                          (3217, '2014 Brazil GP', pobjednik, 71, 01:30:02.555, 00:01:13.555, 2014-11-09),
                          (3218, '2014 Abu Dhabi GP', POBJEDNIK, 55, 01:39:02.619, 00:01:44.496, 2014-11-23),

--                         // GODINA: 2015 \\
                          (3300, '2015 Australia GP', pobjednik, 58, 01:31:54.067, 00:01:30.945, 2015-03-15),
                          (3301, '2015 Malaysia GP', pobjednik, 56, 01:41:05.793, 00:01:42.062, 2015-03-29),
                          (3302, '2015 China GP', pobjednik, 56, 01:39:42.008, 00:01:42.208, 2015-04-12),
                          (3303, '2015 Bahrain GP', pobjednik, 57, 01:35:05.809, 00:01:36.311, 2015-04-19),
                          (3304, '2015 Spain GP', pobjednik, 66, 01:41:12.555, 00:01:28.270, 2015-05-10),
                          (3305, '2015 Monaco GP', pobjednik, 78, 01:49:18.420, 00:01:18.063, 2015-05-24),
                          (3306, '2015 Canada GP', pobjednik, 70, 01:31:53.145, 00:01:16.987, 2015-06-07),
                          (3307, '2015 Austria GP', pobjednik, 71, 01:30:16.930, 00:01:11.235, 2015-06-21),
                          (3308, '2015 Great Britain GP', pobjednik, 52, 01:31:27.729, 00:01:37.093, 2015-07-05),
                          (3309, '2015 Hungary GP', pobjednik, 69, 01:46:09.985, 00:01:24.821, 2015-07-26),
                          (3310, '2015 Belgium GP', pobjednik, 43, 01:23:40.387, 00:01:52.416, 2015-08-23),
                          (3311, '2015 Italy GP', pobjednik, 53, 01:18:00.688, 00:01:26.672, 2015-09-06),
                          (3312, '2015 Singapore GP', pobjednik, 61, 02:01:22.118, 00:01:50.041, 2015-09-20),
                          (3313, '2015 Japan GP', pobjednik, 53, 01:28:06.508, 00:01:36.145, 2015-09-27),
                          (3314, '2015 Russia GP', pobjednik, 53, 01:37:11.024, 00:01:40.071, 2015-10-11),
                          (3315, '2015 United States GP', pobjednik, 56, 01:50:52.703, 00:01:40.666, 2015-10-25),
                          (3316, '2015 Mexico GP', pobjednik, 71, 01:42:35.038, 00:01:20.521, 2015-11-01),
                          (3317, '2015 Brazil GP', pobjednik, 71, 01:31:09.090, 00:01:14.832, 2015-11-15),
                          (3318, '2015 Abu Dhabi GP', pobjednik, 55, 01:38:30.175, 00:01:45.356, 2015-11-29);

--                         // GODINA: 2016 \\
                          (3400, '2016 Australia GP', pobjednik, 57, 1:48:15.565, 00:01:30.557, 2016-03-20),
                          (3401, '2016 Bahrain GP', pobjednik, 57, 1:33:34.696, 00:01:34.158, 2016-04-03),
                          (3402, '2016 China GP', pobjednik, 56, 1:38:53.891, 00:01:35.402, 2016-04-17),
                          (3403, '2016 Russia GP', pobjednik, 56, 1:32:53.891, 00:01:41.997, 2016-05-01),
                          (3404, '2016 Spain GP', pobjednik, , , , 2016-05-15),
                          (3405, '2016 Monaco GP', pobjednik, , , , 2016-05-29),
                          (3406, '2016 Canada GP', pobjednik, , , , 2016-06-12),
                          (3407, '2016 Europe GP', pobjednik, , , , 2016-06-19),
                          (3408, '2016 Austria GP', pobjednik, , , , 2016-07-03),
                          (3409, '2016 Great Britain GP', pobjednik, , , , 2016-07-10),
                          (3410, '2016 Hungary GP', pobjednik, , , , 2016-07-10),
                          (3411, '2016 Germany GP', pobjednik, , , , 2016-07-24),
                          (3412, '2016 Belgium GP', pobjednik, , , , 2016-07-31),
                          (3413, '2016 Italy GP', pobjednik, , , , 2016-08-28),
                          (3414, '2016 Singapore GP', pobjednik, , , , 2016-09-04),
                          (3415, '2016 Malaysia GP', pobjednik, , , , 2016-09-18)
                          (3416, '2016 Japan GP', pobjednik, , , , 2016-10-09),
                          (3417, '2016 United States GP', pobjednik, , , , 2016-10-23),
                          (3418, '2016 Mexico GP', pobjednik, , , , 2016-10-30),
                          (3419, '2016 Brasil GP', pobjednik, , , , 2016-11-13),
                          (3420, '2016 Abu Dhabi GP', pobjednik, , , , 2016-11-27),


-- SEZONE // 
INSERT INTO sezona  VALUES (id, prvak);
                           (2012, ),
                           (2013, ),
                           (2014, ),
                           (2015, ),
                           (2016, ),