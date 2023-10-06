create or replace trigger afterinsertbook
after insert on book for each row
declare
    average number;
begin
    insert into book_log
    values(:new.bookid, :new.bookname, :new.publisher, :new.price);
    dbms_output.put_line('삽입 행을 book_log 테이블에 백업했습니다.');
end;

insert into book values(15, '과학 좋아요', '과학미디어', 25000);
select * from book where bookid=15;