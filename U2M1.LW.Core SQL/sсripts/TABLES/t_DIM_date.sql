--drop table DIM_date;
--alter session set current_schema = DW_DATA;

CREATE TABLE DIM_date(
    TIME_ID                        DATE,
    DAY_NUMBER_IN_YEAR             VARCHAR2(3),
    CALENDAR_WEEK_NUMBER           VARCHAR2(1),
    CALENDAR_MONTH_NUMBER          VARCHAR2(2),
    CALENDAR_QUARTER_NUMBER        VARCHAR2(1),
    CALENDAR_YEAR                  VARCHAR2(4),
    DAY_NAME                       VARCHAR2(44),
    CALENDAR_MONTH_NAME            VARCHAR2(32),
  
    CONSTRAINT "PK_T.DIM_date" PRIMARY KEY(TIME_ID) 
);