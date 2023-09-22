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

-- ���� ���ڿ��� ���̸� �� 15���� ���ߴµ�, ������ �μ��� �ִ� ���ڿ��� ���ʺ��� ä���.
select lpad('Page 1', 15, '*.') from dual;

-- ���� �̸��� ��ȭ��ȣ�� ����Ͻÿ�.(��, ��ȭ��ȣ�� ���� ���� '����ó ����' ���� ���)
select name �̸�, phone ��ȭ��ȣ from customer;
select name �̸�, nvl(phone, '����ó ����')��ȭ��ȣ from customer;

-- ����Ͽ��� ����, ����ȣ, �̸�, ��ȭ��ȣ�� ���� �θ� ����Ͻÿ�.
select rownum ����, custid, name, phone from customer;
select rownum ����, custid, name, phone from customer
where rownum <= 2;

-- mybook ���̺� ����
create table mybook(
    bookid number not null primary key,
    price number
);

-- ������ �� ����
insert into mybook values(1, 10000);
insert into mybook values(2, 20000);
insert into mybook(bookid) values(3);

/* -- 2. mybook ���̺��� �����ϰ� NULL �� ���� ���� SQL ���� ���Ͻÿ�.
-- (1) ���
select * from mybook;
-- (2) ���
select bookid, nvl(price, 0) from mybook;
-- (3) ���
select * from mybook where price is NULL;
-- (4) ���
select * from mybook where price=";
-- (5) ���
select bookid, price+100 from mybook;
-- (6) ���
select num(price), avg(price), count(*)
from mybook where bookid >= 4;
-- (7) ���
select count(*), count(price) from mybook;
-- (8) ���
select sum(price), avg(price) from mybook; */

-- 3. ROWNUM �� ���� ���� SQL ���� ���Ͻÿ�. �����ʹ� ���缭�� �����ͺ��̽��� �̿�
select * from book;
select * from book where rownum <= 5;
select * from book where rownum <= 5 order by price;
select * from (select * from book order by price)b where rownum <= 5;
select * from (select * from book where rownum <= 5)b order by price;
select * from (select * from book where rownum <= 5 order by price)b;

-- ����Ǹűݾ� ������ �ֹ��� ���� �ֹ���ȣ�� �Ǹűݾ��� ����Ͻÿ�.
select orderid �ֹ���ȣ, saleprice �Ǹűݾ� from orders;
select avg(saleprice) from orders;

select orderid �ֹ���ȣ, saleprice �Ǹűݾ� from orders
where saleprice <= (select avg(saleprice) from orders);

-- �� ���� ����Ǹűݾ׺��� ū �ݾ��� �ֹ������� ���ؼ��� �ֹ���ȣ, ����ȣ, �Ǹűݾ��� ����Ͻÿ�.
select orderid �ֹ���ȣ, custid ����ȣ, saleprice �Ǹűݾ� from orders;

select orderid �ֹ���ȣ, custid ����ȣ, saleprice �Ǹűݾ� from orders mo
where saleprice > (select avg(saleprice) from orders fo where mo.custid=mo.custid);

-- ���￡ �����ϴ� ������ �Ǹ��� ������ ���Ǹűݾ��� ����Ͻÿ�.
select sum(Saleprice) ���Ǹűݾ� from orders;
-- ���￡ �����ϴ� ����� ����ȣ
select custid from customer
where address like '%����%';

select sum(saleprice) ���Ǹűݾ� from orders
where custid in (select custid from customer
where address like '%����%');

select sum(saleprice) ���Ǹűݾ� from orders
where custid not in (select custid from customer
where address like '%����%');

-- 3�� ���� �ֹ��� ������ �ְ�ݾ׺��� �� ��� ������ ������ �ֹ��� �ֹ���ȣ�� �ݾ��� ����Ͻÿ�.
select orderid �ֹ���ȣ, saleprice �Ǹűݾ� from orders;
select saleprice from orders where custid=3;

select orderid �ֹ���ȣ, saleprice �Ǹűݾ� from orders
where saleprice > all(select saleprice from orders where custid=3);

-- ���￡ �����ϴ� ������ �Ǹ��� ������ ���Ǹž��� ���Ͻÿ�.(��, exists ������ ���)
select sum(saleprice) ���Ǹűݾ� from orders mo
where exists(
    select * from customer c
    where address like '%����%' and mo.custid=c.custid
);

-- ���� �Ǹűݾ��� �հ踦 ����Ͻÿ�.(����ȣ, �Ǹ��հ�)
select custid ����ȣ, sum(saleprice) �Ǹűݾ� from orders
group by custid;

-- ���� �Ǹűݾ��� �հ踦 ����Ͻÿ�.(����, �Ǹ��հ�)
select (select name from customer c
        where c.custid=o.custid) ����, sum(saleprice) �Ǹűݾ� from orders o
group by o.custid;

-- �ֹ���Ͽ� å�̸��� ������ �� �ִ� �÷��� �߰��Ͻÿ�.
alter table orders add bookname varchar2(40);

update orders o set bookname = (select bookname from book b where b.bookid=o.bookid);

-- ����ȣ�� 2 ������ ����ȣ�� �̸��� ����Ͻÿ�.
select custid ����ȣ, name �̸� from customer
where custid <= 2;

-- ����ȣ�� 2 ������ ���� ���Ǹűݾ��� ����Ͻÿ�.(���̸��� ���� �Ǹž� ���)
select name ���̸�, sum(saleprice) ���Ǹűݾ�
from (select custid, name from customer
where custid <= 2);

-- ����ȣ�� 2 ������ ���� ���Ǹűݾ��� ����Ͻÿ�.(���̸��� ���� �Ǹž� ���)
select name ���̸�, sum(saleprice) ���Ǹűݾ�
from customer c, orders o
where c.custid=o.custid;

-- 5. �μ����ǿ� ���� ���� SQL ���� �����غ��� ��¾ ���ǿ� ���� ������ �����Ͻÿ�.
select custid, (select address
from customer c
where c.custid=o.custid)"address", sum(saleprice)"total"
from orders o
group by o.custid;

