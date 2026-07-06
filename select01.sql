/*-------------------------*/
1. 조회하기 SELECT

SELECT 조회대상(컬럼명) FROM 테이블명;
조회대상 * : 전체컬럼 ALL

테이블 구조 확인 (Describe)
DESC 테이블명;
desc emp;

DESC DEPT;
select * from dept;
SELECT * FROM DEPT;


select * from fruit; -- fruit 테이블의 모든 컬럼 데이터 조회
select * from loan;
SELECT * FROM PRODUCT; --product 테이블의 모든 컬럼 데이터 조회

select * from emp;
select job from emp;
select job, hiredate, mgr from emp;

--가독성
select
    job,
    hiredate,
    mgr
from emp;

select * from emp;

select *
from emp;

/*----------------------------------*/
-- 컬럼명 별도 지정 (별칭 지정)
SELECT
    컬럼명 AS "컬럼별칭",
    컬럼명 "컬럼별칭",
    컬럼명 컬럼별칭
FROM 테이블명;

select
    empno AS "사원번호",
    ename "사원명",
    job 직업,
    sal "급여 데이터"
from emp;

select
    empno,
    empno empnumber,
    empno employeeno
from emp;


/*----------------------------------*/
-- 조회데티어 리터럴 값 활용

select '문자', 123 from emp;
select '문자', 123, empno from emp;

select '문자', 123 from dept;
select * from dept;

select '문자', 123 from dual; -- dual 임시테이블
select * from dual;

select '문자확인' AS "문자컬럼별칭",
        123+234-33 숫자연산결과
from dual;

select dname, loc, '문자안녕', 12345 from dept;
select '문자''작은따옴표' from dual;
select q'[이 안에다가 문자를 '작은"큰 이렇게]' from dual;
--q'[문자작성]'


/*--------------------------------*/
-- 문자 이어붙이기 ||
select '문자' || '이어붙이기' from dual;
select * from dept;
select deptno, dname, from dept;
select deptno || dname from dept;
select
    '부서번호 : ' || deptno AS "부서번호",
    deptno,
    '부서번호+500 = ' || (deptno + 500) 부서번호더하기500
from dept;


/*--------------------------------*/
-- DISTINCT  중복제거
select * from emp;
select job from emp;
select DISTINCT job from emp;
select DISTINCT (job) from emp;

select DISTINCT job, deptno from emp;        











