<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR"
    import="banana.BoardVO, java.util.List"%>
    <%@taglib prefix="q" uri="http://java.sun.com/jsp/jstl/core"%>
<%--

--%><!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

</head>
<body>

	${name}

	<table>	
		<q:forEach items="${rList}" var="t">
			<tr>
				<td>${t.no}</td>
				<td>${t.author}</td>
			</tr>
		</q:forEach>
	</table>
	
	<a href="write.pknu"><button>±Û¾²±â</button></a>

</body>
</html>    
