alter session set current_schema = DW_CL;
GRANT SELECT ON DW_CL.cls_t_product TO DW_DATA;

alter session set current_schema = DW_DATA;

CREATE OR REPLACE PACKAGE body pkg_etl_dw_product
AS  
  PROCEDURE load_dw_product
   AS
     BEGIN
     MERGE INTO DW_DATA.dim_product A
     USING ( SELECT brand_name, product_name, category_name, subcategory_name FROM DW_CL.cls_t_product) B
             ON (a.brand_name = b.brand_name AND a.product_name = b.product_name)
             WHEN MATCHED THEN 
                UPDATE SET a.category_name = b.category_name, a.subcategory_name = b.subcategory_name
             WHEN NOT MATCHED THEN 
                INSERT (a.product_ID, a.brand_name, a.product_name, a.category_name, a.subcategory_name)
                VALUES (DW_DATA.SQ_DIM_product.NEXTVAL, b.brand_name, b.product_name, b.category_name, b.subcategory_name);
     COMMIT;
   END load_dw_product;
END pkg_etl_dw_product;

--------------------------------------------------------------------------------
alter session set current_schema = DW_DATA;
alter user DW_DATA QUOTA UNLIMITED ON TS_DW_DATA_01;

EXEC pkg_etl_dw_product.load_dw_product;
SELECT * FROM DW_DATA.DIM_product;

--------------------------------------------------------------------------------
