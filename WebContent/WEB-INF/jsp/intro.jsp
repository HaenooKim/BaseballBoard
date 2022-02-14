<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="banana.Util"%><%
    		//------------- ���� ���� (�α���) -----------------------------
    		String name = (String)session.getAttribute("name"); //���ǿ� ����� �̸� �� ��������
    		String a= null; //a�±׿� �� ��
    		String btnName = null; //�α����̳� �α׾ƿ���ư�̳� ����
    		
    		if (name == null) {
    			String ip = Util.getRemoteAddr(request);
    			name=ip.substring(0, 7); //6�ڸ������� �����Ѵ�.
    			a = "login.pknu"; // a�±׿� �� �ּ�. �α����� �� �Ǿ������� �α��� ��ư����, �Ǿ������� �α׾ƿ� ��ư�� �ߵ��� ��
    			btnName = "�α���";
    		}
    		else {
    			a="logout.pknu";
    			btnName = "�α׾ƿ�";
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
	      <li><a href="intro.pknu">�Ұ���</a></li>
	      <li><a href="list.pknu">�Խ���</a></li>
	      <li><a href="">��������</a></li>
	    </ul>

	    <div class="header__user">
	    <%
	    	if(session.getAttribute("name") != null) {
	    		%><span><i class="far fa-user"></i>&nbsp;<%=name %> ��</span><%
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
	  	<p class="intro_text">Baseball Park�� 2022���� �����Ͽ� ���Ӱ� â�ܵ� ���� �߱� Ŀ�´�Ƽ ����Ʈ�Դϴ�.
	  		����� �߱� Ŀ�´�Ƽ �������� ���������� ����Ʈ�� Ȯ���Ͽ� ���� �ְ� Ŀ�´�Ƽ ����Ʈ��
	  		�����ϱ����� ������ ���Դϴ�.
	  	</p>
	  	
	  	<h2>Service</h2>
	  	
	  	<div class="intro_service">
	  		<div class="intro_servie_board">
		  		<i class="fas fa-images"></i>
	  		</div>
	  		
	  		<div class="intro_sevice_text">
	  			<span>�Խ���</span>
	  			<p>�̹����� �Խ����� ���յ� Ŀ�´�Ƽ �����Դϴ�. </p>
	  		</div>
	  	</div>
	  	
	  	
	  	
	  	<div class="intro_service">
	  		<div class="intro_servie_mobile">
		  		<i class="fas fa-mobile-alt"></i>
	  		</div>
	  		
	  		<div class="intro_sevice_text">
	  			<span>����� ��/��</span>
	  			<p>����Ʈ��, �º� PC ����� ����� �� �ְ� �����ϴ� ����ȭ �� ����� �����Դϴ�.</p>
	  		</div>
	  	</div>
	  	
	  	<div class="enter_btn_wrap">
	  		<a href="list.pknu"><button class="enter_btn">�����ϱ� <i class="fas fa-sign-in-alt"></i></button></a>
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