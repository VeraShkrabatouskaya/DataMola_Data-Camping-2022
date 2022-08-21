alter session set current_schema=DM_QUANTITY;
--drop view SAL_CL.v_sal_quantity_agency_promotion;
--drop view SAL_CL.v_sal_quantity_agency_customer_brand;
--drop view SAL_CL.v_sal_quantity_agency_employee;
--drop view SAL_CL.v_sal_quantity_agency_promotion;

alter session set current_schema = DW_DATA;
GRANT DELETE,INSERT,UPDATE,SELECT on DW_DATA.FCT_BUSINESS TO DM_QUANTITY;
GRANT DELETE,INSERT,UPDATE,SELECT on DW_DATA.DIM_CUSTOMER TO DM_QUANTITY;
GRANT DELETE,INSERT,UPDATE,SELECT on DW_DATA.DIM_AGENCY TO DM_QUANTITY;
GRANT DELETE,INSERT,UPDATE,SELECT on DW_DATA.DIM_PROMOTION TO DM_QUANTITY;

alter session set current_schema=DM_QUANTITY;
SELECT * FROM SAL_CL.v_sal_quantity_agency_promotion;
SELECT * FROM SAL_CL.v_sal_quantity_agency_customer_brand;
SELECT * FROM SAL_CL.v_sal_quantity_agency_employee;
SELECT * FROM SAL_CL.v_sal_quantity_agency_promotion;



