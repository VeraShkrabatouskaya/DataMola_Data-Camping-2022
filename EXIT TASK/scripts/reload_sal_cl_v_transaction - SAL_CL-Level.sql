alter session set current_schema=SAL_CL;

SELECT * FROM v_sal_budgets;
SELECT * FROM v_sal_budgets_agency;
SELECT * FROM v_sal_budgets_brand_promotion;
SELECT * FROM v_sal_budgets_customer_brand;
SELECT * FROM v_sal_employee_salary_total;
SELECT * FROM v_sal_KPI_daily;
SELECT * FROM v_sal_quantity_agency_customer_brand;
SELECT * FROM v_sal_quantity_agency_employee;
SELECT * FROM v_sal_quantity_agency_promotion;
SELECT * FROM v_sal_salary_by_employee;

--drop view v_sal_budgets; 
--drop view v_sal_budgets_agency;
--drop view v_sal_budgets_brand_promotion;
--drop view v_sal_budgets_customer_brand;
--drop view v_sal_employee_salary_total;
--drop view v_sal_KPI_daily;
--drop view v_sal_quantity_agency_customer_brand;
--drop view v_sal_quantity_agency_employee;
--drop view v_sal_quantity_agency_promotion;
--drop view v_sal_salary_by_employee;
