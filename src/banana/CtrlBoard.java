package banana;

import java.io.File;
import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import orange.UserDAO;
import orange.UserDAO_MariaImpl;
import orange.UserVO;

@Control
public class CtrlBoard {
	
//-----------------회원가입-----------------------------
	
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
				System.out.println("이미 존재하는 id");
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
	//-----------------로그인-----------------------------
	
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
				System.out.println("로그인 성공");
				
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
	
	//---------------------------게시판 조회--------------------------------------
	@RequestMapping("/list.pknu")
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		BoardDAO dao = new BoardDAO_MariaImpl();
		List<BoardVO> rl = dao.findAll();
		
		ModelAndView mnv = new ModelAndView();
		mnv.setViewName("list");
		mnv.addObject("rList", rl);
		return mnv;
	}
	
	@RequestMapping("/showContent.pknu")
	public ModelAndView showContent(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String no = request.getParameter("no");
		System.out.println(no);
		
		BoardDAO dao = new BoardDAO_MariaImpl();
		
		BoardVO po = new BoardVO();
		po.setNo(Integer.parseInt(no));
		BoardVO vo = dao.findByPK(po);
		int uc = dao.viewCount(vo); //조회수 증가
		
		ModelAndView mnv = new ModelAndView();
		mnv.setViewName("showContent");
		mnv.addObject("content", vo);
		return mnv;
	}
	
	
	@RequestMapping("/listSearch.pknu")
	public ModelAndView listSearch(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String search = request.getParameter("search"); // 검색주제가 뭔지 알아내는 코드(글쓴이 or 제목 or 제목+내용)
		String target = request.getParameter("target"); // 뭘 검색했는지 알아내는 코드
		
		BoardDAO dao = new BoardDAO_MariaImpl();
		List<BoardVO> rl = null;
		
		BoardVO po = new BoardVO();
			
		if (search.equals("author")) {
			po.setAuthor(target);
			rl = dao.findByAuthor(po);
			
		}
		else if (search.equals("title")) {
			po.setTitle(target);
			rl=dao.findByTitle(po);
		}
		else if (search.equals("titlecontent")) {
			po.setTitle(target);
			po.setContent(target);
			rl=dao.findByTitlecontent(po);
		}
		
		ModelAndView mnv = new ModelAndView();
		mnv.setViewName("list");
		mnv.addObject("rList", rl);
		return mnv;
		/*
		 * 
		 * 	BoardDAO dao = new BoardDAO_MariaImpl();
		List<BoardVO> rl = dao.findAll();
		
		ModelAndView mnv = new ModelAndView();
		mnv.setViewName("list");
		mnv.addObject("rList", rl);
		return mnv;
		
		--------------
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		HttpSession session = request.getSession();
		
		UserDAO dao = new UserDAO_MariaImpl();
		List<UserVO> rl = dao.findAll();
		
		for (UserVO t : rl) {
			if (t.getId().equals(id) && t.getPassword().equals(password)) {
				session.setAttribute("name", t.getName());
				System.out.println("로그인 성공");
				
				return "redirect:list.pknu";
			}
		}
		
		return "redirect:login.pknu?ecode=login_fail";
		*/
		
	}
	
	
	
	//---------------------------쓰기 관련--------------------------------------
	
	@RequestMapping("/add.pknu")
	public ModelAndView add(HttpServletRequest request, HttpServletResponse response) throws Exception {
		BoardDAO dao = new BoardDAO_MariaImpl();
		ModelAndView mnv = new ModelAndView();
		
		String title = request.getParameter("title");
		System.out.println(title);
		if (title==null || title.equals("")) {
			mnv.setViewName("redirect:list.pknu?ecode=invalid_content");
			return mnv;
		}
		
		String content = request.getParameter("content");
		System.out.println(content);
		if (content==null || content.equals("")) {
			mnv.setViewName("redirect:list.pknu?ecode=invalid_content");
			return mnv;
		}
		
		String author = request.getParameter("author");
		System.out.println(content);
		if (content==null || content.equals("")) {
			mnv.setViewName("redirect:list.pknu?ecode=invalid_content");
			return mnv;
		}
		
		BoardVO po = new BoardVO();
		po.setTitle(title);
		po.setContent(content);
		po.setAuthor(author);
		po.setOfn("2");
		po.setFsn("3");
		po.setView(4);
		dao.add(po);
		
		mnv.setViewName("redirect:list.pknu"); 
		return mnv;
	
	}
	
	@RequestMapping("/write.pknu") // 게시글 선택했을 때 내용 보여주는 기능
	public ModelAndView write(HttpServletRequest request, HttpServletResponse response) throws Exception {
		UserDAO dao = new UserDAO_MariaImpl();
		List<UserVO> rl = dao.findAll();
		
		ModelAndView mnv = new ModelAndView();
		mnv.setViewName("write");
		mnv.addObject("rList", rl);
		return mnv;
	}


}
