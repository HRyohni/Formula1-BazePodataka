DROP DATABASE IF EXISTS Formula1;

CREATE DATABASE Formula1;
USE Formula1;

CREATE TABLE tim(
   id INTEGER PRIMARY KEY,
   naziv VARCHAR(50),
   voditelj VARCHAR(50),
   sjediste VARCHAR(50) NOT NULL
);

CREATE TABLE konstruktor_u_sezoni(
   id INTEGER PRIMARY KEY,
   id_sezona INTEGER,
   id_tim INTEGER,
   kod_sasija VARCHAR(10),
   osvojeno_bodova INTEGER, /* <- kao konstruktor */
   osvojeno_podija INTEGER, /* <- kao konstruktor */
   osvojeno_naslova INTEGER, /* <- kao konstruktor */
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

CREATE TABLE vozac_u_sezoni(
   id INTEGER PRIMARY KEY,
   id_vozac INTEGER,
   id_kus INTEGER,
   id_auto INTEGER,
   id_sezona INTEGER,
   osvojeno_bodova CHAR(5) NOT NULL,
   osvojeno_podija CHAR(5) NOT NULL,
   odvozeno_najbrzih_krugova INTEGER NOT NULL,
   FOREIGN KEY (id_kus) REFERENCES konstruktor_u_sezoni(id),
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

CREATE TABLE trening(
   id INTEGER PRIMARY KEY,
   krugova_vozeno CHAR(5) NOT NULL,
   FOREIGN KEY (id_vus) REFERENCES vozac_u_sezoni(id)
);

CREATE TABLE tren_vrijeme(
   id VARCHAR(9) PRIMARY KEY,
   id_tren FOREIGN KEY, /* <- integer??? */
   id_vus FOREIGN KEY,
   vozeno_vrijeme TIME,
   krug SMALLINT,
   FOREIGN KEY (id_vus) REFERENCES vozac_u_sezoni(id),
   FOREIGN KEY (id_tren) REFERENCES trening(id)
);

CREATE TABLE kvalifikacija(
   id INTEGER PRIMARY KEY,
   krugova_vozeno CHAR(5) NOT NULL,
   izlazaka_na_stazu CHAR(5) NOT NULL
);

CREATE TABLE kval_vrijeme(
   id VARCHAR(9) PRIMARY KEY,
   id_kval FOREIGN KEY,
   id_vus FOREIGN KEY,
   vozeno_vrijeme TIME,
   krug SMALLINT,
   FOREIGN KEY (id_vus) REFERENCES vozac_u_sezoni(id),
   FOREIGN KEY (id_kval) REFERENCES kvalifikacija(id)
);

CREATE TABLE utrka(
   id INTEGER PRIMARY KEY,
   ime_nagrade VARCHAR(30),
   broj_krugova INTEGER NOT NULL,
   FOREIGN KEY (pobjednik) REFERENCES vozac_u_sezoni(id)
);

CREATE TABLE utrka_vrijeme(
   id INTEGER PRIMARY KEY,
   id_utrka INTEGER,
   id_vus INTEGER,
   vozeno_vrijeme_str VARCHAR(30),
   krug SMALLINT
);

CREATE TABLE vikend(
   id INTEGER PRIMARY KEY,
   datum_pocetka DATE,
   datum_kraja DATE,
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

CREATE TABLE sezona(
   id INTEGER PRIMARY KEY,
   godina INTEGER
);

CREATE TABLE prvak(
   id INTEGER PRIMARY KEY,
   id_vozac_u_sezoni INTEGER, -- Vozač za tim
   id_tim INTEGER, -- Konstruktor
   id_sezona INTEGER
   FOREIGN KEY (id_vozac_u_sezoni) REFERENCES vozac_u_sezoni(id),
   FOREIGN KEY (id_tim) REFERENCES tim(id),
   FOREIGN KEY (id_sezona) REFERENCES sezona(id)
);


-- PROMJENE I OGRANIČENJA NA TABLICAMA
ALTER TABLE staza
	ADD CONSTRAINT id_len_ck_staza CHECK (length(id) = 4),
   ADD CONSTRAINT id_rng_ck_staza CHECK (id >= 1000 AND id < 2000),
   ADD CONSTRAINT duzina_rng_ck_staza CHECK (duzina_m >= 1000 AND duzina_m < 100000);
   
ALTER TABLE tim
	ADD CONSTRAINT id_len_ck_tim CHECK (length(id) = 3),
   ADD CONSTRAINT id_rng_ck_tim CHECK (id >= 100 AND id < 1000);

ALTER TABLE konstruktor_u_sezoni
   ADD CONSTRAINT id_len_ck_kus CHECK (length(id) = 3),
   ADD CONSTRAINT id_rng_ck_kus CHECK (id >= 200 AND id < 300);

ALTER TABLE sponzor
   ADD CONSTRAINT id_len_ck_sponzor CHECK (length(id) = 4),
   ADD CONSTRAINT id_rng_ck_sponzor CHECK (id >= 4000 AND id < 5000),
   ADD CONSTRAINT payout_ck_sponzor CHECK (isplacen_novac >= 500000);

ALTER TABLE utrka
   ADD CONSTRAINT id_len_ck_utrka CHECK (length(id) = 4),
   ADD CONSTRAINT id_rng_ck_utrka CHECK (id >= 3000 AND id < 3500);

ALTER TABLE vikend
   ADD CONSTRAINT id_len_ck_vikend CHECK (length(id) BETWEEN 1 AND 2),
   ADD CONSTRAINT id_rng_ck_vikend CHECK (id >= 10000 AND id < 20000);

ALTER TABLE automobil
   ADD CONSTRAINT id_len_ck_automobil CHECK (length(id) = 4),
   ADD CONSTRAINT id_rng_ck_automobil CHECK (id >= 9000 AND id < 10000);
   
ALTER TABLE vozac
   ADD CONSTRAINT id_len_ck_vozac CHECK (length(id) = 4),
   ADD CONSTRAINT id_rng_ck_vozac CHECK (id >= 7000 AND id < 7100);

ALTER TABLE vozac_u_sezoni
   ADD CONSTRAINT id_len_cek_vus CHECK (lenght(id) = 4),
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
INTO TABLE kval_vrijeme
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
                       (110, "Caterham F1 Team", "Cyril Abiteboul", "Leafield, Oxfordshire, United Kingdom"),


INSERT INTO konstruktor_u_sezoni VALUES (200, 2013, 100, "F138", 354, 10), -- // Scuderia Ferrari \\
                                        (201, 2014, 100, "F14 T", 216, 2),
                                        (202, 2015, 100, "SF15-T", 428, 16),

                                        (203, 2013, 101, "VJM06", 77, 0), -- // Sahara Force India \\
                                        (204, 2014, 101, "VJM07", 155, 1),
                                        (205, 2015, 101, "VJM08", 136, 1),

                                        (206, 2013, 102, "E21", 315, 14), -- // Lotus Renault \\
                                        (207, 2014, 102, "E22", 10, 0),
                                        (208, 2015, 102, "E23", 78, 1),

                                        (209, 2013, 103, "MR02", 0, 0), -- // Manor Marussia \\
                                        (210, 2014, 103, "MR03", 2, 0),
                                        (211, 2015, 103, "MR03B", 0, 0),

                                        (212, 2013, 104, "MP4-28", 122, 0), -- // McLaren Honda \\
                                        (213, 2014, 104, "MP4-29", 181, 2),
                                        (214, 2015, 104, "MP4-30", 27, 0),

                                        (215, 2013, 105, "W04", 360, 9), -- // Mercedes AMG Petronas \\
                                        (216, 2014, 105, "W05", 701, 31),
                                        (217, 2015, 105, "W06", 703, 32),

                                        (218, 2013, 106, "RB9", 596, 24), -- // Red Bull \\
                                        (219, 2014, 106, "RB10", 405, 12),
                                        (220, 2015, 106, "RB11", 187, 3),

                                        (221, 2013, 107, "C32", 57, 0), -- // Sauber \\
                                        (222, 2014, 107, "C33", 0, 0),
                                        (223, 2015, 107, "C34", 36, 0),

                                        (224, 2013, 108, "STR8", 33, 0), -- // Scuderia Toro Rosso \\
                                        (225, 2014, 108, "STR9", 30, 0),
                                        (226, 2015, 108, "STR10", 67, 0),

                                        (227, 2013, 109, "FW35", 5, 0), -- // Williams \\
                                        (228, 2014, 109, "FW36", 320, 9),
                                        (229, 2015, 109, "FW37", 257, 4),

                                        (230, 2013, 110, "CT03", 0, 0), -- // Caterham Renault \\
                                        (231, 2014, 110, "CT05", 0, 0);



INSERT INTO vozac VALUES (7000, "Roberto", "Merhi", 98,  STR_TO_DATE("22.3.1991.", "%d.%m.&Y."), "španjolsko"),
                         (7001, "Nico", "Rosberg", 6,  STR_TO_DATE("27.6.1985.", "%d.%m.&Y."), "njemačko"),
                         (7002, "Felipe", "Nasr", 12,  STR_TO_DATE("21.8.1992.", "%d.%m.&Y."), "brazilsko"),
                         (7003, "Pastor", "Maldonado", 13,  STR_TO_DATE("9.3.1985.", "%d.%m.&Y."), "venecuelansko"),
                         (7004, "Alexander", "Rossi", 53,  STR_TO_DATE("25.9.1991.", "%d.%m.&Y."), "američko"),
                         (7005, "Will", "Stevens", 28,  STR_TO_DATE("28.6.1991.", "%d.%m.&Y."), "britansko"),
                         (7006, "Sebastian", "Vettel", 5, STR_TO_DATE("03.07.1987.", "%d.%m.%Y."), "njemačko"),
                         (7007, "Fernando", "Alonso", 14, STR_TO_DATE("29.07.1981.", "%d.%m.%Y."), "španjolsko"),
                         (7008, "Sergio", "Pérez", 11, STR_TO_DATE("26.01.1990", "%d.%m.%Y."), "meksičko"),
                         (7009, "Kimi", "Räikkönen", 7, STR_TO_DATE("17.10.1979", "%d.%m.%Y."), "finsko"),
                         (7010, "Jean-Eric", "Vergne", 25,  STR_TO_DATE("25.4.1990.", "%d.%m.&Y."), " francukso"),
                         (7012, "Romain", "Grosjean", 8,  STR_TO_DATE("17.4.1986.", "%d.%m.&Y."), " francusko"),
                         (7013, "Jules", "Bianchi", 17,  STR_TO_DATE("3.8.1989.", "%d.%m.&Y."), "francusko"),
                         (7014, "Adrian", "Sutil", 99,  STR_TO_DATE("11.1.1983."), "njemačko"),
                         (7015, "Max", "Chilton", 4,  STR_TO_DATE("21.4.1991.", "%d.%m.&Y.") "britansko"),
                         (7016, "Kamui", "Kobayashi", 10,  STR_TO_DATE("13.9.1986.", "%d.%m.&Y.") "japansko"),
                         (7017, "Mark", "Webber", 17, STR_TO_DATE("27.8.1976.", "%d.%m.&Y."), "australsko"),
                         (7018, "Lewis", "Hamilton", 44, STR_TO_DATE("07.01.1985.", "%d.%m.&Y."), "britansko"),
                         (7019, "Felipe", "Massa", 19, STR_TO_DATE("25.4.1981.", "%d.%m.&Y."), "brazilsko"),
                         (7020, "Jenson", "Button", 22, STR_TO_DATE("19.1.1980.", "%d.%m.&Y."), "britansko"),
                         (7021, "Nico", "Hülkenberg", 27, STR_TO_DATE("19.8.1987.", "%d.%m.&Y."), "njemačko"),
                         (7022, "Paul", "di Resta", 40, STR_TO_DATE("16.4.1986.", "%d.%m.&Y."), "britansko"),
                         (7024, "Jules", "Bianchi", 17, STR_TO_DATE("3.8.1989.", "%d.%m.&Y."), "francusko"),
                         (7025, "Charles", "Pic", 99, STR_TO_DATE("15.2.1990.", "%d.%m.&Y."), "francusko"),
                         (7026, "Giedo", "van der Garde", 21, STR_TO_DATE("25.4.1985.", "%d.%m.&Y."), "nizozemsko"),
                         (7027, "Esteban", "Gutiérrez", 21, STR_TO_DATE("05.08.1991.", "%d.%m.%Y."), "meksičko"),
                         (7028, "Valtteri", "Bottas", 77, STR_TO_DATE("28.08.1989", "%d.%m.%Y."), "finsko"),
                         (7029, "Daniel", "Ricciardo", 3, STR_TO_DATE("01.07.1989.", "%d.%m.%Y."), "autstralsko"),
                         (7030, "Marcus", "Ericsson", 9, STR_TO_DATE("02.09.1990.", "%d.%m.%Y."), "švedsko"),
                         (7031, "Kevin", "Magnussen", 20, STR_TO_DATE("05.10.1992.", "%d.%m.%Y."), "dansko"),
                         (7032, "Daniil", "Kvyat", 26, STR_TO_DATE("26.04.1994.", "%d.%m.%Y."), "rusko"),
                         (7033, "Max", "Verstappen", 33, STR_TO_DATE("30.09.1997.", "%d.%m.%Y."), "nizozemsko"),
                         (7034, "Carlos", "Sainz", 55, STR_TO_DATE("01.09.1994.", "%d.%m.%Y."), "španjolsko");

INSERT INTO vozac_u_sezoni (7142, 7006, 218, 9002, 2013, 16, 397, 7), -- // GODINA: 2013 \\
                           (7143, 7017, 218, 9003, 2013, 8, 199, 5),
                           (7144, 7007, 200, 9000, 2013, 9, 242, 2),
                           (7145, 7019, 200, 9001, 2013, 1, 112, 0),
                           (7146, 7020, 212, 9004, 2013, 0, 73, 0),
                           (7147, 7008, 212, 9005, 2013, 0, 49, 1),
                           (7148, 7009, 206, 9014, 2013, 8, 183, 2),
                           (7149, 7012, 206, 9015, 2013, 6, 132, 0),
                           (7150, 7001, 215, 9018, 2013, 4, 171, 0),
                           (7151, 7018, 215, 9019, 2013, 5, 189, 1),
                           (7152, 7021, 221, 9008, 2013, 0, 54, 0),
                           (7153, 7027, 221, 9009, 2013, 0, 6, 1),
                           (7154, 7022, 203, 9020, 2013, 0, 48, 0),
                           (7155, 7014, 203, 9021, 2013, 0, 29, 0),
                           (7156, 7003, 227, 9006, 2013, 0, 4, 0),
                           (7157, 7028, 227, 9007, 2013, 0, 1, 0),
                           (7158, 7010, 224, 9010, 2013, 0, 13, 0),
                           (7159, 7029, 224, 9011, 2013, 0, 20, 0),
                           (7160, 7025, 230, 9012, 2013, 0, 0, 0),
                           (7161, 7026, 230, 9013, 2013, 0, 0, 0),
                           (7162, 7024, 209, 9016, 2013, 0, 0, 0),
                           (7163, 7015, 209, 9017, 2013, 0, 0, 0);

                           (7120, 7030, 231, 9112, 2014, 0, 0, 0), -- // GODINA: 2014 \\
                           (7121, 7016, 231, 9113, 2014, 0, 0, 0),
                           (7122, 7009, 201, 9100, 2014, 0, 55, 1),
                           (7123, 7007, 201, 9101, 2014, 2, 161, 0),
                           (7124, 7008, 204, 9120, 2014, 1, 59, 1),
                           (7125, 7021, 204, 9121, 2014, 0, 96, 0),
                           (7126, 7012, 207, 9114, 2014, 0, 8, 0),
                           (7127, 7003, 207, 9115, 2014, 0, 2, 0),
                           (7128, 7015, 210, 9116, 2014, 0, 0, 0),
                           (7129, 7024, 210, 9117, 2014, 0, 2, 0),
                           (7130, 7031, 213, 9104, 2014, 1, 55, 0),
                           (7131, 7020, 213, 9105, 2014, 1, 126, 0),
                           (7132, 7001, 216, 9118, 2014, 15, 317, 5),
                           (7133, 7018, 216, 9119, 2014, 16, 384, 7),
                           (7134, 7006, 219, 9102, 2014, 4, 167, 2),
                           (7135, 7029, 219, 9103, 2014, 8, 238, 1),
                           (7136, 7027, 222, 9108, 2014, 0, 0, 0),
                           (7137, 7014, 222, 9109, 2014, 0, 0, 0),
                           (7138, 7026, 225, 9110, 2014, 0, 22, 0),
                           (7139, 7032, 225, 9111, 2014, 0, 8, 0),
                           (7140, 7019, 228, 9106, 2014, 3, 134, 1),
                           (7141, 7028, 228, 9107, 2014, 6, 186, 1),

                           (7100, 7000, 211, 9215, 2015, 0, 0, 0), -- // GODINA: 2015 \\
                           (7101, 7005, 211, 9214, 2015, 0, 0, 0),
                           (7102, 7012, 208, 9212, 2015, 1, 51, 0),
                           (7103, 7003, 208, 9213, 2015, 0, 27, 0),
                           (7104, 7001, 217, 9216, 2015, 15, 322, 5),
                           (7105, 7018, 217, 9217, 2015, 17, 381, 8),
                           (7106, 7030, 223, 9208, 2015, 0, 9, 0),
                           (7107, 7002, 223, 9209, 2015, 0, 27, 0),
                           (7108, 7006, 202, 9200, 2015, 13, 278, 1),
                           (7109, 7009, 202, 9201, 2015, 3, 150, 2),
                           (7110, 7007, 214, 9204, 2015, 0, 11, 0),
                           (7111, 7020, 214, 9205, 2015, 0, 16, 0),
                           (7112, 7008, 205, 9218, 2015, 1, 78, 0),
                           (7113, 7021, 205, 9219, 2015, 0, 58, 0),
                           (7114, 7019, 229, 9206, 2015, 2, 121, 0),
                           (7115, 7028, 229, 9207, 2015, 2, 136, 0),
                           (7116, 7029, 220, 9202, 2015, 2, 92, 3),
                           (7117, 7032, 220, 9003, 2015, 1, 95, 0),
                           (7118, 7033, 226, 9210, 2015, 0, 49, 0),
                           (7119, 7034, 226, 9211, 2015, 0, 18, 0),


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
                             (9219, "Force India VJM08 n.2", "1.6L TC V6 Hybrid", "Pirelli"),     


-- SPONZORI // LISTA JE SMANJENA ZBOG OGROMNE KOLIČINE PODATAKA GLEDAJUĆI DA SVAKI TIM IMA PO MINIMALNO 20 SPONZORA.
INSERT INTO sponzor VALUES (4001, "Petronas", 100000000),
                           (4002, "Tommy Hilfiger", 24000000),
                           (4003, "Monster Energy",56000000),
                           (4004, "Oracle", 96500000),
                           -- (4005, "Cash App", 76000000),
                           (4006, "AT&T", 23760000),
                           (4007, "Shell", 136758000),
                           (4008, "Santander", 12000000),
                           -- (4009, "VELAS", 57000000),
                           -- (4010, "Snapdragon", 9000000),
                           (4011, "Google", 194986000),
                           (4012, "Dell", 29000000),
                           (4013, "Alienware", 19000000),
                           (4014, "Logitech G", 38760000),
                           -- (4015, "SunGod", 560000),
                           -- (4016, "BWT", 112000000),
                           (4017, "RCI Bank and Services", 98760000),
                           (4018, "Yahoo", 56000000),
                           (4019, "Kappa", 780000),
                           (4020, "Sprinklr", 520000),
                           -- (4021, "AlphaTauri", 230670000),
                           (4022, "Honda", 73187500),
                           (4023, "Pirelli", 4167940000),
                           -- (4024, "Ray Ban", 10000000),
                           (4025, "Siemens", 13000000),
                           (4026, "Aramco", 79000000),
                           -- (4027, "TikTok", 20000000),
                           (4028, "Hackett London",6780000),
                           -- (4029, "Lavazza", 30000000),
                           (4030, "DURACELL", 24000000),
                           -- (4031, "Acronis", 53000000),
                           -- (4032, "Alfa Romeo", 45600000),
                           -- (4033, "PKN ORLEN", 39876500),
                           (4034, "Iveco", 12000000),
                           (4035, "Puma", 40123000),
                           (4036, "Haas Automation", 36000000),
                           (4037, "Maui Jim", 980760),
                           (4038, "Alpinestars", 63000000),
                           (4039, "TeamViewer", 5000000),
                           (4040, "Richard Mille", 16400300),
                           (4041, "Police", 5600000),
                           (4042, "Philip Morris International", 13873900),
                           (4043, "Rauch", 97655980),
                           (4044, "UPS", 37000000),
                           (4045, "Dupont", 19050000),
                           (4046, "Marlboro", 160753100),
                           (4047, "Martini", 75000000),
                           (4048, "Rexona", 80000000),
                           (4049, "NOVA Chemicals", 93000000),
                           (4050, "TAGHeuer", 60000000);
                           -- Ugašeni neki noviji sponzori (potrebna provjera)

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
                         (1023, "Autodromo do Algarve", "Portimão, Portugal", 4653, 2),
                         (1025, "Losail International Circuit", "Lusail, Qatar", 5380, 1),
                         (1027, "Nürburgring", "Nürburg, Germany", 5148, 2),
                         (1029, "Hockenheimring", "Hockenheim, Germany", 4574, 2),
                         (1030, "Shanghai International Circuit", "Shanghai, China", 5451, 2),
                         (1031, "Sepang International Circuit", "Sepang, Malaysia", 5543, 2),
                         (1032, "Korean International Circuit", "Yeongam, South Korea", 5615, 2),
                         (1033, "Buddh International Circuit", "Greater Noida, India", 5125, 2),
                         (1034, "Valencia Street Circuit", "Valencia, Spain", 5419, 2);


INSERT INTO trening VALUES ("2013-T3101"), -- // GODINA: 2013 \\
                           ("2013-T3102"),
                           ("2013-T3103"),
                           ("2013-T3104"),
                           ("2013-T3105"),
                           ("2013-T3106"),
                           ("2013-T3107"),
                           ("2013-T3108"),
                           ("2013-T3109"),
                           ("2013-T3110"),
                           ("2013-T3111"),
                           ("2013-T3112"),
                           ("2013-T3113"),

                           ("2014-T3200"), -- // GODINA: 2014 \\
                           ("2014-T3201"),
                           ("2014-T3202"),
                           ("2014-T3203"),
                           ("2014-T3204"),
                           ("2014-T3205"),
                           ("2014-T3206"),
                           ("2014-T3207"),
                           ("2014-T3208"),
                           ("2014-T3209"),

                           ("2015-T3300"), -- // GODINA: 2015 \\
                           ("2015-T3301"),
                           ("2015-T3302"),
                           ("2015-T3303"),
                           ("2015-T3304"),
                           ("2015-T3305"),
                           ("2015-T3306"),
                           ("2015-T3307"),
                           ("2015-T3308"),
                           ("2015-T3309");
                             

INSERT INTO kvalifikacija VALUES ("2013-Q3101"), -- // GODINA: 2013 \\
                                 ("2013-Q3102"),
                                 ("2013-Q3103"),
                                 ("2013-Q3104"),
                                 ("2013-Q3105"),
                                 ("2013-Q3106"),
                                 ("2013-Q3107"),
                                 ("2013-Q3108"),
                                 ("2013-Q3109"),
                                 ("2013-Q3110"),
                                 ("2013-Q3111"),
                                 ("2013-Q3112"),
                                 ("2013-Q3113"),

                                 ("2014-Q3200"), -- // GODINA: 2014 \\
                                 ("2014-Q3201"),
                                 ("2014-Q3202"),
                                 ("2014-Q3203"),
                                 ("2014-Q3204"),
                                 ("2014-Q3205"),
                                 ("2014-Q3206"),
                                 ("2014-Q3207"),
                                 ("2014-Q3208"),
                                 ("2014-Q3209"),

                                 ("2015-Q3300"), -- // GODINA: 2015 \\
                                 ("2015-Q3301"),
                                 ("2015-Q3302"),
                                 ("2015-Q3303"),
                                 ("2015-Q3304"),
                                 ("2015-Q3305"),
                                 ("2015-Q3306"),
                                 ("2015-Q3307"),
                                 ("2015-Q3308"),
                                 ("2015-Q3309");



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
                         (3112, "Etihad Airways Abu Dhabi Grand Prix", 55),
                         (3113, "42° Grande Prêmio do Brasil", 71),

                         (3200, "Rolex Australian Grand Prix 2014", 57,), -- // GODINA: 2014 \\
                         (3201, "Gulf Air Bahrain Grand Prix 2014", 57,),
                         (3202, "UBS Chinese Grand Prix 2014", 54,),
                         (3203, "72eme Gran Prix de Monaco", 78),
                         (3204, "Großer Preis von Österreich", 71),
                         (3205, "Grosser Preis Santander von Deutschland 2014", 67),
                         (3206, "Shell Belgian Grand Prix 2014", 44,),
                         (3207, "85° Gran Premio d'Italia", 53,),
                         (3208, "Singapore Airlines Singapore Grand Prix 2014", 60,),
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
                         (3309, "Etihad Airways Abu Dhabi Grand Prix", 55);


INSERT INTO sezona VALUES (id_sezona, godina),
                          (2013, 2013),
                          (2014, 2014),
                          (2015, 2015);
