<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <% 
    	String filePath = request.getParameter("filePath");
    if(filePath == null){
    	filePath = "mainSection";
    }
    %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>"PEOPLES" 사진관 이용자 + 관리자 페이지</title>
<link href="./css/Design.css" rel="stylesheet">
</head>
<body>
<div id=container>

	<jsp:include page="header.jsp"/>
	
	<!-- 섹션 부분 > 메뉴들 클릭시 화면 전환이 이루어짐  -->
	
	<section id="mainSection">
	<jsp:include page='<%=filePath +".jsp" %>'/>
	</section>
	

	<jsp:include page="footer.jsp"/>

</div>
</body>
</html>