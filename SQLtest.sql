drop table HomeBoard;

create table HomeBoard(
seq number(5) primary key,     --게시물 번호  	
nickname varchar2(20) not null,	
title varchar2(200) not null,   --게시물 제목  			
content varchar2(3000) not null, --본문
regdate date default sysdate, 	--게시물 쓴 날짜	
cnt number(5) default 0,		--게시물 조회수
userid varchar2(15) 					 
);

ALTER TABLE HomeBoard ADD     --ALTER TABLE [FK를 생성시킬 테이블명] 
CONSTRAINT FK_HomeBoard foreign KEY (userid) references HomeUsers(id); 

select * from HomeBoard;

insert into HomeBoard values(1,'김돌이','문의','견적문의합니다.','2022/02/28',0,'kim');
insert into HomeBoard values(2,'이순','환불','환불 문의합니다.','2022/02/07',0,'lee');

insert into HomeBoard values(3,'지지','환불',' 문의합니다.','2022/02/11',0,'aaaa');
insert into HomeBoard values(4,'히히','기타','기타 문의합니다.','2022/02/05',0,'aaaa');
insert into HomeBoard values(5,'치치','기타',' 기타 질문 ','2022/02/02',0,'bbbbb');
insert into HomeBoard values(6,'디디','기타','질문 문의합니다.','2022/02/03',0,'123123');
insert into HomeBoard values(7,'비비','문의',' 문의합니다.','2022/01/17',0,'123123');
insert into HomeBoard values(8,'스스','문의',' 문의합니다.','2022/01/27',0,'123');
insert into HomeBoard values(9,'키키','환불','환불 문의합니다.','2022/01/09',0,'kkk');

insert into HomeBoard (seq,nickname,title,content,regdate,cnt,userid) values( (select nvl(max(seq),0)+1 from HomeBoard) ,'구군','환불','환불 문의합니다.','2022/01/09',0,'kim');
rt into room(roomseq,roomname,roomsize,price) values((select nvl(max(roomseq),0)+1 from room), '로얄', 8, 200000);

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

select substr(email,1,instr(email,'@')-1) as email_str from HomeUsers;
--  instr(칼럼A ,'찾는문자열B', 시작자릿수m, n번째 문자열B의 자릿수)
--  substr(문자열,자르고싶은 시작수,자르고 싶은 끝 수)

select email from HomeUsers;
select substr(email,1,instr(email,'@')-1) as email_str from HomeUsers where email='kjdndrkd@naver.com';
select substr(email,instr(email,'@')+1) as email_str_last from HomeUsers where email='kjdndrkd@naver.com';



insert into HomeUsers values('lee','lee123','이웅강','010-3312-8325','2021/11/23','kjdndrkd@naver.com','admin');
insert into HomeUsers values('hong','hong123','홍길동','010-1111-1111','2021/12/01','mmmm@naver.com','user');

insert into HomeUsers values('aaaa','aaaa','미미','010-5555-1111','2021/12/01','mmmm@naver.com','user');
insert into HomeUsers values('bbbb','aaaa','토토','010-6666-1111','2021/12/01','mmmm@naver.com','user');


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

select * from reply;

insert into reply values ()

select * from reply where boardseq=9 order by replyseq desc;

select boardseq,replyseq,nickname,comments,to_char(regdate,'YYYY-MM-DD HH24:MI:SS') from reply where boardseq=9 order by replyseq desc;
-- 날자데이터를 문자열로 VO에 저장하고, to_char메소드를 사용해서 현재날자에 현재 시간을 추가함.

--------------------------------------------------------------------------------
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

---시퀀스 sql
--create sequence seq_room
--increment by 1
--START WITH 1;
--
--drop sequence seq_room;
--select * from user_sequences;
update room set roomname='스위트' where roomseq=1;
delete from room where roomseq=2;
insert into room(roomseq,roomname,roomsize,price) values(seq_room.nextval, '스탠다드', 2, 50000);
insert into room(roomseq,roomname,roomsize,price) values(seq_room.nextval, '스위트룸', 2, 70000);
insert into room(roomseq,roomname,roomsize,price) values(seq_room.nextval, '디럭스', 4, 120000);
insert into room(roomseq,roomname,roomsize,price) values(seq_room.nextval, '로얄', 8, 200000);

----------------------------------------------------------------------------------
--예약 데이타
--예약번호,예약날짜,체크인'아웃,인원수,룸이름,룸번호   ++예약한사람 이름이나 아이디
create table reservation (
rs_no number(12) primary key,       		 -- 예약번호
rs_date date default sysdate,       		 -- 예약날짜
rs_checkin varchar2(25) not null,           -- 체크인 날짜
rs_checkout varchar2(25) not null,          -- 체크아웃 날짜
rs_people number(2) not null,               -- 인원수
rs_roomname varchar2(20) not null,        -- 룸 이름
rs_roomseq number(5) not null,            -- room테이블의 roomseq의 외래키 FK 참조무결성(1번방=예약도1번방)
rs_userid varchar2(25) not null,           -- 예약자, 유저 아이디
rs_price number(12) not null
);

ALTER TABLE reservation ADD     --ALTER TABLE [FK를 생성시킬 테이블명] 
CONSTRAINT FK_reservation foreign KEY(rs_roomseq) references room(roomseq); 
--ADD CONSTRAINT [FK명] foreign KEY(FK가 될 컬럼명) references [PK가 위치하는 테이블] ([PK컬럼명]);

ALTER TABLE reservation drop constraint FK_reservation; 
--ALTER TABLE [삭제할 FK위치한 테이블명] drop constraint [삭제할 FK명];




--외래키는 잠시 사용 안함
constraint FK_reservation_rs_roomseq foreign key(rs_roomseq) REFERENCES room(roomseq),
constraint FK_reservation_rs_userid    foreign key(rs_userid) REFERENCES HomeUsers(id)


select * from reservation;
drop table  reservation;

create sequence seq_reservation
increment by 1
start with 1;

select * from user_sequences;
drop sequence seq_reservation;

insert into reservation values(
seq_reservation.nextval,'2022/03/12','22/05/06','22/05/07', 2, '스위트',1,'lee',70000);
insert into reservation values(
seq_reservation.nextval,'2022/03/15','22/05/22','22/05/23', 2, '스위트',1,'lee',70000);
insert into reservation values(
seq_reservation.nextval,'2022/03/10','22/05/15','22/05/16', 2, '스탠다드',2,'hong',45000);

--토탈가격은 결제 시스템 기능구현을 안해서 제외함 
----------------------------------------------------------
--갤러리에 담을, 호텔객실 데이타베이스 필요함