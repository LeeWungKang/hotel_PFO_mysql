<%@page import="com.sun.jdi.Location"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String errMsg = (String) session.getAttribute("errMsg");
if (errMsg == null)
	errMsg = "";

session.invalidate();

String cookie = "";
Cookie[] cookies = request.getCookies(); //쿠키생성
if (cookies != null && cookies.length > 0)
	for (int i = 0; i < cookies.length; i++) {
		if (cookies[i].getName().equals("cookid")) { //내가 원하는 쿠키명 찾아서 값 저장
	cookie = cookies[i].getValue();
		}
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 팝업 화면</title>
<script type="text/javascript" src="script/loginScript.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<style type="text/css">
* {
	padding: 5px;
}

.table #inputId:focus {
	outline: none;
	border: none;
	box-shadow: 0px -1px 10px -2px rgba(0, 100, 300, 0.7);
}

.table #inputPw:focus {
	outline: none;
	border: none;
	box-shadow: 0px -1px 10px -2px rgba(0, 100, 300, 0.7);
}

.table .logBtn {
	width: 100px;
	height: 40px;
	margin-top: 15px;
	color: #fff;
	background: #004fff;
	font-size: 16px;
	border: none;
	border-radius: 20px;
	box-shadow: 0 4px 16px rgba(0, 79, 255, 0.3);
	transition: 0.3s;
	display: inline-block;
	/* 	left:50%;
	top:50%;
	transform: translate(-50%,-50%); */
}

.table .logBtn:focus {
	outline: 0;
}

.table .logBtn:hover {
	background: rgba(0, 150, 255, 0.8);
	cursor: pointer;
	box-shadow: 0 2px 4px rgba(0, 79, 255, 0.6);
}
</style>


</head>
<body>

	<div align="center" style="margin: auto auto; margin-top: 60px;">
		<h1>로그인</h1>

		<form action="" method="post" name="login_form">
			<table class="table" style="width: 400px;">

				<tr>
					<th>아이디 :</th>
					<td><input type="text" id="inputId" name="id"
						placeholder="아이디를 입력하세요." maxlength="20" value="<%=cookie%>">
						<br> <input type="checkbox" id="cookeyId" name="cookeyId"
						value="1" style="font-size: 0.7em;"> 아이디 기억해두기</td>
				</tr>
				<tr>
					<th>비밀번호 :</th>
					<td><input type="password" id="inputPw" name="pw"
						placeholder="******" maxlength="20" value=""></td>
				</tr>

				<tr>
					<td colspan="2" align="center"><input type="submit"
						value="log_in" onclick="Login(); return false;" class="logBtn">
						<input type="button" value="회원가입" onclick="Sign_Up()"
						class="logBtn"></td>
				</tr>

			</table>
		</form>
		<div>
			<input type="hidden" value="" id="errMsg"> <small
				style="color: red"> <%=errMsg %>
			</small>
		</div>
	</div>

	<script type="text/javascript">

function Login() {
	var id =document.login_form.id.value;
	var pw =document.login_form.pw.value;
	var errMsg = document.getElementById("errMsg").value;
	
	if(id.value=="" || id.length==0){
		alert("아이디를 입력하세요.");
		document.login_form.id.focus();
		return;
	}else if(pw.value=="" || pw.length==0){
		alert("비밀번호를 입력하세요.");
		document.login_form.pw.focus();
		return;
	}else{
	 	alert("잠시만 기다려 주세요.");
	 	window.opener.name = "mainWindow"; // 부모창의 이름 설정
		document.login_form.target = "mainWindow"; // 타켓을 부모창으로 설정
		document.login_form.action="../LoginPro";
		document.login_form.method="post";
		document.login_form.submit();
		self.close();
		
	}
}
function Sign_Up() {  //회원가입 화면으로 이동 > 팝업창은 내린다.
	opener.location.href="../index.jsp?filePath=signUp";
	self.close();
}
</script>
</body>
</html>