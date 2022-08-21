--DROP TABLESPACE ts_sal_cl INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;
--DROP USER sal_cl;

--SELECT * from dba_data_files ;
--ALTER SYSTEM SET db_create_file_dest = '/oracle/u02/oradata/VShkrabatovskayadb';
 
CREATE TABLESPACE ts_sal_cl
DATAFILE '/oracle/u02/oradata/VShkrabatovskayadb/db_ts_sal_cl.dat'
SIZE 150M
AUTOEXTEND ON NEXT 50M
SEGMENT SPACE MANAGEMENT AUTO; 

CREATE USER sal_cl
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sal_cl;

GRANT CONNECT,RESOURCE, CREATE VIEW TO sal_cl;
