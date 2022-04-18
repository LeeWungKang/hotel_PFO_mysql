<%@page import="com.company.Vo.BoardVo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
request.setCharacterEncoding("utf-8");
ArrayList<BoardVo> list = (ArrayList<BoardVo>) request.getAttribute("list");
String role = (String) session.getAttribute("role");
String name = (String) session.getAttribute("name");


int pg; // page변수로 현재 페이지 값을 받아서 페이징 처리에 이용..
int totalCount;
if (request.getParameter("page") == null) {	pg = 1;
} else {pg = Integer.parseInt(request.getParameter("page"));}
if (request.getAttribute("totalRows") == null) {
	totalCount = 1;
} else {	totalCount = (Integer) request.getAttribute("totalRows");


}
if (name == null) {
	response.sendRedirect("./login_check/LoginPopup.jsp");
	return;
}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 검색 결과 </title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"	rel="stylesheet">
<link rel="stylesheet" href="./css/FormDesign.css">
<link rel="stylesheet"	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<link rel="stylesheet" 	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js">
</head>
<body>

<h2 align="center" >커뮤니티 검색결과</h2>
	<hr>
	<br>
	<br>
	<div align="center" style="margin: auto auto;">

		<form action="SearchPro" method="get">
			<table class="table" style="width: 100%">
				<tr>
					<td align="right"><select name="select_type">
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
					<th scope="col">번호</th>
					<th scope="col">제목</th>
					<th scope="col">닉네임</th>
					<th scope="col">작성날짜</th>
					<th scope="col">조회수</th>
					<%
					if (role.equals("admin")) {
					%>
					<th width="50" style="text-align: center;">삭제</th>
					<%
					}
					%>
				</tr>
				<%
				for (int i = 0; i < list.size(); i++) {
					BoardVo vo = list.get(i);
				%>
				<tr>	
					<td><%=vo.getSeq()%></td>
					<td><a href="Get_Board_Pro?num=<%=vo.getSeq()%>"> <%=vo.getTitle()%>
							&nbsp; &nbsp; <i class="fa-regular fa-comment-dots"></i></a>
							</td>   <!-- 댓글달릴떄만 아이콘 뜨게 수정해야댐  -->
					
					<td><%=vo.getNickname()%></td>
					<td><%=vo.getRegdate()%></td>
					<td><%=vo.getCnt()%> &nbsp; <i
						class="fa-brands fa-creative-commons-by" style="font-size: 1.2em;"></i></td>
					<%
					if (role.equals("admin")) {
					%>
					<td><a><input type="checkbox" value="<%=vo.getSeq()%>"
							id="chcBox" name="chcBox"> </a></td>
					<!--체크박스 선택삭제시, seq키값 벨류에 넣어줘서 돌려야댐  -->
					<%
					}
					%>
				</tr>
				<%
				}
				%>
				<%if(list.size() == 0){ %>
				<tr> <td colspan="5"> <p> 검색된 데이타가 없습니다. </p></td> </tr>
				<%} %>
				<tr style="text-align: right;">
					<td colspan="5" align="center"><input type="button"
						value=" 글쓰기 "
							onclick="location.href='index.jsp?filePath=./boardJSP/addBoard'"
						style="background-color: rgba(255, 169, 50, 0.75); color: white; border: none; font-weight: 700; cursor: pointer; padding: 5px 20px 5px 20px;">
					</td>
					<%
					if (role.equals("admin")) {
					%>
					<td width="50" style="text-align: center;"><input
						type="button" onclick="Delete_Check_Popup()" value="삭제하기"
						style="background-color: rgba(0, 0, 10, 0.5); color: white; border: none; font-weight:normal; cursor: pointer;">
					</td>
					<%
					}
					%>
				</tr>
			</table>
			<!--페이지 리스트 시작부분  -->
			<%
			int countList = 5; // 한 페이지에 출력될 게시물 수(10개를 기준으로 잡음)
			int countPage = 5; // 한 화면에 출력될 페이지 수(통상적으로 10개 페이지를 나오게 함)
			int totalPage = totalCount / countList; // totalPage는 전체 페이지 수 (전체 게시물 / 한 페이지에 출력될 게시물 수)
			if (totalCount % countList > 0) {// totalCount를 countList로 나눈 나머지 값이 존재한다는 것은 한 페이지가 더 있다는 의미이다.
				totalPage++;
			}
			if (totalPage < pg) {// 현재 페이지가 전체 페이지보다 크다면 이는 출력될 페이지 범위를 벗어난 현제 페이지를 의미
				pg = totalPage;
			}
			int startPage = ((pg - 1) / 5) * 5 + 1;
			int endPage = startPage + countPage - 1;
			if (endPage > totalPage) {
				endPage = totalPage;
			}
			if (startPage > 1) {
			%>
			<a href="Get_Board_List_Pro?page=1"> 처음 </a>
			<%}if (pg > 1) {	%>
			<a href="Get_Board_List_Pro?page=<%=pg - 1%>"> 이전 </a>
			<%
			}
			for (int iCount = startPage; iCount <= endPage; iCount++) {
			if (iCount == pg) {
			%>
			<b><%=iCount%></b>&nbsp;
			<%} else {%>
			<a href="Get_Board_List_Pro?page=<%=iCount%>"> <%=iCount%>
			</a>&nbsp;
			<%}}if (pg < totalPage) {	%>
			<a href="Get_Board_List_Pro?page=<%=pg + 1%>">다음</a>
			<%	}if (endPage < totalPage) {	%>
			<a href="Get_Board_List_Pro?page=<%=totalPage%>">끝</a>
			<%	}	%>
			<!--페이지 리스트 끝 부분  -->
		</form>
		<script type="text/javascript">
			function Delete_Check_Popup() {
				var msg = confirm("정말로 삭제하시겠습니까?");
				if (msg) {
					chc_Form.method = "post";
					chc_Form.action = "Delete_Check";
					chc_Form.submit();
				} else {
					selfclose();
				}
			}
		</script>

	</div>





</body>
</html>