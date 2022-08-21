alter session set current_schema = DW_CL;

CREATE OR REPLACE PACKAGE pkg_etl_cls_employee
AS  
    PROCEDURE load_cls_employee;
END pkg_etl_cls_employee;
/