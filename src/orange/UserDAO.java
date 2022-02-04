package orange;

import java.util.List;

public interface UserDAO {
	public List<UserVO> findAll() throws Exception;
	public UserVO findByPK(UserVO pvo) throws Exception;
	public int delByPK(UserVO pvo) throws Exception;
	public int add(UserVO pvo) throws Exception;

}
