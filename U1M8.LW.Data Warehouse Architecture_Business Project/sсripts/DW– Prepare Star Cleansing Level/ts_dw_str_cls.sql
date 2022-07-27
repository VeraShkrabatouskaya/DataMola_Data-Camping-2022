--DROP TABLESPACE ts_dw_str_cls INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;
--DROP USER sal_dw_cl;

--SELECT * from dba_data_files ;
--ALTER SYSTEM SET db_create_file_dest = '/oracle/u02/oradata/VShkrabatovskayadb';
 
CREATE TABLESPACE ts_dw_str_cls
DATAFILE '/oracle/u02/oradata/VShkrabatovskayadb/db_ts_dw_str_cls.dat'
SIZE 150M
AUTOEXTEND ON NEXT 50M
SEGMENT SPACE MANAGEMENT AUTO; 

CREATE USER sal_dw_cl
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_dw_str_cls;

GRANT CONNECT,RESOURCE, CREATE VIEW TO sal_dw_cl;
