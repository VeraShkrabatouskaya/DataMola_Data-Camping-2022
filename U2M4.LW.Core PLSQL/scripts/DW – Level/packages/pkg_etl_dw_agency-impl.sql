alter session set current_schema = DW_CL;
GRANT SELECT ON DW_CL.cls_t_agency TO DW_DATA;

alter session set current_schema = DW_DATA;

CREATE OR REPLACE PACKAGE body pkg_etl_dw_agency
AS  
  PROCEDURE load_dw_agency
   AS
     BEGIN 
      DECLARE
           TYPE CURSOR_VARCHAR IS TABLE OF varchar2(50);
           TYPE CURSOR_DECIMAL IS TABLE OF DECIMAL(10,2);
           TYPE CURSOR_NUMBER IS TABLE OF number(10);
           
           TYPE BIG_CURSOR IS REF CURSOR;
           
           ALL_INF BIG_CURSOR;
           
           agency_name CURSOR_VARCHAR;
           department_name CURSOR_VARCHAR;
           agency_city CURSOR_VARCHAR;
           agency_country CURSOR_VARCHAR;
           agency_address CURSOR_VARCHAR;
           agency_postcode CURSOR_VARCHAR;
           agency_email CURSOR_VARCHAR;
           agency_office_phone CURSOR_VARCHAR;
           agency_mobile_phone CURSOR_VARCHAR;
           agency_Fee_percent CURSOR_DECIMAL;
           agency_VAT_percent CURSOR_DECIMAL;
           
           agency_address_stage CURSOR_VARCHAR;
           agency_ID CURSOR_NUMBER;

            BEGIN
                   OPEN ALL_INF FOR
                       SELECT 
                            source_CL.agency_name AS  agency_name_source_CL,
                            source_CL.department_name AS department_name_source_CL,
                            source_CL.agency_city AS  agency_city_source_CL,
                            source_CL.agency_country AS  agency_country_source_CL,
                            source_CL.agency_address AS  agency_address_source_CL,
                            source_CL.agency_postcode AS agency_postcode_source_CL,
                            source_CL.agency_email AS  agency_email_source_CL,
                            source_CL.agency_office_phone AS  agency_office_phone_source_CL,
                            source_CL.agency_mobile_phone AS agency_mobile_phone_source_CL,
                            source_CL.agency_Fee_percent AS  agency_Fee_percent_source_CL,
                            source_CL.agency_VAT_percent AS  agency_VAT_percent_source_CL,
                            
                            stage.agency_address AS agency_address_stage,
                            stage.agency_ID AS  agency_ID
                          FROM (SELECT DISTINCT * FROM DW_CL.cls_t_agency) source_CL
                                 LEFT JOIN DW_DATA.DIM_agency stage
                                   ON (source_CL.agency_address = stage.agency_address and source_CL.department_name = stage.department_name);
                   FETCH ALL_INF
                   BULK COLLECT INTO
                                agency_name,
                                department_name,
                                agency_city,
                                agency_country,
                                agency_address,
                                agency_postcode,
                                agency_email,
                                agency_office_phone,
                                agency_mobile_phone,
                                agency_Fee_percent,    
                                agency_VAT_percent,  
                                
                                agency_address_stage,
                                agency_ID;
                   CLOSE ALL_INF;
           
FOR i IN agency_ID.FIRST .. agency_ID.LAST LOOP
       IF ( agency_ID ( i ) IS NULL ) THEN
          INSERT INTO DW_DATA.DIM_agency ( 
                                            agency_ID,     
                                            agency_name,
                                            department_name,
                                            agency_city,
                                            agency_country,
                                            agency_address,
                                            agency_postcode,
                                            agency_email,
                                            agency_office_phone,
                                            agency_mobile_phone,
                                            agency_Fee_percent,    
                                            agency_VAT_percent)
               VALUES ( DW_DATA.SQ_DIM_agency.NEXTVAL,
                                            agency_name(i),
                                            department_name(i),
                                            agency_city(i),
                                            agency_country(i),
                                            agency_address(i),
                                            agency_postcode(i),
                                            agency_email(i),
                                            agency_office_phone(i),
                                            agency_mobile_phone(i),
                                            agency_Fee_percent(i),    
                                            agency_VAT_percent(i)                                          
                        );
          COMMIT;
          
          ELSE UPDATE DW_DATA.DIM_agency
         SET 
            agency_name = agency_name(i),
            department_name = department_name(i),
            agency_city = agency_city(i),
            agency_country = agency_country(i),
            agency_address = agency_address(i),
            agency_postcode = agency_postcode(i),
            agency_email = agency_email(i),
            agency_office_phone = agency_office_phone(i),
            agency_mobile_phone = agency_mobile_phone(i),
            agency_Fee_percent = agency_Fee_percent(i),
            agency_VAT_percent = agency_VAT_percent(i)
         WHERE agency_ID = agency_ID(i);
	
	         COMMIT;
          
              
       END IF;
 
    END LOOP;
	  
	END;
   END load_dw_agency;
END pkg_etl_dw_agency;

--------------------------------------------------------------------------------
alter session set current_schema = DW_DATA;
alter user DW_DATA QUOTA UNLIMITED ON TS_DW_DATA_01;

EXEC pkg_etl_dw_agency.load_dw_agency;
SELECT * FROM DW_DATA.DIM_agency;

SELECT * FROM DW_DATA.DIM_agency where department_name = 'Production';

SELECT count(*) FROM DW_DATA.DIM_agency;
--------------------------------------------------------------------------------
