package com.company.Vo;

//constraint FK_reservation foreign key(rsroomseq) REFERENCES room(roomseq),
//foreign key(rsuserid) REFERENCES HomeUsers(id)  );

// 디비에 시퀀스 적용해서 예약번호는 1씩 증가하고,예약내역이 삭제되더라도 기존번호 중복없이 올라가도록 함. 
//insert into reservation values( seq_reservation.nextval,'2022/03/12','22/05/06','22/05/07', 2, '스위트룸',1,'lee');


public class reservationVo {

	private int rs_no;
	private String rs_date;          //예약한 날짜
	private String rs_checkin;       //체크인 날짜
	private String rs_checkout;      //체크아웃 날짜
	private int rs_people;           //예약한 인원수
	private String rs_roomname;    //룸이름
	private int rs_roomseq;        //룸테이블에 roomseq <= 외래키로 사용
	private String rs_userid;      //유저테이블에 id <= 외래키로 사용
	private int rs_price;
	private String rs_state;
	
	public String getRs_state() {
		return rs_state;
	}
	public void setRs_state(String rs_state) {
		this.rs_state = rs_state;
	}
	public int getRs_no() {
		return rs_no;
	}
	public void setRs_no(int rs_no) {
		this.rs_no = rs_no;
	}
	public String getRs_date() {
		return rs_date;
	}
	public void setRs_date(String rs_date) {
		this.rs_date = rs_date;
	}
	public String getRs_checkin() {
		return rs_checkin;
	}
	public void setRs_checkin(String rs_checkin) {
		this.rs_checkin = rs_checkin;
	}
	public String getRs_checkout() {
		return rs_checkout;
	}
	public void setRs_checkout(String rs_checkout) {
		this.rs_checkout = rs_checkout;
	}
	public int getRs_people() {
		return rs_people;
	}
	public void setRs_people(int rs_people) {
		this.rs_people = rs_people;
	}
	public String getRs_roomname() {
		return rs_roomname;
	}
	public void setRs_roomname(String rs_roomname) {
		this.rs_roomname = rs_roomname;
	}
	public int getRs_roomseq() {
		return rs_roomseq;
	}
	public void setRs_roomseq(int rs_roomseq) {
		this.rs_roomseq = rs_roomseq;
	}
	public String getRs_userid() {
		return rs_userid;
	}
	public void setRs_userid(String rs_userid) {
		this.rs_userid = rs_userid;
	}
	public int getRs_price() {
		return rs_price;
	}
	public void setRs_price(int rs_price) {
		this.rs_price = rs_price;
	}
	
}
