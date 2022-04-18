<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.company.Vo.roomVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
		request.setCharacterEncoding("utf-8");
String name = (String) session.getAttribute("name");
String date = (String) request.getAttribute("date"); 			//(중복날짜확인)켈린더 서블릿 갓다가 다시내려오는 객체
if(date == null) date = "";

String se_roomname =(String) request.getAttribute("se_roomname");  //룸페이지에서 고객이 선택한 룸의 정보
String roomname =(String) session.getAttribute("roomname"); 	 //세션에다 안넣으면 달력에서 매개로 줄때 코드가 꼬임.
	if (name == null) {	 out.print(
		"<script> alert('죄송합니다. 예약은 로그인이 필요합니다.'); location.href='index.jsp?filePath=./login_check/Login_main'  </script>");
		out.close(); return;
}
String overlap = request.getParameter("overlap");
	if (overlap == null) 
		overlap="";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
				<title>예약하기 페이지</title>
<link href="./css/reservationCss.css" rel="stylesheet">
<link rel="stylesheet"	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<link rel="stylesheet"	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js">
<style>
</style>
</head>
<body>
	<!-- 오늘날짜 이전 날짜를 클릭하면 , 서블릿에서  window.history.back(); 시키는 기능 넣어야됨.  -->

	<c:set value="${roomvo }" var="RV" />

	<div class="subText">
		<c:choose>
			<c:when test="${!empty RV }">
				<h2>
					선택하신 "<font style="color: red;"> ${RV.roomname } </font>" 방 ,<br>
					객실이 만석인지 조회 하기위해, 예약 할 날짜를 선택해 주세요.
				</h2>
				<h4>
					<font color="#A8A8A8" size="3"> 예약 목록과 중복되는 방은 선택하실 수 없습니다.
					</font>
				</h4>
				<br>
			</c:when>
			<c:otherwise>
				<h2 align="center">(선택하신 방이 없습니다. 예약 현황표에서 방을 선택해 주세요)</h2>
				<br>
				<a href="RoomInfo?roomseq=1"> 방 선택하러 가기 </a>
			</c:otherwise>

		</c:choose>
	</div>


	<script type="text/javascript">
    var monthName=new Array("1월","2월","3월","4월","5월","6월","7월",
    "8월","9월","10월","11월","12월")
    var monthDays=new Array(31,28,31,30,31,30,31,31,30,31,30,31)
    var now=new Date()
    var nowd=now.getDate()
    var nowm=now.getMonth()
    var nowy=now.getYear()+1900
    
  function showCalendar(day,month,year)
     {
  if ((year%4==0||year%100==0)&&(year%400==0)) monthDays[1]=29; else monthDays[1]=28 //leap year test
  var firstDay=new Date(year,month,1).getDay()
  var calStr="<table border=0 cellpadding=5 cellspacing=1 align=center bgcolor=#CCCCCC class='CALENDAR'>"
  calStr+="<tr bgcolor=white><td colspan=7>"
  calStr+="<table border=0 cellpadding=0 cellspacing=0 align=center width=100%>"
  calStr+="<td><font size='2'><a href='javascript:;' onClick='nowm--; if (nowm<0) { nowy--; nowm=11; } showCalendar(nowd,nowm,nowy)' title='이전 월'><i class='fa-solid fa-reply'></i> </i><i class='fa-solid fa-reply'></i> </i> </a></font></td>"
  calStr+="<td align=center><font size='5' weight='900'>"+monthName[month].toUpperCase()+" "+year+"년</font></td>"
  calStr+="<td align=right><font size='2'><a href='javascript:;'  onClick='nowm++; if (nowm>11) { nowy++; nowm=0; } showCalendar(nowd,nowm,nowy)' title='다음 월'> <i class='fa-solid fa-share'></i> <i class='fa-solid fa-share'></i>   </a></font></td>"
  calStr+="</tr></table>"
  calStr+="</td></tr>" 
  calStr+="<tr class='days' align=center bgcolor='#1DD1AD'>"
  calStr+="<th width='70px;'><font color='red' size='4'>일</font></th>"
  calStr+="<th width='70px;'><font color='white' size='4'>월</font></th>"
  calStr+="<th width='70px;'><font color='white' size='4'>화</font></th>"
  calStr+="<th width='70px;'><font color='white' size='4'>수</font></th>"
  calStr+="<th width='70px;'><font color='white' size='4'>목</font></th>"
  calStr+="<th width='70px;'><font color='white' size='4'>금</font></th>"
  calStr+="<th width='70px;'><font color='blue' size='4'>토</font></th>" 
  calStr+="</tr>" 
  var dayCount=1
  calStr+="<tr bgcolor=white>"
  for (var i=0;i<firstDay;i++) calStr+="<td> "  //공백
  for (var i=0;i<monthDays[month];i++)
  {
 
  if(dayCount==nowd) {
  calStr+="<td align=center bgcolor='#FF7878'>  Today<br>  <font size='5'><b>"  // 오늘 날짜일때 배경색 지정,글자 진하게
  } else {
  calStr+="<td align=center><font size='3'>" 	 // 오늘 날짜가 아닐때 배경색 지정
  }
    calStr+="<a href=CalendarPro?year="        //날자 클릭시 이동하는 부분. <a>
calStr +=year
calStr+="&month="
calStr+=(month+1)
calStr+="&day="
calStr+=dayCount
calStr+="&roomname=<%=roomname%> >" 					// 링크 '지정한 방'매개변수 넣기.
  calStr+=dayCount++
  calStr+="</a>"
  if(dayCount==nowd) {
  calStr+="</b> "; 				// 오늘 날짜일때 글자 진하게
  } else {
  calStr+=""; 					// 오늘 날짜가 글자 진하게 안함
  }
  calStr+="</font>"
   if ((i+firstDay+1)%7==0&&(dayCount<monthDays[month]+1)) calStr+="<tr bgcolor=white>"
  }
  var totCells=firstDay+monthDays[month];
  for (var i=0;i<(totCells>28?(totCells>35?42:35):28)-totCells;i++) calStr+="<td> "
calStr += "</table></form>";
	calendar.innerHTML=calStr;
   }
     
</script>




	<div class="containerBox">

		<div class="calendarWrap">
			<br>
			<font color="#8A8B8B" size="3"> (클릭시 해당 날짜의 예약 현황 페이지로 이동합니다.)
			</font><br>

			<div id="calendar">
				<!--달력 스크립트 // 객체소환  -->
				<script type="text/javascript"> showCalendar(nowd,nowm,nowy);</script>
				<br />
			</div>

		</div>


		<div class="outside_A">
			<p>중복된 날 : ${overlap }</p>
			<br>
			<br> <a href="index.jsp"> 홈으로 이동</a>
		</div>

	</div>
</body>



</html>