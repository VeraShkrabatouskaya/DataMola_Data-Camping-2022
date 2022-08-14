alter session set current_schema = DW_CL;
GRANT SELECT ON DW_CL.cls_t_customer TO DW_DATA;

alter session set current_schema = DW_DATA;

CREATE OR REPLACE PACKAGE body pkg_etl_dw_customer
AS  
  PROCEDURE load_dw_customer
   AS
     BEGIN 
      DECLARE
           TYPE CURSOR_VARCHAR IS TABLE OF varchar2(50);
           TYPE CURSOR_NUMBER IS TABLE OF number(10);
           
           TYPE BIG_CURSOR IS REF CURSOR;
           
           ALL_INF BIG_CURSOR;
           
           customer_name CURSOR_VARCHAR;
           brand_name CURSOR_VARCHAR;
           customer_address CURSOR_VARCHAR;
           customer_city CURSOR_VARCHAR;
           customer_country CURSOR_VARCHAR;
           customer_email CURSOR_VARCHAR;
           customer_office_phone CURSOR_VARCHAR;
           customer_mobile_phone CURSOR_VARCHAR;
           customer_name_stage CURSOR_VARCHAR;
           customer_ID CURSOR_NUMBER;

            BEGIN
                   OPEN ALL_INF FOR
                       SELECT 
                            source_CL.customer_name AS  customer_name_source_CL,
                            source_CL.brand_name AS brand_name_source_CL,
                            source_CL.customer_address AS  customer_address_source_CL,
                            source_CL.customer_city AS  customer_city_source_CL,
                            source_CL.customer_country AS  customer_country_source_CL,
                            source_CL.customer_email AS customer_email_source_CL,
                            source_CL.customer_office_phone AS  customer_office_phone_source_CL,
                            source_CL.customer_mobile_phone AS  customer_mobile_phone_source_CL,
                            stage.customer_name AS customer_name_stage,
                            stage.customer_ID AS  customer_ID
                          FROM (SELECT DISTINCT * FROM DW_CL.cls_t_customer) source_CL
                                 LEFT JOIN DW_DATA.DIM_customer stage
                                   ON (source_CL.customer_name = stage.customer_name);
                   FETCH ALL_INF
                   BULK COLLECT INTO
                                customer_name,
                                brand_name,
                                customer_address,
                                customer_city,
                                customer_country,
                                customer_email,
                                customer_office_phone,
                                customer_mobile_phone,
                                customer_name_stage,
                                customer_ID;
                   CLOSE ALL_INF;
           
FOR i IN customer_ID.FIRST .. customer_ID.LAST LOOP
       IF ( customer_ID ( i ) IS NULL ) THEN
          INSERT INTO DW_DATA.DIM_customer ( 
                                            customer_ID,
                                            customer_name,
                                            brand_name,
                                            customer_address,
                                            customer_city,
                                            customer_country,
                                            customer_email,
                                            customer_office_phone,
                                            customer_mobile_phone)
               VALUES ( SQ_DIM_customer.NEXTVAL,
                        customer_name(i),
                        brand_name(i),
                        customer_address(i),
                        customer_city(i),
                        customer_country(i),
                        customer_email(i),
                        customer_office_phone(i),
                        customer_mobile_phone(i)                                            
                        );
          COMMIT;
          
          ELSE UPDATE DW_DATA.DIM_customer
         SET 
            customer_name = customer_name(i),
            brand_name = brand_name(i),
            customer_address = customer_address(i),
            customer_city = customer_city(i),
            customer_country = customer_country(i),
            customer_email = customer_email(i),
            customer_office_phone = customer_office_phone(i),
            customer_mobile_phone = customer_mobile_phone(i)
         WHERE customer_ID = customer_ID(i);
	
	         COMMIT;
          
              
       END IF;
 
    END LOOP;
	  
	END;
   END load_dw_customer;
END pkg_etl_dw_customer;

--------------------------------------------------------------------------------
alter session set current_schema = DW_DATA;
alter user DW_DATA QUOTA UNLIMITED ON TS_DW_DATA_01;

EXEC pkg_etl_dw_customer.load_dw_customer;
SELECT * FROM DW_DATA.DIM_customer;

--------------------------------------------------------------------------------
