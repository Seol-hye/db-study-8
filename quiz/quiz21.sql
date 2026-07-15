--1.
--student, department 테이블 활용
--학과 이름, 학과별 최대키, 학과별 최대키를 가진 학생들의 이름과 키를 출력 하세요.
select * from student;
select * from department;

select deptno1, MAX(height)
from student
group by deptno1;

select 
    d.dname,
    s.height as max_height,
    s.name,
    s.height
from student s, department d
where s.deptno1 = d.deptno
    AND s.height = (
                    select MAX(s2.height)
                    from student s2
                    where s2.deptno1 = s.deptno1
                    )
;

--2.
--student 테이블에서 학생의 키가 동일 학년의 평균 키 보다 큰 학생들의 학년과 이름과 키,
--해당 학년의 평균 키를 출력 하세요.
--(학년 컬럼으로 오름차순 정렬해서 출력하세요)
select
    grade,
    name,
    height,
    (
        select AVG(s2.height)
        from student s2
        where s2.grade = s.grade
        ) as avg_height
from student s
where height > (
    select AVG(s2.height)
    from student s2
    where s2.grade = s.grade
    )
order by grade, height;




