alter session set current_schema=SAL_CL;
--drop view v_sal_budgets_agency;

alter session set current_schema=DW_DATA;
GRANT SELECT ON DW_DATA.FCT_business TO SAL_CL;
alter session set current_schema=DW_DATA;
GRANT SELECT ON DW_DATA.DIM_agency TO SAL_CL;
alter session set current_schema=DW_DATA;
GRANT SELECT ON DW_DATA.DIM_promotion TO SAL_CL;

alter session set current_schema=SAL_CL;

CREATE OR REPLACE VIEW v_sal_budgets_agency
AS SELECT
    TRUNC (fct_b.TIME_ID, 'MM') as date_month
,    ag.agency_name
,    ag.agency_country
,    ag.agency_city
,      SUM (ROUND(((prom.promotion_metric_amount*prom.promotion_price*(1-prom.promotion_distinct_percent/100))*ag.agency_fee_percent/100)*(1+ag.agency_VAT_percent/100),2)) as GROSS_Revenue   
,      SUM (ROUND(((prom.promotion_metric_amount*prom.promotion_price*(1-prom.promotion_distinct_percent/100))*ag.agency_fee_percent/100),2)) as NET_Revenue
,      SUM (ROUND(prom.employee_salary_project*(1+ ag.agency_VAT_percent/100),2)) as GROSS_Cost
,      SUM (prom.employee_salary_project) as NET_Cost
,      SUM (ROUND((((prom.promotion_metric_amount*prom.promotion_price*(1-prom.promotion_distinct_percent/100))*ag.agency_fee_percent/100)*(1+ag.agency_VAT_percent/100))-(prom.employee_salary_project*(1+ ag.agency_VAT_percent/100)),2)) as GROSS_Profit
,      SUM (ROUND(((((prom.promotion_metric_amount*prom.promotion_price*(1-prom.promotion_distinct_percent/100))*ag.agency_fee_percent/100))-prom.employee_salary_project),2)) as NET_Profit
,      ROUND(SUM (ROUND((((prom.promotion_metric_amount*prom.promotion_price*(1-prom.promotion_distinct_percent/100))*ag.agency_fee_percent/100)*(1+ag.agency_VAT_percent/100))-(prom.employee_salary_project*(1+ ag.agency_VAT_percent/100)),2))/SUM (ROUND(((prom.promotion_metric_amount*prom.promotion_price*(1-prom.promotion_distinct_percent/100))*ag.agency_fee_percent/100)*(1+ag.agency_VAT_percent/100),2))*100,2)  as MARGIN_PERCENT
FROM   DW_DATA.FCT_business fct_b
left join DW_DATA.DIM_agency ag on fct_b.agency_ID = ag.agency_ID 
left join DW_DATA.DIM_promotion prom on fct_b.promotion_ID = prom.promotion_ID
GROUP BY TRUNC (fct_b.TIME_ID, 'MM'), ROLLUP (ag.agency_name, ag.agency_country, ag.agency_city)
    HAVING TRUNC (fct_b.TIME_ID, 'MM') IS NOT NULL 
    and ag.agency_name IS NOT NULL 
order by TRUNC (fct_b.TIME_ID, 'MM'), ag.agency_name, ag.agency_country, ag.agency_city;

alter session set current_schema=SAL_CL;
SELECT * FROM v_sal_budgets_agency;
