<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
<link rel="stylesheet" href="./css/signupForm.css">
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
								<th><span>이름2</span></th>
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




	

<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"> </script>
	<script type="text/javascript">
$(document).ready(function() { 
    
    $("#id").focusout(function() {
        var id =  $.trim($("#id").val());
        var exp = /[a-z0-9]$/;
        
        if (id.length < 3 || id.length > 16){
        	$('#msg').html('<span style="color:red;"> 아이디는 4~16글자 내외 </span>');
        	$('#id').val('');
        	$('#id').focus();
        	return false ;
        }
        if (id == "" || id.length == 0) {
            alert("아이디를 입력해주세요");
            $('#id').val('');
            $('#id').focus();
            return false ;
        }
        if(!exp.test(id)){ 
        	alert("영문자와 숫자만 입력가능합니다.");
        	$('#id').val('');
        	$('#id').focus(); 
        	return false ; 
        }
       /*  alert(id); */
        $.ajax({
            type : "get",
            data : { id : id },
            url : "Ajax_ID_check",
            dataType: "json",
            success : function(result) {
            	if(result == 0){
                $("#msg").html("(!) 중복된 아이디. (사용불가)");
                $("#msg").attr("color","red");
                $('#id').val('');
            	$("#id").focus(); 
                return;
            	
            	}else {
            	$("#msg").html("사용 할 수 있는 아이디 입니다.  <button type='button' id='textBtn' class='id_btn' onclick='idbtn()'> 사용 </button>");
	            $("#msg").attr("color","blue");
	            return;
             	}
            },
          	  error: function () {	alert("서버 요청 실패");}
        });
    });
 }); 
$(function(){ //비밀번호 일치여부 
		$('#pw2').focusout(function(){
			 var pw1 =  $.trim($("#pw1").val());
			 var pw2 =  $.trim($("#pw2").val());
		
		if($('#pw1').val() == '' || $('#pw2').val() ==''){
		     $("#check").html("패스워드를 입력해주세요.");
		     $("#check").attr("color","red");
		     	  $('#pw2').val('');
		     	   return false;
		}
		if(pw1.length < 4 || pw1.length > 16){
		     $("#check").html("패스워드는 4~16글자 내외로 입력하세요.");
		     $("#check").attr("color","red");
		     	  $('#pw1').val('');
	         	  $('#pw1').focus();
		     	  return false;
		} 
		if($('#pw1').val() != $('#pw2').val()){
		    	if($('#pw2').val()!=''){
		      	   $("#check").html("(!)패스워드를 확인해 주세요.");
		     	   $("#check").attr("color","red");
		    	  	  $('#pw2').val('');
		         	  $('#pw2').focus();
		         	  return false;
		       	}
		}else{
		   	 $("#check").html("패스워드가 일치합니다.");
			 $("#check").attr("color","blue");
			return;
		    }
		})  	   
	});
	
	
//이메일 데이타에 중복여부 유효성.
$(document).ready(function() { 
	 $("#email_value").on("change",function(){
		 console.log("셀렉트 이벤트");
		 var email =  $.trim($("#email").val());
	        var email02 = $.trim($("#email02").val());
	        var exp = /[a-z0-9]$/;
	        var emailCheck = $("#emailCheck").val();
	       
	        var sumMail = email+"@"+email02
	        
	        emailCheck = "";
	        if (email.length <= 2 || email.length > 16){
	        	$('#emailCheck').html('<span style="color:red;">이메일은 3~16글자 내외 </span>');
	        	$('#email').val('');
	        	$('#email').focus();
	        	return false;
	        }else if (email == "" || email.length == 0) {
	        	$('#emailCheck').html('<span style="color:red;"> 이메일을 입력 해주세요. </span>');
	            $('#email').val('');
	            $('#email').focus();
	            return false;
	        }else if(!exp.test(email)){ 
	        	$('#emailCheck').html('<span style="color:red;">영문자와 숫자만 입력 가능합니다. </span>');
	        	$('#email').val('');
	        	$('#email').focus(); 
	        	return false; 
	        }else{
	         	$('#emailCheck').html('<span style="color:red;"> 이메일 유효성 검사 </span>');
	        }
	     
	        
	    $.ajax({   //이메일 아작스실패 ( '@' 포함되서 디비에 입력되는데, 아작스검사할때 스플릿해서 나누기 까지함.)
	            type : "post",
	            data : { "sumMail" : sumMail },
	            url : "Ajax_email_check",
	            dataType: "json",
	            async : false,       //순차적 처리 
	            success : function(result) {
	            	if(result == 0){
	                $("#emailCheck").html("(!) 중복된 이메일 (사용불가)");
	                $("#emailCheck").attr("color","red");
	                $('#email').val('');
	            	$("#email").focus(); 
	                return;
	            	
	            	}else {
	            	$("#emailCheck").html("사용 할 수 있는 이메일 입니다.  <button type='button' id='EmailBtn' class='email_btn' onclick='EmailBtn()'> 사용 </button>");
		            $("#emailCheck").attr("color","blue");
		            return;
	             	}
	            },
	          	  error: function () {	alert("서버 요청 실패");}
	        });
	 });
	 
	
    //이메일 주소까지 입력이 끝났으면 이벤트.
    $("#email02").change(function() {
    	console.log("evnet 자공");
        var email =  $.trim($("#email").val());
        var email02 = $.trim($("#email02").val());
        var exp = /[a-z0-9]$/;
        var emailCheck = $("#emailCheck").val();
       
        var sumMail = email+"@"+email02
        
        emailCheck = "";
        if (email.length <= 2 || email.length > 16){
        	$('#emailCheck').html('<span style="color:red;">이메일은 3~16글자 내외 </span>');
        	$('#email').val('');
        	$('#email').focus();
        	return false;
        }else if (email == "" || email.length == 0) {
        	$('#emailCheck').html('<span style="color:red;"> 이메일을 입력 해주세요. </span>');
            $('#email').val('');
            $('#email').focus();
            return false;
        }else if(!exp.test(email)){ 
        	$('#emailCheck').html('<span style="color:red;">영문자와 숫자만 입력 가능합니다. </span>');
        	$('#email').val('');
        	$('#email').focus(); 
        	return false; 
        }else{
         	$('#emailCheck').html('<span style="color:red;"> 이메일 유효성 검사 </span>');
        }
     
        
    $.ajax({   //이메일 아작스실패 ( '@' 포함되서 디비에 입력되는데, 아작스검사할때 스플릿해서 나누기 까지함.)
            type : "post",
            data : { "sumMail" : sumMail },
            url : "Ajax_email_check",
            dataType: "json",
            async : false,       //순차적 처리 
            success : function(result) {
            	if(result == 0){
                $("#emailCheck").html("(!) 중복된 이메일 (사용불가)");
                $("#emailCheck").attr("color","red");
                $('#email').val('');
            	$("#email").focus(); 
                return;
            	
            	}else {
            	$("#emailCheck").html("사용 할 수 있는 이메일 입니다.  <button type='button' id='EmailBtn' class='email_btn' onclick='EmailBtn()'> 사용 </button>");
	            $("#emailCheck").attr("color","blue");
	            return;
             	}
            },
          	  error: function () {	alert("서버 요청 실패");}
        });
    }); 
 });   
 
 
 
 
 
 
// 이메일 셀렉터 직접입력시 화면 비활성화 시키기.
$('#email_value').change(function(){ $("#email_value option:selected").each(function () { 
	if($(this).val()== '1'){ 				  //직접입력일 경우 
		$("#email02").val('');			      //값 초기화 
 		$("#email02").attr("disabled",false);   //활성화 
	}else{ 									  //직접입력이 아닐경우 
	$("#email02").val($(this).text()); 			//선택값 입력 
 /* 	$("#email02").attr("disabled",true); */ 		  //비활성화  
	}  
	}); 
});
</script>


	<script type="text/javascript">
	
function idbtn(){    //아이디사용가능 버튼 클릭시 이벤트   //"사용" 버튼누르면 버튼을 숨기고, 히든값 변경
	 document.Join_form.ID_Duplication.value ="ID_check";
	 document.getElementById("textBtn").style.display="none";   
}
function EmailBtn(){    //아이디사용가능 버튼 클릭시 이벤트   //"사용" 버튼누르면 버튼을 숨기고, 히든값 변경
	 document.Join_form.Email_Duplication.value ="Email_check";
	 document.getElementById("EmailBtn").style.display="none";   
}


function erase(obj){   //휴대폰번호 4자리입시 자동으로 다음칸
	  obj.value="";
	  obj.focus();
	 }
function moveNext(obj,length,nextObj){
	  if(obj.value.length==length){
	   nextObj.focus(); 
	  }}

//-최종- 폼 전송전 유효성 검사
function Check_value() {
 	var form = document.Join_form;
	
 	if(form.ID_Duplication.value != "ID_check"){  //아이디 중복체크 클릭 이벤트.
			alert("아이디 중복체크를 해주세요.");
			return;
	} 
	if(form.Email_Duplication.value != "Email_check"){  //이메일 중복체크 클릭 이벤트.
		alert("이메일 중복체크를 해주세요.");
		return;
	} 
	else if(!form.pw1.value ){
		alert("비밀번호를 입력하세요.");
		form.pw1.focus();
		return;
	}
	else if(form.pw2.value != form.pw1.value){
		alert("비밀번호가 맞는지 확인해주세요. ");
		form.pw2.focus();
		return;
	}
	else if(!form.name.value){
		alert("이름을 입력하세요.");
		form.name.focus();
		return;
	}
	else if(isNaN(form.tel_1.value) || isNaN(form.tel_2.value) ){
		alert("핸드폰 번호는 숫자만 입력 가능합니다.");
		return;
	}
	 else if(!form.email.value){
		alert("이메일을 입력하세요.");
		form.email.focus();
		return;
	}else{
		document.Join_form.method="post";
		document.Join_form.action="Insert_Signup";
		document.Join_form.submit();
	}}
</script>


</body>
</html>