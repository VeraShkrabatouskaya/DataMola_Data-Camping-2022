alter session set current_schema=SAL_CL;
--drop view v_sal_budgets;

alter session set current_schema=DW_DATA;
GRANT SELECT ON DW_DATA.FCT_business TO SAL_CL;
alter session set current_schema=DW_DATA;
GRANT SELECT ON DW_DATA.DIM_agency TO SAL_CL;
alter session set current_schema=DW_DATA;
GRANT SELECT ON DW_DATA.DIM_promotion TO SAL_CL;

alter session set current_schema=SAL_CL;

CREATE OR REPLACE VIEW v_sal_budgets
AS SELECT
       case grouping(extract(year from fct_b.TIME_ID))
       when 1
       then 'All Years'
       else to_char(extract(year from fct_b.TIME_ID))
       end  year
,      case grouping('Q'||to_char(fct_b.TIME_ID, 'Q'))
       when 1
       then 'All Quarters'
       else 'Q'||to_char(fct_b.TIME_ID, 'Q')
       end  quarter
,      case grouping(to_char(fct_b.TIME_ID, 'MONTH'))
       when 1
       then 'All Months'
       else to_char(fct_b.TIME_ID, 'MONTH')
       end  month
,      case grouping(to_char(fct_b.TIME_ID, 'DAY'))
       when 1
       then 'All Days'
       else to_char(fct_b.TIME_ID, 'DAY')
       end  day
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
GROUP
BY     ROLLUP
       ( extract(year from fct_b.TIME_ID)
       , 'Q'||to_char(fct_b.TIME_ID, 'Q')
       , to_char(fct_b.TIME_ID, 'MONTH')
       , to_char(fct_b.TIME_ID, 'DAY'))
;

alter session set current_schema=SAL_CL;
SELECT * FROM v_sal_budgets;
