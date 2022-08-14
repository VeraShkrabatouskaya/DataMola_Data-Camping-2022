alter session set current_schema = DW_DATA;

CREATE OR REPLACE PACKAGE pkg_etl_dw_promotion
AS  
    PROCEDURE load_dw_promotion;
END pkg_etl_dw_promotion;
/