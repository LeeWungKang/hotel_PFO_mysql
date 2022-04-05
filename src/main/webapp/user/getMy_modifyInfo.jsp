<%@page import="com.company.Vo.userVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 내정보 수정</title>
<script type="text/javascript" src="script/script.js"></script>
<link rel="stylesheet" href="css/mypageCss.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"crossorigin="anonymous">
<style type="text/css">
 a{
 text-decoration: none;
 }
#container{
padding-top: 20px;
width: 80%;
}
.table-striped{
text-align: center; width: 55%;
}
.table-hover{
width: 55%; box-shadow: 0px 2px 5px silver; text-align: center;
line-height: 40px;
}
</style>
	
</head>
<body>

	<c:if test="${empty name }">
		<c:redirect url="index.jsp?filePath=./login_check/Login_main.jsp"/> 
	</c:if>

	<div id="container" align="center">
		<h2> 기본 내정보</h2>
<table class="table table-striped" >
			<thead class="table-dark">
			 	<tr>
					<th>회원 아이디</th>
					<td>${uservo.id}</td>
				</tr>
				<tr>
					<th>회원 이름</th>
					<td>${uservo.name}</td>
				</tr> 
		 		<tr>
					<th>핸드폰 번호</th>
					<td>${uservo.phone }</td>
				</tr>
				<tr>
					<th>가입 날짜</th>
					<td>${uservo.joindate }</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>${uservo.email }</td>
				</tr> 
			</thead>
	</table>
	
	<div style="height: 100px; width: 30%;"> </div>
	
	<div>
		<h3> < 수정하시고 완료 버튼 눌러 주세요. > </h3>
		<p> * 표시 된것만 수정할 수 있습니다. </p>
	<form action="UserInfo_Update?id=${uservo.id}" method="post" name="modify_Form" onsubmit="return modiCheck();">
	
		<table class="table table-hover" style="margin-top: 0">
  				<tr>
					<th>회원 아이디</th>   <!-- 아이디는 수정안됨.  -->
					<td><input type="text" name="id" value="${uservo.id}" readonly="readonly"></td>
				</tr>
				<tr>
					<th><span class="star">*</span>&nbsp;&nbsp;회원 이름</th>
					<td><input type="text" name="name" value="${uservo.name}"></td>
				</tr> 
				<tr>
					<th><span class="star">*</span>&nbsp;&nbsp;패스 워드</th>
					<td><input type="text" name="pw" min="2" value="${uservo.pw}"></td>
				</tr>
		 		<tr>
					<th><span class="star">*</span>&nbsp;&nbsp;핸드폰 번호</th>
					<td><input type="text" name="phone" value="${uservo.phone}"></td>
				</tr>
				<tr>
					<th><span class="star">*</span>&nbsp;&nbsp;이메일</th>
					<td><input type="text" name="email" value="${uservo.email}"></td>
				</tr> 
				
				<tr>
					<td colspan="3" align="center">
					<div class="wrap">
				<input type="submit" class="button" value="수정완료" onclick="return modiCheck();" formtarget="_parent">
					</div>
					</td>
				</tr>
		</table>
	</form>
	
	</div>
	</div>
	
<script type="text/javascript">

</script>

	
</body>
</html>