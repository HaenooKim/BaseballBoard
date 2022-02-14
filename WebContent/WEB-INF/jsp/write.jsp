<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR"
    import="orange.UserVO, banana.Util, java.util.List"%><%
	List<UserVO> ls = (List<UserVO>)request.getAttribute("rList");
	
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
 <link rel="icon" type = "images/jpg" href="images/pknu.jpg">
<link rel="stylesheet" href="css/write.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
 <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
 
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
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
	
		<!------------- �۾���â ------------->
	
	<section class="write">	
	
	<div class="back_btn">
		<button onclick="confirmBack();">�ڷΰ���</button>
	</div>
	
		<form class="write_form" method="POST" action="add.pknu" enctype="multipart/form-data">
			<div class="write_form_author">
				<h4>�ۼ���</h4>
				<input type="text" value="<%=name%>" name="author" readonly/>
			</div>
			
			<div class="write_form_title">
				<h4>����</h4>
				<div class="write_form_title_input">
					<select name="category">
						<option value="KBO">KBO</option>
					    <option value="�Ե�">�Ե�</option>
					    <option value="����">����</option>
					    <option value="�λ�">�λ�</option>
			 			<option value="��ȭ">��ȭ</option>
					    <option value="���">���</option>
					    <option value="�Ｚ">�Ｚ</option>
			 			<option value="KT">KT</option>
					    <option value="SSG">SSG</option>
					    <option value="NC">NC</option>
						<option value="Ű��">Ű��</option>
		  			</select>
					<input type="text" name="title" required placeholder="������ �Է����ּ���" maxlength='20'/>
				</div>
			</div>
			
			<div class="write_form_content">
				<textarea name="content" placeholder="������ �Է����ּ���" maxlength='500'></textarea>
			</div>
			
			<div class="filebox">
			    <input class="upload-name" placeholder="÷������">
			    <label for="file">����ã��</label> 
			    <input type="file" id="file" name="apple">
			</div>
			<!-- 
			<div class="write_form_file">
				<input type="file" name="apple" />
			</div>
			-->
			
			<div class="btn_wrap">
				<input class="enroll_btn" type="submit" value="���"/>
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
		
		function confirmBack() {
			var message;
			
			message = confirm("�ۼ����� ������ ������� �ʽ��ϴ�. �ڷΰ��ðڽ��ϱ�?");
			
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