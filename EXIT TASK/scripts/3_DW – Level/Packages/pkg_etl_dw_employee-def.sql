alter session set current_schema = DW_DATA;

CREATE OR REPLACE PACKAGE pkg_etl_dw_employee
AS  
    PROCEDURE load_dw_employee;
END pkg_etl_dw_employee;
/