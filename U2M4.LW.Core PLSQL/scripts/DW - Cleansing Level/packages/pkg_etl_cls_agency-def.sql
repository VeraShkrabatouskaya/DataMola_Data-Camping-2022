alter session set current_schema = DW_CL;

CREATE OR REPLACE PACKAGE pkg_etl_cls_agency
AS  
    PROCEDURE load_cls_agency;
END pkg_etl_cls_agency;
/