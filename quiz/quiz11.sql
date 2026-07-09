--emp 전체 sal 급여 평균
select AVG(sal) "평균"
from emp;

--emp 30번부서사람들 평균급여
select
    AVG(sal) "평균"
from emp
where deptno = 30;

--emp 각부서별 평균 급여
select
    deptno, AVG(sal) 평균급여
from emp
group by deptno;

--emp 각부서별 인원과 평균 급여
select
    deptno,
    count(*) 인원, SUM(sal) 평균급여
from emp
group by deptno;

select *
from emp;

--emp 각 직업별 평균 급여
select
    job, AVG(sal) 평균급여
from emp
group by job;

--emp 각 직업별 가장 높은 급여 얼마?
select
    job, MAX(sal)
from emp
group by job;

--emp 각 부서별 가장 높은 급여 얼마?
select
    deptno, MAX(sal)
from emp
group by deptno;
