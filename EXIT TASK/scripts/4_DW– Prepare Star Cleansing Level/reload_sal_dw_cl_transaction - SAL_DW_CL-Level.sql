alter session set current_schema = SAL_DW_CL;
alter user SAL_DW_CL QUOTA UNLIMITED ON ts_dw_str_cls;

BEGIN
   pkg_etl_sal_dw_cl_transaction.load_sal_dw_cl_transaction;
END;

SELECT * FROM sal_dw_cl_t_transaction order by 1;
 
