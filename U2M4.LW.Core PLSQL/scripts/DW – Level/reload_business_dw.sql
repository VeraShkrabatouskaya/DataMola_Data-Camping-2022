alter session set current_schema = DW_DATA;
alter user DW_DATA QUOTA UNLIMITED ON TS_DW_DATA_01;

BEGIN
   pkg_etl_dw_customer.load_dw_customer;
   pkg_etl_dw_employee.load_dw_employee;
   pkg_etl_dw_agency.load_dw_agency;
   pkg_etl_dw_gen_period.load_dw_gen_period;
   pkg_etl_dw_product.load_dw_product;
   pkg_etl_dw_promotion.load_dw_promotion;
   pkg_etl_dw_transaction.load_dw_transaction;
END;

EXEC pkg_etl_dw_customer.load_dw_customer;
EXEC pkg_etl_dw_employee.load_dw_employee;
EXEC pkg_etl_dw_agency.load_dw_agency;
EXEC pkg_etl_dw_gen_period.load_dw_gen_period;
EXEC pkg_etl_dw_product.load_dw_product;
EXEC pkg_etl_dw_promotion.load_dw_promotion;
EXEC pkg_etl_dw_transaction.load_dw_transaction;

SELECT * FROM DW_DATA.DIM_customer;
SELECT * FROM DW_DATA.DIM_employee;
SELECT * FROM DW_DATA.DIM_agency;
SELECT * FROM DW_DATA.DIM_gen_period;
SELECT * FROM DW_DATA.DIM_product;
SELECT * FROM DW_DATA.DIM_promotion;
SELECT * from DW_DATA.FCT_business;
 
