alter session set current_schema=SAL_CL;
--drop view v_sal_employee_salary_total;

alter session set current_schema=DW_DATA;
GRANT SELECT ON DW_DATA.FCT_business TO SAL_CL;
alter session set current_schema=DW_DATA;
GRANT SELECT ON DW_DATA.DIM_agency TO SAL_CL;
alter session set current_schema=DW_DATA;
GRANT SELECT ON DW_DATA.DIM_promotion TO SAL_CL;

alter session set current_schema=SAL_CL;

CREATE OR REPLACE VIEW v_sal_employee_salary_total
AS 
WITH salary_employees AS (
SELECT 
TRUNC(fct_b.TIME_ID, 'YYYY') AS year
,TRUNC (fct_b.TIME_ID, 'MM') AS month
,'MONTH' period
,SUM (ROUND(prom.employee_salary_project*(1+ ag.agency_VAT_percent/100),2)) as gross_salary_employee
,SUM (prom.employee_salary_project) as net_salary_employee 
FROM DW_DATA.FCT_business fct_b
left join DW_DATA.DIM_agency ag on fct_b.agency_ID = ag.agency_ID 
left join DW_DATA.DIM_promotion prom on fct_b.promotion_ID = prom.promotion_ID
GROUP BY TRUNC(fct_b.TIME_ID, 'YYYY'), TRUNC (fct_b.TIME_ID, 'MM'))
select year, month, period, gross_salary_employee, net_salary_employee 
from salary_employees
    MODEL
      DIMENSION BY ( year, month, period)
      MEASURES ( gross_salary_employee, net_salary_employee)
       RULES(
       
    gross_salary_employee[FOR year IN (SELECT DISTINCT year FROM salary_employees), 
    NULL, 'YEAR']=SUM(gross_salary_employee)[cv(year), ANY, 'MONTH'],
    gross_salary_employee [NULL, NULL,'ALL']=SUM(gross_salary_employee)[ANY, NULL,'YEAR'],  
       
    net_salary_employee[FOR year IN (SELECT DISTINCT year FROM salary_employees), 
    NULL, 'YEAR']=SUM(net_salary_employee)[cv(year), ANY, 'MONTH'],
    net_salary_employee[NULL, NULL,'ALL']=SUM(net_salary_employee)[ANY, NULL,'YEAR'])
;

alter session set current_schema=SAL_CL;
SELECT * FROM v_sal_employee_salary_total;
