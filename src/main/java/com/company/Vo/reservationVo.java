package com.company.Vo;

//constraint FK_reservation foreign key(rsroomseq) REFERENCES room(roomseq),
//foreign key(rsuserid) REFERENCES HomeUsers(id)  );

// 디비에 시퀀스 적용해서 예약번호는 1씩 증가하고,예약내역이 삭제되더라도 기존번호 중복없이 올라가도록 함. 
//insert into reservation values( seq_reservation.nextval,'2022/03/12','22/05/06','22/05/07', 2, '스위트룸',1,'lee');


public class reservationVo {

	private int rsno;
	private String rsdate;          //예약한 날짜
	private String checkin;       //체크인 날짜
	private String checkout;      //체크아웃 날짜
	private int people;           //예약한 인원수
	private String rsroomname;    //룸이름
	private int rsroomseq;        //룸테이블에 roomseq <= 외래키로 사용
	private String rsuserid;      //유저테이블에 id <= 외래키로 사용
	
	
	
	public String getRsdate() {
		return rsdate;
	}
	public void setRsdate(String rsdate) {
		this.rsdate = rsdate;
	}
	public String getRsuserid() {
		return rsuserid;
	}
	public void setRsuserid(String rsuserid) {
		this.rsuserid = rsuserid;
	}
	public int getRsno() {
		return rsno;
	}
	public void setRsno(int rsno) {
		this.rsno = rsno;
	}
	public String getCheckin() {
		return checkin;
	}
	public void setCheckin(String checkin) {
		this.checkin = checkin;
	}
	public String getCheckout() {
		return checkout;
	}
	public void setCheckout(String checkout) {
		this.checkout = checkout;
	}
	public int getPeople() {
		return people;
	}
	public void setPeople(int people) {
		this.people = people;
	}
	public String getRsroomname() {
		return rsroomname;
	}
	public void setRsroomname(String rsroomname) {
		this.rsroomname = rsroomname;
	}
	public int getRsroomseq() {
		return rsroomseq;
	}
	public void setRsroomseq(int rsroomseq) {
		this.rsroomseq = rsroomseq;
	}
	
	
	
}
