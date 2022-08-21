--Lab7_Task_2 Materialized Views  - ON COMMIT
alter session set current_schema = DW_DATA;
GRANT ON COMMIT REFRESH to DW_DATA;

CREATE MATERIALIZED VIEW LOG ON DW_DATA.FCT_business
WITH rowid, SEQUENCE(
    Business_Fact_ID, 
    TIME_ID,
    customer_ID,
    employee_ID,
    agency_ID,
    gen_period_ID,
    product_ID,
    promotion_ID,
    gross_profit_dollar_amount,
    net_profit_dollar_amount,
    gross_revenue_dollar_amount,
    net_revenue_dollar_amount,
    gross_cost_dollar_amount,
    net_cost_dollar_amount,
    gross_salary_employee_dollar_amount,
    net_salary_employee_dollar_amount,
    gross_profit_margin_percent
    )
INCLUDING NEW VALUES;

-- DROP MATERIALIZED VIEW mv_product_daily;

CREATE MATERIALIZED VIEW mv_product_daily
BUILD IMMEDIATE
REFRESH FAST ON COMMIT
ENABLE QUERY REWRITE
AS
select 
    TIME_ID,
    product_id,
    SUM (gross_revenue_dollar_amount) as Revenue_GROSS,
    SUM (net_revenue_dollar_amount) as Revenue_NET,
    SUM (gross_cost_dollar_amount) as Cost_GROSS,
    SUM (net_cost_dollar_amount) as Cost_NET,
    SUM (gross_profit_dollar_amount) as Profit_GROSS,
    SUM (net_profit_dollar_amount) as Profit_NET
from DW_DATA.FCT_business
GROUP BY (TIME_ID, product_id)
order by TIME_ID, product_id;
            
SELECT * FROM mv_product_daily ORDER BY 1,2;

DELETE FROM DW_DATA.FCT_business
WHERE TIME_ID < to_date('15/01/2022', 'dd/mm/yyyy');
COMMIT;

SELECT * FROM mv_product_daily ORDER BY 1,2;
