/*Task 1 – Heap Understanding*/
create table t
  ( a int,
    b varchar2(4000) default rpad('*',4000,'*'),
    c varchar2(3000) default rpad('*',3000,'*')
   );

insert into t (a) values (1);
insert into t (a) values (2);
insert into t (a) values (3);
commit;
select * from t;
delete from t where a = 2;
commit;
insert into t (a) values (4);
commit;

select a from t;

DROP TABLE t;

select segment_name, segment_type from user_segments; 
PURGE RECYCLEBIN;
select segment_name, segment_type from user_segments;

/*Option 2: Change size for column c*/
create table t
  ( a int,
    b varchar2(4000) default rpad('*',4000,'*'),
    c varchar2(4000) default rpad('*',4000,'*')
   );

insert into t (a) values (1);
insert into t (a) values (2);
insert into t (a) values (3);
commit;

select * from t;
delete from t where a = 2;
commit;
insert into t (a) values (4);
commit;

select a from t;

DROP TABLE t;

select segment_name, segment_type from user_segments; 
PURGE RECYCLEBIN;
select segment_name, segment_type from user_segments;



