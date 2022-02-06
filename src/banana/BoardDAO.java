package banana;

import java.util.List;

import orange.BoardAndReplyVO;

public interface BoardDAO {
	public List<BoardAndReplyVO> findAll() throws Exception;
	public List<BoardAndReplyVO> findByPK(BoardAndReplyVO pvo) throws Exception;
	public int delByPK(BoardVO pvo) throws Exception; 
	public int add(BoardVO pvo) throws Exception; //글쓰기
	public int viewCount(BoardAndReplyVO pvo) throws Exception; //클릭할때마다 조회수 증가
	//---검색기능---------
	public List<BoardVO> findByAuthor(BoardVO pvo) throws Exception; 
	public List<BoardVO> findByTitle(BoardVO pvo) throws Exception; 
	public List<BoardVO> findByTitlecontent(BoardVO pvo) throws Exception; 
	//---------------------
	
}
