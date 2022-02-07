package orange;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class UserDAO_MariaImpl implements UserDAO{

	@Override
	public List<UserVO> findAll() throws Exception {
		List<UserVO> ls = new ArrayList<UserVO>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(
				"jdbc:mariadb://183.111.242.21:3306/pukyung21",
				"pukyung21","pukyung00!!1");
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT * FROM user");
			
			while( rs.next() ) {
				UserVO vo = new UserVO();
				vo.setId(rs.getString("id"));
				vo.setPassword(rs.getString("password"));
				vo.setName(rs.getString("name"));
				vo.setPhone(rs.getString("phone"));
				ls.add( vo );
			}
		}
		catch( Exception e ) {
			System.out.println("throw e;");
			throw e; 
		}
		finally {
			System.out.println("finally ...");
			if( rs != null ) rs.close();
			if( stmt != null ) stmt.close();
			if( conn != null ) conn.close();
		}
		return ls;
	}

	@Override
	public UserVO findByPK(UserVO pvo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int delByPK(UserVO pvo) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int add(UserVO pvo) throws Exception {
		int uc = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(
				"jdbc:mariadb://183.111.242.21:3306/pukyung21",
				"pukyung21","pukyung00!!1");

			String sql = "INSERT INTO user VALUES (?, ?, ?, ?)";
			stmt = conn.prepareStatement( sql );

			stmt.setString(1, pvo.getId() );
			stmt.setString(2, pvo.getPassword());
			stmt.setString(3, pvo.getName());
			stmt.setString(4, pvo.getPhone());

			uc = stmt.executeUpdate();
		}
		catch( Exception e ) { throw e; }
		finally {
			if( stmt != null ) stmt.close();
			if( conn != null ) conn.close();
		}
		return uc;
	}
}
