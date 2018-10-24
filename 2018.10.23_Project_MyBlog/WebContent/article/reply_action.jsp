<%@page import="kr.or.kosta.blog.article.ArticleDao"%>
<%@page import="kr.or.kosta.jsp.blog.dao.DaoFactory"%>
<%@ page contentType="text/html; charset=utf-8" %>

<%
	request.setCharacterEncoding("utf-8");
%>

<jsp:useBean id="reply" class="kr.or.kosta.blog.article.Article" scope="request"/>
<jsp:setProperty property="*" name="reply"/>

<%
DaoFactory factory = (DaoFactory)application.getAttribute("factory");
ArticleDao dao = factory.getArticle();

if(dao.reply(reply)){
  System.out.println("댓글 성공");  
}else{
  System.out.println("댓글 실패");  
}

System.out.println("groupNo : "+reply.getGroupNo());

response.sendRedirect(application.getContextPath()+ "/board/board.jsp");
%>

