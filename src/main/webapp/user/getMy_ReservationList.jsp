<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.company.Vo.reservationVo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
ArrayList<reservationVo> rsList = (ArrayList<reservationVo>) request.getAttribute("rsList");

int pg; // page변수로 현재 페이지 값을 받아서 페이징 처리에 이용..
int totalCount;
if (request.getParameter("page") == null) {
	pg = 1;
} else {	pg = Integer.parseInt(request.getParameter("page"));  }

if (request.getAttribute("totalCount") == null) {	totalCount = 1;
} else {	totalCount = (Integer) request.getAttribute("totalCount");}
// 현재시간 보다 5일전이면 예약취소 불가능 하게 제한 넣어야됨.
Date nowDate = new Date();
			System.out.println(nowDate+"--------nowDate 생성 시간");

SimpleDateFormat sf = new SimpleDateFormat("YYYY-MM-dd");
Calendar cal = Calendar.getInstance();
cal.setTime(nowDate);
cal.add(Calendar.DATE, +3);        //오늘날짜에 제한넣을 3일이라는 수를 넣어서 설정
cal.add(Calendar.DAY_OF_MONTH, -1);      
String ndate = sf.format(cal.getTime()); 
			System.out.println(ndate+":--ndate--------");
%>

 <c:if test="${empty name }">
    	<c:redirect url="index.jsp?filePath=./login_check/Login_main"/>
    </c:if>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 내역</title>
<link rel="stylesheet" href="css/mypageCss.css">
<link	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"	rel="stylesheet">
<style type="text/css">
a {	text-decoration: none;}
</style>

</head>
<body>
		
	<div class="rsWrap">
		<h2>예약 내역</h2>
		
		<form action="">
		<table class="table table-dark table-hover">
			<thead>
				<tr>
					<th align="center">예약 총 " <span> ${totalCount} </span>" 건
					</th>
				</tr>
			</thead>

			<tbody class="Tbody">
				<tr align="center">
					<th width="180px;">예약자 아이디</th>
					<th>예약 날짜</th>
					<th colspan="2">체크인 / 체크아웃</th>
					<th>예약한 방</th>
					<th>인원수</th>
					<th>총 가격</th>
					<th style="color: rgba(255, 255, 255, 0.58); ">예약상태</th>
				</tr>
		<%
			for (int j = 0; j < rsList.size(); j++) {
				reservationVo rsvo = rsList.get(j);
			if(rsvo.getRs_checkin() != null )
		%>
				<tr align="center">
					<td><%=rsvo.getRs_userid()%></td>
					<td style="border-right: 2px solid gray; color: orange;"><%=rsvo.getRs_date()%> <!--체크인시간  --> 
							<input type="hidden" value="<%=rsvo.getRs_checkin()%>" id="rsdate"></td>
					<td colspan="2" style="border-right: 2px solid gray; font-size: 1.3em;"><%=rsvo.getRs_checkin()%>&nbsp; ~ &nbsp;<%=rsvo.getRs_checkout()%></td>
					<td><%=rsvo.getRs_roomname()%></td>
					<td><%=rsvo.getRs_people()%></td>
					<td><%=rsvo.getRs_price()%></td>
					
					<td>
					<!--compareto()  함수는, 앞에변수가 크면 1, 같으면0, 작으면 -1  -->
					<%if (rsvo.getRs_checkin().compareTo(ndate) >=1) {  %>
							<a href="User_rsCencle?delNo=<%=rsvo.getRs_no() %>&&delDate=<%=rsvo.getRs_checkin()%>&&state=예약취소'" > 예약취소가능 </a>
								
					<%}else{%>
							<font> 예약완료 </font>
						<%} %> 
						</td>
				</tr>
				
	<%}%>  <!-- 반복문닫는 괄호 -->
				<tr>
					<td colspan="8">
						<!--오늘날짜  --> <input type="hidden" value="<%=ndate%>"	id="now_date">
					</td>
				</tr>
			</tbody>
		</table>
		
				
		
		</form>
		<div align="center" class="textBox1">
			<%
				if(rsList.size() == 0 || rsList==null ){
			%>
				<p><B> :: 예약 내역이 존재 하지 않습니다. :: </B></p> 
			<%}else{ %>
				<h5><B> :: 체크인 날짜로부터<span> 3일 이전</span>에는 예약을 취소 하실 수 없습니다. :: </B></h5>
			<%} %>
		</div>

		<!-- 페이징  -->
		<div class="pagingBtn" style="width: 100%; margin: auto; text-align: center;">
			<%
			int countList = 5; 				// 한 페이지에 출력될 게시물 수(10개를 기준으로 잡음)
			int countPage = 5; 			// 한 화면에 출력될 페이지 수(통상적으로 10개 페이지를 나오게 함)
			int totalPage = totalCount / countList;

			if (totalCount % countList > 0) {
				totalPage++;
			}
			if (totalPage < pg) {
				pg = totalPage;
			}

			int startPage = ((pg - 1) / 5) * 5 + 1;
			int endPage = startPage + countPage - 1;

			if (endPage > totalPage) {
				endPage = totalPage;
			}
			if (startPage > 1) {
			%>
			<a href="MyRs_List?page=1"> 처음 </a>
			<%
			}
			if (pg > 1) {
			%>
			<a href="MyRs_List?page=<%=pg - 1%>"> 이전 </a>
			<%
			}
			for (int iCount = startPage; iCount <= endPage; iCount++) {
			if (iCount == pg) {
			%>
			<b><%=iCount%></b>&nbsp;

			<%
			} else {
			%>
			<a href="MyRs_List?page=<%=iCount%>"> <%=iCount%>
			</a>&nbsp;
			<%
			}
			}
			if (pg < totalPage) {
			%>

			<a href="MyRs_List?page=${page+2}">다음</a>

			<%
			}
			if (endPage < totalPage) {
			%>
			<a href="MyRs_List?page=<%=totalPage%>">끝</a>

			<%
			}
			%>
		</div>
	</div>





</body>
</html>