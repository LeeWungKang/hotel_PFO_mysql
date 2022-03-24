<%@page import="com.company.Vo.userVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	userVo uservo =(userVo) request.getAttribute("uservo");

String role = (String) session.getAttribute("role");
String name = (String) session.getAttribute("name");
String id = (String) session.getAttribute("id");

if (name == null) {
	response.sendRedirect("index.jsp?filePath=./login_check/Login_main.jsp");
	return;
}
%>    
    
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

	<div id="container" align="center">
		<h2> 정보 수정 전 </h2>
<table class="table table-striped" >
			<thead class="table-dark">
			 	<tr>
					<th>회원 아이디</th>
					<td><%=uservo.getId()%></td>
				</tr>
				<tr>
					<th>회원 이름</th>
					<td><%=uservo.getName()%></td>
				</tr> 
		 		<tr>
					<th>핸드폰 번호</th>
					<td><%=uservo.getPhone()%></td>
				</tr>
				<tr>
					<th>가입 날짜</th>
					<td><%=uservo.getJoindate()%></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><%=uservo.getEmail()%></td>
				</tr> 
			</thead>
	</table>
	
	<div style="height: 100px; width: 30%;"> </div>
	
	
		<h3> < 정보 수정 후 > </h3>
		<p> * 표시 된것만 수정할 수 있습니다. </p>
		
	
	<form action="UserInfo_Update?id=<%=uservo.getId()%>" method="post" name="modify-Form">
	
		<table class="table table-hover">
  				<tr>
					<th>회원 아이디</th>   <!-- 아이디는 수정안됨.  -->
					<td><input type="text" name="id" value="<%=uservo.getId()%>" readonly="readonly"></td>
				</tr>
				<tr>
					<th><span class="star">*</span>&nbsp;&nbsp;회원 이름</th>
					<td><input type="text" name="name" value="<%=uservo.getName()%>"></td>
				</tr> 
				<tr>
					<th><span class="star">*</span>&nbsp;&nbsp;패스 워드</th>
					<td><input type="text" name="pw" min="2" value="<%=uservo.getPw()%>"></td>
				</tr>
		 		<tr>
					<th><span class="star">*</span>&nbsp;&nbsp;핸드폰 번호</th>
					<td><input type="text" name="phone" value="<%=uservo.getPhone()%>"></td>
				</tr>
				<tr>
					<th><span class="star">*</span>&nbsp;&nbsp;이메일</th>
					<td><input type="text" name="email" value="<%=uservo.getEmail()%>"></td>
				</tr> 
				
				<tr>
					<td colspan="3" align="center">
					<div class="wrap">
				<input type="submit" class="button" value="수정완료" onclick="modiCheck(); return false;" formtarget="_parent">
					</div>
					</td>
				</tr>
		</table>
	</form>
	</div>
<script type="text/javascript">

function modiCheck() {
	alert("modiCheck");
	var mf= document.modify-Form;
	
	if (mf.pw.value == "" || mf.pw.length == 0) {
		alert("비밀번호를 입력하세요.");
		mf.pw.focus();
		return;
	}
	else if (!mf.name.value) {
		alert("이름을 입력하세요.");
		mf.name.focus();
		return;
	}
	else if (!mf.phone.value) {
		alert("핸드폰 번호를 입력하세요.");
		mf.phone.focus();
		return;
	}
	else if (!mf.email.value) {
		alert("이메일을 입력하세요.");
		mf.email.focus();
		return;
	} else {
		alert("입력을 완료 했습니다.");
/* 		document.modify-Form.submit();
 */		/* document.modiForm.action = "UserInfo_Update?"; */
	}
}

</script>

	
</body>
</html>