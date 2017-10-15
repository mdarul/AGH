--1

-- USER SQL
CREATE USER wyc IDENTIFIED BY "oracle"
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";
-- ROLES
GRANT "DBA" TO wyc WITH ADMIN OPTION;
ALTER USER wyc DEFAULT ROLE "DBA";
--TABLES
CREATE TABLE OSOBY
(
 ID_OSOBY INT GENERATED ALWAYS AS IDENTITY NOT NULL
, IMIE VARCHAR2(50)
, NAZWISKO VARCHAR2(50)
, PESEL VARCHAR2(11)
, KONTAKT VARCHAR2(100)
, CONSTRAINT OSOBY_PK PRIMARY KEY
 (
 ID_OSOBY
 )
 ENABLE
);
CREATE TABLE WYCIECZKI
(
 ID_WYCIECZKI INT GENERATED ALWAYS AS IDENTITY NOT NULL
, NAZWA VARCHAR2(100)
, KRAJ VARCHAR2(50)
, DATA DATE
, OPIS VARCHAR2(200)
, LICZBA_MIEJSC INT
, CONSTRAINT WYCIECZKI_PK PRIMARY KEY
 (
 ID_WYCIECZKI
 )
 ENABLE
);
CREATE TABLE REZERWACJE
(
 NR_REZERWACJI INT GENERATED ALWAYS AS IDENTITY NOT NULL
, ID_WYCIECZKI INT
, ID_OSOBY INT
, STATUS CHAR(1)
, CONSTRAINT REZERWACJE_PK PRIMARY KEY
 (
 NR_REZERWACJI
 )
 ENABLE
);
ALTER TABLE REZERWACJE
ADD CONSTRAINT REZERWACJE_FK1 FOREIGN KEY
(
 ID_OSOBY
)
REFERENCES OSOBY
(
 ID_OSOBY
)
ENABLE;
ALTER TABLE REZERWACJE
ADD CONSTRAINT REZERWACJE_FK2 FOREIGN KEY
(
 ID_WYCIECZKI
)
REFERENCES WYCIECZKI
(
 ID_WYCIECZKI
)
ENABLE;
ALTER TABLE REZERWACJE
ADD CONSTRAINT REZERWACJE_CHK1 CHECK
(status IN ('N','P','Z','A'))
ENABLE;









--2

INSERT INTO osoby (imie, nazwisko, pesel, kontakt)
VALUES('Adam', 'Kowalski', '87654321', 'tel: 6623');
INSERT INTO osoby (imie, nazwisko, pesel, kontakt)
VALUES('Jan', 'Nowak', '12345678', 'tel: 2312, dzwonić po 18.00');
INSERT INTO wycieczki (nazwa, kraj, data, opis, liczba_miejsc)
VALUES ('Wycieczka do Paryza','Francja',TO_DATE('2016-01-01','YYYY-MM-DD'),'Ciekawa wycieczka ...',3);
INSERT INTO wycieczki (nazwa, kraj, data, opis, liczba_miejsc)
VALUES ('Piękny Kraków','Polska',TO_DATE('2017-02-03','YYYY-MM-DD'),'Najciekawa wycieczka ...',2);
INSERT INTO wycieczki (nazwa, kraj, data, opis, liczba_miejsc)
VALUES ('Wieliczka','Polska',TO_DATE('2017-03-03','YYYY-MM-DD'),'Zadziwiająca kopalnia ...',2);
--UWAGA
--W razie problemów z formatem daty można użyć funkcji TO_DATE
INSERT INTO wycieczki (nazwa, kraj, data, opis, liczba_miejsc)
VALUES ('Wieliczka2','Polska',TO_DATE('2017-03-03','YYYY-MM-DD'),
 'Zadziwiająca kopalnia ...',2);
INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (1,1,'N');
INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (2,2,'P');


INSERT INTO OSOBY (IMIE, NAZWISKO, PESEL, KONTAKT)
VALUES ('Michal', 'Grabowszczak', '1488000', 'pulnocnik@poczta.com');

INSERT INTO OSOBY (IMIE, NAZWISKO, PESEL, KONTAKT)
VALUES ('Karol', 'Karolczak', '9231939', '211 514 372');

INSERT INTO OSOBY (IMIE, NAZWISKO, PESEL, KONTAKT)
VALUES ('Jan', 'Kowalski', '1232193', '23132');

INSERT INTO OSOBY (IMIE, NAZWISKO, PESEL, KONTAKT)
VALUES ('Danuta', 'Wojtkowicz', '823813', '94329');

INSERT INTO OSOBY (IMIE, NAZWISKO, PESEL, KONTAKT)
VALUES ('Agnieszka', 'Stanislawowska', '64323234', '231881');

INSERT INTO OSOBY (IMIE, NAZWISKO, PESEL, KONTAKT)
VALUES ('Karolina', 'Wojtyla', '923198', '532814');

INSERT INTO OSOBY (IMIE, NAZWISKO, PESEL, KONTAKT)
VALUES ('Piotr', 'Nowak', '201123', '213 292 100');

INSERT INTO OSOBY (IMIE, NAZWISKO, PESEL, KONTAKT)
VALUES ('Radoslaw', 'Malanowski', '231911', '63218889');


INSERT INTO wycieczki (nazwa, kraj, data, opis, liczba_miejsc)
VALUES ('Szczecin','Polska',TO_DATE('2019-07-03','YYYY-MM-DD'), 'Tall Ship Races oraz zwiedzanie miasta',10);


INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (21, 21,'N');

INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (8, 23,'P');

INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (6, 24,'P');

INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (6, 25,'N');

INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (21, 26,'N');

INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (21, 27,'N');

INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (6, 27,'Z');

INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (21, 2,'A');

INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (21, 28,'Z');







--3

--a
CREATE VIEW WYCIECZKI_OSOBY AS SELECT
 w.ID_WYCIECZKI,
 w.NAZWA,
 w.KRAJ,
 w.DATA,
 o.IMIE,
 o.NAZWISKO,
 r.STATUS
 FROM WYCIECZKI w
 JOIN REZERWACJE r ON w.ID_WYCIECZKI = r.ID_WYCIECZKI
 JOIN OSOBY o ON r.ID_OSOBY = o.ID_OSOBY;

--b
CREATE VIEW WYCIECZKI_OSOBY_POTWIERDZONE AS SELECT
 w.ID_WYCIECZKI,
 w.NAZWA,
 w.KRAJ,
 w.DATA,
 o.IMIE,
 o.NAZWISKO,
 r.STATUS
  FROM WYCIECZKI w
  JOIN REZERWACJE r ON w.ID_WYCIECZKI = r.ID_WYCIECZKI
  JOIN OSOBY o ON r.ID_OSOBY = o.ID_OSOBY
  WHERE r.STATUS = 'P';

--c
CREATE VIEW WYCIECZKI_PRZYSZLE AS SELECT
 w.ID_WYCIECZKI,
 w.NAZWA,
 w.KRAJ,
 w.DATA,
 o.IMIE,
 o.NAZWISKO,
 r.STATUS
  FROM WYCIECZKI w
  JOIN REZERWACJE r ON w.ID_WYCIECZKI = r.ID_WYCIECZKI
  JOIN OSOBY o ON r.ID_OSOBY = o.ID_OSOBY
  WHERE w.DATA > SYSDATE;

--d
CREATE VIEW WYCIECZKI_MIEJSCA AS SELECT
 w.ID_WYCIECZKI,
 w.NAZWA,
 w.KRAJ,
 w.LICZBA_MIEJSC,
 w.LICZBA_MIEJSC - (SELECT COUNT(*) FROM REZERWACJE r WHERE w.ID_WYCIECZKI = r.ID_WYCIECZKI) as wolne_miejsca
  FROM WYCIECZKI w;

--e
CREATE VIEW DOSTEPNE_WYCIECZKI AS SELECT
 w.ID_WYCIECZKI,
 w.NAZWA,
 w.KRAJ,
 w.LICZBA_MIEJSC,
 w.LICZBA_MIEJSC - (SELECT COUNT(*) FROM REZERWACJE r WHERE w.ID_WYCIECZKI = r.ID_WYCIECZKI) as wolne_miejsca
  FROM WYCIECZKI w
  WHERE  w.LICZBA_MIEJSC - (SELECT COUNT(*) FROM REZERWACJE r WHERE w.ID_WYCIECZKI = r.ID_WYCIECZKI) > 0

--f
CREATE VIEW REZERWACJA_DO_ANULOWANIA AS SELECT
 r.NR_REZERWACJI,
 r.ID_WYCIECZKI,
 w.DATA,
 o.IMIE,
 o.NAZWISKO
  FROM REZERWACJE r
  JOIN WYCIECZKI w ON w.ID_WYCIECZKI = r.ID_WYCIECZKI
  JOIN OSOBY o ON r.ID_OSOBY = o.ID_OSOBY
  WHERE w.DATA - SYSDATE < 7 AND w.DATA > SYSDATE









--4

--a

CREATE OR REPLACE PROCEDURE UCZESTNICY_WYCIECZKI(id_wyc INT, proc_cursor OUT SYS_REFCURSOR ) IS
  if_exist BOOLEAN;
  BEGIN
    if_exist := CHECK_WYCIECZKA_EXISTS(id_wyc);
    IF if_exist = FALSE THEN
      RAISE NO_DATA_FOUND;
    END IF;
    OPEN proc_cursor FOR
    SELECT
     w.ID_WYCIECZKI,
     w.NAZWA,
     w.KRAJ,
     w.DATA,
     W.ID_OSOBY,
     w.IMIE,
     w.NAZWISKO,
     w.STATUS
    FROM WYCIECZKI_OSOBY w
    WHERE w.ID_WYCIECZKI = id_wyc;
  END;

DECLARE
  c_cursor SYS_REFCURSOR;
  c_id WYCIECZKI_OSOBY.ID_WYCIECZKI%TYPE;
  c_trip_name WYCIECZKI_OSOBY.NAZWA%TYPE;
  c_country WYCIECZKI_OSOBY.KRAJ%TYPE;
  c_date WYCIECZKI_OSOBY.DATA%TYPE;
  c_person_id WYCIECZKI_OSOBY.ID_OSOBY%TYPE;
  c_person_name WYCIECZKI_OSOBY.IMIE%TYPE;
  c_person_surname WYCIECZKI_OSOBY.NAZWISKO%TYPE;
  c_status WYCIECZKI_OSOBY.STATUS%TYPE;
BEGIN
  UCZESTNICY_WYCIECZKI(id_wyc=>21, proc_cursor=>c_cursor);
  LOOP
    FETCH c_cursor
    INTO c_id, c_trip_name, c_country, c_date, c_person_id, c_person_name, c_person_surname, c_status;
    EXIT WHEN c_cursor%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(c_id || ' ' || c_trip_name || ' ' || c_country || ' ' || c_date || ' ' || c_person_id || ' ' || c_person_name || ' ' || c_person_surname || ' ' || c_status);
  END LOOP;
  CLOSE c_cursor;
END;

CREATE OR REPLACE FUNCTION CHECK_WYCIECZKA_EXISTS(id_wyc INT)
RETURN BOOLEAN IS
    total NUMBER(2) := 0;
  BEGIN
    SELECT COUNT(*) INTO total
    FROM WYCIECZKI w
    WHERE w.ID_WYCIECZKI = id_wyc;
    IF total != 0 THEN RETURN TRUE;
    ELSE RETURN FALSE;
    END IF;
  END;


--b

CREATE OR REPLACE PROCEDURE REZERWACJE_OSOBY(id_os INT, proc_cursor OUT SYS_REFCURSOR ) IS
  if_exist BOOLEAN;
  BEGIN
    if_exist := CHECK_OSOBA_EXISTS(id_os);
    IF if_exist = FALSE THEN
      RAISE NO_DATA_FOUND;
    END IF;
    OPEN proc_cursor FOR
    SELECT
     w.ID_WYCIECZKI,
     w.NAZWA,
     w.KRAJ,
     w.DATA,
     W.ID_OSOBY,
     w.IMIE,
     w.NAZWISKO,
     w.STATUS
    FROM WYCIECZKI_OSOBY w
    WHERE w.ID_OSOBY = id_os;
  END;

DECLARE
  c_cursor SYS_REFCURSOR;
  c_id WYCIECZKI_OSOBY.ID_WYCIECZKI%TYPE;
  c_trip_name WYCIECZKI_OSOBY.NAZWA%TYPE;
  c_country WYCIECZKI_OSOBY.KRAJ%TYPE;
  c_date WYCIECZKI_OSOBY.DATA%TYPE;
  c_person_id WYCIECZKI_OSOBY.ID_OSOBY%TYPE;
  c_person_name WYCIECZKI_OSOBY.IMIE%TYPE;
  c_person_surname WYCIECZKI_OSOBY.NAZWISKO%TYPE;
  c_status WYCIECZKI_OSOBY.STATUS%TYPE;
BEGIN
  REZERWACJE_OSOBY(id_os=>2, proc_cursor=>c_cursor);
  LOOP
    FETCH c_cursor
    INTO c_id, c_trip_name, c_country, c_date, c_person_id, c_person_name, c_person_surname, c_status;
    EXIT WHEN c_cursor%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(c_id || ' ' || c_trip_name || ' ' || c_country || ' ' || c_date || ' ' || c_person_id || ' ' || c_person_name || ' ' || c_person_surname || ' ' || c_status);
  END LOOP;
  CLOSE c_cursor;
END;

CREATE OR REPLACE FUNCTION CHECK_OSOBA_EXISTS(id_os INT)
RETURN BOOLEAN IS
    total NUMBER(2) := 0;
  BEGIN
    SELECT COUNT(*) INTO total
    FROM OSOBY o
    WHERE o.ID_OSOBY = id_os;
    IF total != 0 THEN RETURN TRUE;
    ELSE RETURN FALSE;
    END IF;
  END;



--c

CREATE OR REPLACE PROCEDURE PRZYSZLE_REZERWACJE_OSOBY(id_os INT, proc_cursor OUT SYS_REFCURSOR ) IS
  if_exist BOOLEAN;
  BEGIN
    if_exist := CHECK_OSOBA_EXISTS(id_os);
    IF if_exist = FALSE THEN
      RAISE NO_DATA_FOUND;
    END IF;
    OPEN proc_cursor FOR
    SELECT
     w.ID_WYCIECZKI,
     w.NAZWA,
     w.KRAJ,
     w.DATA,
     W.ID_OSOBY,
     w.IMIE,
     w.NAZWISKO,
     w.STATUS
    FROM WYCIECZKI_OSOBY w
    WHERE w.ID_OSOBY = id_os AND w.DATA > SYSDATE;
  END;

DECLARE
  c_cursor SYS_REFCURSOR;
  c_id WYCIECZKI_OSOBY.ID_WYCIECZKI%TYPE;
  c_trip_name WYCIECZKI_OSOBY.NAZWA%TYPE;
  c_country WYCIECZKI_OSOBY.KRAJ%TYPE;
  c_date WYCIECZKI_OSOBY.DATA%TYPE;
  c_person_id WYCIECZKI_OSOBY.ID_OSOBY%TYPE;
  c_person_name WYCIECZKI_OSOBY.IMIE%TYPE;
  c_person_surname WYCIECZKI_OSOBY.NAZWISKO%TYPE;
  c_status WYCIECZKI_OSOBY.STATUS%TYPE;
BEGIN
  PRZYSZLE_REZERWACJE_OSOBY(id_os=>2, proc_cursor=>c_cursor);
  LOOP
    FETCH c_cursor
    INTO c_id, c_trip_name, c_country, c_date, c_person_id, c_person_name, c_person_surname, c_status;
    EXIT WHEN c_cursor%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(c_id || ' ' || c_trip_name || ' ' || c_country || ' ' || c_date || ' ' || c_person_id || ' ' || c_person_name || ' ' || c_person_surname || ' ' || c_status);
  END LOOP;
  CLOSE c_cursor;
END;



--d

CREATE OR REPLACE PROCEDURE DOSTEPNE_WYCIECZKI_PROC(kraj varchar2, data_od DATE, data_do DATE, proc_cursor OUT SYS_REFCURSOR ) IS
  date_correctness BOOLEAN;
  BEGIN
    date_correctness := CHECK_DATE(data_od, data_do);
    IF date_correctness = FALSE THEN
      RAISE VALUE_ERROR;
    END IF;
    OPEN proc_cursor FOR
    SELECT
     w.ID_WYCIECZKI,
     w.NAZWA,
     w.KRAJ,
     w.DATA,
     w.OPIS
    FROM WYCIECZKI w
    WHERE w.KRAJ = kraj and w.LICZBA_MIEJSC > (SELECT count(*) FROM REZERWACJE r WHERE w.ID_WYCIECZKI = r.ID_WYCIECZKI and r.STATUS != 'A');
  END;

DECLARE
  c_cursor SYS_REFCURSOR;
  c_id WYCIECZKI.ID_WYCIECZKI%TYPE;
  c_trip_name WYCIECZKI.NAZWA%TYPE;
  c_country WYCIECZKI.KRAJ%TYPE;
  c_date WYCIECZKI.DATA%TYPE;
  c_description WYCIECZKI.OPIS%TYPE;
BEGIN
  DOSTEPNE_WYCIECZKI_PROC(kraj=>'Polska', data_od => SYSDATE, data_do => TO_DATE('2019-12-12', 'YYYY-MM-DD'), proc_cursor=>c_cursor);
  LOOP
    FETCH c_cursor
    INTO c_id, c_trip_name, c_country, c_date, c_description;
    EXIT WHEN c_cursor%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(c_id || ' ' || c_trip_name || ' ' || c_country || ' ' || c_date || ' ' || c_description);
  END LOOP;
  CLOSE c_cursor;
END;

CREATE OR REPLACE FUNCTION CHECK_DATE(data_od DATE, data_do DATE)
RETURN BOOLEAN IS
  BEGIN
    IF data_do >= data_od THEN RETURN TRUE;
    ELSE RETURN FALSE;
    END IF;
  END;