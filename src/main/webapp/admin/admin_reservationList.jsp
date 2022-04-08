<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
      <% 
        response.setContentType("text/html;charset=utf-8");
        
    int pg;  // page변수로 현재 페이지 값을 받아서 페이징 처리에 이용..
    int totalCount;
    if(request.getParameter("page")==null){
    	pg=1;
    }else{
    	pg=Integer.parseInt(request.getParameter("page")); 
    }
    if(request.getAttribute("totalRows")==null){
    	totalCount=1;
    }else{
    	totalCount= (Integer)request.getAttribute("totalRows");
    }
	/* 월별 매출값 받아온 배열  */
    String[] month = request.getParameterValues("month");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
				<title>  모든회원 예약 내역 </title>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"> </script>
<script type="text/javascript" src="./script/script.js"></script>
<link href="./css/adminCss.css" rel="stylesheet">
<link href="https://unpkg.com/bootstrap@3.3.7/dist/css/bootstrap.min.css"rel="stylesheet" >
<style type="text/css">
	*{ 
	box-sizing: inherit;
	}
	ul{
	margin-bottom: 0px;
	}
	th{
	text-align: center;
	}
</style>
</head>
<body>

<c:if test="${empty role}">
		<c:redirect url="index.jsp"/>
	</c:if>
	
	
	<div style="width: 90%; margin: auto; margin-bottom: 100px;">
	
			 <h3>::<B> 회원 예약 리스트</B></h3>
			<form action="" name="userInfoList">
		<table class="table table-light" style="height: auto; margin-top: 60px;">
		<thead>
			<tr>
				<th> 총 "<%=totalCount%>" 개의 예약</th>
			</tr>
		</thead>	
		<tbody>
		<tr align="center">
			<th scope="col">예약번호</th>
			<th scope="col">예약날짜</th>
			<th scope="col">체크인</th>
			<th scope="col">체크아웃</th>
			<th scope="col">인원수</th>
			<th scope="col">예약 방</th>
			<th scope="col">예약 방 번호</th>
			<th scope="col">예약자 ID</th>
			<th scope="col">가격</th>
			<th scope="col">상태</th>
			<th scope="col">-</th>
		</tr>
		<tr>
		<th> ▼ 정보 ▼</th>
		<th colspan="9">-</th>
		<th><a href="#" onclick=""> 결제시스템  </a></th>
		</tr>
		
<c:forEach items="${rsList }" var="rsList"  varStatus="status" >
	<tr align="center">
		<th scope="row"> ${rsList.rs_no}</th>
		<td>${rsList.rs_date }  </td>
		<td>${rsList.rs_checkin } </td>
		<td>${rsList.rs_checkout} </td>
		<td>${rsList.rs_people } </td>
		<td>${rsList.rs_roomname} </td>
		<td>${rsList.rs_roomseq}  </td>
		<td>${rsList.rs_userid}  </td>
		<td>${rsList.rs_price}  </td>
		<td>${rsList.rs_state}  </td>
	
	</tr>
		</c:forEach>
	</tbody>
	</table>
	</form>
	
	<script type="text/javascript">
/* script.js  */
	</script>

	<div style="margin: auto;text-align: center;">
	
	<%
    int countList = 10;			 // 한 페이지에 출력될 게시물 수(10개를 기준으로 잡음)
    int countPage = 10; 		// 한 화면에 출력될 페이지 수(통상적으로 10개 페이지를 나오게 함)
    int totalPage = totalCount / countList; // totalPage는 전체 페이지 수 (전체 게시물 / 한 페이지에 출력될 게시물 수)
    if (totalCount % countList > 0) {// totalCount를 countList로 나눈 나머지 값이 존재한다는 것은 한 페이지가 더 있다는 의미이다.
        totalPage++;
     }
    if (totalPage < pg) {// 현재 페이지가 전체 페이지보다 크다면 이는 출력될 페이지 범위를 벗어난 현제 페이지를 의미
        // 따라서 현재페이지를 가장 끝 페이지인 totalPage로 이동시킨다.
        pg = totalPage;
     }
    int startPage = ((pg - 1) / 10) * 10 + 1;
    // 현재 페이지를 기준으로 한 화면에서 시작 페이지 값을 보여준다.

    int endPage = startPage + countPage - 1;
    if (endPage > totalPage) {
        endPage = totalPage;
     }
    if (startPage > 1) {%>
       <a href="Admin_reservationPro?page=1"> 처음 </a>
    <% }
    if (pg > 1) { %>
        <a href="Admin_reservationPro?page=<%=pg-1 %>"> 이전 </a>
    <% }
    for (int iCount = startPage; iCount <= endPage; iCount++) {
        if (iCount == pg) { %>
          <b><%=iCount %></b>&nbsp;
    <%} else {%>
          <a href="Admin_reservationPro?page=<%=iCount %>"> <%=iCount %> </a>&nbsp;
        <%} }  if (pg < totalPage) { %>
       <a href="Admin_reservationPro?page=<%=pg+1 %>" >다음</a>
    <%} if (endPage < totalPage) { %>
        <a href="Admin_reservationPro?page=<%=totalPage %>">끝</a>
    <%}%>
    		</div>
	</div>

		<!--   ///////////////////////////////////////////////////////  -->
		
<div class="content_totalCount_section">
				
				<table class="subject_table">
					<caption>표 제목 부분</caption>
					<tbody>

						<tr align="center">
							<th class="td_width_1" >v</th>
							<th class="td_width_2" >ROOM</th>
							<th class="td_width_3"> Type</th>
							<th class="td_width_4">예약횟수</th>
							<th class="td_width_4"> -- </th>
							<th class="td_width_4"> 총 가격</th>
							<th class="td_width_4"> -- </th>
						</tr>
					</tbody>
				</table>
				<table class="cart_table">
					<caption>표 내용 부분</caption>
					<tbody>
					<c:set var="ACount"  value="${ACount }" />
					<c:set var="APrice"  value="${APrice }"/>
							<tr align="center">
							<th class="td_width_1" >1</th>
								<td class="td_width_2" ><img alt="" src="./img/size200/stan.jpg">  </td>  
								<td class="td_width_3"> 스탠다드 룸</td>
								<td class="td_width_4 ">${ACount } 회</td>
								<td class="td_width_4 table_text_align_center">--	</td>
								<td class="td_width_4 table_text_align_center"> 총매출 :<fmt:formatNumber pattern=",##0" value="${APrice}"/></td>
								<td class="td_width_4 table_text_align_center delete_btn"><button>합산</button></td>
							</tr>
					<c:set var="BCount"  value="${BCount }" />
					<c:set var="BPrice"  value="${BPrice }" />
							<tr align="center">
							<th class="td_width_1" >2</th>
								<td class="td_width_2" ><img alt="" src="./img/size200/drux1.jpg"></td>  
								<td class="td_width_3"> 디럭스 룸</td>
								<td class="td_width_4 ">${BCount } 회</td>
								<td class="td_width_4 table_text_align_center">--	</td>
								<td class="td_width_4 table_text_align_center"> 총매출 : <fmt:formatNumber pattern=",##0" value="${BPrice}"/></td>
								<td class="td_width_4 table_text_align_center delete_btn"><button>합산</button></td>
							</tr>
							<c:set var="CCount"  value="${CCount }" />
							<c:set var="CPrice"  value="${CPrice }" />
							<tr align="center">
								<th class="td_width_1" >3</th>
								<td class="td_width_2" ><img alt="" src="./img/size200/sweet.jpg"></td>  
								<td class="td_width_3"> 스위트 룸</td>
								<td class="td_width_4 ">${CCount } 회</td>
								<td class="td_width_4 table_text_align_center">--	</td>
								<td class="td_width_4 table_text_align_center"> 총매출 : <fmt:formatNumber pattern=",##0" value="${CPrice}"/></td>
								<td class="td_width_4 table_text_align_center delete_btn"><button>합산</button></td>
							</tr>
							<c:set var="DCount"  value="${DCount }" />
							<c:set var="DPrice"  value="${DPrice }" />
							<tr align="center">
								<th class="td_width_1" >4</th>
								<td class="td_width_2" ><img alt="" src="./img/size200/royal.jpg"></td>  
								<td class="td_width_3"> 로얄 룸</td>
								<td class="td_width_4 ">${DCount } 회</td>
								<td class="td_width_4 table_text_align_center">--	</td>
								<td class="td_width_4 table_text_align_center"> 총매출: <fmt:formatNumber pattern=",##0" value="${DPrice}"/>	</td>
								<td class="td_width_4 table_text_align_center delete_btn"><button>합산</button></td>
							</tr>
					</tbody>
				</table>
				
				
				<table class="list_table">
				</table>
			</div>
			<!-- 가격 종합 -->
			<div class="content_total_section">
				<div class="total_wrap">
					<table>
						<tr>
							<td>
								<table>
									<tr>
										<td>스탠다드 총 매출</td>
										<td>
											<span class="totalPrice_span"><fmt:formatNumber pattern=",##0" value="${APrice}"/> </span> 원
										</td>
									</tr>
									<tr>
										<td>디럭스 총 매출</td>
										<td>
											<span class="delivery_price"><fmt:formatNumber pattern=",##0" value="${BPrice}"/></span>원
										</td>
									</tr>									
									<tr>
										<td>스위트 총 매출</td>
										<td><span class="totalKind_span"><fmt:formatNumber pattern=",##0" value="${CPrice}"/></span> 원 
									</tr>
									<tr>
										<td>로얄 총 매출</td>
										<td><span class="totalKind_span"><fmt:formatNumber pattern=",##0" value="${DPrice}"/></span> 원
									</tr>
								</table>
							</td>
							<td>
								<table>
									<tr>
										<td></td>
										<td></td>
									</tr>
								</table>							
							</td>
						</tr>
					</table>
					<div class="boundary_div" >구분선</div>
					<table>
						<tr>
							<td>
								<table>
									<tbody>
										<tr>
											<td>
												<strong>합산 매출</strong>
											</td>
											<td>
											<c:set value="${APrice+BPrice+CPrice+DPrice}" var="nowtotal"/>
											<fmt:setLocale value="ko_kr"/>
											<fmt:formatNumber value="${nowtotal}" groupingUsed="true" type="currency"/>
											</td>
										</tr>
										
									</tbody>
								</table>
							</td>
							<td>
								<table>
									<tbody>
									<c:set target="${maxRoom}" var="maxRoom" value="${maxRoom}"/>
									<c:set target="${maxCount}" var="maxCount" value="${maxCount}"/>
										<tr>
											<td>
												<b/>★  가장 잘 나가는 방 = 
											</td>
											<td align="left">
												<font color="rgba(255, 0, 149, 0.8)">	${maxRoom}  ,  ${maxCount}번 예약 되었습니다. </font>
											</td>
										</tr>
									</tbody>
								</table>
							</td>
						</tr>
					</table>
				</div>
			</div>
			
			<br><br>
	<!-- ////////////////////////////////    -->
			<div class="content_total_section">
				<div class="total_wrap">
					<table>
						<tr>
							<td>
								<table>
									<tr>
										<th>1월 매출</th>
										<th><span class="totalPrice_span"><fmt:formatNumber pattern=",##0" value="${month[1] }"/> </span> 원 </th>
									</tr>
									<tr>
										<th>2월 매출</th>
										<th><span class="delivery_price"><fmt:formatNumber pattern=",##0" value="${month[2] }"/></span>원</th>
									
									</tr>									
									<tr>
										<th>3월 매출</th>
										<th><span class="totalKind_span"><fmt:formatNumber pattern=",##0" value="${month[3] }"/></span> 원 </th>
									</tr>
									<tr>
										<th>4월 매출</th>
										<th><span class="totalKind_span"><fmt:formatNumber pattern=",##0" value="${month[4] }"/></span> 원 </th>
									</tr>
									<tr>
										<th>5월 매출</th>
										<th><span class="totalKind_span"><fmt:formatNumber pattern=",##0" value="${month[5] }"/></span> 원</th>
									</tr>
									<tr>
										<th>6월 매출</th>
										<th><span class="totalKind_span"><fmt:formatNumber pattern=",##0" value="${month[6] }"/></span> 원</th>
									</tr>
									<tr>
										<th>7월 매출</th>
										<th><span class="totalKind_span"><fmt:formatNumber pattern=",##0" value="${month[7] }"/></span> 원</th>
									</tr>
									<tr>
										<th>8월 매출</th>
										<th><span class="totalKind_span"><fmt:formatNumber pattern=",##0" value="${month[8] }"/></span> 원</th>
									</tr>
									<tr>
										<th>9월 매출</th>
										<th><span class="totalKind_span"><fmt:formatNumber pattern=",##0" value="${month[9] }"/></span> 원</th>
									</tr>
									<tr>
										<th>10월 매출</th>
										<th><span class="totalKind_span"><fmt:formatNumber pattern=",##0" value="${month[10] }"/></span> 원</th>
									</tr>
									<tr>
										<th>11월 매출</th>
										<th><span class="totalKind_span"><fmt:formatNumber pattern=",##0" value="${month[11] }"/></span> 원</th>
									</tr>
									<tr>
										<th>12월 매출</th>
										<th><span class="totalKind_span"><fmt:formatNumber pattern=",##0" value="${month[12] }"/></span> 원</th>
									</tr>
								</table>
							</td>
							<td>
								<table>
									<tr>
										<td></td>
										<td></td>
									</tr>
								</table>							
							</td>
						</tr>
					</table>
					<div class="boundary_div" >구분선</div>
					<table>
						<tr>
							<td>
								<table>
									<tbody>
										<tr>
											<th>
												<strong>현재 총 매출</strong>
											</th>
											<th>
											<c:set value="${APrice+BPrice+CPrice+DPrice}" var="nowtotal"/>
											<fmt:setLocale value="ko_kr"/>
											<fmt:formatNumber value="${nowtotal}" groupingUsed="true" type="currency"/>
											</th>
										</tr>
										
									</tbody>
								</table>
							</td>
							<td>
								<table style="margin-left: 100px;">
									<tbody>
										<tr>
											<td>
												<div class="range-slider">
												<font size="5"><b/> 목표 매출 </font>
														  <input class="range-slider__range" type="range" value="${nowtotal}" min="0" max="100000000">
														   <span class="range-slider__value">0</span> 
												</div> 	
											</td>
											<td width="50px;" align="left">
												<span class="totalPoint_span">1억</span> 
											</td>
										</tr>
									</tbody>
								</table>
							</td>
						</tr>
					</table>
				</div>
			</div>


<script type="text/javascript">

/* 목표매출 range  */
var rangeSlider = function(){
	  var slider = $('.range-slider'),
	      range = $('.range-slider__range'),
	      value = $('.range-slider__value');
	    
	  slider.each(function(){

	    value.each(function(){
	      var value = $(this).prev().attr('value');
	      $(this).html(value);
	    });

	    range.on('input', function(){
	      $(this).next(value).html(this.value);
	    });
	  });
	};

	rangeSlider();



</script>




</body>
</html>