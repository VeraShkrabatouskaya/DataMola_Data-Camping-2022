alter session set current_schema = DW_CL;

CREATE OR REPLACE PACKAGE body pkg_etl_cls_employee
AS  
  PROCEDURE load_cls_employee
   AS
      CURSOR cursor_cls_employee
      IS
         SELECT DISTINCT employee_passport_ID, employee_first_name, employee_last_name, employee_position, employee_email, employee_office_phone, employee_mobile_phone, employee_date_of_hire, employee_date_end_of_contract           FROM sa_employees.SA_EMPLOYEE_DATA_TOTAL
           WHERE employee_passport_ID IS NOT NULL 
                 AND employee_first_name IS NOT NULL
                 AND employee_last_name IS NOT NULL
                 AND employee_position IS NOT NULL
                 AND employee_email IS NOT NULL
                 AND employee_office_phone IS NOT NULL
                 AND employee_mobile_phone IS NOT NULL
                 AND employee_date_of_hire IS NOT NULL
                 AND employee_date_end_of_contract IS NOT NULL
                 ;
  
   BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE DW_CL.cls_t_employee';
      FOR i IN cursor_cls_employee LOOP
         INSERT INTO DW_CL.cls_t_employee( 
                employee_passport_ID,
                employee_first_name,
                employee_last_name,
                employee_position,
                employee_email,
                employee_office_phone,
                employee_mobile_phone,
                employee_date_of_hire,
                employee_date_end_of_contract)
              VALUES ( 
                i.employee_passport_ID,
                i.employee_first_name,
                i.employee_last_name,
                i.employee_position,
                i.employee_email,
                i.employee_office_phone,
                i.employee_mobile_phone,
                i.employee_date_of_hire,
                i.employee_date_end_of_contract);
         EXIT WHEN cursor_cls_employee%NOTFOUND;
      END LOOP;

      COMMIT;
   END load_cls_employee;
END pkg_etl_cls_employee;
--------------------------------------------------------------------------------
alter session set current_schema = DW_CL;
alter user DW_CL QUOTA UNLIMITED ON ts_dw_cl;

EXEC pkg_etl_cls_employee.load_cls_employee;

SELECT * FROM cls_t_employee;
SELECT count(*) FROM cls_t_employee;
--------------------------------------------------------------------------------
