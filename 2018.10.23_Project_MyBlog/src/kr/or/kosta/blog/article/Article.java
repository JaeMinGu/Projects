package kr.or.kosta.blog.article;

public class Article {
	
	private int articleId;
	private int boardId; 
	private String writer; 
	private String subject; //게시글 제목  
	private String content; 
	private String regdate; 
	private int hitCount; 
	private String ip; 
	private String passwd; 
	private String attachFile; 
	private int groupNo; //게시글 식별번호 
	private int levelNo; //그룹내 게시글 레벨
	private int orderNo; //그룹내 게시글 순서
	
	public Article() {
		super();
	}

	public Article(int articleId, int boardId, String writer, String subject, String content, String regdate,
			int hitCount, String ip, String passwd, String attachFile, int groupNo, int levelNo, int orderNo) {
		super();
		this.articleId = articleId;
		this.boardId = boardId;
		this.writer = writer;
		this.subject = subject;
		this.content = content;
		this.regdate = regdate;
		this.hitCount = hitCount;
		this.ip = ip;
		this.passwd = passwd;
		this.attachFile = attachFile;
		this.groupNo = groupNo;
		this.levelNo = levelNo;
		this.orderNo = orderNo;
	}

	public int getArticleId() {
		return articleId;
	}

	public void setArticleId(int articleId) {
		this.articleId = articleId;
	}

	public int getBoardId() {
		return boardId;
	}

	public void setBoardId(int boardId) {
		this.boardId = boardId;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public int getHitCount() {
		return hitCount;
	}

	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public String getAttachFile() {
		return attachFile;
	}

	public void setAttachFile(String attachFile) {
		this.attachFile = attachFile;
	}

	public int getGroupNo() {
		return groupNo;
	}

	public void setGroupNo(int groupNo) {
		this.groupNo = groupNo;
	}

	public int getLevelNo() {
		return levelNo;
	}

	public void setLevelNo(int levelNo) {
		this.levelNo = levelNo;
	}

	public int getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}

	@Override
	public String toString() {
		return "Article [articleId=" + articleId + ", boardId=" + boardId + ", writer=" + writer + ", subject="
				+ subject + ", content=" + content + ", regdate=" + regdate + ", hitCount=" + hitCount + ", ip=" + ip
				+ ", passwd=" + passwd + ", attachFile=" + attachFile + ", groupNo=" + groupNo + ", levelNo=" + levelNo
				+ ", orderNo=" + orderNo + "]";
	}

	
	
	
}
