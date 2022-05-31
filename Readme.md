Sveučilište Jurja Dobrile u Puli

Fakultet informatike u Puli



![Sveučilište Jurja Dobrile u Puli](https://cdn.discordapp.com/attachments/759467826440044585/981096052390244352/170px-Unipu-logo-lat.png)






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



## ER dijagram



![ERD](https://cdn.discordapp.com/attachments/959129607041318933/981260131905962034/Formula1.png)



### Opis dijagrama

Skup entiteta **vikend** je povezan s skupom entiteta **sezona** više naprema jedan, jer možemo više **vikend(*race-a*)** provest unutar jedne sezone, dok unutar jedne **sezone** provodimo više **vikend(*race-a*)**. 

Skup entiteta **vikend** je povezan s skupom entiteta **utrka** jedan naprema jedan, jer unutar **vikend(*race-a*)** se može vozit samo jedna **utrka**, dok se jedna utrka vozi unutar jednog **vikend(*race-a*)**. 

Skup entiteta **utrka** povezan je s skupom entiteta **utrka_vrijeme** jedan naprema više, jer svake **utrke** možemo imat više vremena unutar **utrka_vrijeme**. Iz ovog odnosa veza možemo izlučit podatak opisnog atributa ***ostvareno_mjesto*** tako da uzmemo najbrže ostvareno vrijeme i rangiramo ostala vremena prema njemu.

  Skup entiteta **utrka_vrijeme** je povezan s skupom entiteta **vozac_u-sezoni** više naprema više, jer unutar **utrka_vrijeme**, vrijeme se ostvaruje više puta zbog količine vozača unutar **vozac_u-sezoni**, samim time imamo više vremena unutar **utrka_vrijeme**.

Skup entiteta  **vozac_u-sezoni** je povezan s skupom entiteta **automobil** više naprema jedan, jer svaki **vozac_u_sezoni** može voziti jedan **automobil**, dok jednog **automobila** može voziti više **vozaca_u_sezoni**.

Skup entiteta  **vozac_u-sezoni** je povezan s skupom entiteta **vozac** jedan naprema jedan jer svaki **vozac** se nalazi unutar jedne sezone, što samo intuitivno opisuje naziv naše relacije **vozac_u_sezoni**.

Skup entiteta  **vozac_u-sezoni** je povezan s skupom entiteta **konstruktor_u_sezoni** više naprema jedan, jer svaki vozač može imati samo jednog **konstruktora_u_sezoni**(*drugi naziv za tim: Ferrari, Red Bull itd*), dok unutar jednog **konstruktora_u_sezoni** možemo pronaći više **vozac_u-sezoni**. 

Skup entiteta  **konstruktor_u_sezoni** je povezan s skupom entiteta **tim** jedan naprema jedan, jer svaki **konstruktor_u_sezoni** se nalazi unutar jednog **tima**. 

Dodali smo odnos slabih veza jer bez **tima** skup entiteta **konstruktor_u_sezoni** ne bi imao pretjerano smisla.

Skup entiteta **sponzor_u_sezoni** je povezan s skupom entiteta **sponzor** jedan naprema jedan, preko istog principa kako smo povezali skupove entiteta **vozac_u_sezoni** i **vozac**.  

Skup entiteta **sponzor_u_sezoni** je povezan s skupom entiteta **sezona** više naprema jedan, jer unutar svake **sezone** nalazi se više sponzora, dok se svi ti **sponzori_u_sezoni** ne mogu pronaći u više **sezona** istovremeno.

Skup entiteta **vozac_u_sezoni** je povezan s skupom entiteta **sezona** više naprema jedan, jer unutar jedne **sezone** pronalazimo više **vozača**, dok **vozaci_u_sezoni** se nalaze istovremeno u samo jednoj sezoni.

Skup entiteta  **vikend** je povezan s skupom entiteta **trening** jedan naprema jedan, iz razloga jer unutar svakog **vikenda** provodi se samo jedan **trening**.

Skup entiteta  **vikend** je povezan s skupom entiteta **kvalifikacija** jedan naprema jedan, iz razloga jer unutar svakog **vikenda** provodi se samo jedna **kvalifikacija**.

Skup entiteta  **trening** je povezan s skupom entiteta **tren_vrijeme** jedan naprema jedan, iz razloga jer unutar svakog **treninga** proizlazi samo jedno ***trening**_**vrijeme***, dok ***trening_vrijeme*** se odnosi samo na jedan **trening**.

Skup entiteta  **kvalifikacija** je povezan s skupom entiteta **kval_vrijeme** jedan naprema jedan, iz razloga jer unutar svake **kvalifikacije** proizlazi samo jedno ***kvalifikacijsko**_**vrijeme***, dok ***kvalifikacijsko_vrijeme*** se odnosi samo na jedanu **kvalifikaciju**.

Skup entiteta  **tren_vrijeme** je povezan s skupom entiteta **vozac_u_sezoni** jedan naprema više, jer svako ***trening_vremena*** se povezuju na više **vozaca_u_sezoni**, dok jedan **vozac_u_sezoni** ima samo jedno ***trening_vrijeme***.

Skup entiteta  **kval_vrijeme** je povezan s skupom entiteta **vozac_u_sezoni** jedan naprema više, jer svako ***kvalifikacijsko_vrijeme*** se povezuju na više **vozaca_u_sezoni**, dok jedan **vozac_u_sezoni** ima samo jedno ***kvalifikacijsko_vrijeme***.

Skup entiteta  **vikend** je povezan s skupom entiteta **staza** jedan naprema više, jer svaki **vikend(*race*)** se odvija na samo jednoj **stazi**, dok na jednoj **stazi** se može izvršit više utrka bilo to iz **Formule 1** ili iz lokalnih natjecanja. 



## Relacije, atributi, domene i ograničenja

### Relacija *tim*

Prati osnovne, nepromjenjive podatke o timovima.
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

Evidentira id-eve naših sezona.
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

Promjenjivi podaci koji o timovima koji se mjenjaju kroz sezone.
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

Prati nepromjenjive podatke o vozačima.
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

Osnovni podaci o automobilima, nismo ih raspodjelili po sezonama pošto se vežu direktno na vozaća u sezoni.
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

Prati promjenjive podatke o vozačima kroz sezone.
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

Lista dostupnih sponzora kroz sezone u F1.
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

Prati sponzore i njihove partnere/timove kroz sezone.
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

Zabilježava sve staze vožene kroz 3 sezone.
Relacija staza se sastoji od sljedećih atributa;

- **id** podatak tipa *integer*, koji je primarni ključ unutar relacije

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

Ova tablica se koristi za vezanje treninga za specifični vikend.
Relacija trening se sastoji od sljedećih atributa:

- **id** podatak tipa *integer*, koji je primarni ključ unutar relacije

Relaciju smo stvorili zbog

```mysql
CREATE TABLE trening(
   id INTEGER PRIMARY KEY

);
```

### Relacija trening_vrijeme

Prati vremena svih vozača za svaki krug u svakom treningu.
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

Ova tablica se koristi za vezanje kvalifikacija za specifični vikend.
Relacija kvalifikacije se sastoji od sljedećih atributa:

- **id** podatak tipa *integer* koji je primarni ključ unutar relacije

```mysql
CREATE TABLE kvalifikacija(
   id INTEGER PRIMARY KEY

);
```

### Relacija kval_vrijeme

Prati vremena svih vozača za svaki krug u svakoj kvalifikaciji.
Relacija kval_vrijeme se sastoji od sljedećih atributa:

- **id** podatak tipa *integer*, koji je primarni ključ unutar relacije

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

Tablica se koristi za vezanje specifične utrke za određeni vikend. Također vidimo naziv nagrade i predefinirani broj krugova za utrku.
Relacija utrka vrijeme se sastoji od sljedećih atributa:

- **id** podatak tipa *integer* koji je primarni ključ unutar relacije

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

Prati vremena svih vozača za svaki krug u svakoj utrci.
Relacija utrka_vrijeme se sastoji od sljedećih atributa:

- **id** podatak tipa *integer* koji je primarni ključ unutar relacije

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

Veže utrke, kvalifikacije i treninge. Također veže vikende za određenu sezonu.
Relacija vikend se sastoji od sljedećih atributa:

- **id** podatak tipa *integer* koji je primarni ključ unutar relacije

- **datum_pocetak** podatak tipa *date*, prilagodili smo ga sljedećem standardu *"%d.%m.%Y."*, gdje se u bazu prvo upisuju dani, mjeseci pa godine.

- **datum_kraj** podatak tipa *date*, prilagodili smo ga sljedećem standardu *"%d.%m.%Y."*, gdje se u bazu prvo upisuju dani, mjeseci pa godine.

- **id_staza** podatak tipa *integer* , to je strani ključ iz relacije **staza**

- **id_trening** podatak tipa *integer* , to je strani ključ iz relacije **trening**

- **id_quali** podatak tipa *integer* , to je strani ključ iz relacije **kvalifikacija**
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

## Alter table ograničenja

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

## Učitavanje podataka iz CSV datoteka


Kako bi učitali CSV datoteke u našu bazu podataka moramo prije dobiti direktorij iz kojeg MySQL učitava podatke.
To činimo sa sljedećom komandom:
```
	SHOW VARIABLES LIKE "secure_file_priv";
```
Adresu ispisanu pod *values* ubacujemo u file explorer i u direktorij ubacamo csv datoteke.

Sa sljedećom linijom koda učitavamo podatke iz datoteke koja se nalazi na definiranoj adresi, specificiramo u koju tablicu učitavamo podatke i naglasimo na koji način se odvajaju podaci jedni od drugih.
```mysql
	LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/utrke-vremena.csv"
	INTO TABLE utrka_vrijeme
	FIELDS TERMINATED BY ','
	ENCLOSED BY '"'
	LINES TERMINATED BY '\n';
```

Nakon učitavanja, sa **ALTER TABLE** dodajemo novu kolonu, to jest atribut gdje ćemo konvertirati vozeno vrijeme iz **VARCHAR** u **TIME** specificirajući format u kojem prezentira vrijeme.
```
	ALTER TABLE utrka_vrijeme ADD COLUMN vozeno_vrijeme TIME(3) NOT NULL;
	UPDATE utrka_vrijeme SET vozeno_vrijeme = STR_TO_DATE(vozeno_vrijeme_str, "%i:%s:%f");
```


## Učitavanje podataka INSERT INTO komandom


Kako bi učitavali podatke u tablice koristimo komandu **INSERT INTO** ime tablice **VALUES** te u zagradama pišemo podatke u redoslijedu kao što smo ih specificirali pri stvaranju tablica. Primjer:
```
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
```


## Upiti


1. Ispišite podatke vozača koji su američke nacionalnosti
```
SELECT *
  FROM vozac
  WHERE nacionalnost = "američko";
```



2. Ispišite najdužu stazu za vikend
```
	SELECT ime_staze, max(duzina_m) as najduza
		FROM vikend AS v
	    INNER JOIN staza AS u ON (u.id = v.id_staza);
```



3. Prikažite podatke staza kraćih od 5km
```
	SELECT *
		FROM staza
	    WHERE duzina_m < 5000;
```



4. Navedite sponzora sa najviše isplaćenog novca (id_sponzor, najveca_isplata)
```
	SELECT sponzor.id, sus.id, sponzor.ime, sus.id_sezona, MAX(sus.isplacen_novac) AS najveca_isplata
	   FROM sponzor, sponzor_u_sezoni AS sus;
```



5. Prikažite najdulju stazu u kalendaru (id_staza, ime_staze, max_duzina, broj_drs_zona)
```
	SELECT id, ime_staze, MAX(duzina_m) AS max_duzina, broj_drs_zona
	   FROM staza
	   GROUP BY duzina_m
	   ORDER BY duzina_m DESC
	   LIMIT 1;
```



6. Prikažite vrijeme najbržeg kruga utrke u sezoni 2013. godine te u kojoj utrci je odvožen. (id_utrka, ime_nagrade, najbrzi_krug_2013)
```
	SELECT uv.id_utrka, u.ime_nagrade, MIN(vozeno_vrijeme) AS najbrzi_krug_2013
		FROM utrka_vrijeme AS uv, utrka AS u
	    WHERE uv.id_utrka = u.id AND id_utrka IN (SELECT v.id_utrka
			FROM vikend AS v
			INNER JOIN utrka AS u
			ON (u.id = v.id_utrka)
			WHERE id_sezona = 2013);
```



7. Nađite prosjek trajanja kruga u 2014. godini.
```
	SELECT SEC_TO_TIME(AVG(TIME_TO_SEC(vozeno_vrijeme))) AS prosjek
		FROM utrka_vrijeme
	    WHERE id_utrka IN (SELECT v.id_utrka
					  FROM vikend AS v
					  INNER JOIN utrka AS u
					  ON (u.id = v.id_utrka)
					  WHERE id_sezona = 2014);
```

-- ILI

```
	SELECT SEC_TO_TIME(AVG(TIME_TO_SEC(vozeno_vrijeme))) AS prosjek
		FROM vikend AS v
	    INNER JOIN utrka AS u ON (v.id_utrka = u.id)
			INNER JOIN utrka_vrijeme AS uv ON (u.id = uv.id_utrka)
		WHERE id_sezona = 2014;
```



8. Ispišite tim koji ima najmanje sponzora.
```
	SELECT COUNT(id_sponzor) AS kolicina_sponzora, id_sponzor
		FROM sponzor_u_sezoni AS ss
	    INNER JOIN konstruktor_u_sezoni AS ks ON (ks.id = ss.id_kus)
	    GROUP BY id_tim
	    ORDER BY kolicina_sponzora ASC
	    LIMIT 1;
```



9. Ispiši sve vikende od prije 1.6.2014. te ih sortirajte od najmanje do najviše broja krugova (id_vikend, datum_pocetka, datum_kraja, ime_nagrade, broj_krugova)
```
	SELECT v.id, v.datum_pocetka, v.datum_kraja, u.ime_nagrade, u.broj_krugova
		FROM vikend AS v
	    INNER JOIN utrka AS u ON (u.id = v.id_utrka)
	    WHERE datum_pocetka < STR_TO_DATE("01.07.2014", "%d.%m.%Y.") AND datum_pocetka > STR_TO_DATE("01.01.2014", "%d.%m.%Y.")
	    ORDER BY broj_krugova ASC;
```



10. Ispišite koliko je prosjek broja sponzora po timu.
```
	SELECT AVG(k.kolicina_sponzora) AS prosjek_sponzora_po_timu
			FROM (SELECT COUNT(id_sponzor) AS kolicina_sponzora, id_sponzor
				FROM sponzor_u_sezoni AS ss
				INNER JOIN konstruktor_u_sezoni AS ks ON (ks.id = ss.id_kus)
				GROUP BY id_tim
				ORDER BY kolicina_sponzora) AS k;
```



11. Prikažite staze i najbrze vrijeme ostvareno na svakoj stazi (ime_staze, vrijeme)
```
	SELECT s.ime_staze, MIN(vozeno_vrijeme) AS vrijeme
		FROM staza AS s
			INNER JOIN vikend AS v ON (s.id = v.id_staza)
				INNER JOIN utrka AS u ON (u.id = v.id_utrka)
					INNER JOIN utrka_vrijeme AS uv ON (uv.id_utrka = u.id)
		GROUP BY s.ime_staze;
```



12. Prikažite stazu koja se najkraće vozi jednim krugom (ime_staze, vrijeme)
```
	SELECT s.ime_staze, MIN(vozeno_vrijeme) AS vrijeme
		FROM staza AS s
			INNER JOIN vikend AS v ON (s.id = v.id_staza)
				INNER JOIN utrka AS u ON (u.id = v.id_utrka)
					INNER JOIN utrka_vrijeme AS uv ON (uv.id_utrka = u.id)
		GROUP BY s.ime_staze
   	 ORDER BY vrijeme
   	 LIMIT 1;
```



13. Prikažite koji je automobil dodijeljen pojedinom vozaču (vozac.id, vozac.ime, vozac.prezime, vozac.odabrani_broj, automobil.naziv, automobil.vrsta_motora)
```
	SELECT vozac.id, vozac.ime, vozac.prezime, vozac.odabrani_broj, auto.naziv_auto, auto.vrsta_motora
		FROM vozac_u_sezoni AS vus, vozac, automobil AS auto
    	WHERE vus.id_vozac = vozac.id AND vus.id_auto = auto.id;
```



## Zaključak
