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
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<style type="text/css">
 a{
 text-decoration: none;
 }
#container{
padding-top: 20px;
}
.table-striped{
text-align: center;
width: 35%;
}
.table-striped .table-dark td{
border-left: solid 2px;
}
.table-hover{
width: 35%; 
box-shadow: 0px 2px 5px silver;
text-align: center;
}

table-hover td{
border-left: solid 2px black;
}
.table-hover td input{
	outline-color: #ccc;
	border: 1px solid #eee;
}
.table-hover td input:focus{
    outline: 3px solid rgba(46, 229, 157, 0.4);
	outline-color: invert;    
}

.wrap {
  height: 25%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.wrap .button {
  width: 130px;
  height: 40px;
  font-size: 10px;
  text-transform: uppercase;
  letter-spacing: 2.5px;
  font-weight: 500;
  font-size: 1.2em;
  color: #000;
  background-color: #eee;
  border: none;
  border-radius: 45px;
  box-shadow: 0px 8px 15px rgba(10, 40, 40, 0.2);
  transition: all 0.3s ease 0s;
  cursor: pointer;
  outline: none;
  }

.button:hover {
  background-color: #2EE59D;
  box-shadow: 0px 15px 20px rgba(46, 229, 157, 0.4);
  color: #fff;
  transform: translateY(-7px);
}
</style>	
	
</head>
<body>

	<div id="container" align="center">
		<h2> 내정보 </h2>
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
	
	
		<h3> < 변경 할 정보 작성란 ></h3>
		<p> * 표시 된것만 수정할 수 있습니다. </p>
		
		
	<form action="UserInfo_Update?id=<%=uservo.getId()%>" method="post" name="modiForm" onsubmit="return modify_value()">
	
		<table class="table table-hover" >
  				<tr>
					<th>회원 아이디</th>   <!-- 아이디는 수정안됨.  -->
					<td><input type="text" name="id" value="<%=uservo.getId()%>" readonly="readonly"></td>
				</tr>
				<tr>
					<th>*&nbsp;&nbsp;회원 이름</th>
					<td><input type="text" name="name" value="<%=uservo.getName()%>"></td>
				</tr> 
				<tr>
					<th>*&nbsp;&nbsp;패스 워드</th>
					<td><input type="text" name="pw" min="2" value="<%=uservo.getPw()%>"></td>
				</tr>
		 		<tr>
					<th>*&nbsp;&nbsp;핸드폰 번호</th>
					<td><input type="text" name="phone" value="<%=uservo.getPhone()%>"></td>
				</tr>
				<tr>
					<th>*&nbsp;&nbsp;이메일</th>
					<td><input type="text" name="email" value="<%=uservo.getEmail()%>"></td>
				</tr> 
				
				<tr>
					<td colspan="3" align="center">
					<div class="wrap">
				<input type="submit" class="button" value="수정완료">
					</div>
					</td>
				</tr>
		</table>
	</form>
	
<script type="text/javascript">
function modify_value() {
 	var form = document.modiForm;
	
	if(form.pw.value == "" || form.pw.length == 0 ){
		alert("비밀번호를 입력하세요.");
		form.pw.focus();
		return;
	}
	else if(!form.name.value){
		alert("이름을 입력하세요.");
		form.name.focus();
		return;
	}
	else if(!form.phone.value) ){
		alert("핸드폰 번호를 입력하세요.");
		form.phone.focus();
		return;
	}
	else if(!form.email.value){
		alert("이메일을 입력하세요.");
		form.email.focus();
		return;
	}else{
		document.modiForm.submit();
		document.modiForm.action="UserInfo_Update?id='<%=uservo.getId()%>'";
	}
}
</script>
</div>
	
</body>
</html>