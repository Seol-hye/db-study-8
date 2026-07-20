/*---------------------------------*/
DDL 제약조건 KEY

PK(Primary Key) 기본키 (테이블에 한개만 설정 가능)
FK(Foreign Key) 외래키

CREATE TABLE T3
(
    no number(3) PRIMARY KEY,   --기본키 설정(NOT NULL, UNIQUE 포함)
    name varchar2(16),
    birth date
);

insert into t3 values (1, 'n1', sysdate);

select * from t3;

insert into t3 values (1, 'n1', sysdate); --no 컬럼 (PK) 중복으로 불가
insert into t3 values (null, 'n1', sysdate); --no 컬럼 (PK) NOT NULL 제약


--테이블에는 하나의 기본키만 가질 수 있습니다.
CREATE TABLE T4
(
    no number(3) PRIMARY KEY,       --기본키(PK) 설정
    id varchar2(32) PRIMARY KEY,    --기본키(PK) 설정
    name varchar2(16) NOT NULL,
    birth date DEFAULT SYSDATE
);


--(n개) 두 개의 컬럼을 조합해서 PK로 설정
CREATE TABLE T4
(
    no number(3),      
    id varchar2(32),   
    name varchar2(16) NOT NULL,
    birth date DEFAULT SYSDATE,
    CONSTRAINT T4_PK PRIMARY KEY (no, id) --no id 두개 컬럼을 조합으로 PK 설정
);

                                                        
---------------------------------

