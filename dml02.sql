/*---------------------------------------*/
DML  MERGE 데이터 병합


--신발가게 날짜별 매출
CREATE TABLE T_SHOE
(
    work_date DATE,  --영업일
    store_code NUMBER(3),  --매장 고유 코드 (PK) (10, 20, 30, 40 ..)
    sales_income NUMBER(10) --매출금액  
);

--옷가게 날짜별 매출
CREATE TABLE T_CLOTH
(
    work_date DATE,  --영업일
    store_code NUMBER(3),  --매장 고유 코드 (PK) (1,2,3,4...)
    sales_income NUMBER(10) --매출금액  
);


--본사 날짜별 전체 매출 취합
CREATE TABLE T_COMPANY
(
    work_date DATE,  --영업일
    store_code NUMBER(3),  --매장 고유 코드 (PK)
    sales_income NUMBER(10) --매출금액  
);

INSERT ALL
INTO T_SHOE VALUES (TO_DATE('2025-03-01'), 1, 5000)
INTO T_SHOE VALUES (TO_DATE('2025-03-02'), 1, 15000)
INTO T_SHOE VALUES (TO_DATE('2025-03-03'), 1, 30000)
INTO T_SHOE VALUES (TO_DATE('2025-03-02'), 2, 4000)
INTO T_SHOE VALUES (TO_DATE('2025-03-03'), 2, 90000)
INTO T_SHOE VALUES (TO_DATE('2025-03-04'), 2, 120000)
INTO T_SHOE VALUES (TO_DATE('2025-03-04'), 1, 90000)
select * from dual;


SELECT *
FROM T_SHOE; 

INSERT ALL
INTO T_CLOTH VALUES (TO_DATE('2025-03-01'), 10, 59000)
INTO T_CLOTH VALUES (TO_DATE('2025-03-02'), 10, 25000)
INTO T_CLOTH VALUES (TO_DATE('2025-03-03'), 10, 33000)
INTO T_CLOTH VALUES (TO_DATE('2025-03-04'), 20, 4400)
INTO T_CLOTH VALUES (TO_DATE('2025-03-05'), 20, 99000)
INTO T_CLOTH VALUES (TO_DATE('2025-03-06'), 20, 790000)
select * from dual;

SELECT *
FROM T_CLOTH; 





T_SHOE 매출정보
T_CLOTH 매출정보  >>> T_COMPANY 전체 데이터 취합 (병합)


INSERT INTO T_COMPANY
SELECT * FROM T_SHOE;

SELECT * FROM T_COMPANY;

INSERT INTO T_COMPANY
SELECT work_date, store_code, sales_income FROM T_CLOTH;

select store_code, SUM(sales_income)
from T_COMPANY
group by store_code;

select work_date, SUM(sales_income)
from T_COMPANY
group by work_date
order by work_date;


--------------
배치처리 (batch) 주기적으로 특정 시점, 시간 수행

주기적으로 취합
데이터가 발생 -> 배치시작 새벽 2시


SELECT *
FROM T_SHOE; 
SELECT *
FROM T_CLOTH; 
SELECT *
FROM T_COMPANY; 


--취합 이후에 추가된 데이터 처리 시나리오를 위한 데이터 추가
INSERT INTO T_SHOE VALUES (TO_DATE('2025-03-07'), 1, 210000);

--취합 이후에 수정된 데이터 처리 시나리오를 위한 데이터 수정
UPDATE T_CLOTH
SET sales_income = 890000
WHERE work_date = '2025-03-06'
AND store_code = 20;


--3월 7일 추가를 하드코딩 손으로 직접 
INSERT INTO T_COMPANY
SELECT * FROM T_SHOE
where work_date = '2025-03-07';

--임시 시나리오 가정
--데이터가 밤 22~24시 저장 (어제)
--배치시작 새벽 2시 (오늘)

--INSERT INTO T_COMPANY
select *
from t_shoe
--where TO_CHAR(work_date, 'YYYYMMDD') = TO_CHAR(SYSDATE-1, 'YYYYMMDD');
where TO_CHAR(work_date, 'YYYYMMDD') = TO_CHAR( TO_DATE('2025-03-08')-1, 'YYYYMMDD');



1) DELETE -> 다시 전부 INSERT

SELECT *
FROM T_SHOE; 
SELECT *
FROM T_CLOTH; 
SELECT *
FROM T_COMPANY; 

DELETE FROM T_COMPANY;
INSERT INTO T_COMPANY SELECT * FROM T_SHOE;
INSERT INTO T_COMPANY SELECT * FROM T_CLOTH;


2) MERGE

MERGE INTO 저장대상 테이블명(최종취합)
USING 데이터를 가져올 테이블명
ON (병합/비교 기준조건)
WHEN MATCHED THEN --합치려는 데이터가 기존에 있을때
    UPDATE SET -- 수정
    DELETE WHERE -- 삭제
WHEN NOT MATCHED THEN --합치려는 데이터가 기존에 없을때
    INSERT VALUES (...) --추가
    
;
--테스트 병합전 기존 데이터 삭제
SELECT *
--DELETE
FROM T_COMPANY; 
SELECT *
FROM T_SHOE; 
SELECT *
FROM T_CLOTH; 

MERGE INTO T_COMPANY A
USING T_SHOE B
ON (A.work_date = B.work_date)
WHEN MATCHED THEN
    UPDATE SET A.sales_income = B.sales_income
WHEN NOT MATCHED THEN
    INSERT VALUES (B.work_date, B.store_code, B.sales_income);

MERGE INTO T_COMPANY A
USING T_CLOTH B
ON (A.work_date = B.work_date)
WHEN MATCHED THEN
    UPDATE SET A.sales_income = B.sales_income
WHEN NOT MATCHED THEN
    INSERT VALUES (B.work_date, B.store_code, B.sales_income);


--날짜 1개 기준으로 처리 -> 동일 날짜 겹침으로 데이터가 덮어쓰기 -> 정확한 병합이 불가능
--날짜 + 매장코드 -> 2개를 병합기준

select * from T_COMPANY;

MERGE INTO T_COMPANY A
USING T_SHOE B
ON (A.work_date = B.work_date AND A.store_code = B.store_code)
WHEN MATCHED THEN
    UPDATE SET A.sales_income = B.sales_income
WHEN NOT MATCHED THEN
    INSERT VALUES (B.work_date, B.store_code, B.sales_income);

MERGE INTO T_COMPANY A
USING T_CLOTH B
ON (A.work_date = B.work_date AND A.store_code = B.store_code)
WHEN MATCHED THEN
    UPDATE SET A.sales_income = B.sales_income
WHEN NOT MATCHED THEN
    INSERT VALUES (B.work_date, B.store_code, B.sales_income);


/**************/
전체 데이터 취합 테이블 T_COMPANY
날짜 + 매장코드 기준 조회

select store_code, SUM(sales_income)
from T_COMPANY
group by store_code;

select work_date, SUM(sales_income)
from T_COMPANY
group by work_date
order by work_date;

--shoe 신발가게 매장 매출만 T_SHOE
select *
from t_company
where store_code IN (
                    select DISTINCT(store_code) 
                    from t_shoe
                    );


--매장 판매유형 구분코드 컬럼 추가한 버전 테이블

CREATE TABLE T_COMPANY_TYPE
(
    work_date DATE,  --영업일
    store_code NUMBER(3),  --매장 고유 코드 (PK)
    sales_income NUMBER(10), --매출금액  
    store_type VARCHAR2(8) --매장 유형 구분코드  'C' 옷가게, 'S' 신발가게
);


MERGE INTO T_COMPANY_TYPE A
USING T_SHOE B
ON (A.work_date = B.work_date AND A.store_code = B.store_code)
WHEN MATCHED THEN
    UPDATE SET A.sales_income = B.sales_income
WHEN NOT MATCHED THEN           --신발 정보 삽입할때, store_type 을 'S' 로 저장 
    INSERT VALUES (B.work_date, B.store_code, B.sales_income, 'S');

MERGE INTO T_COMPANY_TYPE A
USING T_CLOTH B
ON (A.work_date = B.work_date AND A.store_code = B.store_code)
WHEN MATCHED THEN
    UPDATE SET A.sales_income = B.sales_income
WHEN NOT MATCHED THEN
    INSERT VALUES (B.work_date, B.store_code, B.sales_income, 'C');


select *
from T_COMPANY_TYPE
where store_type = 'S';

select store_type, SUM(sales_income)
from T_COMPANY_TYPE
group by store_type;

select store_type, store_code, SUM(sales_income)
from T_COMPANY_TYPE
group by store_type, store_code
order by store_type, store_code;

select store_type, store_code, SUM(sales_income)
from T_COMPANY_TYPE
group by ROLLUP(store_type, store_code);