/*--------------------------------------*/
FK(외래키)

student (profno 컬럼)     ->     profressor (profno)

외래키 FK : 다른 테이블에 있는 키값 참조하는 컬럼
- 참조하는 테이블(부모테이블)에 존재하는 값만 사용 가능 (+ null 가능)
- 외래키 대상으로 설정된 부모테이블 입장에서
  자신을 참조하는 자식테이블의 데이터가 존재하면, 삭제 불가 (설정에 따라)
  

외래키 삭제 조건
ON DELETE CASCADE;  부모데이터 삭제시 -> 해당 값을 참조하는 자식데이터도 같이 삭제
ON DELETE SET NULL; 부모데이터 삭제시 -> 해당 값을 참조하는 자식 데이터를 NULL 값으로 변경


CREATE TABLE T_CLUB
(
    id NUMBER(3) PRIMARY KEY,
    name VARCHAR2(32)
);

-- T_TABLE명
-- V_VIEW명

DROP TABLE T_MEMBER;

CREATE TABLE T_MEMBER
(
    id NUMBER(3) PRIMARY KEY,
    name VARCHAR2(32),
    --club_id REFERENCES T_CLUB(ID) --외래키 FK 설정
    --club_id REFERENCES T_CLUB(id) ON DELETE CASCADE --외래키 FK 설정
    club_id REFERENCES T_CLUB(id) ON DELETE SET NULL  --외래키(FK) 설정
);

select * from t_club;
select * from t_member;





select * from T_CLUB;

INSERT INTO T_CLUB VALUES(1, '독서');
INSERT INTO T_CLUB VALUES(2, '게임');
INSERT INTO T_CLUB VALUES(3, '등산');
INSERT INTO T_CLUB VALUES(4, '낚시');

select * from T_MEMBER;

INSERT INTO T_MEMBER VALUES(1, '이름1', 2);
INSERT INTO T_MEMBER VALUES(2, '이름2', 1);
INSERT INTO T_MEMBER VALUES(3, '이름3', 1);

select *
from T_MEMBER m, T_CLUB c
where m.club_id = c.id;

INSERT INTO T_MEMBER VALUES (1, '이름4', 3);      --MEMBER PK id 중복
INSERT INTO T_MEMBER VALUES (null, '이름4', 3);   --MEMBER PK id NOT NULL
INSERT INTO T_MEMBER VALUES (4, '이름4', 5);      --"부모키가 없습니다"
-- FK 참조 부모테이블에 id값 참조 -> id 값 존재 범위 1~4까지만 존재  5는 존재X
INSERT INTO T_MEMBER VALUES (4, '이름4', null);
INSERT INTO T_MEMBER VALUES (5, '이름5', 3);


select *
from T_MEMBER m, T_CLUB c
where m.club_id = c.id(+);

select *
--delete
from T_CLUB
where id = 3;
--자식 레코드가 발견되었습니다
--id 3인 데이터를 외부 자식 테이블에서 참조하고 있는 상태 -> 삭제 불가

참조가 있으면? 삭제 불가
삭제하고 싶으면? 참조하는 자식 테이블 데이터 먼저 삭제
select *
--delete
from T_MEMBER
where id = 5; --자식 테이블 데이터 먼저 삭제

select *
--delete
from T_CLUB --참조하는 외부 테이블 데이터가 없으면 삭제 가능
where id = 3;


----------------------------------
ON DELETE CASCADE

select *
--delete
from T_CLUB
where id = 1;

select *
from T_MEMBER;

-----------------------------------

ON DELETE SET NULL

select *
--delete
from t_club
where id = 1;

select *
from t_member;








