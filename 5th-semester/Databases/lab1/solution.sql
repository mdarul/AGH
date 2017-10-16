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
CREATE OR REPLACE VIEW WYCIECZKI_OSOBY_POTWIERDZONE AS SELECT
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
  WHERE r.STATUS = 'P' or r.STATUS = 'Z'

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
    WHERE w.KRAJ = kraj and (w.DATA BETWEEN data_od AND data_do) and w.LICZBA_MIEJSC > (SELECT count(*) FROM REZERWACJE r WHERE w.ID_WYCIECZKI = r.ID_WYCIECZKI and r.STATUS != 'A');
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

CREATE OR REPLACE FUNCTION CHECK_DATES(data_od DATE, data_do DATE)
RETURN BOOLEAN IS
  BEGIN
    IF data_do >= data_od THEN RETURN TRUE;
    ELSE RETURN FALSE;
    END IF;
  END;









--5

--a

CREATE OR REPLACE PROCEDURE DODAJ_REZERWACJE(id_wyc INT, id_osoby INT) IS
  check_slots BOOLEAN;
  trip_date DATE;
  TRIP_ALREADY_STARTED_EXCEPTION EXCEPTION;
  NO_FREE_SLOTS_EXCEPTION EXCEPTION;
  BEGIN
    SAVEPOINT start_tran;
    BEGIN
      SELECT w.DATA INTO trip_date FROM WYCIECZKI w WHERE w.ID_WYCIECZKI = id_wyc;
      IF CHECK_DATES(SYSDATE, trip_date) = FALSE THEN
        RAISE TRIP_ALREADY_STARTED_EXCEPTION;
      END IF;
      IF CHECK_DATES(SYSDATE, trip_date) = FALSE OR CHECK_FREE_SLOTS(id_wyc) = FALSE THEN
        RAISE NO_FREE_SLOTS_EXCEPTION;
      END IF;

      INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
      VALUES (id_wyc, id_osoby,'N');

      EXCEPTION
        WHEN TRIP_ALREADY_STARTED_EXCEPTION THEN
          dbms_output.put_line('Passed date refers to the past!');
        WHEN NO_FREE_SLOTS_EXCEPTION THEN
          dbms_output.put_line('There are no free slots!');
    END;

    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK TO start_tran;
        RAISE;
  END;


CREATE OR REPLACE FUNCTION CHECK_FREE_SLOTS(id_wyc INT)
RETURN BOOLEAN IS
  taken_slots_amount NUMBER := 0;
  max_slots NUMBER := 0;
  WYCIECZKA_EXISTS_ERROR EXCEPTION;
  BEGIN
    IF CHECK_WYCIECZKA_EXISTS(id_wyc) = FALSE THEN
      RAISE WYCIECZKA_EXISTS_ERROR;
    END IF;
    SELECT count(*) INTO taken_slots_amount FROM REZERWACJE r WHERE r.ID_WYCIECZKI = id_wyc AND r.STATUS != 'A';
    SELECT w.LICZBA_MIEJSC INTO max_slots FROM WYCIECZKI w WHERE w.ID_WYCIECZKI = id_wyc;
    IF max_slots >= (taken_slots_amount + 1) THEN RETURN TRUE;
    ELSE RETURN FALSE;
    END IF;

    EXCEPTION
      WHEN WYCIECZKA_EXISTS_ERROR THEN
        dbms_output.put_line('No such a ID_WYCIECZKI!');
  END;


BEGIN
    DODAJ_REZERWACJE(21, 1);
    COMMIT;
END;


--b

CREATE OR REPLACE PROCEDURE ZMIEN_STATUS_REZERWACJI(id_rezerwacji INT, new_status CHAR) IS
  NO_FREE_SLOTS_EXCEPTION EXCEPTION;
  cur_status CHAR;
  trip_id INT;
  BEGIN
    SAVEPOINT start_tran;
    BEGIN
      SELECT r.STATUS INTO cur_status FROM REZERWACJE r WHERE r.NR_REZERWACJI = id_rezerwacji;
      SELECT r.ID_WYCIECZKI INTO trip_id FROM REZERWACJE r WHERE r.NR_REZERWACJI = id_rezerwacji;

      IF (cur_status = 'A' AND new_status != 'A' AND CHECK_FREE_SLOTS(trip_id) = FALSE) THEN
        RAISE NO_FREE_SLOTS_EXCEPTION;
      ELSE
        UPDATE REZERWACJE r
        SET r.STATUS = new_status
        WHERE r.NR_REZERWACJI = id_rezerwacji;
      END IF;

      EXCEPTION
        WHEN NO_FREE_SLOTS_EXCEPTION THEN
          dbms_output.put_line('There are no free slots!');
    END;
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK TO start_tran;
        RAISE;
  END;

BEGIN
  ZMIEN_STATUS_REZERWACJI(10, 'Z');
  COMMIT;
END;


--c

CREATE OR REPLACE PROCEDURE ZMIEN_LICZBE_MIEJSC(id_wyc INT, l_miejsc INT) IS
  NOT_ENOUGH_SLOTS_EXCEPTION EXCEPTION;
  taken_slots INT := 0;
  BEGIN
    SAVEPOINT start_tran;
    BEGIN
      SELECT count(*) INTO taken_slots FROM REZERWACJE r WHERE r.ID_WYCIECZKI = id_wyc AND r.STATUS != 'A';

      IF (l_miejsc >= taken_slots) THEN
        UPDATE WYCIECZKI w
        SET w.LICZBA_MIEJSC = l_miejsc
        WHERE w.ID_WYCIECZKI = id_wyc;
      ELSE
        RAISE NOT_ENOUGH_SLOTS_EXCEPTION;
      END IF;

      EXCEPTION
        WHEN NOT_ENOUGH_SLOTS_EXCEPTION THEN
          dbms_output.put_line('There is not enough slots!');
    END;
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK TO start_tran;
        RAISE;
  END;


BEGIN
  ZMIEN_LICZBE_MIEJSC(21, 5);
  COMMIT;
END;









--6

CREATE TABLE REZERWACJE_LOG
(
  ID INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
  ID_REZERWACJI INT NOT NULL,
  DATA DATE DEFAULT CURRENT_DATE,
  STATUS CHAR(1) NOT NULL,

  CONSTRAINT REZERWACJE_LOG_REZERWACJE_NR_REZERWACJI_fk
    FOREIGN KEY(ID_REZERWACJI)
    REFERENCES REZERWACJE(NR_REZERWACJI)
);


CREATE OR REPLACE PROCEDURE DODAJ_REZERWACJE(id_wyc INT, id_os INT) IS
  check_slots BOOLEAN;
  trip_date DATE;
  TRIP_ALREADY_STARTED_EXCEPTION EXCEPTION;
  NO_FREE_SLOTS_EXCEPTION EXCEPTION;
  nr_rezerwacji INT;
  BEGIN
    SAVEPOINT start_tran;
    BEGIN
      SELECT w.DATA INTO trip_date FROM WYCIECZKI w WHERE w.ID_WYCIECZKI = id_wyc;
      IF CHECK_DATES(SYSDATE, trip_date) = FALSE THEN
        RAISE TRIP_ALREADY_STARTED_EXCEPTION;
      END IF;
      IF CHECK_FREE_SLOTS(id_wyc) = FALSE THEN
        RAISE NO_FREE_SLOTS_EXCEPTION;
      END IF;

      INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
      VALUES (id_wyc, id_os,'N')
      RETURNING NR_REZERWACJI INTO nr_rezerwacji;

      INSERT INTO REZERWACJE_LOG(ID_REZERWACJI, STATUS)
      VALUES (nr_rezerwacji, 'N');

      EXCEPTION
        WHEN TRIP_ALREADY_STARTED_EXCEPTION THEN
          dbms_output.put_line('Passed date refers to the past!');
        WHEN NO_FREE_SLOTS_EXCEPTION THEN
          dbms_output.put_line('There are no free slots!');
    END;

    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK TO start_tran;
        RAISE;
  END;

BEGIN
  DODAJ_REZERWACJE(21, 25);
  COMMIT;
END;


CREATE OR REPLACE PROCEDURE ZMIEN_STATUS_REZERWACJI(id_rez INT, new_status CHAR) IS
  NO_FREE_SLOTS_EXCEPTION EXCEPTION;
  cur_status CHAR;
  trip_id INT;
  BEGIN
    SAVEPOINT start_tran;
    BEGIN
      SELECT r.STATUS INTO cur_status FROM REZERWACJE r WHERE r.NR_REZERWACJI = id_rez;
      SELECT r.ID_WYCIECZKI INTO trip_id FROM REZERWACJE r WHERE r.NR_REZERWACJI = id_rez;

      IF (cur_status = 'A' AND new_status != 'A' AND CHECK_FREE_SLOTS(trip_id) = FALSE) THEN
        RAISE NO_FREE_SLOTS_EXCEPTION;
      ELSE
        UPDATE REZERWACJE r
        SET r.STATUS = new_status
        WHERE r.NR_REZERWACJI = id_rez;

        INSERT INTO REZERWACJE_LOG(ID_REZERWACJI, STATUS)
        VALUES (id_rez, new_status);
      END IF;

      EXCEPTION
        WHEN NO_FREE_SLOTS_EXCEPTION THEN
          dbms_output.put_line('There are no free slots!');
    END;
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK TO start_tran;
        RAISE;
  END;


BEGIN
  ZMIEN_STATUS_REZERWACJI(61, 'Z');
  COMMIT;
END;









--7

ALTER TABLE WYCIECZKI
ADD LICZBA_WOLNYCH_MIEJSC INT;

CREATE OR REPLACE PROCEDURE FIX_SLOTS_GET(proc_cursor OUT SYS_REFCURSOR) IS
  BEGIN
    OPEN proc_cursor FOR
    SELECT
      w.ID_WYCIECZKI,
      w.LICZBA_MIEJSC
    FROM WYCIECZKI w;
  END;


CREATE OR REPLACE PROCEDURE FIX_SLOTS IS
  c_cursor SYS_REFCURSOR;
  c_id WYCIECZKI.ID_WYCIECZKI%TYPE;
  c_amount WYCIECZKI.LICZBA_MIEJSC%TYPE; -- DEFAULT WYCIECZKI.LICZBA_MIEJSC;
  BEGIN
    FIX_SLOTS_GET(proc_cursor => c_cursor);
    LOOP
      FETCH c_cursor
      INTO c_id, c_amount;
      EXIT WHEN c_cursor%NOTFOUND;
      SELECT count(*) INTO c_amount FROM REZERWACJE r WHERE r.ID_WYCIECZKI = c_id AND r.STATUS != 'A';
      UPDATE WYCIECZKI w
      SET w.LICZBA_WOLNYCH_MIEJSC = w.LICZBA_MIEJSC - c_amount
      WHERE w.ID_WYCIECZKI = c_id;
    END LOOP;
    CLOSE c_cursor;
  END;


BEGIN
  FIX_SLOTS();
  COMMIT;
END;


CREATE VIEW WYCIECZKI_MIEJSCA2 AS SELECT
 w.ID_WYCIECZKI,
 w.NAZWA,
 w.KRAJ,
 w.LICZBA_MIEJSC,
 w.LICZBA_WOLNYCH_MIEJSC
  FROM WYCIECZKI w;


CREATE VIEW DOSTEPNE_WYCIECZKI2 AS SELECT
 w.ID_WYCIECZKI,
 w.NAZWA,
 w.KRAJ,
 w.LICZBA_MIEJSC,
 w.LICZBA_WOLNYCH_MIEJSC
  FROM WYCIECZKI w
  WHERE  w.LICZBA_WOLNYCH_MIEJSC > 0;


CREATE OR REPLACE PROCEDURE ZMIEN_STATUS_REZERWACJI(id_rez INT, new_status CHAR) IS
  NO_FREE_SLOTS_EXCEPTION EXCEPTION;
  cur_status CHAR;
  trip_id INT;
  BEGIN
    SAVEPOINT start_tran;
    BEGIN
      SELECT r.STATUS INTO cur_status FROM REZERWACJE r WHERE r.NR_REZERWACJI = id_rez;
      SELECT r.ID_WYCIECZKI INTO trip_id FROM REZERWACJE r WHERE r.NR_REZERWACJI = id_rez;

      IF (cur_status = 'A' AND new_status != 'A' AND CHECK_FREE_SLOTS(trip_id) = FALSE) THEN
        RAISE NO_FREE_SLOTS_EXCEPTION;
      ELSE
        IF (cur_status != 'A' AND new_status = 'A') THEN
          UPDATE WYCIECZKI w
          SET w.LICZBA_WOLNYCH_MIEJSC = w.LICZBA_WOLNYCH_MIEJSC + 1
          WHERE w.ID_WYCIECZKI = trip_id;
        ELSE
          IF (cur_status = 'A' AND new_status != 'A') THEN
            UPDATE WYCIECZKI w
            SET w.LICZBA_WOLNYCH_MIEJSC = w.LICZBA_WOLNYCH_MIEJSC - 1
            WHERE w.ID_WYCIECZKI = trip_id;
          END IF;
        END IF;
        UPDATE REZERWACJE r
        SET r.STATUS = new_status
        WHERE r.NR_REZERWACJI = id_rez;

        INSERT INTO REZERWACJE_LOG(ID_REZERWACJI, STATUS)
        VALUES (id_rez, new_status);
      END IF;

      EXCEPTION
        WHEN NO_FREE_SLOTS_EXCEPTION THEN
          dbms_output.put_line('There are no free slots!');
    END;
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK TO start_tran;
        RAISE;
  END;


BEGIN
  ZMIEN_STATUS_REZERWACJI(1, 'A');
  COMMIT;
END;


CREATE OR REPLACE PROCEDURE DODAJ_REZERWACJE(id_wyc INT, id_os INT) IS
  check_slots BOOLEAN;
  trip_date DATE;
  TRIP_ALREADY_STARTED_EXCEPTION EXCEPTION;
  NO_FREE_SLOTS_EXCEPTION EXCEPTION;
  nr_rezerwacji INT;
  BEGIN
    SAVEPOINT start_tran;
    BEGIN
      SELECT w.DATA INTO trip_date FROM WYCIECZKI w WHERE w.ID_WYCIECZKI = id_wyc;
      IF CHECK_DATES(SYSDATE, trip_date) = FALSE THEN
        RAISE TRIP_ALREADY_STARTED_EXCEPTION;
      END IF;
      IF CHECK_FREE_SLOTS(id_wyc) = FALSE THEN
        RAISE NO_FREE_SLOTS_EXCEPTION;
      END IF;

      INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
      VALUES (id_wyc, id_os,'N')
      RETURNING NR_REZERWACJI INTO nr_rezerwacji;

      INSERT INTO REZERWACJE_LOG(ID_REZERWACJI, STATUS)
      VALUES (nr_rezerwacji, 'N');

      UPDATE WYCIECZKI w
      SET w.LICZBA_WOLNYCH_MIEJSC = w.LICZBA_WOLNYCH_MIEJSC - 1
      WHERE w.ID_WYCIECZKI = id_wyc;

      EXCEPTION
        WHEN TRIP_ALREADY_STARTED_EXCEPTION THEN
          dbms_output.put_line('Passed date refers to the past!');
        WHEN NO_FREE_SLOTS_EXCEPTION THEN
          dbms_output.put_line('There are no free slots!');
    END;

    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK TO start_tran;
        RAISE;
  END;


BEGIN
  DODAJ_REZERWACJE(21, 23);
  COMMIT;
END;









--8 and 9

CREATE OR REPLACE TRIGGER BEFORE_NOWA_REZERWACJA
BEFORE INSERT
  ON REZERWACJE
FOR EACH ROW
  DECLARE
    wyc WYCIECZKI%ROWTYPE;
  BEGIN
    dbms_output.put_line('running before trigger');
    SELECT * INTO wyc FROM WYCIECZKI w WHERE w.ID_WYCIECZKI = :new.ID_WYCIECZKI;

    IF SYSDATE > wyc.DATA THEN
        raise_application_error(-20021, 'trip has already started');
    END IF;
    IF wyc.LICZBA_WOLNYCH_MIEJSC = 0 THEN
        raise_application_error(-20022, 'no free slots left');
    END IF;
  END;


CREATE OR REPLACE TRIGGER AFTER_NOWA_REZERWACJA
AFTER INSERT
  ON REZERWACJE
FOR EACH ROW
  DECLARE
    wyc WYCIECZKI%ROWTYPE;
  BEGIN
    dbms_output.put_line('running after trigger');
    SELECT * INTO wyc FROM WYCIECZKI w WHERE w.ID_WYCIECZKI = :new.ID_WYCIECZKI;
    INSERT INTO REZERWACJE_LOG(ID_REZERWACJI, STATUS)
    VALUES (:new.NR_REZERWACJI, 'N');
    UPDATE WYCIECZKI w
    SET w.LICZBA_WOLNYCH_MIEJSC = w.LICZBA_WOLNYCH_MIEJSC - 1
    WHERE w.ID_WYCIECZKI = wyc.ID_WYCIECZKI;
  END;


CREATE OR REPLACE PROCEDURE DODAJ_REZERWACJE(id_wyc INT, id_os INT) IS
  BEGIN
    SAVEPOINT start_tran;
    BEGIN
      INSERT INTO REZERWACJE(id_wycieczki, id_osoby, status)
      VALUES (id_wyc, id_os,'N');
    END;
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK TO start_tran;
        RAISE;
  END;


BEGIN
  DODAJ_REZERWACJE(21, 61);
END;


CREATE OR REPLACE PROCEDURE ZMIEN_STATUS_REZERWACJI(id_rez INT, new_status CHAR) IS
  BEGIN
    SAVEPOINT start_tran;
    BEGIN
        UPDATE REZERWACJE r
        SET r.STATUS = new_status
        WHERE r.NR_REZERWACJI = id_rez;
    END;
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK TO start_tran;
        RAISE;
  END;
  
  
  
  
CREATE OR REPLACE TRIGGER BEFORE_ZMIANA_REZERWACJI
BEFORE UPDATE
  ON REZERWACJE
FOR EACH ROW
  DECLARE
    free_slots INT;
  BEGIN
    SELECT w.LICZBA_WOLNYCH_MIEJSC INTO free_slots FROM WYCIECZKI w WHERE w.ID_WYCIECZKI = :OLD.ID_WYCIECZKI;
    IF (:OLD.STATUS = 'A' AND :NEW.STATUS != 'A' AND free_slots <= 0) THEN
        raise_application_error(-20022, 'no free slots left');
    END IF;
  END;
  
  
  
CREATE OR REPLACE TRIGGER AFTER_ZMIANA_REZERWACJI
AFTER UPDATE
  ON REZERWACJE
FOR EACH ROW
    BEGIN
        IF (:OLD.STATUS != 'A' AND :NEW.STATUS = 'A') THEN
            UPDATE WYCIECZKI w
            SET w.LICZBA_WOLNYCH_MIEJSC = w.LICZBA_WOLNYCH_MIEJSC + 1
            WHERE w.ID_WYCIECZKI = :OLD.ID_WYCIECZKI;
        ELSE
            IF (:OLD.STATUS = 'A' AND :NEW.STATUS != 'A') THEN
              UPDATE WYCIECZKI w
              SET w.LICZBA_WOLNYCH_MIEJSC = w.LICZBA_WOLNYCH_MIEJSC - 1
              WHERE w.ID_WYCIECZKI = :OLD.ID_WYCIECZKI;
            END IF;
        END IF;
        
        INSERT INTO REZERWACJE_LOG(ID_REZERWACJI, STATUS)
        VALUES (:NEW.NR_REZERWACJI, :NEW.STATUS);
    END;
  
  
BEGIN
    ZMIEN_STATUS_REZERWACJI(41, 'Z');
END;




CREATE OR REPLACE TRIGGER BEFORE_USUNIECIE_REZERWACJI
BEFORE DELETE
  ON REZERWACJE
  BEGIN
    raise_application_error(-20023, 'you can''t delete reservation');
  END;


DELETE FROM REZERWACJE
WHERE NR_REZERWACJI = 166;


CREATE OR REPLACE TRIGGER BEFORE_ZMIANA_LICZBY_MIEJSC
BEFORE UPDATE
    ON WYCIECZKI
FOR EACH ROW
    DECLARE
        taken_slots INT := 0;
    BEGIN
        SELECT count(*) INTO taken_slots FROM REZERWACJE r WHERE r.ID_WYCIECZKI = :OLD.ID_WYCIECZKI AND r.STATUS != 'A';
        IF (:NEW.LICZBA_MIEJSC < taken_slots) THEN
            raise_application_error(-20022, 'not enough free slots');
        END IF;
    END;


CREATE OR REPLACE PROCEDURE ZMIEN_LICZBE_MIEJSC(id_wyc INT, l_miejsc INT) IS
      taken_slots INT := 0;
      max_slots INT;
  BEGIN
    SAVEPOINT start_tran;
    BEGIN
        SELECT count(*) INTO taken_slots FROM REZERWACJE r WHERE r.ID_WYCIECZKI = id_wyc AND r.STATUS != 'A';
        SELECT w.LICZBA_MIEJSC INTO max_slots FROM WYCIECZKI w WHERE w.ID_WYCIECZKI = id_wyc;
        UPDATE WYCIECZKI w
        SET w.LICZBA_WOLNYCH_MIEJSC = l_miejsc - taken_slots, w.LICZBA_MIEJSC = l_miejsc
        WHERE w.ID_WYCIECZKI = id_wyc;
    END;
    EXCEPTION
        WHEN OTHERS THEN
           ROLLBACK TO start_tran;
           RAISE;
  END;


BEGIN
  ZMIEN_LICZBE_MIEJSC(21, 5);
  COMMIT;
END;
