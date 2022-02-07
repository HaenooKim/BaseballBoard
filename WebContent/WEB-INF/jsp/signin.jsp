<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>회원가입</title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
<link rel="stylesheet" href="css/signup.css" />
</head>
<body>

<header class="welcome-header">
    <a href="list.pknu">
    <h1 class="welcome-header__title">
    	<i class="fas fa-baseball-ball"></i>
    		Baseball Park
    	<i class="fas fa-baseball-ball"></i>
    </h1>
    </a>
 </header>

<form method="GET" action="signinCheck.pknu" class="signup-form">

	<input type="text" name="id" placeholder="ID"  maxlength='10' required />
	<input type="password" name="password" placeholder="Password" maxlength='16' required/>
	<input type="text" name="name" placeholder="이름"  maxlength='10' required/>
	<input type="text" name="phone" placeholder="휴대전화번호" maxlength='20' required/>
	<input type="submit" value="회원가입"/>
</form>
<div class="back-to-login">
	<a href="login.pknu">로그인 화면으로 돌아가기</a>
</div>

</body>
</html>