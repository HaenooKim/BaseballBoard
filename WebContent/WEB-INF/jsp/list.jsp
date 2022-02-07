<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR"
    import="banana.BoardVO, banana.BoardDAO, banana.BoardDAO_MariaImpl, orange.BoardAndReplyVO, banana.Util, java.util.List"%>
    
    <%
    	List<BoardAndReplyVO> ls = (List<BoardAndReplyVO>)request.getAttribute("rList");
    
    	BoardDAO dao = new BoardDAO_MariaImpl();
    	
    	int totalRows = dao.getTotalRows(); //현재 게시판의 총 row개수 (레코드 수)
    	
    	int ArticlesPerPage = 10; //페이지당 글 수 (한페이지당 10개씩 보여줄거임)
    	int pageCount = ((totalRows-1)/ArticlesPerPage) + 1; //페이지 수 
    	//[페이지수] = ( ( [레코드 수] - 1 ) / [페이지당 글 수] ) + 1;
    	
    	
    			
    	String name = (String)session.getAttribute("name"); //세션에 저장된 이름 값 가져오기
    	String a= null; //a태그에 들어갈 값
    	String btnName = null; //로그인이냐 로그아웃버튼이냐 선택
    	
    	if (name == null) {
    		String ip = Util.getRemoteAddr(request);
    		name=ip.substring(0, 7); //6자리까지만 공개한다.
    		a = "login.pknu"; // a태그에 들어갈 주소. 로그인이 안 되어있으면 로그인 버튼으로, 되어있으면 로그아웃 버튼이 뜨도록 함
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

	<span><%=name %>님 안녕하세요</span>
	
	<%
		if (ls.isEmpty()) {
			%>조회하는 결과가 없습니다.<% 
		}
	%>
	
	<table> <% 	
	if (ls != null) {
		for (BoardAndReplyVO t : ls) {
			%>
			
			<tr>
			<td><%=t.getNo() %></td>
			<td><a href="categorySearch.pknu?category=<%=t.getCategory()%>"><%=t.getCategory() %></a></td>
			<td><a href="showContent.pknu?no=<%=t.getNo()%>"><%=t.getTitle() %></a></td>
			<td><%=t.getAuthor() %></td>
			<td><%=t.getTime().substring(0, 16) %></td>
			<td>조회수<%=t.getView() %>
			</tr>
			
			<%
		}
	}
	%>
	</table>
	
	<a href="write.pknu"><button>글쓰기</button></a>
	<a href=<%=a%>><button><%=btnName %></button></a>
	
	<form method="GET" action="listSearch.pknu">
		<select name="search">
		    <option value="author">글쓴이</option>
		    <option value="title">제목</option>
		    <option value="titlecontent">제목+내용</option>
		    <input type="text" name="target" required minlength='2'/>
		    <input type="submit" value="검색"/> 
  		</select>
	</form>
	
	<ul class="pagination">
		<%
			for (int i=1; i<=pageCount; i++) {
				%><li><a href="list.pknu?pageCount=<%=i%>"><%=i%></a></li><%
			}
		%>
	</ul>

</body>
</html>    
