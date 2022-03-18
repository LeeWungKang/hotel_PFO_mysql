<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
//로그인 없이 들어온 유저를 다시 로그인창으로 보내줌. 
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

		<form action="Add_Insert" method="post" name="add_form" class="add_form">
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
					<td ><input type="text" name="name"
						value="<%=name%>" class="form-control"
						readonly="readonly"></td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th scope="row">내용</th>
					<td class="even" colspan="3"><textarea rows="10" cols="90" name="content"
							onchange="check_text()">  </textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="4" align="center"><input type="submit"
						value="게시물 등록" class="btn"></td>
				</tr>
			</tfoot>
			</table>

		</form>
		<hr>
		<A href="Get_Board_List_Pro"> 글 목록 </A>

	</div>

	<script type="text/javascript">
		function check_text() {
			var content = document.add_form.content;

			if (content.length < 1 || content.value == "") {
				alert("게시글을 한글자 이상 작성해주세요.");
				document.add_form.content.focus();
				return;
			}
		}
	</script>
</body>
</html>