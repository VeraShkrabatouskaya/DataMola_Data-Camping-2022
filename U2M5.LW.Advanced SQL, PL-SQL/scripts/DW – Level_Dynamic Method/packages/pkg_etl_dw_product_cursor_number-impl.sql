alter session set current_schema = DW_CL;
GRANT SELECT ON DW_CL.cls_t_product TO DW_DATA;

alter session set current_schema = DW_DATA;

CREATE OR REPLACE PACKAGE body pkg_etl_dw_product_cursor_number
AS  
 PROCEDURE load_dw_product_cursor_number
   AS
   BEGIN
      DECLARE
    
       TYPE BIG_CURSOR IS REF CURSOR;
       TYPE T_REC_product IS RECORD
       (
       brand_name  VARCHAR2(50),
       product_name  VARCHAR2(50),
       category_name  VARCHAR2(50),
       subcategory_name  VARCHAR2(50),
       
       product_name_stage VARCHAR(20),
       product_ID NUMBER );
       TYPE t_product  IS TABLE OF T_REC_product ;
       ALL_INF BIG_CURSOR;
    record_product  t_product ;
    curid NUMBER ( 25 );
 BEGIN
    OPEN ALL_INF FOR
        SELECT source_CL.brand_name AS brand_name_source_CL
                 , source_CL.product_name AS product_name_source_CL
                 , source_CL.category_name AS category_name_source_CL
                 , source_CL.subcategory_name AS subcategory_name_source_CL
                 
                 , stage.product_name AS product_name_stage
                 , STAGE.product_ID AS product_ID
           FROM (SELECT DISTINCT * FROM DW_CL.cls_t_product) source_CL
                     LEFT JOIN
                        DW_DATA.DIM_product stage
                     ON (source_CL.product_name = stage.product_name);

 
    FETCH ALL_INF
    BULK COLLECT INTO record_product ;
    
 
       curid := dbms_sql.to_cursor_number ( ALL_INF );
    dbms_sql.close_cursor ( curid );
       
    FOR i IN record_product.FIRST .. record_product.LAST LOOP
       IF ( record_product(i).product_ID IS NULL ) THEN
          INSERT INTO dim_product(  product_ID,
                                                    brand_name,
                                                    product_name,
                                                    category_name,
                                                    subcategory_name)
               VALUES ( SQ_DIM_product.NEXTVAL
                      , record_product(i).brand_name
                         , record_product(i).product_name
                         , record_product(i).category_name
                         , record_product(i).subcategory_name);
 
          COMMIT;
       END IF;
    END LOOP;
 END;
   END load_dw_product_cursor_number;
END pkg_etl_dw_product_cursor_number;
--------------------------------------------------------------------------------
alter session set current_schema = DW_DATA;
alter user DW_DATA QUOTA UNLIMITED ON TS_DW_DATA_01;

EXEC pkg_etl_dw_product_cursor_number.load_dw_product_cursor_number;

SELECT * FROM DW_DATA.DIM_product order by 1;

SELECT count(*) FROM DW_DATA.DIM_product;

--------------------------------------------------------------------------------
