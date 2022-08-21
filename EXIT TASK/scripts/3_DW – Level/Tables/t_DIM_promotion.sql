drop table DW_DATA.DIM_promotion CASCADE CONSTRAINTS;
alter session set current_schema = DW_DATA;

CREATE TABLE DW_DATA.DIM_promotion(
    promotion_ID NUMBER(10), 
    TIME_ID                    DATE,
    promotion_name             VARCHAR2(50),
    promotion_media_type       VARCHAR2(30),  
    promotion_metric_amount    DECIMAL (10,2),
    department_name            VARCHAR2(50),
    promotion_price            DECIMAL (10,2),
    promotion_KPI              VARCHAR2(30),
    promotion_distinct_percent DECIMAL (10,2),
    employee_salary_project   DECIMAL (30,2),

    CONSTRAINT "PK_T.DIM_promotion" PRIMARY KEY(promotion_ID) 
);

select* from DW_DATA.DIM_promotion;
select * from DW_DATA.DIM_promotion where promotion_name ='68251 SAMSUNG_Headphones_production';
select count(*) from DW_DATA.DIM_promotion;