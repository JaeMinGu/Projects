<%@page import="com.sun.xml.internal.txw2.Document"%>
<%@page import="kr.or.kosta.blog.user.UserDao"%>
<%@page import="kr.or.kosta.jsp.blog.dao.DaoFactory"%>
<%@page import="kr.or.kosta.blog.user.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=utf-8" %>
<%
List<String> idList = null; 
DaoFactory factory =(DaoFactory) application.getAttribute("factory"); 
UserDao dao = factory.getUserDao();
idList = dao.idList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>★ JaeMin's Blog ★</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="../css/basic.css">
<script type="text/javascript">
// 아이디 중복검사 
function idCheck() {
  var id = document.getElementById("id").value;
  //alert(id);
  // 아이디 리스트 가져오기 
  var arr = new Array();
  <%
  for(String userId : idList){%>
    arr.push('<%=userId%>');
  <%}%>
  if(arr.includes(id)){
	  document.getElementById("checkId").innerHTML = '이미 존재하는 아이디입니다'; 
  }else{
	  document.getElementById("checkId").innerHTML = '사용 가능한 아이디입니다'; 
  }
}
// 비밀번호 일치여부 검사 
function passwdCheck() {

	var passwd = document.getElementById('passwd').value;
	var passwd2 = document.getElementById('passwd2').value;

	if (passwd != passwd2) {
		document.getElementById("passwdCheck").innerHTML = '비밀번호가 일치하지 않습니다.';
		return false;
	}

}
</script>
</head>
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
  
      <h1 class="headline" ><b>회원가입</b></h1>
      <div class="registOutline">
<!-- ../user/regist_action.jsp -->
<form action="../user/regist_action.jsp" onsubmit="return passwdCheck()" method="post">
      <div>
          <label class="registL" style="margin-right:60px" >아이디</label>
          <input class="registText w3-border " type="text" id="id" name="id" required placeholder="영어만 입력 가능합니다." maxLength="10" style="display: inline-block; ">
          <input type="button" class= "newButton green" onclick="idCheck()" value="중복확인">
          <p id="checkId" style="color : red; display: inline-block;"></p>
      </div>
      
      
       
      <div>
          <label class="registL" style="margin-right:44px;">비밀번호</label>
          <input class="registText w3-border " type="password" id="passwd" name="passwd" required placeholder="비밀번호를 입력하세요" >
      </div>
      
      <div>
          <label class="registL" >비밀번호 확인</label>
          <input class="registText w3-border " type="password" id="passwd2" name="passwd2" required placeholder="다시 한 번 비밀번호를 입력하세요" style="display: inline-block;">
          <p id="passwdCheck" style="color: red; display: inline-block;"  ></p>
      </div>
      
      <div>
           <label class="registL" style="margin-right: 75px;">이름</label></td>
          <input class="registText w3-border " type="text" id="name" name="name" required placeholder="이름을 입력하세요">
      </div>
      
      <div>
          <label class="registL" style="margin-right: 59px;" >이메일</label></td>
          <input class="registText w3-border " type="email" id="email" name="email" required placeholder="Xxx@xxx.xxx의 형태로 입력하세요">
      </div>
      
      
      <div class="regist">
          <input type="submit" class="newButton" value = "가입하기">
          <input type="button" class="newButton" onclick="location.href='../user/regist_form.jsp'" value = "다시입력">
      </div>
      
      
    </form>
</div>
  

  

<!-- End page content -->
</div>



</html>
