--GRANT UNLIMITED TABLESPACE TO VShkrabatovskaya;
--SELECT * from dba_data_files ;
--select * from USER_tablespaces;
alter session set current_schema=sa_employees;
alter user sa_employees QUOTA UNLIMITED ON ts_sa_employees_data_01;

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

--drop TABLESPACE ts_sa_customers_data_01 INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;
--select segment_name, segment_type from user_segments;
--PURGE RECYCLEBIN;
