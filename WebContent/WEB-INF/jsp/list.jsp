<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR"
    import="banana.BoardVO, java.util.List"%><%
List<BoardVO> ls = (List<BoardVO>)request.getAttribute("rList");
%><%--

--%><!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

</head>
<body>
	<table> <%
		for(BoardVO t : ls) {
			%><tr>
			<td><%=t.getNo() %></td>
			<td><a><%=t.getTitle() %></a></td>
			<td><%=t.getAuthor()%></td>
			<td><%=t.getTime() %></td>
			<td><%=t.getView() %></td>
			<%
		}
	
	%>
	</table>
	
	<a href="write.pknu"><button>±Û¾²±â</button></a>

</body>
</html>    
