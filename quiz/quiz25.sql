

* 다음 조건에 맞는 테이블을 생성하시오.
* 테이블명 : T_MENU_12

* 내부 컬럼 (컬럼명은 적절하게 지을 것!)

CREATE TABLE T_MENU_12
(
    M_ID NUMBER CONSTRAINT T_MENU_ID_PK PRIMARY KEY, --메뉴 아이디 : 숫자형, 기본키
    M_NAME VARCHAR2(128) CONSTRAINT T_MENU_NAME_NOTNULL NOT NULL, --메뉴 이름 : 128바이트 문자형, Null 이면 안됨!
    PRICE NUMBER(10), --가격 : 10자리 숫자형
    TYPE VARCHAR2(64), --종류 : 64바이트 문자형, Null 가능
    M_DATE DATE --메뉴개발일자 : 날짜타입
    --dev_date
);

* 아래 데이터를 테이블에 저장하시오.
1 싸이버거 6000 완전식품 저장시점
2 콩나물비빔밥 7000 탄수화물 저장시점
3 닭가슴살 3000 단백질 저장시점
4 베트남쌀국수 8000 탄수화물 저장시점
5 라면 2000 밀가루 저장시점

INSERT ALL
INTO t_menu_12 VALUES (1, '싸이버거', 6000, '완전식품', SYSDATE)
INTO t_menu_12 VALUES (2, '콩나물비빔밥', 7000, '탄수화물', SYSDATE)
INTO t_menu_12 VALUES (3, '닭가슴살', 3000, '단백질', SYSDATE)
INTO t_menu_12 VALUES (4, '베트남쌀국수', 8000, '탄수화물', SYSDATE)
INTO t_menu_12 VALUES (5, '라면', 2000, '밀가루', SYSDATE)
select * from dual;


* 생성한 해당 데이터를 조회하시오.
select * from t_menu_12;

* 베트남쌀국수의 가격을 8500원으로 변경하시오.

UPDATE t_menu_12
SET price = 8500
WHERE m_name = '베트남쌀국수';
--where id = 4;


* 메뉴에서 라면을 삭제하시오.
DELETE FROM t_menu_12
WHERE m_name = '라면';
--where id = 5;
