<%@page import="com.company.Vo.reservationVo"%>
<%@page import="com.company.Vo.BoardVo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
    String role = (String) session.getAttribute("role");
    String name = (String) session.getAttribute("name");
    String id = (String) session.getAttribute("id");
    
    ArrayList<BoardVo> boardList =(ArrayList<BoardVo>) request.getAttribute("boardList");
	ArrayList<reservationVo> rsvoList =(ArrayList<reservationVo>) request.getAttribute("rsvoList");
    
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
	
	//로그인없이 접속하는 유저를 차단하고 로그인화면으로 이동
	if (name == null) {
		response.sendRedirect("index.jsp?filePath=./login_check/Login_main.jsp");
		return;
	}
	
    %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이 페이지</title>
</head>
<body>

	<div id="container"
		style="width: 100%; height: auto; text-align: center;">

		<table>
			<thead>
				<tr>
					<th>회원 아이디</th>
					<td><%=id%></td>
				</tr>
				<tr>
					<th>회원 이름</th>
					<td><%=name %></td>
				</tr>
				<td colspan="2" align="right"><A href="#"> 회원 탈퇴 </A></td>
			</thead>

			<colgroup>
				<col width="50%" />
				<col width="auto" />
			</colgroup>
			<tbody>
				<tr>
					<th>작성한 게시글</th>
				</tr>

				<% for(int i=0; i<boardList.size(); i++){
			BoardVo bvo = boardList.get(i);	%>
				<tr>
					<td>제목 : <%=bvo.getTitle() %></td>
					<td>내용 : <%=bvo.getContent() %> &nbsp;&nbsp;</td>
					<td>개시날짜 : <%=bvo.getRegdate() %> &nbsp;&nbsp;	</td>
					<td>작성자 id : <%=bvo.getUserid() %>	</td>
				</tr>
				<%} %>

				<tr>
					<th>예약 내역</th>
				</tr>
				<% for(int j=0; j<rsvoList.size(); j++){
				reservationVo rsvo = rsvoList.get(j); %>

				<tr>
					<td><%=rsvo.getRs_date() %></td>
					<td><%=rsvo.getRs_roomname() %></td>
					<td><%=rsvo.getRs_price() %></td>
				</tr>
				<%} %>
			</tbody>
		</table>


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
		<a href="MyPage_Info_List?page=1"> 처음 </a>
		<%
			}
			if (pg > 1) {
			%>
		<a href="MyPage_Info_List?page=<%=pg - 1%>"> 이전 </a>
		<%
			}
			for (int iCount = startPage; iCount <= endPage; iCount++) {
			if (iCount == pg) {
			%>
		<b><%=iCount%></b>&nbsp;

		<%
			} else {
			%>
		<a href="MyPage_Info_List?page=<%=iCount%>"> <%=iCount%>
		</a>&nbsp;
		<%
			}
			}
			if (pg < totalPage) {
			%>

		<a href="MyPage_Info_List?page=<%=pg + 1%>">다음</a>

		<%
			}
			if (endPage < totalPage) {
			%>

		<a href="MyPage_Info_List?page=<%=totalPage%>">끝</a>

		<%
			}
			%>

		<!--페이지 리스트 끝 부분  -->
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