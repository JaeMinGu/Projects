<%@page import="kr.or.kosta.blog.user.User"%>
<%@page import="kr.or.kosta.blog.user.UserDao"%>
<%@page import="kr.or.kosta.jsp.blog.dao.JdbcDaoFactory"%>
<%@page import="kr.or.kosta.jsp.blog.dao.DaoFactory"%>
<%@ page contentType="text/html; charset=utf-8"%>

<%
	request.setCharacterEncoding("utf-8");

	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
  
	
	Cookie[] cookies = request.getCookies();
	if (id != null) {//로그인 시도 
		// UserDao를 이용한 회원가입 여부 체크 
		DaoFactory factory = (DaoFactory) application.getAttribute("factory");
		UserDao dao = factory.getUserDao();
		User user = dao.certify(id, pw);

		if (user != null) {//회원인 경우 

			Cookie cookie = new Cookie("loginId", id);
			cookie.setMaxAge(60 * 60 * 24 * 30);
			cookie.setPath("/");
			response.addCookie(cookie);

      
			if (request.getParameter("saveId") != null) { //아이디 저장 체크 o 
				Cookie cookie2 = new Cookie("saveId", id);
				cookie2.setPath("/");
				response.addCookie(cookie2);
			} else{
				for (int i = 0; i < cookies.length; i++) {
					if (cookies[i].getName().equals("saveId")) {
						cookies[i].setPath("/");
						cookies[i].setMaxAge(0);
						response.addCookie(cookies[i]);
					}
				}
            }
      
			response.sendRedirect(request.getHeader("referer"));
      

		} else {// 회원이 아닌 경우 

			response.sendRedirect(request.getHeader("referer") + "?isLogin=false");
		}
	} else { //로그아웃 

		
		for (int i = 0; i < cookies.length; i++) {
			if (cookies[i].getName().equals("loginId")) {
				cookies[i].setPath("/");
				cookies[i].setMaxAge(0);
				response.addCookie(cookies[i]);
			}
		}
		response.sendRedirect(request.getHeader("referer"));
	}
%>


