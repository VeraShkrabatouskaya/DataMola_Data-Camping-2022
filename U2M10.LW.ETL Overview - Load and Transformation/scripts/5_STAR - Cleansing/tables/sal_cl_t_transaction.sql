alter session set current_schema=SAL_CL;
--drop table sal_cl_t_transaction CASCADE CONSTRAINTS;

alter session set current_schema=sal_dw_cl;
GRANT SELECT ON sal_dw_cl.sal_dw_cl_t_transaction TO SAL_CL;

alter session set current_schema=SAL_CL;

Create table sal_cl_t_transaction (
    transaction_ID                   NUMBER(10),  
--------------------------------------------------------------------------------
    time_ID                          DATE,
--------------------------------------------------------------------------------
    customer_name                    VARCHAR2(50) NOT NULL,
    brand_name                       VARCHAR2(50) NOT NULL,
--------------------------------------------------------------------------------
    agency_name                      VARCHAR2(50) NOT NULL,
    department_name                  VARCHAR2(50) NOT NULL,
    agency_city                      VARCHAR2(30) NOT NULL,
    agency_country                   VARCHAR2(30) NOT NULL,
    agency_Fee_percent               DECIMAL (10,2),
    agency_VAT_percent               DECIMAL (10,2),
--------------------------------------------------------------------------------
    employee_passport_ID             VARCHAR2(14) NOT NULL,
    employee_first_name              VARCHAR2(40) NOT NULL,
    employee_last_name               VARCHAR2(50) NOT NULL,
    employee_position                VARCHAR2(50) NOT NULL, 
    employee_email                   VARCHAR2(50) NOT NULL,
    employee_date_of_hire            DATE NOT NULL,
    employee_date_end_of_contract    DATE NOT NULL,
    current_flg                      VARCHAR2(1) NOT NULL,
--------------------------------------------------------------------------------
    promotion_name                   VARCHAR2(50) NOT NULL,
    promotion_media_type             VARCHAR2(30) NOT NULL,  
    promotion_metric_amount          DECIMAL (10,2) NOT NULL,
    promotion_price                  DECIMAL (10,2) NOT NULL,
    promotion_KPI                    VARCHAR2(30) NOT NULL,
    promotion_distinct_percent       DECIMAL (10,2) NOT NULL,
    employee_salary_project          DECIMAL (30,2) NOT NULL,
--------------------------------------------------------------------------------
    gross_profit_dollar_amount       DECIMAL (10,2) NOT NULL,
    net_profit_dollar_amount         DECIMAL (10,2) NOT NULL,
    gross_revenue_dollar_amount      DECIMAL (10,2) NOT NULL,
    net_revenue_dollar_amount        DECIMAL (10,2) NOT NULL,
    gross_cost_dollar_amount         DECIMAL (10,2) NOT NULL,
    net_cost_dollar_amount           DECIMAL (10,2) NOT NULL,
    gross_salary_employee_dollar_amount DECIMAL (10,2) NOT NULL,
    net_salary_employee_dollar_amount DECIMAL (10,2) NOT NULL,
    gross_profit_margin_percent         DECIMAL (10,2) NOT NULL,
    CONSTRAINT "PK_T.sal_cl_t_transaction" PRIMARY KEY(transaction_ID)
);

alter session set current_schema=SAL_CL;
select * from sal_cl.sal_cl_t_transaction order by 1;
