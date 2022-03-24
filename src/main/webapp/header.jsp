<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String name = (String) session.getAttribute("name");
String id = (String) session.getAttribute("id");
String role = (String) session.getAttribute("role");

if (name == null)
	response.sendRedirect("index.jsp");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"> </script>
<link href="./css/Design.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js">


</head>
<header id="HD">

	<%
	if (name != null && role.equals("user")) {
	%>
	<div class="I_info_Text">
		<p>	 <i class="fa-solid fa-child"></i>	 &nbsp; ${name} (${id} , ${role} )님 어서오세요.	</p>
	</div>
	
	<%} else if (role != null && role.equals("admin")) {	%>
	
	<div class="I_info_Text">
		<p>	<i class="fa-solid fa-user-gear"></i> 	&nbsp; ${name} ( ${id} , ${role} )님 어서오세요.	</p>
	</div>

	<%} else {	%>
	<div align="right">
		<p class="loginText" >	로그인이 필요 합니다.</p>
	</div>
	<%	}	%>

	<div class="NAV">
		<nav id="UL_left">
					
	<nav>
		<ul class="snip1284">
			<li class="li_index"><a href="index.jsp?filePath=mainSection">Home</a></li> 
			<li class="li_index"><a href="RoomInfo?roomseq=1"> Room & Rservation </a></li>
			<li class="li_index"><a href="index.jsp?filePath=location"> Location </a></li>
			<li class="li_index"><a href="Get_Board_List_Pro"> Community </a></li>
		</ul>
	</nav>
		</nav>


		<form action="" method="get" name="out_check">
			<nav id="UL_right">
				<ul class="snip1284">
					<li class="Rogoimg">	<img src="./img/hotelRogo.png" width="80px;"> 	</li>
					<%
					if (name == null) {
					%>
					<li class="li_index"><a href="#"
						onclick="window.open('./login_check/LoginPopup.jsp','LoginPopup','top=200, left=450, width=550, height=400, toolbar=no, status=yes, menubar=no')">Login</a></li>

					<%
					} else {
					%>
					<li class="li_index"><a href="#" onclick="LogOut_Check_Popup();"> Logout </a></li>
					<%
					}
					%>
					<li class="li_index"><a href="#"
						onclick="location.href='index.jsp?filePath=signUp'"> Sign Up </a></li>
					<!-- 게시판  -->
					

					<%
					if (role != null && role.equals("admin")) {
					%>
					<!--관리자만 보이는 메뉴얼 (회원목록, 예약한사람 목) -->
					<li class="adminMenu li_index"><a href="#"> 관리자 전용 &nbsp; 
					<i class="fa-solid fa-list-ul"></i></a>
						<ul class="subMenu">
							<li><a href="#"> 회원 관리 </a>
							<li>
							<li><a href="#"> 예약 관리 </a>
							<li>
							<li><a href="#"> Q & A </a>
							<li>
						</ul></li>
					<%
					} else {
					%>
					<li class="adminMenu"><a href="#"> 마이페이지 &nbsp; <i
							class="fa-solid fa-list-ul"></i></a>
						<ul class="subMenu">
							<li><a href="My_Info_List"> &nbsp; &nbsp; 내정보  &nbsp; &nbsp;</a>
							<li>
							<li><a href="MyRs_List"> &nbsp; &nbsp; 예약내역  &nbsp; &nbsp;</a>
							<li>
							<li><a href="#"> Q & A </a>
							<li>
						</ul></li>
					<%
					}
					%>


				</ul>
			</nav>
		</form>
	</div>
</header>

<script type="text/javascript">
	window.name = "mainWindow";

	function LogOut_Check_Popup() {
		var msg = confirm("정말로 로그아웃 하십니까?");
		if (msg) {
			out_check.method = "get";
			out_check.action = "LogOut";
			out_check.submit();
		} else {
			selfclose();
		}
	}
	
	
	//상단메뉴 active 활성화 
	$(document).ready(function(){
		$('.li_index').each(function(index){
			$(this).attr('menu-index', index);   //.. li_index클래스의 메뉴들을 클릭하면 인덱스번호가 생성됨
			
		}).click(function(){
			var index = $(this).attr('menu-index');
			$('.li_index[menu-index=' + index + ']').addClass('current');
			$('.li_index[menu-index!=' + index + ']').removeClass('current');
		});


	});		
	
	
	
</script>

</body>
</html>