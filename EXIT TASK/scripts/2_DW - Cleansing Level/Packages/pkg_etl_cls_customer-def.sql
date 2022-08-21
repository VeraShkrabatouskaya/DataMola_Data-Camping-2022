alter session set current_schema = DW_CL;

CREATE OR REPLACE PACKAGE pkg_etl_cls_customer
AS  
    PROCEDURE load_cls_customer;
END pkg_etl_cls_customer;
/