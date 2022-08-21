alter session set current_schema = DW_CL;

CREATE OR REPLACE PACKAGE body pkg_etl_cls_agency
AS  
  PROCEDURE load_cls_agency
   AS
      CURSOR cursor_cls_agency
      IS
         SELECT DISTINCT agency_name, department_name, agency_address, agency_city, agency_country, agency_postcode, agency_email, agency_office_phone, agency_mobile_phone, agency_Fee_percent, agency_VAT_percent   
           FROM sa_customers.SA_CUSTOMER_DATA_with_department
           WHERE agency_name IS NOT NULL 
                 AND department_name IS NOT NULL
                 AND agency_address IS NOT NULL
                 AND agency_city  IS NOT NULL
                 AND agency_postcode IS NOT NULL
                 AND agency_country IS NOT NULL
                 AND agency_email IS NOT NULL
                 AND agency_office_phone IS NOT NULL
                 AND agency_mobile_phone IS NOT NULL
                 AND agency_Fee_percent IS NOT NULL
                 AND agency_VAT_percent IS NOT NULL                 
                 ;
  
   BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE DW_CL.cls_t_agency';
      FOR i IN cursor_cls_agency LOOP
         INSERT INTO DW_CL.cls_t_agency( 
                 agency_name,
                 department_name,
                 agency_address,
                 agency_city,
                 agency_postcode,
                 agency_country,
                 agency_email,
                 agency_office_phone,
                 agency_mobile_phone,
                 agency_Fee_percent,
                 agency_VAT_percent)
              VALUES ( 
                 i.agency_name,
                 i.department_name,
                 i.agency_address,
                 i.agency_city,
                 i.agency_postcode,
                 i.agency_country,
                 i.agency_email,
                 i.agency_office_phone,
                 i.agency_mobile_phone,
                 i.agency_Fee_percent,
                 i.agency_VAT_percent);
         EXIT WHEN cursor_cls_agency%NOTFOUND;
      END LOOP;

      COMMIT;
   END load_cls_agency;
END pkg_etl_cls_agency;
--------------------------------------------------------------------------------
alter session set current_schema = DW_CL;
alter user DW_CL QUOTA UNLIMITED ON ts_dw_cl;

EXEC pkg_etl_cls_agency.load_cls_agency;

SELECT * FROM cls_t_agency;
SELECT count(*) FROM cls_t_agency;
SELECT distinct agency_address FROM cls_t_agency;
--------------------------------------------------------------------------------
