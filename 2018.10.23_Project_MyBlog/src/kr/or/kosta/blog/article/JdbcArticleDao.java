package kr.or.kosta.blog.article;

import java.net.InetAddress;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import kr.or.kosta.blog.common.Params;
import oracle.net.aso.a;

public class JdbcArticleDao implements ArticleDao{

	DataSource dataSource;

	public DataSource getDataSource() {
		return dataSource;
	}

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	/** 게시글 작성 후 등록하기 */
	@Override
	public void create(Article article) throws Exception {
		Connection conn = null; 
		PreparedStatement pstmt = null;
		try {
		
		String sql = "INSERT INTO article \r\n" + 
				"            (article_id, \r\n" + 
				"             board_id, \r\n" + 
				"             writer, \r\n" + 
				"             subject, \r\n" + 
				"             content, \r\n" + 
				"             ip, \r\n" + 
				"             passwd, \r\n" + 
				"             group_no, \r\n" + 
				"             level_no, \r\n" + 
				"             order_no) \r\n" + 
				"VALUES      (article_id_seq.NEXTVAL, \r\n" + 
				"             1, \r\n" + 
				"             ?, \r\n" + //1, writer, String
				"             ?, \r\n" + //2, subject, String
				"             ?, \r\n" + //3, content, String
				"             ?, \r\n" + //4, ip, String
				"             ?, \r\n" + //5, passwd, String
				"             article_id_seq.CURRVAL, \r\n" +  //groupNor
				"             0, \r\n" + //6, levelNo, int
				"             0) "; //7, orderNo, int
		
		conn = dataSource.getConnection(); 
		pstmt = conn.prepareStatement(sql);
		// ip 주소얻기 
		InetAddress local = InetAddress.getLocalHost();
		String ip = local.getHostAddress();

		pstmt.setString(1, article.getWriter());
		pstmt.setString(2, article.getSubject());
		pstmt.setString(3, article.getContent());
		pstmt.setString(4, ip);
		pstmt.setString(5, article.getPasswd());
		pstmt.executeUpdate();
			
		}finally {
			try {
				if (pstmt!=null) { pstmt.close(); }
				if (conn!=null) { conn.close(); }
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
	}
	
	/** 게시글 반환하기 */
	@Override
	public Article read(int articleId) throws Exception {
		//System.out.println("SQl에서 받는 게시글 번호: " + articleId);
		Article article = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "UPDATE article \r\n" + 
						 "SET    hitcount = hitcount + 1 \r\n" + 
						 "WHERE  article_id = ? ";
			
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, articleId);
			pstmt.executeQuery(); 
			
			
					sql ="SELECT article_id, \r\n" + 
						 "       subject, \r\n" + 
						 "       writer, \r\n" + 
						 "       passwd, \r\n" + 
						 "       TO_CHAR(regdate, 'YYYY-MM-DD HH24:MI:SS') regdate, \r\n" + 
						 "       regexp_substr(ip,trim(regexp_substr(ip , '[^.]+', 1,1)))||'.'||regexp_substr(ip,trim(regexp_substr(ip , '[^.]+', 1,2))) ip, \r\n" + 
						 "       hitcount, \r\n" + 
						 "       content, \r\n" + 
						 "       group_no, \r\n" + 
						 "       order_no, \r\n" + 
						 "       level_no \r\n" + 
						 "FROM   article \r\n" + 
						 "WHERE  board_id = 1 \r\n" + 
						 "       AND article_id = ?";
			
			try {
				if (pstmt!=null) { pstmt.close();}
				if (conn!=null) { conn.close();}
			} catch (Exception e) {}	
			
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(sql); 
			pstmt.setInt(1, articleId);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				article = new Article(); 

				article.setArticleId(rs.getInt("article_id"));
				article.setSubject(rs.getString("subject"));
				article.setWriter(rs.getString("writer"));
				article.setPasswd(rs.getString("passwd"));
				article.setRegdate(rs.getString("regdate"));
				article.setIp(rs.getString("ip"));
				article.setHitCount(rs.getInt("hitcount"));
				article.setContent(rs.getString("content"));
				article.setGroupNo(rs.getInt("group_no"));
				article.setOrderNo(rs.getInt("order_no"));
				article.setLevelNo(rs.getInt("level_no"));
			}
			
			
			
		} finally {
			try {
				if (rs!=null) { rs.close();}
				if (pstmt!=null) { pstmt.close();}
				if (conn!=null) { conn.close();}
			} catch (Exception e) {}
		}
		return article;
	}
	
	/** 게시글 수정하기 */
	@Override
	public void update(Article article) throws Exception {
		Connection conn = null; 
		PreparedStatement pstmt = null; 
			
			String sql = "UPDATE article \r\n" + 
						 "SET    subject = ?, \r\n" + 
						 "       content = ? \r\n" + 
					     "WHERE  article_id = ?";
			
		try {
			conn =  dataSource.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, article.getSubject());
			pstmt.setString(2, article.getContent());
			pstmt.setInt(3, article.getArticleId());
			
			pstmt.executeUpdate(); 
			
		} finally {
			try {
				if (pstmt != null) { pstmt.close();}
				if (conn != null) { conn.close();}
			} catch (Exception e) {	}
		}
		
		
		
		
	}

	/** 게시글 삭제하기 */
	@Override
	public void delete(String article_id) throws Exception {
		
		Connection conn = null;
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		try {
		String sql = "UPDATE article \r\n" + 
					 "SET    subject = '삭제된 게시글입니다' \r\n" + 
					 "WHERE  article_id = ? ";
		
		conn = dataSource.getConnection(); 
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, article_id);
		pstmt.executeUpdate();
		} finally {
			try {
				
				if (rs != null) {rs.close();}
				if (pstmt != null) {pstmt.close();}
				if (conn != null) {conn.close();}
			} catch (Exception e) {			}
		}
	}

	/** 게시글 전체리스트 보여주기*/
	@Override
	public List<Article> listAll() throws Exception {
		
		Article article = null; 
		Connection conn = null; 
		Statement stmt = null;
		ResultSet rs = null; 
		List<Article> list = null; 
		try {
			
			String sql = "SELECT article_id,\r\n" + 
					"       subject, \r\n" + 
					"       writer, \r\n" + 
					"       regdate, \r\n" + 
					"       regexp_substr(ip,trim(regexp_substr(ip , '[^.]+', 1,1)))||'.'||regexp_substr(ip,trim(regexp_substr(ip , '[^.]+', 1,2))) ip, \r\n" + 
					"       hitcount \r\n" + 
					/* "       group_no \r\n" + 
					 "       level_no \r\n" + 
					 "       order_no \r\n" + */
					 "FROM   article \r\n" + 
					 "WHERE  board_id = 1 \r\n" + 
					 "ORDER  BY group_no DESC, order_no ASC";
			
			conn = dataSource.getConnection(); 
			stmt = conn.createStatement(); 
			rs = stmt.executeQuery(sql);
			
			
			list = new ArrayList<>(); 
			while(rs.next()) {
				article = new Article(); 
				
				article.setArticleId(rs.getInt("article_id"));
				article.setSubject(rs.getString("subject"));
				article.setWriter(rs.getString("writer"));
				article.setRegdate(rs.getString("regdate"));
				article.setIp(rs.getString("ip"));
				article.setHitCount(rs.getInt("hitcount"));
				/*article.setGroupNo(rs.getInt("group_no"));
			article.setLevelNo(rs.getInt("level_no"));
			article.setOrderNo(rs.getInt("order_no"));*/
				//article.setBoardId(rs.getInt("board_id"));
				
				list.add(article);
			}
		} finally {
			try {
				if (rs != null) { rs.close();}
				if (stmt != null) { stmt.close();}
				if (conn != null) { conn.close();}
			} catch (Exception e) {
			}
			
		}
		
		return list; 
	}
	
	/** 리스트를 위한 게시글 반환하기 */
	public Article getArticles(ResultSet rs) throws Exception {
		Article article = new Article(); 
		
		article.setArticleId(rs.getInt("article_id"));
		article.setBoardId(rs.getInt("board_id"));
		article.setWriter(rs.getString("writer"));
		article.setSubject(rs.getString("subject"));
		article.setHitCount(rs.getInt("content"));
		//article.setRegdate(rs.getString("regdate"));
		//article.setHitCount(rs.getInt("hitcount"));
		article.setIp(rs.getString("ip"));
		article.setPasswd(rs.getString("passwd"));
		//article.setAttachFile(rs.getString("attach_file"));
		//article.setGroupNo(rs.getInt("group_no"));
		article.setLevelNo(rs.getInt("level_no"));
		article.setOrderNo(rs.getInt("order_no"));
		
		return article; 
	}
	
	/** orderNo 검색하기 */
	public String buildOrderNo(String groupNo, String levelNo, String orderNo) throws Exception {
	      int result = 99999;
	      int orderNoTemp = result;
	      for (int i = Integer.parseInt(levelNo); i >= 1; i--) {
	         orderNoTemp = searchOrderNo(groupNo, i, orderNo);
	         if(orderNoTemp > 0) {
	            result = orderNoTemp < result ? orderNoTemp : result;
	         }
	      }
	      if (result < 0 || result == 99999) {
	         result = searchMaxOrderNo(groupNo);
	      } else {
	         updateOrderNo(groupNo, String.valueOf(result));
	      }
	      return String.valueOf(result);
	   }
	
	/** orderNo 호출하기*/
	private int searchOrderNo(String groupNo, int levelNo, String orderNo) throws Exception {
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      String sql =  "SELECT Min(order_no) order_no \r\n" + 
    		  		"FROM   article \r\n" + 
    		  		"WHERE  group_no = ? \r\n" +
    		  		"       AND level_no = ? \r\n" + 
    		  		"       AND order_no > ?";
      int result = 99999;
      try {
         con = dataSource.getConnection();
         pstmt = con.prepareStatement(sql);
         pstmt.setString(1, groupNo);
         pstmt.setInt(2, levelNo);
         pstmt.setString(3, orderNo);
         rs = pstmt.executeQuery();
         if (rs.next()) {
            result = rs.getInt("order_no");
         }
      } finally {
         try {
            if (rs != null)
               rs.close();
            if (pstmt != null)
               pstmt.close();
            if (con != null)
               con.close();
         } catch (SQLException e) {
         }
      }
      return result;
   }
	
	/** orderNo 중에서 가장 높은 값 반환하기 */
	private int searchMaxOrderNo(String groupNo) throws Exception {
      Connection con = dataSource.getConnection();
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      String sql = 	"SELECT Max(order_no) + 1 order_no \r\n" + 
    		  		"FROM   article \r\n" + 
    		  		"WHERE  group_no = ?";
      
      int result = 0;
      try {
         pstmt = con.prepareStatement(sql);
         pstmt.setString(1, groupNo);
         rs = pstmt.executeQuery();
         if (rs.next()) {
            result = rs.getInt("order_no");
         }
      } finally {
         if (rs != null)
            rs.close();
         if (pstmt != null)
            pstmt.close();
         if (con != null)
            con.close();
      }
      return result;
   }
	
	/** orderNo 업데이트하기 */
	private void updateOrderNo(String groupNo, String orderNo) throws Exception {
      Connection con = null;
      PreparedStatement pstmt = null;
      String sql = 	"UPDATE article \r\n" + 
    		  		"SET    order_no = order_no + 1 \r\n" + 
    		  		"WHERE  board_id = 1 \r\n" + 
    		  		"       AND group_no = ? \r\n" + 
    		  		"       AND order_no >= ?";
      try {
         con = dataSource.getConnection();
         pstmt = con.prepareStatement(sql);
         pstmt.setString(1, groupNo);
         pstmt.setString(2, orderNo);
         pstmt.executeQuery();
      } finally {
         if (pstmt != null)
            pstmt.close();
         if (con != null)
            con.close();
      }
   }

	/** 댓글 등록하기 */
   @Override
   	public boolean reply(Article article) throws Exception {
	      Connection con =  null;
	      PreparedStatement pstmt = null;
	      String forderID = buildOrderNo(String.valueOf(article.getGroupNo()), String.valueOf(article.getOrderNo()), String.valueOf(article.getLevelNo()));
	      String sql = "INSERT INTO article \r\n" + 
	                  "            (article_id, \r\n" + 
	                  "             board_id, \r\n" + 
	                  "             writer, \r\n" + 
	                  "             subject, \r\n" + 
	                  "             content, \r\n" + 
	                  "             ip, \r\n" + 
	                  "             passwd, \r\n" + 
	                  "             group_no, \r\n" + 
	                  "             level_no, \r\n" + 
	                  "             order_no) \r\n" + 
	                  "VALUES     (article_id_seq.nextval, \r\n" + 
	                  "            1, \r\n" + 
	                  "            ?, \r\n" + 
	                  "            ?, \r\n" + 
	                  "            ?, \r\n" + 
	                  "            '192.168.0.5', \r\n" + 
	                  "            ?, \r\n" + 
	                  "            ?, \r\n" + 
	                  "            ?, \r\n" + 
	                  "            ?)";
	      try {
	         con = dataSource.getConnection();
	         pstmt = con.prepareStatement(sql);
	         pstmt.setString(1, article.getWriter());
	         pstmt.setString(2, article.getSubject());
	         pstmt.setString(3, article.getContent());
	         pstmt.setString(4, article.getPasswd());
	         pstmt.setString(5, String.valueOf(article.getGroupNo()));
	         pstmt.setString(6, String.valueOf(article.getLevelNo()+1));
	         if(forderID == null) {
//	            System.out.println("null??");
	            pstmt.setString(7, String.valueOf(article.getOrderNo()+1));
	         }else {
//	            System.out.println("부모");
	            pstmt.setString(7, forderID);
	         }
	         pstmt.executeUpdate();
	      }catch(Exception e){
	         System.out.println(e.getMessage());
//	         System.out.println("insert error");
	         return false;
	      }
	      finally {
	         try {
	            if(pstmt != null) pstmt.close();
	            if(con != null)   con.close();
	         }catch (Exception e) {}
	      }
	      return true;
	   }
	
	/** 페이징 정렬하기 */
	public List<Article> listByPage(int page, int listSize, String searchType, String searchValue) throws Exception {
		
		List<Article> list = null; 
		Connection conn = null; 
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		try {
			String sql = "SELECT article_id, \r\n" + 
					"       board_id, \r\n" + 
					"       writer, \r\n" + 
					"       subject, \r\n" + 
					"       content, \r\n" + 
					"       regdate, \r\n" + 
					"       hitcount, \r\n" + 
					"       ip, \r\n" + 
					"       passwd, \r\n" + 
					"       group_no, \r\n" + 
					"       level_no, \r\n" + 
					"       order_no \r\n" + 
					"FROM   (SELECT Ceil(ROWNUM / 5) request_page, \r\n" + 
					"               article_id, \r\n" + 
					"               board_id, \r\n" + 
					"               writer, \r\n" + 
					"               subject, \r\n" + 
					"               content, \r\n" + 
					"               regdate, \r\n" + 
					"               hitcount, \r\n" + 
					"               ip, \r\n" + 
					"               passwd, \r\n" + 
					"               group_no, \r\n" + 
					"               level_no, \r\n" + 
					"               order_no \r\n" + 
					"        FROM   (SELECT article_id, \r\n" + 
					"                       board_id, \r\n" + 
					"                       writer, \r\n" + 
					"                       subject, \r\n" + 
					"                       content, \r\n" + 
					"                       To_char(regdate, 'YYYY-MM-DD HH24:MI') regdate, \r\n" + 
					"                       hitcount, \r\n" + 
					"                       ip, \r\n" + 
					"                       passwd, \r\n" + 
					"                       group_no, \r\n" + 
					"                       level_no, \r\n" + 
					"                       order_no \r\n" + 
					"                FROM   article \r\n"; 
			if(searchType != null){
				switch (searchType) {
					case "subject":
						sql += "WHERE  subject like  ? ";
						searchValue = "%" + searchValue + "%";
						break;
					case "content":
						sql += "WHERE  content like  ? ";
						searchValue = "%" + searchValue + "%";
						break;
					case "writer":
						sql += "WHERE  writer = ? ";
						break;
				}
			}
			sql += "                ORDER  BY group_no DESC, \r\n" +
					"                		   order_no ASC)) \r\n" +
			       "WHERE  request_page = ?";
			
			
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			list = new ArrayList<>(); 
			if(searchType != null){
				pstmt.setString(1, searchValue);
				pstmt.setInt(2, page);
			}else {
				pstmt.setInt(1, page);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Article article = new Article(); 
				article.setArticleId(rs.getInt("article_id"));
				article.setSubject(rs.getString("subject"));
				article.setWriter(rs.getString("writer"));
				article.setRegdate(rs.getString("regdate"));
				article.setIp(rs.getString("ip"));
				article.setHitCount(rs.getInt("hitcount"));
				list.add(article);
			}
			
		} finally {
			try {
				if (rs != null) { rs.close();}
				if (pstmt != null) { pstmt.close();}
				if (conn != null) { conn.close();}
			} catch (Exception e) { }
		}
		
		return list;
	}
	
	/** 페이징 정렬하기 */
	@Override
	public List<Article> listByPage(Params param) throws Exception {
		//int page, int listSize, String searchType, String searchValue
		return listByPage(param.getPage(), param.getListSize(), param.getSearchType(), param.getSearchValue());
	}
	
	/** 카운트 값 반환하기 */
	public int countBySearch(String searchType, String searchValue) throws Exception {
		int count = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql ="SELECT COUNT(article_id) count\r\n" + 
					"FROM   article\r\n";
		
		// 검색 유형별 WHERE 절 동적 추가
		if(searchType != null){
			switch (searchType) {
				case "subject":
					sql += "WHERE  subject like  ? ";
					searchValue = "%" + searchValue + "%";
					break;
				case "content":
					sql += "WHERE  content like  ? ";
					searchValue = "%" + searchValue + "%";
					break;
				case "writer":
					sql += "WHERE  writer = ? ";
					break;
			}
		}
		
		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(sql);
			
			// 전체검색이 아닌경우 경우
			if(searchType != null){
				pstmt.setString(1, searchValue);
			}

			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt("count");
			}
		} finally {
			try {
				if(rs != null)    rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null)   con.close();
			}catch (Exception e) {}
		}
		return count;
	}
	
	/** 카운트 값 반환하기 */
	@Override
	public int countBySearch(Params params) throws Exception {
		return countBySearch(params.getSearchType(), params.getSearchValue());
	}
	
	
}
