<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<header id="HD">
			<h1 align="center">
				<B> PEOPLES </B>
			</h1>

			<nav id="UL_left">
				<ul>
					<li><a href="index.jsp?fliePath=home">Home</a></li>
					<!-- 메인화면 네비게이션 -->
					<li><a href="">Gallery</a></li>
					<!-- 사진 모음 , 클릭하면 상세 페이지 -->
					<li><a href="">Community</a></li>
					<!-- 게시판  -->
					<li><a href="">Contact</a></li>
					<!-- 찾아오는길 api -->
				</ul>
			</nav>

			<nav id="UL_right">
				<ul>
					<li><a href="#" onclick="window.open('./login_check/LoginPopup.jsp','LoginPopup','top=210, left=700, width=400, height=350, toolbar=no, status=no, menubar=no')">Login</a></li>
					<li><a href="#" onclick="location.href='index.jsp?filePath=signUpPopup'">Sign Up </a></li>
					<li><a href="#">Rservation </a></li>
					<!-- 예약하기 -->
					<li><a href="">관리자 전용</a></li>
					<!--관리자만 보이는 메뉴얼 (회원목록, 예약한사람 목) -->
				</ul>

			</nav>

		</header>

<script type="text/javascript">



</script>


</body>
</html>