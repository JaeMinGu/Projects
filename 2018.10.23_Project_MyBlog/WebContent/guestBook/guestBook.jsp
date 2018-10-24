<%@page import="java.util.ArrayList"%>
<%@page import="kr.or.kosta.blog.guestbook.GuestBook"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.kosta.blog.guestbook.GuestBookDao"%>
<%@page import="kr.or.kosta.jsp.blog.dao.DaoFactory"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%

  request.setCharacterEncoding("utf-8");

  DaoFactory factory = (DaoFactory)application.getAttribute("factory");
  GuestBookDao dao = factory.getGuestBookDao();
  List<GuestBook> list = dao.listAll(); 
  
  
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
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
  href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet"
  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
  href="<%=application.getContextPath()%>/css/basic.css">
<style>
textarea {
  resize: none;
}
td, th {
    display: table-cell;
    vertical-align: inherit;
}
</style>
</head>
<body class="w3-light-grey w3-content" style="max-width: 1600px">

  <%-- 사이드 바 메뉴 시작 --%>
  <jsp:include page="/include/sideBar.jsp" />
  <%-- 사이드 바 메뉴 종료 --%>


  <!-- Overlay effect when opening sidebar on small screens -->
  <div class="w3-overlay w3-hide-large w3-animate-opacity"
    onclick="w3_close()" style="cursor: pointer" title="close side menu"
    id="myOverlay"></div>

  <!-- !PAGE CONTENT! -->
  <div class="w3-main" style="margin-left: 300px">

    <!-- Header -->
    <div>
    <header id="portfolio">
      <div class="w3-container">
        <%-- 탑 헤드 시작 --%>
        <jsp:include page="../include/top.jsp" />
        <%-- 탑 헤드 종료 --%>

        <div class="w3-section w3-bottombar w3-padding-16"></div>
      </div>
    </header>
    </div>
    <div style="margin: 10px 100px;">

      <h1 class="headline"><b>방명록</b></h1>
      <div class="outline">
        <form action="<%=application.getContextPath()%>/guestBook/regist_action.jsp">
          <%
          	if (id != null) { //로그인
          %>
          <div style="margin: 30px 0px">
            <input type="hidden" name="userId" value="<%=id%>">
            
            <%-- <input class="registText" type="text" name="contents" id="contents" placeholder="방명록을 남겨주세요 (100자 이내)" style="line-height: 100px; width: 90%; background-color: lightgray" maxlength="100">--%>
            <div>
            <textarea class="registText" name="contents" id="contents" style="line-height: 50px; width: 90%; background-color: lightgray; vertical-align: middle;" placeholder="방명록을 남겨주세요 (100자 이내)"  maxlength="100" ></textarea>
            
            <input type="submit" class="newButton registButton"  value="등록" style="vertical-align: middle;">
            </div>
          </div>

          <%
          	} else { // 로그인 x
          %>
          <div style="margin: 30px 0px">
            <input class="registText" type="text"  name="contents" id="contents" placeholder="로그인 후 이용 가능합니다" disabled style="line-height: 100px; width: 90%; resize: none; background-color: lightgray">
            <input type="button" class="newButton registButton" value="등록">
          </div>
          <%
          	}
          %>
        </form>

        <div class="w3-responsive w3-card-4">
          <table class="w3-table w3-striped w3-bordered">
            <thead>
              <tr>
                <th>작성자</th> <th>내용</th> <th>등록날짜</th>
              </tr>
            </thead>
            
            <tbody>              
           
            <%
            for(GuestBook guestBook : list){
            %>  
               <tr>
                  <td><%=guestBook.getUserId() %></td>
                  <td><%=guestBook.getContents() %></td>
                  <td><%=guestBook.getRegdate() %></td>
               </tr>
            <%
            }
            %>
            
            </tbody>
          </table>
        </div>
      </div>
    </div>
    <!-- End page content -->
  </div>


</body>
</html>
