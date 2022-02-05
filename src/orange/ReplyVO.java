package orange;

public class ReplyVO {
	private Integer no = null; //¿Ö·¡Å°
	public Integer getNo() {
		return no;
	}
	public void setNo(Integer no) {
		this.no = no;
	}
	public Integer getReplyNo() {
		return replyNo;
	}
	public void setReplyNo(Integer replyNo) {
		this.replyNo = replyNo;
	}
	public String getReplyAuthor() {
		return replyAuthor;
	}
	public void setReplyAuthor(String replyAuthor) {
		this.replyAuthor = replyAuthor;
	}
	public String getReplyContent() {
		return replyContent;
	}
	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}
	public String getReplyTime() {
		return replyTime;
	}
	public void setReplyTime(String replyTime) {
		this.replyTime = replyTime;
	}
	private Integer replyNo = null;
	private String replyAuthor = null;
	private String replyContent = null;
	private String replyTime =null;
}
