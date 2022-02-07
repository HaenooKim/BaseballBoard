<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR"
    import="orange.UserVO, banana.BoardVO, orange.BoardAndReplyVO, banana.Util, java.util.List"%><%
    		List<BoardAndReplyVO> vo = (List<BoardAndReplyVO>)request.getAttribute("content");
    String name = (String)session.getAttribute("name");
    String ip = null;
	if (name == null) {
		ip = Util.getRemoteAddr(request);
		name=ip.substring(0, 7); //6�ڸ������� �����Ѵ�.
	}
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>

<script>
	function handleBtn() {
		if (confirm("���� �����Ͻðڽ��ϱ�?")==true) {
			document.form.submit();
		}
		else {
			return;
		}
	}
</script>


</head>
<body>

<%if(vo.get(0).getAuthor().equals(name) ) {
	%><a href="showUpdate.pknu?no=<%=vo.get(0).getNo()%>"><button>�����ϱ�</button></a>
		<a href="deleteBoard.pknu?no=<%=vo.get(0).getNo()%>"><button onclick="handleBtn();">�����ϱ�</button></a>
	<% 
}
%>
<div>
	<span><%=vo.get(0).getTitle() %></span>
	<span><%=vo.get(0).getAuthor()%></span>
	<span><%=vo.get(0).getView() %></span>
	<span><%=vo.get(0).getTime().substring(0,16) %></span>
</div>

<div>
	
	<%=vo.get(0).getContent() %>


</div>
	
	
	<table>
	<%
		if (vo.get(0).getReplyContent() != null) {
			for(BoardAndReplyVO t : vo) {
				%><tr>			
				<td><%=t.getReplyAuthor() %></td>
				<td><%=t.getReplyContent()%>
					<%if(t.getReplyAuthor().equals(name) ) {
						%>
							<a href="deleteReply.pknu?replyNo=<%=t.getReplyNo()%>"><button onclick="handleBtn();">[X]</button></a>
					<% 
				}
			%>
					
				
				</td>
				</tr><%
				
			}
		}
	%>
	</table>

	<form action="writeReply.pknu">
		<input type="text" name="replyAuthor" value=<%=name %> readOnly/>
		<input type="text" name="replyContent"/>
		<input type="hidden" name="no" value=<%=vo.get(0).getNo() %> readOnly/>
		<input type="submit" value="��۵��"/>		
	</form>
	
</body>
</html>