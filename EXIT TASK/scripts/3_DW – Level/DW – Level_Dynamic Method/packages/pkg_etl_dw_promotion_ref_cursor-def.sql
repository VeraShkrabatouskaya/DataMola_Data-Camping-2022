alter session set current_schema = DW_DATA;

CREATE OR REPLACE PACKAGE pkg_etl_dw_promotion_ref_cursor
AS  
    PROCEDURE load_dw_promotion_ref_cursor;
END pkg_etl_dw_promotion_ref_cursor;
/