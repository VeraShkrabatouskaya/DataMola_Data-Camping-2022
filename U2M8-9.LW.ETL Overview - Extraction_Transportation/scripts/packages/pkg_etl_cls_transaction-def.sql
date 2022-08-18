alter session set current_schema = DW_CL;

CREATE OR REPLACE PACKAGE pkg_etl_cls_transaction
AS  
    PROCEDURE load_cls_transaction;
END pkg_etl_cls_transaction;
/
