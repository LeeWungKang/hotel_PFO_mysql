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
<link href="./css/Design.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js">


</head>
<header id="HD">


	<div class="Rogoimg">
		<img src="./img/hotelRogo.png" width="50px;">
	</div>


	<%
	if (name != null && role.equals("user")) {
	%>
	<div class="I_info_Text">
		<p>
			<small> <i class="fa-solid fa-child"></i>
			 &nbsp; ${name} (${id} , ${role} )님 어서오세요.
			</small>
		</p>
	</div>
	<%
	} else if (role != null && role.equals("admin")) {
	%>
	<div class="I_info_Text">
		<p>
			<small> <i class="fa-solid fa-user-gear"></i> 
			&nbsp; ${name} ( ${id} , ${role} )님 어서오세요.
			</small>
		</p>
	</div>
	<%
	} else {
	%>
	<div align="right">
		<p
			style="color: black; margin-right: 150px; text-shadow: 1px -2px 2px 5px black;">
			로그인이 필요 합니다.</p>
	</div>
	<%
	}
	%>

	<div class="NAV">
		<nav id="UL_left">
					
	<nav>
		<ul class="snip1284">
			<li><a href="index.jsp?filePath=mainSection">Home</a></li> 
			<li><a href="RoomInfo?roomseq=1"> Room & Rservation </a></li>
			<li><a href="index.jsp?filePath=location"> Location </a></li>
			<li><a href="Get_Board_List_Pro"> Community </a></li>
		</ul>
	</nav>
		</nav>


		<form action="" method="get" name="out_check">
			<nav id="UL_right">
				<ul class="snip1284">
					<%
					if (name == null) {
					%>
					<li><a href="#"
						onclick="window.open('./login_check/LoginPopup.jsp','LoginPopup','top=200, left=450, width=550, height=400, toolbar=no, status=yes, menubar=no')">Login</a></li>

					<%
					} else {
					%>
					<li><a href="#" onclick="LogOut_Check_Popup();"> Logout </a></li>
					<%
					}
					%>

					<li><a href="#"
						onclick="location.href='index.jsp?filePath=signUp'"> Sign Up </a></li>
					<!-- 게시판  -->
					

					<%
					if (role != null && role.equals("admin")) {
					%>
					<!--관리자만 보이는 메뉴얼 (회원목록, 예약한사람 목) -->
					<li class="adminMenu"><a href="#"> 관리자 전용 &nbsp; 
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
							<li><a href="My_Info_List"> 내정보 </a>
							<li>
							<li><a href="MyRs_List"> 예약내역 </a>
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
		$('li').each(function(index){
			$(this).attr('menu-index', index);
		}).click(function(){
			var index = $(this).attr('menu-index');
			$('li[menu-index =' + index + ']').addClass('current');
			$('li[menu-index !=' + index + ']').removeClass('current');
		});


	});		
	
	
	
</script>

</body>
</html>