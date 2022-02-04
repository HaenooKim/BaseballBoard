package banana;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO_MariaImpl implements BoardDAO{

	@Override
	public List<BoardVO> findAll() throws Exception {
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
				BoardVO vo = new BoardVO();
				
				vo.setNo(rs.getInt("no"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setAuthor(rs.getString("author"));
				vo.setOfn(rs.getString("ofn"));
				vo.setFsn(rs.getString("fsn"));
				vo.setView(rs.getInt("view"));
				vo.setTime(rs.getString("time"));
				
				ls.add( vo );
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
		return ls;
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
		return 0;
	}
}
