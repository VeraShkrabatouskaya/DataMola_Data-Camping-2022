alter session set current_schema = DW_CL;

CREATE OR REPLACE PACKAGE body pkg_etl_cls_customer
AS  
  PROCEDURE load_cls_customer
   AS
      CURSOR cursor_cls_customer
      IS
         SELECT DISTINCT customer_name, brand_name, customer_address, customer_city, customer_country, customer_email, customer_office_phone, customer_mobile_phone
           FROM sa_customers.SA_CUSTOMER_DATA_with_department
           WHERE customer_name IS NOT NULL 
                 AND brand_name IS NOT NULL
                 AND customer_address IS NOT NULL
                 AND customer_city IS NOT NULL
                 AND customer_country IS NOT NULL
                 AND customer_email IS NOT NULL
                 AND customer_office_phone IS NOT NULL
                 AND customer_mobile_phone IS NOT NULL
                 ;
  
   BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE DW_CL.cls_t_customer';
      FOR i IN cursor_cls_customer LOOP
         INSERT INTO DW_CL.cls_t_customer( 
                customer_name,
                brand_name,
                customer_address,
                customer_city,
                customer_country,
                customer_email,
                customer_office_phone,
                customer_mobile_phone)
              VALUES ( 
                i.customer_name, 
                i.brand_name, 
                i.customer_address, 
                i.customer_city,
                i.customer_country,
                i.customer_email,
                i.customer_office_phone,
                i.customer_mobile_phone);
         EXIT WHEN cursor_cls_customer%NOTFOUND;
      END LOOP;

      COMMIT;
   END load_cls_customer;
END pkg_etl_cls_customer;
--------------------------------------------------------------------------------
alter session set current_schema = DW_CL;
alter user DW_CL QUOTA UNLIMITED ON ts_dw_cl;

EXEC pkg_etl_cls_customer.load_cls_customer;

SELECT * FROM cls_t_customer;
--------------------------------------------------------------------------------
