--GRANT UNLIMITED TABLESPACE TO VShkrabatovskaya;
--SELECT * from dba_data_files ;
--select * from USER_tablespaces;
alter session set current_schema=sa_promotions;
alter user sa_promotions QUOTA UNLIMITED ON ts_sa_promotions_data_01;

alter session set current_schema=sa_customers;
GRANT SELECT ON SA_CUSTOMER_DATA_total TO sa_promotions;
alter session set current_schema = sa_employees;
GRANT SELECT ON SA_EMPLOYEE_DATA  TO sa_promotions;

select * from sa_customers.SA_CUSTOMER_DATA_total
order by 1;

SELECT *   
FROM sa_employees.SA_EMPLOYEE_DATA
ORDER BY 1;

SELECT *  
FROM sa_promotions.SA_PROMOTION_DATA
ORDER BY 1;

select * from sa_customers.SA_CUSTOMER_DATA_total 
left outer join sa_employees.SA_EMPLOYEE_DATA
on sa_customers.SA_CUSTOMER_DATA_total.TOTAL_ID = sa_employees.SA_EMPLOYEE_DATA.EMPLOYEE_ID
left outer join sa_promotions.SA_PROMOTION_DATA
on sa_customers.SA_CUSTOMER_DATA_total.TOTAL_ID = sa_promotions.SA_PROMOTION_DATA.PROMOTION_ID
order by 1;

select count(*) from sa_customers.SA_CUSTOMER_DATA_total 
left outer join sa_employees.SA_EMPLOYEE_DATA
on sa_customers.SA_CUSTOMER_DATA_total.TOTAL_ID = sa_employees.SA_EMPLOYEE_DATA.EMPLOYEE_ID
left outer join sa_promotions.SA_PROMOTION_DATA
on sa_customers.SA_CUSTOMER_DATA_total.TOTAL_ID = sa_promotions.SA_PROMOTION_DATA.PROMOTION_ID
order by 1;
--------------------------------------------------------------------------------
--DROP TABLE SA_PROMOTION_DATA;
CREATE TABLE SA_PROMOTION_DATA
(   promotion_ID                NUMBER (10),
    promotion_metric_amount     DECIMAL (10,2),
    promotion_price             DECIMAL (10,2),
    promotion_KPI               VARCHAR2 (30),
    promotion_distinct_percent  DECIMAL (10,2) 
)
TABLESPACE ts_sa_promotions_data_01;

--------------------------------------------------------------------------------
INSERT INTO SA_PROMOTION_DATA
    WITH cte_kpi AS (
        SELECT
            1         AS id
          , 'CPA'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            2          AS id
          , 'CPL'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            3          AS id
          , 'CPS'  AS a
        FROM
            dual
    ), cte_gen AS (
        SELECT
            a.*
          , trunc(dbms_random.value(1,100))               AS id_ma 
          , trunc(dbms_random.value(100, 1000))           AS id_pr
          , trunc(dbms_random.value(1, 3))                AS id_kpi
          , trunc(dbms_random.value(3, 20))               AS id_dp
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
      , id_ma
      , id_pr
      , kpi.a
      , id_dp
    FROM
        cte_gen  g
        LEFT OUTER JOIN cte_kpi    kpi ON g.id_kpi = kpi.id
        ;
--

SELECT *  
FROM SA_PROMOTION_DATA
ORDER BY 1;

SELECT count(*)  
FROM SA_PROMOTION_DATA
ORDER BY 1;

--drop TABLESPACE ts_sa_customers_data_01 INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;
--select segment_name, segment_type from user_segments;
--PURGE RECYCLEBIN;
