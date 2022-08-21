alter session set current_schema=SAL_CL;
--drop view v_sal_salary_by_employee;

alter session set current_schema=DW_DATA;
GRANT SELECT ON DW_DATA.FCT_business TO SAL_CL;
alter session set current_schema=DW_DATA;
GRANT SELECT ON DW_DATA.DIM_agency TO SAL_CL;
alter session set current_schema=DW_DATA;
GRANT SELECT ON DW_DATA.DIM_promotion TO SAL_CL;
alter session set current_schema=DW_DATA;
GRANT SELECT ON DW_DATA.DIM_employee TO SAL_CL;

alter session set current_schema=SAL_CL;

CREATE OR REPLACE VIEW v_sal_salary_by_employee
AS SELECT 
    TRUNC (fct_b.TIME_ID, 'MM') AS MONTH,
    emp.employee_first_name||' '|| emp.employee_last_name as employee,    
    SUM (ROUND(prom.employee_salary_project*(1+ ag.agency_VAT_percent/100),2)) as employee_salary_project_GROSS,
    SUM (prom.employee_salary_project) as employee_salary_project_NET
FROM DW_DATA.FCT_business fct_b
left join DW_DATA.DIM_agency ag on fct_b.agency_ID = ag.agency_ID 
left join DW_DATA.DIM_promotion prom on fct_b.promotion_ID = prom.promotion_ID
left join DW_DATA.DIM_employee emp on fct_b.employee_ID = emp.employee_ID
GROUP BY CUBE (TRUNC (fct_b.TIME_ID, 'MM'), emp.employee_first_name, emp.employee_last_name)
    HAVING TRUNC (fct_b.TIME_ID, 'MM') IS NOT NULL 
    and emp.employee_first_name IS NOT NULL
    and emp.employee_last_name IS NOT NULL
order by TRUNC (fct_b.TIME_ID, 'MM'), employee;

alter session set current_schema=SAL_CL;
SELECT * FROM v_sal_salary_by_employee;
