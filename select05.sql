/*--------------------------------------*/
타입변환

TO_CHAR     문자로
TO_DATE     날짜로
TO_NUMBER   숫자로

select 2+2 from dual;
select 2+'2' from dual; --자동형변환(묵시적형변환)
select 2 || '2' from dual;
select 2 + TO_NUMBER('2') from dual; --명시적형변환

select
    TO_CHAR(12341),
    TO_CHAR(123.503),
    sysdate,
    to_char(sysdate, 'yyyy'),
    to_char(sysdate, 'yy'),
    to_char(sysdate, 'mm'),
    to_char(sysdate, 'dd'),
    to_char(sysdate, 'yyyymmdd'),
    to_char(sysdate, 'yymmdd'),
    to_char(sysdate, 'yyyy/mm/dd'),
    to_char(sysdate, 'yyyy-mm-dd')
from dual;

--jumin 문자타입 -> SUBSTR
--birthday 날짜타입 -> TO_CHAR
select
    jumin,
    birthday,
    TO_CHAR(birthday, 'YY') 년,
    TO_CHAR(birthday, 'MM') 월,
    TO_CHAR(birthday, 'DD') 일,
    TO_CHAR(birthday, 'YYYY-MM-DD')
from student;

select
    SYSDATE,
    TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'),
    SYSTIMESTAMP,
    TO_CHAR(SYSTIMESTAMP, 'YYYY-MM-DD HH24:MI:SS')
from dual;

select
    to_number('12313'),
    to_number('123.13')
--    to_number('12394adf') 오류 발생
from dual;

select
    to_char(1234,'999999'),
    to_char(1234,'0999999'),
    to_char(1234,'$999999'),
    '$' || 1234,
    to_char(1234,'9999.99'),
    to_char(1234,'999,999,999')

from dual;
    

select
    --'2025-12-02' + 3
    '2025-12-02' || 3,
    to_date('2025-12-02') + 3,
    to_date('2025-12-02') + 5,
    to_date('25/12/02') + 7,
    to_date('20251202') + 9,
    last_day('2024-02-03'),
    last_day( to_date('2024-02-03') ),
    to_date('2025-03-04', 'YYYY-MM-DD'),
    to_date('25/03/04', 'YY/MM/DD'),
    to_date('2025,03,04', 'YYYY,MM,DD')

from dual;
    

select
    '2026-03-23', 
    SUBSTR('2026-03-23', 6 , 2),
    TO_CHAR( TO_DATE('2026-03-23'), 'MM') 월추출
from dual;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    