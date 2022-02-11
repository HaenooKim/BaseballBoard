<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR"
    import="banana.BoardVO, banana.BoardDAO, banana.BoardDAO_MariaImpl, orange.BoardAndReplyVO, banana.Util, java.util.List"%>
    
    <%
    	List<BoardAndReplyVO> ls = (List<BoardAndReplyVO>)request.getAttribute("rList"); // 게시판 정보를 받는다.
    
	    BoardDAO dao = new BoardDAO_MariaImpl();
		
		int totalRows = dao.getTotalRows(); //현재 게시판의 총 row개수 (레코드 수)
    
    //------------만약 검색된 값을 받는 거라면...? ---------------------
    	String searchCurrentPage = request.getParameter("searchCurrentPage");
    	Boolean checkSearch = false; //이 페이지가 검색된 페이지에서 넘어온건지 그냥 전체 리스트 페이지인지 확인
    	String search = null;
		String target = null;
    	if (searchCurrentPage != null) {
    		checkSearch = true;
    		search = request.getParameter("search"); // 검색주제가 뭔지 알아내는 코드(글쓴이 or 제목 or 제목+내용)
    		target = request.getParameter("target"); // 뭘 검색했는지 알아내는 코드
    		totalRows=dao.getTotalRows(search, target); //만약 검색한 결과를 가져오는 거라면 여기서 찾아야 한다!!
    	}
    	
    	//-------테이블 페이지네이션을 몇번까지 만들지 정하는 코드--------	
    
    	int ArticlesPerPage = 40; //페이지당 글 수 (한페이지당 10개씩 보여줄거임) -> 변경하고 싶으면 BoardDAO_MariaImpl에 가서 showingNumber도 같은 숫자로 바꿔줘야 함
    	int pageCount = ((totalRows-1)/ArticlesPerPage) + 1; //페이지 수 
    	//[페이지수] = ( ( [레코드 수] - 1 ) / [페이지당 글 수] ) + 1;
    	
    	   
     	// -----블록을 보여준 후 >표시를 언제 보여줄지 정하는 코드---
        	String CP=null;
     		if (checkSearch) {
     			CP = searchCurrentPage;
     		}
     		else {     			
     			CP = request.getParameter("currentPage"); 
     		}
     		
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
    	
    	//----------------------------- html ---------------------------------------
    	
    %>
<%--
--%><!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" type = "images/jpg" href="images/pknu.jpg">
<link rel="stylesheet" href="css/list.css">

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
<title>Basball Park</title>

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
  
  <!------------- board ------------->
	<section class="notice">
	 <div class="page-title">
          <div class="container">
              <h2>야구 게시판</h2>
          </div>
      </div>
	<div id="board-list">
		<div class="container">
			<table class="board-table"> 
				<thead>
                  <tr>
                      <th scope="col" class="th-num">번호</th>
                      <th scope="col" class="th-title">제목</th>
                      <th scope="col" class="th-author">글쓴이</th>
                      <th scope="col" class="th-date">등록일</th>
                      <th scope="col" class="th-view">조회수</th>
                  </tr>
                  </thead>
				<tbody>
					<% 	
					if (ls.isEmpty() || ls==null){
						%><span class="alert__search">조회결과가 없습니다.</span><%
					}
					
					else{
						
						if (checkSearch) {
							%><span class="alert__search"><%=totalRows%>건이 검색되었습니다.<span><%
						}
						
						for (BoardAndReplyVO t : ls) {
							%><tr>
							<td><%=t.getNo() %></td>
							<td style="text-align:left">
							<%
								if (t.getOfn() !=null) {
									%><span style="color:#418f33;)"><i class="fas fa-image"></i></span><%
								}
								else if (t.getOfn() == null) {
									%><span style="color:rgba(0, 0, 0, 0.4);)"><i class="far fa-comment-dots"></i></span><%
								}
							%>
							<a style="color:#4a3dff" href="categorySearch.pknu?category=<%=t.getCategory()%>&currentPage=<%=currentPage%>"><%=t.getCategory() %></a>
							<a href="showContent.pknu?no=<%=t.getNo()%>"><%=t.getTitle() %></a>
							<%
								if(dao.getRelpyCount(t.getNo()) !=0) {
									%><a style="color:tomato;" class="reply_count" href="showContent.pknu?no=<%=t.getNo()%>">[<%=dao.getRelpyCount(t.getNo()) %>]</a><%
								}
							%>
							</td>
							<td><%=t.getAuthor() %></td>
							<td><%=t.getTime().substring(0, 16) %></td>
							<td><%=t.getView() %>
							</tr><%
						}
					}
					%>
				</tbody>
			</table>
		</div>
	</div>
	
  	<!------------- 글쓰기, 전체글 버튼 ------------->
	</section>
		<div class="btn-wrap">
		<a href="list.pknu"><button class="list_btn">전체글</button></a>
		<a href="write.pknu"><button class="write_btn">글쓰기</button></a>
	</div>
	
	
	  <!------------- 페이지네이션 ------------->
	<ul class="pagination my">
	<%
	if (checkSearch) {//검색한 경우
		
		if (blockBegin != 1) {
			%><li><a href="listSearch.pknu?searchCurrentPage=<%=blockBegin-1%>&target=<%=target%>&search=<%=search%>">이전</a></li><%
		}
	%><%
			for (int i=blockBegin; i<=blockEnd; i++) {
				if (currentPage == i) {
					%><li class="active"><a href="javascript:void(0);"><%=i%></a></li><%
				}
				else {
					%><li><a href="listSearch.pknu?searchCurrentPage=<%=i%>&target=<%=target%>&search=<%=search%>"><%=i%></a></li>	<%
				}
			}
		%><%
			if (blockEnd != pageCount) {
				%><li><a href="listSearch.pknu?searchCurrentPage=<%=blockEnd+1%>&target=<%=target%>&search=<%=search%>">다음</a></li><%
			}
	}
	
	else { //검색이 아닌 그냥 리스트를 불러올 경우
		if (blockBegin != 1) {
			%><li><a href="list.pknu?currentPage=<%=blockBegin-1 %>">이전</a></li><%
		}
	%>
		<%
			for (int i=blockBegin; i<=blockEnd; i++) {
				if (currentPage == i) {
					%><li class="active"><a href="javascript:void(0);"><%=i%></a></li><%
				}
				else {
					%><li><a href="list.pknu?currentPage=<%=i%>"><%=i%></a></li>
					<%		
				}
				
			
			}
			if (blockEnd != pageCount) {
				%><li><a href="list.pknu?currentPage=<%=blockEnd+1%>">다음</a></li><%
			}
		}
		%>
	</ul>
	
	
	  <!------------- 검색창 ------------->
	<section class="search">
		<form method="GET" action="listSearch.pknu">
			<select class="search__select" name="search">
			    <option value="author">글쓴이</option>
			    <option value="title">제목</option>
			    <option value="titlecontent">제목+내용</option>
	  		</select>
			<input class="search__text" type="text" name="target" required minlength='2' placeholder="검색어를 입력해주세요"/>
			<input type="hidden" name="searchCurrentPage" value="1" />
			 <button type="submit" class="search__btn">
	        	 <i class="fa fa-search"></i>
	    	  </button>
		</form>
	</section>
	
	<!-- 
	페이지 카운트 : <%=pageCount %> 현재페이지 : <span class="current_page"><%=currentPage %></span>
	블럭사이즈 : <%=blockSize %> 블럭비긴 : <%=blockBegin %>
	블럭 엔드 : <%=blockEnd %>
	토탈 레코드 : <%=totalRows %>
	검색한거냐?<%=checkSearch %>
	-->
	<script>
	/*-------반응형웹 Hamberger bar보이게 하기 ----*/
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