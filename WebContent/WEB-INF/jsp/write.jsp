<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR"
    import="orange.UserVO, banana.Util, java.util.List"%><%
List<UserVO> ls = (List<UserVO>)request.getAttribute("rList");
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
	
	<form method="POST" action="add.pknu" enctype="multipart/form-data">
		<select name="category">
			<option value="kbo">KBO</option>
		    <option valu"WebContent/WEB-INF/jsp/login.jsp"e="lotte">�Ե�</option>
		    <option value="lg">����</option>
		    <option value="doosan">�λ�</option>
 			<option value="hanhwa">��ȭ</option>
		    <option value="kia">���</option>
		    <option value="samsung">�Ｚ</option>
 			<option value="kt">KT</option>
		    <option value="ssg">SSG</option>
		    <option value="nc">NC</option>
			<option value="kiwoom">Ű��</option>
  		</select>
		
	
	
	
		<input type="text" value="<%=name%>" name="author" readonly/>
		<input type="text" name="title" required />
		<input type="text" name="content" requried />
		<input type="file" name="apple" />
		<input type="submit" />
	</form>
	
</body>
</html>