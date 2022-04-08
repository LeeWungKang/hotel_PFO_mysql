<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.company.Vo.replyVo"%>
<%@page import="com.company.Vo.BoardVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String name = (String) session.getAttribute("name");
String role = (String) session.getAttribute("role");
String id = (String)session.getAttribute("id");
if (name == null) {
	response.sendRedirect("index.jsp?filePath=./login_check/login_main"); //도메인주소로 강제로 접속하려는사람을 막아줌. 로그인으로 들어온사람만 접속하게함.
	return;
}
BoardVo vo = (BoardVo) request.getAttribute("vo");
ArrayList<replyVo> reply = (ArrayList<replyVo>) request.getAttribute("reply");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
							<title> 클릭한 게시글주인 - 수정페이지 </title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"	crossorigin="anonymous">
<link rel="stylesheet" href="./css/FormDesign.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>

	<h2 align="center" style="margin-top: 50px;">상세 페이지 글수정 페이지. </h2>
	<br>
	<br>

	<div id="container" style="margin: auto auto; padding-bottom: 50px;">
		
		<form action="Update_Board?seq=<%=vo.getSeq()%>" method="post"
			id="add_Form">

			<input type="hidden" name="seq" value="<%=vo.getSeq()%>">
			<input type="hidden" name="userid" value="<%=vo.getUserid()%>">
			<!-- 화면에는 보이지 앉지만 키값으로 넘겨서 데이타뿌려줘야할떄 히든처리  -->

			<table class="table" style="width: 800px">
				<tr>
					<th>제목</th>
					<td align="left"><input type="text" name="title"
						value="<%=vo.getTitle()%>" class="form-control"></td>
				</tr>

				<tr>
					<th>작성자</th>
					<td align="left"><input type="text" name="nickname"
						value="<%=vo.getNickname()%>" class="form-control"></td>
				</tr>

				<tr>
					<th>내용</th>
					<td align="left"><textarea name="content" class="form-control"	id="content">
					 <%=vo.getContent()%>  </textarea></td>
				</tr>

				<tr>
					<th>등록</th>
					<td align="left"><%=vo.getRegdate()%></td>
				</tr>

				<tr>
					<th>조회수</th>
					<td align="left"><%=vo.getCnt()%></td>
				</tr>

				<tr>
					<td colspan="2" align="center">
						<%if(name != null){ if(id.equals(vo.getUserid()) || role.equals("admin")){ %>
						<input type="submit" value="글수정" class="btn btn-outline-dark"
						id="TAbtn"> <input type="button"
						onclick="location.href='Delete_Board_Pro?num=<%=vo.getSeq()%>'"
						value="글삭제" class="btn btn-outline-danger"> 
						<%}} %> 
						<input type="button" value="글목록"	onclick="location.href='Get_Board_List_Pro'"
						class="btn btn-outline-primary">
					</td>
				</tr>
			</table>
		</form>
		<br>
		<!--댓글 작성창 -->
			<form action="" name="replyForm" class="replyform2">
				<table>
					<tr>
						<th colspan="2" style="vertical-align: top;">
							<!--댓글의 닉네임은 로그인한 회원의 이름으로 고정값.  --> <input type="text"
							name="nickname" value="${name}" readonly="readonly"
							style="border: none; text-align: center;"> <input
							type="hidden" name="seq" value="<%=vo.getSeq()%>">
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
		<hr>
		<i class="fa-solid fa-arrow-turn-down-right"></i>
		<!-- 댓글 목록  -->
		<%
		for (int i = 0; i < reply.size(); i++) {
			replyVo replyvo = reply.get(i);
		%>


		<table class="table table-striped table-hover"
			style="line-height: 25px;">
			<tr>
				<td style="height: auto"><font
					style="color: green; font-weight: 800;"> <%=replyvo.getNickname()%>
				</font> &nbsp;|&nbsp;&nbsp; <!--작성자 이름  --> <small style="color: #bbb;">
						<%=replyvo.getRegdate()%>
				</small> <br> <!--작성된 날짜+시간  --> <i class="fa-solid fa-angles-right"></i>
					&nbsp;&nbsp;<%=replyvo.getComments()%> <!--작성된 내용 (댓글내용) --></td>


				<!--대 댓글 입력  -->
				<td width="80" style="font-size: 0.8em; padding-top: 20px;"><a
					href="#" style="color: blue" onclick="reReply();return false;">
						답글달기 </a></td>
				<%if( name != null){ if(name.equals(replyvo.getNickname()) ){  %>
				<!--로그인한 회원의 이름과 댓글이름이 같을떄만 삭제버튼 활성화.  -->
				<td width="50" style="font-size: 0.8em; padding-top: 20px;"><a
					href="DeleteReply?replyseq=<%=replyvo.getReplyseq()%>&&nickname=<%=replyvo.getNickname()%>&&boardseq=<%=vo.getSeq() %>"
					style="color: red;"> 삭제 </a></td>
				<%}} %>
			</tr>

			<tr class="items" style="clear: both;">
				<!-- <td class="item">
			<span class="itemText"> hello  </span>
			<button class="itemDel"> X </button> -->
				</td>
			</tr>

			<tr class="rereply" style="float: right; display: none;">
				<td align="right"><input type="text" name="itemAdd"
					class="input">
					<button type="button" class="itemAdd">입력</button></td>
			</tr>
		</table>
		<%} if (reply.size() == 0) {	%>
		<p style="text-align: center;">등록된 댓글이 없습니다.</p>
		<%}%>

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
	
	
	
	
		
</script>



</body>
</html>