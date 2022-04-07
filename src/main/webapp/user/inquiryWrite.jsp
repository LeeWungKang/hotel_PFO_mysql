<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
							<title> 고객의 소리 </title>
<link rel=stylesheet href="./css/inquiryCss.css">
</head>

	<c:if test="${empty name} ">
		<c:redirect url="index.jsp?filePath=./login_check/Login_main.jsp" />
	</c:if>



<body>
		<div class="fontBox">
&nbsp;&nbsp;&nbsp; <h3><font size="6">고객의 소리 작성</font> </h3> <br />
		</div>
		
		<div class="imgBox">
			<img alt="" src="./img/munj_inquiry.jpg">
		</div>
		
	<div id="detailcomment">
		호텔 " MUJI " 는 언제나 고객님의 목소리에 귀기울이고 있습니다.<br />
		고객님들의 소중한 충고와 격려, 또는 제안의 말씀을 주시면 더 나은 서비스로 보답하겠습니다.
	</div>
		
		<form action="InquiryPro" name="regForm" method="post">
		<table align="center" class="inquiryDetail" >
			<tr>
				<td id="detail">TITLE</td>
				<td> 
				<input type="hidden" name="b_userid" value="${id}">
				<input type="text" name="b_title" maxlength="30" id="writeTitle" placeholder="문의 내용을 상세히 기재해 주시면 정확한 답변에 도움이 됩니다"/></td>
			</tr>
			<tr>
				<td id="detail">CONTENT</td>
				<td><textarea name="b_content" rows="5" cols="40" id="writeContent" placeholder="불건전한 내용(예: 불충분한 증거/귀책 사유에 대한 개인 음해성 등) 또는 광고성 게시물은 사전 통보 없이 삭제 처리될 수 있습니다."></textarea></td>
			</tr>
			<tr align="center">
				<td colspan="2">
					<input type="submit" id="btn" value="확인" onclick="return boardCheck()" />
					<input type="reset" id="btn" value="취소" />
				</td>
			</tr>
		</table>
	</form>


<script>
function boardCheck(){
	if(document.regForm.b_title.value==""){
		alert("제목을 입력해주시기 바랍니다");
		document.regForm.b_title.focus();
		return false;
	}
	
	if(document.regForm.b_content.value==""){
		alert("내용을 입력해주시기 바랍니다");
		document.regForm.b_content.focus();
		return false;
	}
	return true;
}
</script>

</body>
</html>