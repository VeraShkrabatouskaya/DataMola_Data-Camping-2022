--DROP TABLE cls_weeks

ALTER SESSION SET current_schema=u_dw_ext_references;
ALTER USER u_dw_references quota unlimited on TS_REFERENCES_DATA_01; 

CREATE TABLE cls_weeks (

CALENDAR_WEEK_NUMBER          VARCHAR2(1)  ,
WEEK_ENDING_DATE              DATE        
) 
TABLESPACE TS_REFERENCES_EXT_DATA_01;


   
EXEC pkg_load_ext_ref_calendar.load_cls_weeks;
select * from cls_weeks;

   
   
   
