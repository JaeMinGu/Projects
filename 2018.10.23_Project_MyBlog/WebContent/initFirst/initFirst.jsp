<%@page import="kr.or.kosta.jsp.blog.dao.JdbcDaoFactory2"%>
<%@ page contentType="text/html; charset=utf-8" %>
<%!
public void jspInit(){
    getServletContext().setAttribute("factory", new JdbcDaoFactory2()); 
}
%>