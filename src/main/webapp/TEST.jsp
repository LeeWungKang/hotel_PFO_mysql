<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	<%
/* 
	String year = request.getParameter("year");
    String month = request.getParameter("month");
    String day = request.getParameter("day");
    String date ="";
    date += year;
    date += month;
    date += day;
	 */
	 
	 String date =(String) request.getAttribute("date");
	%>
	
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>



	<div align="center" style="margin: auto auto;" class="FormBG">


		<input type="text" value="<%=date%>"> ㅇㅇㅇ추출 날짜  : <%=date%>


		<ul class="items">
			<!-- <li class="item">
			<span class="itemText"> hello  </span>
			<button class="itemDel"> X </button> -->
			<!-- </li> --> -->
		</ul>
				
			<input type="text" class="input" value=""> 
			<button class="itemAdd"> 입력 </button>
----------------------------------------------------------------------------------------------


<!-- 날짜 변화에 따른  일수 계산해서, 스크립트로 지정된 가격만큼 올라가게하기.  -->

		 <input type="date" value="체크인" min="" name="rs_checkin" onchange="CCC()"> 체크인  
 		<input type="date" value="체크아웃" name="rs_checkout" onchange="CCC()"> 체크아웃 
 		
 			<input type="text" value="50000"> 1박 (   ) 원

		<script type="text/javascript">
		
		function name() {
			
		}
		
		
		
		
		
		
		
		
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
const item = document.createElement('li');
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




</script>









		<h2>
			<B>간편 회원가입</B>
		</h2>
		<hr>
		<br> <br>


		<form action="" name="Join_form" method="post">
			<table class="table" border="1" style="width: 60%;">
				<tr>
					<th align="right">아이디 : <span
						style="font-size: 0.8em; color: red">*</span></th>
					<td colspan="2" width="100px;"><input type="text" id="id"
						name="id"> <input type="hidden" name="ID_Duplication"
						value="ID_Uncheck"> <font id="msg"
						style="font-size: 0.7em;"> &nbsp; <!--중복확인 문구 -->
					</font></td>
				</tr>

				<tr>
					<th align="right">비밀번호 : <span
						style="font-size: 0.8em; color: red">*</span></th>
					<td><input type="password" name="pw1" id="pw1"></td>
				</tr>
				<tr>
					<th align="right">비밀번호 확인 : <span
						style="font-size: 0.8em; color: red">*</span></th>
					<td colspan="2" width="100px;"><input type="password"
						name="pw2" id="pw2"> <font id="check"
						style="font-size: 0.7em;"> &nbsp; <!--비밀번호 체크 문구  --></font></td>

				</tr>
				<tr>
					<th align="right">이름 : <span
						style="font-size: 0.8em; color: red">*</span></th>
					<td><input type="text" name="name"></td>
				</tr>


				<tr>
					<th align="right">핸드폰 번호 : <span
						style="font-size: 0.8em; color: red">*</span></th>
					<td><select name="phone_value">
							<option value="010">010</option>
							<option value="011">011</option>
							<option value="012">012</option>
							<option value="016">016</option>
					</select> <input type="text" class="telLength" name="tel_1" maxlength="4"
						onkeyup="moveNext(this,4,document.Join_form.tel_2)"> - <input
						type="text" class="telLength" name="tel_2" maxlength="4"
						onkeyup="moveNext(this,4,document.Join_form.email)"></td>
				</tr>

				<tr>
					<th align="right">이메일 : <span
						style="font-size: 0.8em; color: red">*</span></th>
					<td><input type="text" placeholder="이메일입력" name="email"
						id="email" oninput="initcheckEmail()"> @ <input
						type="text" name="email02" id="email02" style="width: 100px;"
						value=""> <select name="email_value" id="email_value">
							<option value="1">직접입력</option>
							<option value="naver.com">naver.com</option>
							<option value="daum.com">daum.net</option>
							<option value="google.com">google.com</option>
							<option value="hotmail.com">hotmail.com</option>
							<option value="nate.com">nate.com</option>
							<option value="yahoo.co.kr">yahoo.co.kr</option>
							<option value="empas.com">empas.com</option>
					</select></td>
				</tr>
				<tr>
					<td align="center" colspan="2"><font id="emailCheck"
						style="font-size: 0.8em;"> </font></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="submit"
						value="회원가입" onclick="Check_value(); return false;"
						class="btn btn-success"> <input type="reset" value="다시쓰기"
						class="btn btn-warning"></td>
				</tr>

			</table>
		</form>
	</div>















</body>
</html>