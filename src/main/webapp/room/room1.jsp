<%@page import="java.util.ArrayList"%>
<%@page import="com.company.Vo.roomVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ROOM - 1</title>
<link rel="stylesheet" href="./css/roomCss.css">
</head>
<body>

	<c:set var="RV" value="${roomvo }"/>

	<div id="container_room">


		<div class="roomList">
			<table class="table">
				<tr>
					<th>객실</th>
				</tr>
				<tr>
					<td id="select"><a href="RoomInfo?roomseq=1">${RV.roomname }
							<button id="next">&#10095;</button> </a></td>
				</tr>
				<tr>
					<td><a href="RoomInfo?roomseq=2">스위트</a></td>
				</tr>
				<tr>
					<td><a href="RoomInfo?roomseq=3">디럭스</a></td>
				</tr>
				<tr>
					<td><a href="RoomInfo?roomseq=4">로열</a></td>
				</tr>
			</table>
			<!-- 예약하러 가기 버튼  -->
				
			<div class="wrap">
				<button class="button" onclick="location.href='RsRoomInput?roomseq=${RV.roomseq}'">
				 ${RV.roomname } 예약</button>
			</div>
		</div>



		<!--메인 메뉴 2개  div로 묶어서 자리배치  -->

		<div class="infoWrap">
			<div class="imgSlide_R">
				<div class="section">

					<input type="radio" name="slide" id="slide01" checked="checked">
					<input type="radio" name="slide" id="slide02"> <input
						type="radio" name="slide" id="slide03">

					<div class="slideWrap">
						<ul class="slideList">
							<li><a> <label for="slide03" class="left"></label> <img
									src="./img/room1-1.jpg"> <label for="slide02"
									class="right"></label>
							</a></li>
							<li><a> <label for="slide01" class="left"> </label> <img
									src="./img/room1-2.jpg"> <label for="slide03"
									class="right"></label>
							</a></li>
							<li><a> <label for="slide02" class="left"> </label> <img
									src="./img/room1-3.jpg"> <label for="slide01"
									class="right"></label>
							</a></li>
						</ul>
					</div>
				</div>
			</div>



			<div class="roomInfo">

				<div id="roomContent">
					<h1 style="color: #6e583e; font-size: 2.0em;">스탠다드 룸</h1>
					<br /> 스탠다드 룸은 편안함과 쾌적함이 <br /> 인상적인 최상의 휴식 환경을 제공합니다.
				</div>


				<div id="infoContent">
					<h2>객실정보</h2>
					<br />
					<ul>
						<li>룸 이름 : &nbsp;&nbsp;<b> ${RV.roomname }</b> 룸
						</li>
						<li>가격 : &nbsp;&nbsp;<b> ${RV.price }</b> 원
						</li>
						<li>수용인원 :&nbsp; <b>${RV.roomsize }</b> 명
						</li>
						<li>구성&nbsp;&nbsp;침실1, 욕실1</li>
						<li>전망 &nbsp;시티뷰 또는 빌리지뷰</li>
						<li>침대&nbsp;&nbsp;더블,트윈, 패밀리트윈</li>
					</ul>
				</div>


				<div id="amenityContent">
					<h2>부대시설</h2>
					<br />
					<ul>
						<li>피트니스 센터 무료 이용</li>
						<li>피트니스 센터는 매월 세 번쨰 수요일 정기 휴일입니다.</li>
						<li>실내 수영장 무료 이용(만 13세 이상 입장 가능)</li>
						<li>사우나 이용 시 무료</li>
						<li>투숙 기간 내 무료 주차 가능</li>
					</ul>
				</div>
			</div>

		</div>
		<!-- infoWrap -->
	</div>



</body>
</html>