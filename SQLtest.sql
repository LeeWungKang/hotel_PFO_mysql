drop table HomeBoard;
select * from HomeBoard;

create table HomeBoard(
seq number(5) primary key,     --게시물 번호  	
nickname varchar2(20) not null,	
title varchar2(200) not null,   --게시물 제목  			
content varchar2(3000) not null, --본문
regdate date default sysdate, 	--게시물 쓴 날짜	
cnt number(5) default 0,		--게시물 조회수
userid varchar2(15) not null					 
);

--ALTER TABLE [FK를 생성시킬 테이블명]  
--게시글은 유저테이블의 기본키를 참조하게하고, 보드의 부모인 유저테이블이 삭제되면, 
--삭제된 유저가 작성한, 게시글도 삭제되개 한다.
ALTER TABLE HomeBoard ADD     
CONSTRAINT FK_HomeBoard 
foreign KEY (userid) 
references HomeUsers(id)
on delete cascade;

--제약조건 삭제 (외래키)
ALTER TABLE HomeBoard DROP constraint FK_HomeBoard; 

--외래키 조회 방법
select * from information_schema.table_constraints where table_name = 'FK_HomeBoard';
select * from USER_CONSTRAINTS



insert into HomeBoard values(1,'김돌이','문의','견적문의합니다.','2022/02/28',0,'hong');
insert into HomeBoard values(2,'이순','환불','환불 문의합니다.','2022/02/07',0,'lee');
insert into HomeBoard values(3,'지지','환불',' 문의합니다.','2022/02/11',0,'kim');
insert into HomeBoard values(4,'히히','기타','기타 문의합니다.','2022/02/05',0,'aaaa');
insert into HomeBoard values(5,'치치','기타',' 기타 질문 ','2022/02/02',0,'bbbb');


--게시글 추가 sql
insert into HomeBoard values((select nvl(max(seq),0)+1 from HomeBoard),'김길동','환불','환불 문의합니다.','2022/02/07',0,'kim');
insert into HomeBoard (seq,nickname,title,content,regdate,cnt,userid) values( (select nvl(max(seq),0)+1 from HomeBoard) ,'구군','환불','환불 문의합니다.','2022/01/09',0,'kim');


------------------------------------------------------------------------------
--유저 계정 디비
drop table HomeUsers;
select * from HomeUsers;

create table HomeUsers( 
id varchar2(30) primary key,
pw varchar2(30) not null,
name varchar2(20) not null,
phone varchar2(30) not null,  
joindate date default sysdate,
email varchar2(70),
role varchar2(10) default 'user'   --관리자계정은 ="admin" 따로 디비 설정.
);

alter table HomeUsers add grade varchar2(20) default '일반고객'
update HOMEUSERS set grade='admin' where id='lee'






select substr(email,1,instr(email,'@')-1) as email_str from HomeUsers;
--  instr(칼럼A ,'찾는문자열B', 시작자릿수m, n번째 문자열B의 자릿수)
--  substr(문자열,자르고싶은 시작수,자르고 싶은 끝 수)

select email from HomeUsers;
select substr(email,1,instr(email,'@')-1) as email_str from HomeUsers where email='kjdndrkd@naver.com';
select substr(email,instr(email,'@')+1) as email_str_last from HomeUsers where email='kjdndrkd@naver.com';


insert into HomeUsers values('lee','lee123','이웅강','010-3312-8325','2021/11/23','kjdndrkd@naver.com','admin','admin');
insert into HomeUsers values('hong','hong123','홍길동','010-1111-1111','2021/12/01','mmmm@naver.com','user','일반고객');
insert into HomeUsers values('kim','kim123','김길동','010-3331-5511','2022/03/20','mewq@naver.com','user','일반고객');
insert into HomeUsers values('aaaa','aaaa','미미','010-5555-1111','2021/12/01','mmmm@naver.com','user','일반고객');
insert into HomeUsers values('bbbb','aaaa','토토','010-6666-1111','2021/12/01','mmmm@naver.com','user','일반고객');

----------------------------------------------------------------------------------------
--댓글 데이터
drop table reply;
select * from reply;

create table reply ( 
boardseq number(5) not null,         --답글이 달리는 게시판의 seq번호 (외래키)
replyseq number(5) not null,         --답글의 순번 (최신순으로 정렬)
nickname varchar2(30) not null,
comments varchar2(2000) not null,
regdate date default sysdate,
primary key (replyseq, boardseq)         --제약조건을 2개를 묶어서 기본키로 설정
);

--제약조건 , 기본 테이블에 alter로 접근해서 제약조건을 추가하는 방법.
--부모테이블인 보드의 seq를 댓글테이블의 boardseq를 >외래키로 설정하고, 


-- 'cascade delete' 기능을 부여해서 삭제시 같이 삭제되게 함.
alter table reply add constraint reply_fk 
foreign key (boardseq) 
references HomeBoard(seq) 
on delete cascade;


select * from reply order by regdate desc;     --최신날자순 검색

select * from reply where boardseq=9 order by replyseq desc;

select boardseq,replyseq,nickname,comments,to_char(regdate,'YYYY-MM-DD HH24:MI:SS') from reply where boardseq=9 order by replyseq desc;
-- 날자데이터를 문자열로 VO에 저장하고, to_char메소드를 사용해서 현재날자에 현재 시간을 추가함.

------------------------------------------------------------------------------------------------
--호텔 객실 데이타
create table room (
roomseq number(3) primary key,        --룸 번호
roomname varchar2(20) not null,       --룸 이름
roomsize number(3)not null,			--룸 크기 (수용인원)
price number(8) not null,           --룸 가격
constraint room_roomname_uk unique(roomname)     --룸 이름은 고유값, 중복 없이
);

--  + 룸 갯수 추가해야댐.

select * from room;
select * from room order by roomseq;
drop table room;

insert into room values(1, '스탠다드', 2, 45000);
insert into room(roomseq,roomname,roomsize,price) values((select nvl(max(roomseq),0)+1 from room), '스위트', 2, 80000);
insert into room(roomseq,roomname,roomsize,price) values((select nvl(max(roomseq),0)+1 from room), '디럭스', 4, 130000);
insert into room(roomseq,roomname,roomsize,price) values((select nvl(max(roomseq),0)+1 from room), '로얄', 8, 200000);

select count(*) from room;
select * from room order by roomseq;
select * from room where roomseq=1;

delete from room where roomseq=2;

-----------------------------------------------------------------------------------------------------
select * from reservation order by rs_no desc;

select * from reservation;
drop table  reservation;
--예약 데이타
--예약번호,예약날짜,체크인'아웃,인원수,룸이름,룸번호   ++예약한사람 이름이나 아이디
create table reservation (
rs_no number(12) primary key,       		 -- 예약번호
rs_date date default sysdate,       		     -- 예약날짜
rs_checkin varchar2(25) not null,             -- 체크인 날짜
rs_checkout varchar2(25) not null,           -- 체크아웃 날짜
rs_people number(2) not null,                -- 인원수
rs_roomname varchar2(20) not null,         -- 룸 이름
rs_roomseq number(5) not null,              -- room테이블의 roomseq의 외래키 FK 참조무결성(1번방=예약도1번방)
rs_userid varchar2(25) not null,               -- 예약자, 유저 아이디
rs_price number(12) not null,
rs_state varchar2(20) default '예약중'
);
alter table reservation add
constraint FK_reservation foreign key(rs_userid) REFERENCES HomeUsers(id)
on delete cascade;

--ALTER TABLE [FK를 생성시킬 테이블명]   seq 외래키는 잠시 사용안함.
ALTER TABLE reservation ADD   
CONSTRAINT FK_reservation_rmseq foreign KEY(rs_roomseq) references room(roomseq); 
--ADD CONSTRAINT [FK명] foreign KEY(FK가 될 컬럼명) references [PK가 위치하는 테이블] ([PK컬럼명]);


--ALTER TABLE [삭제할 FK위치한 테이블명] drop constraint [삭제할 FK명];
ALTER TABLE reservation drop constraint FK_reservation; 
ALTER TABLE reservation drop constraint FK_reservation_rmseq; 




--지정한 방의 예약횟수와 총판매량.
select count(*) as Acount,sum(rs_price) as APrice from reservation where rs_roomname ='스탠다드';
-- 위와 같음
select count(*) as Acount,
		sum(rs_price) as APrice 
		from reservation where rs_roomname ='스탠다드';

		
--지정 날짜에 대한 매출,판매 갯수.
SELECT count(*) as Acount,
		sum(rs_price) as APrice 
    FROM reservation
    WHERE TO_CHAR(rs_date, 'YYYYMMDD') > '20220301' and TO_CHAR(rs_date, 'YYYYMMDD') < '20220401';
 
--22년 총 합   
SELECT count(*) as Acount,
		sum(rs_price) as APrice 
	    FROM reservation
	    WHERE TO_CHAR(rs_date, 'YYYYMM') > '202201' and TO_CHAR(rs_date, 'YYYYMM') < '202212';
    
    
-- 한달 매출 , 판매횟수  = 3월인것만
SELECT sum(rs_price) as APrice 
	    FROM reservation
	    WHERE TO_CHAR(rs_date, 'YYYYmm') = '202205';
	    
--월별 총합산 sql 
SELECT TO_CHAR(rs_date, 'mm'),
sum(rs_price) as APrice
FROM reservation
where  TO_CHAR(rs_date, 'mm') = '03'
GROUP BY  TO_CHAR(rs_date, 'mm') order by 1;

--가장많은 예약방과 갯수 sql
select max(count(rs_roomname)) as maxCount, max(rs_roomname) as maxRoom
from reservation group by rs_roomname;	    
	    
	    
	    
	    
	    
--자동 증가 시퀀스 생성  (예약번호에 적용시킴)
create sequence seq_reservation
increment by 1
start with 1;

select * from user_sequences;
drop sequence seq_reservation;


select rs_no,to_char(rs_date,'YYYY-MM-DD HH24:MI:SS'),rs_checkin,rs_checkout,rs_people,rs_roomname,rs_roomseq,rs_userid,rs_price from reservation where rs_userid= 'aaaa';
select * from (select rownum as rnum,A.* from (select rs_no,to_char(rs_date,'YYYY-MM-DD HH24:MI:SS') as rs_date,rs_checkin,rs_checkout,rs_people,rs_roomname,rs_roomseq,rs_userid,rs_price from reservation where rs_userid='aaaa' order by rs_no desc) A) where rnum between 1 and 5



insert into reservation values(
seq_reservation.nextval,'2022-03-28','2022-05-06','2022-05-07', 2, '스위트',1,'bbbb',70000,'예약중');
insert into reservation values(
seq_reservation.nextval,'2022-03-15','2022-05-22','2022-05-23', 2, '스위트',1,'bbbb',70000,'예약중');
insert into reservation values(
seq_reservation.nextval,'2022-03-10','2022-05-15','2022-05-16', 2, '스탠다드',2,'hong',45000,'예약중');
insert into reservation values(
seq_reservation.nextval,'2022-03-25','2022-03-25','2022-03-26', 4, '디럭스',2,'aaaa',130000,'예약중');
insert into reservation values(
seq_reservation.nextval,'2022-03-25','2022-03-27','2022-03-29', 4, '디럭스',2,'aaaa',130000,'예약중');
insert into reservation values(
seq_reservation.nextval,'2022-03-25','2022-03-27','2022-03-29', 4, '디럭스',2,'aaaa',130000,'예약중');
insert into reservation values(
seq_reservation.nextval,'2022-03-25','2022-05-15','2022-05-17', 4, '디럭스',2,'aaaa',130000,'예약중');
insert into reservation values(
seq_reservation.nextval,'2022-03-25','2022-05-15','2022-05-17', 4, '디럭스',2,'aaaa',130000,'예약중');



select * from reservation order by rs_no desc;
delete from reservation where rs_no=33;

select * from reservation where rs_userid='hong';
update reservation set rs_checkin='2022-05-15', rs_checkout='2022-05-17'  where  rs_userid='hong';

--토탈가격은 결제 시스템 기능구현을 안해서 제외함 
-------------------------------------------------------------------------------------
--갤러리에 담을, 호텔객실 데이타베이스 필요함

select * from inquiry order by b_no desc;
drop table inquiry;
-- 고객의소리 테이블
create table inquiry( 
b_no number(5) primary key,
b_userid varchar2(25) not null,
b_title varchar2(25) not null,
b_content varchar2(1000) not null,
b_writedate date default sysdate
);

--유저계정 삭제시, 같이 삭제됨.
ALTER TABLE inquiry ADD     
CONSTRAINT FK_inquiry
foreign KEY (b_userid) 
references HomeUsers(id)
on delete cascade;

insert into inquiry values(1,'aaaa','환불','환불해주세요',sysdate );
insert into inquiry values( (select nvl(max(b_no),0)+1 from inquiry),'aaaa','문의','환불해주세요',sysdate );
insert into inquiry values( (select nvl(max(b_no),0)+1 from inquiry),'bbbb','문의','환불해주세요',sysdate );
insert into inquiry values( (select nvl(max(b_no),0)+1 from inquiry),'bbbb','어쩌구','저쩌구',sysdate );

insert into inquiry (b_no, b_userid, b_title, b_content, b_writedate) values ( (select nvl(max(b_no),0)+1 from inquiry),'bbbb','제목1','내용추가', sysdate);

select * from (select rownum as b_rnum, A.* from (select * from inquiry where b_userid='bbbb' order by b_no desc) A) where b_rnum between 6-5 and 5;

--고객의소리 페이징 - 최신날짜순
select * from (select rownum rnum,A.* from
(select * from inquiry order by b_writedate desc) A) where rnum between 10-9 and 9;

----------------------------------------------------------------------------------------------------
--고객의소리 관리자 답변 테이블
create table inquiryReply ( 
ir_seq number(5) not null,            --답글이 달리는 문의글번호
ir_no number(5) not null,				--답글의 순번
ir_role varchar2(12) default '관리자',     --답글다는 사람
ir_comments varchar2(250) not null,        --답글 내용
ir_regdate date default sysdate,
primary key (ir_seq, ir_no)         --제약조건 2개를 묶어서 기본키로.
);

insert into inquiryReply values (7, 1, '관리자', '관리자댓글', sysdate);



--제약조건 , 기본 테이블에 alter로 접근해서 제약조건을 추가하는 방법.
--부모테이블인 보드의 seq를 댓글테이블의 boardseq를 >외래키로 설정하고, 
-- 'cascade delete' 기능을 부여해서, 원본 문의글이 삭제되면 같이 삭제되게 함.
alter table inquiryReply add constraint inquiryReply_FK 
foreign key (ir_no) 
references inquiry(b_no) 
on delete cascade;


--고객응답 답글 리스트 
select ir_seq, ir_no, ir_role, ir_comments ,to_char(ir_regdate,'YYYY-MM-DD HH24:MI:SS') as ir_regdate
from inquiryReply where ir_seq='7'
order by ir_no desc;






