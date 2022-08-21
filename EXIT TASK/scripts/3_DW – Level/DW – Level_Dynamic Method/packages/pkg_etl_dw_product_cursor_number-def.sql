alter session set current_schema = DW_DATA;

CREATE OR REPLACE PACKAGE pkg_etl_dw_product_cursor_number
AS  
    PROCEDURE load_dw_product_cursor_number;
END pkg_etl_dw_product_cursor_number;
/