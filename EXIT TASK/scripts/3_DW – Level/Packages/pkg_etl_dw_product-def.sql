alter session set current_schema = DW_DATA;

CREATE OR REPLACE PACKAGE pkg_etl_dw_product
AS  
    PROCEDURE load_dw_product;
END pkg_etl_dw_product;
/