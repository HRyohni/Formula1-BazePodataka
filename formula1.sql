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
   datum_rodenja DATE NOT NULL, -- fixat datum
   nacionalnost VARCHAR(30) NOT NULL,
   osvojeno_naslova_prvaka INTEGER NOT NULL,
   osvojeno_podija CHAR(5) NOT NULL,
   osvojeno_bodova CHAR(5) NOT NULL,
   odvozeno_najbrzih_krugova INTEGER NOT NULL,

   FOREIGN KEY (id_tim) REFERENCES tim(id_tim)
);

CREATE TABLE vozac_u_timu(
   id_vozac_u_timu INTEGER PRIMARY KEY,
   id_vozac FOREIGN KEY,
   id_tim FOREIGN KEY,
   godina INTEGER NOT NULL
);

CREATE TABLE automobil(
   id_auto INTEGER PRIMARY KEY,
   naziv_auto VARCHAR(30) NOT NULL,
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
   datum DATE -- fixat datum
);

CREATE TABLE trening(
   id_trening INTEGER PRIMARY KEY,
   odvozeno_krugova CHAR(5) NOT NULL,
   najbrzi_krug CHAR(5) NOT NULL,
   izlazaka_na_stazu CHAR(5) NOT NULL,
   datum DATE NOT NULL -- datum fixat
);

CREATE TABLE utrka(
   id_utrka INTEGER PRIMARY KEY,
   ime_nagrade VARCHAR(30),
   pobjednik INTEGER,
   broj_krugova INTEGER NOT NULL,
   vrijeme_vozeno TIME NOT NULL, -- fixat
   najbrzi_krug TIME NOT NULL,
   datum DATE NOT NULL, -- fixat
   FOREIGN KEY (pobjednik) REFERENCES vozac(id_vozac)
);

CREATE TABLE sezona(
   id_sezona INTEGER PRIMARY KEY,
   godina INTEGER
);

CREATE TABLE prvak(
   id_vozac_u_timu FOREIGN KEY, -- Vozač za tim
   id_tim FOREIGN KEY -- Konstruktor
   id_sezona FOREIGN KEY
);

CREATE TABLE vikend(
   id_vikend INTEGER PRIMARY KEY,
   id_trening FOREIGN KEY,
   id_quali FOREIGN KEY,
   id_utrka FOREIGN KEY,
);


-- PROMJENE I OGRANIČENJA NA TABLICAMA
ALTER TABLE staza
	ADD CONSTRAINT id_len_ck_staza CHECK (length(id_staza) = 4),
   ADD CONSTRAINT id_rng_ck_staza CHECK (id_staza >= 1000 AND id_staza <= 1999),
   ADD CONSTRAINT duzina_rng_ck_staza CHECK (duzina_m >= 1000 AND duzina_m <= 99999);
   
ALTER TABLE tim
	ADD CONSTRAINT id_len_ck_tim CHECK (length(id_tim) = 3),
   ADD CONSTRAINT id_rng_ck_tim CHECK (id_tim >= 100 AND id_tim <= 999);

ALTER TABLE sponzor
   ADD CONSTRAINT id_len_ck_sponzor CHECK (length(id_sponzor) = 4),
   ADD CONSTRAINT id_rng_ck_sponzor CHECK (id_sponzor >= 4000 AND id_sponzor <= 4999),
   ADD CONSTRAINT payout_ck_sponzor CHECK (isplacen_novac >= 500000);

ALTER TABLE utrka
   ADD CONSTRAINT id_len_ck_utrka CHECK (length(id_utrka) = 4),
   ADD CONSTRAINT id_rng_ck_utrka CHECK (id_utrka >= 3000 AND id_utrka <= 3499);

ALTER TABLE vikend
   ADD CONSTRAINT id_len_ck_vikend CHECK (length(id_vikend) BETWEEN 1 AND 2),
   ADD CONSTRAINT id_rng_ck_vikend CHECK (id_vikend >= 1 AND id_vikend <= 99);

ALTER TABLE automobil
   ADD CONSTRAINT id_len_ck_automobil CHECK (length(id_auto) = 4),
   ADD CONSTRAINT id_rng_ck_automobil CHECK (id_auto >= 9000 AND id_auto <= 9999);


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
                        (114, 'Haas F1 Team', 'Günther Steiner', 0, 0, 'Banbury, Oxfordshire, Velika Britanija', 'VF-22', 122);
                        (115, 'Manor Racing MRT', 'Dave Ryan', 0, 0, 'Banbury, Oxfordshire, Velika Britanija', 'MRT05', 21),
                        (116, 'Marussia F1 Team', 'John Booth', 0, 0, 'Banbury, Oxfordshire, Velika Britanija', 'MR03B', 74),
                        (117, 'HRT Formula 1 Team', 'Colin Kolles', 0, 0, 'Madrid, Španjolska', 'F112', 56),
                        (118, 'Caterham F1 Team', 'Tony Fernandes', 0, 0, 'Leafield, Oxfordshire, Velika Britanija', 'Caterham CT5', 94),
                        (119, 'Lotus F1 Team', 'Gérard Lopez', 2, 25, 'Enstone, Oxfordshire, Velika Britanija', 'E23', 77);


INSERT INTO vozac VALUES   (id_vozac, id_auto, ime, prezime, odabrani_broj, datum_rodenja, nacionalnost, osvojeno_naslova_prvaka, osvojeno_podija, osvojeno_bodova, odvozeno_najbrzih_krugova)
--                         // 2015 \\
                           (id, id_tim,   id_auto,  'Roberto', 'Merhi', 98,  '22.3.1991.', 'španjolsko', 0, 0, 0, 0),
                           (id, id_tim,   id_auto,  'Nico', 'Rosberg', 6,  '27.6.1985.', 'njemačko', 1, 57, 1594.5, 20),
                           (id, id_tim,   id_auto,  'Felipe', 'Nasr', 12,  '21.8.1992.', 'brazilsko', 0, 0, 29, 0),
                           (id, id_tim,   id_auto,  'Pastor', 'Maldonado', 13,  '9.3.1985.', 'venecuelanski', 0, 1, 76, 0),
                           (id, id_tim,   id_auto,  'Alexander', 'Rossi', 53,  '25.9.1991.', 'američko', 0, 2, 81, 0),
                           (id, id_tim,   id_auto,  'Will', 'Stevens', 28,  '28.6.1991.', 'britansko', 0, 0, 0, 0),
                           
--                         // 2014 \\
                           (id, id_tim,   id_auto,  'Jean-Eric', 'Vergne', 25,  '25.4.1990.',' francukso', 0, 0, 51, 0),
                           (id, id_tim,   id_auto,  'Pastor', 'Maldonado', 13,  '9.3.1985.','venecuelanski', 0, 1, 76, 0),
                           (id, id_tim,   id_auto,  'Romain', 'Grosjean', 8,  '17.4.1986.',' francusko', 0, 10, 391, 1),
                           (id, id_tim,   id_auto,  'Jules', 'Bianchi', 17,  '3.8.1989.',' francusko', 0, 0, 2, 0),
                           (id, id_tim,   id_auto,  'Adrian', 'Sutil', 99,  '11.1.1983.',' njemčko', 0, 0, 124, 1),
                           (id, id_tim,   id_auto,  'Max', 'Chilton', 4,  '21.4.1991.',' britansko', 0, 0, 0, 0),
                           (id, id_tim,   id_auto,  'Kamui', 'Kobayashi', 10,  '13.9.1986.',' japansko', 0, 1, 125, 1),
                           (id, id_tim,   id_auto,  'Will', 'Stevens', 28,  '28.6.1991.',' britansko', 0, 0, 0, 0),
                           
--                         // 2013 \\
                           (id, id_tim,   id_auto,  'Mark', 'Webber', 17,'27.8.1976.','australsko', 0, 42, 1047.5, 19),
                           (id, id_tim,   id_auto,  'Nico', 'Rosberg', 6,  '27.6.1985.','njemačko', 1, 30, 1594.5, 20),
                           (id, id_tim,   id_auto,  'Felipe', 'Massa', 19,  '25.4.1981.','brazilsko', 0, 41, 1167, 15),
                           (id, id_tim,   id_auto,  'Jenson', 'Button', 22,  '19.1.1980.','britansko', 1, 50, 1235, 8),
                           (id, id_tim,   id_auto,  'Nico', 'Hulkenberg', 27,  '19.8.1987.','njemačko', 0, 0, 521, 2),
                           (id, id_tim,   id_auto,  'Paul', 'di Resta', 40,  '16.4.1986.','britansko', 0, 0, 121, 0),
                           (id, id_tim,   id_auto,  'Jean-Eric', 'Vergne', 25,  '25.4.1990.','francusko', 0, 0, 51, 0),
                           (id, id_tim,   id_auto,  'Jules', 'Bianchi', 17,  '3.8.1989.','francusko', 0, 0, 2, 0),
                           (id, id_tim,   id_auto,  'Charles', 'Pic', 99,  '15.2.1990.','francusko', 0, 0, 0, 0),
                           (id, id_tim,   id_auto,  'Heikki', 'Kovalainen', 23,  '19.10.1981.',' finsko', 0, 4, 105, 2),
                           (id, id_tim,   id_auto,  'Giedo', 'van der Garde', odabrani_broj,  '25.4.1985.',' nizozemsko', 0, 0, 0, 0);
   

INSERT INTO automobil VALUES (id_auto, naziv_auto, vrsta_motora, proizvodac_guma);
--                            // GODINA: 2013 \\
                             (9024, 'Ferrari F138 n.1', '2.4L NA V8', 'Pirelli'),
                             (9025, 'Ferrari F138 n.2', '2.4L NA V8', 'Pirelli'),
                             (9026, 'Red Bull RB9 n.1', '2.4L NA V8', 'Pirelli'),
                             (9027, 'Red Bull RB9 n.2', '2.4L NA V8', 'Pirelli'),
                             (9028, 'McLaren MP4-28 n.1', '2.4L NA V8', 'Pirelli'),
                             (9029, 'McLaren MP4-28 n.2', '2.4L NA V8', 'Pirelli'),
                             (9030, 'Williams FW35 n.1', '2.4L NA V8', 'Pirelli'),
                             (9031, 'Williams FW35 n.2', '2.4L NA V8', 'Pirelli'),
                             (9032, 'Sauber C32 n.1', '2.4L NA V8', 'Pirelli'),
                             (9033, 'Sauber C32 n.2', '2.4L NA V8', 'Pirelli'),
                             (9034, 'Toro Rosso STR8 n.1', '2.4L NA V8', 'Pirelli'),
                             (9035, 'Toro Rosso STR8 n.2', '2.4L NA V8', 'Pirelli'),
                             (9036, 'Caterham CT03 n.1', '2.4L NA V8', 'Pirelli'),
                             (9037, 'Caterham CT03 n.2', '2.4L NA V8', 'Pirelli'),
                             (9038, 'Lotus E21 n.1', '2.4L NA V8', 'Pirelli'),
                             (9039, 'Lotus E21 n.2', '2.4L NA V8', 'Pirelli'),
                             (9040, 'Marussia MR02 n.1', '2.4L NA V8', 'Pirelli'),
                             (9041, 'Marussia MR02 n.2', '2.4L NA V8', 'Pirelli'),
                             (9042, 'Mercedes W04 n.1', '2.4L NA V8', 'Pirelli'),
                             (9043, 'Mercedes W04 n.2', '2.4L NA V8', 'Pirelli'),
                             (9044, 'Force India VJM06 n.1', '2.4L NA V8', 'Pirelli'),
                             (9045, 'Force India VJM06 n.2', '2.4L NA V8', 'Pirelli'),


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
                           -- Potrebno počistit višak sponzora (novijih od 2015)


-- STAZE // SVE OD 2012 DO 2022 // NEKE SU SE MJENJALE KROZ GODINE ALI "FOR SAKE OF BREVITY" NECEMO IH UBACIVATI KAO ODVOJENE STAZE.
INSERT INTO staza VALUES  (1001, 'Bahrain International Circuit', 'Sakhir, Bahrain', 5412, 3),
                          (1003, 'Albert Park Circuit', 'Melbourne, Australia', 5278, 3),
                          (1006, 'Circuit de Barcelona-Catalunya 2021-2022', 'Montmeló, Spain', 4675, 2),
                          (1007, 'Circuit de Monte Carlo', 'Monte Carlo, Monaco', 3337, 1),
                          (1008, 'Baku City Circuit', 'Baku, Azerbaijan', 6003, 2),
                          (1009, 'Circuit Gilles-Villeneuve', 'Montreal, Canada', 4361, 2),
                          (1010, 'Silverstone Circuit', 'Silverstone, UK', 5891, 2),
                          (1011, 'Red Bull Ring', 'Spielberg, Austria', 4318, 2),
                          (1012, 'Circuit Paul Ricard', 'Le Castellet, France', 5842, 2),
                          (1013, 'Hungaroring', 'Mogyoród, Hungary', 4381, 1),
                          (1014, 'Circuit Spa-Francorchamps', 'Stavelot, Belgium', 7004, 2),
                          (1016, 'Autodromo Nazionale Monza', 'Monza, Italy', 5793, 2),
                          (1017, 'Sochi Autodrom', 'Sochi, Russia', 5848, 2),
                          (1018, 'Marina Bay Circuit', 'Marina Bay, Singapore', 5063, 3),
                          (1019, 'Suzuka Circuit', 'Suzuka, Japan', 5807, 1),
                          (1020, 'Circuit of the Americas', 'Austin, USA', 5514, 2),
                          (1021, 'Autódromo Hermanos Rodríguez', 'Mexico City, Mexico', 4304, 1),
                          (1022, 'Autódromo José Carlos Pace', 'São Paulo, Brazil', 4309, 2),
                          (1023, 'Yas Marina Circuit', 'Yas Island', 5281, 2),
                          (1023, 'Autodromo do Algarve', 'Portimão, Portugal', 4653, 2),
                          (1025, 'Losail International Circuit', 'Lusail, Qatar', 5380, 1),
                          (1027, 'Nürburgring', 'Nürburg, Germany', 5148, 2),
                          (1029, 'Hockenheimring', 'Hockenheim, Germany', 4574, 2),
                          (1030, 'Shanghai International Circuit', 'Shanghai, China', 5451, 2),
                          (1031, 'Sepang International Circuit', 'Sepang, Malaysia', 5543, 2),
                          (1032, 'Korean International Circuit', 'Yeongam, South Korea', 5615, 2),
                          (1033, 'Buddh International Circuit', 'Greater Noida, India', 5125, 2),
                          (1034, 'Valencia Street Circuit', 'Valencia, Spain', 5419, 2);
                          -- Izbrisane ugašene staze i datumi promjena staza


INSERT INTO kvalifikacija  VALUES (id_kvalifikacija, krugova_vozeno, izlazaka_na_stazu, datum);
INSERT INTO trening  VALUES (id_trening, odvozeno_krugova, najbrzi_krug, izlazaka_na_stazu, datum);


-- UTRKE
INSERT INTO utrka  VALUES
--                         // GODINA: 2013 \\
                          (3101, '2013 Australia GP', pobjednik, 58, 01:30:03.225, 00:01:29.274, 2013-03-17),
                          (3102, '2013 Malaysia GP', pobjednik, 56, 01:38:56.681, 00:01:39.199, 2013-03-24),
                          (3103, '2013 China GP', pobjednik, 56, 01:36:26.945, 00:01:36.808, 2013-04-14),
                          (3104, '2013 Bahrain GP', pobjednik, 57, 01:36:00.498, 00:01:36.961, 2013-04-21),
                          (3106, '2013 Monaco GP', pobjednik, 78, 02:17:52.056, 00:01:18.133, 2013-05-26),
                          (3107, '2013 Canada GP', pobjednik, 70, 01:32:09.143, 00:01:16.182, 2013-06-09),
                          (3108, '2013 Great Britain GP', pobjednik, 52, 01:32:59.456, 00:01:33.401, 2013-06-30),
                          (3109, '2013 Germany GP', pobjednik, 60, 01:41:14.711, 00:01:33.468, 2013-07-07),
                          (3113, '2013 Singapore GP', pobjednik, 61, 01:59:13.132, 00:01:48.574, 2013-09-22),
                          (3115, '2013 Japan GP', pobjednik, 53, 01:26:49.301, 00:01:34.587, 2013-10-13),
                          (3116, '2013 India GP', pobjednik, 60, 01:31:12.187, 00:01:27:679, 2013-10-27),
                          (3117, '2013 Abu Dhabi GP', pobjednik, 55, 01:38:06.106, 00:01:43:434, 2013-11-03),
                          (3119, '2013 Brazil GP', pobjednik, 71, 01:32:26.300, 00:01:15.436, 2013-11-24),

--                         // GODINA: 2014 \\
                          (3200, '2014 Australia GP', pobjednik, 57, 01:32:58.710, 00:01:32.478, 2014-03-16),
                          (3201, '2014 Bahrain GP', pobjednik, 57, 01:39:42.743, 00:01:37.020, 2014-04-06),
                          (3202, '2014 China GP', pobjednik, 54, 01:33:28.338, 00:01:40.402, 2014-04-20),
                          (3203, '2014 Monaco GP', pobjednik, 78, 01:49:27.661, 00:01:18.479, 2014-05-25),
                          (3204, '2014 Austria GP', pobjednik, 71, 01:27:54.976, 00:01:12.142, 2014-06-22),
                          (3205, '2014 Germany GP', pobjednik, 67, 01:33:42.914, 00:01:19.908, 2014-07-20),
                          (3206, '2014 Belgium GP', pobjednik, 44, 01:24:36.556, 00:01:50.511, 2014-08-24),
                          (3207, '2014 Italy GP', pobjednik, 53, 01:19:10.236, 00:01:28.004, 2014-09-07),
                          (3208, '2014 Singapore GP', pobjednik, 60, 02:00:04.795, 00:01:50.417, 2014-09-21),
                          (3209, '2014 Abu Dhabi GP', POBJEDNIK, 55, 01:39:02.619, 00:01:44.496, 2014-11-23),

--                         // GODINA: 2015 \\
                          (3300, '2015 Australia GP', pobjednik, 58, 01:31:54.067, 00:01:30.945, 2015-03-15),
                          (3301, '2015 Monaco GP', pobjednik, 78, 01:49:18.420, 00:01:18.063, 2015-05-24),
                          (3302, '2015 Canada GP', pobjednik, 70, 01:31:53.145, 00:01:16.987, 2015-06-07),
                          (3303, '2015 Great Britain GP', pobjednik, 52, 01:31:27.729, 00:01:37.093, 2015-07-05),
                          (3304, '2015 Belgium GP', pobjednik, 43, 01:23:40.387, 00:01:52.416, 2015-08-23),
                          (3305, '2015 Italy GP', pobjednik, 53, 01:18:00.688, 00:01:26.672, 2015-09-06),
                          (3306, '2015 Singapore GP', pobjednik, 61, 02:01:22.118, 00:01:50.041, 2015-09-20),
                          (3307, '2015 Japan GP', pobjednik, 53, 01:28:06.508, 00:01:36.145, 2015-09-27),
                          (3308, '2015 Brazil GP', pobjednik, 71, 01:31:09.090, 00:01:14.832, 2015-11-15),
                          (3309, '2015 Abu Dhabi GP', pobjednik, 55, 01:38:30.175, 00:01:45.356, 2015-11-29);
                          -- Smanjena količina utrka


-- SEZONE // 
INSERT INTO sezona VALUES (id_sezona, godina);
                          (2013, 2013),
                          (2014, 2014),
                          (2015, 2015);