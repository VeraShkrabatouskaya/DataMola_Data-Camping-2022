--DROP TABLESPACE ts_dw_data_01 INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;
--DROP USER dw_data;

--SELECT * from dba_data_files ;
--ALTER SYSTEM SET db_create_file_dest = '/oracle/u02/oradata/VShkrabatovskayadb';

CREATE TABLESPACE ts_dw_data_01
DATAFILE '/oracle/u02/oradata/VShkrabatovskayadb/db_ts_dw_data_01.dat'
SIZE 200M
AUTOEXTEND ON NEXT 100M
SEGMENT SPACE MANAGEMENT AUTO; 

CREATE USER dw_data
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_dw_data_01;

GRANT CONNECT,RESOURCE TO dw_data;
