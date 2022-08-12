alter session set current_schema = DW_CL;

CREATE OR REPLACE PACKAGE body pkg_etl_cls_promotion
AS  
  PROCEDURE load_cls_promotion
   AS
      CURSOR cursor_cls_promotion
      IS
         SELECT DISTINCT promotion_name, promotion_media_type, promotion_metric_amount, department_name, promotion_price, promotion_KPI, promotion_distinct_percent, employee_salary_project
           FROM sa_promotions.SA_PROMOTION_DATA_TOTAL
           WHERE promotion_name IS NOT NULL 
                 AND promotion_media_type IS NOT NULL
                 AND promotion_metric_amount IS NOT NULL
                 AND department_name IS NOT NULL
                 AND promotion_price IS NOT NULL
                 AND promotion_KPI  IS NOT NULL
                 AND promotion_distinct_percent IS NOT NULL
                 AND employee_salary_project IS NOT NULL
                 ;
  
   BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE DW_CL.cls_t_promotion';
      FOR i IN cursor_cls_promotion LOOP
         INSERT INTO DW_CL.cls_t_promotion( 
                promotion_name,
                promotion_media_type,
                promotion_metric_amount,
                department_name,
                promotion_price,
                promotion_KPI,
                promotion_distinct_percent,
                employee_salary_project)
              VALUES ( 
                i.promotion_name, 
                i.promotion_media_type,
                i.promotion_metric_amount,
                i.department_name,
                i.promotion_price,
                i.promotion_KPI,
                i.promotion_distinct_percent,
                i.employee_salary_project);
         EXIT WHEN cursor_cls_promotion%NOTFOUND;
      END LOOP;

      COMMIT;
   END load_cls_promotion;
END pkg_etl_cls_promotion;
--------------------------------------------------------------------------------
alter session set current_schema = DW_CL;
alter user DW_CL QUOTA UNLIMITED ON ts_dw_cl;

EXEC pkg_etl_cls_promotion.load_cls_promotion;

SELECT * FROM cls_t_promotion;
--------------------------------------------------------------------------------
