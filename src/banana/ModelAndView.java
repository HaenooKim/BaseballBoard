package banana;

import java.util.Hashtable;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

public class ModelAndView {

	public String getViewName() {
		return viewName;
	}
	public void setViewName(String viewName) {
		this.viewName = viewName;
	}
	private String viewName = null;
	
	private Map<String,Object> objMap = null;
	
	public void addObject( String key, Object val ) {
		if( objMap == null ) {
			objMap = new Hashtable<String,Object>();
		}
		objMap.put( key, val );
	}
	
	public void plant( HttpServletRequest request ) {
		if( objMap != null ) {
			Set<String> ks = objMap.keySet();
			for( String key : ks ) {
				Object val = objMap.get(key);
				request.setAttribute( key, val );
			}
		}
	}
}
