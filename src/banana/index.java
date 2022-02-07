package banana;

import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.Method;
import java.util.Hashtable;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class index extends HttpServlet{
	@Override
	public void init(ServletConfig config) throws ServletException {
		String l = config.getInitParameter("controller");
		String[] l2 = l.split(",");
		
		for (String l3 : l2) {
			try {
				Class<?> cls = Class.forName(l3.trim()); //banana.CtrlList banana.CtrlAdd
				Object target  = cls.newInstance();
				
				Control annot = cls.getAnnotation(Control.class);
				if (annot != null) {
					Method[] mtds = cls.getMethods();
					for (Method mtd : mtds) {
						RequestMapping annot2 = mtd.getAnnotation(RequestMapping.class);
						if (annot2 != null) {
							String uri = annot2.value();
							methodMap.put(uri, new MethodAndTarget(mtd, target));
						}
					}
				}
				else {
					System.out.println("@Control이 명시되지 않음");
				}
			}
			catch(Exception e) {e.printStackTrace();}		
		}
	}
	
	private static class MethodAndTarget {
		Method method = null;
		Object target = null;
		MethodAndTarget(Method m, Object t) {
			method = m;
			target = t;
		}
	}
	
	private Map<String, MethodAndTarget> methodMap = null;
	
	public index() {
		methodMap = new Hashtable<String, MethodAndTarget>();
	}
	
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		String ctxPath = request.getContextPath();
		
		String uri2 = uri.substring(ctxPath.length());
		MethodAndTarget mnt = methodMap.get(uri2);
		
		String prefix = "/WEB-INF/jsp/";
		String suffix = ".jsp";
		
		if (mnt!=null) {
			//System.out.println(mnt.method);
			//System.out.println(mnt.target);
			
			try {
				
				Object obj = mnt.method.invoke(mnt.target, request, response);
				if (obj != null) {
					if (obj instanceof ModelAndView) {
						ModelAndView mnv = (ModelAndView)obj;
						
						String viewName = mnv.getViewName();
						
						if (viewName==null) {}
						else if (viewName.startsWith("redirect:")) {
							response.sendRedirect(viewName.substring(9));
						}
						else {
							String view = prefix + viewName + suffix;
							RequestDispatcher rd = request.getRequestDispatcher(view);
							mnv.plant(request);
							rd.forward(request, response);
						}
					}
					
					else if( obj instanceof String ) 
					{
						ResponseBody annot3 = mnt.method.getAnnotation( ResponseBody.class );
						if( annot3 != null ) {
							String l = obj.toString();
							if( l != null ) 
							{
								//	한글 깨짐을 해결키 위해 utf-8 로 변환시켜서 내보낸다.
								response.setContentType("text/plain;charset=utf-8");
								
								OutputStream out = response.getOutputStream();
								out.write( l.getBytes("utf-8") ); 
								out.flush();
								out.close();
							}
						}
						else
						{
							String res = (String)obj;
							if( res.startsWith("redirect:") ) {
								response.sendRedirect( res.substring(9) );
							}
							else {
								RequestDispatcher rd = request.getRequestDispatcher( res );
								rd.forward( request, response );
							}
						}
					}
				}
			}
			catch(Exception e) {
				if (e.getCause()!=null) {
					request.setAttribute("err", e.getCause());					
				}
				else
					request.setAttribute("err", e);
				
				String view = prefix + "error" + suffix;
				RequestDispatcher rd = request.getRequestDispatcher(view);
				rd.forward(request, response);
				
			}
		}
		else {
			System.out.println(uri2 + "에 지정된 컨트롤러 함수가 없습니다.");
		}
	}
}
