--Lab6_Task_3 Using Analytic Functions:• AGGREAGATE FUNCS (MAX, MIN, AVG)
alter session set current_schema=DW_CL;
GRANT SELECT ON DW_CL.cls_t_transaction TO DW_DATA;
alter session set current_schema=DW_DATA;

select * from DW_CL.cls_t_transaction;
select count(*) from DW_CL.cls_t_transaction;

--Information about the maximum, minimum, average salary per project for each employee of the Starcom advertising network.

with t1 AS (
SELECT (employee_first_name||' '||employee_last_name) as employee, employee_salary_project
FROM DW_CL.cls_t_transaction)
SELECT 
employee, 
TRUNC(max (employee_salary_project),2) as max_employee_salary_project,
TRUNC(min (employee_salary_project),2) as min_employee_salary_project,
TRUNC(avg (employee_salary_project),2) as avg_employee_salary_project
FROM t1
GROUP BY employee
ORDER BY max_employee_salary_project, min_employee_salary_project, avg_employee_salary_project ASC;




