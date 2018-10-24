<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="kr.or.kosta.blog.user.UserDao"%>
<%@ page import="kr.or.kosta.jsp.blog.dao.JdbcDaoFactory"%>
<%@ page import="kr.or.kosta.jsp.blog.dao.DaoFactory"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="user" class="kr.or.kosta.blog.user.User" scope="request"/>
<jsp:setProperty property="*" name="user"/>
<%
DaoFactory factory = (DaoFactory)application.getAttribute("factory");
UserDao dao = factory.getUserDao();
dao.create(user);
// 가입결과 jsp로 디스패치 
%>
<jsp:forward page="../user/regist_result.jsp" />
