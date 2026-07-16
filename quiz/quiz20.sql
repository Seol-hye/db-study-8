--1. professor 테이블과 department 테이블을 조회하여 각 학과별로 입사일이 가장 오래된 교수의
--교수번호와 이름, 학과명을 출력하세요
--(입사일 순으로 오름차순 정렬)

select * from professor;
select * from department;

select p.profno, p.name, d.dname
from professor p, department d
where p.deptno = d.deptno
    AND p.hiredate = (
        select MIN(p2.hiredate)
        from professor p2
        where p2.deptno = p.deptno)
order by p.hiredate;



select deptno, MIN(hiredate)
from professor
group by deptno;

select p.profno, p.name, d.dname
from professor p, department d
where (p.deptno, p.hiredate) IN (select deptno, MIN(hiredate)
                                from professor
                                group by deptno)
AND p.deptno = d.deptno;



--2. emp2 테이블 조회하여 직급별로 해당 직급에서 최대 연봉을 받는 직원의 이름과 직급, 연봉을 출력하세요
--(연봉순으로 오름차순 정렬)
select * from emp2;

select name, position, pay
from emp2 e
where pay = (
    select MAX(e2.pay)
    from emp2 e2
    where e2.position = e.position
    )
order by pay;



