<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�α���</title>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
<link rel="stylesheet" href="css/login.css" />
</head>
<body>

<header class="welcome-header">
    <a href="list.pknu">
    <h1 class="welcome-header__title">
    	<i class="fas fa-baseball-ball"></i>
    		�̸� ��õ �پ��ϴ�...
    	<i class="fas fa-baseball-ball"></i>
    </h1>
    </a>
 </header>


<form method="POST" action="loginCheck.pknu" class="login-form">
	<input type="text" name="id" placeholder="���̵�" required/>
	<input type="password" name="password" placeholder="�н�����" required/>
	<input type="submit" value="�α���"/>
</form>

<div class="find-wrap">
	<a href="signin.pknu" >ȸ������</a>
	<div class="divider"></div>
	<a href="#" >��й�ȣ ã��</a>
	<div class="divider"></div>
	<a href="#" >���̵� ã��</a>
</div>
	

</body>
</html>