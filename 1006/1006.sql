set serveroutput on;
exec interest;

create table book_log(
    bookid_1 number,
    bookname_1 varchar2(40),
    publisher_1 varchar2(40),
    price_1 number
);

-- 8. ���� ���α׷��� ���ν����� �ۼ��ϰ� �����Ͻÿ�. �����ͺ��̽��� ���缭���� �̿��Ѵ�.
-- (1) InsertBook() ���ν����� �����Ͽ� ���� ���� ����ϴ� InsertCustomer() ���ν����� �ۼ��Ͻÿ�.
create or replace procedure InsertCustomer(
    p_custid in number,
    p_name in varchar2,
    p_address in varchar2,
    p_phone in varchar2
)
AS
BEGIN
    insert into customer(custid, name, address, phone)
    values(p_custid, p_name, p_address, p_phone);
END;