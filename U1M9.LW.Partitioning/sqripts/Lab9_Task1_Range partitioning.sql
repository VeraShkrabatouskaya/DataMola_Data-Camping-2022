--GRANT UNLIMITED TABLESPACE TO VShkrabatovskaya;
--SELECT * from dba_data_files ;
--select * from USER_tablespaces;
--------------------------------------------------------------------------------
CREATE TABLESPACE ts_dw_data_02
DATAFILE '/oracle/u02/oradata/VShkrabatovskayadb/db_qpt_dw_data_02.dat'
SIZE 200M --REUSE
 AUTOEXTEND ON NEXT 100M
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE USER u_dw_data_02
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_dw_data_02;

GRANT CONNECT,RESOURCE TO u_dw_data_02;

ALTER USER u_dw_data_02 quota unlimited on ts_dw_data_02;
alter session set current_schema=u_dw_data_02;

GRANT UNLIMITED TABLESPACE TO u_dw_data_02;
-------------------------------------------------------------
CREATE TABLESPACE ts_dw_data_03
DATAFILE '/oracle/u02/oradata/VShkrabatovskayadb/db_qpt_dw_data_03.dat'
SIZE 200M --REUSE
 AUTOEXTEND ON NEXT 100M
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE USER u_dw_data_03
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_dw_data_03;

GRANT CONNECT,RESOURCE TO u_dw_data_03;

ALTER USER u_dw_data_03 quota unlimited on ts_dw_data_03;
alter session set current_schema=u_dw_data_03;

GRANT UNLIMITED TABLESPACE TO u_dw_data_03;
-------------------------------------------------------------
--drop table calendar;
alter session set nls_territory = "UNITED KINGDOM";
--Range partitions
CREATE TABLE calendar (
    TIME_ID                       DATE,       
    DAY_NAME                      VARCHAR2(44),
    DAY_NUMBER_IN_WEEK            VARCHAR2(1),
    DAY_NUMBER_IN_MONTH           VARCHAR2(2),
    DAY_NUMBER_IN_YEAR            VARCHAR2(3),
    CALENDAR_WEEK_NUMBER          VARCHAR2(1),
    WEEK_ENDING_DATE              DATE,
    CALENDAR_MONTH_NUMBER         VARCHAR2(2),
    DAYS_IN_CAL_MONTH             VARCHAR2(2),
    END_OF_CAL_MONTH              DATE,
    CALENDAR_MONTH_NAME           VARCHAR2(32),
    DAYS_IN_CAL_QUARTER           NUMBER,
    BEG_OF_CAL_QUARTER            DATE,
    END_OF_CAL_QUARTER            DATE,
    CALENDAR_QUARTER_NUMBER       VARCHAR2(1), 
    CALENDAR_YEAR                 VARCHAR2(4),  
    DAYS_IN_CAL_YEAR              NUMBER,     
    BEG_OF_CAL_YEAR               DATE,      
    END_OF_CAL_YEAR               DATE         
)

PARTITION BY RANGE (TIME_ID)

(
PARTITION PART_1 VALUES LESS THAN (TO_DATE('01/01/2013', 'DD/MM/YYYY')),
PARTITION PART_2 VALUES LESS THAN (TO_DATE('01/01/2015', 'DD/MM/YYYY'))
)

TABLESPACE ts_dw_data_02;

INSERT INTO calendar ( 
        TIME_ID,       
        DAY_NAME,
        DAY_NUMBER_IN_WEEK,
        DAY_NUMBER_IN_MONTH,
        DAY_NUMBER_IN_YEAR,
        CALENDAR_WEEK_NUMBER,
        WEEK_ENDING_DATE,
        CALENDAR_MONTH_NUMBER,
        DAYS_IN_CAL_MONTH,
        END_OF_CAL_MONTH,
        CALENDAR_MONTH_NAME,
        DAYS_IN_CAL_QUARTER,
        BEG_OF_CAL_QUARTER,
        END_OF_CAL_QUARTER,
        CALENDAR_QUARTER_NUMBER, 
        CALENDAR_YEAR,  
        DAYS_IN_CAL_YEAR,     
        BEG_OF_CAL_YEAR,      
        END_OF_CAL_YEAR           
)
         SELECT *  FROM (SELECT 
  TRUNC( sd + rn ) time_id,
  TO_CHAR( sd + rn, 'fmDay' ) day_name,
  TO_CHAR( sd + rn, 'D' ) day_number_in_week,
  TO_CHAR( sd + rn, 'DD' ) day_number_in_month,
  TO_CHAR( sd + rn, 'DDD' ) day_number_in_year,
  TO_CHAR( sd + rn, 'W' ) calendar_week_number,
  ( CASE
      WHEN TO_CHAR( sd + rn, 'D' ) IN ( 1, 2, 3, 4, 5, 6 ) THEN
        NEXT_DAY( sd + rn, 'SUNDAY' )
      ELSE
        ( sd + rn )
    END ) week_ending_date,
  TO_CHAR( sd + rn, 'MM' ) calendar_month_number,
  TO_CHAR( LAST_DAY( sd + rn ), 'DD' ) days_in_cal_month,
  LAST_DAY( sd + rn ) end_of_cal_month,
  TO_CHAR( sd + rn, 'FMMonth' ) calendar_month_name,
  ( ( CASE
      WHEN TO_CHAR( sd + rn, 'Q' ) = 1 THEN
        TO_DATE( '03/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
      WHEN TO_CHAR( sd + rn, 'Q' ) = 2 THEN
        TO_DATE( '06/30/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
      WHEN TO_CHAR( sd + rn, 'Q' ) = 3 THEN
        TO_DATE( '09/30/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
      WHEN TO_CHAR( sd + rn, 'Q' ) = 4 THEN
        TO_DATE( '12/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
    END ) - TRUNC( sd + rn, 'Q' ) + 1 ) days_in_cal_quarter,
  TRUNC( sd + rn, 'Q' ) beg_of_cal_quarter,
  ( CASE
      WHEN TO_CHAR( sd + rn, 'Q' ) = 1 THEN
        TO_DATE( '03/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
      WHEN TO_CHAR( sd + rn, 'Q' ) = 2 THEN
        TO_DATE( '06/30/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
      WHEN TO_CHAR( sd + rn, 'Q' ) = 3 THEN
        TO_DATE( '09/30/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
      WHEN TO_CHAR( sd + rn, 'Q' ) = 4 THEN
        TO_DATE( '12/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
    END ) end_of_cal_quarter,
  TO_CHAR( sd + rn, 'Q' ) calendar_quarter_number,
  TO_CHAR( sd + rn, 'YYYY' ) calendar_year,
  ( TO_DATE( '12/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
    - TRUNC( sd + rn, 'YEAR' ) ) days_in_cal_year,
  TRUNC( sd + rn, 'YEAR' ) beg_of_cal_year,
  TO_DATE( '12/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' ) end_of_cal_year
FROM
  ( 
    SELECT 
      TO_DATE( '12/31/2011', 'MM/DD/YYYY' ) sd,
      rownum rn
    FROM dual
      CONNECT BY level <=1000
  ));



SELECT * FROM calendar PARTITION (PART_1);
SELECT * FROM calendar PARTITION (PART_2);

--Merge partitions

ALTER TABLE calendar 
MERGE PARTITIONS PART_1, PART_2 INTO PARTITION PART_3; 

SELECT * FROM calendar PARTITION (PART_3);

--Move partition

ALTER TABLE calendar MOVE PARTITION PART_3 TABLESPACE ts_dw_data_03 NOLOGGING COMPRESS; 

SELECT partition_name, tablespace_name FROM ALL_TAB_PARTITIONS;

--Split partition
ALTER TABLE calendar SPLIT PARTITION PART_3
AT (TO_DATE('01/01/2014', 'DD/MM/YYYY'))
INTO
( PARTITION PART_1, PARTITION PART_2);

SELECT * FROM calendar PARTITION (PART_1);
SELECT * FROM calendar PARTITION (PART_2);

--Truncate partition
ALTER TABLE calendar TRUNCATE PARTITION PART_2;


SELECT * FROM calendar PARTITION (PART_2);
--Drop partition
ALTER TABLE calendar DROP PARTITION PART_2;

SELECT partition_name, tablespace_name FROM ALL_TAB_PARTITIONS;

--Add partition
ALTER TABLE calendar
    ADD PARTITION PART_2 VALUES LESS THAN (TO_DATE('01/01/2015', 'DD/MM/YYYY'))
    TABLESPACE ts_dw_data_02;

SELECT partition_name, tablespace_name FROM ALL_TAB_PARTITIONS;

SELECT * FROM calendar PARTITION (PART_1);
SELECT * FROM calendar PARTITION (PART_2);

--
--drop table calendar;
--drop TABLESPACE ts_dw_data_02 INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;
--drop TABLESPACE ts_dw_data_03 INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;

--select segment_name, segment_type from user_segments;
--PURGE RECYCLEBIN;
--select segment_name, segment_type from user_segments;