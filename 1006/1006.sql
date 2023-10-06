set serveroutput on;
exec interest;

create table book_log(
    bookid_1 number,
    bookname_1 varchar2(40),
    publisher_1 varchar2(40),
    price_1 number
);

-- 8. 다음 프로그램을 프로시저로 작성하고 실행하시오. 데이터베이스는 마당서점을 이용한다.
-- (1) InsertBook() 프로시저를 수정하여 고객을 새로 등록하는 InsertCustomer() 프로시저를 작성하시오.
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