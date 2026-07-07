/*----------------------------------*/
조건 WHERE 절
필터링 기능, 원하는 조건에 따라서 조회

SELECT ...
FROM ...
WHERE ...;

SELECT * FROM emp; --전체 데이터 조회

SELECT * FROM emp WHERE sal > 2500;
-- emp 테이블에서 sal 컬럼값이 2500을 초과하는 모든 데이터 조회

SELECT ename FROM emp WHERE sal > 2500;
-- emp 테이블에서 sal 컬럼값이 2500을 초과하는 직원들의 이름을 조회

SELECT * FROM emp WHERE job = 'SALESMAN';
-- emp 테이블에서 job(직업)이 세일즈맨인 직원들만 전체 컬럼 조회


-- 부서번호가 10번인 사원들 정보 조회(10번 부서에 속한)
SELECT * FROM emp WHERE deptno = 10;

-- 부서번호가 10번이 아닌 사원정보
select * from emp where deptno != 10;
select * from emp where deptno <> 10;

SELECT * FROM STUDENT
--WHERE weight >= 55; --55kg 이상
--where weight >= 55 AND weight <= 70; -- 55kg<= 대상 <= 70     --AND OR
where weight BETWEEN 55 AND 70;

select *
from student -- 1~3학년만 조회
--where grade >= 1 and grade <=3;
--where grade between 1 and 3;
--where grade = 1 or grade = 2 or grade = 3;
--where grade <> 4;
--where grade != 4;
where grade IN (1,2,3);

-- NOT
-- 2, 4학년만 조회
select *
from student
--where grade IN (2,4);
--where grade = 2 OR grade = 4;
--where grade != 1 AND grade <> 3;
where grade NOT IN (1,3);


LIKE 패턴 검색 (문자)
    % : 0 ~ n개(아무갯수나 가능)
    _ : 해당 위치에 1개

select *
from emp
--where ename = 'SMITH';
--where ename LIKE '%M%';   -- ~~~M~~~  M~~~~   ~~~~M
--where ename LIKE 'M%';
--where ename LIKE '%N';
--where ename LIKE '_M%'; -- OM  OM123121   SMITH
where ename LIKE '__M%'; -- JAMES
-- name title .. LIKE '%만두%'

--null 값 비교
select *
from emp
--where comm is null;
where comm is not null;


날짜비교
1201
1221
미래일수록 큰 값
과거일수록 작은 값

select *
from emp --테이블 팝업설명 정보 -> Shift+F4
--where hiredate = '80/12/17'; -- YY/MM/DD
--where hiredate = '1980-12-17'; -- YYYY-MM-DD
--where hiredate > '80/08/20';
where hiredate <= '1981-04-05';

desc emp;


/*----------------------------------*/
정렬 ORDER BY
단순조회 -> 정렬을 명시하지 않으면 순서보장X
order by 정렬기준컬럼명 [ASC | DESC] [오름차순 | 내림차순]

SELECT ...
FROM ...
WHERE ...
ORDER BY ...;


select *
from student
--order by name; -- asc 기본값 생략
order by name ASC;

--내림차순
select *
from student
order by name desc;

--학생들 학년 기준으로 내림차순 정렬 -> 이름과 학년을 조회
select name, grade
from student
order by grade desc;

-- 학생테이블 기준 1,2,3학년 학생들을 키 내림차순 순서로 조회
select *
from student
where grade in(1,2,3)
order by height desc;

select *
from student
where grade in(1,2,3)
order by grade, height desc;

select *
from student
where grade in(1,2,3)
order by height, grade desc;


select *
from student
--order by birthday; --오름차순 작은값->큰값   작을수록 더 과거   클수록 더 미래
order by birthday desc;













