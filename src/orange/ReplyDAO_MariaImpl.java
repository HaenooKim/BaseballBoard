package orange;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

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

}
