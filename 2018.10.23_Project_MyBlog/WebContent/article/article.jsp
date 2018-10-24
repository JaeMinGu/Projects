<%@page import="java.util.List"%>
<%@page import="java.util.Enumeration"%>
<%@page import="kr.or.kosta.blog.article.Article"%>
<%@page import="kr.or.kosta.blog.article.ArticleDao"%>
<%@page import="kr.or.kosta.jsp.blog.dao.DaoFactory"%>
<%@ page contentType="text/html; charset=utf-8" %>
<%
	request.setCharacterEncoding("utf-8"); 
    
    int articleId = Integer.parseInt(request.getParameter("articleId"));
    //System.out.println("게시글 번호: "+articleId);
    
    DaoFactory factory= (DaoFactory)application.getAttribute("factory");    
    ArticleDao dao= factory.getArticle();
    Article article = dao.read(articleId);
    
    //System.out.println(":"+article.getArticleId());
    //System.out.println(":"+article.getWriter());
    
   	String id = null;
	Cookie[] cookies = request.getCookies();
	if (cookies != null) {//로그인o
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals("loginId")) {
				id = cookie.getValue();
			}
		}
	} else {//로그인x
       
	}
%>
<%-- <%@ include file="../jspf/isLogIn.jsp" %> --%>

<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<title>★ JaeMin's Blog ★</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="<%=application.getContextPath()%>/css/basic.css">
<body class="w3-light-grey w3-content" style="max-width:1600px">

<%-- 사이드 바 메뉴 시작 --%>
<jsp:include page="/include/sideBar.jsp" />
<%-- 사이드 바 메뉴 종료 --%>


<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:300px">

  <!-- Header -->
  <header id="portfolio">
    <div class="w3-container" >
    <%-- 탑 헤드 시작 --%>
  <jsp:include page="/include/top.jsp"></jsp:include>
    <%-- 탑 헤드 종료 --%>
        
    <div class="w3-section w3-bottombar w3-padding-16">
    </div>
    </div>
  </header>
  
<div style="margin:10px 100px; ">

<h1 class="headline"><b>게시글 상세</b></h1>
<div class="outline">
      
      
      <div class="dottedOutline">
          <div>
              <label class="createPostButton">글제목</label>
              <input type="text" class="grayBox" value="<%=article.getSubject()%>" readonly>
          </div>
          <div>
              <label class="createPostButton">작성자</label> 
              <input type="text" class="grayBox"  value="<%=article.getWriter()%>"  readonly>
          <div class="right">
              <label class="createPostButton">작성일</label> 
              <input type="text" class="grayBox"  value="<%=article.getRegdate()%>" readonly></div>
          </div>
          <div>
              <label class="createPostButton">아이피</label> 
              <input type="text" class="grayBox"  value="<%=article.getIp()%>"  readonly>
          <div class="right">
              <label class="createPostButton">조회수</label> 
              <input type="text" class="grayBox"  value="<%=article.getHitCount()%>" readonly>
          </div>
          </div>
          <%--<input type="text" class="createPostBox"  value="<%=article.getContent()%>"  readonly> --%> 
          <textarea rows="10" class="createPostBox" readonly style="resize: none" wrap="hard"> <%=article.getContent()%></textarea>
      </div>
      
      <div style="text-align:right">
          <input type="submit" class="newButton" value='글목록' style="margin-top:20px; display:inline-block;" onclick="location.href='<%=application.getContextPath()%>/board/board.jsp'">      
          <input type="submit" class="newButton" value='답글쓰기' style="margin-top:20px; display:inline-block;" onclick="location.href='<%=application.getContextPath() %>/article/reply_article.jsp?articleId=<%=article.getArticleId()%>'">      
          <input type="submit" class="newButton" value='글수정' style="margin-top:20px; display:inline-block;" onclick="location.href='<%=application.getContextPath() %>/article/update_article.jsp?articleId=<%=article.getArticleId()%>'">      
      </div>

     
</div> 
  

<!-- End page content -->
</div>

</div>

</body>
</html>
