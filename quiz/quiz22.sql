--emp2 dept2 테이블을 참고하여, 'AL Pacino'와 "같은 지역"에서
--근무하는 직원들의 평균 연봉보다 많이 받는 직원들의 
--사번, 이름, 부서번호, 부서이름, 근무지역, 급여 를 출력하세요.

select * from emp2;
select * from dept2;

select e.empno, e.name, e.deptno, d.dname, d.area, e.pay
from emp2 e, dept2 d
where e.deptno = d.dcode
    AND e.pay > (
                select AVG(e2.pay)
                from emp2 e2, dept2 d2
                where e2.deptno = d2.dcode
                    AND d2.area = (
                        select d3.area
                        from emp2 e3, dept2 d3
                        where e3.deptno = d3.dcode
                        AND e3.name = 'AL Pacino')
                        );
                        
--같은 지역 직원들 평균 연봉: 48333333.....
select AVG(e1.pay)
from emp2 e1, dept2 d1
where e1.deptno = d1.dcode
    AND d1.area = (
        select d2.area
        from emp2 e2, dept2 d2
        where e2.deptno = d2.dcode
        AND e2.name = 'AL Pacino');

--'AL Pacino'의 근무지역
select d.area
from emp2 e, dept2 d
where e.deptno = d.dcode
AND e.name = 'AL Pacino';
----------------------------------------------

select e.empno, e.name, e.deptno, d.dname, d.area, e.pay
from emp2 e, dept2 d
where pay > (
            select AVG(pay)            --같은 지역 부서에 일하는 사람들 -> 평균연봉
            from emp2
            where deptno IN ( select dcode        --동일 근무지역에 속한 부서번호들
                                from dept2
                                where area = (select area     --알파치노 소속 부서의 근무지역 
                                                from dept2
                                                where dcode = ( select deptno  --알파치노 소속 부서번호
                                                                from emp2
                                                                where name = 'AL Pacino' ))))
AND e.deptno = d.dcode;      
;

