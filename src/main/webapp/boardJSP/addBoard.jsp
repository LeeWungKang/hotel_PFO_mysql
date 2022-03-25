<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%

//로그인 없이 들어온 유저를 다시 로그인창으로 보내줌. 
String id = (String) session.getAttribute("id");
String name = (String) session.getAttribute("name");
if (name == null) {
	response.sendRedirect("index.jsp");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>새글 등록</title>
<!-- <link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">  부트스트랩 -->

<link rel="stylesheet" href="./css/addboard.css">
<!-- 폰트어썸 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js">
<!-- 폰트어썸 -->
</head>
<body>

	<h2 align="center">새 게시글 쓰기</h2>
	<br>

	<div align="center" style="margin: auto auto;" class="container">

		<form action="Add_Insert" method="post" name="add_form" class="add_form" id="add_form">
			<table class="type10" border="1">
			<thead>
				<tr>
					<th scope="cols">제목</th>
					<td colspan="3"><input type="text" name="title" value=""
						class="form-control" placeholder="제목 입력"></td>
				</tr>
				<tr>
					<th scope="cols">닉네임</th>
					<td ><input type="text" name="nickname" class="form-control" placeholder="닉네임 입력">
					</td>
					<th scope="cols">작성자</th>
					<td >
					<input type="text" name="name"	value="<%=name%>" class="form-control"	readonly="readonly">
					<input type="hidden" name="userid" value="<%=id%>">
					</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th scope="row">내용</th>
					<td class="even" colspan="3">
						<textarea rows="10" cols="90" id="content" name="content" onchange="check_text()">  </textarea>
					</td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="4" align="center">
					<input type="submit" value="게시물 등록" class="btn" id="TAbtn"></td>
				</tr>
			</tfoot>
			</table>

		</form>
		<hr>
		<A href="Get_Board_List_Pro"> 글 목록 </A>

	</div>

	<script type="text/javascript" src="./smarteditor2/demo/js/service/HuskyEZCreator.js" charset="utf-8">  </script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" >  </script>
	
	
	<script type="text/javascript">
	//네이버 에디터 
	
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
		if(validation()) { $("#add_form").submit(); 
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