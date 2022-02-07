<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR"
    import="banana.BoardVO, banana.Util, java.util.List"%><%

    
    BoardVO vo = (BoardVO)request.getAttribute("content");
    String name = (String)session.getAttribute("name");
	if (name == null) { // 비 로그인 상태일 경우
		String ip = Util.getRemoteAddr(request);
		name=ip.substring(0, 7); // 실제로 보여지는 ip주소는 6자리까지만 
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
		<input type="submit" value="수정" />
	</form>
	
</body>
</html>