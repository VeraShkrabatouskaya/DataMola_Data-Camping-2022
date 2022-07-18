/*Task 2 – Understanding Low level of data abstraction: Heap Table Segments*/
Create table t ( x int primary key, y clob, z blob );

select segment_name, segment_type from user_segments;

DROP TABLE t; 

select segment_name, segment_type from user_segments;
PURGE RECYCLEBIN;
select segment_name, segment_type from user_segments;

Create table t
               ( x int primary key,
                 y clob,
                 z blob )
    SEGMENT CREATION IMMEDIATE;
Commit;

select segment_name, segment_type from user_segments;

SELECT DBMS_METADATA.GET_DDL('TABLE','T') FROM dual;

DROP TABLE t;

select segment_name, segment_type from user_segments;
PURGE RECYCLEBIN;
select segment_name, segment_type from user_segments;
