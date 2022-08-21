alter session set current_schema = DW_CL;

CREATE OR REPLACE PACKAGE body pkg_etl_cls_product
AS  
  PROCEDURE load_cls_product
   AS
      CURSOR cursor_cls_product
      IS
         SELECT DISTINCT brand_name, product_name,category_name, subcategory_name 
           FROM sa_customers.SA_CUSTOMER_DATA_with_department
           WHERE brand_name IS NOT NULL 
                 AND product_name IS NOT NULL
                 AND category_name IS NOT NULL
                 AND subcategory_name  IS NOT NULL
                 ;
  
   BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE DW_CL.cls_t_product';
      FOR i IN cursor_cls_product LOOP
         INSERT INTO DW_CL.cls_t_product( 
                brand_name,
                product_name,
                category_name,
                subcategory_name)
              VALUES ( 
                i.brand_name,
                i.product_name,
                i.category_name,
                i.subcategory_name);
         EXIT WHEN cursor_cls_product%NOTFOUND;
      END LOOP;

      COMMIT;
   END load_cls_product;
END pkg_etl_cls_product;
--------------------------------------------------------------------------------
alter session set current_schema = DW_CL;
alter user DW_CL QUOTA UNLIMITED ON ts_dw_cl;

EXEC pkg_etl_cls_product.load_cls_product;

SELECT * FROM cls_t_product;
--------------------------------------------------------------------------------
