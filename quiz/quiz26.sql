--MERGE DATA_1 -> COLC
--MERGE DATA_2 -> COLC
--날짜 기준으로 각 A업체 B업체 여부를 둘다 확인!
--
--외부에서 일일 배치로 전달받아서 DB에 저장하는 데이터가 있다.
--
--A업체에서 받은 데이터는 TABLE_DATA_1 에 저장하고
--B업체에서 받은 데이터는 TABLE_DATA_2 에 저장한다.
--
--각각 저장된 데이터와 들어온 날짜가 저장된다.
--(no순번에 맞춰서 들어오고, 데이터가 들어왔다고 가정한다)

CREATE TABLE TABLE_DATA_1
(
    no number(10),
    create_date DATE
);

CREATE TABLE TABLE_DATA_2
(
    no number(10),
    create_date DATE
);

--이때, A업체 B업체로 부터 각각 들어오기 때문에
--(추후 C, D 업체등 확장 가능)
--언제 들어왔는지 확인목적으로 데이터 취합여부를 체크하는
--TABLE_COLC 를 만들었다.

CREATE TABLE TABLE_COLC
(
    std_date DATE,
    CHECK_DATA1 VARCHAR2(6),
    CHECK_DATA2 VARCHAR2(6)
);

--각 날짜를 기준으로 데이터가 들어왔으면 'Y' 로 아직 안들어왔으면 'N'으로 표기한다.
--CHECK_DATA1 는 A업체에서 들어왔는지 여부
--CHECK_DATA2 는 B업체에서 들어왔는지 여부

INSERT INTO TABLE_DATA_1 VALUES (1, '2023-04-01');
INSERT INTO TABLE_DATA_1 VALUES (2, '2023-04-02');
INSERT INTO TABLE_DATA_1 VALUES (3, '2023-04-03');
INSERT INTO TABLE_DATA_1 VALUES (4, '2023-04-04');

INSERT INTO TABLE_DATA_2 VALUES (1, '2023-04-02');
INSERT INTO TABLE_DATA_2 VALUES (2, '2023-04-03');
INSERT INTO TABLE_DATA_2 VALUES (3, '2023-04-04');
INSERT INTO TABLE_DATA_2 VALUES (4, '2023-04-05');

--각 업체별로 TABLE_COLC에 취합(병합) 하는 쿼리를 작성하세요.
--작성 후 A업체와 B업체의 수신 여부가 취합되야 합니다.

SELECT * FROM TABLE_DATA_1;
SELECT * FROM TABLE_DATA_2;
SELECT * 
FROM TABLE_COLC 
ORDER BY std_date;

MERGE INTO TABLE_COLC C
USING (
    select DISTINCT TRUNC(create_date) AS create_date
    from TABLE_DATA_1
    ) D1
ON (C.std_date = D1.create_date)
WHEN MATCHED THEN
    UPDATE SET C.CHECK_DATA1 = 'Y'
WHEN NOT MATCHED THEN
    INSERT (std_date, CHECK_DATA1, CHECK_DATA2)
    VALUES (D1.create_date, 'Y', 'N');

--------------------
MERGE INTO TABLE_COLC C
USING (
    select DISTINCT TRUNC(create_date) AS create_date
    from TABLE_DATA_2
    ) D2
ON (C.std_date = D2.create_date)
WHEN MATCHED THEN
    UPDATE SET C.CHECK_DATA2 = 'Y'
WHEN NOT MATCHED THEN
    INSERT (std_date, CHECK_DATA1, CHECK_DATA2)
    VALUES (D2.create_date, 'N', 'Y');