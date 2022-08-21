/*UO2_Lab11 Monthly salary data for employees for the year 2022 using Star Schema on the DW level.*/

alter session set current_schema=DW_DATA;

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


