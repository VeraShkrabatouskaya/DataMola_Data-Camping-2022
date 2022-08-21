--drop table DW_DATA.DIM_customer;
--alter session set current_schema = DW_DATA;

CREATE TABLE DW_DATA.DIM_customer(
    customer_ID NUMBER(10),     
    customer_name            VARCHAR2(50),
    brand_name               VARCHAR2(50),
    customer_address         VARCHAR2(50),
    customer_city            VARCHAR2(30),
    customer_country         VARCHAR2(30),
    customer_email           VARCHAR2(50),
    customer_office_phone    VARCHAR2(30),
    customer_mobile_phone    VARCHAR2(30),

    CONSTRAINT "PK_T.DIM_customer" PRIMARY KEY(customer_ID) 
);

    select * from DW_DATA.DIM_customer;
    
     select * from DW_DATA.DIM_customer where customer_id=1;