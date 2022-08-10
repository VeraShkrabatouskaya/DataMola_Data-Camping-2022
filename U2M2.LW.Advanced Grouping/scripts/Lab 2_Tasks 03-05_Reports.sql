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

--DROP TABLE SA_TRANSACTION
Create table SA_TRANSACTION as 
select * from sa_customers.SA_CUSTOMER_DATA_total 
left outer join sa_employees.SA_EMPLOYEE_DATA
on sa_customers.SA_CUSTOMER_DATA_total.TOTAL_ID = sa_employees.SA_EMPLOYEE_DATA.EMPLOYEE_ID
left outer join sa_promotions.SA_PROMOTION_DATA
on sa_customers.SA_CUSTOMER_DATA_total.TOTAL_ID = sa_promotions.SA_PROMOTION_DATA.PROMOTION_ID
order by 1
;

select * from SA_TRANSACTION;

select 
    total_id, 
    agency_name,	
    agency_city, 
    agency_country, 
    promotion_media_type, 
    promotion_KPI,
    promotion_metric_amount,
    promotion_price,
    (promotion_metric_amount*promotion_price) as cost_of_placement_without_VAT,
    promotion_distinct_percent,
    ROUND((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100)),2) as cost_without_VAT_with_discount,
    agency_VAT_percent, 
    ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_VAT_percent/100),2) as VAT_amount,
    ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))+ ((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_VAT_percent/100)),2) as cost_with_VAT_with_discount,
    agency_fee_percent,
    ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100),2) as agency_fee_amount_without_VAT,
    ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100),2) as agency_fee_amount_with_VAT,
    ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100)))+(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)),2) as total_cost_without_VAT_with_discount_with_agency_fee_amount_without_VAT,
    ROUND((((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))+ ((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_VAT_percent/100)))+(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100)),2) as total_cost_with_VAT_with_discount_with_agency_fee_amount_with_VAT,
    employee_salary_project as  employee_salary_project_without_VAT,
    ROUND(employee_salary_project*(1+ agency_VAT_percent/100),2) as employee_salary_project_with_VAT
from SA_TRANSACTION
ORDER BY 1
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

select 
    TOTAL_ID,
    TIME_ID,
    agency_name,
    agency_city,
    agency_country,
    promotion_media_type,
    ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100),2) as Revenue_GROSS,
    ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100),2) as Revenue_NET,
    ROUND(employee_salary_project*(1+ agency_VAT_percent/100),2) as Cost_GROSS,
    employee_salary_project as Cost_NET,
    ROUND((((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100))-(employee_salary_project*(1+ agency_VAT_percent/100)),2) as Profit_GROSS,
    ROUND(((((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100))-employee_salary_project),2) as Profit_NET
from SA_TRANSACTION
ORDER BY 1;

--Daily Reports •	USE: CUBE Extension

select 
    TIME_ID,
    agency_name,
    agency_city,
    agency_country,
    SUM (ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100),2)) as Revenue_GROSS,
    SUM (ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100),2)) as Revenue_NET,
    SUM (ROUND(employee_salary_project*(1+ agency_VAT_percent/100),2)) as Cost_GROSS,
    SUM (employee_salary_project) as Cost_NET,
    SUM (ROUND((((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100))-(employee_salary_project*(1+ agency_VAT_percent/100)),2)) as Profit_GROSS,
    SUM (ROUND(((((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100))-employee_salary_project),2)) as Profit_NET
from SA_TRANSACTION
GROUP BY CUBE (TIME_ID, agency_name, agency_city, agency_country)
    HAVING TIME_ID IS NOT NULL 
    and agency_name IS NOT NULL 
    and agency_city IS NOT NULL 
    and agency_country IS NOT NULL
order by TIME_ID, agency_name, agency_city, agency_country;

select 
    TIME_ID,
    customer_name,
    brand_name,
    SUM (ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100),2)) as Revenue_GROSS,
    SUM (ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100),2)) as Revenue_NET,
    SUM (ROUND(employee_salary_project*(1+ agency_VAT_percent/100),2)) as Cost_GROSS,
    SUM (employee_salary_project) as Cost_NET,
    SUM (ROUND((((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100))-(employee_salary_project*(1+ agency_VAT_percent/100)),2)) as Profit_GROSS,
    SUM (ROUND(((((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100))-employee_salary_project),2)) as Profit_NET
from SA_TRANSACTION
GROUP BY CUBE (TIME_ID, customer_name, brand_name)
    HAVING TIME_ID IS NOT NULL 
    and customer_name IS NOT NULL 
    and brand_name IS NOT NULL 
order by TIME_ID, customer_name, brand_name;

select 
    TIME_ID,
    promotion_media_type,
    SUM (ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100),2)) as Revenue_GROSS,
    SUM (ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100),2)) as Revenue_NET,
    SUM (ROUND(employee_salary_project*(1+ agency_VAT_percent/100),2)) as Cost_GROSS,
    SUM (employee_salary_project) as Cost_NET,
    SUM (ROUND((((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100))-(employee_salary_project*(1+ agency_VAT_percent/100)),2)) as Profit_GROSS,
    SUM (ROUND(((((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100))-employee_salary_project),2)) as Profit_NET
from SA_TRANSACTION
GROUP BY CUBE (TIME_ID, promotion_media_type)
    HAVING TIME_ID IS NOT NULL 
    and promotion_media_type IS NOT NULL
order by TIME_ID, promotion_media_type;
--------------------------------------------------------------------------------
--Daily Reports •	USE: Grouping() function
--------------------------------------------------------------------------------
select 
    TRUNC (TIME_ID, 'DD') as date_day,
    agency_name,
    agency_country,
    agency_city,
    SUM (ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100),2)) as Revenue_GROSS,
    SUM (ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100),2)) as Revenue_NET,
    SUM (ROUND(employee_salary_project*(1+ agency_VAT_percent/100),2)) as Cost_GROSS,
    SUM (employee_salary_project) as Cost_NET,
    SUM (ROUND((((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100))-(employee_salary_project*(1+ agency_VAT_percent/100)),2)) as Profit_GROSS,
    SUM (ROUND(((((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100))-employee_salary_project),2)) as Profit_NET,
    GROUPING(agency_name) AS f1g,
    GROUPING(agency_country) AS f2g,
    GROUPING(agency_city) AS f3g
from SA_TRANSACTION
GROUP BY TRUNC (TIME_ID, 'DD'), CUBE (agency_name, agency_country, agency_city)
    HAVING TRUNC (TIME_ID, 'DD') IS NOT NULL 
    and agency_name IS NOT NULL 
order by TRUNC (TIME_ID, 'DD'), agency_name, agency_country, agency_city;
--------------------------------------------------------------------------------
--Daily Reports •	USE: Grouping_ID function
--------------------------------------------------------------------------------
select 
    TRUNC (TIME_ID, 'DD') as date_day,
    agency_name,
    agency_country,
    agency_city,
    SUM (ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100),2)) as Revenue_GROSS,
    SUM (ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100),2)) as Revenue_NET,
    SUM (ROUND(employee_salary_project*(1+ agency_VAT_percent/100),2)) as Cost_GROSS,
    SUM (employee_salary_project) as Cost_NET,
    SUM (ROUND((((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100))-(employee_salary_project*(1+ agency_VAT_percent/100)),2)) as Profit_GROSS,
    SUM (ROUND(((((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100))-employee_salary_project),2)) as Profit_NET,
    GROUPING_ID(agency_name,agency_country,agency_city) AS grouping_id
from SA_TRANSACTION
GROUP BY TRUNC (TIME_ID, 'DD'), CUBE (agency_name, agency_country, agency_city)
    HAVING TRUNC (TIME_ID, 'DD') IS NOT NULL 
    and agency_name IS NOT NULL 
order by TRUNC (TIME_ID, 'DD'), agency_name, agency_country, agency_city;
--------------------------------------------------------------------------------
--monthly  reports •	USE: CUBE Extension
--------------------------------------------------------------------------------
select 
    TIME_ID,
    agency_city,
    employee_first_name,
    employee_last_name,    
    SUM (ROUND(employee_salary_project*(1+ agency_VAT_percent/100),2)) as employee_salary_project_GROSS,
    SUM (employee_salary_project) as employee_salary_project_NET
from SA_TRANSACTION
GROUP BY CUBE (TIME_ID, agency_city, employee_first_name, employee_last_name)
    HAVING TIME_ID IS NOT NULL 
    and agency_city IS NOT NULL
    and employee_first_name IS NOT NULL
    and employee_last_name IS NOT NULL
order by TIME_ID, agency_city, employee_first_name, employee_last_name;
--------------------------------------------------------------------------------

select 
    TIME_ID,
    brand_name,
    agency_city,
    promotion_media_type,
    COUNT (promotion_ID) as number_of_promotions
from SA_TRANSACTION
GROUP BY CUBE (TIME_ID, brand_name,  agency_city, promotion_media_type)
    HAVING TIME_ID IS NOT NULL 
    and brand_name IS NOT NULL
    and agency_city IS NOT NULL
    and promotion_media_type IS NOT NULL
order by TIME_ID, brand_name,  agency_city, promotion_media_type;
--------------------------------------------------------------------------------
select 
    TIME_ID,
    agency_name,
    agency_city,
    agency_country,
    COUNT(distinct customer_name) as number_of_customers
from SA_TRANSACTION
GROUP BY CUBE (TIME_ID, agency_name,  agency_city, agency_country)
    HAVING TIME_ID IS NOT NULL 
    and agency_name IS NOT NULL
    and agency_city IS NOT NULL
    and agency_country IS NOT NULL
order by TIME_ID, agency_name,  agency_city, agency_country;
--------------------------------------------------------------------------------
select 
    TIME_ID,
    agency_name,
    agency_city,
    agency_country,
    COUNT(distinct (employee_first_name||' '||employee_last_name)) as number_of_employees
from SA_TRANSACTION
GROUP BY CUBE (TIME_ID, agency_name,  agency_city, agency_country)
    HAVING TIME_ID IS NOT NULL 
    and agency_name IS NOT NULL
    and agency_city IS NOT NULL
    and agency_country IS NOT NULL
order by TIME_ID, agency_name,  agency_city, agency_country;
--------------------------------------------------------------------------------
--monthly  reports •	USE: ROLLUP Extension
--------------------------------------------------------------------------------
select 
    TRUNC (TIME_ID, 'MM') as date_month,
    agency_name,
    agency_country,
    agency_city,
    SUM (ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100),2)) as Revenue_GROSS,
    SUM (ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100),2)) as Revenue_NET,
    SUM (ROUND(employee_salary_project*(1+ agency_VAT_percent/100),2)) as Cost_GROSS,
    SUM (employee_salary_project) as Cost_NET,
    SUM (ROUND((((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100))-(employee_salary_project*(1+ agency_VAT_percent/100)),2)) as Profit_GROSS,
    SUM (ROUND(((((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100))-employee_salary_project),2)) as Profit_NET
from SA_TRANSACTION
GROUP BY TRUNC (TIME_ID, 'MM'), ROLLUP (agency_name, agency_country, agency_city)
    HAVING TRUNC (TIME_ID, 'MM') IS NOT NULL 
    and agency_name IS NOT NULL 
order by TRUNC (TIME_ID, 'MM'), agency_name, agency_country, agency_city;

select 
    TRUNC (TIME_ID, 'MM') as date_month,
    agency_name,
    customer_name,
    brand_name,
    SUM (ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100),2)) as Revenue_GROSS,
    SUM (ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100),2)) as Revenue_NET,
    SUM (ROUND(employee_salary_project*(1+ agency_VAT_percent/100),2)) as Cost_GROSS,
    SUM (employee_salary_project) as Cost_NET,
    SUM (ROUND((((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100))-(employee_salary_project*(1+ agency_VAT_percent/100)),2)) as Profit_GROSS,
    SUM (ROUND(((((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100))-employee_salary_project),2)) as Profit_NET
from SA_TRANSACTION
GROUP BY TRUNC (TIME_ID, 'MM'), ROLLUP (agency_name, customer_name, brand_name)
    HAVING TRUNC (TIME_ID, 'MM') IS NOT NULL 
    and agency_name IS NOT NULL 
order by TRUNC (TIME_ID, 'MM'), agency_name, customer_name, brand_name;

select 
    TRUNC (TIME_ID, 'MM') as date_month,
    customer_name,
    brand_name,
    promotion_media_type,
    SUM (ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100),2)) as Revenue_GROSS,
    SUM (ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100),2)) as Revenue_NET,
    SUM (ROUND(employee_salary_project*(1+ agency_VAT_percent/100),2)) as Cost_GROSS,
    SUM (employee_salary_project) as Cost_NET,
    SUM (ROUND((((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100))-(employee_salary_project*(1+ agency_VAT_percent/100)),2)) as Profit_GROSS,
    SUM (ROUND(((((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100))-employee_salary_project),2)) as Profit_NET
from SA_TRANSACTION
GROUP BY TRUNC (TIME_ID, 'MM'), ROLLUP (customer_name, brand_name,promotion_media_type)
    HAVING TRUNC (TIME_ID, 'MM') IS NOT NULL 
order by TRUNC (TIME_ID, 'MM'), customer_name, brand_name,promotion_media_type;
--------------------------------------------------------------------------------
--monthly  reports •	USE: GROUPING SETS Extension
--------------------------------------------------------------------------------
select 
    TRUNC (TIME_ID, 'MM') as date_day,
    agency_name,
    agency_country,
    agency_city,
    SUM (ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100),2)) as Revenue_GROSS,
    SUM (ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100),2)) as Revenue_NET,
    SUM (ROUND(employee_salary_project*(1+ agency_VAT_percent/100),2)) as Cost_GROSS,
    SUM (employee_salary_project) as Cost_NET,
    SUM (ROUND((((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100))-(employee_salary_project*(1+ agency_VAT_percent/100)),2)) as Profit_GROSS,
    SUM (ROUND(((((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100))-employee_salary_project),2)) as Profit_NET,
    GROUPING_ID(agency_name,agency_country,agency_city) AS grouping_id
from SA_TRANSACTION
GROUP BY TRUNC (TIME_ID, 'MM'), GROUPING SETS ((agency_name, agency_country), (agency_name,agency_city))
    HAVING TRUNC (TIME_ID, 'MM') IS NOT NULL 
    and agency_name IS NOT NULL 
order by TRUNC (TIME_ID, 'MM'), agency_name, agency_country, agency_city;
--------------------------------------------------------------------------------
--monthly  reports •	USE: Grouping() function
--------------------------------------------------------------------------------
select 
    TRUNC (TIME_ID, 'MM') as date_month,
    agency_name,
    agency_country,
    agency_city,
    SUM (ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100),2)) as Revenue_GROSS,
    SUM (ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100),2)) as Revenue_NET,
    SUM (ROUND(employee_salary_project*(1+ agency_VAT_percent/100),2)) as Cost_GROSS,
    SUM (employee_salary_project) as Cost_NET,
    SUM (ROUND((((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100))-(employee_salary_project*(1+ agency_VAT_percent/100)),2)) as Profit_GROSS,
    SUM (ROUND(((((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100))-employee_salary_project),2)) as Profit_NET,
    GROUPING(agency_name) AS f1g,
    GROUPING(agency_country) AS f2g,
    GROUPING(agency_city) AS f3g
from SA_TRANSACTION
GROUP BY TRUNC (TIME_ID, 'MM'), CUBE (agency_name, agency_country, agency_city)
    HAVING TRUNC (TIME_ID, 'MM') IS NOT NULL 
    and agency_name IS NOT NULL 
order by TRUNC (TIME_ID, 'MM'), agency_name, agency_country, agency_city;
--------------------------------------------------------------------------------
--reports •	USE: ROLLUP by Time
--------------------------------------------------------------------------------
SELECT case grouping(extract(year from TIME_ID))
       when 1
       then 'All Years'
       else to_char(extract(year from TIME_ID))
       end  year
,      case grouping('Q'||to_char(TIME_ID, 'Q'))
       when 1
       then 'All Quarters'
       else 'Q'||to_char(TIME_ID, 'Q')
       end  quarter
,      case grouping(to_char(TIME_ID, 'MONTH'))
       when 1
       then 'All Months'
       else to_char(TIME_ID, 'MONTH')
       end  month
,      case grouping(to_char(TIME_ID, 'DAY'))
       when 1
       then 'All Days'
       else to_char(TIME_ID, 'DAY')
       end  day
,      SUM (ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100),2)) as Revenue_GROSS    
,      SUM (ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100),2)) as Revenue_NET
,      SUM (ROUND(employee_salary_project*(1+ agency_VAT_percent/100),2)) as Cost_GROSS
,      SUM (employee_salary_project) as Cost_NET
,      SUM (ROUND((((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100))-(employee_salary_project*(1+ agency_VAT_percent/100)),2)) as Profit_GROSS
,      SUM (ROUND(((((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100))-employee_salary_project),2)) as Profit_NET
FROM   SA_TRANSACTION
GROUP
BY     ROLLUP
       ( extract(year from TIME_ID)
       , 'Q'||to_char(TIME_ID, 'Q')
       , to_char(TIME_ID, 'MONTH')
       , to_char(TIME_ID, 'DAY'))
;

SELECT case grouping(extract(year from TIME_ID))
       when 1
       then 'All Years'
       else to_char(extract(year from TIME_ID))
       end  year
,      case grouping('Q'||to_char(TIME_ID, 'Q'))
       when 1
       then 'All Quarters'
       else 'Q'||to_char(TIME_ID, 'Q')
       end  quarter
,      case grouping(to_char(TIME_ID, 'MONTH'))
       when 1
       then 'All Months'
       else to_char(TIME_ID, 'MONTH')
       end  month
,      case grouping(to_char(TIME_ID, 'DAY'))
       when 1
       then 'All Days'
       else to_char(TIME_ID, 'DAY')
       end  day
,      SUM (ROUND(employee_salary_project*(1+ agency_VAT_percent/100),2)) as employee_salary_project_GROSS
,      SUM (employee_salary_project) as employee_salary_project_NET
FROM   SA_TRANSACTION
GROUP
BY     ROLLUP
       ( extract(year from TIME_ID)
       , 'Q'||to_char(TIME_ID, 'Q')
       , to_char(TIME_ID, 'MONTH')
       , to_char(TIME_ID, 'DAY'))
;
--------------------------------------------------------------------------------
