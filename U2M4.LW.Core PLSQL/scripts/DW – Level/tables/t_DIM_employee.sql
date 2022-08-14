--drop table DW_DATA.DIM_employee;
alter session set current_schema = DW_DATA;

CREATE TABLE DW_DATA.DIM_employee(
    employee_ID NUMBER(10),     
    employee_passport_ID            VARCHAR2(14),
    employee_first_name             VARCHAR2(40),
    employee_last_name              VARCHAR2(50),
    employee_position               VARCHAR2(50),
    employee_email                  VARCHAR2(50),
    employee_office_phone           VARCHAR2(30),
    employee_mobile_phone           VARCHAR2(30),
    employee_date_of_hire           DATE,
    employee_date_end_of_contract   DATE,
    CONSTRAINT "PK_T.DIM_employee" PRIMARY KEY(employee_ID) 
);

select * from DW_DATA.DIM_employee;
select * from DW_DATA.DIM_employee where employee_id=37;
