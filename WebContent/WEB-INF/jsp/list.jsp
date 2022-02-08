<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR"
    import="banana.BoardVO, banana.BoardDAO, banana.BoardDAO_MariaImpl, orange.BoardAndReplyVO, banana.Util, java.util.List"%>
    
    <%
    	List<BoardAndReplyVO> ls = (List<BoardAndReplyVO>)request.getAttribute("rList");
    
    	//-------테이블 페이지네이션을 몇번까지 만들지 정하는 코드--------	
    
    	BoardDAO dao = new BoardDAO_MariaImpl();
    	
    	int totalRows = dao.getTotalRows(); //현재 게시판의 총 row개수 (레코드 수)
    	
    	int ArticlesPerPage = 10; //페이지당 글 수 (한페이지당 10개씩 보여줄거임) -> 변경하고 싶으면 BoardDAO_MariaImpl에 가서 showingNumber도 같은 숫자로 바꿔줘야 함
    	int pageCount = ((totalRows-1)/ArticlesPerPage) + 1; //페이지 수 
    	//[페이지수] = ( ( [레코드 수] - 1 ) / [페이지당 글 수] ) + 1;
    	
    	   
     	// -----블록을 보여준 후 >표시를 언제 보여줄지 정하는 코드---
        	String CP = request.getParameter("currentPage"); 
        	int currentPage = 0;
        	if (CP==null || CP.equals("")) {
        		currentPage = 1;
        	}
        	else {
        		currentPage = Integer.parseInt(CP);
        	} //현재 내가 보고있는 페이지 번호 추출
        	
        	int blockSize = 5; // 블록사이즈 결정(5개가 보이면 > 표시가 날 것임)
        	
        	int blockBegin = ((currentPage-1)/blockSize) * blockSize + 1; //현재 페이지에서 블럭의 첫번째 번호는 무엇인지 추출
        	/*
        		[블럭시작] = ( ( [CP] -1 ) / [BS] ) * [BS] + 1
    			즉 ( ( 3 - 1 ) / 5 ) * 5 + 1 이므로 결과는 1 (6)
        	*/
        	int blockEnd = (blockBegin + blockSize-1) < pageCount ? (blockBegin + blockSize-1) : pageCount;
        	/*
        		[블럭끝] = [블럭시작] + [BS] - 1 과 [EP] 중 작은값
				5 와 14 중 작은 값이니까 5 (6)
        	*/
    	
    	
    	//------------- 세션 관리 (로그인) -----------------------------
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
    	
    	//--------------------------------------------------------------------
    	
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
			<td><a href="categorySearch.pknu?category=<%=t.getCategory()%>&currentPage=<%=currentPage%>"><%=t.getCategory() %></a></td>
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
	
	<form method="GET" action="listSearch.pknu?currentPage=<%=currentPage %>">
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
		if (blockBegin != 1) {
			%><li><a href="list.pknu?currentPage=<%=blockBegin-1 %>">이전</a></li><%
		}
	%>
	
	
		<%
			for (int i=blockBegin; i<=blockEnd; i++) {
				%><li><a href="list.pknu?currentPage=<%=i%>"><%=i%></a></li>
			<%
			}
		%>
		
		<%
			if (blockEnd != pageCount) {
				%><li><a href="list.pknu?currentPage=<%=blockEnd+1%>">다음</a></li><%
			}
		%>
		
	</ul>
	
	페이지 카운트 : <%=pageCount %> 현재페이지 : <%=currentPage %>
	블럭사이즈 : <%=blockSize %> 블럭비긴 : <%=blockBegin %>
	블럭 엔드 : <%=blockEnd %>
	토탈 레코드 : <%=totalRows %>

</body>
</html>    
