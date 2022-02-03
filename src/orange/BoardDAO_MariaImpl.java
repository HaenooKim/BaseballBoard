package orange;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO_MariaImpl implements BoardDAO{

	@Override
	public List<BoardDAO> findAll() throws Exception {
		List<BoardVO> ls = new ArrayList<BoardVO>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(
				"jdbc:mariadb://183.111.242.21:3306/pukyung21",
				"pukyung21","pukyung00!!1");
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select * from board ORDER BY no DESC");
			
			while(rs.next()) {
				
			}
			
		}
		catch(Exception e) {
			throw e;
		}
		
		finally {
			if (conn !=null) conn.close();
			if (stmt !=null) stmt.close();
			if (rs != null) rs.close();
		}
		
		
		return null;
	}

	@Override
	public BoardVO findByPK(BoardVO pvo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int delByPK(BoardVO pvo) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int add(BoardVO pvo) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
}
