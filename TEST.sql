select * from HomeBoard;


select max(seq) from HomeBoard;
select * from (select rownum rnum,A.* from (select * from HomeBoard order by seq desc) A) where rnum between 1 and 10";

select * from (select rownum as rnum,b.* from (select * from HomeBoard order by seq desc) b) where rnum between 1 and 5";


--------------------------------------------------------------------
select boardseq,replyseq,nickname,comments,to_char(regdate,'YYYY-MM-DD HH24:MI:SS') from reply;

select * from HomeUsers;