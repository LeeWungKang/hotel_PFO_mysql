<%@page import="com.company.Vo.inquiryVo"%>
<%@page import="com.company.Vo.userVo"%>
<%@page import="com.company.Vo.reservationVo"%>
<%@page import="com.company.Vo.BoardVo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String role = (String) session.getAttribute("role");
String name = (String) session.getAttribute("name");
String id = (String) session.getAttribute("id");

userVo uservo = (userVo) request.getAttribute("uservo");
ArrayList<BoardVo> boardList = (ArrayList<BoardVo>) request.getAttribute("boardList");
ArrayList<inquiryVo>inquiryList = (ArrayList<inquiryVo>) request.getAttribute("inquiryList");


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
<script type="text/javascript" src="script/script.js"></script>
<link rel="stylesheet" href="css/mypageCss.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
	
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
	

<style type="text/css">
a {
	text-decoration: none;
}
.fa-bell-slash{
	font-size: 1.2em; 
	margin-right: 15px;
}
</style>

</head>
<body>

	<div id="containerMypage" align="right">


		<div class="info_Wrap" style="margin-bottom: 100px;">
			<h2>내 정보</h2>
		</div>

<div class="joinInfoWrap">
		<h3 align="left" >:: 가입정보</h3>
		<table class="table table-striped">
			<thead class="table-dark">
				<tr>
					<th>회원 아이디</th>
					<td><%=id%></td>
				</tr>
				<tr>
					<th>회원 이름</th>
					<td><%=name%></td>
				</tr>
				<tr>
					<th>핸드폰 번호</th>
					<td><%=uservo.getPhone()%></td>
				</tr>
				<tr>
					<th>가입 날짜</th>
					<td><%=uservo.getJoindate()%></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><%=uservo.getEmail()%></td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td align="center"><A href="Mypage_Modify_Info?id=<%=uservo.getId()%>"> 내 정보 수정 </A></td>
					<td align="center"><A href="#" onclick="window.open('./user/userInfo_Delete.jsp','deletePopup','top=200, left=450, width=550, height=400, toolbar=no, status=yes, menubar=no')" style="color: red;"> 회원 탈퇴
					</A></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
				</tr>
			</tfoot>
		</table>
		
		</div>
<!-- 문의 글  -->

			<div style="text-align: left; width: 600px; height: auto; display: inline-block; float: right;">
			 <h3>:: 고객의 소리 </h3>
			<div style="width: 600px; height: 325px;  padding: 10px; text-align: center; "> 
				<form action="" name="inquiryForm">
				<table class="table table-hover" style="vertical-align: middle;  line-height: 40px;">
					<tr class="table-dark" >
						<th width="150"  >작성날짜</th>
						<th>제목</th>
						<th>내용</th>
						<th>- X -</th>
					</tr>
				 <% for(int j=0; j<inquiryList.size(); j++){ 
					 inquiryVo iqvo= inquiryList.get(j);
				 %>	 
					<tr>
						<td style="font-size: 0.8em;"><%=iqvo.getB_writedate() %></td>
						<td><%=iqvo.getB_title() %></td>
						<td><%=iqvo.getB_content() %></td>
						<td><a href="#" onclick="inquiryDeletePop()"> 삭제 </a>
							<input type="hidden" name="b_no" value="<%=iqvo.getB_no() %>">
						  </td>
					</tr>
				<%}if(inquiryList.size()== 0 ){ %>
					<tr> 
							<th colspan="4"> <i class="fa-regular fa-bell-slash"></i> 문의하신 내용이 없습니다. </th> 
					</tr>
					<%} %>
				</table>
					</form>
			</div>
			</div>
				
	<script type="text/javascript">
	function inquiryDeletePop() {
		var msg = confirm("정말로 삭제하시겠습니까?");
		if (msg) {
			inquiryForm.method = "post";
			inquiryForm.action = "Myinquiry_Delete";
			inquiryForm.submit();
		} else {
			selfclose();
		}
	} 
	</script>





			<!--  ----------회원정보 끝---------------  -->


	<div class="boardInfoWrap" style="display: inline-block; width: 100%;  ">
		<form action="" name="chc_Form">
		<h3 align="left" style="margin-top: 100px;">:: 내가 작성한 커뮤니티 게시글</h3>
			<table class="table table-hover">
				<thead class="table-dark">
					<tr>
						<th>총 <font class="TotalText"> " <%=totalCount%> " </font>개의 글
						</th>
						<th colspan="3"></th>
						<th width="50" style="text-align: center;">전체 <input
							type="checkbox" name="checkAll" id="th_checkAll"
							onclick="check_All()"></th>
					</tr>
					<tr>
						<th width="150px;">글번호</th>
						<th>제목</th>
						<th>개시날짜</th>
						<th>닉네임(아이디)</th>
						<th width="130px;"><input
							type="button" onclick="Delete_Check()" value="삭제"
							style="background-color:#212529; color: red; border: none; font-weight: 700; cursor: pointer;"></th>
					</tr>
				</thead>

				<%
				for (int i = 0; i < boardList.size(); i++) {
					BoardVo bvo = boardList.get(i);
				%>
				<tbody>
					<tr>
						<td><%=bvo.getSeq()%></td>
						<td><a href="Get_Board_Pro?num=<%=bvo.getSeq()%>"> <%=bvo.getTitle()%> </a></td>
						<td><%=bvo.getRegdate()%></td>
						<td><%=bvo.getNickname()%></td>
						<td><input type="checkbox" id="chcBox" name="chcBox"
							value="<%=bvo.getSeq()%>"></td>
					</tr>
					<%
					}
					%>
				</tbody>
				<tr>
			</table>
		</form>

		<%
		int countList = 10; // 한 페이지에 출력될 게시물 수(10개를 기준으로 잡음)
		int countPage = 5; // 한 화면에 출력될 페이지 수(통상적으로 10개 페이지를 나오게 함)
		int totalPage = totalCount / countList;

		if (totalCount % countList > 0) {
			totalPage++;
		}
		if (totalPage < pg) {
			pg = totalPage;
		}

		int startPage = ((pg - 1) / 5) * 5 + 1;
		int endPage = startPage + countPage - 1;

		if (endPage > totalPage) {
			endPage = totalPage;
		}
		if (startPage > 1) {
		%>
		<a href="My_Info_List?page=1"> 처음 </a>
		<%
		}
		if (pg > 1) {
		%>
		<a href="My_Info_List?page=<%=pg - 1%>"> 이전 </a>
		<%
		}
		for (int iCount = startPage; iCount <= endPage; iCount++) {
		if (iCount == pg) {
		%>
		<b><%=iCount%></b>&nbsp;

		<%
		} else {
		%>
		<a href="My_Info_List?page=<%=iCount%>"> <%=iCount%>
		</a>&nbsp;
		<%
		}
		}
		if (pg < totalPage) {
		%>

		<a href="My_Info_List?page=<%=pg + 1%>">다음</a>

		<%
		}
		if (endPage < totalPage) {
		%>
		<a href="My_Info_List?page=<%=totalPage%>">끝</a>
		<%
		}
		%>
		
		<%if (boardList.size() == 0) {	%>
		<p style="text-align: center; margin-top: 50px; font-weight: 800;">등록된 댓글이 없습니다.</p>
		<%}%>
		</div>
	</div>
	<!--페이지 리스트 끝 부분  -->
	
	
	
	
	
	
	<script type="text/javascript">
	//   js 폴더 
	</script>





</body>
</html>