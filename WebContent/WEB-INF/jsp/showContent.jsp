<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR"
    import="orange.UserVO, banana.BoardVO, orange.BoardAndReplyVO, banana.Util, java.util.List"%><%
    		List<BoardAndReplyVO> vo = (List<BoardAndReplyVO>)request.getAttribute("content");
    String name = (String)session.getAttribute("name");
    String ip = null;
	if (name == null) {
		ip = Util.getRemoteAddr(request);
		name=ip.substring(0, 7); //6자리까지만 공개한다.
	}
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>

<script>
	function handleBtn() {
		if (confirm("정말 삭제하시겠습니까?")==true) {
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
	%><button>수정하기</button>
		<a href="deleteBoard.pknu?no=<%=vo.get(0).getNo()%>"><button onclick="handleBtn();">삭제하기</button></a>
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
						%><button>수정하기</button>
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
		<input type="submit" value="댓글등록"/>		
	</form>
	
</body>
</html>