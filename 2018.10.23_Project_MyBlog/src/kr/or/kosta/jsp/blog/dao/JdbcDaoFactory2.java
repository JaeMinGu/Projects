package kr.or.kosta.jsp.blog.dao;

import java.lang.reflect.Method;
import java.util.Hashtable;
import java.util.List;

import javax.sql.DataSource;

import kr.or.kosta.blog.article.ArticleDao;
import kr.or.kosta.blog.board.BoardDao;
import kr.or.kosta.blog.guestbook.GuestBookDao;
import kr.or.kosta.blog.user.User;
import kr.or.kosta.blog.user.UserDao;

public class JdbcDaoFactory2 extends DaoFactory {
	
	private Hashtable<String, Object> daos;
	
	private String[] daoNames = {"kr.or.kosta.blog.article.JdbcArticleDao", 
								 "kr.or.kosta.blog.board.JdbcBoardDao", 
								 "kr.or.kosta.blog.guestbook.JdbcGuestBookDao", 
								 "kr.or.kosta.blog.user.JdbcUserDao"};
	
	public JdbcDaoFactory2() {
		daos = new Hashtable<String, Object>();
		
		for (String className : daoNames) {
			try {
				Object dao = Class.forName(className).newInstance();
				addDataSource(dao);
				daos.put(className, dao);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	
	private void addDataSource(Object dao) {
		Class cls = dao.getClass();
		// 동적 메소드호출
		Method method;
		try {
			method = cls.getMethod("setDataSource", DataSource.class);
			method.invoke(dao, getDataSource());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
//	public BarDao getBarDao() {...};
//	public FooDao getFooDao() {...};
	
	public static void main(String[] args) throws Exception {
		DaoFactory factory = new JdbcDaoFactory2();
		UserDao dao = factory.getUserDao();
		List<User> list = dao.listAll();
		for (User user : list) {
			System.out.println(user.toString());
		}
		
	}

	@Override
	public UserDao getUserDao() {
		return (UserDao)daos.get("kr.or.kosta.blog.user.JdbcUserDao");
	}

	@Override
	public GuestBookDao getGuestBookDao() {
		return (GuestBookDao)daos.get("kr.or.kosta.blog.guestbook.JdbcGuestBookDao");
	}

	@Override
	public BoardDao getBoardDao() {
		return (BoardDao)daos.get("kr.or.kosta.blog.board.JdbcBoardDao");
	}

	@Override
	public ArticleDao getArticle() {
		return (ArticleDao)daos.get("kr.or.kosta.blog.article.JdbcArticleDao");
	}

}
