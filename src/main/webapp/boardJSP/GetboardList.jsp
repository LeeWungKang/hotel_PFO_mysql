<%@page import="com.company.Vo.replyVo"%>
<%@page import="com.company.Vo.BoardVo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
int pg; // page변수로 현재 페이지 값을 받아서 페이징 처리에 이용..
int totalCount;
if (request.getParameter("page") == null) {	pg = 1; 
} else {	pg = Integer.parseInt(request.getParameter("page"));}
if (request.getAttribute("totalRows") == null) {
	totalCount = 1;
} else {	totalCount = (Integer) request.getAttribute("totalRows");}
%>
 <c:if test="${empty name } ">
 	<c:redirect url="index.jsp"/>
 </c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 리스트</title>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"> </script>
<script type="text/javascript" src="script/script.js"></script>
<link	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="./css/FormDesign.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style type="text/css">
	.selected{
	background-color: rgba(255, 226, 41, 0.35)
	}
	*{ 
	box-sizing: inherit;
	}
	ul{
	margin-bottom: 0px;
	}
</style>
</head>
<body>

	<div id="container">
		<br>
		<br>
		<h2 align="center">커뮤니티</h2>
		<br>
		<br>
		<div align="center" style="margin: auto auto; padding-top: 45px;">

			<form action="SearchPro" method="get">
				<table class="table" style="width: 100%">
					<tr>
						<td align="right"><select name="select_type">
								<!-- 검색기능  -->
								<option value="title" selected="selected">제목</option>
								<option value="content">내용</option>
								<option value="nickname">닉네임</option>
								<option value="regdate">날짜</option>
						</select> <input type="text" name="search_keyword" placeholder="search">
							<input type="submit" value="검색"> <i
							class="fa-solid fa-magnifying-glass"></i></td>
					</tr>
				</table>
			</form>

			<form action="" name="chc_Form">

				<table class="table table-striped table-hover"
					style="text-align: center;">

					<tr style="color: red;">
						<th scope="col" align="center">번호</th>
						<th scope="col">제목</th>
						<th scope="col">닉네임(아이디)</th>
						<th scope="col">작성날짜</th>
						<th scope="col">조회수</th>
						
						<c:if test="${!empty role and role eq 'admin'}">
						<th width="100" style="text-align: center;">전체 <input
							type="checkbox" name="checkAll"  id="th_checkAll"
							onclick="check_All()"></th>
						</c:if>
					</tr>
				
			<c:forEach items="${list}" var="list" varStatus="status">
					<tr>
						<td>${list.seq}</td>
						<td><a href="Get_Board_Pro?num=${list.seq }"> ${list.title }
								&nbsp; &nbsp;
						</a></td>
						<!-- 댓글달릴떄만 아이콘 뜨게 수정해야댐  -->
						<td>${list.nickname}  (${list.userid})</td>
						<td>${list.regdate }</td>
						<td>${list.cnt } &nbsp; <i
							class="fa-brands fa-creative-commons-by"
							style="font-size: 1.2em;"></i></td>
					<c:if test="${!empty role and role eq 'admin'}">
						<td><input type="checkbox" value="${list.seq }"
								class="chcBox" name="chcBox"></td>
						<!--체크박스 선택삭제시, seq키값 벨류에 넣어줘서 돌려야댐  -->
					</c:if>
					</tr>
			</c:forEach>
						
					<tr style="text-align: right;">
						<td colspan="5" align="center"><input type="button"
							value=" 글쓰기 "
							onclick="location.href='index.jsp?filePath=./boardJSP/addBoard'"
							style="background-color: rgba(255, 169, 50, 0.75); color: white; border: none; font-weight: 700; cursor: pointer; padding: 5px 20px 5px 20px;">
						</td>
						
						
						<c:if test="${!empty role and role eq 'admin'}">
						<!-- 체크박스 삭제 이벤트  -->
						<td width="50" style="text-align: center;"><input
							type="button" onclick="Delete_Check_Popup()" value="삭제"
							style="background-color: rgba(0, 0, 10, 0.5); color: white; border: none; font-weight: 700; cursor: pointer;">
						</td>
						</c:if>
					</tr>
				</table>
				
				
				
				<!--페이지 리스트 시작부분  -->
				<%
				int countList = 10; // 한 페이지에 출력될 게시물 수(10개를 기준으로 잡음)
				int countPage = 5; // 한 화면에 출력될 페이지 수(통상적으로 10개 페이지를 나오게 함)

				/* 	int pg=3; // 현재 페이지 번호, 'page'는 도스에서 이미 사용하고있는 변수이기떄문에 pg로 변경, 차후에 requast 겟방식으로 받아서 처리해야함.   (!수정)
				    int totalCount = 255;  */
				// 전체 게시물의 개수 255개 기준으로 잡음. (원래는 select count(*) as totalCount from board)
				// totalCount의 개수는 실제 게시물의 개수를 계산해서 가지고와야 함      (!수정)

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

				if (startPage > 1) {
				%>
				<a href="Get_Board_List_Pro?page=1"> 처음 </a>
				<%
				}

				if (pg > 1) {
				%>
				<a href="Get_Board_List_Pro?page=<%=pg - 1%>"> 이전 </a>
				<%
				}

				for (int iCount = startPage; iCount <= endPage; iCount++) {
				if (iCount == pg) {
				%>

				<b><%=iCount%></b>&nbsp;

				<%
				} else {
				%>
				<a href="Get_Board_List_Pro?page=<%=iCount%>"> <%=iCount%>
				</a>&nbsp;
				<%
				}
				}
				if (pg < totalPage) {
				%>
				<a href="Get_Board_List_Pro?page=<%=pg + 1%>">다음</a>
				<%
				}
				if (endPage < totalPage) {
				%>
				<a href="Get_Board_List_Pro?page=<%=totalPage%>">끝</a>

				<%
				}
				%>
				<!--페이지 리스트 끝 부분  -->
			</form>

		</div>

	</div>

</body>
</html>