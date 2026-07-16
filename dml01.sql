/*-------------------------------------*/
DML 테이블 내부의 데이터 조작

데이터(행) 컬럼 값들...
저장  INSERT
수정  UPDATE
삭제  DELETE
병합  MERGE


INSERT INTO 테이블명 (컬럼명, 컬럼명, ...)
VALUES (데이터값, 데이터값, ...)

전체 컬럼에 데이터 저장 + 컬럼 순서 맞춰서 저장 --> 컬럼명 생략 가능
INSERT INTO 테이블명
VALUES (데이터값, 데이터값, ...)
;

select *
from new_table1;

INSERT INTO NEW_TABLE1 (no, name, birth)
VALUES (1, '이름1', SYSDATE);

commit;
rollback;

insert into new_table1 (no, name, birth)    --순서 다름. 컬럼 타입 달라서 저장 안됨
values ('이름2', 2, SYSDATE);

insert into new_table1 (name, no, birth)   
values ('이름2', 2, SYSDATE);


insert into new_table1 (name, no, birth)   
values ('이름3', 3, TO_DATE('2020-01-30'));

select * from new_table1;


insert into new_table1 
values (4, '이름4', SYSDATE);


insert into new_table1 (no, name)
values (5, '이름5');

insert into new_table1 
values (6, '이름6', null);


INSERT ALL
INTO new_table1 VALUES (7, '이름7', null)
INTO new_table1 VALUES (8, '이름8', SYSDATE)
INTO new_table1 VALUES (9, '이름9', TO_DATE('2025-12-11'))
select * from dual;


/*----------------------------------*/
다른 테이블 데이터 조회 -> 복사 저장

select * from NEW_TABLE1;
select * from NEW_TABLE2;

INSERT INTO new_table2
select no, name, birth from new_table1;

INSERT INTO new_table2
select no, name, birth from new_table1
where no < 5;

TRUNCATE TABLE new_table2;

insert into NEW_TABLE2
select 10, '이름10', SYSDATE from dual;



/*----------------------------------*/
수정 UPDATE

UPDATE 테이블명
SET 컬럼명 = 값,
    컬럼명 = 값,
    컬럼명 = 값
WHERE 조건;

select *
from dept3;

Seoul Branch Office -> Incheon Branch Office


update dept3
SET area = 'Incheon Branch Office'
where area = 'Seoul Branch Office';


Sales1 Team -> Sales First Team

UPDATE dept3
set dname = 'Sales First Team'
--select * from dept3
where dcode = 1008;     --update에 조건을 누락하면 테이블내의 전체 데이터가 수정됨 주의


--테이블 복사
CREATE TABLE professor2
as
select * from professor;

select * from professor2;
> bonus 받는 교수들 보너스금액 +100 인상

update professor2
set bonus = 200
where profno = 1001;

UPDATE professor2
set bonus = bonus + 100
--select * from professor2
where bonus is not null;


/*----------------------------*/
Transaction
TCL

commit; 확정
rollback; 취소(되돌리기)

DML(insert, update, delete) -> commit or rollback 수행


select * from new_table2;
INSERT INTO new_table2 values(11, '이름11', SYSDATE);
commit;
rollback;



/*--------------------------------*/
DELETE 데이터 삭제
(DB tool에서 delete 쿼리 수행시 rollback 가능 : 단, 자동commit 설정이 아닌 상태일 경우)

DELETE FROM 테이블명
WHERE 조건;

select * from dept3;

select *
--delete
from dept3
where dcode = '0001';

commit;













