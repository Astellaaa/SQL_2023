-- 집합연산자: 합집합(UNION), 차집합(MINUS), 교집합(INTERSECT)
-- 차집합 연산자 사용
-- 도서를 주문하지 않은 고객의 이름을 쓰시오.
select name from customer;

select distinct custid from orders;

select name from customer
where custid in(select distinct custid from orders);

-- 차집합 연산자를 사용한 경우
select name from customer
minus
select name from customer
where custid in(select distinct custid from orders);

-- 집합자 연산자를 사용하지 않은 경우
select name from customer
where custid not in(select distinct custid from orders);

-- EXISTS: 서브쿼리의 결과가 존재하는 경우에 true
-- 주문이 있는 고객의 이름과 주소를 출력하시오.
-- in 연산자 사용
select name, address from customer
where custid in(select distinct custid from orders);
-- 동등조인과 중복행 제거
select distinct name, address from customer c, orders o
where c.custid = o.custid;
-- Exists 사용
select name, address from customer c
where exists(select * from orders o
                        where c.custid = o.custid);
                        
-- 1. 마당서점의 고객이 요구하는 다음 질문에 대해 SQL문을 작성하시오.
-- (5) 박지성이 구매한 도서의 출판사 수
select c.name, COUNT (*)
from customer c, orders o
where c.custid = o.custid and c.name like '박지성'
group by c.name;
-- (6) 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이


-- (7) 박지성이 구매하지 않은 도서의 이름
select bookname from book
minus
select bookname from book b, customer c, orders o
where
c.custid = o.custid
and o.bookid = b.bookid
and c.name = '박지성';

-- 2. 마당서점의 운영자와 경영자가 요구하는 다음 질문에 대해 SQL문을 작성하시오.
-- (8) 주문하지 않은 고객의 이름(부속질의 사용)
select name 
from customer
where custid not in (select custid from orders);
-- (9) 주문 금액의 총액과 주문의 평균 금액을 구하시오.
select sum(saleprice) as 합계, avg(saleprice) as 평균
from orders;
-- (10) 주문한 고객의 이름과 고객별 구매액의 합을 구하시오.
select customer.name as 이름, sum(orders.saleprice) as 구매액
from orders, customer
where orders.custid = customer.custid
group by customer.name;
-- (11) 주문한 고객의 이름과 고객이 구매한 도서목록
select name as 이름, bookname as 도서명
from book, orders, customer
where orders.bookid = book.bookid and orders.custid = customer.custid;
-- (12) 도서의 가격(Book 테이블)과 판매가격(Orders 테이블)의 차이가 가장 많은 주문
select * from book b, orders o
where b.bookid = o.bookid
and price - saleprice = (select max(price - saleprice)
                            from book sb, orders so
                            where sb.bookid = so.bookid);
-- (13) 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름
-- DDL(Data Defination Language):데이터 정의어
-- create table/alter table/drop table
-- 테이블 생성 연습 1
create table newbook1(
    bookid number,
    bookname varchar2(20),
    publisher varchar2(20),
    price number
);

-- 테이블 생성 연습 2
-- primary key 설정방법
create table newbook2(
    bookid number,
    bookname varchar2(20),
    publisher varchar2(20),
    price number,
    PRIMARY KEY (bookid)
);

-- primary key 설정방법 2
create table newbook3(
    bookid number primary key,
    bookname varchar2(20),
    publisher varchar2(20),
    price number
);

-- bookname 컬럼: null값을 가질 수 없음
-- publisher 컬럼: 동일한 값을 가질 수 없음
-- price 컬럼: 가격이 입력되어 있지 않으면, 기본값을 10,000으로 하고 입력될 때는 1,000 이상으로 함
-- bookname, publisher 컬럼을 복합키로 설정

create table newbook4(
    bookname varchar2(20) not null,
    publisher varchar2(20) unique,
    price number default 10000 check(price > 1000),
    primary key(bookname, publisher)
);