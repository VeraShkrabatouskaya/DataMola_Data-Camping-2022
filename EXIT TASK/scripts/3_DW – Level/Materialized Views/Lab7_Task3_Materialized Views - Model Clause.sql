--Lab7_Task_3 Materialized Views  - Model Clause
alter session set current_schema=DW_DATA;
GRANT ON COMMIT REFRESH to DW_DATA;

-- DROP MATERIALIZED VIEW DW_DATA.mv_employee_salary_model;

CREATE MATERIALIZED VIEW DW_DATA.mv_employee_salary_model
BUILD IMMEDIATE
REFRESH COMPLETE NEXT SYSDATE + 5/1440
AS
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
            
SELECT * FROM DW_DATA.mv_employee_salary_model ORDER BY 1,2,3;

UPDATE DW_CL.cls_t_transaction
SET employee_salary_project = employee_salary_project*1.01
WHERE TIME_ID >= to_date( '01/01/2022', 'dd/mm/yyyy' ) AND TIME_ID  < to_date( '31/01/2022', 'dd/mm/yyyy' );

SELECT * FROM DW_DATA.mv_employee_salary_model ORDER BY 1,2,3;
