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
| Atribut  | Tip podataka | Opis            | Primjer | Kontrola unosa |
|----------|--------------|-----------------|---------|----------------|
| Id       | Integer      | Šifra tima      |         |                |
| Naziv    | Varchar      | Naziv tima      |         |                |
| Voditelj | Varchar      | Naziv voditelja |         |                |
| sjediste | varchar      | Sjediste tima   |         |                |	



### Konstuktor_u_sezoni

| Atribut          | Tip podataka        | Opis             | Primjer | Kontrola unosa |
|------------------|---------------------|------------------|---------|----------------|
| id               | INTEGER PRIMARY KEY | Šifra tima       | 200     |                |
| id_sezona        | INTEGER             | Šifra sezone     | 2013    |                |
| id_tim           | INTEGER             | Šifra tima       | 100     |                |
| kod_sasija       | VARCHAR             | Šifra šasije     | F138    |                |
| Osvojeno_bodova  | INTEGER             | Osvojeno bodova  | 354     |                |
| osvojeno_podija  | INTEGER             | Osvojeno podija  | 10      |                |
| osvojeno_naslova | INTEGER             | Osvojeno naslova |         |                |		


 

### Vozac
| Atribut       | Tip podataka        | Opis | Primjer | Kontrola unosa |
|---------------|---------------------|------|---------|----------------|
| Id            | Integer primary key |      |         |                |
| Ime           | varchar             |      |         |                |
| Prezime       | Varchar             |      |         |                |
| Odabrani_broj | Samllint            |      |         |                |
| Datum_rodenja | Date                |      |         |                |
| Nacionalnost  | varchar             |      |         |                |		


### Vozac_u_sezoni
| Atribut                   | Tip podataka        | Opis | Primjer | Kontrola unosa |
|---------------------------|---------------------|------|---------|----------------|
| Id                        | Integer primary key |      |         |                |
| Id_vozac                  | integer             |      |         |                |
| Id_kus                    | Integer             |      |         |                |
| Id_auta                   | Integer             |      |         |                |
| Id_sezona                 | Integer             |      |         |                |
| Osvojeno_bodova           | Char                |      |         |                |
| Osvojeno_podija           | Char                |      |         |                |
| Odvozeno_najbrzih_krugova | Integer             |      |         |                |	



### Automobile
| Atribut         | Tip podataka        | Opis | Primjer | Kontrola unosa |
|-----------------|---------------------|------|---------|----------------|
| Id              | Integer primary key |      |         |                |
| Naziv_auta      | Varchar             |      |         |                |
| Vrsta_motora    | Varchar             |      |         |                |
| Proizvodac_guma | varchar             |      |         |                |


### Sponsor
| Atribut        | Tip podataka        | Opis | Primjer | Kontrola unosa |
|----------------|---------------------|------|---------|----------------|
| Id             | Integer primary key |      |         |                |
| Ime            | Varchar             |      |         |                |
| Isplacen_novac | integer             |      |         |                |		


### Staza
| Atribut       | Tip podataka        | Opis | Primjer | Kontrola unosa |
|---------------|---------------------|------|---------|----------------|
| Id            | Integer primary key |      |         |                |
| Ime_staze     | Varchar             |      |         |                |
| Drzava        | Varchar             |      |         |                |
| Duzina_m      | Integer             |      |         |                |
| Broj_drs_zona | integer             |      |         |                |	


### Trening
| Atribut        | Tip podataka        | Opis | Primjer | Kontrola unosa |
|----------------|---------------------|------|---------|----------------|
| Id             | Integer primary key |      |         |                |
| Krugova_vozeno | char                |      |         |                |

 

### Tren_vrijeme
| Atribut        | Tip podataka        | Opis | Primjer | Kontrola unosa |
|----------------|---------------------|------|---------|----------------|
| Id             | Varchar primary key |      |         |                |
| Id_tren        | Integer             |      |         |                |
| Id_vus         | Integer             |      |         |                |
| Vozeno_vrijeme | Time                |      |         |                |
| Krug           | smallint            |      |         |                |			


### Kvalifikacija
| Atribut           | Tip podataka        | Opis | Primjer | Kontrola unosa |
|-------------------|---------------------|------|---------|----------------|
| Id                | Integer primary key |      |         |                |
| Krugova_vozeno    | Char                |      |         |                |
| Izlazaka_na_stazu | char                |      |         |                |

### Kval_vrijeme
| Atribut        | Tip podataka        | Opis | Primjer | Kontrola unosa |
|----------------|---------------------|------|---------|----------------|
| Id             | Varchar primary key |      |         |                |
| Id_kval        | Integer             |      |         |                |
| Id_vus         | Integer             |      |         |                |
| Vozeno_vrijeme | Time                |      |         |                |
| Krug           | Smallint            |      |         |                |		

 

### Utrka
| Atribut      | Tip podataka        | Opis | Primjer | Kontrola unosa |
|--------------|---------------------|------|---------|----------------|
| Id           | Varchar primary key |      |         |                |
| Ime_nagrade  | Varchar             |      |         |                |
| Broj_krugova | integer             |      |         |                |	

### Utrka_vrijeme
| Atribut            | Tip podataka        | Opis | Primjer | Kontrola unosa |
|--------------------|---------------------|------|---------|----------------|
| Id                 | Integer primary key |      |         |                |
| Id_utrka           | Integer             |      |         |                |
| Id_vus             | Integer             |      |         |                |
| Vozeno_vrijeme_str | Varchar             |      |         |                |
| Krug               | smallint            |      |         |                |

### Vikend
| Atribut       | Tip podataka        | Opis | Primjer | Kontrola unosa |
|---------------|---------------------|------|---------|----------------|
| Id            | Integer primary key |      |         |                |
| Datum_pocetka | Date                |      |         |                |
| Datum_kraja   | Date                |      |         |                |
| Id_staza      | Integer             |      |         |                |
| Id_trening    | integer             |      |         |                |
| Id_quali      | Integer             |      |         |                |
| Id_utrka      | integer             |      |         |                |
| Id_sezona     | integer             |      |         |                |		

 

### Sezona
| Atribut | Tip podataka        | Opis | Primjer | Kontrola unosa |
|---------|---------------------|------|---------|----------------|
| Id      | Integer primary key |      |         |                |
| Godina  | integer             |      |         |                |			


### Prvak
| Atribut           | Tip podataka        | Opis | Primjer | Kontrola unosa |
|-------------------|---------------------|------|---------|----------------|
| Id                | Integer primary key |      |         |                |
| Id_vozac_u_sezoni | Integer             |      |         |                |
| Id_tim            | Integer             |      |         |                |
| Id_sezona         | integer             |      |         |                |

 
Pregled poslovnih pravila u bazi
 
Objašnjenje upita
