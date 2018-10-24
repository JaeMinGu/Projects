package kr.or.kosta.jsp.blog.dao;

import java.lang.reflect.Method;

import javax.sql.DataSource;

import kr.or.kosta.blog.article.ArticleDao;
import kr.or.kosta.blog.article.JdbcArticleDao;
import kr.or.kosta.blog.board.BoardDao;
import kr.or.kosta.blog.board.JdbcBoardDao;
import kr.or.kosta.blog.guestbook.GuestBookDao;
import kr.or.kosta.blog.guestbook.JdbcGuestBookDao;
import kr.or.kosta.blog.user.JdbcUserDao;
import kr.or.kosta.blog.user.UserDao;

public class JdbcDaoFactory extends DaoFactory {

	@Override
	public UserDao getUserDao() {
		UserDao dao = new JdbcUserDao();
		Class cls = dao.getClass();
		
		// 동적 메소드호출
		Method method;
		try {
			method = cls.getMethod("setDataSource", DataSource.class);
			//method.invoke(dao, createDataSource());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dao;
	}

	@Override
	public GuestBookDao getGuestBookDao() {
		
		GuestBookDao dao = new JdbcGuestBookDao(); 
		Class cls = dao.getClass();
		
		Method method; 
		
		try {
			method = cls.getMethod("setDataSource", DataSource.class);
			//method.invoke(dao, createDataSource());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dao; 
	}

	@Override
	public BoardDao getBoardDao() {
		
		BoardDao dao = new JdbcBoardDao(); 
		Class cls = dao.getClass(); 
		
		Method method; 
		
		try {
			method = cls.getMethod("setDataSource", DataSource.class);
			//method.invoke(dao, createDataSource());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dao; 
	}

	@Override
	public ArticleDao getArticle() {
		ArticleDao dao = new JdbcArticleDao();
		Class cls = dao.getClass(); 
		
		Method method; 
		
		try {
			method = cls.getMethod("setDataSource", DataSource.class);
			//method.invoke(dao, createDataSource());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dao; 
	}
	
	
	
	
	
//	public BarDao getBarDao() {...};
//	public FooDao getFooDao() {...};

}
