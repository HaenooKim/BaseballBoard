package orange;


public interface ReplyDAO {
	public int writeReply(ReplyVO pvo) throws Exception; //±Û¾²±â
	public ReplyVO findByPK( ReplyVO pvo ) throws Exception;
	public int delByPK(ReplyVO pvo) throws Exception; 
}
