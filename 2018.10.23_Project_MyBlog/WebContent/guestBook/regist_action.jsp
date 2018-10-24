
<%@page import="kr.or.kosta.blog.guestbook.GuestBookDao"%>
<%@page import="kr.or.kosta.jsp.blog.dao.DaoFactory"%>
<%@ page contentType="text/html; charset=utf-8" %>

<%
	request.setCharacterEncoding("utf-8");
%>

<jsp:useBean id="guestBook" class="kr.or.kosta.blog.guestbook.GuestBook" scope="request"/>
<jsp:setProperty property="*" name="guestBook"/>

<%
DaoFactory factory = (DaoFactory)application.getAttribute("factory");
GuestBookDao dao = factory.getGuestBookDao(); 
dao.create(guestBook);
response.sendRedirect("../guestBook/guestBook.jsp");
%>
