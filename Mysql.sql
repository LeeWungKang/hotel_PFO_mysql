drop table HomeBoard;
select * from HomeBoard;

create table HomeBoard(
seq int(5) not null auto_increment,     					
nickname varchar(20) not null,	
title varchar(200) not null,  				 		
content varchar(3000) not null, 				
regdate timestamp default now(), 					
cnt int(5) default 0,							   
userid varchar(15) not null,
	primary key(seq)
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



insert into HomeBoard values(1,'김돌이','문의','견적문의합니다.','2022-01-15',0,'hong');
insert into HomeBoard values(2,'이순','환불','환불 문의합니다.','2022-01-22',0,'lee');
insert into HomeBoard values(3,'지지','환불',' 문의합니다.','2022-02-11',0,'kim');
insert into HomeBoard values(4,'히히','기타','기타 문의합니다.','2022-02-05',0,'aaaa');
insert into HomeBoard values(5,'치치','기타',' 기타 질문 ','2022-02-26',0,'bbbb');
insert into HomeBoard values(default,'치치','기타',' 기타 질문 ','2022-02-26',0,'bbbb');


--게시글 추가 servlet sql
insert into HomeBoard values((select ifnull(seq,default) from HomeBoard),'김길동','환불','환불 문의합니다.','2022-02-07',0,'kim');
insert into HomeBoard (seq,nickname,title,content,regdate,cnt,userid) values( (select ifnull(max(seq),0)+1 from HomeBoard b) ,'구군','환불','환불 문의합니다.','2022-01-09',0,'kim');


----------------------------------------------------------------------------------------------------------------------------------
--유저 계정 디비
drop table HomeUsers;
select * from HomeUsers;

create table HomeUsers( 
id varchar(30) primary key,
pw varchar(30) not null,
name varchar(20) not null,
phone varchar(30) not null,  
joindate timestamp default now(),
email varchar(70),
role varchar(10) default 'user'  
);

--grade 등급 추가
alter table HomeUsers add grade varchar(20) default '일반고객'
update HOMEUSERS set grade='admin' where id='lee'

--유저 리스트 페이징
select * from HomeUsers order by name desc limit 0,10;



select substr(email,1, instr(email,'@')-1) as email_str from HomeUsers;
--  instr(칼럼A ,'찾는문자열B', 시작자릿수m, n번째 문자열B의 자릿수)   == 이메일에서  <'@' 앞자리만 추출 (kjdndrkd)
--  substr(문자열,자르고싶은 시작수,자르고 싶은 끝 수)

select email from HomeUsers;
select substr(email,1,instr(email,'@')-1) as email_str from HomeUsers where email='kjdndrkd@naver.com';   --앞자리 추출
select substr(email,instr(email,'@')+1) as email_str_last from HomeUsers where email='kjdndrkd@naver.com';    --뒷자리 추출


insert into HomeUsers values('lee','lee123','이웅강','010-3312-8325','2021-11-23','kjdndrkd@naver.com','admin','admin');
insert into HomeUsers values('hong','hong123','홍길동','010-1111-1111','2021-12-01','mmmm@naver.com','user','일반고객');
insert into HomeUsers values('kim','kim123','김길동','010-3331-5511','2022-03-20','mewq@naver.com','user','일반고객');
insert into HomeUsers values('aaaa','aaaa','미미','010-5555-1111','2021-12-01','mmmm@naver.com','user','일반고객');
insert into HomeUsers values('bbbb','aaaa','토토','010-6666-1111','2021-12-01','mmmm@naver.com','user','일반고객');

----------------------------------------------------------------------------------------
--댓글 데이터
drop table reply;
select * from reply;

create table reply ( 
boardseq int(5) not null,         
replyseq int(5) not null,       
nickname varchar(30) not null,
comments varchar(2000) not null,
regdate timestamp default now(),
primary key (replyseq, boardseq)       
);

--제약조건 , 기본 테이블에 alter로 접근해서 제약조건을 추가하는 방법.
--부모테이블인 board의 seq를 댓글테이블의 boardseq를 >외래키로 설정하고, 
-- 'cascade delete' 기능을 부여해서 삭제시 같이 삭제되게 함.
alter table reply add constraint reply_fk 
foreign key (boardseq) 
references HomeBoard(seq) 
on delete cascade;


select * from reply order by regdate desc;     --최신날자순 검색
select * from reply where boardseq=9 order by replyseq desc;

select boardseq,replyseq,nickname,comments,date_format(regdate,'%Y-%M-%D %H24: %I: %S') from reply where boardseq=6 order by replyseq desc;
-- 날자데이터를 문자열로 VO에 저장하고, to_char메소드를 사용해서 현재날자에 현재 시간을 추가함.
select boardseq,replyseq,nickname,comments,date_format(regdate,'%Y-%m-%d %H: %i: %s') from reply where boardseq=1 order by replyseq desc;
------------------------------------------------------------------------------------------------
--호텔 객실 데이타
create table room (
roomseq int(3) primary key,        
roomname varchar(20) not null,       
roomsize int(3)not null,		
price int(8) not null,           
constraint room_roomname_uk unique(roomname)     
);

--  + 룸 갯수 추가해야댐.

select * from room;
select * from room order by roomseq;
drop table room;

insert into room values(1, '스탠다드', 2, 45000);
insert into room(roomseq,roomname,roomsize,price) values((SELECT IFNULL(MAX(roomseq) + 1, 1) from room b), '스위트', 2, 80000);
insert into room(roomseq,roomname,roomsize,price) values((SELECT IFNULL(MAX(roomseq) + 1, 1) from room b), '디럭스', 4, 130000);
insert into room(roomseq,roomname,roomsize,price) values((SELECT IFNULL(MAX(roomseq) + 1, 1) from room b), '로얄', 8, 200000);

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
rs_no int(12) primary key auto_increment,       		
rs_date timestamp default now(),       		    
rs_checkin varchar(25) not null,             
rs_checkout varchar(25) not null,        
rs_people int(2) not null,                
rs_roomname varchar(20) not null,       
rs_roomseq int(5) not null,              
rs_userid varchar(25) not null,               
rs_price int(12) not null,
rs_state varchar(20) default '예약중'
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
    WHERE date_format(rs_date, '%Y%m%d') > '20220301' and date_format(rs_date, '%Y%m%d') < '20220401';
 
--22년 총 합   
SELECT count(*) as Acount,
		sum(rs_price) as APrice 
	    FROM reservation
	    WHERE date_format(rs_date, '%Y%m') > '202201' and date_format(rs_date, '%Y%m') < '202212';
    
    
-- 한달 매출 , 판매횟수  = 3월인것만
SELECT sum(rs_price) as APrice 
	    FROM reservation
	    WHERE date_format(rs_date, '%Y%m') = '202204';
	    
--월별 총합산 sql 
SELECT date_format(rs_date, '%m'),
sum(rs_price) as APrice
FROM reservation
where  date_format(rs_date, '%m') = '04'
GROUP BY  date_format(rs_date, '%m') order by 1;




-- 룸이름을 그룹으로 정렬한, 가장많은 예약 갯수 sql    
select count(rs_roomname) as maxCount, max(rs_roomname) as maxRoom
from reservation group by rs_roomname;	    


-- mysql로 변경완료한  가장 많이 팔린   룸과, 갯수    
select max(mc) as maxCount,rs_roomname as maxRoom from (select rs_roomname, count(*) as mc from reservation group by rs_roomname) as maxRoom;



--자동 증가 시퀀스 생성  (예약번호에 적용시킴)
create sequence seq_reservation
increment by 1
start with 1;

select * from user_sequences;
drop sequence seq_reservation;



--특정고객이 예약한 룸 리스트 페이징 0~10
select rs_no,date_format(rs_date,'%Y-%m-%d %H: %i: %s') as rs_date,
rs_checkin,rs_checkout,rs_people,rs_roomname,rs_roomseq,rs_userid,rs_price,rs_state
from reservation where rs_userid='aaaa' 
order by rs_no desc limit 0,5;

--예약 리스트
select * from reservation order by rs_no desc limit 0, 5;
-- 아이디 ?  예약리스트
select * from reservation where rs_userid='bbbb' order by rs_no desc limit 0,5;



insert into reservation values(default,'2022-03-28','2022-03-06','2022-03-07', 2, '스위트',1,'bbbb',70000,'예약중');
insert into reservation values(default,'2022-03-15','2022-03-22','2022-03-23', 2, '스위트',1,'bbbb',70000,'예약중');
insert into reservation values(default,'2022-03-10','2022-04-15','2022-04-16', 2, '스탠다드',2,'hong',45000,'예약중');
insert into reservation values(default,'2022-03-25','2022-04-26','2022-04-28', 4, '로얄',2,'aaaa',130000,'예약중');
insert into reservation values(default,'2022-03-25','2022-04-20','2022-04-29', 4, '스탠다드',2,'aaaa',130000,'예약중');
insert into reservation values(default,'2022-04-02','2022-05-05','2022-05-10', 4, '디럭스',2,'aaaa',130000,'예약중');
insert into reservation values(default,'2022-04-24','2022-05-11','2022-05-12', 4, '디럭스',2,'aaaa',130000,'예약중');
insert into reservation values(default,'2022-05-11','2022-05-15','2022-05-17', 4, '디럭스',2,'aaaa',130000,'예약중');



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
b_no int(5) primary key,
b_userid varchar(25) not null,
b_title varchar(25) not null,
b_content varchar(1000) not null,
b_writedate timestamp default now()
);

--유저계정 삭제시, 같이 삭제됨.
ALTER TABLE inquiry ADD     
CONSTRAINT FK_inquiry
foreign KEY (b_userid) 
references HomeUsers(id)
on delete cascade;

insert into inquiry values(1,'aaaa','환불','환불해주세요',now() );
insert into inquiry values( (select ifnull(max(b_no),0)+1 from inquiry b),'aaaa','문의','환불해주세요',now() );
insert into inquiry values( (select ifnull(max(b_no),0)+1 from inquiry b),'bbbb','문의','환불해주세요',now() );
insert into inquiry values( (select ifnull(max(b_no),0)+1 from inquiry b),'bbbb','어쩌구','저쩌구',now() );

insert into inquiry (b_no, b_userid, b_title, b_content, b_writedate) values ( (select nvl(max(b_no),0)+1 from inquiry),'bbbb','제목1','내용추가', sysdate);

--특정유저의 고객의소리 글 리스트
select * from inquiry where b_userid='bbbb' order by b_no desc limit 0,5;

--고객의소리 전체페이징 - 최신날짜순
select * from inquiry order by b_writedate desc limit 0,10;

----------------------------------------------------------------------------------------------------
--고객의소리 관리자 답변 테이블
create table inquiryReply ( 
ir_seq int(5) not null,           
ir_no int(5) not null,				
ir_role varchar(12) default '관리자',     
ir_comments varchar(250) not null,        
ir_regdate timestamp default now(),
primary key (ir_seq, ir_no)         
);

insert into inquiryReply values (1, 1, '관리자', '관리자댓글', now());



--제약조건 , 기본 테이블에 alter로 접근해서 제약조건을 추가하는 방법.
--부모테이블인 보드의 seq를 댓글테이블의 boardseq를 >외래키로 설정하고, 
-- 'cascade delete' 기능을 부여해서, 원본 문의글이 삭제되면 같이 삭제되게 함.
alter table inquiryReply add constraint inquiryReply_FK 
foreign key (ir_no) 
references inquiry(b_no) 
on delete cascade;


--고객응답 답글 리스트 
select ir_seq, ir_no, ir_role, ir_comments ,date_format(ir_regdate,'%Y-%m-%d %H:%i:%s') as ir_regdate
from inquiryReply where ir_seq='1'
order by ir_no desc;

--관리자 답변
insert into inquiryReply (ir_seq, ir_no, ir_comments) values 
(1,  (select ifnull(max(ir_no),0)+1 from inquiryReply b) ,'답변 내용 test');



---검색  sql
select * from (select rownum as rnum,B.* from(
select * from HomeBoard where " + select_type + " like '%'|| ? ||'%' order by seq desc) B) 
where rnum between ? and ?

-- ?  따옴표 제거해야함. 
select * from HomeBoard where " + select_type + " like concat('%', ?, '%') order by seq desc limit 0,5;

select * from HomeBoard where title like concat('%', '문의', '%') order by seq desc limit 0,5;





