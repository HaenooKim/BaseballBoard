<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR"
    import="banana.BoardVO, banana.Util, java.util.List"%><%

    
    BoardVO vo = (BoardVO)request.getAttribute("content");
   
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
<title>게시글 수정</title>
<script>
	function handleBtn() {
		if (confirm("수정하시겠습니까?")==true) {
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
	
	
	

	<form method="POST" action="update.pknu" enctype="multipart/form-data">
		<select name="category">
			<option value="kbo">KBO</option>
		    <option value="롯데">롯데</option>
		    <option value="엘지">엘지</option>
		    <option value="두산">두산</option>
 			<option value="한화">한화</option>
		    <option value="기아">기아</option>
		    <option value="삼성">삼성</option>
 			<option value="KI">KT</option>
		    <option value="SSG">SSG</option>
		    <option value="NC">NC</option>
			<option value="키움">키움</option>
  		</select>
		
		<input type="text" value="<%=name%>" name="author" readonly/>
		<input type="text" value="<%=vo.getTitle()%>" name="title" required />
		<input type="text" value="<%=vo.getContent()%>" name="content" requried />
		<input type="file" value="<%=vo.getOfn() %>" name="apple" />
		<input type="hidden" value="<%=vo.getNo()%>"  name="no"/>
		<input type="submit" value="수정" onclick="handleBtn()"/>
	</form>
	
</body>
</html>