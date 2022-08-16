alter session set current_schema = DW_DATA;
drop table FCT_business CASCADE CONSTRAINTS;

CREATE TABLE FCT_business(
    Business_Fact_ID NUMBER(10),   
    TIME_ID                                DATE,
    customer_ID                            NUMBER(10),
    employee_ID                            NUMBER(10),
    agency_ID                              NUMBER(10),
    gen_period_ID                          NUMBER(10),
    product_ID                             NUMBER(10),
    promotion_ID                           NUMBER(10),
    gross_profit_dollar_amount             DECIMAL (30,2),
    net_profit_dollar_amount               DECIMAL (30,2),
    gross_revenue_dollar_amount            DECIMAL (30,2),
    net_revenue_dollar_amount              DECIMAL (30,2),
    gross_cost_dollar_amount               DECIMAL (30,2),
    net_cost_dollar_amount                 DECIMAL (30,2),
    gross_salary_employee_dollar_amount    DECIMAL (30,2),
    net_salary_employee_dollar_amount      DECIMAL (30,2),
    gross_profit_margin_percent            DECIMAL (10,2),
    CONSTRAINT "PK_T.FCT_business" PRIMARY KEY(Business_Fact_ID)
)

PARTITION BY RANGE (TIME_ID)
    subpartition by hash(agency_ID) subpartitions 4
(
    PARTITION QUARTER_1 VALUES LESS THAN(TO_DATE('01/04/2022', 'DD/MM/YYYY'))
    ( subpartition QUARTER_1_sub_1,
      subpartition QUARTER_1_sub_2,
      subpartition QUARTER_1_sub_3,
      subpartition QUARTER_1_sub_4
    ),
    PARTITION QUARTER_2 VALUES LESS THAN(TO_DATE('01/07/2022', 'DD/MM/YYYY'))
    ( subpartition QUARTER_2_sub_1,
      subpartition QUARTER_2_sub_2,
      subpartition QUARTER_2_sub_3,
      subpartition QUARTER_2_sub_4
     ),
     PARTITION QUARTER_3 VALUES LESS THAN(TO_DATE('01/10/2022', 'DD/MM/YYYY'))
    ( subpartition QUARTER_3_sub_1,
      subpartition QUARTER_3_sub_2,
      subpartition QUARTER_3_sub_3,
      subpartition QUARTER_3_sub_4
    ),
     PARTITION QUARTER_4 VALUES LESS THAN(TO_DATE('01/01/2023', 'DD/MM/YYYY'))
    ( subpartition QUARTER_4_sub_1,
      subpartition QUARTER_4_sub_2,
      subpartition QUARTER_4_sub_3,
      subpartition QUARTER_4_sub_4
    )
);
   
ALTER TABLE FCT_business
   ADD CONSTRAINT "FK_FCT_business_DIM_customer" FOREIGN KEY (customer_ID )REFERENCES dim_customer (customer_ID);
   
ALTER TABLE FCT_business
   ADD CONSTRAINT "FK_FCT_business_DIM_employee" FOREIGN KEY (employee_ID )REFERENCES dim_employee (employee_ID);
   
ALTER TABLE FCT_business
   ADD CONSTRAINT "FK_FCT_business_DIM_agency" FOREIGN KEY (agency_ID )REFERENCES dim_agency (agency_ID);
   
ALTER TABLE FCT_business
   ADD CONSTRAINT "FK_FCT_business_DIM_gen_period" FOREIGN KEY (gen_period_ID )REFERENCES dim_gen_period (gen_period_ID);
   
ALTER TABLE FCT_business
   ADD CONSTRAINT "FK_FCT_business_DIM_product" FOREIGN KEY (product_ID )REFERENCES dim_product (product_ID);
   
ALTER TABLE FCT_business
   ADD CONSTRAINT "FK_FCT_business_DIM_promotion" FOREIGN KEY (promotion_ID)REFERENCES dim_promotion (promotion_ID);
   

select * from FCT_business order by 1;

select * from FCT_business where promotion_id=219504;
select count(*) from FCT_business;
   
