/*Task 3: Compare performance of using IOT tables*/
CREATE TABLE emp AS
SELECT
  object_id empno, 
  object_name ename, 
  created hiredate, 
  owner job
FROM
  all_objects; 
COMMIT;

ALTER TABLE emp add constraint emp_pk primary key (empno);

SELECT * FROM emp;

/*Calculate Statistic*/
begin
  dbms_stats.gather_table_stats( user, 'EMP', cascade=>true );
end;
COMMIT;

CREATE TABLE heap_addresses
  (
    empno REFERENCES emp(empno) ON DELETE CASCADE, 
    addr_type VARCHAR2(10),
    street    VARCHAR2(20),
    city      VARCHAR2(20),
    state     VARCHAR2(2),
    zip       NUMBER,
    PRIMARY KEY (empno,addr_type)
  );
COMMIT;

CREATE TABLE iot_addresses
  (
    empno REFERENCES emp(empno) ON DELETE CASCADE, 
    addr_type VARCHAR2(10),
    street    VARCHAR2(20),
    city      VARCHAR2(20),
    state     VARCHAR2(2),
    zip       NUMBER,
    PRIMARY KEY (empno,addr_type)
  )
ORGANIZATION INDEX;

COMMIT;

INSERT INTO heap_addresses
SELECT empno, 'WORK' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
INSERT INTO iot_addresses
SELECT empno , 'WORK' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
INSERT INTO heap_addresses
SELECT empno, 'HOME' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
INSERT INTO iot_addresses
SELECT empno, 'HOME' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
INSERT INTO heap_addresses
SELECT empno, 'PREV' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
INSERT INTO iot_addresses
SELECT empno, 'PREV' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
INSERT INTO heap_addresses
SELECT empno, 'SCHOOL' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
INSERT INTO iot_addresses
SELECT empno, 'SCHOOL' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
Commit;

EXEC dbms_stats.gather_table_stats( user, 'HEAP_ADDRESSES');
/*Begin dbms_stats.gather_table_stats( user, 'HEAP_ADDRESSES');  END;*/
EXEC dbms_stats.gather_table_stats( user, 'IOT_ADDRESSES');
/*Begin dbms_stats.gather_table_stats( user, 'IOT_ADDRESSES');  END;*/

/*Option1*/
SELECT *
   FROM emp ,
        heap_addresses
  WHERE emp.empno = heap_addresses.empno
  AND emp.empno   = 42;
 
 SELECT *
   FROM emp ,
        iot_addresses
  WHERE emp.empno = iot_addresses.empno
  AND emp.empno   = 42; 
/*Option2*/
explain plan for
select *
from emp, heap_addresses
where emp.empno = heap_addresses.empno
and emp.empno = 42;

select * from table(dbms_xplan.display );
 
 
 explain plan FOR
 SELECT *
   FROM emp ,
        iot_addresses
  WHERE emp.empno = iot_addresses.empno
  AND emp.empno   = 42; 

 select * from table(dbms_xplan.display );

DROP TABLE iot_addresses;
DROP TABLE heap_addresses;
DROP TABLE emp;
select segment_name, segment_type from user_segments; 
PURGE RECYCLEBIN;
select segment_name, segment_type from user_segments;


 










 


