<%@page import="kr.or.kosta.jsp.blog.dao.DaoFactory"%>
<%@page import="kr.or.kosta.jsp.blog.dao.JdbcDaoFactory"%>
<%@ page contentType="text/html; charset=utf-8" %>
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
      <!--<div>
      <button class="newButton">전체</button>
      <button class="w3-button w3-white">암컷</button>
      <button class="w3-button w3-white w3-hide-small">수컷</button>
    </div>-->
    </div> 
    </div>
  </header>
  
  <!-- First Photo Grid-->
  <div class="w3-row-padding">
    <div class="w3-third w3-container w3-margin-bottom">
      <img src="<%=application.getContextPath() %>/image/puppy1.JPG" alt="puppy1" style="width:100%" class="w3-hover-opacity">
      <div class="w3-container w3-white">
        <p><b>별님이</b></p>
          <p>구조자　정보　　　: 김하나 / 010-1111-2222 <br>
          구조 일시 및 장소　: 안동시 도산면 서부리<br>
            구조 동물 정보　　 : 개 / 암컷 / 1개월 추정</p>
        </div>
    </div>
    <div class="w3-third w3-container w3-margin-bottom">
      <img src="<%=application.getContextPath() %>/image/puppy2.JPG" alt="puppy2" style="width:100%" class="w3-hover-opacity">
      <div class="w3-container w3-white">
        <p><b>달님이</b></p>
        <p>구조자　정보　　　: 김두울 / 010-2222-3333 <br>
          구조 일시 및 장소　: 서울시 강남구 잠실동<br>
            구조 동물 정보　　 : 개 / 수컷 / 3개월 추정</p>
      </div>
    </div>
    <div class="w3-third w3-container">
      <img src="<%=application.getContextPath() %>/image/puppy3.JPG" alt="puppy3" style="width:100%" class="w3-hover-opacity">
      <div class="w3-container w3-white">
        <p><b>햇살이</b></p>
        <p>구조자　정보　　　: 김세엣 / 010-3333-4444 <br>
          구조 일시 및 장소　: 대구시 수성구 범어동<br>
            구조 동물 정보　　 : 개 / 수컷 / 9개월 추정</p>
      </div>
    </div>
  </div>
  
  <!-- Second Photo Grid-->
  <div class="w3-row-padding">
    <div class="w3-third w3-container w3-margin-bottom">
      <img src="<%=application.getContextPath() %>/image/puppy4.JPG" alt="puppy4" style="width:100%" class="w3-hover-opacity">
      
      <div class="w3-container w3-white">
        <p><b>로꾸</b></p>
          <p>구조자　정보　　　: 김네엣 / 010-4444-5555 <br>
          구조 일시 및 장소　: 서울시 성북구 돈암동<br>
            구조 동물 정보　　 : 개 / 수컷 / 2개월 추정</p>
    </div>
    </div>
    
    <div class="w3-third w3-container w3-margin-bottom">
      <img src="<%=application.getContextPath() %>/image/puppy5.JPG" alt="puppy5" style="width:100%" class="w3-hover-opacity">
      <div class="w3-container w3-white">
        <p><b>설기</b></p>
       <p>구조자　정보　　　: 김다섯 / 010-5555-6666 <br>
          구조 일시 및 장소　: 대전시 유성구 용계동<br>
            구조 동물 정보　　 : 개 / 암컷 / 1개월 추정</p>
      </div>
    </div>
    
    <div class="w3-third w3-container">
      <img src="<%=application.getContextPath() %>/image/puppy6.JPG" alt="puppy6" style="width:100%" class="w3-hover-opacity">
      <div class="w3-container w3-white">
        <p><b>노신이</b></p>
         <p>구조자　정보　　　: 김여섯 / 010-6666-7777 <br>
          구조 일시 및 장소　: 제주시 구좌읍 하도리<br>
            구조 동물 정보　　 : 개 / 암컷 / 5개월 추정</p>
        </div>
    </div>
    
  </div>
  <!-- Pagination -->
<!--   <div class="w3-center w3-padding-32">
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
  </div> -->


 
</div>  
</body>
</html>
