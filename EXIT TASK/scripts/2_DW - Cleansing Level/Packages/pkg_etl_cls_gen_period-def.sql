alter session set current_schema = DW_CL;

CREATE OR REPLACE PACKAGE pkg_etl_cls_DIM_gen_period
AS  
    PROCEDURE load_cls_DIM_gen_period;
END pkg_etl_cls_DIM_gen_period;
/