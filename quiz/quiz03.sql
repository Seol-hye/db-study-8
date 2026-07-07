
--1. dept 테이블을 활용하여 아래와 같은 결과를 만드는 쿼리를 작성하세요
select 
    deptno "부서번호",
    dname "부서이름",
    loc "위치"
from dept;

--2. professor 테이블을 활용하여 아래와 같은 결과를 만드는 쿼리를 작성하세요
select
    name || '(' || id || ')' as "교수정보",
    position,
    hiredate as "입사일자",
    email as "이메일"
from professor;