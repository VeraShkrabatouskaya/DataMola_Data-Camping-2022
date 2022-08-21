alter session set current_schema = DW_DATA;

GRANT CREATE MATERIALIZED VIEW TO DW_DATA;
GRANT QUERY REWRITE TO DW_DATA;
GRANT CREATE ANY TABLE TO DW_DATA; 
GRANT SELECT ANY TABLE TO DW_DATA;
GRANT ON COMMIT REFRESH to DW_DATA;

EXECUTE DBMS_MVIEW.REFRESH('mv_customer_budgets_monthly');
EXECUTE DBMS_MVIEW.REFRESH('mv_agency_customer_budgets_monthly');

SELECT * FROM  mv_customer_budgets_monthly order by 1,2;
SELECT * FROM  mv_agency_customer_budgets_monthly order by 1,2,3;
SELECT * FROM mv_product_daily ORDER BY 1,2;
SELECT * FROM mv_employee_salary_model ORDER BY 1,2,3;

--DROP MATERIALIZED VIEW mv_customer_budgets_monthly;
--DROP MATERIALIZED VIEW mv_agency_customer_budgets_monthly;
--DROP MATERIALIZED VIEW mv_product_daily;
--DROP MATERIALIZED VIEW DW_DATA.mv_employee_salary_model;

