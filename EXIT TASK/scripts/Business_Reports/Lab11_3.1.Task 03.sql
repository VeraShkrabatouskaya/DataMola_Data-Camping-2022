/*UO2_Lab2 Monthly salary data for employees for the year 2022 on the SA level.*/

alter session set current_schema=sa_promotions;
set autotrace traceonly;
select 
    TRUNC(TIME_ID, 'YYYY') AS YEAR,
    TRUNC (TIME_ID, 'MM') AS MONTH,
    SUM (ROUND(employee_salary_project*(1+ agency_VAT_percent/100),2)) as gross_salary_employee_dollar_amount,
    SUM (employee_salary_project) as net_salary_employee_dollar_amount
from SA_TRANSACTION
GROUP BY CUBE (TRUNC(TIME_ID, 'YYYY'), TRUNC (TIME_ID, 'MM'))
    HAVING  
    (TRUNC(TIME_ID, 'YYYY') IS NOT NULL 
     AND
     TRUNC(TIME_ID, 'MM') IS NOT NULL)
order by TRUNC(TIME_ID, 'YYYY'), TRUNC (TIME_ID, 'MM');
SET AUTOTRACE OFF;

/*UO2_Lab5 Monthly salary data for employees for the year 2022 using Module Clause on the DW level.*/

alter session set current_schema=DW_DATA;
--set autotrace traceonly;
WITH salary_employees AS (
SELECT TRUNC(TIME_ID, 'YYYY') AS year,
TRUNC (TIME_ID, 'MM') AS month,'MONTH' period
,SUM (ROUND(employee_salary_project*(1+ agency_VAT_percent/100),2)) as gross_salary_employee_dollar_amount
,SUM (employee_salary_project) as net_salary_employee_dollar_amount   
FROM   DW_CL.cls_t_transaction
GROUP BY TRUNC(TIME_ID, 'YYYY'), TRUNC (TIME_ID, 'MM'))

select year, month, period, gross_salary_employee_dollar_amount, net_salary_employee_dollar_amount  
from salary_employees
    MODEL
      DIMENSION BY ( year, month, period)
      MEASURES ( gross_salary_employee_dollar_amount, net_salary_employee_dollar_amount)
       RULES(
       
    gross_salary_employee_dollar_amount[FOR year IN (SELECT DISTINCT year FROM salary_employees), 
    NULL, 'YEAR']=SUM(gross_salary_employee_dollar_amount)[cv(year), ANY, 'MONTH'],
    gross_salary_employee_dollar_amount [NULL, NULL,'ALL']=SUM(gross_salary_employee_dollar_amount)[ANY, NULL,'YEAR'],  
       
    net_salary_employee_dollar_amount[FOR year IN (SELECT DISTINCT year FROM salary_employees), 
    NULL, 'YEAR']=SUM(net_salary_employee_dollar_amount)[cv(year), ANY, 'MONTH'],
    net_salary_employee_dollar_amount[NULL, NULL,'ALL']=SUM(net_salary_employee_dollar_amount)[ANY, NULL,'YEAR']);
--SET AUTOTRACE OFF;    

/*UO2_Lab11 Monthly salary data for employees for the year 2022 using Star Schema on the DW level.*/

alter session set current_schema=DW_DATA;
--set autotrace traceonly;
select 
    TRUNC(TIME_ID, 'YYYY') AS YEAR,
    TRUNC (TIME_ID, 'MM') AS MONTH,
    SUM (gross_salary_employee_dollar_amount)/* as employee_salary_project_GROSS*/,
    SUM (net_salary_employee_dollar_amount) /*as employee_salary_project_NET*/
from DW_DATA.FCT_BUSINESS
GROUP BY CUBE (TRUNC(TIME_ID, 'YYYY'), TRUNC (TIME_ID, 'MM'))
    HAVING  
    (TRUNC(TIME_ID, 'YYYY') IS NOT NULL 
     AND
     TRUNC(TIME_ID, 'MM') IS NOT NULL)
order by TRUNC(TIME_ID, 'YYYY'), TRUNC (TIME_ID, 'MM');
--SET AUTOTRACE OFF; 
