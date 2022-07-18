/*2.3. Task 4: Index Range Scan*/
--Table T2 was created in Task 2
SELECT t2.*  FROM t2 where t2.id = '1';

Drop table T2;
select segment_name, segment_type from user_segments;
PURGE RECYCLEBIN;
select segment_name, segment_type from user_segments;


