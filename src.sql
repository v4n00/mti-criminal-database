-- deleting the tables
DROP TABLE p_captivity_history CASCADE CONSTRAINTS;
DROP TABLE p_crime_history CASCADE CONSTRAINTS;
DROP TABLE p_criminals CASCADE CONSTRAINTS;
DROP TABLE p_involved_officers CASCADE CONSTRAINTS;
DROP TABLE p_involved_victims CASCADE CONSTRAINTS;
DROP TABLE p_officer_info CASCADE CONSTRAINTS;
DROP TABLE p_victim_info CASCADE CONSTRAINTS;
DROP TABLE p_salary CASCADE CONSTRAINTS;

-- creating the tables
CREATE TABLE p_criminals
(
 cnp NUMBER(13),
 criminal_id NUMBER(6) CONSTRAINT c_pk PRIMARY KEY,
 captivity_history_id NUMBER(6) UNIQUE,
 first_name VARCHAR2(30),
 last_name VARCHAR2(30),
 age NUMBER(2),
 gender CHAR(1),
 address VARCHAR2(40),
 remarks VARCHAR2(1000)
);

CREATE TABLE p_crime_history
(
 crime_id NUMBER(6) CONSTRAINT ch_pk PRIMARY KEY,
 criminal_id NUMBER(6) CONSTRAINT ch_fk REFERENCES p_criminals(criminal_id),
 officer_id NUMBER(6) UNIQUE,
 victim_id NUMBER(6) UNIQUE,
 crime_date DATE,
 offense VARCHAR2(100),
 address VARCHAR2(40),
 region CHAR(2)
); 

CREATE TABLE p_captivity_history
(
 cell NUMBER(1),
 date_incarcerated DATE,
 date_freed DATE,
 captivity_id NUMBER(6) CONSTRAINT caph_fk REFERENCES p_criminals(captivity_history_id),
 CONSTRAINT caph_pk PRIMARY KEY (cell,date_incarcerated)
);

CREATE TABLE p_officer_info
(
 officer_info_id NUMBER(6) CONSTRAINT oi_pk PRIMARY KEY,
 first_name VARCHAR2(30),
 last_name VARCHAR2(30),
 rank VARCHAR2(20),
 chief_id NUMBER(6),
 age NUMBER(2),
 CONSTRAINT chief_fk FOREIGN KEY (CHIEF_ID) REFERENCES P_OFFICER_INFO (OFFICER_INFO_ID)
);

CREATE TABLE p_involved_officers
(
 officer_id NUMBER(6),
 officer_info_id NUMBER(6),
 date_assigned DATE,
 CONSTRAINT io_pk PRIMARY KEY (officer_id, officer_info_id),
 CONSTRAINT io_fk1 FOREIGN KEY (officer_id) REFERENCES p_crime_history (officer_id),
 CONSTRAINT io_fk2 FOREIGN KEY (officer_info_id) REFERENCES p_officer_info (officer_info_id)
);

CREATE TABLE p_victim_info
(
 victim_info_id NUMBER(6) CONSTRAINT vi_pk PRIMARY KEY,
 first_name VARCHAR2(30),
 last_name VARCHAR2(30),
 age NUMBER(2),
 gender CHAR(1),
 address VARCHAR2(40)
);

CREATE TABLE p_involved_victims
(
 victim_id NUMBER(6),
 victim_info_id NUMBER(6),
 has_insurance CHAR(1),
 CONSTRAINT iv_pk PRIMARY KEY (victim_id, victim_info_id),
 CONSTRAINT iv_fk1 FOREIGN KEY (victim_id) REFERENCES p_crime_history (victim_id),
 CONSTRAINT iv_fk2 FOREIGN KEY (victim_info_id) REFERENCES p_victim_info (victim_info_id)
);

CREATE TABLE p_salary
(
 officer_info_id NUMBER(6) CONSTRAINT sal_fk REFERENCES p_officer_info(officer_info_id),
 salary NUMBER(6) DEFAULT 9000,
 bonus NUMBER(6),
 CONSTRAINT sal_uni UNIQUE (officer_info_id)
);

-- inserting the data
-- p_criminals
INSERT INTO p_criminals (cnp, criminal_id, captivity_history_id, first_name, last_name, age, gender, address, remarks) VALUES (6073683838378, 1, 1, 'Marisa', 'Kirisame', 25, 'f', 'Str Greensage 63', null); 
INSERT INTO p_criminals (cnp, criminal_id, captivity_history_id, first_name, last_name, age, gender, address, remarks) VALUES (6038536829398, 2, 2, 'Flandre', 'Scarlet', 21, 'f', 'Str Ogoal 7', null);
INSERT INTO p_criminals (cnp, criminal_id, captivity_history_id, first_name, last_name, age, gender, address, remarks) VALUES (6094536537363, 3, 3, 'Remilia', 'Scarlet', 21, 'f', 'Str Ogoal 7', 'under house arrest'); 
INSERT INTO p_criminals (cnp, criminal_id, captivity_history_id, first_name, last_name, age, gender, address, remarks) VALUES (5039579378368, 4, 4, 'Jak', 'Mar', 37, 'm', 'Str Klaw 15', 'psychiatric problems'); 
INSERT INTO p_criminals (cnp, criminal_id, captivity_history_id, first_name, last_name, age, gender, address, remarks) VALUES (5085547536482, 5, 5, 'Karlsefni', 'Thorfinn', 19, 'm', 'Str Igubun 37', null); 
INSERT INTO p_criminals (cnp, criminal_id, captivity_history_id, first_name, last_name, age, gender, address, remarks) VALUES (6072686799263, 6, 6, 'Patchouli', 'Knowledge', 38, 'f', 'Str Librariei 7', 'psychiatric problems'); 

-- p_crime_history
INSERT INTO p_crime_history (crime_id, criminal_id, officer_id, victim_id, crime_date, offense, address, region) VALUES (1, 1, 1, 1, TO_DATE('21-05-2022','DD-MM-RRRR'), 'theft', 'Str Gensokyo 223', 'IC');
INSERT INTO p_crime_history (crime_id, criminal_id, officer_id, victim_id, crime_date, offense, address, region) VALUES (2, 1, 2, 2, TO_DATE('17-09-2021','DD-MM-RRRR'), 'assault', 'Str Daxter 19', 'IC');
INSERT INTO p_crime_history (crime_id, criminal_id, officer_id, victim_id, crime_date, offense, address, region) VALUES (3, 1, 3, 3, TO_DATE('05-03-2021','DD-MM-RRRR'), 'disorderly conduct', 'Str Gol 44', 'IC');
INSERT INTO p_crime_history (crime_id, criminal_id, officer_id, victim_id, crime_date, offense, address, region) VALUES (4, 2, 4, 4, TO_DATE('29-01-2020','DD-MM-RRRR'), 'littering', 'Str Maya 98', 'BR');
INSERT INTO p_crime_history (crime_id, criminal_id, officer_id, victim_id, crime_date, offense, address, region) VALUES (5, 3, 5, 5, TO_DATE('02-03-2022','DD-MM-RRRR'), 'traffic offense', 'Str Sunken 42', 'YU');
INSERT INTO p_crime_history (crime_id, criminal_id, officer_id, victim_id, crime_date, offense, address, region) VALUES (6, 3, 6, 6, TO_DATE('09-05-2022','DD-MM-RRRR'), 'traffic offense', 'Str Precursor 26', 'YU');
INSERT INTO p_crime_history (crime_id, criminal_id, officer_id, victim_id, crime_date, offense, address, region) VALUES (7, 4, 7, 7, TO_DATE('30-12-2021','DD-MM-RRRR'), 'hunting without a license', 'Str Bullet 4', 'TC');
INSERT INTO p_crime_history (crime_id, criminal_id, officer_id, victim_id, crime_date, offense, address, region) VALUES (8, 5, 8, 8, TO_DATE('08-05-2020','DD-MM-RRRR'), 'excessive noise', 'Str Sumap 172', 'HL');

-- p_captivity_history
INSERT INTO p_captivity_history (cell, date_incarcerated, date_freed, captivity_id) VALUES (1, TO_DATE('05-03-2021', 'DD-MM-RRRR'), TO_DATE('22-03-2022', 'DD-MM-RRRR'), 1);
INSERT INTO p_captivity_history (cell, date_incarcerated, date_freed, captivity_id) VALUES (1, TO_DATE('17-09-2021', 'DD-MM-RRRR'), TO_DATE('17-10-2022', 'DD-MM-RRRR'), 1);
INSERT INTO p_captivity_history (cell, date_incarcerated, date_freed, captivity_id) VALUES (3, TO_DATE('02-03-2022', 'DD-MM-RRRR'), TO_DATE('03-03-2022', 'DD-MM-RRRR'), 3);
INSERT INTO p_captivity_history (cell, date_incarcerated, date_freed, captivity_id) VALUES (2, TO_DATE('09-05-2022', 'DD-MM-RRRR'), TO_DATE('10-05-2022', 'DD-MM-RRRR'), 3);
INSERT INTO p_captivity_history (cell, date_incarcerated, date_freed, captivity_id) VALUES (2, TO_DATE('30-12-2021', 'DD-MM-RRRR'), TO_DATE('30-01-2022', 'DD-MM-RRRR'), 4);
INSERT INTO p_captivity_history (cell, date_incarcerated, date_freed, captivity_id) VALUES (1, TO_DATE('08-05-2020', 'DD-MM-RRRR'), TO_DATE('15-05-2020', 'DD-MM-RRRR'), 5);

-- p_officer_info
INSERT INTO p_officer_info (officer_info_id, first_name, last_name, rank, chief_id, age) VALUES (1, 'Hecatia', 'Lapislazuli', 'captain', null, 28);
INSERT INTO p_officer_info (officer_info_id, first_name, last_name, rank, chief_id, age) VALUES (2, 'Keiki', 'Haniyasushin', 'corporal', 1, 25);
INSERT INTO p_officer_info (officer_info_id, first_name, last_name, rank, chief_id, age) VALUES (3, 'Koishi', 'Komeiji', 'corporal', 1, 31);
INSERT INTO p_officer_info (officer_info_id, first_name, last_name, rank, chief_id, age) VALUES (4, 'Alice', 'Margatroid', 'officer', 3, 26);
INSERT INTO p_officer_info (officer_info_id, first_name, last_name, rank, chief_id, age) VALUES (5, 'Hong', 'Meiling', 'officer', 2, 29);
INSERT INTO p_officer_info (officer_info_id, first_name, last_name, rank, chief_id, age) VALUES (6, 'Minamitsu', 'Murasa', 'officer', 3, 31);
INSERT INTO p_officer_info (officer_info_id, first_name, last_name, rank, chief_id, age) VALUES (7, 'Nitori', 'Kwashiro', 'officer', 3, 26);

-- p_involved_officers
INSERT INTO p_involved_officers (officer_id, officer_info_id, date_assigned) VALUES (1, 3, TO_DATE('21-05-2022','DD-MM-RRRR'));
INSERT INTO p_involved_officers (officer_id, officer_info_id, date_assigned) VALUES (2, 1, TO_DATE('17-09-2021','DD-MM-RRRR'));
INSERT INTO p_involved_officers (officer_id, officer_info_id, date_assigned) VALUES (2, 2, TO_DATE('18-09-2021','DD-MM-RRRR'));
INSERT INTO p_involved_officers (officer_id, officer_info_id, date_assigned) VALUES (3, 4, TO_DATE('06-03-2021','DD-MM-RRRR'));
INSERT INTO p_involved_officers (officer_id, officer_info_id, date_assigned) VALUES (4, 5, TO_DATE('29-01-2020','DD-MM-RRRR'));
INSERT INTO p_involved_officers (officer_id, officer_info_id, date_assigned) VALUES (5, 4, TO_DATE('02-03-2022','DD-MM-RRRR'));
INSERT INTO p_involved_officers (officer_id, officer_info_id, date_assigned) VALUES (5, 5, TO_DATE('04-03-2022','DD-MM-RRRR'));
INSERT INTO p_involved_officers (officer_id, officer_info_id, date_assigned) VALUES (6, 7, TO_DATE('09-05-2022','DD-MM-RRRR'));
INSERT INTO p_involved_officers (officer_id, officer_info_id, date_assigned) VALUES (7, 2, TO_DATE('30-12-2021','DD-MM-RRRR'));
INSERT INTO p_involved_officers (officer_id, officer_info_id, date_assigned) VALUES (7, 7, TO_DATE('03-01-2022','DD-MM-RRRR'));
INSERT INTO p_involved_officers (officer_id, officer_info_id, date_assigned) VALUES (7, 4, TO_DATE('04-01-2022','DD-MM-RRRR'));
INSERT INTO p_involved_officers (officer_id, officer_info_id, date_assigned) VALUES (8, 7, TO_DATE('08-05-2020','DD-MM-RRRR'));

-- p_victim_info
INSERT INTO p_victim_info (victim_info_id, first_name, last_name, age, gender, address) VALUES (1, 'Ran', 'Yakumo', 28, 'f', 'Str Nue 19');
INSERT INTO p_victim_info (victim_info_id, first_name, last_name, age, gender, address) VALUES (2, 'Reisen', 'Udonge', 47, 'f', 'Str Ringo 38');
INSERT INTO p_victim_info (victim_info_id, first_name, last_name, age, gender, address) VALUES (3, 'Satori', 'Komeiji', 30, 'f', 'Str Seiran 144');
INSERT INTO p_victim_info (victim_info_id, first_name, last_name, age, gender, address) VALUES (4, 'Saimos', 'Sage', 25, 'm', 'Str Sandover 89');
INSERT INTO p_victim_info (victim_info_id, first_name, last_name, age, gender, address) VALUES (5, 'Tenshi', 'Hinanai', 45, 'f', 'Str Urumi 121');
INSERT INTO p_victim_info (victim_info_id, first_name, last_name, age, gender, address) VALUES (6, 'Tewi', 'Inaba', 62, 'f', 'Str Forma 60');
INSERT INTO p_victim_info (victim_info_id, first_name, last_name, age, gender, address) VALUES (7, 'Yuyuko', 'Saigyouji', 52, 'f', 'Str Lob 108');

-- p_involved_victims
INSERT INTO p_involved_victims (victim_id, victim_info_id, has_insurance) VALUES (1, 3, 'y');
INSERT INTO p_involved_victims (victim_id, victim_info_id, has_insurance) VALUES (1, 4, 'n');
INSERT INTO p_involved_victims (victim_id, victim_info_id, has_insurance) VALUES (1, 2, 'n');
INSERT INTO p_involved_victims (victim_id, victim_info_id, has_insurance) VALUES (2, 1, 'y');
INSERT INTO p_involved_victims (victim_id, victim_info_id, has_insurance) VALUES (2, 7, 'n');
INSERT INTO p_involved_victims (victim_id, victim_info_id, has_insurance) VALUES (3, 5, 'n');
INSERT INTO p_involved_victims (victim_id, victim_info_id, has_insurance) VALUES (5, 7, 'y');
INSERT INTO p_involved_victims (victim_id, victim_info_id, has_insurance) VALUES (8, 6, 'y');

-- p_salary
INSERT INTO p_salary(officer_info_id, salary, bonus) VALUES (1, 12000, 0);
INSERT INTO p_salary(officer_info_id, salary, bonus) VALUES (3, 11000, 0);
INSERT INTO p_salary(officer_info_id, salary, bonus) VALUES (7, 11450, 0);

-- EXERCISES
-- Examples of DDL Statements
-- add a middle name column for criminals
ALTER TABLE p_criminals ADD (middle_name VARCHAR2(20));
ALTER TABLE p_criminals DROP COLUMN middle_name;

-- change remarks by giving it a max of 500 chars
ALTER TABLE p_criminals MODIFY (remarks VARCHAR2(500));

--disable foreign key constraint
ALTER TABLE p_involved_officers DISABLE CONSTRAINT io_fk1;
ALTER TABLE p_involved_officers ENABLE CONSTRAINT io_fk1;

-- Examples of DML Statements
-- age up the criminal with age 38
UPDATE p_criminals SET age = age + 1 WHERE AGE = 38;
-- correct the IC region typo to JC
UPDATE p_crime_history SET region = 'JC' WHERE region = 'IC';
-- delete officers that dont have any cases
DELETE FROM p_officer_info WHERE officer_info_id NOT IN (SELECT officer_info_id FROM p_involved_officers);
-- now add her back
INSERT INTO p_officer_info (officer_info_id, first_name, last_name, rank, chief_id, age) VALUES (6, 'Minamitsu', 'Murasa', 'officer', 3, 31);

-- MERGE
-- update the salary table by giving each officer a bonus based on how many cases the have
-- if officers are not in the table, add them only if they have active cases
MERGE INTO p_salary s
USING (SELECT officer_info_id, COUNT(officer_info_id) AS no_cases FROM p_involved_officers GROUP BY officer_info_id ORDER BY officer_info_id) w
ON (s.officer_info_id = w.officer_info_id)
WHEN MATCHED THEN
UPDATE SET s.bonus = s.bonus + (w.no_cases) * 100, s.salary = s.salary + (w.no_cases) * 100
WHEN NOT MATCHED THEN
INSERT (s.officer_info_id, salary, bonus)
VALUES (w.officer_info_id, 9000 + w.no_cases * 100, w.no_cases * 100);

-- SELECT statements
-- display all criminals between 20 and 25 that have names ending in a
SELECT CRIMINAL_ID, FIRST_NAME, LAST_NAME, AGE
FROM P_CRIMINALS
WHERE AGE BETWEEN 20 AND 25 AND FIRST_NAME LIKE '%a';

-- display the victims that don't have insurance below 30 years of age
SELECT VICTIM_ID, FIRST_NAME, LAST_NAME, AGE, HAS_INSURANCE
FROM P_INVOLVED_VICTIMS v, P_VICTIM_INFO i
WHERE HAS_INSURANCE != 'y' AND v.VICTIM_ID = i.VICTIM_INFO_ID and i.AGE <= 30;

-- display the chief of the police department
SELECT *
FROM P_OFFICER_INFO
WHERE CHIEF_ID IS NULL;

-- display the salaries of the lowest ranks whose salary is bigger than any of their superiors
SELECT DISTINCT i.OFFICER_INFO_ID, FIRST_NAME, LAST_NAME, RANK, SALARY
FROM P_OFFICER_INFO i, P_SALARY s
WHERE rank IN ('officer') AND i.OFFICER_INFO_ID = s.OFFICER_INFO_ID
AND salary > ANY (SELECT SALARY FROM P_OFFICER_INFO i, P_SALARY s WHERE rank NOT IN ('officer') AND i.OFFICER_INFO_ID = s.OFFICER_INFO_ID);

-- display all salaries of higher ranks that have salary smaller than all of their inferiors
SELECT DISTINCT i.OFFICER_INFO_ID, FIRST_NAME, LAST_NAME, RANK, SALARY
FROM P_OFFICER_INFO i, P_SALARY s
WHERE rank NOT IN ('officer') AND i.OFFICER_INFO_ID = s.OFFICER_INFO_ID
AND salary <= ALL (SELECT SALARY FROM P_OFFICER_INFO i, P_SALARY s WHERE rank IN ('officer') AND i.OFFICER_INFO_ID = s.OFFICER_INFO_ID);

-- display all cases that happened from 2 years ago onwards
SELECT CRIME_ID, OFFENSE, REGION, CRIME_DATE
FROM P_CRIME_HISTORY
WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM CRIME_DATE) > 1;

-- display the officers which names start with K
SELECT *
FROM P_OFFICER_INFO
WHERE SUBSTR(UPPER(FIRST_NAME), 1, 1) = 'K';

-- display all criminals and the year of their most recent crime
SELECT FIRST_NAME, LAST_NAME, MAX(TO_CHAR(CRIME_DATE, 'rrrr')) LATEST_CRIME
FROM P_CRIMINALS cr, P_CRIME_HISTORY h
WHERE cr.CRIMINAL_ID = h.CRIMINAL_ID
GROUP BY FIRST_NAME, LAST_NAME;

-- display all criminals, the ones who have more than 1 crime should be labeled as repeat offenders
SELECT ch.CRIMINAL_ID, FIRST_NAME, LAST_NAME, COUNT(crime_id) NO_OF_CRIMES, 
DECODE (
COUNT(crime_id),
0, 'good citizen',
1, 'normal offender',
'repeat offender') STATUS
FROM P_CRIME_HISTORY ch, P_CRIMINALS cr
WHERE ch.CRIMINAL_ID(+) = cr.CRIMINAL_ID
GROUP BY ch.CRIMINAL_ID, first_name, last_name;

-- display all officers
-- salary < 10'000 are low paid
-- salary < 12'000, are medium paid
-- otherwise, they have high pay
SELECT DISTINCT o.OFFICER_INFO_ID, FIRST_NAME, LAST_NAME, SALARY, CASE
WHEN SALARY < 10000 THEN 'low pay'
WHEN SALARY < 12000 THEN 'medium pay'
ELSE 'high pay' END PAY_STATUS
FROM P_OFFICER_INFO o, P_SALARY s
WHERE o.OFFICER_INFO_ID = s.OFFICER_INFO_ID;

-- display the criminals with and without remarks
SELECT CRIMINAL_ID, FIRST_NAME, LAST_NAME, NVL(REMARKS, 'none') REMARKS
FROM P_CRIMINALS;

-- display the officers that dont have any cases
SELECT i.OFFICER_INFO_ID, FIRST_NAME, LAST_NAME
FROM P_OFFICER_INFO i, P_INVOLVED_OFFICERS v
WHERE i.OFFICER_INFO_ID = v.OFFICER_INFO_ID(+)
MINUS
SELECT i.OFFICER_INFO_ID, FIRST_NAME, LAST_NAME
FROM P_OFFICER_INFO i, P_INVOLVED_OFFICERS v
WHERE i.OFFICER_INFO_ID = v.OFFICER_INFO_ID;

-- select the officers that have a salary < 10'000 and are below 30 years of age
SELECT i.OFFICER_INFO_ID, FIRST_NAME, LAST_NAME, SALARY
FROM P_OFFICER_INFO i, P_SALARY s
WHERE AGE < 30 AND i.OFFICER_INFO_ID = s.OFFICER_INFO_ID
INTERSECT
SELECT i.OFFICER_INFO_ID, FIRST_NAME, LAST_NAME, SALARY
FROM P_OFFICER_INFO i, P_SALARY s
WHERE salary < 10000 AND i.OFFICER_INFO_ID = s.OFFICER_INFO_ID;

-- display the cumulated salary each rank has and give the department an investment based on that
SELECT RANK, SUM(SALARY), 0.5 * SUM(SALARY) INVESTMENT
FROM P_OFFICER_INFO i, P_SALARY s
WHERE i.OFFICER_INFO_ID = s.OFFICER_INFO_ID
GROUP BY RANK
HAVING SUM(SALARY) < 30000
UNION
SELECT RANK, SUM(SALARY),  0.1 * SUM(SALARY) INVESTMENT
FROM P_OFFICER_INFO i, P_SALARY s
WHERE i.OFFICER_INFO_ID = s.OFFICER_INFO_ID
GROUP BY RANK
HAVING SUM(SALARY) >= 30000;

-- make a view to see the criminals that have done more than 1 crime
CREATE VIEW dangerous_criminals
AS
SELECT ch.CRIMINAL_ID, FIRST_NAME, LAST_NAME, COUNT(crime_id) NO_OF_CRIMES
FROM P_CRIME_HISTORY ch, P_CRIMINALS cr
WHERE ch.CRIMINAL_ID = cr.CRIMINAL_ID
GROUP BY ch.CRIMINAL_ID, first_name, last_name
HAVING  COUNT(crime_id) > 1;

SELECT * FROM dangerous_criminals;
DROP VIEW dangerous_criminals;

-- create an index on crime date
CREATE INDEX crim_date_idx ON P_CRIME_HISTORY(CRIME_DATE);

SELECT * FROM USER_INDEXES;
DROP INDEX crim_date_idx;

-- create a synonym for captivity_history
CREATE SYNONYM P_CH FOR P_CAPTIVITY_HISTORY;

SELECT * FROM P_CH;
DROP SYNONYM P_CH;

-- make a sequence for bonus
CREATE SEQUENCE seq_bonus
START WITH 100 INCREMENT BY 100
MAXVALUE 1000 NOCYCLE;
INSERT INTO P_SALARY (OFFICER_INFO_ID, SALARY, BONUS) VALUES (6, 9000 + seq_bonus.nextval, seq_bonus.currval);

SELECT * FROM P_SALARY WHERE OFFICER_INFO_ID = 6;
DROP SEQUENCE seq_bonus;

-- display the officer tree
SELECT LEVEL-1 RANK, RANK RANK_NAME, FIRST_NAME, LAST_NAME, SYS_CONNECT_BY_PATH(FIRST_NAME, '/') CHIEF_NAME
FROM P_OFFICER_INFO
CONNECT BY PRIOR OFFICER_INFO_ID = CHIEF_ID
START WITH OFFICER_INFO_ID = 1
ORDER BY LEVEL;
