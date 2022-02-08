package banana;

import java.io.File;
import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import orange.BoardAndReplyVO;
import orange.ReplyDAO;
import orange.ReplyDAO_MariaImpl;
import orange.ReplyVO;
import orange.UserDAO;
import orange.UserDAO_MariaImpl;
import orange.UserVO;

@Control
public class CtrlBoard {
	
//-----------------ȸ������-----------------------------
	
	@RequestMapping("/signin.pknu")
	public ModelAndView signin(HttpServletRequest request, HttpServletResponse response) throws Exception {
		UserDAO dao = new UserDAO_MariaImpl();
		List<UserVO> rl = dao.findAll();
		
		ModelAndView mnv = new ModelAndView();
		mnv.setViewName("signin");
		mnv.addObject("rList", rl);
		return mnv;
	}
	
	@RequestMapping("/signinCheck.pknu")
	public String signinCheck(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
	
		UserDAO dao = new UserDAO_MariaImpl();
		List<UserVO> rl = dao.findAll();
		
		for (UserVO t : rl) {
			if (t.getId().equals(id)) {
				System.out.println("�̹� �����ϴ� id");
				return "redirect:signin.pknu";
			}
		}
		
		UserVO po = new UserVO();
		po.setId(id);
		po.setName(name);
		po.setPassword(password);
		po.setPhone(phone);
		dao.add(po);
		
		return "redirect:login.pknu";
		
	}
	//-----------------�α���-----------------------------
	
	@RequestMapping("/login.pknu")
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response) throws Exception {
		UserDAO dao = new UserDAO_MariaImpl();
		List<UserVO> rl = dao.findAll();
		
		ModelAndView mnv = new ModelAndView();
		mnv.setViewName("login");
		mnv.addObject("rList", rl);
		return mnv;
	}
	
	@RequestMapping("/loginCheck.pknu")
	public String loginCheck(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		HttpSession session = request.getSession();
		
		UserDAO dao = new UserDAO_MariaImpl();
		List<UserVO> rl = dao.findAll();
		
		for (UserVO t : rl) {
			if (t.getId().equals(id) && t.getPassword().equals(password)) {
				session.setAttribute("name", t.getName());
				System.out.println("�α��� ����");
				
				return "redirect:list.pknu";
			}
		}
		return "redirect:login.pknu?ecode=login_fail";
	}
	
	
	@RequestMapping("/logout.pknu")
	public String logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:login.pknu";	
	}
	
	//---------------------------�Խ��� ��ȸ--------------------------------------
	@RequestMapping("/list.pknu")
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String currentPage = request.getParameter("currentPage");
		int currentPage2 = 0;
		
		if (currentPage==null || currentPage.equals("")) {
			currentPage2 = 1;
		}
		else {
			currentPage2 = Integer.parseInt(currentPage);
		}
		System.out.println("���������� ��ȣ"+currentPage2);
		
		BoardDAO dao = new BoardDAO_MariaImpl();
		List<BoardAndReplyVO> rl = dao.findAll(currentPage2);
		
		ModelAndView mnv = new ModelAndView();
		mnv.setViewName("list");
		mnv.addObject("rList", rl);
		return mnv;
	}
	
	/*
	 * @RequestMapping("/list.pknu")
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		BoardDAO dao = new BoardDAO_MariaImpl();
		List<BoardAndReplyVO> rl = dao.findAll();
		
		ModelAndView mnv = new ModelAndView();
		mnv.setViewName("list");
		mnv.addObject("rList", rl);
		return mnv;
	}
	 */
	
	@RequestMapping("/showContent.pknu")
	public ModelAndView showContent(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String no = request.getParameter("no");
		ModelAndView mnv = new ModelAndView();
		if (no==null || no.equals("")) {
			mnv.setViewName("redirect:list.pknu?ecode=invalid_content");
			return mnv;
		}
		
		BoardDAO dao = new BoardDAO_MariaImpl();
		
		BoardAndReplyVO po = new BoardAndReplyVO();
		po.setNo(Integer.parseInt(no));
		List<BoardAndReplyVO> vo = dao.findByPK(po);
		int uc = dao.viewCount(vo.get(0)); //��ȸ�� ����
		
		mnv.setViewName("showContent");
		mnv.addObject("content", vo);
		return mnv;
	}
	
	@RequestMapping("/listSearch.pknu")
	public ModelAndView listSearch(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String search = request.getParameter("search"); // �˻������� ���� �˾Ƴ��� �ڵ�(�۾��� or ���� or ����+����)
		String target = request.getParameter("target"); // �� �˻��ߴ��� �˾Ƴ��� �ڵ�
		
		String searchCurrentPage = request.getParameter("searchCurrentPage"); //���� ������ (string)
		int currentPage2 = 0; //���� ������(int)
		System.out.println("�˻�" + searchCurrentPage);
		
		if (searchCurrentPage==null || searchCurrentPage.equals("")) {
			currentPage2 = 1;
		}
		else {
			currentPage2 = Integer.parseInt(searchCurrentPage);
		}
	
		BoardDAO dao = new BoardDAO_MariaImpl();
		List<BoardAndReplyVO> rl = null;
		
		BoardVO po = new BoardVO();
			
		if (search.equals("author")) {
			po.setAuthor(target);
			rl = dao.findByAuthor(po, currentPage2);
		}
		else if (search.equals("title")) {
			po.setTitle(target);
			rl=dao.findByTitle(po, currentPage2);
		}
		else if (search.equals("titlecontent")) {
			po.setTitle(target);
			po.setContent(target);
			rl=dao.findByTitlecontent(po, currentPage2);
		}
		
		ModelAndView mnv = new ModelAndView();
		mnv.setViewName("list");
		mnv.addObject("rList", rl);
		return mnv;
	}
	
	@RequestMapping("/categorySearch.pknu")
	public ModelAndView categorySearch(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String category = request.getParameter("category");
		
		String searchCurrentPage = request.getParameter("searchCurrentPage"); //���� ������ (string)
		int currentPage2 = 0; //���� ������(int)
		
		if (searchCurrentPage==null || searchCurrentPage.equals("")) {
			currentPage2 = 1;
		}
		else {
			currentPage2 = Integer.parseInt(searchCurrentPage);
		}
		
		ModelAndView mnv = new ModelAndView();
		
		if (category == null || category.equals("")) {
			mnv.setViewName("redirect:list.pknu?ecode=invalid_content");
			return mnv;
		}
		
		BoardDAO dao = new BoardDAO_MariaImpl();
		List<BoardAndReplyVO> rl = null;
		
		BoardVO po = new BoardVO();
		po.setCategory(category);
		rl=dao.findByCategory(po, currentPage2);
		
		mnv.setViewName("list");
		mnv.addObject("rList", rl);
		return mnv;
	}
	
	//---------------------------���� ����--------------------------------------
	
	@RequestMapping("/add.pknu")
	public ModelAndView add(HttpServletRequest request, HttpServletResponse response) throws Exception {
		BoardDAO dao = new BoardDAO_MariaImpl();
		
		MultipartRequest mpr = new MultipartRequest( request , Util.uploadDir(), 
				1024*1024*16 , "utf-8", null ); //request, ����������, ����ũ��, ���ڵ�, ��å(null)
		
		ModelAndView mnv = new ModelAndView();

		String category = mpr.getParameter("category");
		if (category == null || category.equals("")) {
			mnv.setViewName("redirect:write.pknu?ecode=invalid_content");
			return mnv;
		}

		String title = mpr.getParameter("title");
		if (title == null || title.equals("")) {
			mnv.setViewName("redirect:write.pknu?ecode=invalid_content");
			return mnv;
		}
		
		String content = mpr.getParameter("content");
		if (content == null || content.equals("")) {
			mnv.setViewName("redirect:write.pknu?ecode=invalid_content");
			return mnv;
		}
		
		String author = mpr.getParameter("author");
		if (author == null || author.equals("")) {
			mnv.setViewName("redirect:write.pknu?ecode=invalid_content");
			return mnv;
		}
		
		BoardVO po = new BoardVO();
		po.setCategory(category);
		po.setTitle(title);
		po.setContent(content);
		po.setAuthor(author);
		
		String ofn = mpr.getOriginalFileName("apple");
		if (ofn != null) {
			File file = mpr.getFile("apple");
			String fsn = UUID.randomUUID().toString();
			file.renameTo(new File(Util.uploadDir()+fsn));
			
			po.setOfn(ofn);
			po.setFsn(fsn);
		}
		
		dao.add(po);
		mnv.setViewName("redirect:list.pknu");
		return mnv;
	}
	
	@RequestMapping("/write.pknu") // �Խñ� �������� �� ���� �����ִ� ���
	public ModelAndView write(HttpServletRequest request, HttpServletResponse response) throws Exception {
		UserDAO dao = new UserDAO_MariaImpl();
		List<UserVO> rl = dao.findAll();
		
		ModelAndView mnv = new ModelAndView();
		mnv.setViewName("write");
		mnv.addObject("rList", rl);
		return mnv;
	}
	
	
	//-------------------����------------------------
	@RequestMapping("/showUpdate.pknu") // �Խù� ���������� �̵�
	public ModelAndView showUpdateContent(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String no = request.getParameter("no");
		ModelAndView mnv = new ModelAndView();
		
		if (no==null || no.equals("")) {
			mnv.setViewName("redirect:showContent.pknu?ecode=invalid_content");
			return mnv;
		}
		
		BoardDAO dao = new BoardDAO_MariaImpl();
		BoardVO vo = new BoardVO();
		vo.setNo(Integer.parseInt(no));
		
		BoardVO po = new BoardVO();
		po = dao.findByPK2(vo);
		
		mnv.setViewName("update");
		mnv.addObject("content", po);		
		return mnv;
	}
	
	@RequestMapping("/update.pknu")
	public ModelAndView update(HttpServletRequest request, HttpServletResponse response) throws Exception {
		BoardDAO dao = new BoardDAO_MariaImpl();
	
		MultipartRequest mpr = new MultipartRequest( request , Util.uploadDir(), 
				1024*1024*16 , "utf-8", null ); //request, ����������, ����ũ��, ���ڵ�, ��å(null)
		
		ModelAndView mnv = new ModelAndView();
		
		String no = mpr.getParameter("no");
		if (no == null || no.equals("")) {
			mnv.setViewName("redirect:write.pknu?ecode=invalid_content");
			return mnv;
		}
		
		String category = mpr.getParameter("category");
		if (category == null || category.equals("")) {
			mnv.setViewName("redirect:write.pknu?ecode=invalid_content");
			return mnv;
		}

		String title = mpr.getParameter("title");
		if (title == null || title.equals("")) {
			mnv.setViewName("redirect:write.pknu?ecode=invalid_content");
			return mnv;
		}
		System.out.println("����" + title);
		
		String content = mpr.getParameter("content");
		if (content == null || content.equals("")) {
			mnv.setViewName("redirect:write.pknu?ecode=invalid_content");
			return mnv;
		}
		System.out.println("����" + content);
		
		String author = mpr.getParameter("author");
		if (author == null || author.equals("")) {
			mnv.setViewName("redirect:write.pknu?ecode=invalid_content");
			return mnv;
		}
		
		BoardVO po = new BoardVO();
		po.setNo(Integer.parseInt(no));
		po.setCategory(category);
		po.setTitle(title);
		po.setContent(content);
		po.setAuthor(author);
		
		String ofn = mpr.getOriginalFileName("apple");
		if (ofn != null) {
			File file = mpr.getFile("apple");
			String fsn = UUID.randomUUID().toString();
			file.renameTo(new File(Util.uploadDir()+fsn));
			
			po.setOfn(ofn);
			po.setFsn(fsn);
		}
		
		dao.update(po); 
		mnv.setViewName("redirect:list.pknu");
		return mnv;
		
	}
	
	//----------------��۴ޱ�
	
	@RequestMapping("/writeReply.pknu")
	public String writeReply(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ReplyDAO dao = new ReplyDAO_MariaImpl();
		
		String no = request.getParameter("no");
		if (no==null || no.equals("")) {
			return "redirect:showContent.pknu?ecode=invalid_content";
		}
		
		String replyContent = request.getParameter("replyContent");
		String replyAuthor = request.getParameter("replyAuthor");
		ReplyVO po = new ReplyVO();
		po.setNo(Integer.parseInt(no));
		po.setReplyContent(replyContent);
		po.setReplyAuthor(replyAuthor);
		dao.writeReply(po);
		
		return "showContent.pknu";
	}
	
	//----------------�Խñ� ���� �� ����--------------------

	@RequestMapping("/deleteBoard.pknu")
	public ModelAndView deleteBoard(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mnv = new ModelAndView();
		
		String no = request.getParameter("no");
		
		if( no == null || no.equals("")) {
			mnv.setViewName("redirect:list.do?ecode=invalid_no");
			return mnv;
		}
		
		BoardDAO dao = new BoardDAO_MariaImpl();
		BoardVO po = new BoardVO();
		po.setNo(Integer.parseInt(no));
		BoardVO vo = dao.findByPK2(po);
		int uc = dao.delByPK(po);
		
		if( uc > 0 && vo.getFsn() != null ) {
			File file = new File( Util.uploadDir() + vo.getFsn() );
			if( file.exists() ) {
				file.delete();
			}
		}
		mnv.setViewName("redirect:list.pknu");
		return mnv;
		
	}
	
	@RequestMapping("/deleteReply.pknu")
	public String deleteReply(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String replyNo = request.getParameter("replyNo");		
		if( replyNo == null || replyNo.equals("")) {
			return "redirect:showContent.pknu?ecode=invalid_no";
		}
		
		ReplyDAO dao = new ReplyDAO_MariaImpl();
		ReplyVO po = new ReplyVO();
		po.setReplyNo(Integer.parseInt(replyNo));
		ReplyVO vo = dao.findByPK(po);
		int uc = dao.delByPK(po);
		
		return "showContent.pknu?no="+vo.getNo();
	}
}
