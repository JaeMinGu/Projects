package kr.or.kosta.blog.guestbook;

import java.util.List;

public interface GuestBookDao {
	
	/** 방명록 작성 후 등록하기*/
	public void create(GuestBook guestBook) throws Exception; 
	
	/** 방명록 전체리스트 보여주기 */
	public List<GuestBook> listAll() throws Exception;
}
