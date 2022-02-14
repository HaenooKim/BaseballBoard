package banana;

import java.net.InetAddress;

import javax.servlet.http.HttpServletRequest;

public class Util {
	public static String uploadDir() {
		String t = System.getProperty("os.name");
		String upload = "/pukyung21/upload/";
		if( t.indexOf("indows") != -1 ) {
			upload = "C:\\upload\\";
		}
		return upload;
	}
	
	
	public static String han( String l ) {
		if( l == null || l.equals("") )
			return l;
		try {
			l = new String( l.getBytes("8859_1") , "utf-8");
		}
		catch( Exception e ) {}
		return l;
	}
	
	public static String getRemoteAddr( HttpServletRequest request ) 
	{
		String t = System.getProperty("os.name");
		if( t.indexOf("indows") != -1 ) 
		{
			try {
				return InetAddress.getLocalHost().getHostAddress().toString();
			}
			catch( Exception e ) {
				return "127.0.0.1";
			}
		}
		
		String ip = request.getHeader("X-FORWARDED-FOR"); 
        if (ip == null || ip.length() == 0) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0) {
            ip = request.getHeader("HTTP_CLIENT_IP");     
        }
        if (ip == null || ip.length() == 0) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR"); 
        }
        if (ip == null || ip.length() == 0) {
            ip = request.getRemoteAddr() ;
        }
        return ip;
	} 	
}
