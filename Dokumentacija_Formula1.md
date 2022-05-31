Sveučilište Jurja Dobrile u Puli

Fakultet informatike u Puli



![Sveučilište Jurja Dobrile u Puli – Wikipedija](https://cdn.discordapp.com/attachments/759467826440044585/981096052390244352/170px-Unipu-logo-lat.png)







Dokumentacija uz projektni zadatak

Formula1

Tim 3

Izradili: Leo Matošević, Mateo Kocev, Stevan Čorak, Filippo Bubić, Jan Božac

Studijski smjer: Informatika

Kolegij: Baza podataka I

Mentor: doc. dr. sc. Goran Oreški







 Sadržaj

[TOC]





## Uvod

 U priloženoj dokumentaciji prezentirat ćemo naš projektni zadatak iz kolegija Baze podataka 1. Tema projekta je baze podataka Formule 1. Kao prvi korak izrade baze podataka došli smo do zaključka da ćemo koristit podatke iz: 2013, 2014 i 2015 sezone Formule 1. Temeljni razlog je da limitiramo količinu podataka koje ćemo upisivat unutar naše baze podataka. Nakon ograničenja raspona sezona kreirali smo osnovne relacije koju se se naknadno mijenjale kroz izradu projekta. 

Cilj naše baze podataka je prikazat pojednostavljenu statistiku Formule 1. Prikazujemo najosnovnije podatke vezano uz svaki *tim*, *vozača*, *sponzora* itd. unutar pojedinih *sezona*, unatoč našoj namjeri da stvorimo pojednostavljenu bazu podataka naišli smo do problema pri upisivanju brzine svakog odvoženog kruga vozača unutar svake utrke, naime količina podataka koju smo trebali sami zapisat je bila prevelika te smo si olakšali rad pomoću generatora informacija u obliku *python* koda koji ćemo objasnit naknadno u dokumentaciji. Zbog već navedenih problema odlučili smo blago napustit podatke iz pravog svijeta, ali ne i generalnu realističnost projekta.  







## Relacije, atributi, domene i ograničenja

### Relacija *tim*

Relacija tim se sastoji od sljedećih atributa:

- **id** podatak tipa *integer*, koji je primarni ključ unutar relacije  

- **naziv** podatak tipa *varchar* koji je limitiran na 50 znakova, ograničen je pomoću naredbe *unique* kako ne bi imali dva tima s istim nazivom 

- **voditelj** podatak tipa varchar koji je limitiran na 50 znakova 

- **sjediste** podatak tipa varchar koji je limitiran na 50 znakova

Ograničenje ***not null*** označava da podatak ne smije biti ***null*** tip podatka.

```mysql
CREATE TABLE tim(
   id INTEGER PRIMARY KEY,
   naziv VARCHAR(50) NOT NULL UNIQUE,
   voditelj VARCHAR(50) NOT NULL,
   sjediste VARCHAR(50) NOT NULL
    
);
```



### Relacija sezona

Relacija sezona se sastoji od sljedećih atributa:

- **id** podatak tipa *integer*, koji je primarni ključ unutar relacije  

- **godina** podatak tipa *integer* 

Ograničenje ***not null*** označava da podatak ne smije biti ***null*** tip podatka. 

```mysql
CREATE TABLE sezona(
   id INTEGER PRIMARY KEY,
   godina INTEGER NOT NULL
    
);
```





### Relacija konstruktor_u_sezoni

Relacija konstruktor_u_sezoni se sastoji od sljedećih atributa: 

- **id** podatak tipa *integer*, koji je primarni ključ unutar relacije  

- **id_sezona** podatak tipa *integer*, to je strani ključ iz relacije **sezona** 

- **id_tim** podatak tipa *integer*, to je strani ključ iz relacije **tim**

- **kod_sasija** podatak tipa *varchar* koji je limitiran na 10 znakova, ograničen je pomoću naredbe *unique* kako ne bi imali dvije šasije s istim nazivom

Ograničenje ***not null*** označava da podatak ne smije biti ***null*** tip podatka.

```mysql
CREATE TABLE konstruktor_u_sezoni(
   id INTEGER PRIMARY KEY,
   id_sezona INTEGER,
   id_tim INTEGER,
   kod_sasija VARCHAR(10) NOT NULL UNIQUE,
   FOREIGN KEY (id_tim) REFERENCES tim(id),
   FOREIGN KEY (id_sezona) REFERENCES sezona(id)
    
);
```



### Relacija vozac 

Relacija vozac se sastoji od sljedećih atributa:

- **id** podatak tipa *integer*, koji je primarni ključ unutar relacije  

- **ime** podatak tipa *varchar* koji je limitiran na 30 znakova

- **prezime** podatak tipa *varchar* koji je limitiran na 30 znakova 

- **odabrani_broj** podatak tipa *smallint* koji prima cjelobrojne podatke malih vrijednosti
- **datum_rodenja** podatak tipa *date*, prilagodili smo ga sljedećem standardu *"%d.%m.%Y."*, gdje se u bazu prvo upisuju dani, mjeseci pa godine.
- **nacionalnost** podatak tipa *varchar* koji je limitiran na 30 znakova

Ograničenje ***not null*** označava da podatak ne smije biti **null** tip podatka.

```mysql
CREATE TABLE vozac(
   id INTEGER PRIMARY KEY,
   ime VARCHAR(30) NOT NULL,
   prezime VARCHAR(30) NOT NULL,
   odabrani_broj SMALLINT,
   datum_rodenja DATE NOT NULL,
   nacionalnost VARCHAR(30) NOT NULL
    
);
```



### Relacija automobil

Relacija automobil se sastoji od sljedećih atributa:

- **id** podatak tipa *integer*, koji je primarni ključ unutar relacije

- **naziv_auto** podatak tipa *varchar* koji je limitiran na 30 znakova

- **vrsta_motora** podatak tipa *varchar* koji je limitiran na 40 znakova 

- **proizvodac_guma** podatak tipa *varchar* koji je limitiran na 40 znakova, ograničen je naredbom *default* koja automatski postavlja vrijednost *" Pirelli "* unutar relacije, osima ako korisnik ne upiše drugu vrijednost 

Ograničenje ***not null*** označava da podatak ne smije biti ***null*** tip podatka.

```mysql
CREATE TABLE automobil(
   id INTEGER PRIMARY KEY,
   naziv_auto VARCHAR(30) NOT NULL,
   vrsta_motora VARCHAR(40) NOT NULL,
   proizvodac_guma VARCHAR(30) DEFAULT 'Pirelli'
    
);
```



### Relacija vozac_u_sezoni

Relacija automobil se sastoji od sljedećih atributa:

- **id** podatak tipa *integer,* koji je primarni ključ unutar relacije

- **id_vozac** podatak tipa *integer*, to je strani ključ iz relacije **vozac** 

- **id_kus** podatak tipa *integer*, to je strani ključ iz relacije **konstruktor_u_sezoni**

- **id_auto** podatak tipa *integer*, to je strani ključ iz relacije **automobil**

- **id_sezona** podatak tipa *integer*, to je strani ključ iz relacije **sezona**

   

```mysql
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
```



### Relacija sponzor

Relacija sponzor se sastoji od sljedećih atributa:

- **id** podatak tipa *integer*, koji je primarni ključ unutar relacije

- **ime** podatak tipa *varchar* koji je limitiran na 50 znakova

Ograničenje ***not null*** označava da podatak ne smije biti ***null*** tip podatka.

```mysql
CREATE TABLE sponzor(
   id INTEGER PRIMARY KEY,
   ime VARCHAR(50) NOT NULL
    
);
```



### Relacija sponzor_u_sezoni

Relacija sponzor se sastoji od sljedećih atributa:

- **id** podatak tipa *integer* koji je primarni ključ unutar relacije

- **id_sponzor** podatak tipa *integer*, to je strani ključ iz relacije **sponzor**  

- **id_kus** podatak tipa *integer*, to je strani ključ iz relacije **konstruktor_u_sezoni**

- **id_sezona** podatak tipa *integer*, to je strani ključ iz relacije **sezona** 

- **isplacen_novac** podatak tipa *integer*  

- **status_sponzora**  podatak tipa *varchar* koji je limitiran na 13 znakova, ograničen je naredbom *default* koja automatski postavlja vrijednost *" Suradnik "* unutar relacije, osima ako korisnik ne upiše drugu vrijednost 

Ograničenje ***not null*** označava da podatak ne smije biti ***null*** tip podatka.

```mysql
CREATE TABLE sponzor_u_sezoni(
   id INTEGER PRIMARY KEY,
   id_sponzor INTEGER,
   id_kus INTEGER,
   id_sezona INTEGER,
   isplacen_novac FLOAT NOT NULL,
   status_sponzora VARCHAR(13) DEFAULT 'Suradnik',
   FOREIGN KEY (id_sponzor) REFERENCES sponzor(id),
   FOREIGN KEY (id_kus) REFERENCES konstruktor_u_sezoni(id),
   FOREIGN KEY (id_sezona) REFERENCES sezona(id)
    
);
```



### Relacija staza

Relacija staza se sastoji od sljedećih atributa;

- **id **podatak tipa *integer*, koji je primarni ključ unutar relacije

- **ime_staze** podatak tipa *varchar* koji je limitiran na 50 znakova, ograničen je pomoću naredbe *unique* kako ne bi imali dvije staze s istim nazivom

- **drzava** podatak tipa *varchar* koji je limitiran na 50 znakova

- **duzina_m** podatak tipa *integer* 
-  **broj_drs_zona** podatak tipa *integer*, ograničen je naredbom *default* koja automatski postavlja vrijednost  *" 2 "* unutar relacije, osima ako korisnik ne upiše drugu vrijednost 

Ograničenje ***not null*** označava da podatak ne smije biti ***null*** tip podatka.

```mysql
CREATE TABLE staza(
   id INTEGER PRIMARY KEY,
   ime_staze VARCHAR(50) NOT NULL UNIQUE,
   drzava VARCHAR(30) NOT NULL,
   duzina_m INTEGER NOT NULL,
   broj_drs_zona INTEGER NOT NULL DEFAULT 2
    
);

```

### Relacija trening

Relacija trening se sastoji od sljedećih atributa:

- **id **podatak tipa *integer*, koji je primarni ključ unutar relacije

Relaciju smo stvorili zbog 

```mysql
CREATE TABLE trening(
   id INTEGER PRIMARY KEY
    
);
```

### Relacija trening_vrijeme

Relacija trening_vrijeme se sastoji od sljedećih atributa:

- **id **podatak tipa *integer*, koji je primarni ključ unutar relacije

- **id_tren** podatak tipa *integer*,  to je strani ključ iz relacije **trening** 

- **id_vus** podatak tipa *integer*,  to je strani ključ iz relacije **vozac_u_sezoni**

- **vozeno_vrijeme_str** podatak tipa *varchar* koji je limitiran na 30 znakova

- **krug** podatak tipa *smallint* koji prima cjelobrojne podatke malih vrijednosti

Ograničenje ***not null*** označava da podatak ne smije biti ***null*** tip podatka.

```mysql
CREATE TABLE tren_vrijeme(
   id INTEGER PRIMARY KEY,
   id_tren INTEGER,
   id_vus INTEGER,
   vozeno_vrijeme_str VARCHAR(30) NOT NULL,
   krug SMALLINT,
   FOREIGN KEY (id_vus) REFERENCES vozac_u_sezoni(id),
   FOREIGN KEY (id_tren) REFERENCES trening(id)
    
);
```

### Relacija kvalifikacija

Relacija kvalifikacije se sastoji od sljedećih atributa:

- **id **podatak tipa *integer* koji je primarni ključ unutar relacije

```mysql
CREATE TABLE kvalifikacija(
   id INTEGER PRIMARY KEY
    
);
```

### Relacija kval_vrijeme

Relacija kval_vrijeme se sastoji od sljedećih atributa:

- **id **podatak tipa *integer*, koji je primarni ključ unutar relacije

- **id_kval**  podatak tipa *integer*,  to je strani ključ iz relacije **kvalifikacija**

- **id_vus** podatak tipa *integer*,  to je strani ključ iz relacije **vozac_u_sezoni**

- **vozeno_vrijeme_str** podatak tipa *varchar* koji je limitiran na 30 znakova
- **krug** podatak tipa *smallint* koji prima cjelobrojne podatke malih vrijednosti

Ograničenje ***not null*** označava da podatak ne smije biti ***null*** tip podatka.

```mysql
CREATE TABLE kval_vrijeme(
   id INTEGER PRIMARY KEY,
   id_kval INTEGER,
   id_vus INTEGER,
   vozeno_vrijeme_str VARCHAR(30) NOT NULL,
   krug SMALLINT,
   FOREIGN KEY (id_vus) REFERENCES vozac_u_sezoni(id),
   FOREIGN KEY (id_kval) REFERENCES kvalifikacija(id)
    
);
```



### Relacija utrka

Relacija utrka vrijeme se sastoji od sljedećih atributa:

- **id **podatak tipa *integer* koji je primarni ključ unutar relacije

- **ime_nagrade** podatak tipa *varchar* koji je limitiran na 50 znakova, ograničen je pomoću naredbe *unique* kako ne bi imali dvije nagrade s istim nazivom

- ***broj_krugova*** podatak tipa *integer* 

Ograničenje ***not null*** označava da podatak ne smije biti ***null*** tip podatka.

```mysql
CREATE TABLE utrka(
   id INTEGER PRIMARY KEY,
   ime_nagrade VARCHAR(50) NOT NULL UNIQUE,
   broj_krugova INTEGER NOT NULL
    
);

```

### Relacija utrka_vrijeme 

Relacija utrka_vrijeme se sastoji od sljedećih atributa:

- **id **podatak tipa *integer* koji je primarni ključ unutar relacije

- **id_utrka** podatak tipa *integer* , to je strani ključ iz relacije **utrka**

- **id_vus** podatak tipa *integer*, to je strani ključ iz relacije **vozac_u_sezoni**

- **vozeno_vrijeme_str** podatak tipa *varchar* koji je limitiran na 30 znakova

- **krug** podatak tipa *smallint* koji prima cjelobrojne podatke malih vrijednosti

Ograničenje ***not null*** označava da podatak ne smije biti ***null*** tip podatka.

```mysql
CREATE TABLE utrka_vrijeme(
   id INTEGER PRIMARY KEY,
   id_utrka INTEGER,
   id_vus INTEGER,
   vozeno_vrijeme_str VARCHAR(30) NOT NULL,
   krug SMALLINT,
   FOREIGN KEY (id_utrka) REFERENCES utrka(id),
   FOREIGN KEY (id_vus) REFERENCES vozac_u_sezoni(id)
    
);
```

### Relacija vikend

Relacija vikend se sastoji od sljedećih atributa:

- **id **podatak tipa *integer* koji je primarni ključ unutar relacije

- **datum_pocetak** podatak tipa *date*, prilagodili smo ga sljedećem standardu *"%d.%m.%Y."*, gdje se u bazu prvo upisuju dani, mjeseci pa godine.

- **datum_kraj** podatak tipa *date*, prilagodili smo ga sljedećem standardu *"%d.%m.%Y."*, gdje se u bazu prvo upisuju dani, mjeseci pa godine.

- **id_staza** podatak tipa *integer* , to je strani ključ iz relacije **staza**

- **id_trening** podatak tipa *integer* , to je strani ključ iz relacije **trening**

- **id_quali **podatak tipa *integer* , to je strani ključ iz relacije **kvalifikacija**
- **id_utrka** podatak tipa *integer* , to je strani ključ iz relacije **utrka**
- **id_sezona** podatak tipa *integer* , to je strani ključ iz relacije **sezona** 

Ograničenje ***not null*** označava da podatak ne smije biti ***null*** tip podatka.

```mysql
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
```

## Alter tabel ograničenja

### Ograničenje staza

Putem ograničenja staze ograničili smo relaciju sljedećom metodom:

- ograničenje *id_len_ck_staza* koje ograničava dužinu id na 4 znamenke, zbog preglednosti i da nam se id-evi ne podudaraju 
- ograničenje  *id_rng_ck_staza* ograničava da id smije poprimit samo vrijednosti od 1000 do 1999
- ograničenje *duzina_rng_ck_staza* ograničava dužinu staze od 1000 do 6999 metara, zbog regulacija staza unutar Formule 1

```mysql
ALTER TABLE staza
	ADD CONSTRAINT id_len_ck_staza CHECK (length(id) = 4),
   ADD CONSTRAINT id_rng_ck_staza CHECK (id >= 1000 AND id < 2000),
   ADD CONSTRAINT duzina_rng_ck_staza CHECK (duzina_m >= 1000 AND duzina_m < 7000);
```

### Ograničenje tim

Putem ograničenja tim ograničili smo relaciju sljedećom metodom:

- ograničenje *id_len_ck_tim* koje ograničava dužinu id na 3 znamenke, zbog preglednosti i da nam se id-evi ne podudaraju

- ograničenje  *id_rng_ck_staza* ograničava da id smije poprimit samo vrijednosti od 100 do 999

```mysql
ALTER TABLE tim
	ADD CONSTRAINT id_len_ck_tim CHECK (length(id) = 3),
   ADD CONSTRAINT id_rng_ck_tim CHECK (id >= 100 AND id < 1000);
```

### Ograničenje konstruktor_u_sezoni

Putem ograničenja konstruktor_u_sezoni ograničili smo relaciju sljedećom metodom:

- ograničenje *id_len_ck_kus* koje ograničava dužinu id na 3 znamenke, zbog preglednosti i da nam se id-evi ne podudaraju

- ograničenje  *id_rng_ck_kus* ograničava da id smije poprimit samo vrijednosti od 200 do 299

```mysql
ALTER TABLE konstruktor_u_sezoni
   ADD CONSTRAINT id_len_ck_kus CHECK (length(id) = 3),
   ADD CONSTRAINT id_rng_ck_kus CHECK (id >= 200 AND id < 300);

```

### Ograničenje sponzor

Putem ograničenja sponzor ograničili smo relaciju sljedećom metodom:

- ograničenje *id_len_ck_sponzor* koje ograničava dužinu id na 4 znamenke, zbog preglednosti i da nam se id-evi ne podudaraju

- ograničenje  *id_rng_ck_sponzor* ograničava da id smije poprimit samo vrijednosti od 4000 do 4999

```mysql
ALTER TABLE sponzor
   ADD CONSTRAINT id_len_ck_sponzor CHECK (length(id) = 4),
   ADD CONSTRAINT id_rng_ck_sponzor CHECK (id >= 4000 AND id < 5000);

```

### Ograničenje sponzor_u_sezoni

Putem ograničenja sponzor_u_sezoni ograničili smo relaciju sljedećom metodom:

- ograničenje *payout_ck_sponzor* ograničava sve sponzore koji nisu isplatili minimalnu svotu novca od 500000 Є, po regulacijama Formule 1

```mysql
ALTER TABLE sponzor_u_sezoni
   ADD CONSTRAINT payout_ck_sponzor CHECK (isplacen_novac >= 500000);

```

### Ograničenje utrka

Putem ograničenja utrka ograničili smo relaciju sljedećom metodom:

- ograničenje *id_len_ck_utrka*  koje ograničava dužinu id na 4 znamenke, zbog preglednosti i da nam se id-evi ne podudaraju
- ograničenje  *id_rng_ck_sponzor* ograničava da id smije poprimit samo vrijednosti od 3000 do 3499

```mysql

ALTER TABLE utrka
   ADD CONSTRAINT id_len_ck_utrka CHECK (length(id) = 4),
   ADD CONSTRAINT id_rng_ck_utrka CHECK (id >= 3000 AND id < 3500);

```

### Ograničenje vikend

Putem ograničenja utrka ograničili smo relaciju sljedećom metodom:

- ograničenje *id_len_ck_vikend*  koje ograničava dužinu id na 4 znamenke, zbog preglednosti i da nam se id-evi ne podudaraju

- ograničenje  *id_rng_ck_vikend* ograničava da id smije poprimit samo vrijednosti od 8000 do 8999
- ograničenje *date_rng_ck* ograničava da vrijednost n-torke može biti jedino vrijednosti 3 

```mysql
ALTER TABLE vikend
   ADD CONSTRAINT id_len_ck_vikend CHECK (length(id) = 4),
   ADD CONSTRAINT id_rng_ck_vikend CHECK (id >= 8000 AND id < 9000),
   ADD CONSTRAINT date_rng_ck  CHECK (datum_pocetka + INTERVAL 3 DAY == datum_kraja);
```

### Ograničenje automobil 

Putem ograničenja utrka ograničili smo relaciju sljedećom metodom:

- ograničenje *id_len_ck_automobil*  koje ograničava dužinu id na 4 znamenke, zbog preglednosti i da nam se id-evi ne podudaraju

- ograničenje  *id_rng_ck_automobil* ograničava da id smije poprimit samo vrijednosti od 9000 do 9999

```mysql
ALTER TABLE automobil
   ADD CONSTRAINT id_len_ck_automobil CHECK (length(id) = 4),
   ADD CONSTRAINT id_rng_ck_automobil CHECK (id >= 9000 AND id < 10000);
```

### Ograničenje vozac 

Putem ograničenja utrka ograničili smo relaciju sljedećom metodom:

- ograničenje *id_len_ck_vozac*  koje ograničava dužinu id na 4 znamenke, zbog preglednosti i da nam se id-evi ne podudaraju

- ograničenje  *id_rng_ck_vozac* ograničava da id smije poprimit samo vrijednosti od 7000 do 7099

```mysql
ALTER TABLE vozac
   ADD CONSTRAINT id_len_ck_vozac CHECK (length(id) = 4),
   ADD CONSTRAINT id_rng_ck_vozac CHECK (id >= 7000 AND id < 7100);
```

### Ograničenje vozac_u_sezoni

Putem ograničenja vozac_u_sezoni ograničili smo relaciju sljedećom metodom:

- ograničenje *id_len_cek_vus*  koje ograničava dužinu id na 4 znamenke, zbog preglednosti i da nam se id-evi ne podudaraju

- ograničenje  *id_rng_ck_vus* ograničava da id smije poprimit samo vrijednosti od 7100 do 7199

```mysql
ALTER TABLE vozac_u_sezoni
   ADD CONSTRAINT id_len_cek_vus CHECK (length(id) = 4),
   ADD CONSTRAINT id_rng_ck_vus CHECK (id >= 7100 and id < 7200);

```

### Ograničenje sezona 

Putem ograničenja sezona ograničili smo relaciju sljedećom metodom:

- ograničenje  *id_check* ograničava da id smije poprimit samo vrijednosti od 2013 do 2015, jer su to jedine sezone iz kojih uzimamo podatke unutar naše baze podataka

```mysql
ALTER TABLE sezona
   ADD CONSTRAINT id_check CHECK (id >= 2013 and id <= 2015);
```

## Učitavanje podataka

*#0*#

```mysql
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/utrke-vremena.csv" 
INTO TABLE utrka_vrijeme
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

ALTER TABLE utrka_vrijeme ADD COLUMN vozeno_vrijeme TIME(3) NOT NULL;
UPDATE utrka_vrijeme SET vozeno_vrijeme = STR_TO_DATE(vozeno_vrijeme_str, "%i:%s:%f");
```



```mysql
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/treninzi-vremena.csv" 
INTO TABLE tren_vrijeme
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

ALTER TABLE tren_vrijeme ADD COLUMN vozeno_vrijeme TIME(3) NOT NULL;
UPDATE tren_vrijeme SET vozeno_vrijeme = STR_TO_DATE(vozeno_vrijeme_str, "%i:%s:%f");
```





## Upiti