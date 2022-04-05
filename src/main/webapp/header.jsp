<%@page import="org.apache.tomcat.jdbc.pool.ConnectionPool"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> </title>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="./css/Design.css" rel="stylesheet">
<link rel="stylesheet"	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<script type="text/javascript" src="./script/script.js"></script>
</head>
<header id="HD">

	<c:choose>
		<c:when test="${!empty name and role eq 'user' }">
			<div class="I_info_Text">
				<p>
					<i class="fa-solid fa-child"></i> &nbsp; ${name} (${id} , ${role}
					)님 어서오세요.
				</p>
			</div>
		</c:when>


		<c:when test="${!empty name and role eq 'admin'}">
			<div class="I_info_Text">
				<p>
					<i class="fa-solid fa-user-gear"></i> &nbsp; ${name} ( ${id} ,
					${role} )님 어서오세요.
				</p>
			</div>
		</c:when>

		<c:otherwise>
			<div align="right">
				<p class="loginText">로그인이 필요 합니다.</p>
			</div>
		</c:otherwise>
	</c:choose>


	<div class="NAV">
		<nav id="UL_left">
			<nav>
				<ul class="snip1284">
					<li class="li_index"><a href="index.jsp?filePath=mainSection">Home</a></li>
					<li class="li_index"><a href="RoomInfo?roomseq=1"> Room &
							Reservation </a></li>
					<li class="li_index"><a href="index.jsp?filePath=location">
							Location </a></li>
					<li class="li_index"><a href="Get_Board_List_Pro">
							Community </a></li>
				</ul>
			</nav>
		</nav>


		<form action="" method="get" name="out_check">
			<nav id="UL_right">
				<ul class="snip1284">
					<li class="Rogoimg"><img src="./img/hotelRogo.png"
						width="80px;"></li>

					<c:choose>
						<c:when test="${empty name }">
							<li class="li_index"><a href="#"
								onclick="window.open('./login_check/LoginPopup.jsp','LoginPopup','top=200, left=450, width=550, height=400, toolbar=no, status=yes, menubar=no')">Login</a></li>
						</c:when>
						<c:otherwise>
							<li class="li_index"><a href="#"
								onclick="LogOut_Check_Popup();"> Logout </a></li>
						</c:otherwise>
					</c:choose>

					<li class="li_index"><a href="#"
						onclick="location.href='index.jsp?filePath=signUp'"> Sign Up </a></li>

					<c:choose>
						<c:when test="${!empty role and role eq('admin') }">
							<!--관리자만 보이는 메뉴얼 (회원목록, 예약한사람 목) -->
							<li class="adminMenu li_index"><a href="#"> 관리자 전용
									&nbsp; <i class="fa-solid fa-list-ul"></i>
							</a>
								<ul class="subMenu">
									<li><a href="Admin_UserInfoPro"> 회원 관리 </a>
									<li>
									<li><a href="Admin_reservationPro"> 예약 관리 </a>
									<li>
									<li><a href="Admin_InquiryPro"> Q & A </a>
									<li>
								</ul></li>
						</c:when>

						<c:otherwise>
							<li class="adminMenu"><a href="#"> 마이페이지 &nbsp; <i
									class="fa-solid fa-list-ul"></i></a>
								<ul class="subMenu">
									<li><a href="My_Info_List"> &nbsp; &nbsp; 내정보 &nbsp;
											&nbsp;</a>
									<li>
									<li><a href="MyRs_List"> &nbsp; &nbsp; 예약내역 &nbsp;
											&nbsp;</a>
									<li>
									<li><a href="index.jsp?filePath=./user/inquiryWrite">
											Q & A </a>
									<li>
								</ul></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</nav>
		</form>
	</div>
</header>

<script type="text/javascript">
	/* script.js   */
</script>

</body>
</html>