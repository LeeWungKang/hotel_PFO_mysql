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
<link href="https://unpkg.com/bootstrap@3.3.7/dist/css/bootstrap.min.css"rel="stylesheet" >

<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<!--css, js 파일을 다운받아서 넣어서 쓰는 방법  -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.js" integrity="sha512-n/4gHW3atM3QqRcbCn6ewmpxcLAHGaDjpEBu4xZd47N0W2oQ+6q7oc3PXstrJYXcbNU1OHdQ1T7pAP+gi5Yu8g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">7 -->


<script type="text/javascript">
$(document).ready(function() { 
    
    $("#id").focusout(function() {

        var id =  $.trim($("#id").val());
        var exp = /[a-z0-9]$/;
        
        if (id.length < 4){
        	$('#msg').html('<span style="color:red;"> 아이디는 4글자 이상 </span>');
        	return ;
        }
        
        if (id == "" || id.length == 0) {
            alert("아이디를 입력해주세요");
            $("#id").focus();
            return ;
        }
        
        if(!exp.test(id)){ 
        	alert("영문자와 숫자만 입력가능합니다."); 
        	$("#userid").focus(); 
        	return; 
        }

//$반복 var exp = /[a-z0-9]$/; //영문자와 숫자 //정규표현식. test(입력값) 규칙에 맞으면 true if(!exp.test(userid)){ alert("영문자와 숫자만 입력가능합니다."); $("#userid").focus(); return; }
//비동기 ajax 방식으로 데이터 주고 받기 방버버

       /*  alert(id); */
        
        $.ajax({
            
            type : "get",
            data : { id : id },
            url : "Idcheck",
            dataType: "json",
            success : function(result) {
            	if(result == 0){
                $("#msg").html("(!) 중복된 아이디. (사용불가)");
                $("#msg").attr("color","red");
                return;
            	
            	}else {
            	$("#msg").html("사용 할 수 있는 아이디 입니다.");
	            $("#msg").attr("color","green");
	           /*  $("#msg").html("<button type='button' id='textBtn'> 버튼</button>"); */
	            	 return;
             	}
            },
          	  error: function () {
				alert("서버 요청 실패");						
				}

        });
    });

 }); 

</script>
</head>
<body>

	<div align="center" style="margin: auto auto;">
	<h2> <B>간편 회원가입</B> </h2>
		<hr><br> <br>


<form action="" name="Join_form" method="post">
	<table class="table">
				<!--'키다운'이벤트를 설정하는건, 사용자가 중복체크를 하고 난뒤, 아이디입력란에 사용가능(체크완료)한 아이디를 지우고 다른 아이디를 작성하는걸 방지하기 위함.  -->
				<!-- 중복체크버튼을 클릭해야지만 완료될수있게 기능추가.  -->
		<tr><th align="right"><span style="font-size: 0.7em;">*</span> 아이디:</th>
			<td>
				 <input type="text" id="id" name="id" >
				 <div><font id="msg" style="font-size: 0.8em;"> </font></div> 
				 <input type="hidden" name="ID_Duplication" value="ID_Uncheck">
			</td>	</tr>


		<tr><th align="right"><span style="font-size: 0.7em;">*</span>비밀번호 :</th>
			<td><input type="password" name="pw_1" onchange="check_pw()"></td>	</tr>


		<tr><th align="right"><span style="font-size: 0.7em;">*</span>비밀번호 확인 :</th>
			<td><input type="password" name="pw_2" onchange="check_pw()">
				<button type="button" onclick="PW_confirm(); return false;">확인</button>  
				<span id="check" > </span> <!--비밀번호 체크 문구  -->
				</td>
				  
		</tr>


		<tr><th align="right"><span style="font-size: 0.7em;">*</span> 이름</th>
			<td><input type="text" name="name"></td></tr>


		<tr><th align="right"><span style="font-size: 0.7em;">*</span>핸드폰 번호</th>
			<td>
			<select name="phone_value">
				<option value="010">010</option>
				<option value="011">011</option>
				<option value="012">012</option>
				<option value="016">016</option>
			</select>
			<input type="text" name="tel_1" maxlength="4" size="5" onkeyup="moveNext(this,4,document.Join_form.tel_2)">
		  - <input type="text"name="tel_2" maxlength="4" size="5" onkeyup="moveNext(this,4,document.Join_form.email)"></td> </tr>

		<tr>
			<th align="right"><span style="font-size: 0.7em;">*</span>주소</th>
			<td><input type="text"> <button type="button"> 주소검색 </button> </td>
		</tr>
		 	<tr> 
		 	<th align="center" >상세주소 </th>
			<td><input type="text" placeholder="(동,호수)"> </td>
			</tr>


			<tr>
				<th align="right"><span style="font-size: 0.7em;">*</span> 이메일	</th>
			<td><input type="email" placeholder="이메일" name="email">
				<select name="email_value">
					<option value="naver.com">@naver.com</option>
					<option value="daum.com">@daum.net</option>
					<option value="google.com">@google.com</option>
			</select></td>
		</tr>


		<tr>
			<td colspan="2" align="center"><input type="submit"	value="회원가입" onclick="Check_value(); return false;" class="btn btn-primary"> 
				<input type="reset" value="다시쓰기" class="btn btn-primary"></td>
			</tr>

		</table>
	</form>
</div>


<script type="text/javascript">

//주민번호 자릿수입력하면 자동으로 뒷자리 입력칸으로 커서가 옴겨짐.
 function erase(obj){
	  obj.value="";
	  obj.focus();
	 }
function moveNext(obj,length,nextObj){
	  if(obj.value.length==length){
	   nextObj.focus(); 
	  }}

//아이디 입력란에 키다운이벤트'히든으로 값 세팅. 중복체크 후 다시 아이디창에 새로운 아이디를 입력할떄 다시 중복체크를 하게함.
function inputIdChk(){
          document.Join_form.ID_Duplication.value ="ID_Uncheck";
    } 

 function check_pw() {
	var pw_1 = document.Join_form.pw_1.value;
	
	if(pw_1.length <6  || pw_1.length >18 || pw_1.value == ""){
		alert("비밀번호는 6~18자 이내로 작성해주세요.");
		document.Join_form.pw_1.value="";
		document.Join_form.pw_1.focus();
	}
}

function PW_confirm() {
		var pw_1 = document.Join_form.pw_1;
		var pw_2 = document.Join_form.pw_2;
		
		if(pw_1.value == pw_2.value){
			document.getElementById('check').innerHTML='비밀번호가 일치합니다.'
               document.getElementById('check').style.color='blue';
		}else if(pw_1.value != pw_2.value){
			document.getElementById('check').innerHTML='비밀번호가 일치하지 않습니다.'
            document.getElementById('check').style.color='red';
			Join_form.pw_1.focus();
		}
	}

 function Check_value() {
	var form = document.Join_form;
	
	 if(!form.id.value){
		alert("아이디를 입력하세요.");
		form.id.focus();
		return;
	} 
	 else if(form.ID_Duplication.value != "ID_check"){  //아이디 중복체크 클릭 이벤트.
		alert("아이디 중복체크를해주세요.");
		return;
	}  
	 else if(!(form.pw_1.value && form.pw_2.value)){
		alert("비밀번호를 입력하세요.");
		form.pw_1.focus();
		return;
	}
	else if(form.pw_1.value != form.pw_2.value){
		alert("비밀번호를 동일하게 입력하세요.");
		form.pw_2.focus();
		return;
	}
	else if(!form.name.value){
		alert("이름을 입력하세요.");
		form.name.focus();
		return;
	}
	else if(isNaN(form.SS_Number1.value) || isNaN(form.SS_Number2.value) ){
		alert("주민번호는 숫자만 입력 가능합니다.");
		return;
	}
	else if(!form.email.value){
		alert("이메일을 입력하세요.");
		form.email.focus();
		return;
	}else{
		document.Join_form.method="post";
		document.Join_form.action="Insert_Sign_up";
		document.Join_form.submit();
	}
}
 
</script>


</body>
</html>