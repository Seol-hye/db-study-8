select * from student;

--1번
SELECT
    name || '''s ID : ' || id || ', WEIGHT is ' || weight || 'Kg' AS "ID AND WEIGHT"
FROM student;

--2번
SELECT
    ename || '(' || job || '), '|| ename || '''' || job || '''' AS "NAME AND JOB"
FROM emp;

--3번
SELECT
    ename || '''s sal is $' || sal || '''' AS "Name and Sal"
FROM emp;