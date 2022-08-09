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

<link rel="stylesheet" href="./css/FormDesign.css">
<link	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

	<div align="center" style="margin: auto auto; margin-top: 150px;">

		<h1>로그인</h1>

		<form action="" method="post" name="login_form">
			<table class="table" style="width: 400px;">

				<tr>
					<th>아이디 :</th>
					<td><input type="text" id="inputId" name="id"
						placeholder="아이디를 입력하세요." maxlength="20" value="<%=cookie%>">
						<br>
					<input type="checkbox" id="cookeyId" name="cookeyId" value="1"
						style="font-size: 0.7em;"> 아이디 기억해두기</td>
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
				
				<tr>
			<th> 테스트 접속 아이디<th>
			</tr>
			<tr>
				<td>관리자 : lee   </td>
				<td>암호 : lee123 </td>
			</tr>
			<tr>
			<td>손님 : aaaa </td>
			<td>암호 : aaaa </td>
			</tr>

			</table>
		</form>
		<div>
			<input type="hidden" value="" id="errMsg"> <small
				style="color: red"> <%=errMsg %>
			</small>
		</div>
	</div>
	

</body>
</html>