<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <% 
 	String name = ( String )session.getAttribute("name");
 	String id = ( String )session.getAttribute("id");
 	String role = ( String )session.getAttribute("role");

 	
 	if(name == null) response.sendRedirect("index.jsp");
    
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
			
			
			<div class="Rogoimg"><img src="./img/hotelRogo.png" width="80px;"></div>
			
			 
		<%if(name != null) { %>
		<div align="right" style="margin-bottom: 10px;"> <p style="color: #333; font-weight:600; margin-right: 240px;"><small> <i class="fa-solid fa-child"></i> ${name}( ${id} , ${role})님 어서오세요.</small> </p> </div>
		<% }else { %>
		<div align="right"> <p style="color:gray; text-shadow: 1px -2px 2px 5px black;"> 로그인이 필요 합니다.  </p> </div>
		<%} %>
		
		
		<div class="NAV">
			<nav id="UL_left" >
				<ul>
					<li><a href="index.jsp?filePath=mainSection">Home</a></li>  <!--  home 메인 이미지 페이지 수정필요 -->
					<!-- 메인화면 네비게이션 -->
					<li><a href="RoomInfo?roomseq=1"> Room </a></li>
					<!-- index.jsp?filePath=./room/room1  -->
					<!-- 사진 모음 , 클릭하면 상세 페이지 -->
					<li><a href="index.jsp?filePath=./room/rservation"> Rservation </a></li>
					<!-- 예약하기 -->
					<li><a href="index.jsp?filePath=location"> Location </a></li>
					<!-- 찾아오는길 api -->
				</ul>
			</nav>
			
			
	<form action="" method="get" name="out_check">
			<nav id="UL_right" >
				<ul>
					<%if(name == null){ %>
					<li><a href="#" onclick="window.open('./login_check/LoginPopup.jsp','LoginPopup','top=200, left=450, width=550, height=400, toolbar=no, status=yes, menubar=no')">Login</a></li>
					
					<%}else{ %>
					<li><a href="#" onclick="LogOut_Check_Popup();"> Logout </a></li>
					<% } %> 
					
					<li><a href="#" onclick="location.href='index.jsp?filePath=signUp'"> Sign Up </a></li>
					<!-- 게시판  -->
					<li><a href="Get_Board_List_Pro"> Community </a></li>
					
					 <%if(role!=null && role.equals("admin")){ %>   	<!--관리자만 보이는 메뉴얼 (회원목록, 예약한사람 목) -->
					<li class="adminMenu"><a href="" style="font-size: 0.8em; color: yellow;"> 관리자 전용 </a>
						<ul class="subMenu">
						<li><a href="#"> 회원 관리 </a> <li>
						<li><a href="#"> 예약 관리 </a> <li>
						<li><a href="#"> Q & A </a> <li>
						</ul>
					</li>
					<% }else{	%>
					<li class="adminMenu"><a href="" style="font-size: 0.8em; color: yellow;"> 마이페이지 </a>
						<ul class="subMenu">
						<li><a href="#"> 내정보  </a> <li>
						<li><a href="#"> 예약내역 </a> <li>
						<li><a href="#"> Q & A </a> <li>
						</ul>
					</li>
					<%} %>
					
				
				</ul>
			</nav>
		</form>
		</div>
		</header>

<script type="text/javascript">
 window.name="mainWindow";

function LogOut_Check_Popup() {
	var msg=confirm("정말로 로그아웃 하십니까?");
	if(msg){
		out_check.method="get";
		out_check.action="LogOut";
		out_check.submit();
	}else{
		selfclose();
	}
}

</script>

</body>
</html>