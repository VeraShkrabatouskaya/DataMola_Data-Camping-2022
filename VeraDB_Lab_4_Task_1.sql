/*1.1. Task 1: Full Scans and the High-water Mark and Block reading*/
CREATE TABLE t2 AS
 SELECT TRUNC( rownum / 100 ) id, rpad( rownum,100 ) t_pad
   FROM dual
  CONNECT BY rownum < 100000;

CREATE INDEX t2_idx1 ON t2
  ( id );

select blocks from user_segments where segment_name = 'T2';

select count(distinct (dbms_rowid.rowid_block_number(rowid))) block_ct from t2 ;

set autotrace ON;
SELECT COUNT( * )
   FROM t2 ;
SET autotrace OFF;

DELETE FROM t2;

--Repeat 

select blocks from user_segments where segment_name = 'T2';

select count(distinct (dbms_rowid.rowid_block_number(rowid))) block_ct from t2 ;

SET autotrace ON;
SELECT COUNT( * )
   FROM t2 ;
SET autotrace OFF;

--Repeat 
 
INSERT INTO t2
  ( ID, T_PAD )
  VALUES
  (  1,'1' );

COMMIT;

select blocks from user_segments where segment_name = 'T2';

select count(distinct (dbms_rowid.rowid_block_number(rowid))) block_ct from t2 ;

SET autotrace ON;
SELECT COUNT( * )
   FROM t2 ;
SET autotrace OFF;

--Repeat

TRUNCATE TABLE t2;

select blocks from user_segments where segment_name = 'T2';

select count(distinct (dbms_rowid.rowid_block_number(rowid))) block_ct from t2 ;

SET autotrace ON;
SELECT COUNT( * )
   FROM t2 ; 
SET autotrace OFF;

Drop table T2;
select segment_name, segment_type from user_segments;
PURGE RECYCLEBIN;
select segment_name, segment_type from user_segments;



