/*----------------------------*/
시퀀스 (Sequence)

순차적으로 값을 사용하는 용도 (번호표)
                (다른 DB auto increment ...)

PK(기본키) 용으로 사용하거나 순차적인 데이터를 표현하기위해 사용하는 숫자 값
시퀀스를 호출 할 때마다 자동으로 증가


시퀀스 생성
 
CREATE SEQUENCE 시퀀스명
INCREMENT BY 1  --증가할 값
START WITH 1    --시작값
MINVALUE 1      --최소값
MAXVALUE 10     -- 최대값
CYCLE | NOCYCLE -- 순환여부  default:NOCYCLE
CACHE 20 | NOCACHE --숫자 메모리에 미리 저장해둘 갯수
;

시퀀스 삭제
DROP SEQUENCE 시퀀스명

시퀀스 사용(호출)
시퀀스명.nextval 다음값 호출(사용)
시퀀스명.currval 현재값 확인

/*******-------------------***/

--PK 설정/ PK 활용
;

CREATE TABLE SEQ_TEST
(
    no NUMBER(6) PRIMARY KEY,
    name VARCHAR2(32)
);

select * from SEQ_TEST;

수동으로 no(pk) 값 확인하고 처리
INSERT INTO seq_test VALUES (1, '이름1');
INSERT INTO seq_test VALUES (2, '이름2');

서브쿼리로 no 순번 값 계산으로 처리 (COUNT)
select COUNT(*) from seq_test;  --현재 갯수
select COUNT(*)+1 from seq_test;  --다음 no값

INSERT INTO seq_test VALUES ( (select COUNT(*)+1 from seq_test), '이름3');
INSERT INTO seq_test VALUES ( (select COUNT(*)+1 from seq_test), '이름4');
INSERT INTO seq_test VALUES ( (select COUNT(*)+1 from seq_test), '이름5');

select * from SEQ_TEST;

--한명이 탈퇴 3번 사용자 탈퇴
select *
--delete
from seq_test
where no = 3;

다음 사용자 가입 저장 -> PK 중복으로 저장 불가 케이스
INSERT INTO seq_test VALUES ( (select COUNT(*)+1 from seq_test), '이름6');

--------******
데이터 관리 기준이 어떻게 되느냐?
삭제(탈퇴) 어떻게 관리? 탈퇴하면?
    1) 데이터 행 삭제 (delete from ...)
    2) 삭제된 것처럼 데이터(상태값)로 관리 ('Y', 'N', ... 'O', 'X' )
--------******

서브쿼리로 no 순번 값 계산으로 처리 (MAX)

select * 
-- delete
from seq_test;

select MAX(no)  --현재 마지막으로 사용된 제일큰 no 값
from seq_test;

select MAX(no)+1 --이 다음에 사용할 no 값
from seq_test;

select NVL(MAX(no), 0) + 1 --이 다음에 사용할 no 값
from seq_test;
select NVL(MAX(no)+1, 1) --이 다음에 사용할 no 값
from seq_test;

INSERT INTO seq_test VALUES ( (select NVL(MAX(no), 0) + 1 from seq_test), '이름6');



시퀀스 로 no 순번값 처리

-- T_테이블명
-- V_뷰명
-- dept3_id_notnull

CREATE SEQUENCE SEQ_SEQ_TEST_PKS
INCREMENT BY 1
START WITH 1;
--MIN /MAX /CACHE / NOCYCLE

select SEQ_SEQ_TEST_PKS.nextval from dual; --다음 차례 seq 호출 (호출하는 순간 사용됨, 계속 진행~)
select SEQ_SEQ_TEST_PKS.currval from dual; --현재 시퀀스값 확인


INSERT INTO seq_test VALUES ( SEQ_SEQ_TEST_PKS.nextval, '이름7');
INSERT INTO seq_test VALUES ( SEQ_SEQ_TEST_PKS.nextval, '이름8');
INSERT INTO seq_test VALUES ( SEQ_SEQ_TEST_PKS.nextval, '이름9');

select * from seq_test
order by no;

select *
--delete
from seq_test
where no = 11;

INSERT INTO seq_test VALUES ( SEQ_SEQ_TEST_PKS.nextval, '이름10');
INSERT INTO seq_test VALUES ( SEQ_SEQ_TEST_PKS.nextval, '이름11');

PK를 시퀀스로 사용
일반 숫자로 활용 ~9999999999999999999999999999
코드와 결합 'CL' || seq.nextval    CL1 CL2 CL3 CL4
          'SH' || seq.nextval    SH1 SH5 SH6 SH7 



시퀀스 값을 조정해서 다시 1부터 시작

1) 시퀀스 삭제 후 재생성
DROP SEQUENCE SEQ_SEQ_TEST_PKS;

CREATE SEQUENCE SEQ_SEQ_TEST_PKS
INCREMENT BY 1
START WITH 1;

select SEQ_SEQ_TEST_PKS.nextval from dual;


2) 다음 시퀀스 값 조정

--현재값 확인
select SEQ_SEQ_TEST_PKS.currval from dual;
--이 다음에 다시 nextval 다음 값을 호출했을때 1이 나오도록 만들기!

--0으로 바꾸기  , 그 다음에 +1   -> 1
--지금 26 기준

--값이 조정되는 기준을 변경
ALTER SEQUENCE SEQ_SEQ_TEST_PKS INCREMENT BY -26;
ALTER SEQUENCE SEQ_SEQ_TEST_PKS MINVALUE 0;
--1회 호출해서 다음값 변경 (0으로 만들기)
select SEQ_SEQ_TEST_PKS.NEXTVAL from dual;
--다시 1씩 증가하는 기준으로 설정 복구
ALTER SEQUENCE SEQ_SEQ_TEST_PKS INCREMENT BY 1;
--시퀀스 다시 사용
select SEQ_SEQ_TEST_PKS.NEXTVAL from dual;

--------------------------------------------

CREATE SEQUENCE SEQ_01
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 5
NOCYCLE;

SELECT SEQ_01.NEXTVAL FROM DUAL;


CREATE SEQUENCE SEQ_02
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 5
CYCLE
CACHE 3;

SELECT SEQ_02.NEXTVAL FROM DUAL;



CREATE SEQUENCE SEQ_03
START WITH 100
INCREMENT BY 5;

SELECT SEQ_03.NEXTVAL FROM DUAL;














