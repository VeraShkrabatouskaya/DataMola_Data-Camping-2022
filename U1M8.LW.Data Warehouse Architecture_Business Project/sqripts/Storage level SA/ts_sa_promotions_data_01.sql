--DROP TABLESPACE ts_sa_promotions_data_01 INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;
--DROP USER sa_promotions;

--SELECT * from dba_data_files ;
--ALTER SYSTEM SET db_create_file_dest = '/oracle/u02/oradata/VShkrabatovskayadb';
 
CREATE TABLESPACE ts_sa_promotions_data_01
DATAFILE '/oracle/u02/oradata/VShkrabatovskayadb/db_ts_sa_promotions_data_01.dat'
SIZE 200M
AUTOEXTEND ON NEXT 50M
SEGMENT SPACE MANAGEMENT AUTO; 

CREATE USER sa_promotions
  IDENTIFIED BY "%PWD%"
    DEFAULT TABLESPACE ts_sa_promotions_data_01;

GRANT CONNECT,RESOURCE TO sa_promotions;
