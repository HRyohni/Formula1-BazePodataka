# Sveučilište Jurja Dobrile u Puli  Fakultet informatike u Puli


## Tim X
# Formula1




### Izradili: Leo Matošević, Mateo Kocev, Stevan Čorak, Filippo Bubić, Jan Božac  
### Studijski smjer: Informatika
### Kolegij: Baza podataka I
### Mentor: doc. dr. sc. Goran Oreški
 

# Sadržaj

 
# Sažetak
 
# Uvod
 
# ER Dijagram
 
# Kardinalnost veza
 
# Opis tablica
### Tim
| Atribut         | Tip podataka   | Opis                   | Primjer             | Kontrola unosa |
|-----------------|----------------|------------------------|---------------------|----------------|
|     Id          |     Integer    |     Šifra tima         | 100                 |                |
|     Naziv       |     Varchar    |     Naziv tima         | Scuderia Ferrari    |                |
|     Voditelj    |     Varchar    |     Naziv voditelja    | Maurizio Arrivabene |                |
|     sjediste    |     varchar    |     Sjediste tima      | Maranello, Italy    | not null       |



### Konstuktor_u_sezoni
|     Atribut    |     Tip podataka    |     Opis                         |     Primjer    |     Kontrola unosa    |
|----------------|---------------------|----------------------------------|----------------|-----------------------|
| id             | PRIMARY KEY INTEGER | šifra konstruktora u sezoni      | 200            |                       |
| id_sezona      | INTEGER             | šifra sezone                     | 2013           |                       |
| id_tim         | INTEGER             | šifra tima                       | 100            |                       |
| kod_sasija     | VARCHAR             | kod šasije konstruktora u sezoni | F138           |                       |

 

### Vozac
|     Atribut          |     Tip podataka           |     Opis             |     Primjer    |     Kontrola unosa    |
|----------------------|----------------------------|----------------------|----------------|-----------------------|
|     Id               |     Integer primary key    | šifra vozača         | 7000           |                       |
|     Ime              |     varchar                | ime vozača           | Roberto        | not null              |
|     Prezime          |     Varchar                | prezime vozača       | Merhi          | not null              |
|     Odabrani_broj    |     Samllint               | odabrani broj vozača | 98             |                       |
|     Datum_rodenja    |     Date                   | datum rođenja vozača | 22.03.1991.    | not null              |
|     Nacionalnost     |     varchar                | nacionalnost vozača  | španjolsko     | not null              |



### Vozac_u_sezoni
|     Atribut    |     Tip podataka    |     Opis                    |     Primjer    |     Kontrola unosa    |
|----------------|---------------------|-----------------------------|----------------|-----------------------|
| id             | PRIMARY KEY INTEGER | šifra vozača u sezoni       | 7142           |                       |
| id_vozac       | INTEGER             | šifra vozača                | 7006           |                       |
| id_kus         | INTEGER             | šifra konstruktora u sezoni | 218            |                       |
| id_auto        | INTEGER             | šifra auta                  | 9002           |                       |
| id_sezona      | INTEGER             | šifra sezone                | 2013           |                       |


### Automobile
|     Atribut     |     Tip podataka    |     Opis                      |     Primjer      |     Kontrola unosa    |
|-----------------|---------------------|-------------------------------|------------------|-----------------------|
| id              | INTEGER PRIMARY KEY | šifra automobila              | 9000             |                       |
| naziv_auto      | VARCHAR             | naziv automobila              | Ferrari F138 n.1 | NOT NULL              |
| vrsta_motora    | VARCHAR             | vrsta motora u automobilu     | 2.4L NA V8       | NOT NULL              |
| proizvodac_guma | VARCHAR             | proizvođač guma na automobilu | Pirelli          | NOT NULL              |

### Sponsor
|    <br>Atribut    |    <br>Tip podataka    |    <br>Opis    |    <br>Primjer    |    <br>Kontrola unosa    |
|-------------------|------------------------|----------------|-------------------|--------------------------|
| id                | INTEGER PRIMARY KEY    | šifra sponzora | 4001              |                          |
| ime               | VARCHAR                | ime sponzora   | Petronas          | NOT NULL                 |

### Staza
|    <br>Atribut    |    <br>Tip podataka    |    <br>Opis                    |    <br>Primjer                |    <br>Kontrola unosa    |
|-------------------|------------------------|--------------------------------|-------------------------------|--------------------------|
| id                | INTEGER PRIMARY KEY    | šifra staze                    | 1001                          |                          |
| ime_staze         | VARCHAR                | ime staze                      | Bahrain International Circuit | NOT NULL                 |
| drzava            | VARCHAR                | država u kojoj se staza nalazi | Sakhir, Bahrain               | NOT NULL                 |
| duzina_m          | INTEGER                | dužina staze                   | 5412                          | NOT NULL                 |
| broj_drs_zona     | INTEGER                | broj drs zona                  | 3                             | NOT NULL                 |

### Trening
|    <br>Atribut    |    <br>Tip podataka    |    <br>Opis    |    <br>Primjer    |    <br>Kontrola unosa    |
|-------------------|------------------------|----------------|-------------------|--------------------------|
| id                | INTEGER PRIMARY KEY    | šifra treninga | 20133101          |                          |
 

### Tren_vrijeme
|    <br>Atribut    |    <br>Tip podataka    |    <br>Opis           |    <br>Primjer    |    <br>Kontrola unosa    |
|-------------------|------------------------|-----------------------|-------------------|--------------------------|
| id                | INTEGER PRIMARY KEY    | šifra kvalifikacije   | 100000            |                          |
| id_kval           | INTEGER                | šifra treninga        | 20133101          |                          |
| id_vus            | INTEGER                | šifra vozača u sezoni | 7142              |                          |
| vozeno_vrijeme    | VARCHAR                | voženo vrijeme        | 1:31:348          |                          |
| krug              | SMALLINT               | broj krugova          | 1                 |                          |		


### Kvalifikacija
|    <br>Atribut    |    <br>Tip podataka    |    <br>Opis         |    <br>Primjer    |    <br>Kontrola unosa    |
|-------------------|------------------------|---------------------|-------------------|--------------------------|
| id                | INTEGER PRIMARY KEY    | šifra kvalifikacije | 100000            | 30133101                 |     |                |

### Kval_vrijeme
|    <br>Atribut    |    <br>Tip podataka    |    <br>Opis                    |    <br>Primjer    |    <br>Kontrola unosa    |
|-------------------|------------------------|--------------------------------|-------------------|--------------------------|
| id                | INTEGER PRIMARY KEY    | šifra kvalifikacija vrijeme    | 200000            |                          |
| id_kval           | INTEGER                | šifra kvalifikacija            | 30133101          |                          |
| id_vus            | INTEGER                | šifra vozača u sezoni          | 7142              |                          |
| vozeno_vrijeme    | VARCHAR                | voženo vrijeme u kvalifikaciji | 1:31:369          |                          |
| krug              | SMALLINT               | krug u kvalifikaciji           | 1                 |                          |
 

### Utrka
|    <br>Atribut    |    <br>Tip podataka    |    <br>Opis          |    <br>Primjer                   |    <br>Kontrola unosa    |
|-------------------|------------------------|----------------------|----------------------------------|--------------------------|
| id                | INTEGER PRIMARY KEY    | šifra utrke          | 3101                             |                          |
| ime_nagrade       | VARCHAR                | ime nagrade te utrke | Rolex Australian Grand Prix 2013 |                          |
| broj_krugova      | INTEGER                | broj krugova u utrci | 58                               | NOT NULL                 |         |                |	

### Utrka_vrijeme
|    <br>Atribut     |    <br>Tip podataka    |    <br>Opis                    |    <br>Primjer    |    <br>Kontrola unosa    |
|--------------------|------------------------|--------------------------------|-------------------|--------------------------|
| id                 | INTEGER PRIMARY KEY    | šifra utrka-vrijeme            | 20000             |                          |
| id_utrka           | INTEGER                | šifra utrke                    | 3101              |                          |
| id_vus             | INTEGER                | šifra vozača u sezoni          | 7142              |                          |
| vozeno_vrijeme_str | VARCHAR                | voženo vrijeme u utrka-vrijeme | 1:30:698          |                          |
| krug               | SMALLINT               | broj krugova u utrka-vrijeme   | 1                 |                          |        |                |

### Vikend
|    <br>Atribut    |    <br>Tip podataka    |    <br>Opis         |    <br>Primjer    |    <br>Kontrola unosa    |
|-------------------|------------------------|---------------------|-------------------|--------------------------|
| id                | INTEGER PRIMARY KEY    | šifra vikenda       | 8000              |                          |
| datum_pocetka     | DATE                   | datum početka       | 15.03.2013.       | NOT NULL                 |
| datum_kraja       | DATE                   | datum kraja         | 17.03.2013.       | NOT NULL                 |
| id_staza          | INTEGER                | šifra staze         | 1003              |                          |
| id_trening        | INTEGER                | šifra treninga      | 20133101          |                          |
| id_quali          | INTEGER                | šifra kvalifikacije | 30133101          |                          |
| id_utrka          | INTEGER                | šifra utrke         | 3101              |                          |
| id_sezona         | INTEGER                | šifra sezone        | 2013              |                          |
 

### Sezona
|    <br>Atribut    |    <br>Tip podataka    |    <br>Opis    |    <br>Primjer    |    <br>Kontrola unosa    |
|-------------------|------------------------|----------------|-------------------|--------------------------|
| id                | INTEGER PRIMARY KEY    | šifra sezone   | 2013              |                          |
| godina            | INTEGER                | godina sezone  | 2013              |                          |

### Prvak

 
Pregled poslovnih pravila u bazi
 
Objašnjenje upita
