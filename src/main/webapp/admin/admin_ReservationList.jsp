<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[admin] 모든회원 예약 내역 </title>
</head>
<body>
<%-- 


<div class="rsWrap"></div>
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
/* >>>>>>> caf7925d62cc3f86befdfa887dc1eaf5b76aab03 */
		%>
				<tr align="center">
					<td><%=rsvo.getRs_userid()%></td>
					<td style="border-right: 2px solid gray; color: orange;"><%=rsvo.getRs_date()%> <!--체크인시간  --> 
							<input type="hidden" 	value="<%=rsvo.getRs_checkin()%>" id="rsdate"></td>
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
 --%>


</body>
</html>