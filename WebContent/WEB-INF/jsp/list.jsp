<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR"
    import="banana.BoardVO, banana.Util, java.util.List"%>
    <%@taglib prefix="q" uri="http://java.sun.com/jsp/jstl/core"%>
    
    <%
    	List<BoardVO> ls = (List<BoardVO>)request.getAttribute("rList");
    	String name = (String)session.getAttribute("name");
    	String a= null;
    	String btnName = null;
    	
    	if (name == null) {
    		name=Util.getRemoteAddr(request);
    		a = "login.pknu";
    		btnName = "로그인";
    	}
    	else {
    		a="logout.pknu";
    		btnName = "로그아웃";
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

	<table> <% 	
		for (BoardVO t : ls) {
			%>
			
			<tr>
			<td><%=t.getNo() %></td>
			<td><a href="showContent.pknu?no=<%=t.getNo()%>"><%=t.getTitle() %></a></td>
			<td><%=t.getAuthor() %></td>
			<td><%=t.getTime().substring(0, 16) %></td>
			<td>조회수<%=t.getView() %>
			</tr>
			
			<%
		}
	
	%>
	</table>
	
	<a href="write.pknu"><button>글쓰기</button></a>
	<a href=<%=a%>><button><%=btnName %></button></a>

</body>
</html>    
