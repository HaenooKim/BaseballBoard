package banana;

import java.util.List;

import orange.BoardAndReplyVO;

public interface BoardDAO {
	public List<BoardAndReplyVO> findAll() throws Exception;
	public List<BoardAndReplyVO> findAll(int pageCount) throws Exception;
	
	public List<BoardAndReplyVO> findByPK(BoardAndReplyVO pvo) throws Exception;
	public BoardVO findByPK2( BoardVO pvo ) throws Exception;
	public int delByPK(BoardVO pvo) throws Exception; 
	public int add(BoardVO pvo) throws Exception; //글쓰기
	public int viewCount(BoardAndReplyVO pvo) throws Exception; //클릭할때마다 조회수 증가
	public int update(BoardVO pvo) throws Exception;
	//---검색기능---------
	public  List<BoardAndReplyVO> findByAuthor(BoardVO pvo, int currentPage) throws Exception; 
	public List<BoardAndReplyVO> findByTitle(BoardVO pvo, int currentPage) throws Exception; 
	public List<BoardAndReplyVO> findByTitlecontent(BoardVO pvo, int currentPage) throws Exception; 
	public List<BoardAndReplyVO> findByCategory(BoardVO pvo, int currentPage) throws Exception; 
	//----갯수 출력 기능 count(*)-----------------
	public int getTotalRows() throws Exception;
	public int getTotalRows(String search, String target) throws Exception;
	public int getRelpyCount(int boardNo) throws Exception;
}