--GRANT UNLIMITED TABLESPACE TO VShkrabatovskaya;
--SELECT * from dba_data_files ;
--select * from USER_tablespaces;
alter session set current_schema=sa_employees;
alter user sa_employees QUOTA UNLIMITED ON ts_sa_employees_data_01;

alter session set current_schema=sa_employees;
GRANT SELECT ON SA_EMPLOYEE_DATA_TOTAL  TO DW_CL;

alter session set current_schema=sa_customers;
GRANT SELECT ON SA_CUSTOMER_DATA  TO SA_EMPLOYEE_DATA;
alter session set current_schema = sa_employees;

select * from sa_customers.SA_CUSTOMER_DATA_total
order by 1;

SELECT *   
FROM sa_employees.SA_EMPLOYEE_DATA
ORDER BY 1;

select * from sa_customers.SA_CUSTOMER_DATA_total left outer join sa_employees.SA_EMPLOYEE_DATA
on sa_customers.SA_CUSTOMER_DATA_total.TOTAL_ID = sa_employees.SA_EMPLOYEE_DATA.EMPLOYEE_ID
order by 1;

select count(*) from sa_customers.SA_CUSTOMER_DATA_total left outer join sa_employees.SA_EMPLOYEE_DATA
on sa_customers.SA_CUSTOMER_DATA_total.TOTAL_ID = sa_employees.SA_EMPLOYEE_DATA.EMPLOYEE_ID
order by 1;

--------------------------------
--DROP TABLE SA_EMPLOYEE_DATA;
CREATE TABLE SA_EMPLOYEE_DATA
(   employee_ID             NUMBER (10),
    employee_first_name     VARCHAR2 (40),
    employee_last_name      VARCHAR2 (40),
    employee_position       VARCHAR2 (40),
    employee_salary_project DECIMAL (30,2)   
)
TABLESPACE ts_sa_employees_data_01;

--
INSERT INTO SA_EMPLOYEE_DATA
    WITH cte_fn AS (
        SELECT
            1      AS id
          , 'Alex'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            2      AS id
          , 'Billie'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            3      AS id
          , 'Chris'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            4      AS id
          , 'Frankie'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            5      AS id
          , 'Jackie'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            6      AS id
          , 'Nat'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            7      AS id
          , 'Robbie'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            8      AS id
          , 'Ronnie'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            9      AS id
          , 'Sam'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            10      AS id
          , 'Steph'  AS a
        FROM
            dual
         UNION ALL
        SELECT
            11      AS id
          , 'Terry'  AS a
        FROM
            dual
        ), cte_ln AS (
        SELECT
            1         AS id
          , 'Abramson'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            2          AS id
          , 'Barnes'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            3        AS id
          , 'Campbell'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            4         AS id
          , 'Delon'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            5         AS id
          , 'Enderson'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            6         AS id
          , 'Foster'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            7          AS id
          , 'Gauss'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            8        AS id
          , 'Hasse'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            9         AS id
          , 'Joukowski'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            10         AS id
          , 'Kendall'  AS a
        FROM
            dual
         UNION ALL
        SELECT
            11         AS id
          , 'Leverett'  AS a
        FROM
            dual
      ), cte_p AS (
        SELECT
            1         AS id
          , 'specialist'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            2          AS id
          , 'manager'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            3        AS id
          , 'head'  AS a
        FROM
            dual
    ), cte_gen AS (
        SELECT
            a.*
          , trunc(dbms_random.value(1, 11))           AS id_fn
          , trunc(dbms_random.value(1, 11))           AS id_ln
          , trunc(dbms_random.value(1, 3))            AS id_p
          , trunc(dbms_random.value(50, 500))         AS id_esal 
        FROM
            (
                SELECT
                    ROWNUM rn
                FROM
                    dual
                CONNECT BY
                    level <= 336000
            ) a
    )
    SELECT
        g.rn
      , fn.a
      , ln.a
      , p.a
      , id_esal
    FROM
        cte_gen  g
        LEFT OUTER JOIN cte_fn   fn ON g.id_fn = fn.id
        LEFT OUTER JOIN cte_ln   ln ON g.id_ln = ln.id
        LEFT OUTER JOIN cte_p     p ON g.id_p = p.id
        ;
--

SELECT *  
FROM SA_EMPLOYEE_DATA
ORDER BY 1;

SELECT count(*)  
FROM SA_EMPLOYEE_DATA
ORDER BY 1;

alter session set current_schema=sa_employees;

with cte_emp AS (
select distinct employee_first_name, employee_last_name
from SA_EMPLOYEE_DATA
order by 2)
select count (*) from cte_emp;

--drop table unique_employee; 
create table unique_emp AS 
select distinct employee_first_name, employee_last_name
from SA_EMPLOYEE_DATA
order by 2;

--DROP TABLE unique_emp_total
create table unique_emp_total AS
select 
TRUNC(DBMS_RANDOM.VALUE(100000000,999999999)) as employee_passport_ID,
unique_emp.*, 
CONCAT(CONCAT (CONCAT(employee_first_name, '.'), employee_last_name), '@gmail.com') AS employee_email,
CONCAT(CONCAT(CONCAT (CONCAT(TRUNC(DBMS_RANDOM.VALUE(100,999)), '-'), TRUNC(DBMS_RANDOM.VALUE(100,999))),'-'), TRUNC(DBMS_RANDOM.VALUE(100,999))) AS employee_office_phone,
CONCAT(CONCAT(CONCAT (CONCAT(TRUNC(DBMS_RANDOM.VALUE(100,999)), '-'), TRUNC(DBMS_RANDOM.VALUE(100,999))),'-'), TRUNC(DBMS_RANDOM.VALUE(100,999))) AS employee_mobile_phone,
TO_DATE(TRUNC(DBMS_RANDOM.VALUE(
            TO_CHAR(TO_DATE('01-01-2019','dd-mm-yyyy'),'J'),
             TO_CHAR(TO_DATE('01-01-2021','dd-mm-yyyy'),'J'))),'J') as employee_date_of_hire,
TO_DATE(TRUNC(DBMS_RANDOM.VALUE(
            TO_CHAR(TO_DATE('01-09-2022','dd-mm-yyyy'),'J'),
             TO_CHAR(TO_DATE('01-01-2024','dd-mm-yyyy'),'J'))),'J') as employee_date_end_of_contract,
'Y' as current_flg
from unique_emp
order by 3;

select count(*) from unique_emp_total;

--DROP table SA_EMPLOYEE_DATA_TOTAL; 
Create table SA_EMPLOYEE_DATA_TOTAL AS
SELECT SA_EMPLOYEE_DATA.employee_ID, SA_EMPLOYEE_DATA.employee_first_name, SA_EMPLOYEE_DATA.employee_last_name, SA_EMPLOYEE_DATA.employee_position, SA_EMPLOYEE_DATA.employee_salary_project, 
unique_emp_total.employee_passport_ID, unique_emp_total.employee_email, unique_emp_total.employee_office_phone, unique_emp_total.employee_mobile_phone, unique_emp_total.employee_date_of_hire, unique_emp_total.employee_date_end_of_contract,unique_emp_total.current_flg 
FROM SA_EMPLOYEE_DATA left outer join unique_emp_total on SA_EMPLOYEE_DATA.employee_first_name=unique_emp_total.employee_first_name and SA_EMPLOYEE_DATA.employee_last_name = unique_emp_total.employee_last_name
ORDER BY 1;

select * from SA_EMPLOYEE_DATA_TOTAL;
select count(*) from SA_EMPLOYEE_DATA_TOTAL;

--drop TABLESPACE ts_sa_customers_data_01 INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;
--select segment_name, segment_type from user_segments;
--PURGE RECYCLEBIN;
