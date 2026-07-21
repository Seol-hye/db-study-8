1. 다음 두 명령어는 어떤 기능을 수행하는 명령어인지 작성하고,
두 기능의 차이점이 있다면 설명하시오.
DELETE FROM 테이블명;
-> 테이블의 모든 데이터를 삭제하는 DML 명령어, WHERE절 사용 가능, 삭제 후 ROLLBACK 가능

TRUNCATE TABLE 테이블명; 
> 테이블의 모든 데이터를 삭제하는 DDL 명령어, WHERE절 사용 불가능, 삭제 후 ROLLBACK 불가능

2. 다음 조건에 따라 테이블을 생성하시오.
테이블명 : T_MEMBER_POINT

*내부 컬럼
ID : 숫자형 6자리
순번 : 숫자형 6자리
멤버ID : 문자형 24바이트, Null 안됨(꼭 입력해야함)
점수 : 숫자형 3자리
채점일시 : 날짜형, 단 입력된 값이 없을 경우 입력(현재)시간을 기본값으로 설정
※ 기본키(PK) : ID와 순번의 조합

CREATE TABLE T_MEMBER_POINT
(
    id NUMBER(6),
    no NUMBER(6),
    member_id VARCHAR2(24) NOT NULL,
    point NUMBER(3),
    point_date DATE DEFAULT SYSDATE,
    CONSTRAINT T_MEMBER_POINT_PK PRIMARY KEY (id, no)
);

select * from t_member_point;


--3. 다음 조건에 맞는 시퀀스를 생성하시오. -> 생성한 시퀀스는 id 컬럼에 사용
--시퀀스명 : T_MEMBER_POINT_PK_SEQ
--*상세조건
--1부터 시작하며 1씩 증가한다.
--값의 범위는 1~999999
--순환하지 않도록 한다.

CREATE SEQUENCE T_MEMBER_POINT_PK_SEQ
START WITH 1    --1부터 시작
INCREMENT BY 1  --1씩 증가
MINVALUE 1      --최소값
MAXVALUE 999999 --최대값
NOCYCLE; --순환X


--4. 생성한 시퀀스의 값을 불러서 임의의 데이터를 저장해보시오.
--(*순번은 각 멤버ID 별로 자동 계산되어 저장하도록 해주세요)
--- 시퀀스 사용 -> id
--- 순번(no) -> 해당 학생이 시험을 치룬 회차 계산되서 저장
----
--
--* 저장시 필요한 데이터가 파라미터로 전달되는 것으로 가정
--저장하는 데이터 예시)
--ID: 1, 순번: 1, 멤버ID : A, 점수: 30, 채점일시:입력or현재
--ID: 2, 순번: 1, 멤버ID : B, 점수: 40, 채점일시:입력or현재
--ID: 3, 순번: 1, 멤버ID : C, 점수: 40, 채점일시:입력or현재
--ID: 4, 순번: 2, 멤버ID : A, 점수: 50, 채점일시:입력or현재
--ID: 5, 순번: 2, 멤버ID : B, 점수: 60, 채점일시:입력or현재
--ID: 6, 순번: 3, 멤버ID : A, 점수: 70, 채점일시:입력or현재

select * from t_member_point;


INSERT INTO T_MEMBER_POINT
VALUES ( 
    T_MEMBER_POINT_PK_SEQ.nextval,
    (select NVL(MAX(NO), 0)+1
       from T_MEMBER_POINT
      where member_id='A'),
    'A',
    70,
    DEFAULT
);


select COUNT(*)+1
       from T_MEMBER_POINT
      where member_id='A')



