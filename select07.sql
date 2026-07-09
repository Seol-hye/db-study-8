/*--------------------------------------*/
복수행 함수      (집계)

COUNT(대상)   갯수세기

select *
from emp;

select COUNT(*)
from emp;

-- 갯수 대상식별자 (*, 기본키 Primary Key / PK - 유니크(중복X), 값존재)

select
    count(empno),
    count(ename),
    count(mgr),
    count(comm) -- null이 아닌 값의 갯수
from emp;

select
    count(*)
from emp
where comm is not null;

select
    count(*)
from emp
where comm is null;

--student 4학년 몇 명?
select count(*)
from student
where grade = 4;


수치 집계
SUM / AVG / MAX / MIN / STDDEV / VARIANCE

-- 총 직원 몇명, 총 급여 얼마냐
select
    count(*), SUM(sal), SUM(comm)
from emp;

-- 10, 20 부서에 다니는 직원 몇 명, 총 급여
select
    count(*), SUM(sal)
from emp
where deptno IN (10, 20);


select
    count(height),
    sum(height),
    avg(height),
    max(height),
    min(height),
    stddev(height),
    variance(height),
    avg(weight)
from student;


/*--------------------------------------*/
그룹화하기 group by

SELECT ...
FROM ...
WHERE ...
GROUP BY 컬럼대상을 지정(지정된 컬럼을 기준으로 그룹지어서 계산)
         group by에 명시한 컬럼은 select 조회에 사용 가능
HAVING
ORDER BY
;

--학생들 각 학년별 평균키

select '1학년', avg(height)
from student
where grade = 1
UNION ALL
select '2학년', avg(height)
from student
where grade = 2
UNION ALL
select '3학년', avg(height)
from student
where grade = 3
UNION ALL
select '4학년', avg(height)
from student
where grade = 4;


select
    grade, AVG(height)
from student
group by grade;

select
    grade, COUNT(*), AVG(height)
from student
group by grade
order by grade;

select
    studno, COUNT(*), AVG(height)
from student
group by studno;

select *
from student;

-- 1,2,3학년 학년별 평균키  학년기준 내림차순 정렬
select
    grade 학년, AVG(height) 평균키
from student
where grade IN (1,2,3)
group by grade
order by 1 desc;
--order by 학년 desc;

1) 급여가 2000 이상인 직원들 대상으로 부서별 평균 급여
select 
    deptno,
    AVG(sal)
from emp
where sal >= 2000
group by deptno;

2) 부서별 평균 급여가 2000 이상인 부서별 평균 급여
select
    deptno, AVG(sal)
from emp
group by deptno
having AVG(sal) >= 2000;

student
학생 각 학년별 평균 몸무게
평균 몸무게가 65kg 이상인 경우만
select grade, AVG(weight)
from student
group by grade
having AVG(weight) >= 65;


student
4학년을 제외하고
학생 각 학년별 평균 몸무게
평균 몸무게가 65kg 이상인 경우만
학년별 오름차순 정렬
select 
    grade, AVG(weight)
from student
where grade != 4
group by grade
having AVG(weight) >= 65
order by grade;



select deptno, AVG(sal)
from emp
group by deptno;

select job, avg(sal)
from emp
group by job;

select job, deptno, avg(sal)
from emp
group by job, deptno
order by job, deptno desc;














