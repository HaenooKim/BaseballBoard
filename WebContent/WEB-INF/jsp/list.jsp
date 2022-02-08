<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR"
    import="banana.BoardVO, banana.BoardDAO, banana.BoardDAO_MariaImpl, orange.BoardAndReplyVO, banana.Util, java.util.List"%>
    
    <%
    	List<BoardAndReplyVO> ls = (List<BoardAndReplyVO>)request.getAttribute("rList");
    
    	//-------���̺� ���������̼��� ������� ������ ���ϴ� �ڵ�--------	
    
    	BoardDAO dao = new BoardDAO_MariaImpl();
    	
    	int totalRows = dao.getTotalRows(); //���� �Խ����� �� row���� (���ڵ� ��)
    	
    	int ArticlesPerPage = 10; //�������� �� �� (���������� 10���� �����ٰ���) -> �����ϰ� ������ BoardDAO_MariaImpl�� ���� showingNumber�� ���� ���ڷ� �ٲ���� ��
    	int pageCount = ((totalRows-1)/ArticlesPerPage) + 1; //������ �� 
    	//[��������] = ( ( [���ڵ� ��] - 1 ) / [�������� �� ��] ) + 1;
    	
    	   
     	// -----����� ������ �� >ǥ�ø� ���� �������� ���ϴ� �ڵ�---
        	String CP = request.getParameter("currentPage"); 
        	int currentPage = 0;
        	if (CP==null || CP.equals("")) {
        		currentPage = 1;
        	}
        	else {
        		currentPage = Integer.parseInt(CP);
        	} //���� ���� �����ִ� ������ ��ȣ ����
        	
        	int blockSize = 5; // ��ϻ����� ����(5���� ���̸� > ǥ�ð� �� ����)
        	
        	int blockBegin = ((currentPage-1)/blockSize) * blockSize + 1; //���� ���������� ���� ù��° ��ȣ�� �������� ����
        	/*
        		[������] = ( ( [CP] -1 ) / [BS] ) * [BS] + 1
    			�� ( ( 3 - 1 ) / 5 ) * 5 + 1 �̹Ƿ� ����� 1 (6)
        	*/
        	int blockEnd = (blockBegin + blockSize-1) < pageCount ? (blockBegin + blockSize-1) : pageCount;
        	/*
        		[����] = [������] + [BS] - 1 �� [EP] �� ������
				5 �� 14 �� ���� ���̴ϱ� 5 (6)
        	*/
    	
    	
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
    	
    	//--------------------------------------------------------------------
    	
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
			<td><a href="categorySearch.pknu?category=<%=t.getCategory()%>&currentPage=<%=currentPage%>"><%=t.getCategory() %></a></td>
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
	
	<form method="GET" action="listSearch.pknu?currentPage=<%=currentPage %>">
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
		if (blockBegin != 1) {
			%><li><a href="list.pknu?currentPage=<%=blockBegin-1 %>">����</a></li><%
		}
	%>
	
	
		<%
			for (int i=blockBegin; i<=blockEnd; i++) {
				%><li><a href="list.pknu?currentPage=<%=i%>"><%=i%></a></li>
			<%
			}
		%>
		
		<%
			if (blockEnd != pageCount) {
				%><li><a href="list.pknu?currentPage=<%=blockEnd+1%>">����</a></li><%
			}
		%>
		
	</ul>
	
	������ ī��Ʈ : <%=pageCount %> ���������� : <%=currentPage %>
	�������� : <%=blockSize %> ����� : <%=blockBegin %>
	�� ���� : <%=blockEnd %>
	��Ż ���ڵ� : <%=totalRows %>

</body>
</html>    
