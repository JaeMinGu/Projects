<%@page import="kr.or.kosta.blog.article.Article"%>
<%@page import="kr.or.kosta.blog.article.ArticleDao"%>
<%@page import="kr.or.kosta.jsp.blog.dao.DaoFactory"%>
<%@ page contentType="text/html; charset=utf-8" %>

<%request.setCharacterEncoding("utf-8");%>


<%
DaoFactory factory = (DaoFactory)application.getAttribute("factory");
ArticleDao dao = factory.getArticle();
dao.delete(request.getParameter("article_id"));

response.sendRedirect(application.getContextPath()+"/board/board.jsp");
%>