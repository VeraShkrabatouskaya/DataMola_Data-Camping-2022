--alter session set current_schema=DW_CL;
--drop table cls_t_promotion;

alter session set current_schema=DW_CL;

Create table cls_t_promotion (
    TIME_ID                    DATE NOT NULL,
    promotion_name             VARCHAR2(50) NOT NULL,
    promotion_media_type       VARCHAR2(30) NOT NULL,  
    promotion_metric_amount    DECIMAL (10,2) NOT NULL,
    department_name            VARCHAR2(50) NOT NULL,
    promotion_price            DECIMAL (10,2) NOT NULL,
    promotion_KPI              VARCHAR2(30) NOT NULL,
    promotion_distinct_percent DECIMAL (10,2) NOT NULL,
    employee_salary_project    DECIMAL (30,2) NOT NULL
);

select * from cls_t_promotion
order by 1;
select count(*) from cls_t_promotion;