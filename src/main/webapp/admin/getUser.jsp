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
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"> </script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style type="text/css">
.table .table-dark td {
	text-align: center;
	color: rgba(255, 0, 122, 0.93);
}
.joinInfoWrap{
	width: 100%;
}
.table-striped{
	width: 70%;
}
a{
text-decoration: none;
}
</style>
</head>
<body>

	<c:if test="${!role eq'admin' }">
		<c:redirect url="index.jsp" />
	</c:if>

	<div id="containerMypage" align="right"></div>

	<div class="info_Wrap" style="margin-bottom: 100px;">
		<h2>고객 정보</h2>
	</div>

	<div class="joinInfoWrap">
		<h3 align="left">:: 가입정보</h3>
				<table class="table table-striped" >
			<thead class="table-dark" align="right">
				<tr>
					<th>회원 아이디 :</th>
					<td><input type="hidden" value=" ${uservo.id}"  name="Id"  id="sendID">  ${uservo.id }</td>
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
							<select id="grade_value" name="grade_value"  style="padding: 4px; vertical-align: middle; background-color: rgba(154, 153, 154, 0.7);">
									<option value="일반고객" >일반고객</option>
									<option value="VIP">VIP</option>
									<option value="STAFF">STAFF</option>
									<option value="1">직접입력 </option>
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
					<button type="button" value=""  onclick="GradeUpdate()">등급 변경 </button> 
				<br> <font class="innerText">  </font>
				</tr>
			</tbody>
			<tfoot>
				<tr></tr>  <!--공란 밑줄  -->
			</tfoot>
		</table>
	</div>

	<script type="text/javascript">
function GradeUpdate() {
	var grade = $.trim($("#grade").val());
	var sendID =$.trim($("#sendID").val());
	var innerText = $(".innerText").val()+"";
	if(grade=="" || grade.length==0){
		alert("회원의 등급을 입력하세요.");
		$('#grade').focus();
		return false;
	}
	$.ajax({
		type:"get",
		url: "UserGrade_Update",
		data:{ grade : grade,
			sendID : sendID },
		dataType : "json" ,
		async: true,

		success : function (result) {
			if(result=="1"){
				$(".innerText").html(" ' 등급이 변경 되었습니다. ' ");
				$(".innerText").attr("color","blue");
				return;
			}else{
				alert("수정 오류");
			}
		},
		error : function () {
			alert('서버 오류 전송실패.');
		}
	});
}
	
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

<div class="rsWrap">
	<h3>:: 예약 내역</h3>

	<form action="">
		<table class="table table-dark table-hover">
			<thead>
				<tr>
					<th align="center">예약 총 " <span><%=totalCount %> </span>" 건
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
								<th style="color: rgba(0, 255, 255, 0.58);">예약상태</th>
							</tr>
						</tbody>
			<c:choose>
						<c:when test="${rsvoList.size() >0 }">
							<c:forEach items="${rsvoList }" var="rsvo" varStatus="status">
									<tr align="center">
										<td>${rsvo.rs_userid }</td>
										<td>${rsvo.rs_date }</td>
										<td colspan="2">${rsvo.rs_checkin}~ ${rsvo.rs_checkout }</td>
										<td>${rsvo.rs_roomname }</td>
										<td>${rsvo.rs_people }</td>
										<td>${rsvo.rs_price }</td>
										<td>${rsvo.rs_state }</td>
									</tr>
							</c:forEach>
						</c:when>
				
					<c:otherwise>
						<tr align="center">
							<th colspan="8" >:: 예약 내역이 존재 하지 않습니다. ::</th>
						</tr>
					</c:otherwise>

			</c:choose>
		</table>
	</form>
	</div>
		<div style=" width:100%; text-align: center; margin-top: 100px;"><a href="Admin_UserInfoPro">< 이전페이지 </a> </div>
</body>
</html>