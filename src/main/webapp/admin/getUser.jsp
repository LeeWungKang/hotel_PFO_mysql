<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
    int totalCount;
    if (request.getAttribute("totalCount") == null) {	
    	totalCount = 1;
    } else {	totalCount = (Integer) request.getAttribute("totalCount");}
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[admin] 유저 상세 정보</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style type="text/css">
.table .table-dark td {
	text-align: center;
	color: rgba(255, 0, 122, 0.93);
}
</style>
</head>
<body>

	<c:if test="${!role eq'admin' }">
		<c:redirect url="index.jsp" />
	</c:if>

	<div id="containerMypage" align="right"></div>

	<div class="info_Wrap" style="margin-bottom: 100px;">
		<h2>내 정보</h2>
	</div>

	<div class="joinInfoWrap">
		<h3 align="left">:: 가입정보</h3>
		<form action="UserGrade_Update"  method="get">
				<table class="table table-striped">
			<thead class="table-dark" align="right">
				<tr>
					<th>회원 아이디 :</th>
					<td>${uservo.id }</td>
				</tr>
				<tr>
					<th>회원 이름 :</th>
					<td>${uservo.name }</td>
				</tr>
				<tr>
					<th>핸드폰 번호 :</th>
					<td>${uservo.phone }</td>
				</tr>
				<tr>
					<th>가입 날짜 :</th>
					<td>${uservo.joindate }</td>
				</tr>
				<tr>
					<th>이메일 :</th>
					<td>${uservo.email }</td>
				</tr>
				<tr>
					<th>회원등급 :</th>
					<td>
					<input type="text" value="${uservo.grade }" name="grade" 	id="grade"	style="text-align: center; width: 130px; background-color: rgba(255, 255, 0, 0.85);">
							&nbsp;&nbsp;
							<select id="grade_value"   style="padding: 4px; vertical-align: middle; background-color: rgba(154, 153, 154, 0.7);">
									<option value="일반고객" selected="selected">일반고객</option>
									<option value="VIP">VIP</option>
									<option value="STAFF">STAFF</option>
									<option value="1">직접입력</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>role :</th>
					<td>${uservo.role }</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td align="center" colspan="2">
					<input type="submit" value="버튼">
					
					<A href="UserGrade_Update?num=${uservo.id}&grade=${uservo.grade }"> 회원 등급 수정 </A></td>
				</tr>
			</tbody>
			<tfoot>
				<tr></tr>  <!--공란 밑줄  -->
			</tfoot>
		</table>
</form>
	</div>

	<script type="text/javascript">
$('#grade_value').change(function(){ 
	$("#grade_value option:selected").each(function () { 
	if($(this).val()== '1'){ 				  //직접입력일 경우 
		$("#grade").val('');			      //값 초기화 
	}else{ 									  //직접입력이 아닐경우 
	$("#grade").val($(this).text()); 	  //선택값 입력 
	}  
	}); 
});

</script>






	<div class="rsWrap"></div>
	<h3>:: 예약 내역</h3>

	<form action="">
		<table class="table table-dark table-hover">
			<thead>
				<tr>
					<th align="center">예약 총 " <span><%=totalCount %> </span>" 건
					</th>
				</tr>
			</thead>
			<c:choose>
				<c:when test="${rsvoList.size() >0 }">
					<c:forEach items="${rsvoList }" var="rsvo" varStatus="status">
						<tbody class="Tbody">
							<tr align="center">
								<th width="180px;">예약자 아이디</th>
								<th>예약 날짜</th>
								<th colspan="2">체크인 / 체크아웃</th>
								<th>예약한 방</th>
								<th>인원수</th>
								<th>총 가격</th>
								<th style="color: rgba(0, 255, 255, 0.58);">예약상태</th>
							</tr>
							<tr align="center">
								<td>${rsvo.rs_userid }</td>
								<td>${rsvo.rs_date }</td>
								<td colspan="2">${rsvo.rs_checkin}~ ${rsvo.rs_checkout }</td>
								<td>${rsvo.rs_roomname }</td>
								<td>${rsvo.rs_people }</td>
								<td>${rsvo.rs_price }</td>
								<td>${rsvo.rs_state }</td>
							</tr>
						</tbody>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<th>:: 예약 내역이 존재 하지 않습니다. ::</th>
					</tr>
				</c:otherwise>

			</c:choose>
		</table>
	</form>

	<%-- 
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
		 --%>



	<%-- 	<div align="center" class="textBox1">
			<%
				if(rsList.size() == 0 || rsList==null ){
			%>
				<p><B> :: 예약 내역이 존재 하지 않습니다. :: </B></p> 
			<%}else{ %>
				<h5><B> :: 체크인 날짜로부터<span> 3일 이전</span>에는 예약을 취소 하실 수 없습니다. :: </B></h5>
			<%} %>
		</div> --%>





</body>
</html>