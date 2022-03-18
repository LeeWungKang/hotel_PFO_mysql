package com.company.Vo;

public class replyVo {

	/*
	 * create table reply ( 
	 * replyseq number(5) not null, --답글의 순번 (최신순으로 정렬)
	 * boardseq number(5) not null, --답글이 달리는 게시판의 seq번호 (외래키) 
	 * comments varchar2(2000) not null, 
	 * nickname varchar2(30) not null, 
	 * regdate date default	sysdate, 
	 * primary key (replyseq, boardseq) --제약조건을 2개를 묶어서 기본키로 설정 );
	 */
	private int replyseq;
	private int boardseq;
	private String comments;
	private String nickname;
	private String regdate;    //댓글에 작성시간까지 보여주기위해 String으로 자료형 변환시킴.
	
	
	public int getReplyseq() {
		return replyseq;
	}
	public void setReplyseq(int replyseq) {
		this.replyseq = replyseq;
	}
	public int getBoardseq() {
		return boardseq;
	}
	public void setBoardseq(int boardseq) {
		this.boardseq = boardseq;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
	
	
}
