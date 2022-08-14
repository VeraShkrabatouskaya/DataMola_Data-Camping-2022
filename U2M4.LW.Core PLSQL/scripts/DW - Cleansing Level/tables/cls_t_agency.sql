--alter session set current_schema=DW_CL;
--drop table cls_t_agency;

alter session set current_schema=DW_CL;

Create table cls_t_agency (
    agency_name            VARCHAR2(50) NOT NULL,
    department_name        VARCHAR2(50) NOT NULL,
    agency_address         VARCHAR2(50) NOT NULL,
    agency_city            VARCHAR2(30) NOT NULL,
    agency_country         VARCHAR2(30) NOT NULL,
    agency_postcode        VARCHAR2(6) NOT NULL,
    agency_email           VARCHAR2(30) NOT NULL,
    agency_office_phone    VARCHAR2(30) NOT NULL,
    agency_mobile_phone    VARCHAR2(30) NOT NULL,
    agency_Fee_percent     DECIMAL (10,2),
    agency_VAT_percent     DECIMAL (10,2)
);

select * from cls_t_agency;
select count(*) from cls_t_agency;