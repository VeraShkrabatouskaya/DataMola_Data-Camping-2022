--alter session set current_schema=DW_CL;
--drop table cls_t_employee;

alter session set current_schema=DW_CL;

Create table cls_t_employee (
    employee_passport_ID             VARCHAR2(14) NOT NULL,
    employee_first_name              VARCHAR2(40) NOT NULL,
    employee_last_name               VARCHAR2(50) NOT NULL,
    employee_position                VARCHAR2(50) NOT NULL,
    employee_email                   VARCHAR2(50) NOT NULL,
    employee_office_phone            VARCHAR2(30) NOT NULL,
    employee_mobile_phone            VARCHAR2(30) NOT NULL,
    employee_date_of_hire            DATE NOT NULL,
    employee_date_end_of_contract    DATE NOT NULL
);
