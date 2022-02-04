<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR"
    import="orange.UserVO, banana.BoardVO, banana.Util, java.util.List"%><%
    		BoardVO vo = (BoardVO)request.getAttribute("content");
    String name = (String)session.getAttribute("name");
	if (name == null) {
		name=Util.getRemoteAddr(request);
	}
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%=vo.getContent() %>
	
</body>
</html>