<%@page import="kr.or.kosta.blog.user.User"%>
<%@page import="kr.or.kosta.blog.user.UserDao"%>
<%@page import="kr.or.kosta.jsp.blog.dao.JdbcDaoFactory"%>
<%@page import="kr.or.kosta.jsp.blog.dao.DaoFactory"%>
<%@ page contentType="text/html; charset=utf-8" %>


<%if(application.getAttribute("factory") != null){
	application.setAttribute("factory", new JdbcDaoFactory());
}%>

<%
String id = request.getParameter("userid");
String pw = request.getParameter("passwd");

if(id != null){//로그인 
  session.setAttribute("id", id); 
} else{// 로그아웃 
 session.invalidate();
}


// UserDao를 이용한 회원가입 여부 체크 
DaoFactory factory = new JdbcDaoFactory();
UserDao dao = factory.getUserDao();
User user = dao.certify(id, pw);
if(user != null){
  //회원인 경우 
  response.sendRedirect(application.getContextPath() + "/index.jsp");
}else{
  // 회원이 아닌 경우 
%>
<script>
alert("아이디와 비밀번호를 확인해주세요");
history.back();
</script>

<%  
}
%> 


