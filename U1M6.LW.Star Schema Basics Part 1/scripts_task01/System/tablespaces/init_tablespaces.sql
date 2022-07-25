--==============================================================
-- DBMS name:      ORACLE Version 11g
-- Created on:     01.03.2012 15:17:06
--==============================================================
--DROP TABLESPACE ts_dw_data_01 INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;
--
--DROP TABLESPACE ts_dw_idx_01 INCLUDING CONTENTS CASCADE CONSTRAINTS;
--
--DROP TABLESPACE ts_persons_data_01 INCLUDING CONTENTS CASCADE CONSTRAINTS;
--
--DROP TABLESPACE ts_persons_idx_01 INCLUDING CONTENTS CASCADE CONSTRAINTS;
--
--DROP TABLESPACE ts_references_data_01 INCLUDING CONTENTS CASCADE CONSTRAINTS;
--
--DROP TABLESPACE ts_references_ext_data_01 INCLUDING CONTENTS CASCADE CONSTRAINTS;
--
--DROP TABLESPACE ts_references_idx_01 INCLUDING CONTENTS CASCADE CONSTRAINTS;

--Change parameter:Default DataBase data files location
SELECT * from dba_data_files ;
ALTER SYSTEM SET db_create_file_dest = '/oracle/u02/oradata/VShkrabatovskayadb';

CREATE TABLESPACE ts_dw_data_01
DATAFILE '/oracle/u02/oradata/VShkrabatovskayadb/db_qpt_dw_data_01.dat'
SIZE 200M
 AUTOEXTEND ON NEXT 100M
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE ts_dw_idx_01
DATAFILE '/oracle/u02/oradata/VShkrabatovskayadb/db_qpt_dw_idx_01.dat'
SIZE 150M
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE ts_persons_data_01
DATAFILE '/oracle/u02/oradata/VShkrabatovskayadb/db_qpt_person_data_01.dat'
SIZE 150M
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE ts_persons_idx_01
DATAFILE '/oracle/u02/oradata/VShkrabatovskayadb/db_qpt_person_idx_01.dat'
SIZE 50M
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE ts_references_data_01
DATAFILE '/oracle/u02/oradata/VShkrabatovskayadb/db_qpt_references_data_01.dat'
SIZE 150M
 AUTOEXTEND ON NEXT 50
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE ts_references_ext_data_01
DATAFILE '/oracle/u02/oradata/VShkrabatovskayadb/db_qpt_ext_references_data_01.dat'
SIZE 20M
 AUTOEXTEND ON
    NEXT 20M
    MAXSIZE 60M
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE ts_references_idx_01
DATAFILE '/oracle/u02/oradata/VShkrabatovskayadb/db_qpt_references_idx_01.dat'
SIZE 50M
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;
