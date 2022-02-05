package banana;

import java.util.List;

public interface BoardDAO {
	public List<BoardVO> findAll() throws Exception;
	public BoardVO findByPK(BoardVO pvo) throws Exception;
	public int delByPK(BoardVO pvo) throws Exception; 
	public int add(BoardVO pvo) throws Exception; //글쓰기
	public int viewCount(BoardVO pvo) throws Exception; //클릭할때마다 조회수 증가
	//---검색기능---------
	public List<BoardVO> findByAuthor(BoardVO pvo) throws Exception; 
	public List<BoardVO> findByTitle(BoardVO pvo) throws Exception; 
	public List<BoardVO> findByTitlecontent(BoardVO pvo) throws Exception; 
	//---------------------
	
}
