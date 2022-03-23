<%@page import="com.company.Vo.replyVo"%>
<%@page import="com.company.Vo.BoardVo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("utf-8");
response.setContentType("text/hrml;charset=utf-8");

String role = (String) session.getAttribute("role");
String name = (String) session.getAttribute("name");
String id = (String) session.getAttribute("id");
int pg; // page변수로 현재 페이지 값을 받아서 페이징 처리에 이용..
int totalCount;

// 현재 페이지 변수 받음.
if (request.getParameter("page") == null) {
	pg = 1;
} else {
	pg = Integer.parseInt(request.getParameter("page"));
}

//전체 레코드의 수 구하기  차후 구하기...일단 기본 값으로 1로 해놓겠다.
if (request.getAttribute("totalRows") == null) {
	totalCount = 1;
} else {
	totalCount = (Integer) request.getAttribute("totalRows");
}

if (name == null) {
	response.sendRedirect("./login_check/LoginPopup.jsp");
	return;
}

ArrayList<BoardVo> list = (ArrayList<BoardVo>) request.getAttribute("list");
ArrayList<replyVo> reply =(ArrayList<replyVo>) request.getAttribute("reply");

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
						<title> 게시판 리스트 </title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">

<link rel="stylesheet" href="./css/FormDesign.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js">
</head>
<body>
	<br><br>
	<h2 align="center" >커뮤니티</h2>
	<br><br>
	<div align="center" style="margin: auto auto; padding-top: 45px;">

		<form action="SearchPro" method="get">
			<table class="table" style="width: 100%">
				<tr>
					<td align="right"><select name="select_type">               <!-- 검색기능  -->
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

				<tr style="color: red;" >
					<th scope="col"align="center">번호</th>
					<th scope="col">제목</th>
					<th scope="col">닉네임(아이디)</th>
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
							&nbsp; &nbsp; </a>
							</td>   <!-- 댓글달릴떄만 아이콘 뜨게 수정해야댐  -->
					<td><%=vo.getNickname()%>(<%=id %>)</td>
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
				<tr style="text-align: right;">
					<td colspan="5" align="center"><input type="button"
						value=" 글쓰기 "
						onclick="location.href='index.jsp?filePath=./boardJSP/addBoard'"
						style="background-color: rgba(255, 169, 50, 0.75); color: white; border: none; font-weight: 700; cursor: pointer; padding: 5px 20px 5px 20px;">
					</td>
					<%
					if (role.equals("admin")) {
					%>
					<!-- 체크박스 삭제 이벤트  -->
					<td width="50" style="text-align: center;"><input
						type="button" onclick="Delete_Check_Popup()" value="삭제1"
						style="background-color: rgba(0, 0, 10, 0.5); color: white; border: none; font-weight: 700; cursor: pointer;">
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

			int startPage = ((pg - 1) / 5) * 5 + 1;
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