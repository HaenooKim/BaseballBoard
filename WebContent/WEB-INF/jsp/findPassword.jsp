<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Baseball Park</title>
 <link rel="icon" type = "images/jpg" href="images/pknu.jpg">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
<link rel="stylesheet" href="css/findPassword.css" />

</head>
<body>

<header class="welcome-header">
    <a href="list.pknu">
    <h1 class="welcome-header__title">
    	<i class="fas fa-baseball-ball"></i>
    		BaseBall Park
    </h1>
    </a>
    
    <h3>비밀번호 찾기</h3>
 </header>


<form method="POST" action="pwdResult.pknu" class="findPassword-form">
	<input type="text" name="id" placeholder="아이디" required/>
	<input type="text" name="phone" placeholder="전화번호" required/>
	<input type="submit" value="비밀번호 찾기"/>
</form>
 <div class="back-to-login">
	<a href="login.pknu">로그인 화면으로 돌아가기</a>
</div>

</body>
</html>