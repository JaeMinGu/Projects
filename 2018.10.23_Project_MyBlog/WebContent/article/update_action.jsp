<%@page import="kr.or.kosta.blog.article.ArticleDao"%>
<%@page import="kr.or.kosta.jsp.blog.dao.DaoFactory"%>
<%@ page contentType="text/html; charset=utf-8" %>

<%
	request.setCharacterEncoding("utf-8");
%>

<jsp:useBean id="article" class="kr.or.kosta.blog.article.Article" scope="request" />
<jsp:setProperty property="*" name="article"/>

<%
DaoFactory factory = (DaoFactory)application.getAttribute("factory");
ArticleDao dao = factory.getArticle();
dao.update(article);

response.sendRedirect(application.getContextPath()+"/article/update_result.jsp");
%>

