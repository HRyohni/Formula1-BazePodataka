DROP DATABASE IF EXISTS Formula1;

CREATE DATABASE Formula1;
USE Formula1;

CREATE TABLE tim(
   id INTEGER PRIMARY KEY,
   naziv VARCHAR(50),
   voditelj VARCHAR(50),
   pobjede CHAR(5) NOT NULL,
   osvojeno_podija CHAR(5) NOT NULL,
   sjediste VARCHAR(50) NOT NULL,
   kod_sasija VARCHAR(30) NOT NULL,
   kolicina_utrka CHAR(5)
);

CREATE TABLE vozac(
   id INTEGER PRIMARY KEY,
   ime VARCHAR(30) NOT NULL,
   prezime VARCHAR(30) NOT NULL,
   datum_rodenja DATE NOT NULL,
   nacionalnost VARCHAR(30) NOT NULL
);

CREATE TABLE vozac_u_sezoni(
   id INTEGER PRIMARY KEY,
   id_vozac INTEGER,
   id_tim INTEGER,
   id_auto INTEGER,
   id_sezona INTEGER,
   osvojeno_naslova_prvaka INTEGER NOT NULL,
   osvojeno_podija CHAR(5) NOT NULL,
   osvojeno_bodova CHAR(5) NOT NULL,
   odvozeno_najbrzih_krugova INTEGER NOT NULL,
   FOREIGN KEY (id_tim) REFERENCES tim(id),
   FOREIGN KEY (id_vozac) REFERENCES vozac(id),
   FOREIGN KEY (id_auto) REFERENCES automobil(id),
   FOREIGN KEY (id_sezona) REFERENCES sezona(id)
);

CREATE TABLE automobil(
   id INTEGER PRIMARY KEY,
   naziv_auto VARCHAR(30) NOT NULL,
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
   ime_staze VARCHAR(50) NOT NULL,
   drzava VARCHAR(30) NOT NULL,
   duzina_m INTEGER NOT NULL,
   broj_drs_zona INTEGER NOT NULL
);

CREATE TABLE kvalifikacija(
   id INTEGER PRIMARY KEY,
   krugova_vozeno CHAR(5) NOT NULL,
   izlazaka_na_stazu CHAR(5) NOT NULL
);

CREATE TABLE trening(
   id INTEGER PRIMARY KEY,
   id_vrijeme INTEGER,
   odvozeno_krugova CHAR(5) NOT NULL,
   najbrzi_krug CHAR(5) NOT NULL,
   izlazaka_na_stazu CHAR(5) NOT NULL,
   FOREIGN KEY (id_vrijeme) REFERENCES vrijeme(id)
);

CREATE TABLE utrka(
   id INTEGER PRIMARY KEY,
   ime_nagrade VARCHAR(30),
   pobjednik INTEGER,
   broj_krugova INTEGER NOT NULL,
   vrijeme_vozeno TIME NOT NULL,
   najbrzi_krug TIME NOT NULL,
   id_vrijeme INTEGER,
   FOREIGN KEY (pobjednik) REFERENCES vozac(id_vozac),
   FOREIGN KEY (id_vrijeme) REFERENCES vrijeme(id)
);

CREATE TABLE sezona(
   id INTEGER PRIMARY KEY,
   godina INTEGER
);

CREATE TABLE prvak(
   id INTEGER PRIMARY KEY,
   id_vozac_u_timu INTEGER, -- Vozač za tim
   id_tim INTEGER, -- Konstruktor
   id_sezona INTEGER
   FOREIGN KEY (id_vozac_u_sezoni) REFERENCES vozac_u_sezoni(id),
   FOREIGN KEY (id_tim) REFERENCES tim(id),
   FOREIGN KEY (id_sezona) REFERENCES sezona(id)
);

CREATE TABLE vrijeme(
   id INTEGER PRIMARY KEY,
   id_vozac INTEGER,
   vozeno_vrijeme TIME,
   krug SMALLINT,
   tip_gume VARCHAR(2),
   pozicija SMALLINT, -- u slučaju da se radi o treningu ili kvalifikacijama pozicija je OBAVEZNO NULL
   FOREIGN KEY (id_vozac) REFERENCES vozac.id_vozac
);

CREATE TABLE vikend(
   id INTEGER PRIMARY KEY,
   datum_pocetka DATE,
   datum_kraja DATE,
   id_staza INTEGER,
   id_trening INTEGER,
   id_quali INTEGER,
   id_utrka INTEGER,
   FOREIGN KEY (id_staza) REFERENCES staza(id),
   FOREIGN KEY (id_trening) REFERENCES trening(id),
   FOREIGN KEY (id_quali) REFERENCES kvalifikacija(id),
   FOREIGN KEY (id_utrka) REFERENCES utrka(id)
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


-- Potrebna preprava
INSERT INTO tim VALUES  (id_tim, naziv, voditelj, pobjede, osvojeno_podija, sjediste, kod_sasija, utrke)
--                      // 2015 \\

--                      // 2014 \\

--                      // 2013 \\

--                      // 2012 \\


INSERT INTO vozac VALUES
--                         // 2015 \\
                           (100, id_tim,   id_auto,  'Roberto', 'Merhi', 98,  STR_TO_DATE('22.3.1991.', '%d.%m.&Y.'), 'španjolsko', 0, 0, 0, 0),
                           (101, id_tim,   id_auto,  'Nico', 'Rosberg', 6,  STR_TO_DATE('27.6.1985.', '%d.%m.&Y.'), 'njemačko', 1, 57, 1594.5, 20),
                           (102, id_tim,   id_auto,  'Felipe', 'Nasr', 12,  STR_TO_DATE('21.8.1992.', '%d.%m.&Y.'), 'brazilsko', 0, 0, 29, 0),
                           (103, id_tim,   id_auto,  'Pastor', 'Maldonado', 13,  STR_TO_DATE('9.3.1985.', '%d.%m.&Y.'), 'venecuelansko', 0, 1, 76, 0),
                           (104, id_tim,   id_auto,  'Alexander', 'Rossi', 53,  STR_TO_DATE('25.9.1991.', '%d.%m.&Y.'), 'američko', 0, 2, 81, 0),
                           (105, id_tim,   id_auto,  'Will', 'Stevens', 28,  STR_TO_DATE('28.6.1991.', '%d.%m.&Y.'), 'britansko', 0, 0, 0, 0),
                           
--                         // 2014 \\
                           (110, id_tim,   id_auto,  'Jean-Eric', 'Vergne', 25,  STR_TO_DATE('25.4.1990.', '%d.%m.&Y.'), ' francukso', 0, 0, 51, 0),
                           (111, id_tim,   id_auto,  'Pastor', 'Maldonado', 13,  STR_TO_DATE('9.3.1985.', '%d.%m.&Y.'), 'venecuelansko', 0, 1, 76, 0),
                           (112, id_tim,   id_auto,  'Romain', 'Grosjean', 8,  STR_TO_DATE('17.4.1986.', '%d.%m.&Y.'), ' francusko', 0, 10, 391, 1),
                           (113, id_tim,   id_auto,  'Jules', 'Bianchi', 17,  STR_TO_DATE('3.8.1989.', '%d.%m.&Y.'), 'francusko', 0, 0, 2, 0),
                           (114, id_tim,   id_auto,  'Adrian', 'Sutil', 99,  STR_TO_DATE('11.1.1983.'), 'njemačko', 0, 0, 124, 1),
                           (115, id_tim,   id_auto,  'Max', 'Chilton', 4,  STR_TO_DATE('21.4.1991.', '%d.%m.&Y.') 'britansko', 0, 0, 0, 0),
                           (116, id_tim,   id_auto,  'Kamui', 'Kobayashi', 10,  STR_TO_DATE('13.9.1986.', '%d.%m.&Y.') 'japansko', 0, 1, 125, 1),
                           (117, id_tim,   id_auto,  'Will', 'Stevens', 28,  STR_TO_DATE('28.6.1991.', '%d.%m.&Y.') 'britansko', 0, 0, 0, 0),
                           
--                         // 2013 \\
                           (120, id_tim,   id_auto,  'Mark', 'Webber', 17, STR_TO_DATE('27.8.1976.', '%d.%m.&Y.'), 'australsko', 0, 42, 1047.5, 19),
                           (121, id_tim,   id_auto,  'Nico', 'Rosberg', 6, STR_TO_DATE('27.6.1985.', '%d.%m.&Y.'), 'njemačko', 1, 30, 1594.5, 20),
                           (122, id_tim,   id_auto,  'Felipe', 'Massa', 19, STR_TO_DATE('25.4.1981.', '%d.%m.&Y.'), 'brazilsko', 0, 41, 1167, 15),
                           (123, id_tim,   id_auto,  'Jenson', 'Button', 22, STR_TO_DATE('19.1.1980.', '%d.%m.&Y.'), 'britansko', 1, 50, 1235, 8),
                           (124, id_tim,   id_auto,  'Nico', 'Hulkenberg', 27, STR_TO_DATE('19.8.1987.', '%d.%m.&Y.'), 'njemačko', 0, 0, 521, 2),
                           (125, id_tim,   id_auto,  'Paul', 'di Resta', 40, STR_TO_DATE('16.4.1986.', '%d.%m.&Y.'), 'britansko', 0, 0, 121, 0),
                           (126, id_tim,   id_auto,  'Jean-Eric', 'Vergne', 25, STR_TO_DATE('25.4.1990.', '%d.%m.&Y.'), 'francusko', 0, 0, 51, 0),
                           (127, id_tim,   id_auto,  'Jules', 'Bianchi', 17, STR_TO_DATE('3.8.1989.', '%d.%m.&Y.'), 'francusko', 0, 0, 2, 0),
                           (128, id_tim,   id_auto,  'Charles', 'Pic', 99, STR_TO_DATE('15.2.1990.', '%d.%m.&Y.'), 'francusko', 0, 0, 0, 0),
                           (129, id_tim,   id_auto,  'Heikki', 'Kovalainen', 23, STR_TO_DATE('19.10.1981.', '%d.%m.&Y.'), 'finsko', 0, 4, 105, 2),
                           (130, id_tim,   id_auto,  'Giedo', 'van der Garde', 21, STR_TO_DATE('25.4.1985.', '%d.%m.&Y.'), 'nizozemsko', 0, 0, 0, 0);
   

INSERT INTO automobil VALUES (id_auto, naziv_auto, vrsta_motora, proizvodac_guma);
--                            // GODINA: 2013 \\
                             (9000, 'Ferrari F138 n.1', '2.4L NA V8', 'Pirelli'),
                             (9001, 'Ferrari F138 n.2', '2.4L NA V8', 'Pirelli'),
                             (9002, 'Red Bull RB9 n.1', '2.4L NA V8', 'Pirelli'),
                             (9003, 'Red Bull RB9 n.2', '2.4L NA V8', 'Pirelli'),
                             (9004, 'McLaren MP4-28 n.1', '2.4L NA V8', 'Pirelli'),
                             (9005, 'McLaren MP4-28 n.2', '2.4L NA V8', 'Pirelli'),
                             (9006, 'Williams FW35 n.1', '2.4L NA V8', 'Pirelli'),
                             (9007, 'Williams FW35 n.2', '2.4L NA V8', 'Pirelli'),
                             (9008, 'Sauber C32 n.1', '2.4L NA V8', 'Pirelli'),
                             (9009, 'Sauber C32 n.2', '2.4L NA V8', 'Pirelli'),
                             (9010, 'Toro Rosso STR8 n.1', '2.4L NA V8', 'Pirelli'),
                             (9011, 'Toro Rosso STR8 n.2', '2.4L NA V8', 'Pirelli'),
                             (9012, 'Caterham CT03 n.1', '2.4L NA V8', 'Pirelli'),
                             (9013, 'Caterham CT03 n.2', '2.4L NA V8', 'Pirelli'),
                             (9014, 'Lotus E21 n.1', '2.4L NA V8', 'Pirelli'),
                             (9015, 'Lotus E21 n.2', '2.4L NA V8', 'Pirelli'),
                             (9016, 'Marussia MR02 n.1', '2.4L NA V8', 'Pirelli'),
                             (9017, 'Marussia MR02 n.2', '2.4L NA V8', 'Pirelli'),
                             (9018, 'Mercedes W04 n.1', '2.4L NA V8', 'Pirelli'),
                             (9019, 'Mercedes W04 n.2', '2.4L NA V8', 'Pirelli'),
                             (9020, 'Force India VJM06 n.1', '2.4L NA V8', 'Pirelli'),
                             (9021, 'Force India VJM06 n.2', '2.4L NA V8', 'Pirelli'),
--                            // GODINA: 2014\\
                             (9100, 'Ferrari F14 T n.1', '1.6L TC V6 Hybrid', 'Pirelli'),
                             (9101, 'Ferrari F14 T n.2', '1.6L TC V6 Hybrid', 'Pirelli'),
                             (9102, 'Red Bull RB10 n.1', '1.6L TC V6 Hybrid', 'Pirelli'),
                             (9103, 'Red Bull RB10 n.2', '1.6L TC V6 Hybrid', 'Pirelli'),
                             (9104, 'McLaren MP4-29 n.1', '1.6L TC V6 Hybrid', 'Pirelli'),
                             (9105, 'McLaren MP4-29 n.2', '1.6L TC V6 Hybrid', 'Pirelli'),
                             (9106, 'Williams FW36 n.1', '1.6L TC V6 Hybrid', 'Pirelli'),
                             (9107, 'Williams FW36 n.2', '1.6L TC V6 Hybrid', 'Pirelli'),
                             (9108, 'Sauber C33 n.1', '1.6L TC V6 Hybrid', 'Pirelli'),
                             (9109, 'Sauber C33 n.2', '1.6L TC V6 Hybrid', 'Pirelli'),
                             (9110, 'Toro Rosso STR9 n.1', '1.6L TC V6 Hybrid', 'Pirelli'),
                             (9111, 'Toro Rosso STR9 n.2', '1.6L TC V6 Hybrid', 'Pirelli'),
                             (9112, 'Caterham CT05 n.1', '1.6L TC V6 Hybrid', 'Pirelli'),
                             (9113, 'Caterham CT05 n.2', '1.6L TC V6 Hybrid', 'Pirelli'),
                             (9114, 'Lotus E22 n.1', '1.6L TC V6 Hybrid', 'Pirelli'),
                             (9115, 'Lotus E22 n.2', '1.6L TC V6 Hybrid', 'Pirelli'),
                             (9116, 'Marussia MR03 n.1', '1.6L TC V6 Hybrid', 'Pirelli'),
                             (9117, 'Marussia MR03 n.2', '1.6L TC V6 Hybrid', 'Pirelli'),
                             (9118, 'Mercedes W05 n.1', '1.6L TC V6 Hybrid', 'Pirelli'),
                             (9118, 'Mercedes W05 n.2', '1.6L TC V6 Hybrid', 'Pirelli'),
                             (9119, 'Force India VJM07 n.1', '1.6L TC V6 Hybrid', 'Pirelli'),
                             (9120, 'Force India VJM07 n.2', '1.6L TC V6 Hybrid', 'Pirelli'),
--                           //GODINA: 2015\\
                              (9200, 'Ferrari F15 T n.1', '1.6L TC V6 Hybrid', 'Pirelli'),
                              (9201, 'Ferrari F15 T n.2', '1.6L TC V6 Hybrid', 'Pirelli'),
                              (9202, 'Red Bull RB11 n.1', '1.6L TC V6 Hybrid', 'Pirelli'),
                              (9203, 'Red Bull RB11 n.2', '1.6L TC V6 Hybrid', 'Pirelli'),
                              (9204, 'McLaren MP4-30 n.1', '1.6L TC V6 Hybrid', 'Pirelli'),
                              (9205, 'McLaren MP4-30 n.2', '1.6L TC V6 Hybrid', 'Pirelli'),
                              (9206, 'Williams FW37 n.1', '1.6L TC V6 Hybrid', 'Pirelli'),
                              (9207, 'Williams FW37 n.2', '1.6L TC V6 Hybrid', 'Pirelli'),
                              (9208, 'Sauber C34 n.1', '1.6L TC V6 Hybrid', 'Pirelli'),
                              (9209, 'Sauber C34 n.2', '1.6L TC V6 Hybrid', 'Pirelli'),
                              (9210, 'Toro Rosso STR10 n.1', '1.6L TC V6 Hybrid', 'Pirelli'),
                              (9211, 'Toro Rosso STR10 n.2', '1.6L TC V6 Hybrid', 'Pirelli'),
                              (9212, 'Lotus E23 n.1', '1.6L TC V6 Hybrid', 'Pirelli'),
                              (9213, 'Lotus E23 n.2', '1.6L TC V6 Hybrid', 'Pirelli'),
                              (9214, 'Marussia MR03B n.1', '1.6L TC V6 Hybrid', 'Pirelli'),
                              (9215, 'Marussia MR03B n.2', '1.6L TC V6 Hybrid', 'Pirelli'),
                              (9216, 'Mercedes W06 n.1', '1.6L TC V6 Hybrid', 'Pirelli'),
                              (9217, 'Mercedes W06 n.2', '1.6L TC V6 Hybrid', 'Pirelli'),
                              (9218, 'Force India VJM08 n.1', '1.6L TC V6 Hybrid', 'Pirelli'),
                              (9219, 'Force India VJM08 n.2', '1.6L TC V6 Hybrid', 'Pirelli'),     


-- SPONZORI // LISTA JE SMANJENA ZBOG OGROMNE KOLIČINE PODATAKA GLEDAJUĆI DA SVAKI TIM IMA PO MINIMALNO 20 SPONZORA.
INSERT INTO sponzor VALUES (4001, 'Petronas', 100000000),
                           (4002, 'Tommy Hilfiger', 24000000),
                           (4003, 'Monster Energy',56000000),
                           (4004, 'Oracle', 96500000),
                           -- (4005, 'Cash App', 76000000),
                           (4006, 'AT&T', 23760000),
                           (4007, 'Shell', 136758000),
                           (4008, 'Santander', 12000000),
                           -- (4009, 'VELAS', 57000000),
                           (4010, 'Snapdragon', 9000000),
                           (4011, 'Google', 194986000),
                           (4012, 'Dell', 29000000),
                           (4013, 'Alienware', 19000000),
                           (4014, 'Logitech G', 38760000),
                           (4015, 'SunGod', 560000),
                           -- (4016, 'BWT', 112000000),
                           (4017, 'RCI Bank and Services', 98760000),
                           (4018, 'Yahoo', 56000000),
                           (4019, 'Kappa', 780000),
                           (4020, 'Sprinklr', 520000),
                           -- (4021, 'AlphaTauri', 230670000),
                           (4022, 'Honda', 73187500),
                           (4023, 'Pirelli', 4167940000),
                           (4024, 'Ray Ban', 10000000),
                           (4025, 'Siemens', 13000000),
                           (4026, 'Aramco', 79000000),
                           -- (4027, 'TikTok', 20000000),
                           (4028, 'Hackett London',6780000),
                           (4029, 'Lavazza', 30000000),
                           (4030, 'DURACELL', 24000000),
                           -- (4031, 'Acronis', 53000000),
                           -- (4032, 'Alfa Romeo', 45600000),
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
                           -- Ugašeni neki noviji sponzori (potrebna provjera)

--                        Staze se ne klasificiraju drukčije nakon što su vođene promjene na njima (npr. dodani zavoji)
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


INSERT INTO kvalifikacija  VALUES (id_kvalifikacija, krugova_vozeno, izlazaka_na_stazu, datum);
INSERT INTO trening  VALUES (id_trening, odvozeno_krugova, najbrzi_krug, izlazaka_na_stazu, datum);


-- UTRKE
INSERT INTO utrka  VALUES
--                         // GODINA: 2013 \\
                          (3101, '2013 Australia GP', pobjednik, 58, 01:30:03.225, 00:01:29.274),
                          (3102, '2013 Malaysia GP', pobjednik, 56, 01:38:56.681, 00:01:39.199),
                          (3103, '2013 China GP', pobjednik, 56, 01:36:26.945, 00:01:36.808),
                          (3104, '2013 Bahrain GP', pobjednik, 57, 01:36:00.498, 00:01:36.961),
                          (3105, '2013 Monaco GP', pobjednik, 78, 02:17:52.056, 00:01:18.133),
                          (3106, '2013 Canada GP', pobjednik, 70, 01:32:09.143, 00:01:16.182),
                          (3107, '2013 Great Britain GP', pobjednik, 52, 01:32:59.456, 00:01:33.401),
                          (3108, '2013 Germany GP', pobjednik, 60, 01:41:14.711, 00:01:33.468),
                          (3109, '2013 Singapore GP', pobjednik, 61, 01:59:13.132, 00:01:48.574),
                          (3110, '2013 Japan GP', pobjednik, 53, 01:26:49.301, 00:01:34.587),
                          (3111, '2013 India GP', pobjednik, 60, 01:31:12.187, 00:01:27:679),
                          (3112, '2013 Abu Dhabi GP', pobjednik, 55, 01:38:06.106, 00:01:43:434),
                          (3113, '2013 Brazil GP', pobjednik, 71, 01:32:26.300, 00:01:15.436),

--                         // GODINA: 2014 \\
                          (3200, '2014 Australia GP', pobjednik, 57, 01:32:58.710, 00:01:32.4784),
                          (3201, '2014 Bahrain GP', pobjednik, 57, 01:39:42.743, 00:01:37.020),
                          (3202, '2014 China GP', pobjednik, 54, 01:33:28.338, 00:01:40.402),
                          (3203, '2014 Monaco GP', pobjednik, 78, 01:49:27.661, 00:01:18.4794),
                          (3204, '2014 Austria GP', pobjednik, 71, 01:27:54.976, 00:01:12.142),
                          (3205, '2014 Germany GP', pobjednik, 67, 01:33:42.914, 00:01:19.908),
                          (3206, '2014 Belgium GP', pobjednik, 44, 01:24:36.556, 00:01:50.511),
                          (3207, '2014 Italy GP', pobjednik, 53, 01:19:10.236, 00:01:28.004),
                          (3208, '2014 Singapore GP', pobjednik, 60, 02:00:04.795, 00:01:50.417),
                          (3209, '2014 Abu Dhabi GP', POBJEDNIK, 55, 01:39:02.619, 00:01:44.496),

--                         // GODINA: 2015 \\
                          (3300, '2015 Australia GP', pobjednik, 58, 01:31:54.067, 00:01:30.945),
                          (3301, '2015 Monaco GP', pobjednik, 78, 01:49:18.420, 00:01:18.063),
                          (3302, '2015 Canada GP', pobjednik, 70, 01:31:53.145, 00:01:16.987),
                          (3303, '2015 Great Britain GP', pobjednik, 52, 01:31:27.729, 00:01:37.093),
                          (3304, '2015 Belgium GP', pobjednik, 43, 01:23:40.387, 00:01:52.416),
                          (3305, '2015 Italy GP', pobjednik, 53, 01:18:00.688, 00:01:26.672),
                          (3306, '2015 Singapore GP', pobjednik, 61, 02:01:22.118, 00:01:50.041),
                          (3307, '2015 Japan GP', pobjednik, 53, 01:28:06.508, 00:01:36.145),
                          (3308, '2015 Brazil GP', pobjednik, 71, 01:31:09.090, 00:01:14.832),
                          (3309, '2015 Abu Dhabi GP', pobjednik, 55, 01:38:30.175, 00:01:45.356);


-- SEZONE // 
INSERT INTO sezona VALUES (id_sezona, godina),
                          (2013, 2013),
                          (2014, 2014),
                          (2015, 2015);