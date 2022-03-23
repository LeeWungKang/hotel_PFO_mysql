<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
    String name = ( String )session.getAttribute("name");
    if(name == null) response.sendRedirect("index.jsp");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지도 api</title>
<link href="./css/locationCss.css" rel="stylesheet">
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=944a26a214e779cba297f16259835be8"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=LIBRARY"></script>
</head>
<body>

<div id="container">

	<h1 class="H1">Locataion - 오시는 길</h1>

	<div class="Wrap_location">
		<div id="map"></div>

		<div id="side_text">
					
				<article>
					<h3> 안내 사항 </h3>
					<ul>
						<li>주소 : 경기도 수원시 팔달구 인계동 1234-123 </li>
						<li>수원시청역  6번출구에서 도보 5분 </li>
						<li>주차장 시설 완비 (최대 50대 차량)</li>
					<hr>
					<h3> 전화번호 </h3>
						<li>000-0000-0000</li>
					<hr>
					<h3> 이메일 </h3>
					<li>kjdndrkd@naver.com</li>
					<hr>
					<h3> 편의 시설 </h3>
					<li>수영장 , 아동풀장</li>
					<li>사우나 규모 150평</li>
					<li>조식 석식 중식 가능</li>
					<li>노래방시설, 각종 행사 장비</li>
					</ul>
					</article>
		</div>

	</div>
	<script type="text/javascript">
var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
var options = { //지도를 생성할 때 필요한 기본 옵션
	center: new kakao.maps.LatLng(37.26312183969012, 127.0298556993812), //지도의 중심좌표.
	level: 3 //지도의 레벨(확대, 축소 정도)
};

var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

var markerPosition  = new kakao.maps.LatLng(37.26312183969012, 127.0298556993812); 

//마커를 생성합니다
var marker = new kakao.maps.Marker({
 position: markerPosition
});

//마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

//아래 코드는 지도 위의 마커를 제거하는 코드입니다
//marker.setMap(null);  

</script>
</div>
</body>
</html>