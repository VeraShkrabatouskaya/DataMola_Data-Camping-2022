alter session set current_schema = SAL_DW_CL;

CREATE OR REPLACE PACKAGE pkg_etl_sal_dw_cl_transaction
AS  
    PROCEDURE load_sal_dw_cl_transaction;
END pkg_etl_sal_dw_cl_transaction;
/
