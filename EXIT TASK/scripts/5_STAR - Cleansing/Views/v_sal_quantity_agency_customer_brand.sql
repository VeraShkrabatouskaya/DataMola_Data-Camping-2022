alter session set current_schema=SAL_CL;
--drop view v_sal_quantity_agency_customer_brand;

alter session set current_schema=DW_DATA;
GRANT SELECT ON DW_DATA.FCT_business TO SAL_CL;
alter session set current_schema=DW_DATA;
GRANT SELECT ON DW_DATA.DIM_agency TO SAL_CL;
alter session set current_schema=DW_DATA;
GRANT SELECT ON DW_DATA.DIM_customer TO SAL_CL;

alter session set current_schema=SAL_CL;

CREATE OR REPLACE VIEW v_sal_quantity_agency_customer_brand
AS SELECT 
    TRUNC (fct_b.TIME_ID, 'MM') as date_month,
    ag.agency_name,
    ag.agency_city,
    ag.agency_country,
    COUNT(distinct cust.customer_name) as number_of_customers,
    COUNT(distinct cust.brand_name) as number_of_brands
FROM DW_DATA.FCT_business fct_b
left join DW_DATA.DIM_agency ag on fct_b.agency_ID = ag.agency_ID 
left join DW_DATA.DIM_customer cust on fct_b.customer_ID = cust.customer_ID
GROUP BY CUBE (TRUNC (fct_b.TIME_ID, 'MM'), ag.agency_name, ag.agency_city, ag.agency_country)
    HAVING TRUNC (fct_b.TIME_ID, 'MM') IS NOT NULL 
    and ag.agency_name IS NOT NULL
    and ag.agency_city IS NOT NULL
    and ag.agency_country IS NOT NULL
order by TRUNC (fct_b.TIME_ID, 'MM'), ag.agency_name,  ag.agency_city, ag.agency_country;

alter session set current_schema=SAL_CL;
SELECT * FROM v_sal_quantity_agency_customer_brand;
