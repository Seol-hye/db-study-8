--1.
--student, score, hakjum 테이블을 활용하여 다음 정보를 출력하세요.
--각 학생 별로 점수가 몇점이고 그 점수가 어떤 학점인지를 확인하고 싶습니다.
--학번 이름 점수 학점 순으로 조회하세요.
select 
    sd.studno 학번,
    sd.name 이름,
    sc.total 점수,
    h.grade 학점
from student sd, score sc, hakjum h
where sd.studno = sc.studno
AND sc.total BETWEEN h.min_point AND h.max_point
order by h.grade, sc.total desc;

select * from hakjum;
select * from score;
select * from student;

--2.
--student, score, hakjum 테이블을 활용하여 다음 정보를 출력하세요.
--각 학생 별로 점수가 몇점이고 그 점수가 어떤 학점인지를 확인하고 싶습니다.
--학번 이름 점수 학점 순으로 조회하세요.
--위 내역에서 101, 102 학과에 속한 학생들의 정보만 보여주세요.
select 
    sd.studno 학번,
    sd.name 이름,
    sc.total 점수,
    h.grade 학점
from student sd, score sc, hakjum h
where sd.studno = sc.studno
AND sc.total BETWEEN h.min_point AND h.max_point
AND sd.deptno1 IN (101, 102)
order by h.grade, sc.total desc;

--3.
--학생 테이블(student)과 학과 테이블(department) , 교수 테이블(professor) 을 Join하여
--301학과 속한 교수를 제외한 교수를 지도교수로 두고 있는
--학생의 이름과 학생의 학년, 학생의 지도교수 이름, 지도교수의 학과 번호, 지도교수가 속한 학과이름을 출력하세요.

select 
    s.name 학생이름, 
    s.grade 학생학년, 
    p.name 교수이름, 
    p.deptno 교수학과번호, 
    d.dname 교수소속학과이름
from student s, professor p, department d
where s.profno = p.profno
AND p.deptno = d.deptno
AND p.deptno <> 301;

--where p.deptno <> 301
--AND p.deptno = d.deptno
--AND p.deptno <> 301;


select
    s.name 학생이름, 
    s.grade 학생학년, 
    p.name 교수이름, 
    p.deptno 교수학과번호, 
    d.dname 교수소속학과이름
from
    student s
    INNER JOIN professor p
    ON s.profno = p.profno
    INNER JOIN department d
    ON p.deptno = d.deptno
where
    p.deptno != 301;