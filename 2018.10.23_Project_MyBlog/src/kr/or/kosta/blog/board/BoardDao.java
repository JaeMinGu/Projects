package kr.or.kosta.blog.board;

public interface BoardDao {
	
	/** 게시판 불러오기*/
	public void read(Board board) throws Exception; 
	
	
}
