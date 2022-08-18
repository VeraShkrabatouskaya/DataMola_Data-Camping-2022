alter session set current_schema = DW_CL;
GRANT SELECT ON DW_CL.cls_t_employee TO DW_DATA;

alter session set current_schema = DW_DATA;

CREATE OR REPLACE PACKAGE body pkg_etl_dw_employee
AS  
  PROCEDURE load_dw_employee
   AS
     BEGIN 
      DECLARE
           TYPE CURSOR_VARCHAR IS TABLE OF varchar2(50);
           TYPE CURSOR_NUMBER IS TABLE OF number(10);
           TYPE CURSOR_DATE IS TABLE OF DATE;
           
           TYPE BIG_CURSOR IS REF CURSOR;
           
           ALL_INF BIG_CURSOR;
           
           employee_passport_ID CURSOR_VARCHAR;
           employee_first_name CURSOR_VARCHAR;
           employee_last_name CURSOR_VARCHAR;
           employee_position CURSOR_VARCHAR;
           employee_email CURSOR_VARCHAR;
           employee_office_phone CURSOR_VARCHAR;
           employee_mobile_phone CURSOR_VARCHAR;
           employee_date_of_hire CURSOR_DATE;
           employee_date_end_of_contract CURSOR_DATE;
           current_flg CURSOR_VARCHAR;
           
           employee_passport_ID_stage CURSOR_VARCHAR;
           employee_position_stage CURSOR_VARCHAR;
           employee_ID CURSOR_NUMBER;

            BEGIN
                   OPEN ALL_INF FOR
                       SELECT 
                            source_CL.employee_passport_ID AS  employee_passport_ID_source_CL,
                            source_CL.employee_first_name AS employee_first_name_source_CL,
                            source_CL.employee_last_name AS  employee_last_name_source_CL,
                            source_CL.employee_position AS  employee_position_source_CL,
                            source_CL.employee_email AS  employee_email_source_CL,
                            source_CL.employee_office_phone AS employee_office_phone_source_CL,
                            source_CL.employee_mobile_phone AS  employee_mobile_phone_source_CL,
                            source_CL.employee_date_of_hire AS  employee_date_of_hire_source_CL,
                            source_CL.employee_date_end_of_contract AS  employee_date_end_of_contract_source_CL,
                            source_CL.current_flg AS  current_flg_source_CL,
                            
                            stage.employee_passport_ID AS employee_passport_ID_stage,
                            stage.employee_position AS employee_position_stage,
                            stage.employee_ID AS  employee_ID
                          FROM (SELECT DISTINCT * FROM DW_CL.cls_t_employee) source_CL
                                 LEFT JOIN DW_DATA.DIM_employee stage
                                   ON (source_CL.employee_passport_ID = stage.employee_passport_ID and source_CL.employee_position = stage.employee_position);
                   FETCH ALL_INF
                   BULK COLLECT INTO
                                employee_passport_ID,
                                employee_first_name,
                                employee_last_name,
                                employee_position,
                                employee_email,
                                employee_office_phone,
                                employee_mobile_phone,
                                employee_date_of_hire,
                                employee_date_end_of_contract,
                                current_flg,
                                
                                employee_passport_ID_stage,
                                employee_position_stage,
                                employee_ID;
                   CLOSE ALL_INF;
           
FOR i IN employee_ID.FIRST .. employee_ID.LAST LOOP
       IF ( employee_ID ( i ) IS NULL ) THEN
          INSERT INTO DW_DATA.DIM_employee ( 
                                            employee_ID,
                                            
                                            employee_passport_ID,
                                            employee_first_name,
                                            employee_last_name,
                                            employee_position,
                                            employee_email,
                                            employee_office_phone,
                                            employee_mobile_phone,
                                            employee_date_of_hire,
                                            employee_date_end_of_contract,
                                            current_flg)
               VALUES ( SQ_DIM_employee.NEXTVAL,
                                            employee_passport_ID(i),
                                            employee_first_name(i),
                                            employee_last_name(i),
                                            employee_position(i),
                                            employee_email(i),
                                            employee_office_phone(i),
                                            employee_mobile_phone(i),
                                            employee_date_of_hire(i),
                                            employee_date_end_of_contract(i),
                                            current_flg (i)
                        );
          COMMIT;
          
          ELSE UPDATE DW_DATA.DIM_employee
         SET 
            employee_passport_ID = employee_passport_ID(i),
            employee_first_name = employee_first_name(i),
            employee_last_name = employee_last_name(i),
            employee_position = employee_position(i),
            employee_email = employee_email(i),
            employee_office_phone = employee_office_phone(i),
            employee_mobile_phone = employee_mobile_phone(i),
            employee_date_of_hire = employee_date_of_hire(i),
            employee_date_end_of_contract = employee_date_end_of_contract(i),
            current_flg = current_flg (i)
         WHERE employee_ID = employee_ID(i);
	
	         COMMIT;
          
              
       END IF;
 
    END LOOP;
	  
	END;
   END load_dw_employee;
END pkg_etl_dw_employee;

--------------------------------------------------------------------------------
alter session set current_schema = DW_DATA;
alter user DW_DATA QUOTA UNLIMITED ON TS_DW_DATA_01;

EXEC pkg_etl_dw_employee.load_dw_employee;
SELECT * FROM DW_DATA.DIM_employee;

--------------------------------------------------------------------------------
