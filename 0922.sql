select abs(-15) from dual;
select ceil(15.7) from dual;
select cos(3.14159) from dual;
select floor(15.7) from dual;
select log(10,100) from dual;
select mod(11,4) from dual;
select power(3,2) from dual;
select round(15.7) from dual;
select sign(-15) from dual;
select trunc(15.7) from dual;
select chr(67) from dual;
select concat('HAPPY','Birthday') from dual;
select lower('Birthday') from dual;
select lpad('Page 1', 15, '*.') from dual;
select ltrim('Page 1','ae') from dual;
select replace('JACK', 'J', 'BL') from dual;
select rpad('Page 1', 15, '*.') from dual;
select rtrim('Page 1', 'ae') from dual;
select substr('ABCDEFG',3,4) from dual;
select trim(LEADING 0 FROM '00AA00') from dual;
select upper('Birthday') from dual;
select ascii('A') from dual;
select instr('CORPORATE FLOOR','OR',3,2) from dual;
select length('Birthday') from dual;
select add_months(TO_DATE('14/05/21', 'yy/mm/dd'),1) from dual;
select last_day(sysdate) from dual;
select next_day(sysdate, 'Thu') from dual;
select round(sysdate) from dual;
select sysdate from dual;
select to_char(sysdate) from dual;
select to_char(123) from dual;
select to_date('12 05 2014', 'DD MM YYYY') from dual;
select to_number('12.3') from dual;
select decode(1,1,'aa','bb') from dual;
select nullif(123,345) from dual;
select nvl(null, 123) from dual;

-- 원본 문자열의 길이를 총 15개로 맞추는데, 마지막 인수에 있는 문자열로 왼쪽부터 채운다.
select lpad('Page 1', 15, '*.') from dual;

-- 고객의 이름과 전화번호를 출력하시오.(단, 전화번호가 없는 고객은 '연락처 없음' 으로 출력)
select name 이름, phone 전화번호 from customer;
select name 이름, nvl(phone, '연락처 없음')전화번호 from customer;

-- 고객목록에서 순번, 고객번호, 이름, 전화번호를 앞의 두명만 출력하시오.
select rownum 순번, custid, name, phone from customer;
select rownum 순번, custid, name, phone from customer
where rownum <= 2;

-- mybook 테이블 생성
create table mybook(
    bookid number not null primary key,
    price number
);

-- 데이터 행 삽입
insert into mybook values(1, 10000);
insert into mybook values(2, 20000);
insert into mybook(bookid) values(3);

/* -- 2. mybook 테이블을 생성하고 NULL 에 관한 다음 SQL 문에 답하시오.
-- (1) 결과
select * from mybook;
-- (2) 결과
select bookid, nvl(price, 0) from mybook;
-- (3) 결과
select * from mybook where price is NULL;
-- (4) 결과
select * from mybook where price=";
-- (5) 결과
select bookid, price+100 from mybook;
-- (6) 결과
select num(price), avg(price), count(*)
from mybook where bookid >= 4;
-- (7) 결과
select count(*), count(price) from mybook;
-- (8) 결과
select sum(price), avg(price) from mybook; */

-- 3. ROWNUM 에 관한 다음 SQL 문에 답하시오. 데이터는 마당서점 데이터베이스를 이용
select * from book;
select * from book where rownum <= 5;
select * from book where rownum <= 5 order by price;
select * from (select * from book order by price)b where rownum <= 5;
select * from (select * from book where rownum <= 5)b order by price;
select * from (select * from book where rownum <= 5 order by price)b;

-- 평균판매금액 이하의 주문에 대해 주문번호와 판매금액을 출력하시오.
select orderid 주문번호, saleprice 판매금액 from orders;
select avg(saleprice) from orders;

select orderid 주문번호, saleprice 판매금액 from orders
where saleprice <= (select avg(saleprice) from orders);

-- 각 고객의 평균판매금액보다 큰 금액의 주문내역에 대해서만 주문번호, 고객번호, 판매금액을 출력하시오.
select orderid 주문번호, custid 고객번호, saleprice 판매금액 from orders;

select orderid 주문번호, custid 고객번호, saleprice 판매금액 from orders mo
where saleprice > (select avg(saleprice) from orders fo where mo.custid=mo.custid);

-- 서울에 거주하는 고객에게 판매한 도서의 총판매금액을 출력하시오.
select sum(Saleprice) 총판매금액 from orders;
-- 서울에 거주하는 사람의 고객번호
select custid from customer
where address like '%서울%';

select sum(saleprice) 총판매금액 from orders
where custid in (select custid from customer
where address like '%서울%');

select sum(saleprice) 총판매금액 from orders
where custid not in (select custid from customer
where address like '%서울%');

-- 3번 고객이 주문한 도서의 최고금액보다 더 비싼 도서를 구입한 주문의 주문번호와 금액을 출력하시오.
select orderid 주문번호, saleprice 판매금액 from orders;
select saleprice from orders where custid=3;

select orderid 주문번호, saleprice 판매금액 from orders
where saleprice > all(select saleprice from orders where custid=3);

-- 서울에 거주하는 고객에게 판매한 도서의 총판매액을 구하시오.(단, exists 연산자 사용)
select sum(saleprice) 총판매금액 from orders mo
where exists(
    select * from customer c
    where address like '%서울%' and mo.custid=c.custid
);

-- 고객별 판매금액의 합계를 출력하시오.(고객번호, 판매합계)
select custid 고객번호, sum(saleprice) 판매금액 from orders
group by custid;

-- 고객별 판매금액의 합계를 출력하시오.(고객명, 판매합계)
select (select name from customer c
        where c.custid=o.custid) 고객명, sum(saleprice) 판매금액 from orders o
group by o.custid;

-- 주문목록에 책이름을 저장할 수 있는 컬럼을 추가하시오.
alter table orders add bookname varchar2(40);

update orders o set bookname = (select bookname from book b where b.bookid=o.bookid);

-- 고객번호가 2 이하인 고객번호와 이름을 출력하시오.
select custid 고객번호, name 이름 from customer
where custid <= 2;

-- 고객번호가 2 이하인 고객의 총판매금액을 출력하시오.(고객이름과 고객별 판매액 출력)
select name 고객이름, sum(saleprice) 총판매금액
from (select custid, name from customer
where custid <= 2);

-- 고객번호가 2 이하인 고객의 총판매금액을 출력하시오.(고객이름과 고객별 판매액 출력)
select name 고객이름, sum(saleprice) 총판매금액
from customer c, orders o
where c.custid=o.custid;

-- 5. 부속질의에 관한 다음 SQL 문을 수행해보고 어쩐 질의에 대한 답인지 설명하시오.
select custid, (select address
from customer c
where c.custid=o.custid)"address", sum(saleprice)"total"
from orders o
group by o.custid;

