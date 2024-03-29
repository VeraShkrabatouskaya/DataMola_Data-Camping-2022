--DROP TABLESPACE ts_dw_cl INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;
--DROP USER dw_cl;

--SELECT * from dba_data_files ;
--ALTER SYSTEM SET db_create_file_dest = '/oracle/u02/oradata/VShkrabatovskayadb';
 
CREATE TABLESPACE ts_dw_cl
DATAFILE '/oracle/u02/oradata/VShkrabatovskayadb/db_ts_dw_cl.dat'
SIZE 200M
AUTOEXTEND ON NEXT 100M
SEGMENT SPACE MANAGEMENT AUTO; 

CREATE USER dw_cl
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_dw_cl;

GRANT CONNECT,RESOURCE, CREATE VIEW TO dw_cl;
