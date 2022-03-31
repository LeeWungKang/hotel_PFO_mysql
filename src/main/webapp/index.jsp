<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <% 
    	String filePath = request.getParameter("filePath");
    if(filePath == null){
    	filePath = "mainSection";
    }
    String name = (String) session.getAttribute("name");
    String role = (String) session.getAttribute("role");
    role = "";
    
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>"MUJI" 호텔 이용고객님 반갑습니다.</title>
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