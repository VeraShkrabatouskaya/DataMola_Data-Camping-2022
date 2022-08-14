--alter session set current_schema=DW_CL;
--drop table cls_t_customer;

alter session set current_schema=DW_CL;

Create table cls_t_customer (
    customer_name            VARCHAR2(50) NOT NULL,
    brand_name               VARCHAR2(50) NOT NULL,
    customer_address         VARCHAR2(50) NOT NULL,
    customer_city            VARCHAR2(30) NOT NULL,
    customer_country         VARCHAR2(30) NOT NULL,
    customer_email           VARCHAR2(50) NOT NULL,
    customer_office_phone    VARCHAR2(30) NOT NULL,
    customer_mobile_phone    VARCHAR2(30) NOT NULL
);