--drop table DW_DATA.DIM_agency CASCADE CONSTRAINTS;
--alter session set current_schema = DW_DATA;

CREATE TABLE DW_DATA.DIM_agency(
    agency_ID NUMBER(10),     
    agency_name         VARCHAR2(50),
    department_name     VARCHAR2(50),
    agency_city         VARCHAR2(30),
    agency_country      VARCHAR2(30),
    agency_address      VARCHAR2(50),
    agency_postcode     VARCHAR2(6),
    agency_email        VARCHAR2(30),
    agency_office_phone VARCHAR2(30),
    agency_mobile_phone VARCHAR2(30),
    agency_Fee_percent  DECIMAL(10,2),    
    agency_VAT_percent  DECIMAL(10,2),   

    CONSTRAINT "PK_T.DIM_agency" PRIMARY KEY(agency_ID) 
);

select * from DW_DATA.DIM_agency;

select * from DW_DATA.DIM_agency where agency_id=12;
select count(*) from DW_DATA.DIM_agency;