<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.company.Vo.reservationVo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String role = (String) session.getAttribute("role");
String name = (String) session.getAttribute("name");
String id = (String) session.getAttribute("id");

ArrayList<reservationVo> rsList = (ArrayList<reservationVo>) request.getAttribute("rsList");

int pg; // page변수로 현재 페이지 값을 받아서 페이징 처리에 이용..
int totalCount;
if (request.getParameter("page") == null) {
	pg = 1;
} else {
	pg = Integer.parseInt(request.getParameter("page"));
}

if (request.getAttribute("totalCount") == null) {
	totalCount = 1;
} else {
	totalCount = (Integer) request.getAttribute("totalCount");
}

//로그인없이 접속하는 유저를 차단하고 로그인화면으로 이동
if (name == null) {
	response.sendRedirect("index.jsp?filePath=./login_check/Login_main.jsp");
	return;
}

// 현재시간 보다 5일전이면 예약취소 불가능 하게 제한 넣어야됨.
Date nowDate = new Date();
System.out.println(nowDate);
SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
String ndate = sf.format(nowDate); 

System.out.println(ndate+"--------------------현재시간");			

%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 내역</title>

<link rel="stylesheet" href="css/mypageCss.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">

<style type="text/css">
a {
	text-decoration: none;
}

.table-hover {
	margin-top: 120px;
}
</style>

</head>
<body>

	<div class="rsWrap">
		<h2>예약 내역</h2>
		<table class="table table-dark table-hover">
			<thead>
				<tr>
					<th align="center">총 예약횟수 " <span><%=totalCount%></span> " 건
					</th>
				</tr>
			</thead>
			
			
			<tbody class="Tbody">
				<tr align="center">
					<th>예약자 아이디</th>
					<th>예약 날짜</th>
					<th colspan="2">체크인 / 체크아웃</th>
					<th>예약한 방</th>
					<th>인원수</th>
					<th>총 가격</th>
					<th style="color: red;">예약 취소</th>
				</tr>
				
			<%
			for (int j = 0; j < rsList.size(); j++) {
				reservationVo rsvo = rsList.get(j);
			String A = rsvo.getRs_checkin();
				
		%>
				<tr align="center">
					<td><%=rsvo.getRs_userid()%></td>
					<td><%=rsvo.getRs_date()%>
					
	<!--체크인시간  -->	   		<input type="hidden"  value="<%=rsvo.getRs_checkin()%>" id="rsdate">
	<!--오늘날짜  -->		       <input type="hidden"  value="<%=ndate%>" id="now_date" >
					</td>
					<td colspan="2"><%=rsvo.getRs_checkin()%>&nbsp; ~ &nbsp;<%=rsvo.getRs_checkout()%></td>
					<td><%=rsvo.getRs_roomname()%></td>
					<td><%=rsvo.getRs_people()%></td>
					<td><%=rsvo.getRs_price()%></td>
					<td>
					<input type="button" onclick="rsDelete();" value="예약취소">
					or  
					<font>"ㅡ"</font>
					 
					</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
			<div align="center"> 	<h5> :: 체크인 날짜 3일 이전에는 예약을 취소 하실 수 없습니다. :: </h5> </div>
	
	<script type="text/javascript">

	function rsDelete() {
		var now_date = new Date(document.getElementById("now_date").value).getTime();     	  //오늘 날짜
		var rsdate = new Date(document.getElementById("rsdate").value).getTime();      		      //체크인 시작 날짜
		var diffdate = (( rsdate - now_date) / (24*60*60*1000));       										  //예약날짜 - 현재날짜  
		
		
		if (rsdate != null && diffdate <= 3) { 				//체크인하는 날이  현재날짜보다 3일전일떄는 예약 취소 불가능.
			alert("3일전 이라 취소가 불가능 합니다.");
			console.log("취소 불가능");
			return;
			
			
		}else{
			confirm("취소하시겠습니까?");
			console.log(" 날짜차이가 3일 이상일떄 = 취소 가능 기능");
			location.href="cccccc.jsp";
		}
	}
	</script>



	<!-- 페이징  -->
		<div style="width: 100%; margin: auto; text-align: center;">
			<%
			int countList = 5; 				// 한 페이지에 출력될 게시물 수(10개를 기준으로 잡음)
			int countPage = 5; 			// 한 화면에 출력될 페이지 수(통상적으로 10개 페이지를 나오게 함)
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
			<a href="MyRs_List?page=1"> 처음 </a>
			<%
			}
			if (pg > 1) {
			%>
			<a href="MyRs_List?page=<%=pg - 1%>"> 이전 </a>
			<%
			}
			for (int iCount = startPage; iCount <= endPage; iCount++) {
			if (iCount == pg) {
			%>
			<b><%=iCount%></b>&nbsp;

			<%
			} else {
			%>
			<a href="MyRs_List?page=<%=iCount%>"> <%=iCount%>
			</a>&nbsp;
			<%
			}
			}
			if (pg < totalPage) {
			%>

			<a href="MyRs_List?page=<%=pg + 1%>">다음</a>

			<%
			}
			if (endPage < totalPage) {
			%>
			<a href="MyRs_List?page=<%=totalPage%>">끝</a>

			<%
			}
			%>
		</div>
	</div>
	

	
	
	
</body>
</html>