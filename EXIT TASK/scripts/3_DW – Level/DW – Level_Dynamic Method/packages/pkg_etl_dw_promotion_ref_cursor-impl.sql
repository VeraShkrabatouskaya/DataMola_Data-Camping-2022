alter session set current_schema = DW_CL;
GRANT SELECT ON DW_CL.cls_t_promotion TO DW_DATA;

alter session set current_schema = DW_DATA;

CREATE OR REPLACE PACKAGE body pkg_etl_dw_promotion_ref_cursor
AS  
  PROCEDURE load_dw_promotion_ref_cursor
   AS
     BEGIN 
     DECLARE 
       cursor_id NUMBER (25);
       cur_count NUMBER (38);
       quary_cur VARCHAR2(2000);
       TYPE ref_crsr IS REF CURSOR;
       ref_cursor ref_crsr;
       TYPE type_rec IS RECORD
    (  TIME_ID DATE,
       promotion_name VARCHAR2(50),
       promotion_media_type VARCHAR2(30),
       promotion_metric_amount DECIMAL (10,2),
       department_name VARCHAR2(50),
       promotion_price DECIMAL (10,2),
       promotion_KPI VARCHAR2(30),
       promotion_distinct_percent DECIMAL (10,2),
       employee_salary_project    DECIMAL (30,2),
       promotion_ID NUMBER);
       one_record type_rec;
       
     BEGIN 
     EXECUTE IMMEDIATE 'TRUNCATE TABLE DW_DATA.dim_promotion CASCADE';
     quary_cur:= 'SELECT 
                  TIME_ID, 
                  promotion_name, 
                  promotion_media_type,
                  promotion_metric_amount,
                  department_name,
                  promotion_price,
                  promotion_KPI,
                  promotion_distinct_percent,
                  employee_salary_project,
                  promotion_ID FROM
                        (SELECT source.TIME_ID AS TIME_ID,
                         source.promotion_name AS promotion_name, 
                         source.promotion_media_type AS  promotion_media_type,
                         source.promotion_metric_amount AS  promotion_metric_amount,
                         source.department_name AS department_name,
                         source.promotion_price AS promotion_price,
                         source.promotion_KPI AS promotion_KPI,
                         source.promotion_distinct_percent AS promotion_distinct_percent,
                         source.employee_salary_project AS employee_salary_project,
                         stage.promotion_ID AS promotion_ID
                  FROM DW_CL.cls_t_promotion source
                  LEFT JOIN DW_DATA.DIM_promotion stage
                  ON (source.promotion_name = stage.promotion_name AND source.TIME_ID = stage.TIME_ID))';
                  
      cursor_id:=DBMS_SQL.open_cursor;
      
      DBMS_SQL.PARSE(cursor_id, quary_cur, DBMS_SQL.NATIVE);
      
      cur_count:= DBMS_SQL.EXECUTE(cursor_id);
      
      ref_cursor:= DBMS_SQL.TO_REFCURSOR(cursor_id);
      
      LOOP
      FETCH ref_cursor INTO one_record;
      EXIT WHEN ref_cursor%NOTFOUND;
      IF (one_record.promotion_ID IS NULL) THEN
                INSERT INTO DW_DATA.DIM_promotion(  promotion_ID,
                                                    TIME_ID,
                                                    promotion_name,
                                                    promotion_media_type,
                                                    promotion_metric_amount,
                                                    department_name,
                                                    promotion_price,
                                                    promotion_KPI,
                                                    promotion_distinct_percent,
                                                    employee_salary_project)
                VALUES (DW_DATA.SQ_DIM_promotion.NEXTVAL,
                        one_record.TIME_ID, 
                        one_record.promotion_name,
                        one_record.promotion_media_type,
                        one_record.promotion_metric_amount, 
                        one_record.department_name,
                        one_record.promotion_price,
                        one_record.promotion_KPI, 
                        one_record.promotion_distinct_percent,
                        one_record.employee_salary_project
                        ); 
      END IF;
      END LOOP;
    COMMIT;
    END;
   END load_dw_promotion_ref_cursor;
END pkg_etl_dw_promotion_ref_cursor;
--------------------------------------------------------------------------------
alter session set current_schema = DW_DATA;
alter user DW_DATA QUOTA UNLIMITED ON TS_DW_DATA_01;

EXEC pkg_etl_dw_promotion_ref_cursor.load_dw_promotion_ref_cursor;

SELECT * FROM DW_DATA.DIM_promotion order by 1;

SELECT count(*) FROM DW_DATA.DIM_promotion;

--------------------------------------------------------------------------------
