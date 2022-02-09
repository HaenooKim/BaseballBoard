<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR"
    import="orange.UserVO, banana.BoardVO, orange.BoardAndReplyVO, banana.Util, java.util.List"%><%
    		List<BoardAndReplyVO> vo = (List<BoardAndReplyVO>)request.getAttribute("content");
    
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
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="css/write.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
 <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
 
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>게시글 조회</title>

<script>
	function handleBtn() {
		if (confirm("정말 삭제하시겠습니까?")==true) {
			document.form.submit();
		}
		else {
			return;
		}
	}
</script>


</head>
<body>

<!------------- nav bar ------------->
	<nav class="header">
	    <div class="header__logo">
	      <i class="fas fa-baseball-ball"></i>
	      <a href="list.pknu" >BaseBall Park</a>
	    </div>
	
	    <ul class="header__menu">
	      <li><a href="">소개글</a></li>
	      <li><a href="list.pknu">게시판</a></li>
	      <li><a href="">공지사항</a></li>
	    </ul>

	    <div class="header__user">
	    <%
	    	if(session.getAttribute("name") != null) {
	    		%><span><i class="far fa-user"></i>&nbsp;<%=name %> 님</span><%
	    	}
	    %>
	 
	      <a href=<%=a%>><button class="logBtn"><%=btnName %></button></a>
	    </div>

		<a href="#" class="header__toggleBtn">
			<i class="fas fa-bars"></i>
		</a>
  </nav>
	




<%if(vo.get(0).getAuthor().equals(name) ) {
	%><a href="showUpdate.pknu?no=<%=vo.get(0).getNo()%>"><button>수정하기</button></a>
		<a href="deleteBoard.pknu?no=<%=vo.get(0).getNo()%>"><button onclick="handleBtn();">삭제하기</button></a>
	<% 
}
%>
<div>
	<span><%=vo.get(0).getTitle() %></span>
	<span><%=vo.get(0).getAuthor()%></span>
	<span><%=vo.get(0).getView() %></span>
	<span><%=vo.get(0).getTime().substring(0,16) %></span>
</div>

<div>
	
	<%=vo.get(0).getContent() %>


</div>
	
	
	<table>
	<%
		if (vo.get(0).getReplyContent() != null) {
			for(BoardAndReplyVO t : vo) {
				%><tr>			
				<td><%=t.getReplyAuthor() %></td>
				<td><%=t.getReplyContent()%>
					<%if(t.getReplyAuthor().equals(name) ) {
						%>
							<a href="deleteReply.pknu?replyNo=<%=t.getReplyNo()%>"><button onclick="handleBtn();">[X]</button></a>
					<% 
				}
			%>
					
				
				</td>
				</tr><%
				
			}
		}
	%>
	</table>

	<form action="writeReply.pknu">
		<input type="text" name="replyAuthor" value=<%=name %> readOnly/>
		<input type="text" name="replyContent"/>
		<input type="hidden" name="no" value=<%=vo.get(0).getNo() %> readOnly/>
		<input type="submit" value="댓글등록"/>		
	</form>
	
</body>
</html>