-- 도서정보 Book 테이블
create table Book(
  bookid NUMBER(2) primary key,
  bookname VARCHAR2(50),
  publisher VARCHAR2(50),
  price NUMBER(8)
);
--수입도서정보 Imported_Book 테이블
create table Imported_Book(
    bookid NUMBER(2),
    bookname VARCHAR2(50),
    publisher VARCHAR2(40),
    price NUMBER(8)
);
-- 고객정보 Customer 테이블
create table Customer(
    custid NUMBER(2) PRIMARY KEY,
    name VARCHAR2(40),
    address VARCHAR2(50),
    phone VARCHAR(20)
);
-- 주문정보 Orders 테이블
create table Orders(
    orderid NUMBER(2) PRIMARY KEY,
    custid NUMBER(2) REFERENCES Customer(custid),
    bookid NUMBER(2) REFERENCES Book(bookid),
    saleprice NUMBER(8),
    orderdate DATE
);
--Book 테이블에 10권의 도서 정보를 추가하세요
insert into Book values(1,'축구의 역사','굿스포츠',7000);
insert into Book values(2,'해리포터 죽음의 성물','좋은책',17000);
insert into Book values(3,'나무','해냄',12000);
insert into Book values(4,' 1%를 읽는 힘','토네이도',7000);
insert into Book values(5,' 아메리칸 프로메테우스','사이언스북스',16000);
insert into Book values(6,'이토록 공부가 재미있어지는','다산북스',19000);
insert into Book values(7,'세이노의 가르침','데이원',21000);
insert into Book values(8,'도둑맞은 집중력','어크로스',13000);

-- Customer 테이블에 고객정보 5명 추가
insert into customer values(1, '박지성', '영국 맨체스터', '000-5000-001');
insert into customer values(2, '김연아', '서울 동작구 흑석동', '02-333-5555');
insert into customer values(3, '장미란', '서울 용산구 보광동', '02-555-7777');
insert into customer values(4, '추신수', '인천광역시 연수구', '032-233-5656');
insert into customer values(5, '박세리', '대전광역시 유성구', '042-322-1237');





