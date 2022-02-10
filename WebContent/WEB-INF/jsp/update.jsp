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

</head>
<body>
	<!------------- nav bar ------------->
	<nav class="header">
	    <div class="header__logo">
	      <i class="fas fa-baseball-ball"></i>
	      <a href="list.pknu" >BaseBall Park</a>
	    </div>
	
	    <ul class="header__menu">
	      <li><a href="intro">소개글</a></li>
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
	
	<!-- 수정창 -->
	<section class="write">	
	
	<div class="back_btn">
		<button onclick="confirmBack();">뒤로가기</button>
	</div>
	
		<form id="update" class="write_form" method="POST" action="update.pknu" enctype="multipart/form-data">
			
			<div class="write_form_author">
				<h4>작성자</h4>
				<input type="text" value="<%=name%>" name="author" readonly/>
			</div>
			
			<div class="write_form_title">
				<h4>제목</h4>
				<div class="write_form_title_input">
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
					<input value="<%=vo.getTitle()%>" type="text" name="title" required placeholder="제목을 입력해주세요" maxlength='20'/>
				</div>
			</div>
			
			<div class="wrtie_Form_content">
				<textarea name="content" placeholder="내용을 입력해주세요" maxlength='500'><%=vo.getContent()%></textarea>
				<!--<input type="text" name="content" requried placeholder="내용을 입력해주세요" maxlength='500'/>  -->
			</div>
			
			<div class="filebox">
			    <input class="upload-name"  placeholder="파일을 다시 올려주세요">
			    <label for="file">파일찾기</label> 
			    <input type="file" id="file" name="apple">
			</div>
			
			<input type="hidden" value="<%=vo.getNo()%>"  name="no"/>
			
			
			<div class="btn_wrap">
				<input class="enroll_btn" type="button" value="수정" onclick="confirmUpdate();"/>
			</div>
		</form>
	</section>
	
	
	<script>
		const toggleBtn = document.querySelector(".header__toggleBtn");
		const menu = document.querySelector(".header__menu");
		const user = document.querySelector(".header__user");
		
		
		/*-----------수정시 확인 메세지 창 띄우기-------------------*/
		//여기서 input 을 submit으로 하니까 취소를 눌러도 수정이 되는 오류가 발생했는데 button으로 바꾸니까 해결되었다.
		//submit으로 하면 바로 동작이 되어버리지만 버튼으로 하면 확인후 submit을 한다.
		toggleBtn.addEventListener('click', () => {
			menu.classList.toggle('active');
			user.classList.toggle('active');
		});
		
		function confirmUpdate() {
			var message;
			
			message = confirm("수정하시겠습니까?");
			if (message) {
				document.getElementById('update').submit();
			}
			else {
				return false;
			}
		}
		
		/*-----------수정 도중 뒤로갈 때 경고 창 띄우기-------------------*/
		function confirmBack() {
			var message;
			
			message = confirm("작성중인 내용은 저장되지 않습니다. 뒤로가시겠습니까?");
			
			if (message) {
				window.history.back();
			}
			else {
				return false;
			}
		}
		
	</script>
</body>
</html>