drop table HomeBoard;

create table HomeBoard(
seq number(5) primary key,     --게시물 번호  		
title varchar2(200) not null,   --게시물 제목  			
content varchar2(3000) not null, --본문
regdate date default sysdate, 	--게시물 쓴 날짜	
cnt number(5) default 0,		--게시물 조회수
userid varchar2(15) 					 
);

select * from HomeBoard;

insert into HomeBoard values(1,'문의','견적문의합니다.','2022/02/28',0,'kim');
insert into HomeBoard values(2,'환불','환불 문의합니다.','2022/02/07',0,'lee');


------------------------------------------------------------------------------
select * from HomeUsers;

create table HomeUsers( 
id varchar2(30) primary key,
pw varchar2(30) not null,
name varchar2(20) not null,
phone varchar2(30) not null,  
address varchar2(250),            --주소입력에 api로 연동한 주소가 들어가게끔.
joindate date default sysdate,
email varchar2(70),
role varchar2(10) default 'user'    --관리자계정은 ="admin" 따로 디비 설정.
);

insert into HomeUsers values('lee','lee123','이웅강','010-3312-8325','경기도 수원시 팔달구','2021/11/23','kjdndrkd@naver.com','admin');
insert into HomeUsers values('hong','hong123','홍길동','010-1111-1111','경남남도 창원시 디디구','2021/12/01','mmmm@naver.com','user');

insert into HomeUsers values('aaaa','aaaa','미미','010-5555-1111','경기도 안양시 디디구','2021/12/01','mmmm@naver.com','user');
insert into HomeUsers values('bbbb','aaaa','토토','010-6666-1111','경기도 안산시 디디구','2021/12/01','mmmm@naver.com','user');

select * from HomeUsers;


----------------------------------------------------------------------------------
--사용 안함 		
CREATE TABLE HomeZIPCODE(
id varchar2(30) primary key,
ZIPCODE VARCHAR2(7),
SIDO VARCHAR2(4),
GUGUN VARCHAR2(13),
DONG VARCHAR2(24),
RI VARCHAR2(36),
BUNJI VARCHAR2(17),
PRIMARY KEY (ID)
);
