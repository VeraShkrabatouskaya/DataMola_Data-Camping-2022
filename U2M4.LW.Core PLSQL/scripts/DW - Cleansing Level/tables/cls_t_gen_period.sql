--alter session set current_schema=DW_CL;
--drop table cls_t_DIM_gen_period;

alter session set current_schema=DW_CL;

Create table cls_t_DIM_gen_period (
    promotion_name             VARCHAR2(50) NOT NULL,
    promotion_start            Date,
    promotion_end              Date
);
