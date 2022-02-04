<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR"
    import="banana.BoardVO, banana.Util, java.util.List"%>
    <%@taglib prefix="q" uri="http://java.sun.com/jsp/jstl/core"%>
    
    <%
    	String name = (String)session.getAttribute("name");
    	if (name == null) {
    		name=Util.getRemoteAddr(request);
    	}
    %>
<%--

--%><!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

</head>
<body>

	<%=name %>

	<table>	
		<q:forEach items="${rList}" var="t">
			<tr>
				<td>${t.no}</td>
				<td>${t.title }</td>
				<td>${t.author}</td>
				<td>${t.time}</td>
			</tr>
		</q:forEach>
	</table>
	
	<a href="write.pknu"><button>글쓰기</button></a>
	<a href="logout.pknu"><button>로그아웃</button></a>

</body>
</html>    
