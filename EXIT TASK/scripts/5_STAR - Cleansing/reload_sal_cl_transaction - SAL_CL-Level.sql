alter session set current_schema = SAL_CL;
GRANT SELECT ON SAL_DW_CL.sal_dw_cl_t_transaction TO SAL_CL;

BEGIN
   pkg_etl_sal_cl_t_transaction.load_sal_cl_t_transaction;
END;

SELECT * FROM sal_cl_t_transaction order by 1;
 
