package banana;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import orange.UserDAO;
import orange.UserDAO_MariaImpl;
import orange.UserVO;

@Control
public class CtrlBoard {
	
	@RequestMapping("/list.pknu")
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		BoardDAO dao = new BoardDAO_MariaImpl();
		List<BoardVO> rl = dao.findAll();
		
		ModelAndView mnv = new ModelAndView();
		mnv.setViewName("list");
		mnv.addObject("rList", rl);
		return mnv;
	}
	
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
	
	@RequestMapping("/add.pknu")
	public ModelAndView add(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
	return null;
	}
	
	@RequestMapping("/write.pknu")
	public ModelAndView write(HttpServletRequest request, HttpServletResponse response) throws Exception {
		UserDAO dao = new UserDAO_MariaImpl();
		List<UserVO> rl = dao.findAll();
		
		ModelAndView mnv = new ModelAndView();
		mnv.setViewName("write");
		mnv.addObject("rList", rl);
		return mnv;
	}


}
