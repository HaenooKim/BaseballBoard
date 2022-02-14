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
	} //���̵� ���� ���ۿ� �־ �ڹٽ�ũ��Ʈ�� ���̵� ��ȿ�� �˻翡 ��������.
	
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
	<button class="idValidation" onclick="idValidation();">ID �ߺ�üũ</button> 
 </div>
<form method="GET" action="signinCheck.pknu" class="signup-form">	
	<input onchange="idCheck();" class="id" type="text" name="id" placeholder="���̵� (����, �������� 4~10��)" minlength='4'  maxlength='10' required />
	<span class="idMessage"></span>	
	<input onchange="pwdCheck();" class="password1"  type="password" name="password" placeholder="��й�ȣ (6~16��)" minlength='6' maxlength='16' required/>
	<input onchange="pwdCheck();" class="password2" type="password" name="passwordCheck" placeholder="��й�ȣ Ȯ��" minlength='6' maxlength='16' required/>
	<span class="pwdMessage"></span>
	<input onchange="nickCheck();" class="nickName" type="text" name="name" placeholder="�г���"  minlength='2' maxlength='10' required/>
	<span class="nickMessage"></span>
	<input onchange="phoneCheck();" class="phoneNum" type="text" name="phone" placeholder="�޴���ȭ��ȣ '-' ���� �Է�" maxlength='20' required/>
	<span style="margin-bottom:10px;" class="phoneMessage"></span>
	<input onclick="signupCheck();" type="button" value="ȸ������"/>
</form>
<div class="back-to-login">
	<a href="login.pknu">�α��� ȭ������ ���ư���</a>
</div>

<script>

//���̵� �ߺ�üũ
function idValidation() {
	var id = document.querySelector(".id").value;
	var flag = true;
	var list = [<%=uid.toString()%>];
	var idMessage = document.querySelector(".idMessage");
	
	if(id=="") {
		alert("���̵� �Է����ּ���.");
		return ;
	}
	
	if (idMessage.innerHTML == "���̵�� ������ ���ڸ� �����Ͽ� 4~10�ڸ��� �Է����ּ���") {
		alert("���̵�� ������ ���ڸ� �����Ͽ� 4~10�ڸ��� �Է����ּ���");
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
			idMessage.innerHTML = "��밡���� ���̵��Դϴ�.";
			idMessage.style.color="blue";
		}
		else {
			idMessage.innerHTML = "���Ұ����� ���̵��Դϴ�.";
			idMessage.style.color="tomato";
		}	
	}
}


//ID ���Ŀ� �´��� üũ
function idCheck() {
	var reg = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{4,10}$/; //ID ���Խ� (����, ���� ���� 4~10�ڸ�)
	var id = document.querySelector(".id").value;
	var idMessage = document.querySelector(".idMessage");
	
	if( !reg.test(id) ) {
	    idMessage.innerHTML = "���̵�� ������ ���ڸ� �����Ͽ� 4~10�ڸ��� �Է����ּ���";
	    idMessage.style.color="tomato";
	    //document.querySelector(".id").value="";
	}
	else {
		idMessage.innerHTML = "";
	}
}

//�޴���ȭ ������ �´�ġ üũ
function phoneCheck() {
	var phoneNum = document.querySelector(".phoneNum").value;
	var phoneMessage = document.querySelector(".phoneMessage");
	
	var regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/; //�޴���ȭ ���Խ�
	if (regPhone.test(phoneNum) === false) {
		phoneMessage.innerHTML = "�Է¹���� �߸��Ǿ����ϴ�.";
		phoneMessage.style.color = "tomato";
		//document.querySelector(".phoneNum").value="";
	}
	else {
		phoneMessage.innerHTML = "";
	}
}

//��й�ȣ üũ
function pwdCheck() {
	var password1 = document.querySelector(".password1").value; //
	var password2 = document.querySelector(".password2").value; //��й�ȣ ��ġȮ�� ��
	var pwdMessage = document.querySelector(".pwdMessage");
	
	if (password1 != '' && password2 != '') {
		
		if (password1.length < 6 || password1.length > 16) {
			pwdMessage.innerHTML = "��й�ȣ�� 6 ~ 16�� ���̷� ���ּ���";
			pwdMessage.style.color= "tomato";
		}
		else {
			if (password1 == password2) {
				pwdMessage.innerHTML = "��й�ȣ�� ��ġ�մϴ�";
				pwdMessage.style.color= "blue";
			}
			else  {
				pwdMessage.innerHTML = "��й�ȣ�� ��ġ���� �ʽ��ϴ�.";
				pwdMessage.style.color= "tomato";
			}
		}
	}
}

//�г��� üũ
function nickCheck() { 
	var nickName = document.querySelector(".nickName").value;
	var nickMessage = document.querySelector(".nickMessage");
	
	if (nickName.length < 2) {
		nickMessage.innerHTML = "�г����� 2�� �̻� �Է����ּ���";		
		nickMessage.style.color="tomato";
	}
	else {
		nickMessage.innerHTML = "��밡���� �г����Դϴ�.";	
		nickMessage.style.color="blue";
	}
}


function signupCheck() {
	//----------��ȿ�� üũ-------------
	var signupCheck = document.querySelector(".signup-form");
	var pwdMessage = document.querySelector(".pwdMessage").innerHTML;
	var idMessage = document.querySelector(".idMessage").innerHTML;
	var phoneMessage = document.querySelector(".phoneMessage").innerHTML;
	var nickMessage = document.querySelector(".nickMessage").innerHTML;
	//----------�Էµ��� ���� �� üũ---------
	var id = document.querySelector(".id").value;
	var phoneNum = document.querySelector(".phoneNum").value;
	var password1 = document.querySelector(".password1").value; //
	var password2 = document.querySelector(".password2").value; //��й�ȣ ��ġȮ�� ��
	var nickName = document.querySelector(".nickName").value;
	
	
	if (id == "" || phoneNum=="" || password1=="" || password2=="" 
			|| nickName=="") {
		alert("�Էµ��� ���� ������ �ֽ��ϴ�.");
	}
	
	else if (phoneMessage=="�Է¹���� �߸��Ǿ����ϴ�.") {
		alert("�޴���ȭ��ȣ�� Ȯ�����ּ���");
	}
	else if (pwdMessage!="��й�ȣ�� ��ġ�մϴ�"){
		alert("��й�ȣ�� Ȯ�����ּ���");
	}
	else if (idMessage!="��밡���� ���̵��Դϴ�.") {
		if (idMessage == "���̵�� ������ ���ڸ� �����Ͽ� 4~10�ڸ��� �Է����ּ���") {
			alert("���̵� ����� Ȯ�����ּ���");
		}
		else {
			alert("�ߺ�üũ�� ���ּ���");			
		}
	}
	else if (nickMessage=="�г����� 2�� �̻� �Է����ּ���") {
		alert("�г����� Ȯ�����ּ���.");
	}
	
	else {
		signupCheck.submit(); // ��� ��ȿ�� �˻�Ϸ��� ȸ������ submit
	}
}



</script>


</body>
</html>