<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR"
    import="orange.UserVO, banana.BoardDAO, banana.BoardDAO_MariaImpl, banana.BoardVO, orange.BoardAndReplyVO, banana.Util, java.util.List"%><%
    List<BoardAndReplyVO> vo = (List<BoardAndReplyVO>)request.getAttribute("content");
    BoardDAO dao = new BoardDAO_MariaImpl();	
    
    
    // 페이네이션
    
    int totalReplyRows = dao.getRelpyCount(vo.get(0).getNo()); //총 레코드 수
    int ArticlesPerPage = 10; //페이지당 글 수
    int pageCount = ((totalReplyRows-1) / ArticlesPerPage + 1);
    
   	int currentPage = 0;
    String CP = request.getParameter("currentPage");
   	
    if (CP == null) {
    	currentPage=1;
    }
    else {
    	currentPage = Integer.parseInt(CP);
    }
    
    int blockSize = 5; //블럭사이즈 (한번에 페이지를 몇개까지 보여줄 건지. 나는 5개로 설정함)
    int blockBegin = ((currentPage-1)/blockSize) * blockSize + 1;
    int blockEnd = (blockBegin + blockSize-1) < pageCount ? (blockBegin + blockSize-1) : pageCount; 
    
    
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
 <link rel="icon" type = "images/jpg" href="images/pknu.jpg">
<link rel="stylesheet" href="css/showContent.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
 <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Baseball Park</title>

</head>
<body>

<!------------- nav bar ------------->
	<nav class="header">
	    <div class="header__logo">
	      <i class="fas fa-baseball-ball"></i>
	      <a href="list.pknu" >BaseBall Park</a>
	    </div>
	
	    <ul class="header__menu">
	      <li><a href="intro.pknu">소개글</a></li>
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

<!--  
페이지수 : <%=pageCount %> / 블럭사이즈 <%=blockSize %>
현재 페이지 : <%=currentPage %> / 블럭시작 : <%=blockBegin %>
/ 블럭끝 : <%=blockEnd %>
-->

<section class="showContent">
	<div class="back_btn">
		<button onclick="window.history.back();">뒤로가기</button>
	</div>
	<div class="showContent_wrap">
	
		<!-- 제목, 내용, 작성자 등이 들어간 곳(컨텐트의 헤더) -->
		<div class="showContent_information">
			<div class="showContent_information_column1">
				<div class="showContent_information_title">
					[<span style="color:#1c93e8;"><%=vo.get(0).getCategory() %></span>]
					<span><%=vo.get(0).getTitle() %></span>
				</div>
				<div class="showContent_information_author">
					<span><%=vo.get(0).getAuthor()%></span>
					<span><%=vo.get(0).getTime().substring(0,16) %></span>
				</div>
			</div>
		
			<div class="showContent_information_column2">
				<span style="margin-right:5px;">조회 <%=vo.get(0).getView() %></span>
				<span>댓글 <%=totalReplyRows %></span>
			</div>
		</div>
		
		<!-- 내용이 들어간 곳 -->
		<div class="showContent_information_content">
			<span><%=vo.get(0).getContent() %></span>
		</div>
		 
		
		<!-- 첨부된 파일이 있으면 파일이름이 들어간 a태그 생성 -->
		<div class="showContent_information_footer">
							<div class="showContent_information_file">
			<%
					if (vo.get(0).getOfn() != null && vo.get(0).getFsn() != null) {
						%>
								<a href="down.pknu?fsn=<%=vo.get(0).getFsn()%>&ofn=<%=vo.get(0).getOfn()%>">
									<%=vo.get(0).getOfn() %>&nbsp;<i class="fas fa-download"></i>
								</a>
						<%
					}
			%>
							</div>
			<div class="share_layer">
				<span style="color:#3266a8;"><i class="fas fa-share"></i></span>
				&nbsp;<span style="color:#ebeb23;"><i class="far fa-clone"></i></span>
			</div>
		
		</div>
		
	</div>
		
</section>

<%if(vo.get(0).getAuthor().equals(name) ) {
	%><div class="board_update"><a href="showUpdate.pknu?no=<%=vo.get(0).getNo()%>"><button class="modify_btn">수정하기</button></a>
		<a onclick="return confirm('정말 삭제하시겠습니까?');" href="deleteBoard.pknu?no=<%=vo.get(0).getNo()%>"><button class="delete_btn">삭제하기</button></a>
	</div><% 
}
%>


	
<!------------- 댓글 테이블 ------------->

<h3 class="reply_title">전체 댓글 <span style="color:tomato;"><%=dao.getRelpyCount(vo.get(0).getNo()) %></span></h3>
<div id="board-list">
		<div class="container">
			<table class="board-table"> 
				<tbody>
					<%
		if (vo.get(0).getReplyContent() != null) {
			for(BoardAndReplyVO t : vo) {
				%><tr>			
				<td class="replyAuthor"><%=t.getReplyAuthor() %></td>
				<td class="replyContent"><%=t.getReplyContent()%></td>
				<td class="replyTime"><%=t.getReplyTime().substring(0, 16)%>
					<%if(t.getReplyAuthor().equals(name) ) {
						%>
							<a onclick="return confirm('정말 삭제하시겠습니까?');" href="deleteReply.pknu?replyNo=<%=t.getReplyNo()%>"><button class="reply_delete_btn" ><i class="fas fa-times-circle"></i></button></a>
					<%
				
				}
					else {
						%><button class="reply_delete_btn"  style="visibility: hidden;"><i class="fas fa-times-circle"></i></button><%
					}
			%>
				</td>
				</tr><%
				
			}
		}
	%>
				</tbody>
			</table>
		</div>
	</div>

<!-- 페이지네이션 -->
<ul class="pagination">
<% 
if (blockBegin != 1) {
	%><li><a href="showContent.pknu?currentPage=<%=blockBegin-1 %>&no=<%=vo.get(0).getNo()%>">이전</a></li><%
}
  for (int i=blockBegin; i<=blockEnd; i++) {
	  if (currentPage == i) {
		  %><li class="active"><a href="javascript:void(0);"><%=i%></a><li><%
	  }
	  else {
		  
		  %><li><a href="showContent.pknu?currentPage=<%=i%>&no=<%=vo.get(0).getNo()%>"><%=i%></a><li><%
	  }
	  	  
  }
  if (blockEnd != pageCount) {
		%><li><a href="showContent.pknu?currentPage=<%=blockEnd+1%>&no=<%=vo.get(0).getNo()%>">다음</a></li><%
	}
  %>
</ul>

<!------------- 댓글 등록 ------------->

	<section class="write_reply">
		<form action="writeReply.pknu" method="GET" class="wrtie_reply_form">
			<input type="hidden" name="replyAuthor" value=<%=name %> readOnly/>
			
			<div class="write_reply_content">
				<textarea cols="15" rows="4" name="replyContent" maxlength='200'></textarea>
			</div>
				<input type="hidden" name="no" value=<%=vo.get(0).getNo() %> readOnly/>
				
			<div class="reply_enroll_btn_wrap">			
				<input class="reply_enroll_btn" type="submit" value="댓글등록"/>				
			</div>
		</form>
	</section>
	
	<script>

		const toggleBtn = document.querySelector(".header__toggleBtn");
		const menu = document.querySelector(".header__menu");
		const user = document.querySelector(".header__user");
		
		toggleBtn.addEventListener('click', () => {
			menu.classList.toggle('active');
			user.classList.toggle('active');
		});
		
	</script>
</body>
</html>