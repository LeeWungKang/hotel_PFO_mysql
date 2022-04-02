<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
				<title>  모든회원 예약 내역 </title>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"> </script>
<script type="text/javascript" src="./script/script.js"></script>
<link href="https://unpkg.com/bootstrap@3.3.7/dist/css/bootstrap.min.css"rel="stylesheet" >
<style type="text/css">
 table{
	 	border-collapse: collapse;
	 	width: 100%;
	 }
	 .table_text_align_center{
				text-align: center;
	 }	
	 caption{
	    visibility: hidden;
	    width: 0;
	    height: 0;
	    font-size: 0;
	    line-height: 0;
	    overflow: hidden; 
	 }	  

	 .content_subject{
		height: 110px;
	    line-height: 110px;
	    background-color: #5080bd;
	    margin-bottom: 60px; 
	 
	 }
		 .content_subject span{ 
		    padding-left: 30 px;
		    display: inline-block;
		    color: white;
		    font-size: 50px;
		    font-weight: bolder; 
		 }
	 
	 .content_totalCount_section{
	 	margin-bottom: 12px;
	 }
	 .subject_table{
		font-size: 14px;
	    line-height: 20px;
	    width: 100%;
	    text-align: center; 	
	 }

		 th{
		text-align: center;
	    color: #333;
	    border-bottom: 1px solid #e7e7e7;
	    border-top: 1px solid #3084d9;
	    background: #f4f9fd;
	    padding: 2px 0;	 
		 }
		.td_width_1{
			width: 5%;
		}	 	 	 
		.td_width_2{
			width: 10%;
		}	 	 
		.td_width_3{
			width: 25%;
		}	 
		.td_width_4{
			width: 15%;
		}	
		.cart_table{
			font-size: 14px;
			line-height: 20px;
		}  
			.cart_table tr{
				height: 110px;
			}
			.price_td{
				padding-left: 5px;
			}
				.red_color{
					color : red;
				}
				.green_color{
					color : green;
				}
			.cart_table td{
				border-bottom: 1px solid #e7e7e7;
			}
			.quantity_div{
				position: relative;
			    width: 42px;
			    height: 25px;
			    text-align: left;
			    margin: 5px auto;		
			}
			.quantity_input{
				position: absolute;
				width: 27px;
			    height: 23px;
			    text-align: center;
			    border: 1px solid #c6c6c6;
			    border-right: 0px;
			    line-height: 19px;
			    font-size: 12px;
			    color: #4c4848;	
			    left: 0;
			}
			.quantity_btn{
				position: absolute;
			    border: 1px solid #aaa;
			    color: #3a60df;
			    width: 14px;
			    height: 13px;
			    padding: 0px;
			    background-color: #fff;
			    font-weight: bold;
			    font-size: 7px;
			    line-height: 6px;
			    vertical-align: middle;	
			}
			.plus_btn{
				top: 0;
				right: 0
			}
			.minus_btn{
				bottom: 0;
				right: 0
			}		
			.quantity_modify_btn{
				border: 1px solid #d0d0d0;
			    height: 13px;
			    line-height: 13px;
			    background-color: #fff;
			    text-align: center;
			    width: 28px;
			    display: inline-block;
			    padding: 3px 6px 2px;
			    margin-top: 3px;		
			}
			.table_text_align_center{
				text-align: center;
			}
			.delete_btn{
				width: 40px;		
			}
		
	.content_total_section{
		    background-color: rgb(227, 237, 247);
	}		
		.total_wrap{
			width: 80%;
		    margin: auto;
		    padding: 10px 0 10px 0;	
		}
			.total_wrap td{
				width : 50%;
			}
			.finalTotalPrice_span{
				color: #854A72;
				font-size: 17px;
				font-weight: bold;
			}
			.totalPoint_span{
				font-size: 17px;
				font-weight: bold;		
			}
			.boundary_div{
				font-size: 0;
			    border: 1px dotted #d1c7c7;
			    margin: 5px 0 5px 0;		
			}
</style>
</head>
<body>

<c:if test="${empty role and role eq'user'  }">
		<c:redirect url="index.jsp"/>
	</c:if>
	
	
	<div style="width: 90%; margin: auto;">
	
			 <h3>::<B> 회원 예약 리스트</B></h3>
			<form action="" name="userInfoList">
		<table class="table table-light" style="height: auto; margin-top: 60px;">
		<thead>
			<tr>
				<th> 총 "<%=totalCount%>" 개의 예약</th>
			</tr>
		</thead>	
		<tbody>
		<tr style="margin: auto auto; ">
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
		<th> ▼ 정보보기 ▼</th>
		<th colspan="9">-</th>
		<th><a href="#" onclick="">예약 데이터 삭제 </a></th>
		</tr>
		
<c:forEach items="${rsList }" var="rsList"  varStatus="status" >
	<tr>
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
		<td>Check &nbsp;&nbsp;<input type="checkbox" value="${rsList.rs_no}" class="chcBox" name="chcBox"></td>
	
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
       <a href="Admin_UserInfoPro?page=1"> 처음 </a>
    <% }
    if (pg > 1) { %>
        <a href="Admin_UserInfoPro?page=<%=pg-1 %>"> 이전 </a>
    <% }
    for (int iCount = startPage; iCount <= endPage; iCount++) {
        if (iCount == pg) { %>
          <b><%=iCount %></b>&nbsp;
    <%} else {%>
          <a href="Admin_UserInfoPro?page=<%=iCount %>"> <%=iCount %> </a>&nbsp;
        <%} }  if (pg < totalPage) { %>
       <a href="Admin_UserInfoPro?page=<%=pg+1 %>" >다음</a>
    <%} if (endPage < totalPage) { %>
        <a href="Admin_UserInfoPro?page=<%=totalPage %>">끝</a>
    <%}%>
    		</div>
	</div>

		<!--   ///////////////////////////////////////////////////////  -->
		
<div class="content_totalCount_section">
				
				<table class="subject_table">
					<caption>표 제목 부분</caption>
					<tbody>

						<tr>
							<th class="td_width_1">-</th>
							<th class="td_width_2">-</th>
							<th class="td_width_3">룸Type</th>
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
					<%-- 	<c:forEach items="" var="ci"> --%>
					<c:set var="ACount"  value="${ACount }" />
							<tr align="center">
								<td class="td_width_1"></td>
								<td class="td_width_2" colspan="2"></td>  
								<td class="td_width_3"> 스탠다드 룸</td>
								<td class="td_width_4 ">${ACount } 회</td>
								<td class="td_width_4 table_text_align_center">--	</td>
								<td class="td_width_4 table_text_align_center"> 총가격 --	</td>
								<td class="td_width_4 table_text_align_center delete_btn"><button>합산</button></td>
							</tr>
					<c:set var="BCount"  value="${BCount }" />
							<tr align="center">
								<td class="td_width_1"></td>
								<td class="td_width_2" colspan="2"></td>  
								<td class="td_width_3"> 디럭스 룸</td>
								<td class="td_width_4 ">${BCount } 회</td>
								<td class="td_width_4 table_text_align_center">--	</td>
								<td class="td_width_4 table_text_align_center"> 총가격 --	</td>
								<td class="td_width_4 table_text_align_center delete_btn"><button>합산</button></td>
							</tr>
							<c:set var="CCount"  value="${CCount }" />
							<tr align="center">
								<td class="td_width_1"></td>
								<td class="td_width_2" colspan="2"></td>  
								<td class="td_width_3"> 스위트 룸</td>
								<td class="td_width_4 ">${CCount } 회</td>
								<td class="td_width_4 table_text_align_center">--	</td>
								<td class="td_width_4 table_text_align_center"> 총가격 --	</td>
								<td class="td_width_4 table_text_align_center delete_btn"><button>합산</button></td>
							</tr>
							<c:set var="ACount"  value="${DCount }" />
							<tr align="center">
								<td class="td_width_1"></td>
								<td class="td_width_2" colspan="2"></td>  
								<td class="td_width_3"> 스탠다드</td>
								<td class="td_width_4 ">${DCount } 회</td>
								<td class="td_width_4 table_text_align_center">--	</td>
								<td class="td_width_4 table_text_align_center"> 총가격 --	</td>
								<td class="td_width_4 table_text_align_center delete_btn"><button>합산</button></td>
							</tr>
					<%-- 	</c:forEach> --%>
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
										<td>총 상품 가격</td>
										<td>
											<span class="totalPrice_span">70000</span> 원
										</td>
									</tr>
									<tr>
										<td>배송비</td>
										<td>
											<span class="delivery_price">3000</span>원
										</td>
									</tr>									
									<tr>
										<td>총 주문 상품수</td>
										<td><span class="totalKind_span"></span>종 <span class="totalCount_span"></span>권</td>
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
					<div class="boundary_div">구분선</div>
					<table>
						<tr>
							<td>
								<table>
									<tbody>
										<tr>
											<td>
												<strong>총 결제 예상 금액</strong>
											</td>
											<td>
												<span class="finalTotalPrice_span">70000</span> 원
											</td>
										</tr>
									</tbody>
								</table>
							</td>
							<td>
								<table>
									<tbody>
										<tr>
											<td>
												<strong>총 적립 예상 마일리지</strong>
											
											</td>
											<td>
												<span class="totalPoint_span">70000</span> 원
											</td>
										</tr>
									</tbody>
								</table>
							</td>
						</tr>
					</table>
				</div>
			</div>


</body>
</html>