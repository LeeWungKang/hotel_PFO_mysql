<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 고객의소리 상세 화면 </title>
<link href="./css/inquiryCss.css" rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
	<link rel="stylesheet"	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
	
	<div id="containerBox" style="height: auto; margin: auto; box-sizing: border-box; width: 1300px; padding-left: 120px;">
	

			<div class="inquiryBox1" style="width: 100%; margin: auto auto; margin-top: 100px; ">
				<h3 align="left">:: <i class="fa-solid fa-child"></i> 고객의 소리 </h3>
				<table class="table table-hover" style="width: 90%; text-align: center;">
					<tr class="table-dark">
						<th width="200">작성날짜</th>
						<th width="200" colspan="2">제목</th>
					</tr>
					<c:choose>
						<c:when test="${ iqList.size() > 0}">
							<c:forEach items="${iqList}" var="B" varStatus="status">
								<tr> 
									<td style="font-size: 0.8em;">${status.count } ♥ ${B.b_writedate }</td>
									<td style="border-left: 5px solid black;"><a href="getUserInquiry?num=${B.b_no }">${B.b_title } </a></td>
								</tr>
						<tr class="table-dark">
							<th width="20px;">글 번호</th>
							<th width="200" colspan="2" >내용</th>
						</tr>
						<tr>
							<td width="20px;">${B.b_no} </td>
							<td align="left" colspan="2" style="border-left: 5px solid black;"> ::&nbsp;&nbsp;&nbsp;   ${B.b_content } </td>
						</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<th colspan="4"><i class="fa-regular fa-bell-slash"></i>
									문의하신 내용이 없습니다.</th>
							</tr>
						</c:otherwise>
					</c:choose>
				</table>
		</div>
		
		
<div style="width: 80%; height: auto;  padding-left: 200px; margin-top: 60px;">

				<h2> ::  <i class="fa-solid fa-user-gear"></i> 관리자 답변 </h2>
			<table border="1" style="width: 100%; margin: auto;">
<c:choose>
		<c:when test="${iqReList.size() > 0 }">
			<c:forEach items="${iqReList}" var="R">
				<tr>
				<td></td>
					<td colspan="4" id="comment commensty">
					<font color="gray" 	size="2"> 문의번호 : ${R.ir_seq} &nbsp; | &nbsp;&nbsp;
							작성날짜 : ${R.ir_regdate }</font> <br />

						<div id="showContent" style="white-space: pre-line; background-color: silver; padding: 15px;">
							<c:out value="${R.ir_comments}"></c:out>
							<br/>
						</div> 
					</td>
				</tr>
			</c:forEach>
		</c:when>
		
			<c:otherwise>
					<tr>
						<th> 작성된 답변이 아직 없습니다.</th>
					</tr>
			</c:otherwise>
	</c:choose>
		</table>
</div>


</div>



</body>
</html>