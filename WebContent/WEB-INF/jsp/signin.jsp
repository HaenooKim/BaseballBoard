<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

<form method="GET" action="signinCheck.pknu">
	<input type="text" name="id" placeholder="ID"  maxlength='10' required/>
	<input type="password" name="password" placeholder="Password" maxlength='16' required/>
	<input type="text" name="name" placeholder="�̸�"  maxlength='10' required/>
	<input type="text" name="phone" placeholder="�޴���ȭ��ȣ" maxlength='20' required/>
	<input type="submit" value="ȸ������"/>
</form>

<a href="list.pknu"><button>�Խ������� ����</button></a>

</body>
</html>