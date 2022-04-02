<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
      
        <% 
        response.setContentType("text/html;charset=utf-8");
        
    int pg;  // page변수로 현재 페이지 값을 받아서 페이징 처리에 이용..
    int totalCount;
    // 현재 페이지 변수 받음.
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
					<title>"MUJI" 회원 조회 </title>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"> </script>
<script type="text/javascript" src="./script/script.js"></script>
<link href="https://unpkg.com/bootstrap@3.3.7/dist/css/bootstrap.min.css"rel="stylesheet" >
<style type="text/css">
.selected{
background-color: rgba(255, 226, 41, 0.35);
}

</style>
</head>
<body>
	<c:if test="${empty role and role eq'user'  }">
		<c:redirect url="index.jsp"/>
	</c:if>
	
	
	<div style="width: 90%; margin: auto;">
	
			 <h3>::<B> 회원 리스트</B></h3>
			<form action="" name="userInfoList">
		<table class="table table-light" style="height: auto; margin-top: 60px;">
		<thead>
			<tr>
				<th> 총 "<%=totalCount%>" 명</th>
			</tr>
		</thead>	
		<tbody>
		<tr style="margin: auto auto; ">
			<th scope="col">ID</th>
			<th scope="col">Password</th>
			<th scope="col">Name</th>
			<th scope="col">Phone</th>
			<th scope="col">Joindate</th>
			<th scope="col">Email</th>
			<th scope="col">Grade</th>
			<th scope="col">Expulsion</th>
		</tr>
		<tr>
		<th> ▼ 정보보기 ▼</th>
		<th colspan="6">-</th>
		<th><a href="#" onclick="admin_userchk_Delete()">회원 삭제 </a></th>
		</tr>
		
<c:forEach items="${uvo }" var="uvo"  varStatus="status" >
	<tr>
		<th scope="row">${status.count } . <a href="Get_UserProfile?num=${uvo.id}">  ${uvo.id } </a></th>
		<td>${uvo.pw }  </td>
		<td>${uvo.name } </td>
		<td>${uvo.phone } </td>
		<td>${uvo.joindate } </td>
		<td>${uvo.email } </td>
		<td>${uvo.grade}  </td>
		<td>Check &nbsp;&nbsp;<input type="checkbox" value="${uvo.id}" class="chcBox" name="chcBox"></td>
	
	</tr>
		</c:forEach>
	</tbody>
	</table>
	</form>
	
	<script type="text/javascript">
/* script.js  */
	</script>

	
	
	<div style="margin: auto;text-align: center;">
	
	<%
    int countList = 10;			 // 한 페이지에 출력될 게시물 수(10개를 기준으로 잡음)
    int countPage = 10; 		// 한 화면에 출력될 페이지 수(통상적으로 10개 페이지를 나오게 함)
    int totalPage = totalCount / countList; // totalPage는 전체 페이지 수 (전체 게시물 / 한 페이지에 출력될 게시물 수)
    if (totalCount % countList > 0) {// totalCount를 countList로 나눈 나머지 값이 존재한다는 것은 한 페이지가 더 있다는 의미이다.
        totalPage++;
     }
    if (totalPage < pg) {// 현재 페이지가 전체 페이지보다 크다면 이는 출력될 페이지 범위를 벗어난 현제 페이지를 의미
        // 따라서 현재페이지를 가장 끝 페이지인 totalPage로 이동시킨다.
        pg = totalPage;
     }
    int startPage = ((pg - 1) / 10) * 10 + 1;
    // 현재 페이지를 기준으로 한 화면에서 시작 페이지 값을 보여준다.

    int endPage = startPage + countPage - 1;
    if (endPage > totalPage) {
        endPage = totalPage;
     }
    if (startPage > 1) {%>
       <a href="Admin_UserInfoPro?page=1"> 처음 </a>
    <% }
    if (pg > 1) { %>
        <a href="Admin_UserInfoPro?page=<%=pg-1 %>"> 이전 </a>
    <% }
    for (int iCount = startPage; iCount <= endPage; iCount++) {
        if (iCount == pg) { %>
          <b><%=iCount %></b>&nbsp;
    <%} else {%>
          <a href="Admin_UserInfoPro?page=<%=iCount %>"> <%=iCount %> </a>&nbsp;
        <%} }  if (pg < totalPage) { %>
       <a href="Admin_UserInfoPro?page=<%=pg+1 %>" >다음</a>
    <%} if (endPage < totalPage) { %>
        <a href="Admin_UserInfoPro?page=<%=totalPage %>">끝</a>
    <%}%>
    		</div>
	</div>
</body>
</html>