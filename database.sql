-- Tworzenie bazy danych flota
CREATE DATABASE flota;

-- Użycie bazy danych
\c flota;

-- Tabela Osoby
CREATE TABLE "Osoby"
(
  "Id_osoby" BigSerial NOT NULL,
  "Imię" Character varying NOT NULL,
  "Nazwisko" Character varying NOT NULL,
  "pesel" Integer NOT NULL,
  "rola" Character varying NOT NULL,
  "Login" Character varying,
  "Haslo" Character varying,
  PRIMARY KEY ("Id_osoby"),
  UNIQUE ("pesel")
)
WITH (
  autovacuum_enabled = true
);

-- Tabela pojazdy
CREATE TABLE "pojazdy"
(
  "Id_pojazdu" BigSerial NOT NULL,
  "Marka" Character varying NOT NULL,
  "Model" Character varying NOT NULL,
  "Dane_serwisowe" Character varying,
  "Naped" Character varying NOT NULL,
  "Paliwo" Integer,
  "status" Character varying NOT NULL,
  "Data_przegladu" Date NOT NULL,
  "Przebieg" Character varying,
  PRIMARY KEY ("Id_pojazdu"),
  UNIQUE ("Id_pojazdu")
)
WITH (
  autovacuum_enabled = true
);

-- Tabela wypożyczenia
CREATE TABLE "wypożyczenia"
(
  "Id_wypozyczenia" BigSerial NOT NULL,
  "Id_osoby" Bigint NOT NULL,
  "Id_pojazdu" Bigint NOT NULL,
  "Data_poczatek" Date NOT NULL,
  "Data_koniec" Date NOT NULL,
  PRIMARY KEY ("Id_wypozyczenia", "Id_osoby", "Id_pojazdu")
)
WITH (
  autovacuum_enabled = true
);

-- Tabela Zapytania
CREATE TABLE "Zapytania"
(
  "Id_zapytania" BigSerial NOT NULL,
  "Id_osoby" Bigint NOT NULL,
  "Id_pojazdu" Bigint NOT NULL,
  "Data_poczatek" Date,
  "Data_koniec" Date,
  "Uzasadnienie" Character varying,
  "Decyzja" Boolean,
  PRIMARY KEY ("Id_zapytania", "Id_osoby", "Id_pojazdu"),
  UNIQUE ("Id_zapytania")
)
WITH (
  autovacuum_enabled = true
);

-- Klucze obce dla wypożyczenia
ALTER TABLE "wypożyczenia"
  ADD CONSTRAINT "Relationship1"
    FOREIGN KEY ("Id_osoby")
    REFERENCES "Osoby" ("Id_osoby")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;

ALTER TABLE "wypożyczenia"
  ADD CONSTRAINT "Relationship2"
    FOREIGN KEY ("Id_pojazdu")
    REFERENCES "pojazdy" ("Id_pojazdu")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;

-- Klucze obce dla Zapytania
ALTER TABLE "Zapytania"
  ADD CONSTRAINT "Relationship3"
    FOREIGN KEY ("Id_osoby")
    REFERENCES "Osoby" ("Id_osoby")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;

ALTER TABLE "Zapytania"
  ADD CONSTRAINT "Relationship4"
    FOREIGN KEY ("Id_pojazdu")
    REFERENCES "pojazdy" ("Id_pojazdu")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;
