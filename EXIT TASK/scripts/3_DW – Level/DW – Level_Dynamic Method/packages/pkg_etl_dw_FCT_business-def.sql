alter session set current_schema = DW_DATA;

CREATE OR REPLACE PACKAGE pkg_etl_dw_transaction
AS  
    PROCEDURE load_dw_transaction;
END pkg_etl_dw_transaction;
/
