/*2.2. Task 3: Index Unique Scan*/
--Table T1 was created in Task 2
CREATE UNIQUE INDEX udx_t1 ON t1( t_pad );

SELECT t1.*  FROM t1 where t1.t_pad = '1';

Drop table T1;
select segment_name, segment_type from user_segments;
PURGE RECYCLEBIN;
select segment_name, segment_type from user_segments;

