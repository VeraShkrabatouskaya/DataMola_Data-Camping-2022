--drop sequence DW_DATA.SQ_DIM_promotion;
--alter session set current_schema = DW_DATA;

CREATE SEQUENCE DW_DATA.SQ_DIM_promotion
    START WITH        1    
    INCREMENT BY      1
    NOCACHE
    NOCYCLE;