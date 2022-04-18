<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.company.Vo.replyVo"%>
<%@page import="com.company.Vo.BoardVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${empty name}">
	<c:redirect url="index.jsp?filePath=./login_check/login_main"/>
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 클릭했을때 화면 폼 (게시글 상세페이지)</title>
<link	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="./css/FormDesign.css">
<link rel="stylesheet"	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>



	<c:set target="${vo}" var="vo" value="${vo}" />
	<h2 align="center">상세 페이지</h2>
	<br>
	<br>

	<div id="container" align="center">
		<form action="Get_Board_Modify?num=${vo.seq }" method="post"
			id="add_Form">

			<h4>${vo.userid }님의 게시글</h4>
			<input type="hidden" name="seq" value="${vo.seq }"> <input
				type="hidden" name="userid" value="${vo.userid }">
			<!-- 화면에는 보이지 앉지만 키값으로 넘겨서 데이타뿌려줘야할떄 히든처리  -->

			<table class="table" style="width: 800px">
				<tr>
					<th>제목</th>
					<td align="left"><input type="text" name="title"
						value="${vo.title }" class="form-control" readonly="readonly">
					
					<c:if test="${reply.size() > 0}">
					 <i class="fa-regular fa-comment-dots"> 댓글이 등록 되었습니다. </i>
					</c:if>
					</td>
				</tr>

				<tr>
					<th>작성자</th>
					<td align="left"><input type="text" name="nickname"
						value="${vo.nickname }" class="form-control" readonly="readonly"></td>
				</tr>

				<tr>
					<th>내용</th>
					<td align="left" style="height: 150px;">${vo.content } <input
						type="hidden" name="content" value="${vo.content }">
					</td>
				</tr>

				<tr>
					<th>등록</th>
					<td align="left">${vo.regdate }</td>
				</tr>

				<tr>
					<th>조회수</th>
					<td align="left">${vo.cnt }</td>
				</tr>

				<tr>
					<td colspan="2" align="center"><c:if test="${!empty name }">
							<c:set target="${vo.userid }" var="user" value="${vo.userid }" />
							<c:if test="${id ==user or role eq'admin'}">
								<!--로그인한 아이디와, 게시글의 아이디가 같거나 관리자이면, -->
								<input type="submit" value="글수정" class="btn btn-outline-dark"
									id="TAbtn">
								<input type="button"
									onclick="location.href='Delete_Board_Pro?num=${vo.seq}'"
									value="글삭제" class="btn btn-outline-danger">
							</c:if>
						</c:if> <input type="button" value="글목록"
						onclick="location.href='Get_Board_List_Pro'"
						class="btn btn-outline-primary"></td>
				</tr>
			</table>
		</form>
		<br>
		<!--댓글 작성창 -->
		<div>
			<form action="" name="replyForm">
				<table>
					<tr>
						<th colspan="2" style="vertical-align: top;">
							<!--댓글의 닉네임은 로그인한 회원의 이름으로 고정값.  --> <input type="text"
							name="nickname" value="${name}" readonly="readonly"
							style="border: none; text-align: center;"> <input
							type="hidden" name="seq" value="${vo.seq }">
						<td><textarea rows="3" cols="65" name="comments"
								placeholder="댓글을 입력하세요." style="padding: 10px 15px;">
							</textarea></td>
					</tr>
					<tr>
						<td colspan="3" align="right"><input type="button"
							class="btn btn-primary" value="댓글등록"
							onclick="reply();return false;"></td>
					</tr>
				</table>
			</form>
		</div>
		<hr>
		<i class="fa-solid fa-arrow-turn-down-right"></i>
		<!-- 댓글 목록  -->
		<c:choose>
			<c:when test="${reply.size() > 0 }">
				<c:forEach items="${reply}" var="reply">
					<table class="table table-striped table-hover"
						style="line-height: 25px; width: 800px;">
						<tr>
							<td style="height: auto"><i
								class="fa-regular fa-comment-dots"></i> <font
								style="color: green; font-weight: 800;"> ${reply.nickname }</font>
								&nbsp;|&nbsp;&nbsp; <small style="color: #bbb;">${reply.regdate }</small>
								<br> &nbsp;&nbsp;&nbsp;<i class="fa-solid fa-angles-right"></i>
								&nbsp;&nbsp;${reply.comments } <!--작성된 내용 (댓글내용) --></td>


							<!--대 댓글 입력  -->
							<td width="80" style="font-size: 0.8em; padding-top: 20px;"><a
								href="#" style="color: blue" onclick="reReply();return false;">
									답글달기 </a></td>
							<c:if test="${!empty name }">
								<c:set value="${reply.nickname }" var="nickname" />
								<c:if test="${name == nickname }">
									<td width="50" style="font-size: 0.8em; padding-top: 20px;">
										<a
										href="DeleteReply?replyseq=${reply.replyseq }&&nickname=${reply.nickname }&&boardseq=${vo.seq}"
										style="color: red;"> 삭제 </a>
									</td>
								</c:if>
							</c:if>
						</tr>

						<tr class="items" style="clear: both;">
							<!-- <td class="item">
			<span class="itemText"> hello  </span>
			<button class="itemDel"> X </button> </td>-->
						</tr>

						<tr class="rereply" style="float: right; display: none;">
							<td align="right"><input type="text" name="itemAdd"
								class="input">
								<button type="button" class="itemAdd">입력</button></td>
						</tr>
					</table>

				</c:forEach>
			</c:when>
				<c:otherwise>
					<p style="text-align: center;">등록된 댓글이 없습니다.</p>
				</c:otherwise>
		</c:choose>
	</div>




	<script type="text/javascript"
		src="./smarteditor2/demo/js/service/HuskyEZCreator.js" charset="utf-8">  </script>
	<script type="text/javascript"
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js">  </script>

	<script type="text/javascript">
	function reply() {
		var replyContent = document.replyForm.comments.value;

		if (replyContent.length == 0 || replyContent.value == "") {
			alert("답글을 작성하지 않았습니다.");
		} else {
			document.replyForm.action = "ReplyPro";
			document.replyForm.method = "post";
			document.replyForm.submit();
		}
	}

	
			// 네이버 에디터 게시판 시작 
	var oEditors = [];
	$(function() {
		nhn.husky.EZCreator.createInIFrame({
			oAppRef : oEditors,
			elPlaceHolder : "content",
			//SmartEditor2Skin.html 파일이 존재하는 경로
			sSkinURI : "./smarteditor2/demo/SmartEditor2Skin.html",
			htParams : {
				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseToolbar : true,
				// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseVerticalResizer : true,
				// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
				bUseModeChanger : true,
				fOnBeforeUnload : function() {
				}
			},
			fCreator : "createSEditor2"
		});
	})
	$("#TAbtn").click(function(){ 
			// id가 smarteditor인 textarea에 에디터에서 대입 
			oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []); 
		// 이부분에 에디터 validation 검증 
		if(validation()) { $("#add_Form").submit(); 
		} 
	}); 
function validation(){ 
	var contents = $.trim(oEditors[0].getContents()); 
		if(contents === '<p>&bnsp;</p>' || contents === ''){ 
			// 기본적으로 아무것도 입력하지 않아도 값이 입력되어 있음. 
			alert("내용을 입력하세요."); 
			oEditors.getById['content'].exec('FOCUS'); 
			return false; } 
		return true; }
	
	
	
	
	
/* 	parent(). */     /* 대댓글 삽입하는 스크립 */
const input = document.querySelector('.input');
const itemAdd = document.querySelector('.itemAdd');
const items = document.querySelector('.items');

const onAdd = () => {
	const text = input.value;
	console.log(text);
	
	if(input.value === ''){
		input.focus();
		alert("댓글입력");
		return;
	}
const item = document.createElement('tr');
item.setAttribute('class', 'item');

const itemText = document.createElement('span');
itemText.innerHTML = text;

const itemDel = document.createElement('button');
itemDel.setAttribute('class', 'itemDel');
itemDel.innerHTML = 'X';
itemDel.addEventListener('click', () => {
	items.removeChild(item);
});

item.appendChild(itemText);
item.appendChild(itemDel);
items.appendChild(item);
input.value = '';
input.focus();
};

itemAdd.addEventListener('click', () => {
	onAdd();
});

input.addEventListener('keypress',(event)=> {
	if (event.key === 'Enter') {
		onAdd();
	}
	return;
});

	function reReply() {
		if($('.rereply').css('display')== 'none'){
			$('.rereply').css('display' , 'block');
		}else if($('.rereply').css('display')=='block'){
			$('.rereply').css('display', 'none');
		}
	}
		
</script>



</body>
</html>