<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="banana.Util"%><%
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
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<link rel="stylesheet" href="css/intro.css">

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
<title>환영합니다</title>

<style>
img {
  position: absolute;
  left: 0;
  top: 0;
  max-width: 100%;
  min-width: 100%;
  max-height: 100%;
  min-height: 100%;
  z-index: -5;
  filter: brightness(50%);
}
</style>

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
  
  <script>
	const toggleBtn = document.querySelector(".header__toggleBtn");
	const menu = document.querySelector(".header__menu");
	const user = document.querySelector(".header__user");
	
	toggleBtn.addEventListener('click', () => {
		menu.classList.toggle('active');
		user.classList.toggle('active');
	});
  
	const images=["baseball1.jpg", "baseball2.jpg", "baseball3.jpg", "baseball4.jpg"];
	
	const chosenImage = images[Math.floor(Math.random()*images.length)];
	const bgImage = document.createElement("img");
	bgImage.src="images/"+chosenImage;
	document.body.appendChild(bgImage);
	
	
  </script>
</body>
</html>