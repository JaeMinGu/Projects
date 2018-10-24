package kr.or.kosta.blog.guestbook;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

public class JdbcGuestBookDao implements GuestBookDao{

	private DataSource dataSource; 
	
	public DataSource getDataSource() {
		return dataSource;
	}

	public void setDataSource(DataSource datasource) {
		this.dataSource = datasource;
	}
	
	/** 방명록 작성 후 등록하기 */
	@Override
	public void create(GuestBook guestBook) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null; 
		
		try {
			String sql = "INSERT INTO guestbook \r\n" + 
					"            (guestbook_id, \r\n" + 
					"             user_id, \r\n" + 
					"             contents) \r\n" + 
					"VALUES      (guestbook_seq.NEXTVAL, \r\n" + 
					"             ?, \r\n" + 
					"             ?) ";
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, guestBook.getUserId());
			pstmt.setString(2, guestBook.getContents());
			pstmt.executeQuery();
		} finally {
			try {
				if (pstmt != null) {pstmt.close();}
				if (conn != null) {conn.close();}
			} catch (Exception e) {
			
			}
		}
	}
	
	/** 방명록 전체리스트 보여주기 */
	@Override
	public List<GuestBook> listAll() throws Exception {
		List<GuestBook> list = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		
		
		try {
			String sql = "SELECT   guestbook_id, \r\n" + 
					"         user_id, \r\n" + 
					"         CONTENTS, \r\n" + 
					"         To_char(regdate, 'YYYY/MM/DD HH24:MI DAY') regdate \r\n" + 
					"FROM     guestbook \r\n" + 
					"ORDER BY guestbook_id DESC";
			
			
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs= pstmt.executeQuery();
			
			list = new ArrayList<>();
			while(rs.next()) {
				GuestBook guestBook = getGuestBook(rs);
				list.add(guestBook);
			}
			
		} finally {
			try {
				if (rs != null) { rs.close(); }
				if (pstmt != null) { pstmt.close(); }
				if (conn != null) { conn.close(); }
			} catch (Exception e) {			}
		}
		return list;
	}
	
	/** 방명록 반환하기 */
	public GuestBook getGuestBook(ResultSet rs) throws Exception{
		
		GuestBook guestBook = new GuestBook();
		
		guestBook.setGuestBookId(rs.getInt("guestbook_id"));
		guestBook.setUserId(rs.getString("user_id"));
		guestBook.setContents(rs.getString("CONTENTS"));
		guestBook.setRegdate(rs.getString("regdate"));
		
		return guestBook; 
	}

}
