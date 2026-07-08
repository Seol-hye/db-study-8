/*--------------------------------------*/
단일행 함수


NVL 함수
값이 null 일 때 기본값 처리
NVL(대상, null일 때 기본값)


select
    sal,
    comm,
    (sal*12) + comm,
    NVL(comm, 123),
    NVL(comm, 0),
    (sal*12) + NVL(comm, 0)
from emp;


select
    sal,
    comm,
    sal*12 + comm "연봉"
from emp
where comm is not null
UNION ALL
select
    sal,
    comm,
    sal*12
from emp
where comm is null;


NVL2(대상값, 있을때, 없을때)

select
    NVL(null, 10),
    NVL(20, 10),
    NVL2(null, '있다', '없다'),
    NVL2(1234, '있다', '없다'),
    NVL2(1234, '12342', '없다')
from dual;

select
    sal,
    comm,
    (sal*12) + NVL(comm, 0),
    NVL2(comm, comm, 0),
    (sal*12) + NVL2(comm, comm, 0),
    NVL2(comm, (sal*12)+comm, (sal*12))
from emp;


***DECODE

DECODE(대상, 비교값, '같다', '다르다')
DECODE(대상, 비교값, '같다', (DECODE(대상, 비교값, '같다', '다르다')) )
DECODE(대상, 비교값1, '같다1', 비교값2, '같다2', 비교값3, '같다3', '다르다')
DECODE(대상, 비교값1, '같다1', 비교값2, '같다2', 비교값3, '같다3') -> 마지막 생략 시 NULL

select
    decode(10, 10, '같다', '다르다'),
    decode(10, 20, '같다', '다르다'),
    decode(10, 10, '같다'),
    decode(10, 20, '같다'),       -- 다르다 생략 -> null
    decode(10, 20, '같다', null),
    decode(30, 10, '10이다', 20, '20이다', 30, '30이다', 40, '40이다', '아니다'),
    decode(30, 10, '10이다', 20, '20이다', 30, '30이다', 40, '40이다'),
    decode(40, 10, '10이다', 20, '20이다', 30, '30이다', 40, '40이다', null),
    decode(99, 10, '10이다', 20, '20이다', 30, '30이다', 40, '40이다', null)
from dual;

swith(20):
case 20: '20이다'
case 30: ...

select
    name,
    deptno,
    DECODE(deptno, 101, '컴공', 102, '전기', 103, '기계', 201, '물리', 202, '화학', 203, '수학', '기타') "학과이름",
    '전공학과:' || DECODE(deptno, 101, '컴공', 102, '전기', 103, '기계', 201, '물리', 202, '화학', 203, '수학', '기타') "학과이름"

from professor;


***CASE 문

select * 
from student;
--학년 1 2 3 4
--학년구분 -> 컬럼
-- 1 2 저학년
-- 3 4 고학년

select
    grade,
    DECODE(grade, 1, '저학년', 2, '저학년', 3, '고학년', 4, '고학년', '범위이탈') 구분,
    CASE grade
        WHEN 1 THEN '저학년'
        WHEN 2 THEN '저학년'
        WHEN 3 THEN '고학년'
        WHEN 4 THEN '고학년'
        ELSE '범위이탈'
    END AS "구분CASE",
    CASE
        WHEN grade IN (1,2) THEN '저학년'
        WHEN grade BETWEEN 3 AND 4 THEN '고학년'
        else '어쩌구...'
    END 구분CASE2
from student;

-----------------------
연봉계산

select
    sal,
    comm,
    sal*12 + comm 연봉1,
    sal*12 + NVL(comm, 0) 연봉2,
    sal*12 + NVL2(comm, comm, 0)  연봉3,
    NVL2(comm, sal*12+comm, sal*12) 연봉4,
    sal*12 + DECODE(comm, null, 0, comm) 연봉5,
    CASE comm
        WHEN null THEN (sal*12)         --comm = null   comm is null
        ELSE (sal*12 + comm)
    END 연봉6, -- 안되는 케이스
    CASE
        WHEN comm is null THEN (sal*12)
        WHEN comm is not null THEN (sal*12 + comm)
    END 연봉7
from emp;











