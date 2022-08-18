alter session set current_schema=DW_CL;
--drop table cls_t_transaction CASCADE CONSTRAINTS;

alter session set current_schema=DW_CL;
GRANT SELECT ON DW_CL.cls_t_transaction TO DW_DATA;

Create table cls_t_transaction (
    time_ID                          DATE,
    customer_name                    VARCHAR2(50) NOT NULL,
    brand_name                       VARCHAR2(50) NOT NULL,
    customer_address                 VARCHAR2(50) NOT NULL,
    customer_city                    VARCHAR2(30) NOT NULL,
    customer_country                 VARCHAR2(30) NOT NULL,
    customer_email                   VARCHAR2(50) NOT NULL,
    customer_office_phone            VARCHAR2(30) NOT NULL,
    customer_mobile_phone            VARCHAR2(30) NOT NULL,
    product_name                     VARCHAR2(50) NOT NULL,
    agency_name                      VARCHAR2(50) NOT NULL,
    agency_city                      VARCHAR2(30) NOT NULL,
    agency_country                   VARCHAR2(30) NOT NULL,
    agency_address                   VARCHAR2(50) NOT NULL,
    agency_postcode                  VARCHAR2(6) NOT NULL,
    agency_email                     VARCHAR2(30) NOT NULL,
    agency_office_phone              VARCHAR2(30) NOT NULL,
    agency_mobile_phone              VARCHAR2(30) NOT NULL,
    agency_Fee_percent               DECIMAL (10,2),
    agency_VAT_percent               DECIMAL (10,2),
    promotion_media_type             VARCHAR2(30) NOT NULL,  
    category_name                    VARCHAR2(50) NOT NULL,
    subcategory_name                 VARCHAR2(50) NOT NULL,
    department_name                  VARCHAR2(50) NOT NULL,
    employee_first_name              VARCHAR2(40) NOT NULL,
    employee_last_name               VARCHAR2(50) NOT NULL,
    employee_position                VARCHAR2(50) NOT NULL,
    employee_salary_project          DECIMAL (30,2) NOT NULL,
    employee_passport_ID             VARCHAR2(14) NOT NULL,
    employee_email                   VARCHAR2(50) NOT NULL,
    employee_office_phone            VARCHAR2(30) NOT NULL,
    employee_mobile_phone            VARCHAR2(30) NOT NULL,
    employee_date_of_hire            DATE NOT NULL,
    employee_date_end_of_contract    DATE NOT NULL,
    current_flg                      VARCHAR2(1) NOT NULL,
    promotion_metric_amount          DECIMAL (10,2) NOT NULL,
    promotion_price                  DECIMAL (10,2) NOT NULL,
    promotion_KPI                    VARCHAR2(30) NOT NULL,
    promotion_distinct_percent       DECIMAL (10,2) NOT NULL,
    promotion_name                   VARCHAR2(50) NOT NULL,
    promotion_start                  Date,
    promotion_end                    Date,
    gross_revenue_dollar_amount      DECIMAL (10,2) NOT NULL,
    net_revenue_dollar_amount        DECIMAL (10,2) NOT NULL,
    gross_cost_dollar_amount         DECIMAL (10,2) NOT NULL,
    net_cost_dollar_amount           DECIMAL (10,2) NOT NULL,
    gross_profit_dollar_amount       DECIMAL (10,2) NOT NULL,
    net_profit_dollar_amount         DECIMAL (10,2) NOT NULL,
    net_salary_employee_dollar_amount DECIMAL (10,2) NOT NULL,
    gross_salary_employee_dollar_amount DECIMAL (10,2) NOT NULL,
    gross_profit_margin_percent         DECIMAL (10,2) NOT NULL
);

select * from DW_CL.cls_t_transaction;
select * from DW_CL.cls_t_transaction where promotion_name = '68251 SAMSUNG_Headphones_production';