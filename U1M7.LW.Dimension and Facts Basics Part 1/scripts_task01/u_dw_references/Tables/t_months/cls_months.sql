ALTER SESSION SET current_schema=u_dw_ext_references;

CREATE TABLE cls_months (

CALENDAR_MONTH_NUMBER         VARCHAR2(2)  ,
DAYS_IN_CAL_MONTH             VARCHAR2(2)  ,
END_OF_CAL_MONTH              DATE         ,
CALENDAR_MONTH_NAME           VARCHAR2(32)   
)
TABLESPACE TS_REFERENCES_EXT_DATA_01;

EXEC pkg_load_ext_ref_calendar.load_cls_months;
select * from cls_months;
