alter session set current_schema = DW_CL;
GRANT SELECT ON DW_CL.cls_t_DIM_gen_period TO DW_DATA;

alter session set current_schema = DW_DATA;

CREATE OR REPLACE PACKAGE body pkg_etl_dw_gen_period
AS  
  PROCEDURE load_dw_gen_period
   AS
     BEGIN
     MERGE INTO DW_DATA.DIM_gen_period A
     USING ( SELECT promotion_name, promotion_start, promotion_end FROM DW_CL.cls_t_DIM_gen_period) B
             ON (a.promotion_name = b.promotion_name)
             WHEN MATCHED THEN 
                UPDATE SET a.promotion_start = b.promotion_start, a.promotion_end = b.promotion_end
             WHEN NOT MATCHED THEN 
                INSERT (a.gen_period_ID, a.promotion_name, a.promotion_start, a.promotion_end)
                VALUES (DW_DATA.SQ_DIM_gen_period.NEXTVAL, b.promotion_name, b.promotion_start, b.promotion_end);
     COMMIT;
   END load_dw_gen_period;
END pkg_etl_dw_gen_period;

--------------------------------------------------------------------------------
alter session set current_schema = DW_DATA;
alter user DW_DATA QUOTA UNLIMITED ON TS_DW_DATA_01;

EXEC pkg_etl_dw_gen_period.load_dw_gen_period;
SELECT * FROM DW_DATA.DIM_gen_period;

--------------------------------------------------------------------------------
