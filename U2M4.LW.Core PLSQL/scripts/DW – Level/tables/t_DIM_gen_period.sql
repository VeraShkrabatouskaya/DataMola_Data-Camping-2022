--drop table DW_DATA.DIM_gen_period;
--alter session set current_schema = DW_DATA;

CREATE TABLE DW_DATA.DIM_gen_period(
    gen_period_ID NUMBER(10),     
    promotion_name        VARCHAR2(50),
    promotion_start       Date,
    promotion_end         Date,

    CONSTRAINT "PK_T.DIM_gen_period" PRIMARY KEY(gen_period_ID) 
);

select * from DW_DATA.DIM_gen_period;

select count(*) from DW_DATA.DIM_gen_period;

select * from DW_DATA.DIM_gen_period where gen_period_id = 138501;