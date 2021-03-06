/**
 * 
 */

/* 
	rservation2  --js
									*/

function dateCheck() {    //날짜 차이 계산 
	var start_date = new Date(document.regForm.rs_checkin.value).getTime();   		 //체크인 
	var end_date = new Date(document.regForm.rs_checkout.value).getTime();    	 //체크아웃
	var rs_setPrice_X = document.getElementById("rs_setPrice_X").value;							 //룸 가격 '히든'(표현식으로 방의 값이 바뀜)
	var diffdate = ((end_date - start_date) / (24 * 60 * 60 * 1000));            				 //기간에 차이 결과 값 (ex:1일 2일 3일 4일 ...)
	var rs_price = document.getElementById("rs_price").value;   							 //화면에 보여질 총 가격.
	var totalPrice = diffdate * rs_setPrice_X;
	var diffdate1 = diffdate + 1;                               											 // 날짜차이에 더하기 1 값은=  [?박"?일"] 데이터로 사용.
	var totalPriceF = totalPrice.toLocaleString();      	 											 //천자리수 마다 콤마찍는 스크립트 함수호출
	if (rs_price.value == null) {
		document.getElementById("rs_price").value = totalPrice;         						 //화면에 안보이는 가격을 서블릿으로 보내고, 보이는 값은 눈으로만 보는값.
		document.getElementById("rs_Getprice").value = ("(" + diffdate + "박" + diffdate1 + "일)") + "         " + totalPriceF + "원";
	}
}


function reservationCheck() {
	if (document.regForm.name.value == "" || document.regForm.name.length == 0) {
		alert("예약자명을 적어주세요.");
		regForm.name.focus();
		return false;
	}
	if (document.regForm.rs_userid.value == "" || document.regForm.rs_userid.length == 0) {
		alert("예약자 아이디를 적어주세요.");
		regForm.rs_userid.focus();
		return false;
	}
	if (document.regForm.rs_people.value < 1) {
		alert("인원수를 선택해주세요");
		regForm.rs_people.focus();
		return false;
	}
	if (document.regForm.rs_people.value > 9) {
		alert("최대허용 인원을 초과 하였습니다.");
		regForm.rs_people.focus();
		return false;
	}
	if (!document.regForm.rs_checkin.value) {
		alert("체크인 날짜를 선택해주세요.");
		regForm.rs_checkin.focus();
		return false;
	}
	if (!document.regForm.rs_checkout.value) {
		alert("체크아웃 날짜를 선택해주세요.");
		regForm.rs_checkout.focus();
		return false;
	}
	if (document.regForm.rs_checkout.value <= document.regForm.rs_checkin.value) {
		alert("체크아웃 날짜를 다시 선택해주세요 (예약날짜보다 과거 입니다.)");
		regForm.rs_checkout.focus();
		return false;
	}
	if (document.regForm.rs_roomname.value == "1") {
		alert("객실을 선택해 주세요.");
		regForm.rs_roomname.focus();
		return false;
	}
}


/*  
		getMy_modifyInfo.jsp
							 */
//개인정보 수정 유효성 검사

function modiCheck() {
	var mf = document.modify_Form;

	if (!mf.pw.value) {
		alert("비밀번호를 입력하세요.");
		mf.pw.focus();
		return false;
	}
	else if (!mf.name.value) {
		alert("이름을 입력하세요.");
		mf.name.focus();
		return false;
	}
	else if (!mf.phone.value) {
		alert("핸드폰 번호를 입력하세요.");
		mf.phone.focus();
		return false;
	}
	else if (!mf.email.value) {
		alert("이메일을 입력하세요.");
		mf.email.focus();
		return false;
	} else {
		document.modify_Form.method = "post";
		document.modify_Form.action = "UserInfo_Update";
		document.modify_Form.submit();
	}
}



/* 
		GetboardList.jsp
		-체크박스 전체선택/선택삭제-				 */

								/*  	function Delete_Check_Popup() {
										var msg = confirm("정말로 삭제하시겠습니까?");
										if (msg) {
											chc_Form.method = "post";
											chc_Form.action = "Delete_Check";
											chc_Form.submit();
										} else {
											self.close();
										}
									} 
								 */


/*
[공용컨트롤]			체크박스 개별선택 컬러이벤트 
 */
$(document).ready(function() {
				$(".chcBox").on('click', function() { 
					
				if ( $(this).is(':checked') == true ) { 
					console.log("check");
					$(this).parent().parent().addClass("selected"); 
					
				} else { 
					console.log("Nocheck");
					$(this).parent().parent().removeClass("selected"); 
						} 
					}); 
				}); 	
/*
[공용컨트롤]	 			 체크박스 전체 선택.   
*/
function check_All() {

	if ($("#th_checkAll").is(':checked')) {
		$("input[name=chcBox]").prop("checked", true);
	} else {
		$("input[name=chcBox]").prop("checked", false);
	}
}



/* 선택된 체크박스 배열에 담기  */

function Delete_Check_Popup() {
	var chcBox = "";

	$("input[name='chcBox']:checked").each(function() {
		chcBox = chcBox + $(this).val() + ","; 				// 체크된 것만 값을 뽑아서 배열에 push
		console.log(chcBox);
	});

	chcBox = chcBox.substring(0, chcBox.lastIndexOf(",")); 			//맨끝 콤마만 지우기

	if (chcBox == "") { 						//체크가 없을떄 유효성.
		alert("삭제할 대상을 선택하세요.");
		return false;
	}
	console.log("==== chcBox => []" + chcBox);

	$.ajax({
		type: "POST",
		url: "Delete_Check",
		data: { chcBox : chcBox },
		success: function(result) {
			console.log(result);
			if (result == "1") {
				alert('선택한 게시물이 삭제 되었습니다.');
				location.reload();
			}
			return;
		},
		error: function() {
			alert("서버요청 오류로 삭제 실패");
			return;
		}
	});
}

/*      
	마이페이지 삭제버튼 기능
											*/
//선택한 체크박스 삭제요청

function Delete_Check() {
	var chcBox = "";

	$("input[name='chcBox']:checked").each(function() {
		chcBox = chcBox + $(this).val() + ",";			 // 체크된 것만 값을 뽑아서 배열에 push
		console.log(chcBox);
	});

	chcBox = chcBox.substring(0, chcBox.lastIndexOf(",")); //맨끝 콤마만 지우기

	if (chcBox == "") { 				//체크가 없을떄 유효성.
		alert("삭제할 대상을 선택하세요.");
		return false;
	}
	console.log("==== chcBox => []" + chcBox);

	$.ajax({
		type: "POST",
		url: "Mypage_Delete_Check",
		data: { chcBox: chcBox },
		success: function(result) {
			console.log(result);
			if (result == "1") {
				alert("선택한 게시물 삭제 완료");
				location.reload();
			}
			return;
		},
		error: function() {
			alert("서버요청 오류로 삭제 실패");
			return;
		}
	});
}



/*  
헤더 메뉴 스크립트  
*/

window.name = "mainWindow";
function LogOut_Check_Popup() {
	var msg = confirm("정말로 로그아웃 하십니까?");
	if (msg) {
		out_check.method = "get";
		out_check.action = "LogOut";
		out_check.submit();
	} else {
		selfclose();
	}
}
//상단메뉴 active 활성화 
$(document).ready(function() {
	$('.li_index').each(function(index) {
		$(this).attr('menu-index', index);   //.. li_index클래스의 메뉴들을 클릭하면 인덱스번호가 생성됨

	}).click(function() {
		var index = $(this).attr('menu-index');
		$('.li_index[menu-index=' + index + ']').addClass('current');
		$('.li_index[menu-index!=' + index + ']').removeClass('current');
	});
});


/*
admin 유저정보 페이지 js
*/
	
function admin_userchk_Delete() {
		var chkarr = "";
	$(".chcBox:checked").each(function() {
		chkarr=chkarr + ($(this).val())+",";
		console.log(chkarr);
	});
	chkarr=chkarr.substring(0, chkarr.lastIndexOf(","));  
	
	if(chkarr == ""){ 
		alert("삭제할 대상을 선택하세요.");
		 return false;
	}
	console.log(" chkarr[] =>" + chkarr);

	if( confirm("[주의 !] \n 해당회원의 모든 정보가 삭제 됩니다. \n 정말 삭제?")) {
		userInfoList.method= "post";
		userInfoList.action = "AdminDeleteChecked";
		userInfoList.submit();
		return true;
	}else{
		self.close();
		return false;
	}
}
	
/* 헤더영역 - 실시간 시계 js  */
			
function setClock(){
    var dateInfo = new Date(); 
    var hour = modifyNumber(dateInfo.getHours());
    var min = modifyNumber(dateInfo.getMinutes());
    var sec = modifyNumber(dateInfo.getSeconds());
    var year = dateInfo.getFullYear();
    var month = dateInfo.getMonth()+1; //monthIndex를 반환해주기 때문에 1을 더해준다.
    var date = dateInfo.getDate();
    document.getElementById("time").innerHTML = hour + ":" + min  + ":" + sec;
    document.getElementById("date").innerHTML = year + "년 " + month + "월 " + date + "일";
}
function modifyNumber(time){
    if(parseInt(time)<10){
        return "0"+ time;
    }
    else
        return time;
}
window.onload = function(){
    setClock();
    setInterval(setClock,1000); //1초마다 setClock 함수 실행
}



