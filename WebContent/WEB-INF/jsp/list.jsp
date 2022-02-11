<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR"
    import="banana.BoardVO, banana.BoardDAO, banana.BoardDAO_MariaImpl, orange.BoardAndReplyVO, banana.Util, java.util.List"%>
    
    <%
    	List<BoardAndReplyVO> ls = (List<BoardAndReplyVO>)request.getAttribute("rList"); // �Խ��� ������ �޴´�.
    
	    BoardDAO dao = new BoardDAO_MariaImpl();
		
		int totalRows = dao.getTotalRows(); //���� �Խ����� �� row���� (���ڵ� ��)
    
    //------------���� �˻��� ���� �޴� �Ŷ��...? ---------------------
    	String searchCurrentPage = request.getParameter("searchCurrentPage");
    	Boolean checkSearch = false; //�� �������� �˻��� ���������� �Ѿ�°��� �׳� ��ü ����Ʈ ���������� Ȯ��
    	String search = null;
		String target = null;
    	if (searchCurrentPage != null) {
    		checkSearch = true;
    		search = request.getParameter("search"); // �˻������� ���� �˾Ƴ��� �ڵ�(�۾��� or ���� or ����+����)
    		target = request.getParameter("target"); // �� �˻��ߴ��� �˾Ƴ��� �ڵ�
    		totalRows=dao.getTotalRows(search, target); //���� �˻��� ����� �������� �Ŷ�� ���⼭ ã�ƾ� �Ѵ�!!
    	}
    	
    	//-------���̺� ���������̼��� ������� ������ ���ϴ� �ڵ�--------	
    
    	int ArticlesPerPage = 40; //�������� �� �� (���������� 10���� �����ٰ���) -> �����ϰ� ������ BoardDAO_MariaImpl�� ���� showingNumber�� ���� ���ڷ� �ٲ���� ��
    	int pageCount = ((totalRows-1)/ArticlesPerPage) + 1; //������ �� 
    	//[��������] = ( ( [���ڵ� ��] - 1 ) / [�������� �� ��] ) + 1;
    	
    	   
     	// -----����� ������ �� >ǥ�ø� ���� �������� ���ϴ� �ڵ�---
        	String CP=null;
     		if (checkSearch) {
     			CP = searchCurrentPage;
     		}
     		else {     			
     			CP = request.getParameter("currentPage"); 
     		}
     		
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
    	
    	//----------------------------- html ---------------------------------------
    	
    %>
<%--
--%><!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" type = "images/jpg" href="images/pknu.jpg">
<link rel="stylesheet" href="css/list.css">

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
<title>Basball Park</title>

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
  
  <!------------- board ------------->
	<section class="notice">
	 <div class="page-title">
          <div class="container">
              <h2>�߱� �Խ���</h2>
          </div>
      </div>
	<div id="board-list">
		<div class="container">
			<table class="board-table"> 
				<thead>
                  <tr>
                      <th scope="col" class="th-num">��ȣ</th>
                      <th scope="col" class="th-title">����</th>
                      <th scope="col" class="th-author">�۾���</th>
                      <th scope="col" class="th-date">�����</th>
                      <th scope="col" class="th-view">��ȸ��</th>
                  </tr>
                  </thead>
				<tbody>
					<% 	
					if (ls.isEmpty() || ls==null){
						%><span class="alert__search">��ȸ����� �����ϴ�.</span><%
					}
					
					else{
						
						if (checkSearch) {
							%><span class="alert__search"><%=totalRows%>���� �˻��Ǿ����ϴ�.<span><%
						}
						
						for (BoardAndReplyVO t : ls) {
							%><tr>
							<td><%=t.getNo() %></td>
							<td style="text-align:left">
							<%
								if (t.getOfn() !=null) {
									%><span style="color:#418f33;)"><i class="fas fa-image"></i></span><%
								}
								else if (t.getOfn() == null) {
									%><span style="color:rgba(0, 0, 0, 0.4);)"><i class="far fa-comment-dots"></i></span><%
								}
							%>
							<a style="color:#4a3dff" href="categorySearch.pknu?category=<%=t.getCategory()%>&currentPage=<%=currentPage%>"><%=t.getCategory() %></a>
							<a href="showContent.pknu?no=<%=t.getNo()%>"><%=t.getTitle() %></a>
							<%
								if(dao.getRelpyCount(t.getNo()) !=0) {
									%><a style="color:tomato;" class="reply_count" href="showContent.pknu?no=<%=t.getNo()%>">[<%=dao.getRelpyCount(t.getNo()) %>]</a><%
								}
							%>
							</td>
							<td><%=t.getAuthor() %></td>
							<td><%=t.getTime().substring(0, 16) %></td>
							<td><%=t.getView() %>
							</tr><%
						}
					}
					%>
				</tbody>
			</table>
		</div>
	</div>
	
  	<!------------- �۾���, ��ü�� ��ư ------------->
	</section>
		<div class="btn-wrap">
		<a href="list.pknu"><button class="list_btn">��ü��</button></a>
		<a href="write.pknu"><button class="write_btn">�۾���</button></a>
	</div>
	
	
	  <!------------- ���������̼� ------------->
	<ul class="pagination my">
	<%
	if (checkSearch) {//�˻��� ���
		
		if (blockBegin != 1) {
			%><li><a href="listSearch.pknu?searchCurrentPage=<%=blockBegin-1%>&target=<%=target%>&search=<%=search%>">����</a></li><%
		}
	%><%
			for (int i=blockBegin; i<=blockEnd; i++) {
				if (currentPage == i) {
					%><li class="active"><a href="javascript:void(0);"><%=i%></a></li><%
				}
				else {
					%><li><a href="listSearch.pknu?searchCurrentPage=<%=i%>&target=<%=target%>&search=<%=search%>"><%=i%></a></li>	<%
				}
			}
		%><%
			if (blockEnd != pageCount) {
				%><li><a href="listSearch.pknu?searchCurrentPage=<%=blockEnd+1%>&target=<%=target%>&search=<%=search%>">����</a></li><%
			}
	}
	
	else { //�˻��� �ƴ� �׳� ����Ʈ�� �ҷ��� ���
		if (blockBegin != 1) {
			%><li><a href="list.pknu?currentPage=<%=blockBegin-1 %>">����</a></li><%
		}
	%>
		<%
			for (int i=blockBegin; i<=blockEnd; i++) {
				if (currentPage == i) {
					%><li class="active"><a href="javascript:void(0);"><%=i%></a></li><%
				}
				else {
					%><li><a href="list.pknu?currentPage=<%=i%>"><%=i%></a></li>
					<%		
				}
				
			
			}
			if (blockEnd != pageCount) {
				%><li><a href="list.pknu?currentPage=<%=blockEnd+1%>">����</a></li><%
			}
		}
		%>
	</ul>
	
	
	  <!------------- �˻�â ------------->
	<section class="search">
		<form method="GET" action="listSearch.pknu">
			<select class="search__select" name="search">
			    <option value="author">�۾���</option>
			    <option value="title">����</option>
			    <option value="titlecontent">����+����</option>
	  		</select>
			<input class="search__text" type="text" name="target" required minlength='2' placeholder="�˻�� �Է����ּ���"/>
			<input type="hidden" name="searchCurrentPage" value="1" />
			 <button type="submit" class="search__btn">
	        	 <i class="fa fa-search"></i>
	    	  </button>
		</form>
	</section>
	
	<!-- 
	������ ī��Ʈ : <%=pageCount %> ���������� : <span class="current_page"><%=currentPage %></span>
	�������� : <%=blockSize %> ����� : <%=blockBegin %>
	�� ���� : <%=blockEnd %>
	��Ż ���ڵ� : <%=totalRows %>
	�˻��Ѱų�?<%=checkSearch %>
	-->
	<script>
	/*-------�������� Hamberger bar���̰� �ϱ� ----*/
		const toggleBtn = document.querySelector(".header__toggleBtn");
		const menu = document.querySelector(".header__menu");
		const user = document.querySelector(".header__user");
		
		toggleBtn.addEventListener('click', () => {
			menu.classList.toggle('active');
			user.classList.toggle('active');
		});
	
	</script>


</body>
</html>    