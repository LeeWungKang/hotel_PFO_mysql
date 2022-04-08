<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
       <% 
        response.setContentType("text/html;charset=utf-8");
        
    int pg;  // page변수로 현재 페이지 값을 받아서 페이징 처리에 이용..
    int totalCount;
    if(request.getParameter("page")==null){
    	pg=1;
    }else{
    	pg=Integer.parseInt(request.getParameter("page")); 
    }
    if(request.getAttribute("totalRows")==null){
    	totalCount=1;
    }else{
    	totalCount= (Integer)request.getAttribute("totalRows");
    }
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
			<title> 고객의 소리 관리자 페이지</title>
			<link href="./css/inquiryCss.css" rel="stylesheet">
</head>
<body>

	<div id="reserveTitle"> <font size="8">:: 고객의 소리 </font></div>
	
	<div class="tableBox">
	<table align="center" class="reserveInfo">
		<tr align="center" id="list">
			<td>NO</td>
			<td>작성자</td>
			<td>제목</td>
			<td>내용</td>
			<td>작성일 </td>
		</tr>
		
		<c:choose>
			<c:when test="${iqvo.size() >0 }">
				<c:forEach var="b" items="${iqvo }">
					<tr align="center">
						<td>${b.b_no }</td>
						<td>${b.b_userid}</td>
						<td><a href="admin_GetInquiryDetail?num=${b.b_no}"><b>${ b.b_title}</b></a></td>
						<td>${b.b_content}</td>
						<td>${b.b_writedate}</td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td colspan="4" align="center">작성된 글이 없습니다</td>
				</tr>
			</c:otherwise>
		</c:choose>
		
	</table>
	<br><br>
	</div>
		<div style="margin: auto;text-align: center;">
	
	<%
    int countList = 10;			 
    int countPage = 10; 		
    int totalPage = totalCount / countList; 
    if (totalCount % countList > 0) {
        totalPage++;
     }
    if (totalPage < pg) {
        pg = totalPage;
     }
    int startPage = ((pg - 1) / 10) * 10 + 1;
    int endPage = startPage + countPage - 1;
    if (endPage > totalPage) {
        endPage = totalPage;
     }
    if (startPage > 1) {%>
       <a href="Admin_InquiryPro?page=1"> 처음 </a>
    <% }
    if (pg > 1) { %>
        <a href="Admin_InquiryPro?page=<%=pg-1 %>"> 이전 </a>
    <% }
    for (int iCount = startPage; iCount <= endPage; iCount++) {
        if (iCount == pg) { %>
          <b><%=iCount %></b>&nbsp;
    <%} else {%>
          <a href="Admin_InquiryPro?page=<%=iCount %>"> <%=iCount %> </a>&nbsp;
        <%} }  if (pg < totalPage) { %>
       <a href="Admin_InquiryPro?page=<%=pg+1 %>" >다음</a>
    <%} if (endPage < totalPage) { %>
        <a href="Admin_InquiryPro?page=<%=totalPage %>">끝</a>
    <%}%>
    		</div>





</body>
</html>