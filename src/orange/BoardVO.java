package orange;

public class BoardVO {
	private Integer no = null; // �Խù� ��ȣ
	private String title = null; //�Խù� ����
	private String content = null; // �Խù� ����
	private String author = null; //�ۼ���
	private String ofn = null; // ���� �̸�
	private String fsn = null;
	private Integer view = null; //��ȸ��
	private String time = null; // �ۼ� �ð�
	
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
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
}
