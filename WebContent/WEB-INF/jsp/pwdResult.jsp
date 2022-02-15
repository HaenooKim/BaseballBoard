<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="orange.UserVO"%>
<%
	UserVO vo = (UserVO)request.getAttribute("pwdResult");
%>
    
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
 </header>
 

 
 <div class="result">
  <%
 	if (vo.getPassword()==null) {
 		%><span>��ȸ����� �����ϴ�.</span><%
 	}
 	else {
 		%> <span>ȸ������ ��й�ȣ�� <%=vo.getPassword().substring(0, vo.getPassword().length()-2)%>** �Դϴ�.</span><%
 	}
 %>
 </div>
 
 <div class="back-to-login">
	<a href="login.pknu">�α��� ȭ������ ���ư���</a>
</div>



</body>
</html>