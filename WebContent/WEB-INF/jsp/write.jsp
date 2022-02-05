<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR"
    import="orange.UserVO, banana.Util, java.util.List"%><%
List<UserVO> ls = (List<UserVO>)request.getAttribute("rList");
    String name = (String)session.getAttribute("name");
	if (name == null) { // 비 로그인 상태일 경우
		String ip = Util.getRemoteAddr(request);
		name=ip.substring(0, 7); // 실제로 보여지는 ip주소는 6자리까지만 
	}
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	
	<form method="GET" action="add.pknu" enctype="multipart/form-data">
		<input type="text" value="<%=name%>" name="author" readonly/>
		<input type="text" name="title" required/>
		<input type="text" name="content" requried/>
		<input type="file" name="apple"/>
		<input type="submit"/>
	</form>
	
</body>
</html>