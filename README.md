<h1 align="center">Oracl SQL Criminal Record Database</h1>
<h4 align="center"><i>Individual project for my Databases Class</i></h2>

# Description
This database is designed to showcase several important features of SQL, including Many-to-Many links, hierarchical relations, and Data Manipulation Language (DML) statements.

# DML statement examples:

> display the officer hierarchical tree
```SQL
SELECT LEVEL-1 RANK, RANK RANK_NAME, FIRST_NAME, LAST_NAME, SYS_CONNECT_BY_PATH(FIRST_NAME, '/') CHIEF_NAME
FROM P_OFFICER_INFO
CONNECT BY PRIOR OFFICER_INFO_ID = CHIEF_ID
START WITH OFFICER_INFO_ID = 1
ORDER BY LEVEL;
```

> update the salary table by giving each officer a bonus based on how many cases the have
```SQL
MERGE INTO p_salary s
USING (SELECT officer_info_id, COUNT(officer_info_id) AS no_cases FROM p_involved_officers GROUP BY officer_info_id ORDER BY officer_info_id) w
ON (s.officer_info_id = w.officer_info_id)
WHEN MATCHED THEN
UPDATE SET s.bonus = s.bonus + (w.no_cases) * 100, s.salary = s.salary + (w.no_cases) * 100
WHEN NOT MATCHED THEN
INSERT (s.officer_info_id, salary, bonus)
VALUES (w.officer_info_id, 9000 + w.no_cases * 100, w.no_cases * 100);
```

> select the officers that have a salary < 10'000 and are below 30 years of age
```SQL
SELECT i.OFFICER_INFO_ID, FIRST_NAME, LAST_NAME, SALARY
FROM P_OFFICER_INFO i, P_SALARY s
WHERE AGE < 30 AND i.OFFICER_INFO_ID = s.OFFICER_INFO_ID
INTERSECT
SELECT i.OFFICER_INFO_ID, FIRST_NAME, LAST_NAME, SALARY
FROM P_OFFICER_INFO i, P_SALARY s
WHERE salary < 10000 AND i.OFFICER_INFO_ID = s.OFFICER_INFO_ID;
```

# Database schema
The database comprises of several tables shown in the following image:

   <img src="https://github.com/v4n00/mti-criminal-database/blob/master/project%20files/database%20schema.png?raw=true" alt="Database schema" />
