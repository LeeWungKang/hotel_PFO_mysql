<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 로그인 팝업 화면 </title>
</head>
<body>

<div align="center" style="margin: auto auto;">
	<h1> 로그인 </h1>
	<form action="" method="post" name="login_from">
	
	<table class="table" style="width: 400px;"> 
	<tr>
		<th>아이디 : </th>
		<td><input type="text" name="id" placeholder="아이디를 입력하세요." maxlength="20" value="">  </td>
	</tr>	
	<tr>
		<th>비밀번호 : </th>
		<td><input type="password" name="pw" placeholder="******" maxlength="20" value="">  </td>
	</tr>
	
	<tr>  
		<td colspan="2" align="center">   
		<input type="submit" value="log_in" onclick="Login(); return false;">
		<input type="button" value="회원가입" onclick="window.open('../signUpPopup.jsp','signUpPopup','top=170, left=300, width=620, height=700, toolbar=yes, status=yes, menubar=yes')">	
		</td>
	</tr>
	</table>
	
	</form>
</div>	

	<script type="text/javascript">
	function Login() {
		var id =document.login_from.id.value;
		var pw =document.login_from.pw.value;
		
		if(id.value=="" || id.length==0){
			alert("아이디를 입력하세요.");
			document.login_from.id.focus();
			return;
		}else if(pw.value=="" || pw.length==0){
			alert("비밀번호를 입력하세요.");
			document.login_from.pw.focus();
			return;
		}else{
			alert("잠시만 기다려 주세요.");
			document.login_from.method="post";
			document.login_from.action="LoginPro";
			document.login_from.submit();
		}
	}
	
	function Sign_Up() {
		location.href="sign_up.jsp";
	}
	function Sign_Up1() {
		window.open('sign_up.jsp','sign_up','top=20, left=20, width=500, height=600, status=no,toolbar=yes,menubar=yes');
	}
	
	</script>




</body>
</html>