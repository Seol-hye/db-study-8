
--학과정보
select * from department;
select * from student;
select * from professor;


select s.name, s.deptno1, d.dname
from student s, department d
where s.deptno1 = d.deptno;


select *
from student s, professor p, department d
where s.profno = p.profno
AND s.deptno1 = d.deptno;

select s.name, p.name, d.dname
from
student s INNER JOIN professor p
ON s.profno = p.profno
INNER JOIN department d
ON s.deptno1 = d.deptno;



select *
from student s, professor p, department d
where s.profno = p.profno
AND s.deptno1 = d.deptno
AND s.deptno1 = 101;

-----------------------------------------------

1) 학생명, 학생학과번호, 학생의 학과명, 교수명, 교수학과번호
select s.name, s.deptno1, d.dname, p.name, p.deptno
from student s, professor p, department d
where s.profno = p.profno
AND s.deptno1 = d.deptno;

2) 학생명, 학생학과번호, 교수의 학과명, 교수명, 교수학과번호
select s.name, s.deptno1, d.dname, p.name, p.deptno
from student s, professor p, department d
where s.profno = p.profno
AND p.deptno = d.deptno;

3) 학생명, 학생학과번호, 학생의 학과명, 교수명, 교수학과번호, 교수의 학과명
select s.name, s.deptno1, ds.dname, p.name, p.deptno
from student s, professor p, department ds, department dp
where s.profno = p.profno   -- 학생 <--> 지도교수 (profno 기준)
AND s.deptno1 = ds.deptno   -- 학생 <--> 학과정보 (deptno1 | deptno)
AND p.deptno = dp.deptno;   -- 교수 <--> 학과정보 (deptno 기준)


----------------------------------------

INNER JOIN
OUTER JOIN

등가조인         조인의 연결 조건 = 같다
비등가조인       조인의 연결 조건 = 같다가 아닌 다른 조건으로 연결


select * from customer;
select * from gift;

point 점수 g_start    g_end 사이에 들어가면 해당 사은품 수령

select *
from customer c, gift g
where c.point BETWEEN g.g_start AND g.g_end;


SELF JOIN

select * from emp;

select *
from emp e1, emp e2
where e1.mgr = e2.empno;

select *
from emp2;

select A.empno, A.name, A.pempno, B.empno, B.name
from emp2 A, emp2 B
where A.pempno = B.empno;

















