<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="orange.UserVO, java.util.List"%>
    
<%
	List<UserVO> ls = (List<UserVO>)request.getAttribute("rList");
	
	StringBuffer uid = new StringBuffer();
	for (int i=0; i<ls.size(); i++) {
		if(uid.length()>0) {
			uid.append(',');
		}
		uid.append('"').append(ls.get(i).getId()).append('"');
	} //아이디 값을 버퍼에 넣어서 자바스크립트에 아이디 유효성 검사에 넣을거임.
	
	//System.out.println(uid.toString());
%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
 <link rel="icon" type = "images/jpg" href="images/pknu.jpg">
<title>Baseball Park</title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
<link rel="stylesheet" href="css/signup.css" />
</head>
<body>

<header class="welcome-header">
    <a href="list.pknu">
    <h1 class="welcome-header__title">
    	<i class="fas fa-baseball-ball"></i>
    		BaseBall Park
    </h1>
    </a>
</header>
 <div class="idValidation-wrap">
	<button class="idValidation" onclick="idValidation();">ID 중복체크</button> 
 </div>
<form method="GET" action="signinCheck.pknu" class="signup-form">	
	<input onchange="idCheck();" class="id" type="text" name="id" placeholder="아이디 (영문, 숫자포함 4~10자)" minlength='4'  maxlength='10' required />
	<span class="idMessage"></span>	
	<input onchange="pwdCheck();" class="password1"  type="password" name="password" placeholder="비밀번호 (6~16자)" minlength='6' maxlength='16' required/>
	<input onchange="pwdCheck();" class="password2" type="password" name="passwordCheck" placeholder="비밀번호 확인" minlength='6' maxlength='16' required/>
	<span class="pwdMessage"></span>
	<input onchange="nickCheck();" class="nickName" type="text" name="name" placeholder="닉네임"  minlength='2' maxlength='10' required/>
	<span class="nickMessage"></span>
	<input onchange="phoneCheck();" class="phoneNum" type="text" name="phone" placeholder="휴대전화번호 '-' 없이 입력" maxlength='20' required/>
	<span style="margin-bottom:10px;" class="phoneMessage"></span>
	<input onclick="signupCheck();" type="button" value="회원가입"/>
</form>
<div class="back-to-login">
	<a href="login.pknu">로그인 화면으로 돌아가기</a>
</div>

<script>

//아이디 중복체크
function idValidation() {
	var id = document.querySelector(".id").value;
	var flag = true;
	var list = [<%=uid.toString()%>];
	var idMessage = document.querySelector(".idMessage");
	
	if(id=="") {
		alert("아이디를 입력해주세요.");
		return ;
	}
	
	if (idMessage.innerHTML == "아이디는 영문과 숫자를 포함하여 4~10자리로 입력해주세요") {
		alert("아이디는 영문과 숫자를 포함하여 4~10자리로 입력해주세요");
	}
	else {
		for (var i=0; i<list.length; i++) {
			if ((id==list[i])) {
				flag=false;
				break;
			}
		}
		if (flag) {
			idValidationFalg = 1;
			idMessage.innerHTML = "사용가능한 아이디입니다.";
			idMessage.style.color="blue";
		}
		else {
			idMessage.innerHTML = "사용불가능한 아이디입니다.";
			idMessage.style.color="tomato";
		}	
	}
}


//ID 형식에 맞는지 체크
function idCheck() {
	var reg = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{4,10}$/; //ID 정규식 (영문, 숫자 포함 4~10자리)
	var id = document.querySelector(".id").value;
	var idMessage = document.querySelector(".idMessage");
	
	if( !reg.test(id) ) {
	    idMessage.innerHTML = "아이디는 영문과 숫자를 포함하여 4~10자리로 입력해주세요";
	    idMessage.style.color="tomato";
	    //document.querySelector(".id").value="";
	}
	else {
		idMessage.innerHTML = "";
	}
}

//휴대전화 형식이 맞는치 체크
function phoneCheck() {
	var phoneNum = document.querySelector(".phoneNum").value;
	var phoneMessage = document.querySelector(".phoneMessage");
	
	var regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/; //휴대전화 정규식
	if (regPhone.test(phoneNum) === false) {
		phoneMessage.innerHTML = "입력방식이 잘못되었습니다.";
		phoneMessage.style.color = "tomato";
		//document.querySelector(".phoneNum").value="";
	}
	else {
		phoneMessage.innerHTML = "";
	}
}

//비밀번호 체크
function pwdCheck() {
	var password1 = document.querySelector(".password1").value; //
	var password2 = document.querySelector(".password2").value; //비밀번호 일치확인 값
	var pwdMessage = document.querySelector(".pwdMessage");
	
	if (password1 != '' && password2 != '') {
		
		if (password1.length < 6 || password1.length > 16) {
			pwdMessage.innerHTML = "비밀번호는 6 ~ 16자 사이로 해주세요";
			pwdMessage.style.color= "tomato";
		}
		else {
			if (password1 == password2) {
				pwdMessage.innerHTML = "비밀번호가 일치합니다";
				pwdMessage.style.color= "blue";
			}
			else  {
				pwdMessage.innerHTML = "비밀번호가 일치하지 않습니다.";
				pwdMessage.style.color= "tomato";
			}
		}
	}
}

//닉네임 체크
function nickCheck() { 
	var nickName = document.querySelector(".nickName").value;
	var nickMessage = document.querySelector(".nickMessage");
	
	if (nickName.length < 2) {
		nickMessage.innerHTML = "닉네임은 2자 이상 입력해주세요";		
		nickMessage.style.color="tomato";
	}
	else {
		nickMessage.innerHTML = "사용가능한 닉네임입니다.";	
		nickMessage.style.color="blue";
	}
}


function signupCheck() {
	//----------유효성 체크-------------
	var signupCheck = document.querySelector(".signup-form");
	var pwdMessage = document.querySelector(".pwdMessage").innerHTML;
	var idMessage = document.querySelector(".idMessage").innerHTML;
	var phoneMessage = document.querySelector(".phoneMessage").innerHTML;
	var nickMessage = document.querySelector(".nickMessage").innerHTML;
	//----------입력되지 않은 값 체크---------
	var id = document.querySelector(".id").value;
	var phoneNum = document.querySelector(".phoneNum").value;
	var password1 = document.querySelector(".password1").value; //
	var password2 = document.querySelector(".password2").value; //비밀번호 일치확인 값
	var nickName = document.querySelector(".nickName").value;
	
	
	if (id == "" || phoneNum=="" || password1=="" || password2=="" 
			|| nickName=="") {
		alert("입력되지 않은 문항이 있습니다.");
	}
	
	else if (phoneMessage=="입력방식이 잘못되었습니다.") {
		alert("휴대전화번호를 확인해주세요");
	}
	else if (pwdMessage!="비밀번호가 일치합니다"){
		alert("비밀번호를 확인해주세요");
	}
	else if (idMessage!="사용가능한 아이디입니다.") {
		if (idMessage == "아이디는 영문과 숫자를 포함하여 4~10자리로 입력해주세요") {
			alert("아이디 양식을 확인해주세요");
		}
		else {
			alert("중복체크를 해주세요");			
		}
	}
	else if (nickMessage=="닉네임은 2자 이상 입력해주세요") {
		alert("닉네임을 확인해주세요.");
	}
	
	else {
		signupCheck.submit(); // 모든 유효성 검사완료후 회원가입 submit
	}
}



</script>


</body>
</html>