alter session set current_schema=SAL_CL;
--drop view v_sal_quantity_agency_promotion;

alter session set current_schema=DW_DATA;
GRANT SELECT ON DW_DATA.FCT_business TO SAL_CL;
alter session set current_schema=DW_DATA;
GRANT SELECT ON DW_DATA.DIM_agency TO SAL_CL;
alter session set current_schema=DW_DATA;
GRANT SELECT ON DW_DATA.DIM_customer TO SAL_CL;
alter session set current_schema=DW_DATA;
GRANT SELECT ON DW_DATA.DIM_promotion TO SAL_CL;

alter session set current_schema=SAL_CL;

CREATE OR REPLACE VIEW v_sal_quantity_agency_promotion
AS SELECT 
    TRUNC (fct_b.TIME_ID, 'MM') as date_month,
    cust.brand_name,
    ag.agency_city,
    prom.promotion_media_type,
    COUNT (prom.promotion_ID) as number_of_promotions
FROM DW_DATA.FCT_business fct_b
left join DW_DATA.DIM_agency ag on fct_b.agency_ID = ag.agency_ID 
left join DW_DATA.DIM_customer cust on fct_b.customer_ID = cust.customer_ID
left join DW_DATA.DIM_promotion prom on fct_b.promotion_ID = prom.promotion_ID
GROUP BY CUBE (TRUNC (fct_b.TIME_ID, 'MM'), cust.brand_name,  ag.agency_city, prom.promotion_media_type)
    HAVING TRUNC (fct_b.TIME_ID, 'MM') IS NOT NULL 
    and cust.brand_name IS NOT NULL
    and ag.agency_city IS NOT NULL
    and prom.promotion_media_type IS NOT NULL
order by TRUNC (fct_b.TIME_ID, 'MM'), cust.brand_name,  ag.agency_city, prom.promotion_media_type;

alter session set current_schema=SAL_CL;
SELECT * FROM v_sal_quantity_agency_promotion;
