package banana;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import orange.BoardAndReplyVO;

public class BoardDAO_MariaImpl implements BoardDAO{
	
	@Override
	public List<BoardAndReplyVO> findAll() throws Exception {
		List<BoardAndReplyVO> ls = new ArrayList<BoardAndReplyVO>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(
				"jdbc:mariadb://183.111.242.21:3306/pukyung21",
				"pukyung21","pukyung00!!1");
			stmt = conn.createStatement();
			//rs = stmt.executeQuery("select * from board natural join reply ");
			rs = stmt.executeQuery("select * from board order by no desc");
			
			
			while(rs.next()) {
				BoardAndReplyVO vo = new BoardAndReplyVO();
				
				vo.setNo(rs.getInt("no"));
				vo.setCategory(rs.getString("category"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setAuthor(rs.getString("author"));
				vo.setView(rs.getInt("view"));
				vo.setTime(rs.getString("time"));
				
				/*
				vo.setNo(rs.getInt("no"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setAuthor(rs.getString("author"));
				vo.setOfn(rs.getString("ofn"));
				vo.setFsn(rs.getString("fsn"));
				vo.setView(rs.getInt("view"));
				vo.setTime(rs.getString("time"));
				vo.setCategory(rs.getString("category"));
				
				vo.setReplyAuthor(rs.getString("replyAuthor"));
				vo.setReplyContent(rs.getString("replyContent"));
				vo.setReplyNo(rs.getInt("replyNo"));
				vo.setReplyTime(rs.getString("replyTime"));
				*/
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

	
	/*
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
				vo.setCategory(rs.getString("category"));
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
	*/
	
	@Override
	public List<BoardAndReplyVO> findByPK(BoardAndReplyVO pvo) throws Exception {
		List<BoardAndReplyVO> ls = new ArrayList<BoardAndReplyVO>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(
				"jdbc:mariadb://183.111.242.21:3306/pukyung21",
				"pukyung21","pukyung00!!1");
			stmt = conn.prepareStatement("select * from board left join reply on board.no=reply.no where board.no=?");
			stmt.setInt( 1, pvo.getNo() );
			rs = stmt.executeQuery();
			
			while( rs.next() ) {
				BoardAndReplyVO vo = new BoardAndReplyVO();
				//---°Ô½Ã±Û----
				vo.setNo(rs.getInt("no"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setAuthor(rs.getString("author"));
				vo.setOfn(rs.getString("ofn"));
				vo.setFsn(rs.getString("fsn"));
				vo.setView(rs.getInt("view"));
				vo.setTime(rs.getString("time"));
				vo.setCategory(rs.getString("category"));
				//----´ñ±Û-----
				vo.setReplyAuthor(rs.getString("replyAuthor"));
				vo.setReplyContent(rs.getString("replyContent"));
				vo.setReplyNo(rs.getInt("replyNo"));
				vo.setReplyTime(rs.getString("replyTime"));
				ls.add(vo);
				
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
		return ls;
	}

	@Override
	public int delByPK(BoardVO pvo) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int add(BoardVO pvo) throws Exception {
		int uc = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(
				"jdbc:mariadb://183.111.242.21:3306/pukyung21",
				"pukyung21","pukyung00!!1");
			String sql = "INSERT INTO board VALUES (default,?,?,?,?,?,?,NOW(),?)";
			stmt = conn.prepareStatement( sql );

			stmt.setString(1, pvo.getTitle() );
			stmt.setString(2, pvo.getContent() );
			stmt.setString(3, pvo.getAuthor() );
			stmt.setString(4, pvo.getOfn() );
			stmt.setString(5,  pvo.getFsn());
			stmt.setInt(6, 0);
			stmt.setString(7, pvo.getCategory());

			uc = stmt.executeUpdate();
		}
		catch( Exception e ) { throw e; }
		finally {
			if( stmt != null ) stmt.close();
			if( conn != null ) conn.close();
		}
		return uc;
	}

	@Override
	public int viewCount(BoardAndReplyVO pvo) throws Exception {
		int uc = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(
				"jdbc:mariadb://183.111.242.21:3306/pukyung21",
				"pukyung21","pukyung00!!1");
			String sql = "update board set view = view + 1 where no = ?";
			stmt = conn.prepareStatement( sql );

			stmt.setInt(1, pvo.getNo() );
			

			uc = stmt.executeUpdate();
		}
		catch( Exception e ) { throw e; }
		finally {
			if( stmt != null ) stmt.close();
			if( conn != null ) conn.close();
		}
		return uc;
	}

	@Override
	public List<BoardVO> findByAuthor(BoardVO pvo) throws Exception {
		List <BoardVO> ls =new ArrayList<BoardVO>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(
				"jdbc:mariadb://183.111.242.21:3306/pukyung21",
				"pukyung21","pukyung00!!1");
			stmt = conn.prepareStatement("SELECT * FROM board WHERE author = ? ORDER BY no DESC");
			stmt.setString( 1, pvo.getAuthor() );
			rs = stmt.executeQuery();
			
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
				vo.setCategory(rs.getString("category"));
				ls.add( vo );
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
		return ls;
	}

	@Override
	public List<BoardVO> findByTitle(BoardVO pvo) throws Exception {
		List <BoardVO> ls =new ArrayList<BoardVO>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(
				"jdbc:mariadb://183.111.242.21:3306/pukyung21",
				"pukyung21","pukyung00!!1");
			stmt = conn.prepareStatement("SELECT * FROM board WHERE title = ? ORDER BY no DESC");
			stmt.setString( 1, pvo.getTitle() );
			rs = stmt.executeQuery();
			
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
				vo.setCategory(rs.getString("category"));
				ls.add( vo );
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
		return ls;
	}

	@Override
	public List<BoardVO> findByTitlecontent(BoardVO pvo) throws Exception {
		List <BoardVO> ls =new ArrayList<BoardVO>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(
				"jdbc:mariadb://183.111.242.21:3306/pukyung21",
				"pukyung21","pukyung00!!1");
			stmt = conn.prepareStatement("select * from board where title=? or content=? ORDER BY no DESC");
			stmt.setString( 1, pvo.getTitle() );
			stmt.setString( 2, pvo.getContent() );
			rs = stmt.executeQuery();
			
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
				vo.setCategory(rs.getString("category"));
				ls.add( vo );
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
		return ls;
	}
}
