<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR"
    import="banana.BoardVO, banana.Util, java.util.List"%><%

    
    BoardVO vo = (BoardVO)request.getAttribute("content");
    String name = (String)session.getAttribute("name");
	if (name == null) { // �� �α��� ������ ���
		String ip = Util.getRemoteAddr(request);
		name=ip.substring(0, 7); // ������ �������� ip�ּҴ� 6�ڸ������� 
	}
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	
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
		<input type="submit" value="����" />
	</form>
	
</body>
</html>