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
 <link rel="icon" type = "images/jpg" href="images/pknu.jpg">
<link rel="stylesheet" href="css/intro.css">

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">

<style>
.intro {
	color:white;
	padding-top : 60px;
	display : flex;
	justify-content: center;
	align-items : center;
}


.intro_welcome {
	margin-top : 5px;
	padding: 40px 25px;
	background-color : rgba(0, 0, 0, 0.5);
	width : 60%;
	animation: fadeIn 1.2s ease-in;
}

.intro_welcome h2 {
	margin-bottom : 35px;
	font-weight : bold;
}

.intro_welcome .intro_text {
	width : 70%;
	font-size:16px;
	margin-bottom : 50px;
}

.intro_service {
	display : flex;
	margin-bottom:30px;
}

.intro_servie_mobile {
	margin-right : 55px;
	display : flex;
	justify-content : center;
	align-items : center;
	font-size : 55px;
	color : var(--own-blue);
}

.intro_servie_board {
	margin-right : 30px;
	display : flex;
	justify-content : center;
	align-items : center;
	font-size : 50px;
	color : var(--own-blue);
}
.intro_sevice_text span{
	font-size : 20px;
	font-weight : bold;
}

.enter_btn_wrap {
	margin-top:30px;
	display : flex;
	justify-content : flex-end;
}

.enter_btn {
	border : none;
	background-color: transparent;
	outline : none;
	color : white;
	font-weight : bold;
	font-size:24px;
}

@keyframes fadeIn {
  from {
    transform: translateY(15px);
    opacity: 0;
  }
  to {
    opacity: 1;
    transform: none;
  }
}


@media screen and (max-width:768px) {
	.intro {
		
	}
}



</style>


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
  
  <section class="intro">
  	<div class="intro_welcome">
	  	<h2>Introduction</h2>
	  	<p class="intro_text">Baseball Park는 2022년을 맞이하여 새롭게 창단된 국내 야구 커뮤니티 사이트입니다.
	  		현재는 야구 커뮤니티 뿐이지만 지속적으로 사이트를 확장하여 국내 최고 커뮤니티 사이트로
	  		성장하기위해 발전할 것입니다.
	  	</p>
	  	
	  	<h2>Service</h2>
	  	
	  	<div class="intro_service">
	  		<div class="intro_servie_board">
		  		<i class="fas fa-images"></i>
	  		</div>
	  		
	  		<div class="intro_sevice_text">
	  			<span>게시판</span>
	  			<p>이미지와 게시판이 결합된 커뮤니티 서비스입니다. </p>
	  		</div>
	  	</div>
	  	
	  	
	  	
	  	<div class="intro_service">
	  		<div class="intro_servie_mobile">
		  		<i class="fas fa-mobile-alt"></i>
	  		</div>
	  		
	  		<div class="intro_sevice_text">
	  			<span>모바일 웹/앱</span>
	  			<p>스마트폰, 태블릿 PC 등에서도 사용할 수 있게 제공하는 최적화 된 모바일 서비스입니다.</p>
	  		</div>
	  	</div>
	  	
	  	<div class="enter_btn_wrap">
	  		<a href="list.pknu"><button class="enter_btn">입장하기 <i class="fas fa-sign-in-alt"></i></button></a>
	  	</div>
	  	
  	</div>
  </section>
  
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