alter session set current_schema = SAL_CL;

CREATE OR REPLACE PACKAGE pkg_etl_sal_cl_t_transaction
AS  
    PROCEDURE load_sal_cl_t_transaction;
END pkg_etl_sal_cl_t_transaction;
/
