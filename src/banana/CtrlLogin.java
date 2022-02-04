package banana;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Control
public class CtrlLogin {
	@RequestMapping("/login.pknu")
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		System.out.println("login");
	return null;
	}

}
