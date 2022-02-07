<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>로그인</title>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
<link rel="stylesheet" href="css/login.css" />
</head>
<body>

<header class="welcome-header">
    <a href="list.pknu">
    <h1 class="welcome-header__title">
    	<i class="fas fa-baseball-ball"></i>
    		이름 추천 바씁니다...
    	<i class="fas fa-baseball-ball"></i>
    </h1>
    </a>
 </header>


<form method="POST" action="loginCheck.pknu" class="login-form">
	<input type="text" name="id" placeholder="아이디" required/>
	<input type="password" name="password" placeholder="패스워드" required/>
	<input type="submit" value="로그인"/>
</form>

<div class="find-wrap">
	<a href="signin.pknu" >회원가입</a>
	<div class="divider"></div>
	<a href="#" >비밀번호 찾기</a>
	<div class="divider"></div>
	<a href="#" >아이디 찾기</a>
</div>
	

</body>
</html>