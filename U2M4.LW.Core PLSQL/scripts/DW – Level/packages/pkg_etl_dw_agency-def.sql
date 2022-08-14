alter session set current_schema = DW_DATA;

CREATE OR REPLACE PACKAGE pkg_etl_dw_agency
AS  
    PROCEDURE load_dw_agency;
END pkg_etl_dw_agency;
/
