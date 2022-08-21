alter session set current_schema=DM_SALARY;
--drop view SAL_CL.v_sal_salary_by_employee;

alter session set current_schema = DW_DATA;
GRANT DELETE,INSERT,UPDATE,SELECT on DW_DATA.FCT_BUSINESS TO DM_SALARY;
GRANT DELETE,INSERT,UPDATE,SELECT on DW_DATA.DIM_AGENCY TO DM_SALARY;
GRANT DELETE,INSERT,UPDATE,SELECT on DW_DATA.DIM_EMPLOYEE TO DM_SALARY;
GRANT DELETE,INSERT,UPDATE,SELECT on DW_DATA.DIM_PROMOTION TO DM_SALARY;

alter session set current_schema=DM_SALARY;
SELECT  * FROM SAL_CL.v_sal_salary_by_employee;
SELECT  * FROM SAL_CL.v_sal_employee_salary_total;

