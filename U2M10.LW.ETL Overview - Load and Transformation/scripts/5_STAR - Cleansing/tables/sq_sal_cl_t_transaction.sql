--drop sequence SAL_CL.SQ_sal_cl_t_transaction;
alter session set current_schema = SAL_CL;

CREATE SEQUENCE SAL_CL.SQ_sal_cl_t_transaction
    START WITH        1    
    INCREMENT BY      1
    NOCACHE
    NOCYCLE;