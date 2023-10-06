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