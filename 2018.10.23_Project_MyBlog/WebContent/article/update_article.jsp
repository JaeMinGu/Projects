<%@page import="kr.or.kosta.blog.article.Article"%>
<%@page import="kr.or.kosta.blog.article.ArticleDao"%>
<%@page import="kr.or.kosta.blog.board.BoardDao"%>
<%@page import="kr.or.kosta.blog.user.UserDao"%>
<%@page import="kr.or.kosta.jsp.blog.dao.DaoFactory"%>
<%@ page contentType="text/html; charset=utf-8" %>

<%
    request.setCharacterEncoding("utf-8");    

    int articleId = Integer.parseInt(request.getParameter("articleId"));
    
    DaoFactory factory= (DaoFactory)application.getAttribute("factory");    
    ArticleDao dao= factory.getArticle();
    Article article = dao.read(articleId); 
    System.out.println(article.getArticleId());
    System.out.println(article.getPasswd());
   
    
    
    String id = null;
	Cookie[] cookies = request.getCookies();
	if (cookies != null) {
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals("loginId")) {
				id = cookie.getValue();
				break;
			}
		}
	}
%>




<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<title>★ JaeMin's Blog ★</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="<%=application.getContextPath()%>/css/basic.css">
<script type="text/javascript">

function passwdCheck() {
	var cpasswd = document.getElementById("passwd").value; 
	
	var passwd = <%= article.getPasswd() %>
	
	if(passwd != cpasswd){
		document.getElementById("checkPasswd").innerHTML = '비밀번호를 확인해주세요';
		return false;
	}
}

function deleteArticle() {
	var cpasswd = document.getElementById("passwd").value; 
	var passwd = <%= article.getPasswd() %>
	
	if(passwd!= cpasswd){
		document.getElementById("checkPasswd").innerHTML = '비밀번호가 일치하지 않습니다';
		return false;
	}else{
		window.location.href = '../article/delete_action.jsp?article_id='+<%=article.getArticleId()%>;
	}
	
}

</script>
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

<h1 class="headline"><b>게시글 수정</b></h1>
      
<div class="outline">
   <%
    if(id != null){//로그인 
   %>
<form action="<%=application.getContextPath() %>/article/update_action.jsp" onsubmit="return passwdCheck()"  >
   <div class="dottedOutline">
   
        <div class="caution">
             <label>※ 비밀번호는 글 수정, 삭제시 필요합니다.</label>
        </div>
           
        <div>
             <input type="hidden" value="<%=articleId%>" name="articleId" id="articleId">
             <label class="createPostButton">글제목</label> 
             <input type="text" class="grayBox" required id="subject" name="subject" value='<%=article.getSubject()%>'>
        </div>
          
        <div>
             <label class="createPostButton">작성자</label> 
             <input type="text" class="grayBox" readonly value='<%=id %>'  id="writer" name="writer" >
             <div class="right"><label class="createPostButton">비밀번호</label> 
             <input type="password" class="grayBox" placeholder="4자리 설정" maxlength="4" required id="passwd" name="passwd"></div>
        </div>
        
        <input type="text" class="createPostBox" id="content" name="content" value="<%=article.getContent()%>">    
        
    </div> 
    
    <div style="text-align:right">
          <p id="checkPasswd" style="color : red; display: inline-block; padding-top: 20px;"></p>
          <%if (id.equals(article.getWriter())){ %>
          <input type="button" class="newButton" value='삭제' style="margin-top:20px; display:inline-block;" onclick="deleteArticle()" >
          <%} %>      
          <input type="submit" class="newButton" value='확인' style="margin-top:20px; display:inline-block;" onclick="passwdCheck()" >      
    </div>

</form>
    
    <%
    }
    %>
   
  </div> 
  

<!-- End page content -->
</div>

</div>

</body>
</html>
