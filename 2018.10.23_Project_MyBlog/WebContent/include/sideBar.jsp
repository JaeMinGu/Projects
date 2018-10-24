<%@ page contentType="text/html; charset=utf-8" %>
<!-- Sidebar/menu -->
<nav class="w3-sidebar w3-collapse w3-white w3-animate-left" style="z-index:3; width:300px;" id="mySidebar"><br>
  <div class="w3-container" >
    <a href="#" onclick="w3_close()" class="w3-hide-large w3-right w3-jumbo w3-padding w3-hover-grey" title="close menu">
      <i class="fa fa-remove"></i>
    </a>
    <a href="<%=application.getContextPath() %>/index.jsp"><img src="<%=application.getContextPath() %>/image/smilingPuppy.jpg" style="width:55%;" class="w3-round"></a><br><br>
    <h4><b>〓 사지말고 입양하세요 〓</b></h4>
    <p class="w3-text-grey"></p>
  </div>
  
  <div class="w3-bar-block">
    <a href="#" onclick="location.href='<%=application.getContextPath()%>/index.jsp'" class="w3-bar-item w3-button w3-padding">▶　홈</a> 
    <a href="#" onclick="location.href='<%=application.getContextPath()%>/guestBook/guestBook.jsp'" class="w3-bar-item w3-button w3-padding">▶　방명록</a> 
    <a href="#" onclick="location.href='<%=application.getContextPath()%>/board/board.jsp'" class="w3-bar-item w3-button w3-padding">▶　자유게시판</a> 
  </div>
  
</nav>