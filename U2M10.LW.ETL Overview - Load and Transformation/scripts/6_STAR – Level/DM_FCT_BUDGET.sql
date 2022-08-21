alter session set current_schema=DM_BUDGET;
--drop view SAL_CL.v_sal_budgets;
--drop view SAL_CL.v_sal_budgets_agency;
--drop view SAL_CL.v_sal_budgets_brand_promotion;
--drop view SAL_CL.v_sal_budgets_customer_brand;

alter session set current_schema = DW_DATA;
GRANT DELETE,INSERT,UPDATE,SELECT on DW_DATA.FCT_BUSINESS TO DM_BUDGET;
GRANT DELETE,INSERT,UPDATE,SELECT on DW_DATA.DIM_CUSTOMER TO DM_BUDGET;
GRANT DELETE,INSERT,UPDATE,SELECT on DW_DATA.DIM_AGENCY TO DM_BUDGET;
GRANT DELETE,INSERT,UPDATE,SELECT on DW_DATA.DIM_PROMOTION TO DM_BUDGET;


alter session set current_schema=DM_BUDGET;
SELECT * FROM SAL_CL.v_sal_budgets;
SELECT * FROM SAL_CL.v_sal_budgets_agency;
SELECT * FROM SAL_CL.v_sal_budgets_brand_promotion;
SELECT * FROM SAL_CL.v_sal_budgets_customer_brand;
