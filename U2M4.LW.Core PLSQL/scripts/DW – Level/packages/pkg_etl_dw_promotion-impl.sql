alter session set current_schema = DW_CL;
GRANT SELECT ON DW_CL.cls_t_promotion TO DW_DATA;

alter session set current_schema = DW_DATA;

CREATE OR REPLACE PACKAGE body pkg_etl_dw_promotion
AS  
  PROCEDURE load_dw_promotion
   AS
     BEGIN 
      DECLARE
           TYPE CURSOR_VARCHAR IS TABLE OF varchar2(50);
           TYPE CURSOR_DECIMAL IS TABLE OF DECIMAL(30,2);
           TYPE CURSOR_DATE IS TABLE OF DATE;
           TYPE CURSOR_NUMBER IS TABLE OF number(10);
           
           TYPE BIG_CURSOR IS REF CURSOR;
           
           ALL_INF BIG_CURSOR;
           
           TIME_ID CURSOR_DATE;
           promotion_name CURSOR_VARCHAR;
           promotion_media_type CURSOR_VARCHAR;
           promotion_metric_amount CURSOR_DECIMAL;
           department_name CURSOR_VARCHAR;
           promotion_price CURSOR_DECIMAL;
           promotion_KPI CURSOR_VARCHAR;
           promotion_distinct_percent CURSOR_DECIMAL;
           employee_salary_project CURSOR_DECIMAL;
           
           promotion_name_stage CURSOR_VARCHAR;
           TIME_ID_stage CURSOR_DATE;
           promotion_ID CURSOR_NUMBER;

            BEGIN
                   OPEN ALL_INF FOR
                       SELECT 
                            source_CL.TIME_ID AS TIME_ID_source_CL,
                            source_CL.promotion_name AS  promotion_name_source_CL,
                            source_CL.promotion_media_type AS  promotion_media_type_source_CL,
                            source_CL.promotion_metric_amount AS  promotion_metric_amount_source_CL,
                            source_CL.department_name AS department_name_source_CL,
                            source_CL.promotion_price AS  promotion_price_source_CL,
                            source_CL.promotion_KPI AS  promotion_KPI_source_CL,
                            source_CL.promotion_distinct_percent AS promotion_distinct_percent_source_CL,
                            source_CL.employee_salary_project AS  aemployee_salary_project_source_CL,
                             
                            stage.promotion_name AS promotion_name_stage,                           
                            stage.TIME_ID AS TIME_ID_stage,
                            stage.promotion_ID AS  promotion_ID
                          FROM (SELECT DISTINCT * FROM DW_CL.cls_t_promotion) source_CL
                                 LEFT JOIN DW_DATA.DIM_promotion stage
                                   ON (source_CL.promotion_name = stage.promotion_name AND source_CL.TIME_ID = stage.TIME_ID)
                       ;
                   FETCH ALL_INF
                   BULK COLLECT INTO
                                TIME_ID,
                                promotion_name,
                                promotion_media_type,
                                promotion_metric_amount,
                                department_name,
                                promotion_price,
                                promotion_KPI,
                                promotion_distinct_percent,
                                employee_salary_project,
                                                                
                                promotion_name_stage,
                                TIME_ID_stage,
                                promotion_ID;
                   CLOSE ALL_INF;
           
FOR i IN promotion_ID.FIRST .. promotion_ID.LAST LOOP
       IF ( promotion_ID ( i ) IS NULL ) THEN
          INSERT INTO DW_DATA.DIM_promotion ( 
                                            promotion_ID,     
                                            TIME_ID,
                                            promotion_name,
                                            promotion_media_type,
                                            promotion_metric_amount,
                                            department_name,
                                            promotion_price,
                                            promotion_KPI,
                                            promotion_distinct_percent,
                                            employee_salary_project)
               VALUES ( DW_DATA.SQ_DIM_promotion.NEXTVAL,
                                            TIME_ID(i),
                                            promotion_name(i),
                                            promotion_media_type(i),
                                            promotion_metric_amount(i),
                                            department_name(i),
                                            promotion_price(i),
                                            promotion_KPI(i),
                                            promotion_distinct_percent(i),
                                            employee_salary_project(i)                                        
                        );
          COMMIT;
          
          ELSE UPDATE DW_DATA.DIM_promotion
         SET 
            TIME_ID = TIME_ID(i),
            promotion_name = promotion_name(i),
            promotion_media_type = promotion_media_type(i),
            promotion_metric_amount = promotion_metric_amount(i),
            department_name = department_name(i),
            promotion_price = promotion_price(i),
            promotion_KPI = promotion_KPI(i),
            promotion_distinct_percent = promotion_distinct_percent(i),
            employee_salary_project = employee_salary_project(i)
         WHERE promotion_ID = promotion_ID(i);
	
	         COMMIT;
          
              
       END IF;
 
    END LOOP;
	  
	END;
   END load_dw_promotion;
END pkg_etl_dw_promotion;

--------------------------------------------------------------------------------
alter session set current_schema = DW_DATA;
alter user DW_DATA QUOTA UNLIMITED ON TS_DW_DATA_01;

EXEC pkg_etl_dw_promotion.load_dw_promotion;

SELECT * FROM DW_DATA.DIM_promotion;

SELECT count(*) FROM DW_DATA.DIM_promotion;

--------------------------------------------------------------------------------
