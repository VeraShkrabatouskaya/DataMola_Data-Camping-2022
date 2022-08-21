alter session set current_schema = DW_CL;

CREATE OR REPLACE PACKAGE pkg_etl_cls_promotion
AS  
    PROCEDURE load_cls_promotion;
END pkg_etl_cls_promotion;
/