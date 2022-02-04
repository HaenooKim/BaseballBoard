<%@ page contentType="text/html;charset=utf-8"
    pageEncoding="EUC-KR"%><%
    
	Exception err = (Exception)request.getAttribute("err");
	
%><!DOCTYPE html>
<html>
<body>
	<%=err.toString()%><br/><%
	
	StackTraceElement[] stes = err.getStackTrace();
	for( StackTraceElement ste : stes ) {
		%><%=ste.toString()%><br/><%
	}
	
%></body>
</html>