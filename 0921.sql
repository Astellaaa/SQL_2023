-- 1. 마당서점에서 다음의 심화된 질문에 대해 SQL문을 작성하시오.
-- (1) 박지성이 구매한 도서의 출판사와 같은 출판사에서 도서를 구매한 고객의 이름
select publisher from customer cs, orders os, book bs
where cs.custid=os.custid and os.bookid=bs.bookid
and name like '박지성';

select name from
customer cs, orders os, book bs
where cs.custid=os.custid and os.bookid=bs.bookid
and name not like '박지성'
and publisher in(
    select publisher from customer cs, orders os, book bs
    where cs.custid=os.custid and os.bookid=bs.bookid
    and name like '박지성'
);

-- (2) 두개 이상의 서로 다른 출판사에서 도서를 구매한 고객의 이름을 출력하시오.
select name from customer cm
where (select count(distinct publisher)from customer c, orders o, book b
where c.custid=o.custid and o.bookid=b.bookid
and name like c.name)>=2;

-- (3) 고객의 30% 이상이 구매한 도서명을 출력하시오.
select bookname from book bm
where (select count(b.bookid) from book b, orders o
        where b.bookid=o.bookid and b.bookid=bm.bookid)
        >= (select count(*) from customer)*0.3;
        
-- (1) 새로운 도서 ('스포츠 세계', '대한미디어', '10,000원')이 마당서점에 입고되었다.
-- 데이터 행을 추가하시오.
-- 만약 삽입이 되지 않는다면 부족한 데이터가 있는지 확인해 본다.
insert into book values(11, '스포츠 세계', '대한미디어', 10000);

-- (2) '데이원' 에서 출판한 도서를 삭제해야 한다.
delete from book
where publisher like '데이원';

-- (3) '해냄' 에서 출판한 도서를 삭제해야 한다.
-- 만약 삭제되지 않는다면 오류메세지를 확인해 보세요.
delete from book
where publisher like '해냄';
-- 결과: 무결성 제약조건이 위배되었습니다- 자식 레코드가 발견되었습니다
-- 따라서, '해냄' 출판사의 도서정보는 삭제할 수 없다.

-- (4) 출판사 '대한미디어' 를 '대한출판사' 로 이름을 변경하시오.
update book set publisher='대한출판사' where publisher like '대한미디어';

-- abs :절대값을 구하는 함수
select abs(-33), abs(33) from dual;

-- 5.657을 소수 첫번째 자리까지 반올림한 값을 구하시오.
select round(5.657, 1) from dual;

-- 고객별 평균 주문금액을 100원 단위로 반올림한 값을 구하시오.
select custid "고객번호", round(avg(saleprice), -2) "평균금액" from orders
group by custid;

-- 도서명에 '과학' 이 포함된 도서를 '수학' 으로 변경하여 출력하시오.
-- 단, 실제 book 테이블의 원본데이터를 변경하지 마시오.
select bookid, replace(bookname, '과학', '수학') bookname, publisher, price from book;
select * from book;

-- 출판사가 '해냄' 인 도서명의 글자수와 바이트수를 출력하시오.
select bookname "도서명", length(bookname) "글자수", lengthb(bookname) "바이트수" from book
where publisher like '해냄';

-- 고객중에서 같은 성씨를 가진 사람이 몇명인지 성씨별 인원수를 출력하시오.
select substr(name, 1, 1) "성씨", count(*) "인원수" from customer
group by substr(name, 1, 1);

-- 서점의 주문확정일은 주문일로부터 10일후이다. 주문번호, 주문일, 주문확정일을 출력하시오.
select orderid 주문번호, orderdate 주문일, orderdate+10 주문확정일 from orders;

-- 2023년 8월 28일에 주문받은 주문번호, 주문일, 고객번호, 도서번호를 모두 출력하시오.
-- 단, 주문일은 "yyyy년 mm월 dd일" 과 같은 format 으로 표시하시오.

select orderid 주문번호, orderdate 주문일, custid 고객번호, bookid 도서번호
from orders
where orderdate=to_date('20230828', 'yyyymmdd');

-- 2023년 8월 28일에 주문받은 주문번호, 주문일, 고객명, 도서명를 모두 출력하시오.
-- 단, 주문일은 "yyyy년 mm월 dd일" 과 같은 format 으로 표시하시오.

select orderid 주문번호, to_char(orderdate, 'yyyy-mm-dd') 주문일, name 고객명, bookname 도서명
from orders o, customer c, book b
where c.custid=o.custid and o.bookid=b.bookid
and orderdate=to_date('20230828', 'yyyymmdd');

-- DB 서버에 설정된 날짜와 시간, 요일을 출력하시오.
-- 실제 반환된 날짜와 형식, 그리고
-- 지정(yyyy/mm/dd dy, hrs:min:sec)한 날짜와 시간 총 2가지를 모두 출력하시오.

select sysdate 원래반환된값, to_char(sysdate, 'yyyy/mm/dd dy hh24:mi:ss') 지정형식날짜및시간 from dual; 