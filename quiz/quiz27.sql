CREATE TABLE product_quiz
(
product_id INTEGER NOT NULL,
product_code VARCHAR(8) NOT NULL,
price INTEGER NOT NULL
);

INSERT INTO product_quiz VALUES (1, 'A1000011', 10000);
INSERT INTO product_quiz VALUES (2, 'A1000045', 9000);
INSERT INTO product_quiz VALUES (3, 'C3000002', 22000);
INSERT INTO product_quiz VALUES (4, 'C3000006', 15000);
INSERT INTO product_quiz VALUES (5, 'C3000010', 30000);
INSERT INTO product_quiz VALUES (6, 'K1000023', 17000);


select * from product_quiz;

select CASE
            WHEN price < 1000 THEN 0
            ELSE TRUNC(price, -4)
        END AS "PRICE_GROUP",
        COUNT(product_id) as "PRODUCTS"
from product_quiz
group by CASE
            WHEN price < 1000 THEN 0
            ELSE TRUNC(price, -4)
        END
order by price_group;






1) 개별적으로 따로 숫자 계산후 합치기

select 0 price_group, COUNT(*) products
from product_quiz
--where price >= 0 AND price < 10000;
where price BETWEEN 0 AND 9999
UNION ALL
select 10000, COUNT(*)
from product_quiz
where price BETWEEN 10000 AND 19999
UNION ALL
select 20000, COUNT(*)
from product_quiz
where price BETWEEN 20000 AND 29999
UNION ALL
select 30000, COUNT(*)
from product_quiz
where price BETWEEN 30000 AND 39999;


2) 가격대 별로 나눠서 그룹지어 갯수세기


2-1) case when 범위 지정

select
    case
        when price BETWEEN 0 AND 9999 THEN 0
        when price BETWEEN 10000 AND 19999 THEN 10000
        when price BETWEEN 20000 AND 29999 THEN 20000
        when price BETWEEN 30000 AND 39999 THEN 30000
    END price_group,
    count(*) products
from product_quiz
group by
    case
        when price BETWEEN 0 AND 9999 THEN 0
        when price BETWEEN 10000 AND 19999 THEN 10000
        when price BETWEEN 20000 AND 29999 THEN 20000
        when price BETWEEN 30000 AND 39999 THEN 30000
    END
order by price_group
;
    
2-2) 가격대별로 정리 + 서브쿼리

select price, count(*)
from (
    select 
        case
            when price BETWEEN 0 AND 9999 THEN 0
            when price BETWEEN 10000 AND 19999 THEN 10000
            when price BETWEEN 20000 AND 29999 THEN 20000
            when price BETWEEN 30000 AND 39999 THEN 30000
        END price
    from product_quiz
)
group by price
order by price;

2-3) 가격대를 뽑을때 만원대 숫자 활용

select 
    price,
    price/10000,
    TRUNC(price/10000),
    TRUNC(price/10000)*10000,
    TRUNC(price, -4)
from product_quiz;


select 
    TRUNC(price/10000)*10000 price_group,
    count(*) products
from product_quiz
group by TRUNC(price/10000)*10000
order by 1;


select price_code*10000 price_group, count(*) products
from (
    select
        product_id,
        product_code,
        price,
        TRUNC(price/10000) price_code
    from product_quiz
)
group by price_code
order by 1;




select price_group, count(*) products
from (
    select
        TRUNC(price, -4) price_group
    from product_quiz
)
group by price_group
order by 1;







