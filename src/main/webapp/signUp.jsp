<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String msg = request.getParameter("msg");
String emailCheck = request.getParameter("emailCheck");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
<link rel="stylesheet" href="./css/signupForm.css">

<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"> </script>
<script type="text/javascript" src="script/loginScript.js"></script>


</head>
<body>

	<div class="wrap wd668">
		<div class="container">
			<form action="" name="Join_form" method="post">
			<div class="form_txtInput">
				
				<h2 class="sub_tit_txt">회원가입</h2>
				<p class="exTxt">회원가입시 이메일 인증을 반드시 진행하셔야 합니다.</p>
				
				<div class="join_form">
					<table>
						<colgroup>
							<col width="30%" />
							<col width="auto" />
						</colgroup>
						<tbody>
							<tr>
								<th><span>아이디</span></th>
								<td><input type="text" id="id"name="id" placeholder="영문자+숫자만 입력 가능"> 
								<input type="hidden" name="ID_Duplication"value="ID_Uncheck" > 
								<font id="msg" style="font-size: 0.8em;"> &nbsp; <!--중복확인 문구 --></font></td>
							</tr>
							<tr>
								<th><span>이름</span></th>
								<td><input type="text" name="name" placeholder="홍길동"></td>
							</tr>
							<tr>
								<th><span>비밀번호</span></th>
								<td><input type="password" name="pw1" id="pw1" placeholder="비밀번호를 입력해주세요."></td>
							</tr>
							<tr>
								<th><span>비밀번호 확인</span></th>
								<td><input type="password" name="pw2" id="pw2" placeholder="비밀번호를 확인하세요">
								 <font id="check" style="font-size: 0.8em;"> &nbsp; <!--비밀번호 체크 문구  --></font></td>
							</tr>
							<tr>
								<th><span>휴대폰 번호</span></th>
								<td><select name="phone_value" class="phone_value">
							<option value="010">010</option>
							<option value="011">011</option>
							<option value="012">012</option>
							<option value="016">016</option>
					</select> <input type="text" class="telLength" name="tel_1" maxlength="4"
						onkeyup="moveNext(this,4,document.Join_form.tel_2)"> <span class="mar10"> - </span>
						<input type="text" class="telLength" name="tel_2" maxlength="4"
						onkeyup="moveNext(this,4,document.Join_form.email)"></td>
							</tr>
							<tr class="email">
								<th><span>이메일</span></th>
								<td>
									<input type="hidden" name="Email_Duplication" value="Email_Uncheck" >
									<input type="text" class="email" placeholder="이메일 입력" name="email" id="email">
										<span class="mar10">@</span> 
									<input type="text" class="email email2"	placeholder="직접입력"  name="email02" id="email02" value=""> 
									<select name="email_value" id="email_value" class="email_value" >
										<option value="1">직접입력</option>
										<option value="naver.com">naver.com</option>
										<option value="daum.com">daum.net</option>
										<option value="google.com">google.com</option>
										<option value="hotmail.com">hotmail.com</option>
										<option value="nate.com">nate.com</option>
										<option value="yahoo.co.kr">yahoo.co.kr</option>
										<option value="empas.com">empas.com</option>
									</select><br><br> <font id="emailCheck" style="font-size: 0.8em;"> &nbsp;&nbsp; <!--이메일 체크 문구  --></font> </td>
									<!-- <a href="javascript:;"	class="btn_confirm">인증번호 발송</a></td> -->
							</tr>
						<!-- 	<tr>
								<th><span>인증번호 확인</span></th>
								<td><input type="text" class="send_number"
									placeholder="10:00"> <a href="javascript:;"
									class="btn_confirm">인증번호 확인</a></td>
							</tr> -->
						</tbody>
					</table>
					<div class="exform_txt">
						<span>표시는 필수적으로 입력해주셔야 가입이 가능합니다.</span>
					</div>
				</div>
				<!-- join_form E  -->
				<div class="agree_wrap">
					<div class="checkbox_wrap">
						<input type="checkbox" id="news_letter" name="news_letter"
							class="agree_chk"> <label for="news_letter">[선택]뉴스레터
							수신동의</label>
					</div>
					<div class="checkbox_wrap mar27">
						<input type="checkbox" id="marketing" name="marketing"
							class="agree_chk"> <label for="marketing">[선택]마케팅
							목적 개인정보 수집 및 이용에 대한 동의</label>
						<ul class="explan_txt">
							<li><span class="red_txt">항목 : 성별, 생년월일</span></li>
							<li>고객님께서는 위의 개인정보 및 회원정보 수정 등을 통해 추가로 수집하는 개인정보에<br /> 대해
								동의하지 않거나 개인정보를 기재하지 않음으로써 거부하실 수 있습니다.<br /> 다만 이때 회원 대상 서비스가
								제한될 수 있습니다.
							</li>
						</ul>
					</div>
				</div>
				<div class="btn_wrap">
					<input type="submit" onclick="Check_value(); return false;" value="회원가입" class="submitBtn" >
				</div>
			</div>
			<!-- form_txtInput E -->
			</form>
		</div>
		<!-- content E-->
	</div>
	<!-- container E -->

</body>
</html>