--DROP TABLESPACE ts_sa_fct_budget_01 INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;
--DROP USER dm_budget;

--SELECT * from dba_data_files ;
--ALTER SYSTEM SET db_create_file_dest = '/oracle/u02/oradata/VShkrabatovskayadb';
 
CREATE TABLESPACE ts_sa_fct_budget_01
DATAFILE '/oracle/u02/oradata/VShkrabatovskayadb/db_ts_sa_fct_budget_01.dat'
SIZE 150M
AUTOEXTEND ON NEXT 50M
SEGMENT SPACE MANAGEMENT AUTO; 

CREATE USER dm_budget
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_fct_budget_01;

GRANT CONNECT,RESOURCE, CREATE VIEW TO dm_budget;
