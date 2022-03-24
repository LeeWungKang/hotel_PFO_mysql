<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String deleteErrMsg =(String)session.getAttribute("deleteErrMsg");
    if(deleteErrMsg == null) deleteErrMsg ="";
    %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 회원 탈퇴 팝업 창</title>
<style type="text/css">
 h1{
 color: orange;
 }
 p{
 font-weight: 800;
 }
 span{
 color: red;
 }
</style>

</head>
<body>

	<div align="center" style="margin: auto auto; margin-top: 80px;">
			<h1> 회원탈퇴 본인 확인 </h1>
			<p>본인 아이디와 비밀번호를 입력하시면 <span>탈퇴처리</span>가 됩니다. </p>
	
	<form action="" method="post" name="deleteForm">
		<table class="table" style="width: 400px;"> 

	<tr>
		<th align="right">아이디 : </th>
		<td><input type="text" id="inputId" name="id" placeholder="본인 아이디를 입력하세요." maxlength="20" value=""> 
	</tr>	
	<tr>
		<th align="right">비밀번호 : </th>
		<td><input type="password" id="inputPw" name="pw" placeholder="******" maxlength="20" value="">  </td>
	</tr>
	
	<tr>  
		<td colspan="2" align="center">   
		<input type="submit" value="탈퇴하기" onclick="Delete(); return false;" class="logBtn" formtarget="_parent">
		<input type="button" value="창 닫기" onclick="Close()" class="logBtn">	
		</td>
	</tr>
	
		</table>
	</form>	
		
		<div >
		<input type="hidden" id="deleteErrMsg">  <small style="color: red"> <%=deleteErrMsg %> </small></div>
		</div>	

	<script type="text/javascript">
	function Delete() {
		var id =document.deleteForm.id.value;
		var pw =document.deleteForm.pw.value;
		var deleteErrMsg = document.getElementById("deleteErrMsg").value;
		
		if(id.value=="" || id.length==0){
			alert("아이디를 입력하세요.");
			document.deleteForm.id.focus();
			return;
		}else if(pw.value=="" || pw.length==0){
			alert("비밀번호를 입력하세요.");
			document.deleteForm.pw.focus();
			return;
		}else{
			document.deleteForm.action="../Mypage_Delete_Info";
			document.deleteForm.method="post";
			document.deleteForm.submit();
		}
	}
	
	function Close() { //팝업창 그냥 내린다.
		self.close();
	}
	</script>



</body>
</html>