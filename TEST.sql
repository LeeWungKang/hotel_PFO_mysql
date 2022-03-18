select * from HomeBoard;


select max(seq) from HomeBoard;
select * from (select rownum rnum,A.* from (select * from HomeBoard order by seq desc) A) where rnum between 1 and 10";

select * from (select rownum as rnum,b.* from (select * from HomeBoard order by seq desc) b) where rnum between 1 and 5";


--------------------------------------------------------------------
select boardseq,replyseq,nickname,comments,to_char(regdate,'YYYY-MM-DD HH24:MI:SS') from reply;

select * from HomeUsers;



-- 예약 데이터 조회 sql  "pstmt.setString(1, id);"
select rs_roomname,R.* from reservation R 
left outer join HomeUsers U 
on R.rs_userid = U.id          --유저테이블 id = 예약테이블 예약id가 같은지.
left outer join room RM 
on R.rs_roomseq = RM.roomseq 
where rs_userid = 'lee' 
order by rs_no desc;


--룸번호가 ? 번인 테이블중 예약날짜가 3월1일~ 3월19일인 테이블의 개수 
SELECT COUNT(*) FROM reservation 
WHERE rs_roomseq = 1 
AND TO_CHAR(rs_date,'YYYY-MM-DD') 
BETWEEN '2022-03-01' AND '2022-03-19';


--방의 개수를 알아보는 sql  (roomname=?)
select count(*)  from room where roomname = '스위트';


