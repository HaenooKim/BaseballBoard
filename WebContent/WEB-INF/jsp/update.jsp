<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR"
    import="banana.BoardVO, banana.Util, java.util.List"%><%

    
    BoardVO vo = (BoardVO)request.getAttribute("content");
   
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
<link rel="stylesheet" href="css/write.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
 <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
 
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�Խñ� ����</title>
<script>
	function handleBtn() {
		if (confirm("�����Ͻðڽ��ϱ�?")==true) {
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
	      <li><a href="">�Ұ���</a></li>
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
	
	
	

	<form method="POST" action="update.pknu" enctype="multipart/form-data">
		<select name="category">
			<option value="kbo">KBO</option>
		    <option value="�Ե�">�Ե�</option>
		    <option value="����">����</option>
		    <option value="�λ�">�λ�</option>
 			<option value="��ȭ">��ȭ</option>
		    <option value="���">���</option>
		    <option value="�Ｚ">�Ｚ</option>
 			<option value="KI">KT</option>
		    <option value="SSG">SSG</option>
		    <option value="NC">NC</option>
			<option value="Ű��">Ű��</option>
  		</select>
		
		<input type="text" value="<%=name%>" name="author" readonly/>
		<input type="text" value="<%=vo.getTitle()%>" name="title" required />
		<input type="text" value="<%=vo.getContent()%>" name="content" requried />
		<input type="file" value="<%=vo.getOfn() %>" name="apple" />
		<input type="hidden" value="<%=vo.getNo()%>"  name="no"/>
		<input type="submit" value="����" onclick="handleBtn()"/>
	</form>
	
</body>
</html>