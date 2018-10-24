package kr.or.kosta.blog.board;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.sql.DataSource;


public class JdbcBoardDao implements BoardDao{

	private DataSource dataSource;

	public DataSource getDataSource() {
		return dataSource;
	}

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	/** 게시판 불러오기*/
	@Override
	public void read(Board board) throws Exception {
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		
		try {

			String sql = "SELECT * \r\n" + 
					"FROM   board \r\n" + 
					"WHERE  board_id = ?";
			
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board.getBoardId());
			pstmt.executeQuery();
			
		} finally {
			try {
				if (pstmt != null) { pstmt.close(); }
				if (conn != null) { conn.close(); }
			} catch (Exception e) {
			}
		}
		
		
	}

	


}
