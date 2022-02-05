package orange;

public class BoardAndReplyVO { //게시판과 댓글을 natural 조인한 테이블임
	//----게시글----
	private Integer no = null; //왜래키
	private String title = null; //게시물 제목
	private String content = null; // 게시물 내용
	private String author = null; //작성자
	private String ofn = null; // 파일 이름
	private String fsn = null;
	private Integer view = null; //조회수
	private String time = null; // 작성 시간
	private String category = null; //팀선택
	
	public Integer getNo() {
		return no;
	}
	public void setNo(Integer no) {
		this.no = no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getOfn() {
		return ofn;
	}
	public void setOfn(String ofn) {
		this.ofn = ofn;
	}
	public String getFsn() {
		return fsn;
	}
	public void setFsn(String fsn) {
		this.fsn = fsn;
	}
	public Integer getView() {
		return view;
	}
	public void setView(Integer view) {
		this.view = view;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
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
	//---댓글----
	private Integer replyNo = null;
	private String replyAuthor = null;
	private String replyContent = null;
	private String replyTime =null;
}
