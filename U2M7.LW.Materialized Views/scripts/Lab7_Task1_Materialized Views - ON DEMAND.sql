--Lab7_Task_1 Materialized Views  - ON DEMAND
alter session set current_schema = DW_DATA;

GRANT CREATE MATERIALIZED VIEW TO DW_DATA;
GRANT QUERY REWRITE TO DW_DATA;
GRANT CREATE ANY TABLE TO DW_DATA; 
GRANT SELECT ANY TABLE TO DW_DATA;

--DROP MATERIALIZED VIEW mv_customer_budgets_monthly;
CREATE MATERIALIZED VIEW mv_customer_budgets_monthly
BUILD DEFERRED
REFRESH COMPLETE ON DEMAND
AS 
select 
    TRUNC (TIME_ID, 'MM') as date_month,
    /*  agency_ID,*/
    customer_ID,
    SUM (gross_revenue_dollar_amount) as Revenue_GROSS,
    SUM (net_revenue_dollar_amount) as Revenue_NET,
    SUM (gross_cost_dollar_amount) as Cost_GROSS,
    SUM (net_cost_dollar_amount) as Cost_NET,
    SUM (gross_profit_dollar_amount) as Profit_GROSS,
    SUM (net_profit_dollar_amount) as Profit_NET
from FCT_business
GROUP BY TRUNC (TIME_ID, 'MM'), ROLLUP (/*agency_ID,*/ customer_ID)
    HAVING TRUNC (TIME_ID, 'MM') IS NOT NULL 
--    and agency_ID IS NOT NULL 
order by TRUNC (TIME_ID, 'MM'), /*agency_ID,*/ customer_ID;

SELECT * FROM  mv_customer_budgets_monthly order by 1,2;

EXECUTE DBMS_MVIEW.REFRESH('mv_customer_budgets_monthly');

SELECT * FROM  mv_customer_budgets_monthly order by 1,2;

--DROP MATERIALIZED VIEW mv_agency_customer_budgets_monthly;
CREATE MATERIALIZED VIEW mv_agency_customer_budgets_monthly
BUILD DEFERRED
REFRESH COMPLETE ON DEMAND
AS 
select 
    TRUNC (TIME_ID, 'MM') as date_month,
    agency_ID,
    customer_ID,
    SUM (gross_revenue_dollar_amount) as Revenue_GROSS,
    SUM (net_revenue_dollar_amount) as Revenue_NET,
    SUM (gross_cost_dollar_amount) as Cost_GROSS,
    SUM (net_cost_dollar_amount) as Cost_NET,
    SUM (gross_profit_dollar_amount) as Profit_GROSS,
    SUM (net_profit_dollar_amount) as Profit_NET
from FCT_business
GROUP BY TRUNC (TIME_ID, 'MM'), ROLLUP (agency_ID, customer_ID)
    HAVING TRUNC (TIME_ID, 'MM') IS NOT NULL 
    and agency_ID IS NOT NULL 
order by TRUNC (TIME_ID, 'MM'), agency_ID, customer_ID;

SELECT * FROM  mv_agency_customer_budgets_monthly order by 1,2,3;

EXECUTE DBMS_MVIEW.REFRESH('mv_agency_customer_budgets_monthly');

SELECT * FROM  mv_agency_customer_budgets_monthly order by 1,2,3;
