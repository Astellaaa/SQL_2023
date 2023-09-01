-- book ���̺��� �����Ͻÿ�.
select * from book;

-- book ���̺��� �����̶�� ���ڿ��� �����ϰ� ���������� 7,000�� �̻��� ������ ���� �˻��Ͻÿ�.
select * from book where bookname like '%����%' and price >=7000;

-- book���̺��� ���ǻ簡 �½����� �Ǵ� ��ũ�ν��� ������ �˻��Ͻÿ�.
select * from book where publisher='�½�����' or publisher='��ũ�ν�';

-- book ���̺��� ���ǻ簡 �½�����, ��ũ�ν��� å�� �˻��Ͻÿ�.(in ������ ���)
select * from book
        where publisher in ('�½�����', '��ũ�ν�');

-- book ���̺��� ����������� �˻��Ͻÿ�.
select * from book order by bookname;

-- book ���̺��� ������ȣ������ �˻��Ͻÿ�.
select * from book order by bookid;

-- book ���̺��� ���ݼ����� �˻��ϰ�, ���� �����̸� �̸������� �˻��Ͻÿ�.
select * from book order by price, bookname;

-- book ���̺��� ������ ������������ �˻��ϰ�, ���� �����̸� ���ǻ縦 ������������ �˻��Ͻÿ�.
select * from book order by price desc, publisher asc;

select * from orders;
-- orders ���̺��� ���� �ֹ��� ������ �� �Ǹž��� ���Ͻÿ�.
-- �����Լ� ���(�հ�: sum)
select sum(saleprice) as ���Ǹűݾ� from orders;

-- orders ���̺��� ����ȣ�� 1�� ���� �ֹ��� ������ ���Ǹž��� ���Ͻÿ�.
select sum(saleprice) as ���Ǹűݾ� from orders
                                    where custid=1;
                                    
-- orders ���̺��� �Ǹž��� �հ�, ���, �ּҰ�, �ִ밪�� ���Ͻÿ�.
select sum(saleprice) as ���Ǹűݾ�,
    avg(saleprice) as �Ǹž����,
    min(saleprice) as ��������,
    max(saleprice) as �ִ밡��
from orders;

-- orders ���̺��� �Ǹ��� ������ ������ ���Ͻÿ�.
select count(*) from orders;
-- orders ���̺��� ���������� 13,000�� �̻��� ������ ������ ���Ͻÿ�.
select count(*) from orders where saleprice >= 13000;
-- orders ���̺��� ����ȣ�� 1 �Ǵ� 3�� ���� �ֹ� ������ ���Ͻÿ�.
select count(*) from orders where custid in(1, 3);

-- orders ���̺��� �� �� �ֹ��� ������ ������ �� �հ踦 ���Ͻÿ�.
-- �׷�ȭ(�κ���): group by
select count(*) �ֹ�����, sum(saleprice) �ֹ��Ѿ� from orders
    group by custid
    order by custid;
-- orders ���̺��� �ǸŰ����� 8,000�� �̻��� ������ ������ ���� ���� 
-- ���� �ֹ� ������ �� ������ ���Ͻÿ�.
select custid, count(*) as �������� from orders
where saleprice >= 8000
group by custid
having count(*) >= 2
order by custid;

-- 1. ���缭���� ���� �䱸�ϴ� ���� ������ ���� SQL ���� �ۼ��Ͻÿ�.

-- (1) ������ȣ�� 1�� ������ �̸�
select bookname as �����̸� from book where bookid=1;
-- (2) ������ 15,000�� �̻��� ������ �̸�
select bookname as �����̸� from book where price > 15000;
-- (3) �������� �� ���ž�(����ȣ�� 1������ ���� �ۼ�)
select sum(saleprice) as �ѱ��ž� from orders
                                 where custid=1;
-- (4) �������� ������ ������ ��(����ȣ�� 1������ ���� �ۼ�)
select sum(custid) as �ѵ������� from orders
                                where custid=1;

-- 2. ���缭���� ��ڿ� �濵�ڰ� �䱸�ϴ� ���� ������ ���� SQL ���� �ۼ��Ͻÿ�.

-- (1) ���缭�� ������ �� ����
select count(*) as �ѵ������� from book;
-- (2) ���缭���� ������ ����ϴ� ���ǻ��� �� ����
select count(distinct publisher) as ���ǻ簳�� from book;
-- (3) ��� ���� �̸��� �ּ�
select name as �̸�, address as �ּ� from customer;
-- (4) 2022�� 10�� 1�� ~ 11�� 30�� ���̿� �ֹ����� ������ �ֹ���ȣ
select orderid as �ֹ���ȣ from orders where orderdate 
                            between '2022-10-01'
                            and '2022-11-30';
-- (5) 2022�� 10�� 1�� ~ 11�� 30�� ���̿� �ֹ����� ������ ������ ������ �ֹ���ȣ
select orderid as �ֹ���ȣ from orders where orderdate 
                            not between '2022-10-01'
                            and '2022-11-30';
-- (6) ���� '��' ���� ���� �̸��� �ּ�
select name as �̸�, address as �ּ� from customer
                        where name like '��__%';
                        
-- (7) ���� '��' ���̰� �̸��� '��' �� ������ ���� �̸��� �ּ�
select name as �̸�, address as �ּ� from customer
                        where name like '��_��%';