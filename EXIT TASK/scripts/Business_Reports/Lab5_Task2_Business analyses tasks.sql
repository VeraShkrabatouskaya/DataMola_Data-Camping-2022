--Lab5_Task_2 Monthly Reports Layouts
alter session set current_schema=DW_CL;
GRANT SELECT ON DW_CL.cls_t_transaction TO DW_DATA;
alter session set current_schema=DW_DATA;

select * from DW_CL.cls_t_transaction;
select count(*) from DW_CL.cls_t_transaction;
--------------------------------------------------------------------------------
--Salary of the Starcom advertising network employees by month using Module Clause
--------------------------------------------------------------------------------
WITH salary_employees AS (
SELECT TRUNC(TIME_ID, 'YYYY') AS year,
TO_CHAR(TIME_ID, 'MM') AS month,'MONTH' period
,SUM (employee_salary_project) as net_salary_employee_dollar_amount   
FROM   DW_CL.cls_t_transaction
GROUP BY TRUNC(TIME_ID, 'YYYY'), TO_CHAR(TIME_ID, 'MM'))
select year,month,period, net_salary_employee_dollar_amount  
from salary_employees
    MODEL
      DIMENSION BY ( year, month,period)
      MEASURES ( net_salary_employee_dollar_amount)
       RULES(
    net_salary_employee_dollar_amount[FOR year IN (SELECT DISTINCT year FROM salary_employees), 
    NULL, 'YEAR']=SUM(net_salary_employee_dollar_amount)[cv(year), ANY, 'MONTH'],
    net_salary_employee_dollar_amount [NULL, NULL, 'ALL']=SUM(net_salary_employee_dollar_amount)[ANY, NULL,'YEAR'])
;
--------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------
--Revenues, costs, profits of the Starcom advertising network by month using Module Clause
--------------------------------------------------------------------------------
WITH budget_agencies AS (
SELECT TRUNC(TIME_ID, 'YYYY') AS year,
TRUNC (TIME_ID, 'MM') AS month,'MONTH' period
,      SUM (ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100),2)) as gross_revenue_dollar_amount  
,      SUM (ROUND(((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100),2)) as net_revenue_dollar_amount
,      SUM (ROUND(employee_salary_project*(1+ agency_VAT_percent/100),2)) as gross_cost_dollar_amount
,      SUM (employee_salary_project) as net_cost_dollar_amount
,      SUM (ROUND((((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100)*(1+agency_VAT_percent/100))-(employee_salary_project*(1+ agency_VAT_percent/100)),2)) as gross_profit_dollar_amount
,      SUM (ROUND(((((promotion_metric_amount*promotion_price*(1-promotion_distinct_percent/100))*agency_fee_percent/100))-employee_salary_project),2)) as net_profit_dollar_amount
FROM   DW_CL.cls_t_transaction
GROUP BY TRUNC(TIME_ID, 'YYYY'), TRUNC (TIME_ID, 'MM'))

select year, month, period, gross_revenue_dollar_amount, net_revenue_dollar_amount, gross_cost_dollar_amount, net_cost_dollar_amount, gross_profit_dollar_amount, net_profit_dollar_amount
from budget_agencies
    MODEL
      DIMENSION BY ( year, month, period)
      MEASURES ( gross_revenue_dollar_amount, net_revenue_dollar_amount, gross_cost_dollar_amount, net_cost_dollar_amount, gross_profit_dollar_amount, net_profit_dollar_amount)
       RULES(
       
    gross_revenue_dollar_amount[FOR year IN (SELECT DISTINCT year FROM budget_agencies), 
    NULL, 'YEAR']=SUM(gross_revenue_dollar_amount)[cv(year), ANY, 'MONTH'],
    gross_revenue_dollar_amount [NULL, NULL,'ALL']=SUM(gross_revenue_dollar_amount)[ANY, NULL,'YEAR'],  
    
    net_revenue_dollar_amount[FOR year IN (SELECT DISTINCT year FROM budget_agencies), 
    NULL, 'YEAR']=SUM(net_revenue_dollar_amount)[cv(year), ANY, 'MONTH'],
    net_revenue_dollar_amount [NULL, NULL,'ALL']=SUM(net_revenue_dollar_amount)[ANY, NULL,'YEAR'],  
    
    gross_cost_dollar_amount[FOR year IN (SELECT DISTINCT year FROM budget_agencies), 
    NULL, 'YEAR']=SUM(gross_cost_dollar_amount)[cv(year), ANY, 'MONTH'],
    gross_cost_dollar_amount [NULL, NULL,'ALL']=SUM(gross_cost_dollar_amount)[ANY, NULL,'YEAR'],  
    
    net_cost_dollar_amount[FOR year IN (SELECT DISTINCT year FROM budget_agencies), 
    NULL, 'YEAR']=SUM(net_cost_dollar_amount)[cv(year), ANY, 'MONTH'],
    net_cost_dollar_amount [NULL, NULL,'ALL']=SUM(net_cost_dollar_amount)[ANY, NULL,'YEAR'],  
    
    gross_profit_dollar_amount[FOR year IN (SELECT DISTINCT year FROM budget_agencies), 
    NULL, 'YEAR']=SUM(gross_profit_dollar_amount)[cv(year), ANY, 'MONTH'],
    gross_profit_dollar_amount [NULL, NULL,'ALL']=SUM(gross_profit_dollar_amount)[ANY, NULL,'YEAR'],  
       
    net_profit_dollar_amount[FOR year IN (SELECT DISTINCT year FROM budget_agencies), 
    NULL, 'YEAR']=SUM(net_profit_dollar_amount)[cv(year), ANY, 'MONTH'],
    net_profit_dollar_amount[NULL, NULL,'ALL']=SUM(net_profit_dollar_amount)[ANY, NULL,'YEAR']);



