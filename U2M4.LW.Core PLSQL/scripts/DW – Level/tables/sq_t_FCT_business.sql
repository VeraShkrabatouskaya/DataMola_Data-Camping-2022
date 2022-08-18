--drop sequence DW_DATA.SQ_FCT_business;
alter session set current_schema = DW_DATA;

CREATE SEQUENCE DW_DATA.SQ_FCT_business
    START WITH        1    
    INCREMENT BY      1
    NOCACHE
    NOCYCLE;