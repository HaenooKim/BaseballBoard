package orange;

import java.util.List;

public interface BoardDAO {
	public List<BoardDAO> findAll() throws Exception;
	public BoardVO findByPK(BoardVO pvo) throws Exception;
	public int delByPK(BoardVO pvo) throws Exception;
	public int add(BoardVO pvo) throws Exception;
	
}
