DROP DATABASE IF EXISTS Formula1;

CREATE DATABASE Formula1;
USE Formula1;


CREATE TABLE tim(
   id INTEGER PRIMARY KEY,
   naziv VARCHAR(50) NOT NULL UNIQUE,
   voditelj VARCHAR(50) NOT NULL,
   sjediste VARCHAR(50) NOT NULL
);

CREATE TABLE sezona(
   id INTEGER PRIMARY KEY,
   godina INTEGER NOT NULL
);

CREATE TABLE konstruktor_u_sezoni(
   id INTEGER PRIMARY KEY,
   id_sezona INTEGER,
   id_tim INTEGER,
   kod_sasija VARCHAR(10) NOT NULL UNIQUE,
   FOREIGN KEY (id_tim) REFERENCES tim(id),
   FOREIGN KEY (id_sezona) REFERENCES sezona(id)
);

CREATE TABLE vozac(
   id INTEGER PRIMARY KEY,
   ime VARCHAR(30) NOT NULL,
   prezime VARCHAR(30) NOT NULL,
   odabrani_broj SMALLINT,
   datum_rodenja DATE NOT NULL,
   nacionalnost VARCHAR(30) NOT NULL
);

CREATE TABLE automobil(
   id INTEGER PRIMARY KEY,
   naziv_auto VARCHAR(30) NOT NULL,
   vrsta_motora VARCHAR(40) NOT NULL,
   proizvodac_guma VARCHAR(30) DEFAULT 'Pirelli'
);

CREATE TABLE vozac_u_sezoni(
   id INTEGER PRIMARY KEY,
   id_vozac INTEGER,
   id_kus INTEGER,
   id_auto INTEGER,
   id_sezona INTEGER,
   FOREIGN KEY (id_kus) REFERENCES konstruktor_u_sezoni(id),
   FOREIGN KEY (id_vozac) REFERENCES vozac(id),
   FOREIGN KEY (id_auto) REFERENCES automobil(id),
   FOREIGN KEY (id_sezona) REFERENCES sezona(id)
);

CREATE TABLE sponzor(
   id INTEGER PRIMARY KEY,
   ime VARCHAR(50) NOT NULL
);

CREATE TABLE sponzor_u_sezoni(
   id INTEGER PRIMARY KEY,
   id_sponzor INTEGER,
   id_kus INTEGER,
   isplacen_novac INTEGER NOT NULL,
   status_sponzora VARCHAR(13) DEFAULT 'Suradnik',
   id_sezona INTEGER,
   FOREIGN KEY (id_sponzor) REFERENCES sponzor(id),
   FOREIGN KEY (id_kus) REFERENCES konstruktor_u_sezoni(id),
   FOREIGN KEY (id_sezona) REFERENCES sezona(id)
);

CREATE TABLE staza(
   id INTEGER PRIMARY KEY,
   ime_staze VARCHAR(50) NOT NULL UNIQUE,
   drzava VARCHAR(30) NOT NULL,
   duzina_m INTEGER NOT NULL,
   broj_drs_zona INTEGER NOT NULL DEFAULT 2
);

CREATE TABLE trening(
   id INTEGER PRIMARY KEY
);

CREATE TABLE tren_vrijeme(
   id INTEGER PRIMARY KEY,
   id_tren INTEGER,
   id_vus INTEGER,
   vozeno_vrijeme_str VARCHAR(30) NOT NULL,
   krug SMALLINT,
   FOREIGN KEY (id_vus) REFERENCES vozac_u_sezoni(id),
   FOREIGN KEY (id_tren) REFERENCES trening(id)
);

CREATE TABLE kvalifikacija(
   id INTEGER PRIMARY KEY
);

CREATE TABLE kval_vrijeme(
   id INTEGER PRIMARY KEY,
   id_kval INTEGER,
   id_vus INTEGER,
   vozeno_vrijeme_str VARCHAR(30) NOT NULL,
   krug SMALLINT,
   FOREIGN KEY (id_vus) REFERENCES vozac_u_sezoni(id),
   FOREIGN KEY (id_kval) REFERENCES kvalifikacija(id)
);

CREATE TABLE utrka(
   id INTEGER PRIMARY KEY,
   ime_nagrade VARCHAR(50) NOT NULL UNIQUE,
   broj_krugova INTEGER NOT NULL
);

CREATE TABLE utrka_vrijeme(
   id INTEGER PRIMARY KEY,
   id_utrka INTEGER,
   id_vus INTEGER,
   vozeno_vrijeme_str VARCHAR(30) NOT NULL,
   krug SMALLINT,
   FOREIGN KEY (id_utrka) REFERENCES utrka(id),
   FOREIGN KEY (id_vus) REFERENCES vozac_u_sezoni(id)
);

CREATE TABLE vikend(
   id INTEGER PRIMARY KEY,
   datum_pocetka DATE NOT NULL,
   datum_kraja DATE NOT NULL, 
   id_staza INTEGER,
   id_trening INTEGER,
   id_quali INTEGER,
   id_utrka INTEGER,
   id_sezona INTEGER,
   FOREIGN KEY (id_staza) REFERENCES staza(id),
   FOREIGN KEY (id_trening) REFERENCES trening(id),
   FOREIGN KEY (id_quali) REFERENCES kvalifikacija(id),
   FOREIGN KEY (id_utrka) REFERENCES utrka(id),
   FOREIGN KEY (id_sezona) REFERENCES sezona(id)
);


-- PROMJENE I OGRANIČENJA NA TABLICAMA
ALTER TABLE staza
	ADD CONSTRAINT id_len_ck_staza CHECK (length(id) = 4),
   ADD CONSTRAINT id_rng_ck_staza CHECK (id >= 1000 AND id < 2000),
   ADD CONSTRAINT duzina_rng_ck_staza CHECK (duzina_m >= 1000 AND duzina_m < 7000);
   
ALTER TABLE tim
	ADD CONSTRAINT id_len_ck_tim CHECK (length(id) = 3),
   ADD CONSTRAINT id_rng_ck_tim CHECK (id >= 100 AND id < 1000);

ALTER TABLE konstruktor_u_sezoni
   ADD CONSTRAINT id_len_ck_kus CHECK (length(id) = 3),
   ADD CONSTRAINT id_rng_ck_kus CHECK (id >= 200 AND id < 300);

ALTER TABLE sponzor
   ADD CONSTRAINT id_len_ck_sponzor CHECK (length(id) = 4),
   ADD CONSTRAINT id_rng_ck_sponzor CHECK (id >= 4000 AND id < 5000);

ALTER TABLE sponzor_u_sezoni
   ADD CONSTRAINT payout_ck_sponzor CHECK (isplacen_novac >= 500000);

ALTER TABLE utrka
   ADD CONSTRAINT id_len_ck_utrka CHECK (length(id) = 4),
   ADD CONSTRAINT id_rng_ck_utrka CHECK (id >= 3000 AND id < 3500);

ALTER TABLE vikend
   ADD CONSTRAINT id_len_ck_vikend CHECK (length(id) = 4),
   ADD CONSTRAINT id_rng_ck_vikend CHECK (id >= 8000 AND id < 9000),
   ADD CONSTRAINT date_rng_ck  CHECK (datum_pocetka + INTERVAL 3 DAY == datum_kraja); -- Provjeriti

ALTER TABLE automobil
   ADD CONSTRAINT id_len_ck_automobil CHECK (length(id) = 4),
   ADD CONSTRAINT id_rng_ck_automobil CHECK (id >= 9000 AND id < 10000);
   
ALTER TABLE vozac
   ADD CONSTRAINT id_len_ck_vozac CHECK (length(id) = 4),
   ADD CONSTRAINT id_rng_ck_vozac CHECK (id >= 7000 AND id < 7100);

ALTER TABLE vozac_u_sezoni
   ADD CONSTRAINT id_len_cek_vus CHECK (length(id) = 4),
   ADD CONSTRAINT id_rng_ck_vus CHECK (id >= 7100 and id < 7200);

ALTER TABLE sezona
   ADD CONSTRAINT id_check CHECK (id >= 2013 and id <= 2015);


-- OVO JE ISJEČAK ZA TABLICE IMPORTIRANE IZ CSV FILE-A
SHOW VARIABLES LIKE "secure_file_priv"; -- OVA NESMIJE ISPISATI NULL POD VALUES, U DOBIVENI DIREKTORIJ SE UBACUJU .CSV DATOTEKE

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/utrke-vremena.csv" -- OVDJE IDE DIREKTORIJ KOJI DOBIJES IZ GORNJE KOMANDE, U SLUCAJU GRESKE MOGUCE JE DA TREBA ZAMJENITI SMJER SLASHEVA
INTO TABLE utrka_vrijeme
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

ALTER TABLE utrka_vrijeme ADD COLUMN vozeno_vrijeme TIME(3) NOT NULL;
UPDATE utrka_vrijeme SET vozeno_vrijeme = STR_TO_DATE(vozeno_vrijeme_str, "%i:%s:%f");
--  // KRAJ ZA UTRKE VRIJEME


LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/kvalifikacije-vremena.csv" -- OVDJE IDE DIREKTORIJ KOJI DOBIJES IZ GORNJE KOMANDE, U SLUCAJU GRESKE MOGUCE JE DA TREBA ZAMJENITI SMJER SLASHEVA
INTO TABLE kval_vrijeme
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

ALTER TABLE kval_vrijeme ADD COLUMN vozeno_vrijeme TIME(3) NOT NULL;
UPDATE kval_vrijeme SET vozeno_vrijeme = STR_TO_DATE(vozeno_vrijeme_str, "%i:%s:%f");
--  // KRAJ ZA KVALIFIKACIJE VRIJEME


LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/treninzi-vremena.csv" -- OVDJE IDE DIREKTORIJ KOJI DOBIJES IZ GORNJE KOMANDE, U SLUCAJU GRESKE MOGUCE JE DA TREBA ZAMJENITI SMJER SLASHEVA
INTO TABLE tren_vrijeme
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

ALTER TABLE tren_vrijeme ADD COLUMN vozeno_vrijeme TIME(3) NOT NULL;
UPDATE tren_vrijeme SET vozeno_vrijeme = STR_TO_DATE(vozeno_vrijeme_str, "%i:%s:%f");
--  // KRAJ ZA TRENING VRIJEME


INSERT INTO tim VALUES (100, "Scuderia Ferrari", "Maurizio Arrivabene", "Maranello, Italy"),
                       (101, "Sahara Force India F1 Team", "Colin Kolles", "Silverstone, United Kingdom"),
                       (102, "Lotus F1 Team", "Éric Boullier", "Enstone, Oxfordshire, United Kingdom"),
                       (103, "Manor Marussia F1 Team", "John Booth ", "Banbury, Oxfordshire, United Kingdom"),
                       (104, "McLaren Honda", "Eric Boullier", "Surrey, United Kingdom"),
                       (105, "Mercedes AMG Petronas F1 Team", "Totto Wolf", "Brackley, United Kingdom"),
                       (106, "Infiniti Red Bull Racing", "Christian Horner", "Milton Keynes, United Kingdom."),
                       (107, "Sauber F1 Team", "Monisha Kaltenborn", "Hinwil, Switzerland"),
                       (108, "Scuderia Toro Rosso", "Franz Tost", "Faenza, Italy"),
                       (109, "Williams Martini Racing", "Claire Williams", "Grove, Oxfordshire, United Kingdom"),
                       (110, "Caterham F1 Team", "Cyril Abiteboul", "Leafield, Oxfordshire, United Kingdom");


INSERT INTO vozac VALUES (7000, "Roberto", "Merhi", 98, STR_TO_DATE("22.03.1991.", "%d.%m.%Y."), "španjolsko"),
                         (7001, "Nico", "Rosberg", 6, STR_TO_DATE("27.06.1985.", "%d.%m.%Y."), "njemačko"),
                         (7002, "Felipe", "Nasr", 12, STR_TO_DATE("21.08.1992.", "%d.%m.%Y."), "brazilsko"),
                         (7003, "Pastor", "Maldonado", 13, STR_TO_DATE("09.03.1985.", "%d.%m.%Y."), "venecuelansko"),
                         (7004, "Alexander", "Rossi", 53, STR_TO_DATE("25.09.1991.", "%d.%m.%Y."), "američko"),
                         (7005, "Will", "Stevens", 28, STR_TO_DATE("28.06.1991.", "%d.%m.%Y."), "britansko"),
                         (7006, "Sebastian", "Vettel", 5, STR_TO_DATE("03.07.1987.", "%d.%m.%Y."), "njemačko"),
                         (7007, "Fernando", "Alonso", 14, STR_TO_DATE("29.07.1981.", "%d.%m.%Y."), "španjolsko"),
                         (7008, "Sergio", "Pérez", 11, STR_TO_DATE("26.01.1990", "%d.%m.%Y."), "meksičko"),
                         (7009, "Kimi", "Räikkönen", 7, STR_TO_DATE("17.10.1979", "%d.%m.%Y."), "finsko"),
                         (7010, "Jean-Eric", "Vergne", 25, STR_TO_DATE("25.04.1990.", "%d.%m.%Y."), " francukso"),
                         (7012, "Romain", "Grosjean", 8, STR_TO_DATE("17.04.1986.", "%d.%m.%Y."), " francusko"),
                         (7013, "Jules", "Bianchi", 17, STR_TO_DATE("03.08.1989.", "%d.%m.%Y."), "francusko"),
                         (7014, "Adrian", "Sutil", 99, STR_TO_DATE("11.01.1983.", "%d.%m.%Y."), "njemačko"),
                         (7015, "Max", "Chilton", 4, STR_TO_DATE("21.04.1991.", "%d.%m.%Y."), "britansko"),
                         (7016, "Kamui", "Kobayashi", 10, STR_TO_DATE("13.09.1986.", "%d.%m.%Y."), "japansko"),
                         (7017, "Mark", "Webber", 17, STR_TO_DATE("27.08.1976.", "%d.%m.%Y."), "australsko"),
                         (7018, "Lewis", "Hamilton", 44, STR_TO_DATE("07.01.1985.", "%d.%m.%Y."), "britansko"),
                         (7019, "Felipe", "Massa", 19, STR_TO_DATE("25.04.1981.", "%d.%m.%Y."), "brazilsko"),
                         (7020, "Jenson", "Button", 22, STR_TO_DATE("19.01.1980.", "%d.%m.%Y."), "britansko"),
                         (7021, "Nico", "Hülkenberg", 27, STR_TO_DATE("19.08.1987.", "%d.%m.%Y."), "njemačko"),
                         (7022, "Paul", "di Resta", 40, STR_TO_DATE("16.04.1986.", "%d.%m.%Y."), "britansko"),
                         (7024, "Jules", "Bianchi", 17, STR_TO_DATE("03.08.1989.", "%d.%m.%Y."), "francusko"),
                         (7025, "Charles", "Pic", 99, STR_TO_DATE("15.02.1990.", "%d.%m.%Y."), "francusko"),
                         (7026, "Giedo", "van der Garde", 21, STR_TO_DATE("25.04.1985.", "%d.%m.%Y."), "nizozemsko"),
                         (7027, "Esteban", "Gutiérrez", 21, STR_TO_DATE("05.08.1991.", "%d.%m.%Y."), "meksičko"),
                         (7028, "Valtteri", "Bottas", 77, STR_TO_DATE("28.08.1989", "%d.%m.%Y."), "finsko"),
                         (7029, "Daniel", "Ricciardo", 3, STR_TO_DATE("01.07.1989.", "%d.%m.%Y."), "autstralsko"),
                         (7030, "Marcus", "Ericsson", 9, STR_TO_DATE("02.09.1990.", "%d.%m.%Y."), "švedsko"),
                         (7031, "Kevin", "Magnussen", 20, STR_TO_DATE("05.10.1992.", "%d.%m.%Y."), "dansko"),
                         (7032, "Daniil", "Kvyat", 26, STR_TO_DATE("26.04.1994.", "%d.%m.%Y."), "rusko"),
                         (7033, "Max", "Verstappen", 33, STR_TO_DATE("30.09.1997.", "%d.%m.%Y."), "nizozemsko"),
                         (7034, "Carlos", "Sainz", 55, STR_TO_DATE("01.09.1994.", "%d.%m.%Y."), "španjolsko");


INSERT INTO automobil VALUES (9000, "Ferrari F138 n.1", "2.4L NA V8", "Pirelli"), -- // GODINA: 2013 \\
                             (9001, "Ferrari F138 n.2", "2.4L NA V8", "Pirelli"),
                             (9002, "Red Bull RB9 n.1", "2.4L NA V8", "Pirelli"),
                             (9003, "Red Bull RB9 n.2", "2.4L NA V8", "Pirelli"),
                             (9004, "McLaren MP4-28 n.1", "2.4L NA V8", "Pirelli"),
                             (9005, "McLaren MP4-28 n.2", "2.4L NA V8", "Pirelli"),
                             (9006, "Williams FW35 n.1", "2.4L NA V8", "Pirelli"),
                             (9007, "Williams FW35 n.2", "2.4L NA V8", "Pirelli"),
                             (9008, "Sauber C32 n.1", "2.4L NA V8", "Pirelli"),
                             (9009, "Sauber C32 n.2", "2.4L NA V8", "Pirelli"),
                             (9010, "Toro Rosso STR8 n.1", "2.4L NA V8", "Pirelli"),
                             (9011, "Toro Rosso STR8 n.2", "2.4L NA V8", "Pirelli"),
                             (9012, "Caterham CT03 n.1", "2.4L NA V8", "Pirelli"),
                             (9013, "Caterham CT03 n.2", "2.4L NA V8", "Pirelli"),
                             (9014, "Lotus E21 n.1", "2.4L NA V8", "Pirelli"),
                             (9015, "Lotus E21 n.2", "2.4L NA V8", "Pirelli"),
                             (9016, "Marussia MR02 n.1", "2.4L NA V8", "Pirelli"),
                             (9017, "Marussia MR02 n.2", "2.4L NA V8", "Pirelli"),
                             (9018, "Mercedes W04 n.1", "2.4L NA V8", "Pirelli"),
                             (9019, "Mercedes W04 n.2", "2.4L NA V8", "Pirelli"),
                             (9020, "Force India VJM06 n.1", "2.4L NA V8", "Pirelli"),
                             (9021, "Force India VJM06 n.2", "2.4L NA V8", "Pirelli"),

                             (9100, "Ferrari F14 T n.1", "1.6L TC V6 Hybrid", "Pirelli"), -- // GODINA: 2014\\
                             (9101, "Ferrari F14 T n.2", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9102, "Red Bull RB10 n.1", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9103, "Red Bull RB10 n.2", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9104, "McLaren MP4-29 n.1", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9105, "McLaren MP4-29 n.2", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9106, "Williams FW36 n.1", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9107, "Williams FW36 n.2", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9108, "Sauber C33 n.1", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9109, "Sauber C33 n.2", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9110, "Toro Rosso STR9 n.1", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9111, "Toro Rosso STR9 n.2", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9112, "Caterham CT05 n.1", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9113, "Caterham CT05 n.2", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9114, "Lotus E22 n.1", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9115, "Lotus E22 n.2", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9116, "Marussia MR03 n.1", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9117, "Marussia MR03 n.2", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9118, "Mercedes W05 n.1", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9119, "Mercedes W05 n.2", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9120, "Force India VJM07 n.1", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9121, "Force India VJM07 n.2", "1.6L TC V6 Hybrid", "Pirelli"),

                             (9200, "Ferrari SF15-T T n.1", "1.6L TC V6 Hybrid", "Pirelli"), -- //GODINA: 2015\\
                             (9201, "Ferrari SF15-T n.2", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9202, "Red Bull RB11 n.1", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9203, "Red Bull RB11 n.2", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9204, "McLaren MP4-30 n.1", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9205, "McLaren MP4-30 n.2", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9206, "Williams FW37 n.1", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9207, "Williams FW37 n.2", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9208, "Sauber C34 n.1", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9209, "Sauber C34 n.2", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9210, "Toro Rosso STR10 n.1", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9211, "Toro Rosso STR10 n.2", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9212, "Lotus E23 n.1", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9213, "Lotus E23 n.2", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9214, "Marussia MR03B n.1", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9215, "Marussia MR03B n.2", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9216, "Mercedes W06 n.1", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9217, "Mercedes W06 n.2", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9218, "Force India VJM08 n.1", "1.6L TC V6 Hybrid", "Pirelli"),
                             (9219, "Force India VJM08 n.2", "1.6L TC V6 Hybrid", "Pirelli");


-- SPONZORI // LISTA JE SMANJENA ZBOG OGROMNE KOLIČINE PODATAKA GLEDAJUĆI DA SVAKI TIM IMA PO MINIMALNO 20 SPONZORA.
INSERT INTO sponzor VALUES (4001, "Petronas"),
                           (4002, "Weichai Power"),
                           (4003, "Alfa Romeo"),
                           (4004, "Coca-Cola"),
                           (4005, "Mahle"),
                           (4006, "AT&T"),
                           (4007, "Shell"),
                           (4008, "Santander"),
                           (4009, "Brembo"),
                           (4010, "Kaspersky"),
                           (4011, "Google"),
                           (4012, "Dell"),
                           (4013, "Alienware"),
                           (4014, "Logitech G"),
                           (4015, "Magneti Marelli"),
                           (4016, "Blackberry"),
                           (4017, "RCI Bank and Services"),
                           (4018, "Yahoo"),
                           (4019, "Kappa"),
                           (4020, "Sprinklr"),
                           (4021, "MIG Bank"),
                           (4022, "Honda"),
                           (4023, "Pirelli"),
                           (4024, "Burn"),
                           (4025, "Siemens"),
                           (4026, "Aramco"),
                           (4027, "Genii Business Exchange"),
                           (4028, "Hackett London"),
                           (4029, "Randstad"),
                           (4030, "DURACELL"),
                           (4031, "Petróleos de Venezuela, S.A."),
                           (4032, "Tata Motors"),
                           (4033, "Infiniti"),
                           (4034, "Iveco"),
                           (4035, "Puma"),
                           (4036, "Haas Automation"),
                           (4037, "Maui Jim"),
                           (4038, "Alpinestars"),
                           (4039, "TeamViewer"),
                           (4040, "Richard Mille"),
                           (4041, "Police"),
                           (4042, "Philip Morris International"),
                           (4043, "Rauch"),
                           (4044, "UPS"),
                           (4045, "Dupont"),
                           (4046, "Marlboro"),
                           (4047, "Martini"),
                           (4048, "Rexona"),
                           (4049, "NOVA Chemicals"),
                           (4050, "TAGHeuer"),
                           (4051, "Casio"),
                           (4052, "Pepe Jeans"),
                           (4053, "TotalEnergies"),
                           (4054, "Airbus"),
                           (4055, "Intel"),
                           (4056, "Cristalbox"),
                           (4057, "Econocom Ermestel"),
                           (4058, "Varlion"),
                           (4059, "Marussia"),
                           (4060, "Bifold Group"),
                           (4061, "Antler Luggage"),
                           (4062, "Sage Enterprise Resource Planning Softwares"),
                           (4063, "Sahara India Pariwar"),
                           (4064, "Whyte And Mackay"),
                           (4065, "Kingfisher"),
                           (4066, "Vodafone"),
                           (4067, "Hugo Boss"),
                           (4068, "Verizon"),
                           (4069, "Mobil 1"),
                           (4070, "Telcel"),
                           (4071, "Telmex"),
                           (4072, "Claro"),
                           (4073, "Chelsea F.C."),
                           (4074, "NEC Corporation"),
                           (4075, "Renault"),
                           (4076, "Banco do Brasil"),
                           (4077, "QNET"),
                           (4078, "Monster Energy"),
                           (4079, "Smirnoff"),
                           (4080, "Flex-Box"),
                           (4081, "Airbnb"),
                           (4082, "Reebok");


                          -- Staze se ne klasificiraju drukčije nakon što su vođene promjene na njima (npr. dodani zavoji)
INSERT INTO staza VALUES (1001, "Bahrain International Circuit", "Sakhir, Bahrain", 5412, 3),
                         (1003, "Albert Park Circuit", "Melbourne, Australia", 5278, 3),
                         (1006, "Circuit de Barcelona-Catalunya 2021-2022", "Montmeló, Spain", 4675, 2),
                         (1007, "Circuit de Monte Carlo", "Monte Carlo, Monaco", 3337, 1),
                         (1008, "Baku City Circuit", "Baku, Azerbaijan", 6003, 2),
                         (1009, "Circuit Gilles-Villeneuve", "Montreal, Canada", 4361, 2),
                         (1010, "Silverstone Circuit", "Silverstone, UK", 5891, 2),
                         (1011, "Red Bull Ring", "Spielberg, Austria", 4318, 2),
                         (1012, "Circuit Paul Ricard", "Le Castellet, France", 5842, 2),
                         (1013, "Hungaroring", "Mogyoród, Hungary", 4381, 1),
                         (1014, "Circuit Spa-Francorchamps", "Stavelot, Belgium", 7004, 2),
                         (1016, "Autodromo Nazionale Monza", "Monza, Italy", 5793, 2),
                         (1017, "Sochi Autodrom", "Sochi, Russia", 5848, 2),
                         (1018, "Marina Bay Circuit", "Marina Bay, Singapore", 5063, 3),
                         (1019, "Suzuka Circuit", "Suzuka, Japan", 5807, 1),
                         (1020, "Circuit of the Americas", "Austin, USA", 5514, 2),
                         (1021, "Autódromo Hermanos Rodríguez", "Mexico City, Mexico", 4304, 1),
                         (1022, "Autódromo José Carlos Pace", "São Paulo, Brazil", 4309, 2),
                         (1023, "Yas Marina Circuit", "Yas Island", 5281, 2),
                         (1024, "Autodromo do Algarve", "Portimão, Portugal", 4653, 2),
                         (1025, "Losail International Circuit", "Lusail, Qatar", 5380, 1),
                         (1027, "Nürburgring", "Nürburg, Germany", 5148, 2),
                         (1029, "Hockenheimring", "Hockenheim, Germany", 4574, 2),
                         (1030, "Shanghai International Circuit", "Shanghai, China", 5451, 2),
                         (1031, "Sepang International Circuit", "Sepang, Malaysia", 5543, 2),
                         (1032, "Korean International Circuit", "Yeongam, South Korea", 5615, 2),
                         (1033, "Buddh International Circuit", "Greater Noida, India", 5125, 2),
                         (1034, "Valencia Street Circuit", "Valencia, Spain", 5419, 2);


INSERT INTO trening VALUES (20133101), -- // GODINA: 2013 \\
                           (20133102),
                           (20133103),
                           (20133104),
                           (20133105),
                           (20133106),
                           (20133107),
                           (20133108),
                           (20133109),
                           (20133110),
                           (20133111),
                           (20133112),
                           (20133113),

                           (20143200), -- // GODINA: 2014 \\
                           (20143201),
                           (20143202),
                           (20143203),
                           (20143204),
                           (20143205),
                           (20143206),
                           (20143207),
                           (20143208),
                           (20143209),

                           (20153300), -- // GODINA: 2015 \\
                           (20153301),
                           (20153302),
                           (20153303),
                           (20153304),
                           (20153305),
                           (20153306),
                           (20153307),
                           (20153308),
                           (20153309);
                             

INSERT INTO kvalifikacija VALUES (30133101), -- // GODINA: 2013 \\
                                 (30133102),
                                 (30133103),
                                 (30133104),
                                 (30133105),
                                 (30133106),
                                 (30133107),
                                 (30133108),
                                 (30133109),
                                 (30133110),
                                 (30133111),
                                 (30133112),
                                 (30133113),

                                 (30143200), -- // GODINA: 2014 \\
                                 (30143201),
                                 (30143202),
                                 (30143203),
                                 (30143204),
                                 (30143205),
                                 (30143206),
                                 (30143207),
                                 (30143208),
                                 (30143209),

                                 (30153300), -- // GODINA: 2015 \\
                                 (30153301),
                                 (30153302),
                                 (30153303),
                                 (30153304),
                                 (30153305),
                                 (30153306),
                                 (30153307),
                                 (30153308),
                                 (30153309);


INSERT INTO utrka VALUES (3101, "Rolex Australian Grand Prix 2013", 58), -- // GODINA: 2013 \\
                         (3102, "Petronas Malaysia Grand Prix 2013", 56),
                         (3103, "UBS Chinese Grand Prix 2013", 56),
                         (3104, "Gulf Air Bahrain Grand Prix 2013", 57),
                         (3105, "71e Grand Prix de Monaco", 78),
                         (3106, "Grand Prix du Canada 2013", 70),
                         (3107, "Santander British Grand Prix 2013", 52),
                         (3108, "Grosser Preis Santander von Deutschland 2013", 60),
                         (3109, "Singtel Singapore Grand Prix 2013", 61),
                         (3110, "Japanese Grand Prix 2013", 53),
                         (3111, "Aritel India Grand Prix", 60),
                         (3112, "Etihad Airways Abu Dhabi Grand Prix 2013", 55),
                         (3113, "42° Grande Prêmio do Brasil", 71),

                         (3200, "Rolex Australian Grand Prix 2014", 57), -- // GODINA: 2014 \\
                         (3201, "Gulf Air Bahrain Grand Prix 2014", 57),
                         (3202, "UBS Chinese Grand Prix 2014", 54),
                         (3203, "72eme Gran Prix de Monaco", 78),
                         (3204, "Großer Preis von Österreich", 71),
                         (3205, "Grosser Preis Santander von Deutschland 2014", 67),
                         (3206, "Shell Belgian Grand Prix 2014", 44),
                         (3207, "85° Gran Premio d'Italia", 53),
                         (3208, "Singapore Airlines Singapore Grand Prix 2014", 60),
                         (3209, "Etihad Airways Abu Dhabi Grand Prix 2014", 55),

                         (3300, "Rolex Australian Grand Prix 2015", 58), -- // GODINA: 2015 \\
                         (3301, "73ème Grand Prix de Monaco", 78),
                         (3302, "Grand Prix du Canada", 70),
                         (3303, "British Grand Prix", 52),
                         (3304, "Shell Belgian Grand Prix 2015", 43),
                         (3305, "86° Gran Premio d'Italia", 53),
                         (3306, "Singapore Airlines Singapore Grand Prix 2015", 61),
                         (3307, "Japanese Grand Prix 2015", 53),
                         (3308, "44° Grande Prêmio do Brasil", 71),
                         (3309, "Etihad Airways Abu Dhabi Grand Prix 2015", 55);


INSERT INTO sezona VALUES (2013, 2013),
                          (2014, 2014),
                          (2015, 2015);


INSERT INTO konstruktor_u_sezoni VALUES (200, 2013, 100, "F138"), -- // Scuderia Ferrari \\
                                        (201, 2014, 100, "F14 T"),
                                        (202, 2015, 100, "SF15-T"),

                                        (203, 2013, 101, "VJM06"), -- // Sahara Force India \\
                                        (204, 2014, 101, "VJM07"),
                                        (205, 2015, 101, "VJM08"),

                                        (206, 2013, 102, "E21"), -- // Lotus Renault \\
                                        (207, 2014, 102, "E22"),
                                        (208, 2015, 102, "E23"),

                                        (209, 2013, 103, "MR02"), -- // Manor Marussia \\
                                        (210, 2014, 103, "MR03"),
                                        (211, 2015, 103, "MR03B"),

                                        (212, 2013, 104, "MP4-28"), -- // McLaren Honda \\
                                        (213, 2014, 104, "MP4-29"),
                                        (214, 2015, 104, "MP4-30"),

                                        (215, 2013, 105, "W04"), -- // Mercedes AMG Petronas \\
                                        (216, 2014, 105, "W05"),
                                        (217, 2015, 105, "W06"),

                                        (218, 2013, 106, "RB9"), -- // Red Bull \\
                                        (219, 2014, 106, "RB10"),
                                        (220, 2015, 106, "RB11"),

                                        (221, 2013, 107, "C32"), -- // Sauber \\
                                        (222, 2014, 107, "C33"),
                                        (223, 2015, 107, "C34"),

                                        (224, 2013, 108, "STR8"), -- // Scuderia Toro Rosso \\
                                        (225, 2014, 108, "STR9"),
                                        (226, 2015, 108, "STR10"),

                                        (227, 2013, 109, "FW35"), -- // Williams \\
                                        (228, 2014, 109, "FW36"),
                                        (229, 2015, 109, "FW37"),

                                        (230, 2013, 110, "CT03"), -- // Caterham Renault \\
                                        (231, 2014, 110, "CT05");
                          

INSERT INTO vozac_u_sezoni VALUES (7142, 7006, 218, 9002, 2013), -- // GODINA: 2013 \\
								          (7143, 7017, 218, 9003, 2013),
                                  (7144, 7007, 200, 9000, 2013),
                                  (7145, 7019, 200, 9001, 2013),
                                  (7146, 7020, 212, 9004, 2013),
                                  (7147, 7008, 212, 9005, 2013),
                                  (7148, 7009, 206, 9014, 2013),
                                  (7149, 7012, 206, 9015, 2013),
                                  (7150, 7001, 215, 9018, 2013),
                                  (7151, 7018, 215, 9019, 2013),
                                  (7152, 7021, 221, 9008, 2013),
                                  (7153, 7027, 221, 9009, 2013),
                                  (7154, 7022, 203, 9020, 2013),
                                  (7155, 7014, 203, 9021, 2013),
                                  (7156, 7003, 227, 9006, 2013),
                                  (7157, 7028, 227, 9007, 2013),
                                  (7158, 7010, 224, 9010, 2013),
                                  (7159, 7029, 224, 9011, 2013),
                                  (7160, 7025, 230, 9012, 2013),
                                  (7161, 7026, 230, 9013, 2013),
                                  (7162, 7024, 209, 9016, 2013),
                                  (7163, 7015, 209, 9017, 2013),

                                  (7120, 7030, 231, 9112, 2014), -- // GODINA: 2014 \\
                                  (7121, 7016, 231, 9113, 2014),
                                  (7122, 7009, 201, 9100, 2014),
                                  (7123, 7007, 201, 9101, 2014),
                                  (7124, 7008, 204, 9120, 2014),
                                  (7125, 7021, 204, 9121, 2014),
                                  (7126, 7012, 207, 9114, 2014),
                                  (7127, 7003, 207, 9115, 2014),
                                  (7128, 7015, 210, 9116, 2014),
                                  (7129, 7024, 210, 9117, 2014),
                                  (7130, 7031, 213, 9104, 2014),
                                  (7131, 7020, 213, 9105, 2014),
                                  (7132, 7001, 216, 9118, 2014),
                                  (7133, 7018, 216, 9119, 2014),
                                  (7134, 7006, 219, 9102, 2014),
                                  (7135, 7029, 219, 9103, 2014),
                                  (7136, 7027, 222, 9108, 2014),
                                  (7137, 7014, 222, 9109, 2014),
                                  (7138, 7026, 225, 9110, 2014),
                                  (7139, 7032, 225, 9111, 2014),
                                  (7140, 7019, 228, 9106, 2014),
                                  (7141, 7028, 228, 9107, 2014),

                                  (7100, 7000, 211, 9215, 2015), -- // GODINA: 2015 \\
                                  (7101, 7005, 211, 9214, 2015),
                                  (7102, 7012, 208, 9212, 2015),
                                  (7103, 7003, 208, 9213, 2015),
                                  (7104, 7001, 217, 9216, 2015),
                                  (7105, 7018, 217, 9217, 2015),
                                  (7106, 7030, 223, 9208, 2015),
                                  (7107, 7002, 223, 9209, 2015),
                                  (7108, 7006, 202, 9200, 2015),
                                  (7109, 7009, 202, 9201, 2015),
                                  (7110, 7007, 214, 9204, 2015),
                                  (7111, 7020, 214, 9205, 2015),
                                  (7112, 7008, 205, 9218, 2015),
                                  (7113, 7021, 205, 9219, 2015),
                                  (7114, 7019, 229, 9206, 2015),
                                  (7115, 7028, 229, 9207, 2015),
                                  (7116, 7029, 220, 9202, 2015),
                                  (7117, 7032, 220, 9003, 2015),
                                  (7118, 7033, 226, 9210, 2015),
                                  (7119, 7034, 226, 9211, 2015);


INSERT INTO sponzor_u_sezoni VALUES (5000, 4010, 200, 78000000, "Suradnik", 2013), -- // GODINA: 2013 \\
                                    (5001, 4007, 200, 81000000, "Suradnik", 2013),
                                    (5002, 4044, 200, 55000000, "Suradnik", 2013),
                                    (5003, 4063, 203, 122000000, "Sponzor imena", 2013),_test
                                    (5004, 4082, 203, 22000000, "Suradnik", 2013),
                                    (5005, 4065, 203, 73000000, "Suradnik", 2013),
                                    (5006, 4027, 206, 33000000, "Suradnik", 2013),
                                    (5007, 4024, 206, 17000000, "Suradnik", 2013),
                                    (5008, 4048, 206, 67000000, "Suradnik", 2013),
                                    (5009, 4059, 209, 119200000, "Sponzor imena", 2013),
                                    (5010, 4077, 209, 35000000, "Suradnik", 2013),
                                    (5011, 4062, 209, 19000000, "Suradnik", 2013),
                                    (5012, 4066, 212, 179000000, "Sponzor imena", 2013),
                                    (5013, 4069, 212, 33990000, "Suradnik", 2013),
                                    (5014, 4072, 212, 79000000, "Suradnik", 2013),
                                    (5015, 4001, 215, 163750300, "Sponzor imena", 2013),
                                    (5016, 4021, 215, 67000100, "Suradnik", 2013),
                                    (5017, 4035, 215, 39000000, "Suradnik", 2013),
                                    (5018, 4033, 218, 127000000, "Sponzor imena", 2013),
                                    (5019, 4006, 218, 56000000, "Suradnik", 2013),
                                    (5020, 4051, 218, 78000000, "Suradnik", 2013),
                                    (5021, 4072, 221, 40000000, "Suradnik", 2013),
                                    (5022, 4073, 221, 31000000, "Suradnik", 2013),
                                    (5023, 4071, 221, 76000000, "Suradnik", 2013),
                                    (5024, 4049, 224, 67000000, "Suradnik", 2013),
                                    (5025, 4025, 224, 31000000, "Suradnik", 2013),
                                    (5027, 4029, 227, 56000000, "Suradnik", 2013),
                                    (5028, 4075, 227, 13000000, "Suradnik", 2013),
                                    (5030, 4055, 230, 63000000, "Suradnik", 2013),
                                    (5031, 4012, 230, 35000000, "Suradnik", 2013),
                                    (5032, 4075, 230, 34000000, "Suradnik", 2013),
                                    
                                    (5100, 4007, 201, 60000000, "Suradnik", 2014), -- // GODINA: 2014 \\
                                    (5101, 4044, 201, 18000000, "Suradnik", 2014),
                                    (5102, 4008, 201, 65000000, "Suradnik", 2014),
                                    (5103, 4063, 204, 150000000, "Sponzor imena", 2014),
                                    (5104, 4065, 204, 26000000, "Suradnik", 2014),
                                    (5105, 4072, 204, 73500000, "Suradnik", 2014),
                                    (5106, 4027, 207, 63000000, "Suradnik", 2014),
                                    (5107, 4048, 207, 9000000, "Suradnik", 2014),
                                    (5108, 4075, 207, 43000000, "Suradnik", 2014),
                                    (5109, 4059, 210, 97560300, "Sponzor imena", 2014),
                                    (5110, 4062, 210, 33000000, "Suradnik", 2014),
                                    (5111, 4060, 210, 61000000, "Suradnik", 2014),
                                    (5112, 4022, 213, 110000000, "Sponzor imena", 2014),
                                    (5113, 4069, 213, 34000000, "Suradnik", 2014),
                                    (5114, 4050, 213, 44000000, "Suradnik", 2014),
                                    (5115, 4001, 216, 75000000, "Sponzor imena", 2014),
                                    (5116, 4016, 216, 12400000, "Suradnik", 2014),
                                    (5117, 4078, 216, 110000000, "Suradnik", 2014),
                                    (5118, 4033, 219, 69000000, "Sponzor imena", 2014),
                                    (5119, 4043, 219, 24000000, "Suradnik", 2014),
                                    (5120, 4051, 219, 87000000, "Suradnik", 2014),
                                    (5121, 4070, 222, 49000000, "Suradnik", 2014),
                                    (5122, 4071, 222, 67000000, "Suradnik", 2014),
                                    (5123, 4074, 222, 44000000, "Suradnik", 2014),
                                    (5124, 4049, 225, 63000000, "Suradnik", 2014),
                                    (5125, 4025, 225, 51000000, "Suradnik", 2014),
                                    (5126, 4075, 225, 40000000, "Suradnik", 2014),
                                    (5127, 4047, 228, 113000430, "Sponzor imena", 2014),
                                    (5128, 4048, 228, 23000000, "Suradnik", 2014),
                                    (5129, 4076, 228, 89000000, "Suradnik", 2014),
                                    (5130, 4012, 231, 23000000, "Suradnik", 2014),
                                    (5131, 4055, 231, 14000000, "Suradnik", 2014),
                                    (5132, 4075, 231, 36000000, "Suradnik", 2014),

                                    (5200, 4008, 202, 65000000, "Suradnik", 2015),  -- // GODINA: 2015 \\
                                    (5201, 4044, 202, 23000000, "Suradnik", 2015),
                                    (5202, 4070, 202, 51400000, "Suradnik", 2015),
                                    (5203, 4079, 205, 30000000, "Suradnik", 2015),
                                    (5204, 4038, 205, 43000000, "Suradnik", 2015),
                                    (5205, 4063, 205, 95000000, "Sponzor imena", 2015),
                                    (5206, 4040, 208, 33000000, "Suradnik", 2015),
                                    (5209, 4080, 211, 86000000, "Sponzor imena", 2015),
                                    (5210, 4081, 211, 15000000, "Suradnik", 2015),
                                    (5212, 4022, 214, 110000000, "Sponzor imena", 2015),
                                    (5213, 4069, 214, 46000000, "Suradnik", 2015),
                                    (5214, 4050, 214, 20000000, "Suradnik", 2015),
                                    (5215, 4001, 217, 150000000, "Sponzor imena", 2015),
                                    (5216, 4035, 217, 32000000, "Suradnik", 2015),
                                    (5217, 4067, 217, 62000000, "Suradnik", 2015),
                                    (5218, 4033, 220, 112340000, "Sponzor imena", 2015),
                                    (5219, 4052, 220, 23000000, "Suradnik", 2015),
                                    (5220, 4006, 220, 30000000, "Suradnik", 2015),
                                    (5221, 4070, 223, 50000000, "Suradnik", 2015),
                                    (5222, 4071, 223, 31000000, "Suradnik", 2015),
                                    (5223, 4074, 223, 43000000, "Suradnik", 2015),
                                    (5224, 4049, 226, 71000000, "Suradnik", 2015),
                                    (5225, 4025, 226, 49000000, "Suradnik", 2015),
                                    (5226, 4075, 226, 43000000, "Suradnik", 2015),
                                    (5227, 4029, 229, 34000000, "Suradnik", 2015),
                                    (5228, 4047, 229, 61000000, "Sponzor imena", 2015),
                                    (5229, 4028, 229, 49000000, "Suradnik", 2015);


INSERT INTO vikend VALUES (8000, STR_TO_DATE("15.03.2013.", "%d.%m.%Y."), STR_TO_DATE("17.03.2013.", "%d.%m.%Y."), 1003, 20133101, 30133101, 3101, 2013), -- // GODINA: 2013 \\
                          (8001, STR_TO_DATE("22.03.2013.", "%d.%m.%Y."), STR_TO_DATE("24.03.2013.", "%d.%m.%Y."), 1031, 20133102, 30133102, 3102, 2013),
                          (8002, STR_TO_DATE("12.04.2013.", "%d.%m.%Y."), STR_TO_DATE("14.04.2013.", "%d.%m.%Y."), 1030, 20133103, 30133103, 3103, 2013),
                          (8003, STR_TO_DATE("19.04.2013.", "%d.%m.%Y."), STR_TO_DATE("21.04.2013.", "%d.%m.%Y."), 1001, 20133104, 30133104, 3104, 2013),
                          (8004, STR_TO_DATE("24.05.2013.", "%d.%m.%Y."), STR_TO_DATE("26.05.2013.", "%d.%m.%Y."), 1007, 20133105, 30133105, 3105, 2013),
                          (8005, STR_TO_DATE("07.06.2013.", "%d.%m.%Y."), STR_TO_DATE("09.06.2013.", "%d.%m.%Y."), 1009, 20133106, 30133106, 3106, 2013),
                          (8006, STR_TO_DATE("28.06.2013.", "%d.%m.%Y."), STR_TO_DATE("30.06.2013.", "%d.%m.%Y."), 1010, 20133107, 30133107, 3107, 2013),
                          (8007, STR_TO_DATE("05.07.2013.", "%d.%m.%Y."), STR_TO_DATE("07.07.2013.", "%d.%m.%Y."), 1027, 20133108, 30133108, 3108, 2013),
                          (8008, STR_TO_DATE("20.09.2013.", "%d.%m.%Y."), STR_TO_DATE("22.09.2013.", "%d.%m.%Y."), 1018, 20133109, 30133109, 3109, 2013),
                          (8009, STR_TO_DATE("11.10.2013.", "%d.%m.%Y."), STR_TO_DATE("13.10.2013.", "%d.%m.%Y."), 1019, 20133110, 30133110, 3110, 2013),
                          (8010, STR_TO_DATE("25.10.2013.", "%d.%m.%Y."), STR_TO_DATE("27.10.2013.", "%d.%m.%Y."), 1033, 20133111, 30133111, 3111, 2013),
                          (8011, STR_TO_DATE("01.11.2013.", "%d.%m.%Y."), STR_TO_DATE("03.11.2013.", "%d.%m.%Y."), 1023, 20133112, 30133112, 3112, 2013),
                          (8012, STR_TO_DATE("22.11.2013.", "%d.%m.%Y."), STR_TO_DATE("24.11.2013.", "%d.%m.%Y."), 1022, 20133113, 30133113, 3113, 2013),

                          (8013, STR_TO_DATE("14.03.2014.", "%d.%m.%Y."), STR_TO_DATE("16.03.2014.", "%d.%m.%Y."), 1003, 20143200, 30143200, 3200, 2014), -- // GODINA: 2014 \\
                          (8014, STR_TO_DATE("04.04.2014.", "%d.%m.%Y."), STR_TO_DATE("06.04.2014.", "%d.%m.%Y."), 1001, 20143201, 30143201, 3201, 2014),
                          (8015, STR_TO_DATE("18.04.2014.", "%d.%m.%Y."), STR_TO_DATE("20.04.2014.", "%d.%m.%Y."), 1030, 20143202, 30143202, 3202, 2014),
                          (8016, STR_TO_DATE("23.05.2014.", "%d.%m.%Y."), STR_TO_DATE("25.05.2014.", "%d.%m.%Y."), 1007, 20143203, 30143203, 3203, 2014),
                          (8017, STR_TO_DATE("20.06.2014.", "%d.%m.%Y."), STR_TO_DATE("22.06.2014.", "%d.%m.%Y."), 1011, 20143204, 30143204, 3204, 2014),
                          (8018, STR_TO_DATE("18.07.2014.", "%d.%m.%Y."), STR_TO_DATE("20.07.2014.", "%d.%m.%Y."), 1027, 20143205, 30143205, 3205, 2014),
                          (8019, STR_TO_DATE("22.08.2014.", "%d.%m.%Y."), STR_TO_DATE("24.08.2014.", "%d.%m.%Y."), 1014, 20143206, 30143206, 3206, 2014),
                          (8020, STR_TO_DATE("05.09.2014.", "%d.%m.%Y."), STR_TO_DATE("07.09.2014.", "%d.%m.%Y."), 1016, 20143207, 30143207, 3207, 2014),
                          (8021, STR_TO_DATE("19.09.2014.", "%d.%m.%Y."), STR_TO_DATE("21.09.2014.", "%d.%m.%Y."), 1018, 20143208, 30143208, 3208, 2014),
                          (8022, STR_TO_DATE("21.11.2014.", "%d.%m.%Y."), STR_TO_DATE("23.11.2014.", "%d.%m.%Y."), 1023, 20143209, 30143209, 3209, 2014),

                          (8023, STR_TO_DATE("13.03.2015.", "%d.%m.%Y."), STR_TO_DATE("15.03.2015.", "%d.%m.%Y."), 1003, 20153300, 30153300, 3300, 2015), -- // GODINA: 2015 \\
                          (8024, STR_TO_DATE("22.05.2015.", "%d.%m.%Y."), STR_TO_DATE("24.05.2015.", "%d.%m.%Y."), 1007, 20153301, 30153301, 3301, 2015),
                          (8025, STR_TO_DATE("05.06.2015.", "%d.%m.%Y."), STR_TO_DATE("07.06.2015.", "%d.%m.%Y."), 1009, 20153302, 30153302, 3302, 2015),
                          (8026, STR_TO_DATE("03.07.2015.", "%d.%m.%Y."), STR_TO_DATE("05.07.2015.", "%d.%m.%Y."), 1010, 20153303, 30153303, 3303, 2015),
                          (8027, STR_TO_DATE("21.08.2015.", "%d.%m.%Y."), STR_TO_DATE("23.08.2015.", "%d.%m.%Y."), 1014, 20153304, 30153304, 3304, 2015),
                          (8028, STR_TO_DATE("04.06.2015.", "%d.%m.%Y."), STR_TO_DATE("06.09.2015.", "%d.%m.%Y."), 1016, 20153305, 30153305, 3305, 2015),
                          (8029, STR_TO_DATE("18.09.2015.", "%d.%m.%Y."), STR_TO_DATE("20.09.2015.", "%d.%m.%Y."), 1018, 20153306, 30153306, 3306, 2015),
                          (8030, STR_TO_DATE("25.09.2015.", "%d.%m.%Y."), STR_TO_DATE("27.09.2015.", "%d.%m.%Y."), 1019, 20153307, 30153307, 3307, 2015),
                          (8031, STR_TO_DATE("13.11.2015.", "%d.%m.%Y."), STR_TO_DATE("15.11.2015.", "%d.%m.%Y."), 1022, 20153308, 30153308, 3308, 2015),
                          (8032, STR_TO_DATE("27.11.2015.", "%d.%m.%Y."), STR_TO_DATE("29.11.2015.", "%d.%m.%Y."), 1023, 20153309, 30153309, 3309, 2015);


-- UPITI
/* Navedite sponzora sa najviše isplaćenog novca(id_sponzor,isplacen_novac) */
SELECT sponzor.id, sus.id, sponzor.ime, sus.id_sezona, max(sus.isplacen_novac) AS najveca_isplata
   FROM sponzor, sponzor_u_sezoni AS sus;
   
/* Prikažite vrijeme najbržeg kruga utrke u sezoni 2013. godine. */
SELECT MIN(vozeno_vrijeme) AS prosjek
	FROM utrka_vrijeme
    WHERE id_utrka IN (SELECT v.id_utrka
		FROM vikend AS v
		INNER JOIN utrka AS u
		ON (u.id = v.id_utrka)
		WHERE id_sezona = 2013);

/* Nađite prosjek trajanja kruga u 2014. godini. */
SELECT SEC_TO_TIME(AVG(TIME_TO_SEC(vozeno_vrijeme))) AS prosjek
	FROM utrka_vrijeme
    WHERE id_utrka IN (SELECT v.id_utrka
		FROM vikend AS v
		INNER JOIN utrka AS u
		ON (u.id = v.id_utrka)
		WHERE id_sezona = 2014);

-- ILI --

SELECT SEC_TO_TIME(AVG(TIME_TO_SEC(vozeno_vrijeme))) AS prosjek
	FROM vikend AS v
    INNER JOIN utrka AS u ON (v.id_utrka = u.id)
		INNER JOIN utrka_vrijeme AS uv ON (u.id = uv.id_utrka)
	WHERE id_sezona = 2014;


/* Ispišite tim koji ima najmanje sponzora. */
SELECT COUNT(id_sponzor) AS kolicina_sponzora, id_sponzor
	FROM sponzor_u_sezoni AS ss
    INNER JOIN konstruktor_u_sezoni AS ks ON (ks.id = ss.id_kus)
    GROUP BY id_tim
    ORDER BY kolicina_sponzora ASC
    LIMIT 1;


/* Ispišite koliko je prosjek broja sponzora po timu. */
SELECT AVG(k.kolicina_sponzora) AS prosjek
		FROM (SELECT COUNT(id_sponzor) AS kolicina_sponzora, id_sponzor
			FROM sponzor_u_sezoni AS ss
			INNER JOIN konstruktor_u_sezoni AS ks ON (ks.id = ss.id_kus)
			GROUP BY id_tim
			ORDER BY kolicina_sponzora) AS k;
            
            
/* Popis staza i najbrze vrijeme na stazi */
SELECT s.ime_staze, MIN(vozeno_vrijeme) AS vrijeme
	FROM staza AS s
		INNER JOIN vikend AS v ON (s.id = v.id_staza)
			INNER JOIN utrka AS u ON (u.id = v.id_utrka)
				INNER JOIN utrka_vrijeme AS uv ON ( uv.id_utrka = u.id)
	GROUP BY s.ime_staze;


/* Staza sa najbrzim vremenom */
SELECT s.ime_staze, MIN(vozeno_vrijeme) AS vrijeme
	FROM staza AS s
		INNER JOIN vikend AS v ON (s.id = v.id_staza)
			INNER JOIN utrka AS u ON (u.id = v.id_utrka)
				INNER JOIN utrka_vrijeme AS uv ON (uv.id_utrka = u.id)
	GROUP BY s.ime_staze
    ORDER BY vrijeme
    LIMIT 1;


/* Ispišite average osvojeno_bodova za svaki tim u svakoj godini. */


/* Ispišite najviše osvojeno_bodova za svaki tim u svakoj godini. */


/* Ispis svih vozaca koji imaju preko x pobjeda. */


/* Top 3 najuspijesnije momcadi */


/* Driver championship (neka bude pogled view) */


/* Constructor championship Gdje je bila najmanja razlika izmedu bodova (tesko, mozda se nezna) */


/* Vjv da dodes 1. A bio si u pol positionu (br pobjeda sa br pol pozitiona se dijele) postotak kolikl ima sanse da budes prvi */


/* Ko je pobjednik 2014. sezone */


/* Ispišite tim koji ima najviše pobjeda. */