<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR"
    import="banana.BoardVO, banana.BoardDAO, banana.BoardDAO_MariaImpl, orange.BoardAndReplyVO, banana.Util, java.util.List"%>
    
    <%
    	List<BoardAndReplyVO> ls = (List<BoardAndReplyVO>)request.getAttribute("rList");
    
    	BoardDAO dao = new BoardDAO_MariaImpl();
    	
    	int totalRows = dao.getTotalRows(); //���� �Խ����� �� row���� (���ڵ� ��)
    	
    	int ArticlesPerPage = 10; //�������� �� �� (���������� 10���� �����ٰ���)
    	int pageCount = ((totalRows-1)/ArticlesPerPage) + 1; //������ �� 
    	//[��������] = ( ( [���ڵ� ��] - 1 ) / [�������� �� ��] ) + 1;
    	
    	
    			
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
<%--

--%><!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

</head>
<body>

	<span><%=name %>�� �ȳ��ϼ���</span>
	
	<%
		if (ls.isEmpty()) {
			%>��ȸ�ϴ� ����� �����ϴ�.<% 
		}
	%>
	
	<table> <% 	
	if (ls != null) {
		for (BoardAndReplyVO t : ls) {
			%>
			
			<tr>
			<td><%=t.getNo() %></td>
			<td><a href="categorySearch.pknu?category=<%=t.getCategory()%>"><%=t.getCategory() %></a></td>
			<td><a href="showContent.pknu?no=<%=t.getNo()%>"><%=t.getTitle() %></a></td>
			<td><%=t.getAuthor() %></td>
			<td><%=t.getTime().substring(0, 16) %></td>
			<td>��ȸ��<%=t.getView() %>
			</tr>
			
			<%
		}
	}
	%>
	</table>
	
	<a href="write.pknu"><button>�۾���</button></a>
	<a href=<%=a%>><button><%=btnName %></button></a>
	
	<form method="GET" action="listSearch.pknu">
		<select name="search">
		    <option value="author">�۾���</option>
		    <option value="title">����</option>
		    <option value="titlecontent">����+����</option>
		    <input type="text" name="target" required minlength='2'/>
		    <input type="submit" value="�˻�"/> 
  		</select>
	</form>
	
	<ul class="pagination">
		<%
			for (int i=1; i<=pageCount; i++) {
				%><li><a href="list.pknu?pageCount=<%=i%>"><%=i%></a></li><%
			}
		%>
	</ul>

</body>
</html>    
