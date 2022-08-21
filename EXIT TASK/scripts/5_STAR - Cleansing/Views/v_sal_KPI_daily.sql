alter session set current_schema=SAL_CL;
--drop view v_sal_KPI_daily;

alter session set current_schema=DW_DATA;
GRANT SELECT ON DW_DATA.FCT_business TO SAL_CL;
alter session set current_schema=DW_DATA;
GRANT SELECT ON DW_DATA.DIM_agency TO SAL_CL;
alter session set current_schema=DW_DATA;
GRANT SELECT ON DW_DATA.DIM_promotion TO SAL_CL;

alter session set current_schema=SAL_CL;

CREATE OR REPLACE VIEW v_sal_KPI_daily
AS SELECT
    fct_b.time_ID,
    ag.agency_name,	
    ag.agency_city, 
    ag.agency_country, 
    prom.promotion_name,
    prom.promotion_media_type, 
    prom.promotion_KPI,
    prom.promotion_metric_amount,
    prom.promotion_price,
    (prom.promotion_metric_amount*prom.promotion_price) as cost_of_placement_without_VAT,
    prom.promotion_distinct_percent,
    ROUND((prom.promotion_metric_amount*prom.promotion_price*(1-prom.promotion_distinct_percent/100)),2) as cost_without_VAT_with_discount,
    ag.agency_VAT_percent, 
    ROUND(((prom.promotion_metric_amount*prom.promotion_price*(1-prom.promotion_distinct_percent/100))*ag.agency_VAT_percent/100),2) as VAT_amount,
    ROUND(((prom.promotion_metric_amount*prom.promotion_price*(1-prom.promotion_distinct_percent/100))+ ((prom.promotion_metric_amount*prom.promotion_price*(1-prom.promotion_distinct_percent/100))*ag.agency_VAT_percent/100)),2) as cost_with_VAT_with_discount,
    ag.agency_fee_percent,
    ROUND(((prom.promotion_metric_amount*prom.promotion_price*(1-prom.promotion_distinct_percent/100))*ag.agency_fee_percent/100),2) as agency_fee_amount_without_VAT,
    ROUND(((prom.promotion_metric_amount*prom.promotion_price*(1-prom.promotion_distinct_percent/100))*ag.agency_fee_percent/100)*(1+ag.agency_VAT_percent/100),2) as agency_fee_amount_with_VAT,
    ROUND(((prom.promotion_metric_amount*prom.promotion_price*(1-prom.promotion_distinct_percent/100)))+(((prom.promotion_metric_amount*prom.promotion_price*(1-prom.promotion_distinct_percent/100))*ag.agency_fee_percent/100)),2) as total_cost_without_VAT_with_discount_with_agency_fee_amount_without_VAT,
    ROUND((((prom.promotion_metric_amount*prom.promotion_price*(1-prom.promotion_distinct_percent/100))+ ((prom.promotion_metric_amount*prom.promotion_price*(1-prom.promotion_distinct_percent/100))*ag.agency_VAT_percent/100)))+(((prom.promotion_metric_amount*prom.promotion_price*(1-prom.promotion_distinct_percent/100))*ag.agency_fee_percent/100)*(1+ag.agency_VAT_percent/100)),2) as total_cost_with_VAT_with_discount_with_agency_fee_amount_with_VAT
FROM DW_DATA.FCT_business fct_b
left join DW_DATA.DIM_agency ag on fct_b.agency_ID = ag.agency_ID 
left join DW_DATA.DIM_promotion prom on fct_b.promotion_ID = prom.promotion_ID
ORDER BY 1;

alter session set current_schema=SAL_CL;
SELECT * FROM v_sal_KPI_daily;
SELECT count(*) FROM v_sal_KPI_daily;