<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.company.Vo.roomVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
	<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
request.setCharacterEncoding("utf-8");
String name = (String) session.getAttribute("name");
if (name == null) {
	out.print(
	"<script> alert('죄송합니다. 예약은 로그인이 필요합니다.'); location.href='index.jsp?filePath=./login_check/Login_main'  </script>");
	out.close();
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
							<title>예약하기 2 페이지</title>
<script type="text/javascript" src="script/script.js"></script>
<link href="./css/reservationCss.css" rel="stylesheet">
<style>
</style>
</head>
<body>
<c:set value="${roomvo }" var="RV"/>
<c:set value="${date}"  var="Adate"/>   <!-- 달력 클릭으로 넘어온 String타입 날짜 -->
<fmt:parseDate value="${Adate }"  var="Bdate"  pattern="yyyyMMdd"  />
<fmt:formatDate value="${Bdate }" var="clickDate" pattern="YYYY년 MM월 dd일"/>  <!--상단에뿌릴 데이터  -->
<fmt:formatDate value="${Bdate }" var="Fdate" pattern="YYYY-MM-dd"/>  <!--체크인 인풋박스  -->

	<div id="container">
		<div class="TEST_box1">
			<div class="TEST_box2">
				<c:choose>
					<c:when test="${!empty se_roomname }">
						<h2>
					선택하신 "<font style="color: red;"> ${se_roomname }
					</font>"룸은 <br> 지정하신 "<font
						style="color: yellow; background-color: gray; padding: 5px;"> ${clickDate}
					</font>" 날짜에 ${conMsg }	합니다.
				</h2>
				<br> <br>
					</c:when>
				
					<c:otherwise>
						<h2>(선택하신 방이 없습니다. <br> 바로 예약 하시려면 현황표에서 방을 선택해 주세요.)</h2>
					</c:otherwise>
				</c:choose>
				
				<div class="userInfoBox">
					<table align="center" class="reservelist1">
						<tr>
							<th align="left">예약자 이름 :</th>
							<td align="center" colspan="2">${name }</td>
						</tr>
						<tr>
							<th align="left">예약자 아이디 :</th>
							<td align="center" colspan="2">${id }</td>
						</tr>
					</table>
				</div>

			</div>
		</div>



		<div class="rs_Wrap" onsubmit="return reservationCheck()">

			<div class="reserve1 regForm_Wrap">
				<form action="Reservation_Ok" method="post" name="regForm">
					<table class="res_table">
						<tr align="center">
							<td><input type="hidden" name="rs_date"></td>
							<!-- 예약한 현재시간 sysdate로 자동입력  -->
							<td><input type="hidden" name="name" value="${name }"></td>
							<td><input type="hidden" name="rs_userid" value="${id }"></td>
							<td><input type="hidden" name="rs_roomname"
								value="${se_roomname }"></td>
							<!--최초로 클릭한 사용자가 선택한 룸 -->
							<td><input type="hidden" name="rs_roomseq"
								value="${RV.roomseq }"></td>
						</tr>

						<tr align="center" style="color: #a0a0a0; font-weight: bold;">
							<td colspan="1">체크인</td>
							<td colspan="1">체크아웃</td>
							<td>총 가격</td>
							<td>인원수</td>
						</tr>

						<tr align="center">
							<td colspan="1"><input type="date" name="rs_checkin"
								id="add_setDate" min="${Fdate }"></td>            <!--달력에서 클릭한 날짜를 우선으로 체크인  -->
							<td colspan="1"><input type="date" name="rs_checkout"
								min="${Fdate }" oninput="dateCheck()"></td>
							<!--체크아웃 이벤트 -->
							<td class="totalPrice_BOX"><input type="text" id="rs_Getprice" name="rs_Getprice"
								value="" placeholder=" = " > <input type="hidden"
								id="rs_setPrice_X" value="${RV.price }"> <input
								type="hidden" id="rs_price" name="rs_price" value=""></td>
							<td><input type="text" maxlength="1" name="rs_people"
								placeholder="기본 2명" value="2"></td>
						</tr>

						<tr align="center" style="height: 60px;">
							<td colspan="5"><B>:: 예약을 원하는 날짜,인원,가격이 맞는지 확인해주세요 ^^ :: </B></td>
						</tr>
						<tr style="height: 150px;">
							<td align="center" colspan="5"><input type="submit"
								class="rs_BTN" value="예약 신청합니다"> <input type="reset"
								class="rs_BTN" value="다시 작성하기"></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		<!--rs_Wrap  -->
	</div>
	<!-- 컨테이너 -->
	<script type="text/javascript">
			/* script.js */
	</script>

</body>
</html>