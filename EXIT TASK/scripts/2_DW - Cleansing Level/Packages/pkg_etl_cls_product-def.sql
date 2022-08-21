alter session set current_schema = DW_CL;

CREATE OR REPLACE PACKAGE pkg_etl_cls_product
AS  
    PROCEDURE load_cls_product;
END pkg_etl_cls_product;
/