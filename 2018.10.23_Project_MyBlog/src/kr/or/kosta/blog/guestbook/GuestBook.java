package kr.or.kosta.blog.guestbook;


public class GuestBook {
	
	
	private int guestBookId; 
	private String userId; 
	private String contents; 
	private String regdate; 
	
	public GuestBook() {
		super();
	}

	public GuestBook(int guestBookId, String userId, String contents, String regdate) {
		super();
		this.guestBookId = guestBookId;
		this.userId = userId;
		this.contents = contents;
		this.regdate = regdate;
	}

	public int getGuestBookId() {
		return guestBookId;
	}

	public void setGuestBookId(int guestBookId) {
		this.guestBookId = guestBookId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	@Override
	public String toString() {
		return "GuestBook [guestBookId=" + guestBookId + ", userId=" + userId + ", contents=" + contents + ", regdate="
				+ regdate + "]";
	}
	
	
}
