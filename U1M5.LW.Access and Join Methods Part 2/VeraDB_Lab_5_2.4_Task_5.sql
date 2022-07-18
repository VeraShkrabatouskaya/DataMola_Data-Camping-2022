/*2.4. Task 5: Cartesian Joins*/

SELECT  empno, ename, dname, loc
     FROM scott.emp e, scott.dept d
    WHERE e.deptno = d.deptno
     AND d.deptno   = 10

SELECT /*+ ordered */ empno, ename, dname, loc
     FROM scott.emp e, scott.dept d
    WHERE e.deptno = d.deptno
      AND d.deptno   = 10



