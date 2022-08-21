alter session set current_schema = DW_DATA;

CREATE OR REPLACE PACKAGE pkg_etl_dw_gen_period
AS  
    PROCEDURE load_dw_gen_period;
END pkg_etl_dw_gen_period;
/