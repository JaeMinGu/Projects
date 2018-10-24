<%@page import="kr.or.kosta.blog.common.Params"%>
<%@page import="kr.or.kosta.blog.common.PageBuilder"%>
<%@page import="kr.or.kosta.blog.article.Article"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.kosta.blog.article.ArticleDao"%>
<%@page import="kr.or.kosta.jsp.blog.dao.DaoFactory"%>
<%@page import="kr.or.kosta.blog.user.User"%>
<%@page import="kr.or.kosta.blog.user.UserDao"%>
<%@ page contentType="text/html; charset=utf-8" %>
<%
request.setCharacterEncoding("utf-8");
DaoFactory factory= (DaoFactory)application.getAttribute("factory");
ArticleDao dao = factory.getArticle();

//페이지당 보여지는 목록수 설정
int listSize = 5;
//페이지당 보여지는 페이지수 설정
int pageSize = 5;


// 선택페이지 수신
String requestPage = request.getParameter("page");
if(requestPage == null || requestPage.equals("")){
  requestPage = "1";
}

//검색 요청일 경우 파라메터 수신
String searchType = request.getParameter("searchType");
String searchValue = request.getParameter("searchValue");

//System.out.println(searchType );
//System.out.println(searchValue);
if(searchType == null || searchType.equals("")){
searchType = null;
searchValue = null;
}

//요청파라메터 포장
Params params = new Params(Integer.parseInt(requestPage), listSize, pageSize, searchType, searchValue);

// 페이징 정렬 
List<Article> list = dao.listByPage(params);

// 페이징 처리에 필요한 검색 개수 DB조회
int rowCount = dao.countBySearch(params);

// PageBuilder를 이용하여 페이징 계산
PageBuilder pageBuilder = new PageBuilder(params, rowCount);
pageBuilder.build();

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

<h1 class="headline"><b>자유게시판</b></h1>
<div class="outline">

<div class="w3-responsive w3-card-4">
        <table class="w3-table w3-striped w3-bordered" style="text-align: center;">
          <thead>
            <tr class="w3-theme">
              <th>번호</th>
              <th>제목</th>
              <th>작성자</th>
              <th>작성일</th>
              <th>아이피</th> 
              <th>조회</th>
            </tr>
          </thead>
          <tbody>
          
          <%
            for(int i=0; i<list.size(); i++){
            Article article = list.get(i);
            %>
              <tr>
                  <td><%=(rowCount - listSize * (params.getPage()-1) ) - i %></td>
                  <td><a href=' <%=application.getContextPath() %>/article/article.jsp?articleId=<%=article.getArticleId() %>'><%=article.getSubject() %></a></td>
                  <td><%=article.getWriter() %></td>
                  <td><%=article.getRegdate() %></td>
                  <td><%=article.getIp() %></td>
                  <td><%=article.getHitCount() %></td>
            </tr>
            <%
            }
            %>
          </tbody>
        </table>
        
  <!-- Pagination -->
<%--   <div class="w3-center w3-padding-32">
    <div class="w3-bar">
      <a href="#" class="w3-bar-item w3-button w3-hover-green ">««</a>
      <a href="#" class="w3-bar-item w3-button w3-hover-green">«</a>
      <a href="#" class="w3-bar-item w3-black w3-button">1</a>
      <a href="#" class="w3-bar-item w3-button w3-hover-black">2</a>
      <a href="#" class="w3-bar-item w3-button w3-hover-black">3</a>
      <a href="#" class="w3-bar-item w3-button w3-hover-black">4</a>
      <a href="#" class="w3-bar-item w3-button w3-hover-black">5</a>
      <a href="#" class="w3-bar-item w3-button w3-hover-green">»</a>
      <a href="#" class="w3-bar-item w3-button w3-hover-green">»»</a>
      </div>
      <div style="text-align:right;margin-right:50px" >
      <button  class="newButton" onclick="location.href='<%=application.getContextPath()%>/index.jsp'">홈으로</button>
      <button class="newButton" onclick="location.href='<%=application.getContextPath()%>/article/regist_article.jsp'">글쓰기</button>
    </div>
  </div> --%>
   <div class="w3-center w3-padding-32">
    <div class="w3-bar">
         <%
      if(pageBuilder.isShowFirst()){
      %>
        <a href="<%=pageBuilder.getQueryString(1)%>" class=" w3-bar-item w3-button w3-hover-green ">처음으로</a>      
      <%        
      }
      %>
      
      <%
      if(pageBuilder.isShowPrevious()){
      %>
        <a class="w3-bar-item w3-button w3-hover-green" href="<%=pageBuilder.getQueryString(pageBuilder.getPreviousStartPage())%>">&laquo;</a>      
      <%        
      }
      %>
      
      <%
      for(int i=pageBuilder.getStartPage(); i<=pageBuilder.getEndPage(); i++){
        if(i == params.getPage()){
      %>
          <a class="w3-bar-item w3-black w3-button active"><%=i %></a>
      <%          
        }else{
      %>
           <a href="<%=pageBuilder.getQueryString(i)%>" class="w3-bar-item w3-black w3-button"><%=i %></a>
      <%          
        }
      }
      %>
      
      <%
      if(pageBuilder.isShowNext()){
      %>
        <a class="w3-bar-item w3-button w3-hover-green" href="<%=pageBuilder.getQueryString(pageBuilder.getNextStartPage())%>" >&raquo;</a>      
      <%        
      }
      %>
      <%
      if(pageBuilder.isShowLast()){
      %>
        <a class="w3-bar-item w3-button w3-hover-green" href="<%=pageBuilder.getQueryString(pageBuilder.getPageCount())%>">끝으로</a>      
      <%        
      }
      %>
      </div><br>
      <div style="float: right; margin-bottom: 30px; margin-right: 20px;">
        <input class="newButton w3-bar-item" type="button" value="홈으로" onclick="location.href='<%=application.getContextPath()%>/index.jsp'">
        <input class="newButton w3-bar-item" type="button" value="글쓰기" onclick="location.href='<%=application.getContextPath()%>/article/regist_article.jsp'">
      </div>
  </div> 
  
  
      </div>    
  
    <div style="text-align:center; margin-top: 30px">
     <form action = "../board/board.jsp" method="post">
      <div style="vertical-align:middle; display:inline-block; ">
          <select class="brownBox" name="searchType">
            <option value="subject">글제목
            <option value="content">글내용
            <option value="writer">작성자
          </select>
      </div> 
      
      <input type="text" class=" grayBox" name="searchValue" >
      <input class="newButton w3-bar-item" type="submit" value="검색"> 
    </form>
   </div>
  </div>
  
  
</div>      


    
    

</div>

  

  




</body>
</html>
