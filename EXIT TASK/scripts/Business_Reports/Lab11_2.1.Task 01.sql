alter session set current_schema=SAL_CL;
--drop table sal_cl_t_transaction CASCADE CONSTRAINTS;

--alter session set current_schema=sal_dw_cl;
--GRANT SELECT ON sal_dw_cl.sal_dw_cl_t_transaction TO SAL_CL;

alter session set current_schema=SAL_CL;

create table sal_cl_t_transaction_temp_Q3 as
select * from sal_cl_t_transaction
where 1=2;

select * from sal_cl_t_transaction_temp_Q3;

alter table sal_cl_t_transaction
   EXCHANGE partition QUARTER_3
   with table sal_cl_t_transaction_temp_Q3;

select * from sal_cl_t_transaction_temp_Q3;

--------------------------------------------------------------------------------

alter session set current_schema=SAL_CL;
select * from sal_cl.sal_cl_t_transaction order by 1;

SELECT * FROM ALL_TAB_PARTITIONS;
SELECT * FROM ALL_PART_TABLES WHERE TABLE_NAME = 'SAL_CL_T_TRANSACTION';

select num_rows, PARTITION_NAME , SUBPARTITION_NAME 
FROM ALL_TAB_SUBPARTITIONS;

SELECT * FROM SAL_CL_T_TRANSACTION partition (QUARTER_1);
SELECT * FROM SAL_CL_T_TRANSACTION partition (QUARTER_2);
SELECT * FROM SAL_CL_T_TRANSACTION partition (QUARTER_3);
SELECT * FROM SAL_CL_T_TRANSACTION partition (QUARTER_4);   

--DELETE FROM SAL_CL_T_TRANSACTION partition (QUARTER_3);
--ALTER TABLE SAL_CL_T_TRANSACTION DROP PARTITION QUARTER_3;
