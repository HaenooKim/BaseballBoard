<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR"
    import="orange.UserVO, java.util.List"%><%
List<UserVO> ls = (List<UserVO>)request.getAttribute("rList");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	
	<form method="POST" action="add.pknu" enctype="multipart/form-data">
		<input type="text" value=""/>
		<input type="submit"/>
	</form>
	
</body>
</html>