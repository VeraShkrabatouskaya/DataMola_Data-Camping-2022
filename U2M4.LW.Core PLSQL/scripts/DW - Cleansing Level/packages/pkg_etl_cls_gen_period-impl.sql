alter session set current_schema = DW_CL;

CREATE OR REPLACE PACKAGE body pkg_etl_cls_DIM_gen_period
AS  
  PROCEDURE load_cls_DIM_gen_period
   AS
      CURSOR cursor_cls_DIM_gen_period
      IS
         SELECT DISTINCT promotion_name, promotion_start, promotion_end
           FROM sa_promotions.SA_PROMOTION_DATA_TOTAL
           WHERE promotion_name IS NOT NULL 
                 AND promotion_start IS NOT NULL
                 AND promotion_end IS NOT NULL
                 ;
  
   BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE DW_CL.cls_t_DIM_gen_period';
      FOR i IN cursor_cls_DIM_gen_period LOOP
         INSERT INTO DW_CL.cls_t_DIM_gen_period( 
                promotion_name,
                promotion_start,
                promotion_end)
              VALUES ( 
                i.promotion_name, 
                i.promotion_start,
                i.promotion_end);
         EXIT WHEN cursor_cls_DIM_gen_period%NOTFOUND;
      END LOOP;

      COMMIT;
   END load_cls_DIM_gen_period;
END pkg_etl_cls_DIM_gen_period;
--------------------------------------------------------------------------------
alter session set current_schema = DW_CL;
alter user DW_CL QUOTA UNLIMITED ON ts_dw_cl;

EXEC pkg_etl_cls_DIM_gen_period.load_cls_DIM_gen_period;

SELECT * FROM cls_t_DIM_gen_period;
--------------------------------------------------------------------------------
