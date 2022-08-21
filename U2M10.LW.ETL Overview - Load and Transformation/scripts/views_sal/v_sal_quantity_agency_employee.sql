alter session set current_schema=SAL_CL;
--drop view v_sal_quantity_agency_employee;

alter session set current_schema=DW_DATA;
GRANT SELECT ON DW_DATA.FCT_business TO SAL_CL;
alter session set current_schema=DW_DATA;
GRANT SELECT ON DW_DATA.DIM_agency TO SAL_CL;
alter session set current_schema=DW_DATA;
GRANT SELECT ON DW_DATA.DIM_employee TO SAL_CL;

alter session set current_schema=SAL_CL;

CREATE OR REPLACE VIEW v_sal_quantity_agency_employee
AS SELECT 
    fct_b.TIME_ID,
    ag.agency_name,
    ag.agency_city,
    ag.agency_country,
    COUNT(distinct (emp.employee_first_name||' '||emp.employee_last_name)) as number_of_employees
FROM DW_DATA.FCT_business fct_b
left join DW_DATA.DIM_agency ag on fct_b.agency_ID = ag.agency_ID 
left join DW_DATA.DIM_employee emp on fct_b.employee_ID = emp.employee_ID
GROUP BY CUBE (fct_b.TIME_ID, ag.agency_name, ag.agency_city, ag.agency_country)
    HAVING fct_b.TIME_ID IS NOT NULL 
    and ag.agency_name IS NOT NULL
    and ag.agency_city IS NOT NULL
    and ag.agency_country IS NOT NULL
order by fct_b.TIME_ID, ag.agency_name,  ag.agency_city, ag.agency_country;

alter session set current_schema=SAL_CL;
SELECT * FROM v_sal_quantity_agency_employee;
