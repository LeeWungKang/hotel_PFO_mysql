<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객 문의 상세 페이지 .</title>
<link href="./css/inquiryCss.css" rel="stylesheet">
</head>
<body>
	<c:set value="${vo}" target="${vo}" var="vo" />
	<div id="reserveTitle">
		<font size="8">"${vo.b_userid}" 님의 문의글 </font>
	</div>

	<form action="inquiryDelete" method="get">
		<table align="center" class="inquiryDetail">
			<tr>
				<td id="detail">제목</td>
				<td>${vo.b_title}</td>
				<td id="detail">번호</td>
				<td>${vo.b_no}<input type="hidden" name="b_no"
					value="${vo.b_no}" />
				</td>
			</tr>
			<tr>
				<td id="detail">작성자</td>
				<td>${vo.b_userid}</td>
				<td id="detail">작성일</td>
				<td>${vo.b_writedate }</td>

			</tr>
			<tr>
				<td id="detailcontent">내용</td>
				<td colspan="3"><textarea rows="5" cols="30"
						id="detailtextarea" readonly="readonly" name="b_content">${vo.b_content}</textarea>
				</td>
			</tr>

			<tr align="center">
				<td colspan="4"><input type="button" value="목록"
					onclick="location.href='Admin_InquiryPro'" /></td>
			</tr>
	</form>

	<c:choose>
		<c:when test="${iqList.size() > 0 }">
			<c:forEach items="${iqList }" var="iqList">
				<tr>
					<td colspan="4" id="comment commensty"><font color="gray"
						size="2"> 문의번호 : ${iqList.ir_seq} &nbsp; | &nbsp;&nbsp;
							작성날짜 : ${iqList.ir_regdate }</font> <br />

						<div id="showContent" style="white-space: pre-line;">
							<c:out value="${iqList.ir_comments}"></c:out>
							<br />
						</div> <c:if test="${iqList.ir_role eq '관리자' }">
							<div id="showContent" align="right">
								<input type="button" value="수정" id="commentBtn"
									onclick="showDesc(${iqList.ir_no})" /> <input type="button"
									value="삭제" id="commentBtn"
									onclick="location.href='AdminCommentDelete?ir_seq=${iqList.ir_seq}&ir_no=${iqList.ir_no}'" />
							</div>
						</c:if></td>
				</tr>
			</c:forEach>
		</c:when>
	</c:choose>
	<tr>
		<td colspan="4" id="commentWrite">
			<form action="AdminCommentWrite" method="post">
				<textarea rows="6" cols="100" name="ir_comments" required="required"
					placeholder="소중한 댓글을 작성해주시길 바랍니다." style="padding: 12px;"></textarea>
				<input type="hidden" name="ir_seq" value="${vo.b_no}"> <input
					type="submit" value="댓글 작성" id="commentWriteBtn" />
			</form>
		</td>
	</tr>
	</table>

</body>
</html>