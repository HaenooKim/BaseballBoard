package orange;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;


public class ReplyDAO_MariaImpl implements ReplyDAO{

	@Override
	public int writeReply(ReplyVO pvo) throws Exception {
		int uc = 0;
		
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(
					"jdbc:mariadb://183.111.242.21:3306/pukyung21",
					"pukyung21","pukyung00!!1");
			stmt = conn.prepareStatement("insert into reply values(default, ?, ?, ?, NOW());");
			stmt.setInt(1, pvo.getNo());
			stmt.setString(2, pvo.getReplyAuthor());
			stmt.setString(3, pvo.getReplyContent());
			uc = stmt.executeUpdate();
		}
		catch(Exception e) {}
		finally {
			if(conn!=null) conn.close();
			if(stmt!=null) stmt.close();
		}
		
		
		
		return uc;
	}

	@Override
	public ReplyVO findByPK(ReplyVO pvo) throws Exception {
		ReplyVO vo = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(
				"jdbc:mariadb://183.111.242.21:3306/pukyung21",
				"pukyung21","pukyung00!!1");
			stmt = conn.prepareStatement("SELECT * FROM reply WHERE replyNo = ?");
			stmt.setInt( 1, pvo.getReplyNo() );
			rs = stmt.executeQuery();
			
			if( rs.next() ) {
				vo = new ReplyVO();
				vo.setNo(rs.getInt("no"));
				vo.setReplyAuthor(rs.getString("replyAuthor"));
				vo.setReplyContent(rs.getString("replyContent"));
				vo.setReplyNo(rs.getInt("replyNo"));
				vo.setReplyTime(rs.getString("replyTime"));
				
			}
		}
		catch( Exception e ) {
			throw e; 
		}
		finally {
			if( rs != null ) rs.close();
			if( stmt != null ) stmt.close();
			if( conn != null ) conn.close();
		}
		return vo;
	}

	@Override
	public int delByPK(ReplyVO pvo) throws Exception {
		int uc = 0;
		Connection conn = null;
		Statement stmt = null;
		
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(
				"jdbc:mariadb://183.111.242.21:3306/pukyung21",
				"pukyung21","pukyung00!!1");
			stmt = conn.createStatement();
			String sql  = "DELETE FROM reply where replyNo = " + pvo.getReplyNo();
			uc = stmt.executeUpdate(sql);
					
		}
		catch(Exception e) {throw e;}
		finally {
			if( stmt != null ) stmt.close();
			if( conn != null ) conn.close();
		}
		return uc;
	}

}
