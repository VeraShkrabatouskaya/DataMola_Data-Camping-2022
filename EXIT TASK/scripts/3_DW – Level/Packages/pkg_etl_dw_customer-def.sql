alter session set current_schema = DW_DATA;

CREATE OR REPLACE PACKAGE pkg_etl_dw_customer
AS  
    PROCEDURE load_dw_customer;
END pkg_etl_dw_customer;
/