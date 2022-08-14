--GRANT UNLIMITED TABLESPACE TO VShkrabatovskaya;
--SELECT * from dba_data_files ;
--select * from USER_tablespaces;

alter session set current_schema=sa_promotions;
alter user sa_promotions QUOTA UNLIMITED ON ts_sa_promotions_data_01;


alter session set current_schema=sa_customers;
GRANT SELECT ON SA_CUSTOMER_DATA_with_department TO sa_promotions;
alter session set current_schema = sa_employees;
GRANT SELECT ON SA_EMPLOYEE_DATA_TOTAL  TO sa_promotions;

select * from sa_customers.SA_CUSTOMER_DATA_with_department
order by 1;

SELECT *   
FROM sa_employees.SA_EMPLOYEE_DATA_TOTAL
ORDER BY 1;

SELECT *  
FROM sa_promotions.SA_PROMOTION_DATA_TOTAL
ORDER BY 1;
--------------------------------------------------------------------------------
Create TABLE SA_PROMOTION_DATA_02 AS 
SELECT promotion_id,  promotion_metric_amount, promotion_price, promotion_KPI, promotion_distinct_percent, promotion_name, promotion_start, promotion_end
FROM sa_promotions.SA_PROMOTION_DATA_TOTAL
ORDER BY 1;

select * from SA_PROMOTION_DATA_02;
--------------------------------------------------------------------------------
--DROP TABLE SA_TRANSACTION
Create table SA_TRANSACTION as 
select * from sa_customers.SA_CUSTOMER_DATA_with_department
left outer join sa_employees.SA_EMPLOYEE_DATA_TOTAL
on sa_customers.SA_CUSTOMER_DATA_with_department.TOTAL_ID = sa_employees.SA_EMPLOYEE_DATA_TOTAL.EMPLOYEE_ID
left outer join sa_promotions.SA_PROMOTION_DATA_02
on sa_customers.SA_CUSTOMER_DATA_with_department.TOTAL_ID = sa_promotions.SA_PROMOTION_DATA_02.PROMOTION_ID
order by 1
;

select * from SA_TRANSACTION;
select count(*) from SA_TRANSACTION;
--------------------------------------------------------------------------------
select 
total_id, 
time_id, 
customer_name, 
brand_name, 
customer_address, 
customer_city, 
customer_country, 
customer_email, 
customer_office_phone,
customer_mobile_phone, 
product_name,
agency_name,
agency_city,
agency_country ,
agency_address,
agency_postcode,
agency_email,
agency_office_phone,
agency_mobile_phone,
agency_Fee_percent,
agency_VAT_percent,
promotion_media_type,  
category_name,
subcategory_name,
department_name,
employee_first_name,
employee_last_name,
employee_position,
employee_salary_project,
employee_passport_ID,
employee_email,
employee_office_phone,
employee_mobile_phone,
employee_date_of_hire,
employee_date_end_of_contract,
promotion_metric_amount,
promotion_price,
promotion_KPI,
promotion_distinct_percent,
promotion_name,
promotion_start,
promotion_end, 
ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100),2) as gross_revenue_dollar_amount,
ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100),2) as net_revenue_dollar_amount,
ROUND(employee_salary_project*(1+ agency_VAT_percent/100),2) as gross_cost_dollar_amount,
employee_salary_project as net_cost_dollar_amount,
ROUND((((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100))-(employee_salary_project*(1+ agency_VAT_percent/100)),2) as gross_profit_dollar_amount,
ROUND(((((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100))-employee_salary_project),2) as net_profit_dollar_amount,
employee_salary_project as  net_salary_employee_dollar_amount,
ROUND(employee_salary_project*(1+ agency_VAT_percent/100),2) as gross_salary_employee_dollar_amount,
ROUND(((((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100))-(employee_salary_project*(1+ agency_VAT_percent/100)))/(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100))*100,2) as gross_profit_margin_percent
from SA_TRANSACTION
order by 1;
--------------------------------------------------------------------------------
--FACT TABLE
select 
    TOTAL_ID,
    TIME_ID,
    agency_name,
    agency_city,
    agency_country,
    promotion_media_type,
    ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100),2) as gross_revenue_dollar_amount,
    ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100),2) as net_revenue_dollar_amount,
    ROUND(employee_salary_project*(1+ agency_VAT_percent/100),2) as gross_cost_dollar_amount,
    employee_salary_project as net_cost_dollar_amount,
    ROUND((((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100))-(employee_salary_project*(1+ agency_VAT_percent/100)),2) as gross_profit_dollar_amount,
    ROUND(((((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100))-employee_salary_project),2) as net_profit_dollar_amount,
    employee_salary_project as  net_salary_employee_dollar_amount,
    ROUND(employee_salary_project*(1+ agency_VAT_percent/100),2) as gross_salary_employee_dollar_amount,
    ROUND(((((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100))-(employee_salary_project*(1+ agency_VAT_percent/100)))/(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100))*100,2) as gross_profit_margin_percent
from SA_TRANSACTION
ORDER BY 1;

--DROP TABLE SA_TRANSACTION_FACT_DATA;
Create table SA_TRANSACTION_FACT_DATA AS
select 
total_id, 
time_id, 
customer_name, 
brand_name, 
customer_address, 
customer_city, 
customer_country, 
customer_email, 
customer_office_phone,
customer_mobile_phone, 
product_name,
agency_name,
agency_city,
agency_country ,
agency_address,
agency_postcode,
agency_email,
agency_office_phone,
agency_mobile_phone,
agency_Fee_percent,
agency_VAT_percent,
promotion_media_type,  
category_name,
subcategory_name,
department_name,
employee_first_name,
employee_last_name,
employee_position,
employee_salary_project,
employee_passport_ID,
employee_email,
employee_office_phone,
employee_mobile_phone,
employee_date_of_hire,
employee_date_end_of_contract,
promotion_metric_amount,
promotion_price,
promotion_KPI,
promotion_distinct_percent,
promotion_name,
promotion_start,
promotion_end, 
ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100),2) as gross_revenue_dollar_amount,
ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100),2) as net_revenue_dollar_amount,
ROUND(employee_salary_project*(1+ agency_VAT_percent/100),2) as gross_cost_dollar_amount,
employee_salary_project as net_cost_dollar_amount,
ROUND((((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100))-(employee_salary_project*(1+ agency_VAT_percent/100)),2) as gross_profit_dollar_amount,
ROUND(((((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100))-employee_salary_project),2) as net_profit_dollar_amount,
employee_salary_project as  net_salary_employee_dollar_amount,
ROUND(employee_salary_project*(1+ agency_VAT_percent/100),2) as gross_salary_employee_dollar_amount,
ROUND(((((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100))-(employee_salary_project*(1+ agency_VAT_percent/100)))/(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100))*100,2) as gross_profit_margin_percent
from SA_TRANSACTION
order by 1;

select * from SA_TRANSACTION_FACT_DATA;

select * from SA_TRANSACTION_FACT_DATA where promotion_name ='68251 SAMSUNG_Headphones_production';

select count(*) from SA_TRANSACTION_FACT_DATA;

