<%@ page contentType="text/html; charset=utf-8"
    pageEncoding="EUC-KR"
    import="orange.UserVO, banana.BoardVO, orange.BoardAndReplyVO, banana.Util, java.util.List"%><%
    		List<BoardAndReplyVO> vo = (List<BoardAndReplyVO>)request.getAttribute("content");
    
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
<link rel="stylesheet" href="css/showContent.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
 <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>�Խñ� ��ȸ</title>

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



<section class="showContent">
	<div class="showContent_wrap">
	
		<!-- ����, ����, �ۼ��� ���� �� ��(����Ʈ�� ���) -->
		<div class="showContent_information">
			<div class="showContent_information_column1">
				<div class="showContent_information_title">
					<span>[<%=vo.get(0).getCategory() %>]</span>
					<span><%=vo.get(0).getTitle() %></span>
				</div>
				<div class="showContent_information_author">
					<span><%=vo.get(0).getAuthor()%></span>
					<span><%=vo.get(0).getTime().substring(0,16) %></span>
				</div>
			</div>
		
			<div class="showContent_information_column2">
				<span style="margin-right:5px;">��ȸ <%=vo.get(0).getView() %></span>
				<span>��ۼ�</span>
			</div>
		</div>
		
		<!-- ������ �� �� -->
		<div class="showContent_information_content">
			<span><%=vo.get(0).getContent() %></span>
		</div>
		 
		
		<!-- ÷�ε� ������ ������ div���� �� footer -->
		<div class="showContent_information_footer">
							<div class="showContent_information_file">
			<%
					if (vo.get(0).getOfn() != null && vo.get(0).getFsn() != null) {
						String ofn = vo.get(0).getOfn();
						%>
								<a href="down.pknu?fsn=<%=vo.get(0).getFsn()%>&ofn<%=ofn%>">
									<%=vo.get(0).getFsn() %>&nbsp;<i class="fas fa-download"></i>
								</a>
						<%
					}
			%>
							</div>
			<div class="share_layer">
				<span><i class="fas fa-share"></i></span>
				&nbsp;<span><i class="far fa-clone"></i></span>
			</div>
		
		</div>
		
	</div>
		
</section>

<%if(vo.get(0).getAuthor().equals(name) ) {
	%><div class="board_update"><a href="showUpdate.pknu?no=<%=vo.get(0).getNo()%>"><button class="modify_btn">�����ϱ�</button></a>
		<a onclick="return confirm('���� �����Ͻðڽ��ϱ�?');" href="deleteBoard.pknu?no=<%=vo.get(0).getNo()%>"><button class="delete_btn">�����ϱ�</button></a>
	</div><% 
}
%>


	
<!------------- ��� ���̺� ------------->

<h3 class="reply_title">��ü ���</h3>
<div id="board-list">
		<div class="container">
			<table class="board-table"> 
				<tbody>
					<%
		if (vo.get(0).getReplyContent() != null) {
			for(BoardAndReplyVO t : vo) {
				%><tr>			
				<td class="replyAuthor"><%=t.getReplyAuthor() %></td>
				<td class="replyContent"><%=t.getReplyContent()%></td>
				<td class="replyTime"><%=t.getReplyTime().substring(0, 16)%>
					<%if(t.getReplyAuthor().equals(name) ) {
						%>
							<a onclick="return confirm('���� �����Ͻðڽ��ϱ�?');" href="deleteReply.pknu?replyNo=<%=t.getReplyNo()%>"><button class="reply_delete_btn" ><i class="fas fa-times-circle"></i></button></a>
					<%
				
				}
					else {
						%><button class="reply_delete_btn"  style="visibility: hidden;"><i class="fas fa-times-circle"></i></button><%
					}
			%>
				</td>
				</tr><%
				
			}
		}
	%>
				</tbody>
			</table>
		</div>
	</div>



<!------------- ��� ��� ------------->

	<section class="write_reply">
		<form action="writeReply.pknu" method="GET" class="wrtie_reply_form">
			<input type="hidden" name="replyAuthor" value=<%=name %> readOnly/>
			
			<div class="write_reply_content">
				<textarea cols="15" rows="4" name="replyContent" maxlength='200'></textarea>
			</div>
				<input type="hidden" name="no" value=<%=vo.get(0).getNo() %> readOnly/>
				
			<div class="reply_enroll_btn_wrap">			
				<input class="reply_enroll_btn" type="submit" value="��۵��"/>				
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
		
	
	</script>
</body>
</html>