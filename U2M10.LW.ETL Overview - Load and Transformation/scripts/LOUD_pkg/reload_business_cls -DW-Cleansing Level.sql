alter session set current_schema = DW_CL;
alter user DW_CL QUOTA UNLIMITED ON ts_dw_cl;

BEGIN
   pkg_etl_cls_customer.load_cls_customer;
   pkg_etl_cls_employee.load_cls_employee;
   pkg_etl_cls_agency.load_cls_agency;
   pkg_etl_cls_DIM_gen_period.load_cls_DIM_gen_period;
   pkg_etl_cls_product.load_cls_product;
   pkg_etl_cls_promotion.load_cls_promotion;
   pkg_etl_cls_transaction.load_cls_transaction;
END;

SELECT * FROM DW_CL.cls_t_customer;
SELECT * FROM DW_CL.cls_t_employee;
SELECT * FROM DW_CL.cls_t_agency;
SELECT * FROM DW_CL.cls_t_DIM_gen_period;
SELECT * FROM DW_CL.cls_t_product;
SELECT * FROM DW_CL.cls_t_promotion;
SELECT * FROM cls_t_transaction;

 
