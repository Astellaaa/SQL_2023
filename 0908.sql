-- ���տ�����: ������(UNION), ������(MINUS), ������(INTERSECT)
-- ������ ������ ���
-- ������ �ֹ����� ���� ���� �̸��� ���ÿ�.
select name from customer;

select distinct custid from orders;

select name from customer
where custid in(select distinct custid from orders);

-- ������ �����ڸ� ����� ���
select name from customer
minus
select name from customer
where custid in(select distinct custid from orders);

-- ������ �����ڸ� ������� ���� ���
select name from customer
where custid not in(select distinct custid from orders);

-- EXISTS: ���������� ����� �����ϴ� ��쿡 true
-- �ֹ��� �ִ� ���� �̸��� �ּҸ� ����Ͻÿ�.
-- in ������ ���
select name, address from customer
where custid in(select distinct custid from orders);
-- �������ΰ� �ߺ��� ����
select distinct name, address from customer c, orders o
where c.custid = o.custid;
-- Exists ���
select name, address from customer c
where exists(select * from orders o
                        where c.custid = o.custid);
                        
-- 1. ���缭���� ���� �䱸�ϴ� ���� ������ ���� SQL���� �ۼ��Ͻÿ�.
-- (5) �������� ������ ������ ���ǻ� ��
select c.name, COUNT (*)
from customer c, orders o
where c.custid = o.custid and c.name like '������'
group by c.name;
-- (6) �������� ������ ������ �̸�, ����, ������ �ǸŰ����� ����


-- (7) �������� �������� ���� ������ �̸�
select bookname from book
minus
select bookname from book b, customer c, orders o
where
c.custid = o.custid
and o.bookid = b.bookid
and c.name = '������';

-- 2. ���缭���� ��ڿ� �濵�ڰ� �䱸�ϴ� ���� ������ ���� SQL���� �ۼ��Ͻÿ�.
-- (8) �ֹ����� ���� ���� �̸�(�μ����� ���)
select name 
from customer
where custid not in (select custid from orders);
-- (9) �ֹ� �ݾ��� �Ѿװ� �ֹ��� ��� �ݾ��� ���Ͻÿ�.
select sum(saleprice) as �հ�, avg(saleprice) as ���
from orders;
-- (10) �ֹ��� ���� �̸��� ���� ���ž��� ���� ���Ͻÿ�.
select customer.name as �̸�, sum(orders.saleprice) as ���ž�
from orders, customer
where orders.custid = customer.custid
group by customer.name;
-- (11) �ֹ��� ���� �̸��� ���� ������ �������
select name as �̸�, bookname as ������
from book, orders, customer
where orders.bookid = book.bookid and orders.custid = customer.custid;
-- (12) ������ ����(Book ���̺�)�� �ǸŰ���(Orders ���̺�)�� ���̰� ���� ���� �ֹ�
select * from book b, orders o
where b.bookid = o.bookid
and price - saleprice = (select max(price - saleprice)
                            from book sb, orders so
                            where sb.bookid = so.bookid);
-- (13) ������ �Ǹž� ��պ��� �ڽ��� ���ž� ����� �� ���� ���� �̸�
-- DDL(Data Defination Language):������ ���Ǿ�
-- create table/alter table/drop table
-- ���̺� ���� ���� 1
create table newbook1(
    bookid number,
    bookname varchar2(20),
    publisher varchar2(20),
    price number
);

-- ���̺� ���� ���� 2
-- primary key �������
create table newbook2(
    bookid number,
    bookname varchar2(20),
    publisher varchar2(20),
    price number,
    PRIMARY KEY (bookid)
);

-- primary key ������� 2
create table newbook3(
    bookid number primary key,
    bookname varchar2(20),
    publisher varchar2(20),
    price number
);

-- bookname �÷�: null���� ���� �� ����
-- publisher �÷�: ������ ���� ���� �� ����
-- price �÷�: ������ �ԷµǾ� ���� ������, �⺻���� 10,000���� �ϰ� �Էµ� ���� 1,000 �̻����� ��
-- bookname, publisher �÷��� ����Ű�� ����

create table newbook4(
    bookname varchar2(20) not null,
    publisher varchar2(20) unique,
    price number default 10000 check(price > 1000),
    primary key(bookname, publisher)
);