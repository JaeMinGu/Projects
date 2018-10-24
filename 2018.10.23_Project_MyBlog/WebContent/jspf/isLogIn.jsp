<%@ page contentType="text/html; charset=utf-8" %>
<%
  String id = null;
	Cookie[] cookies = request.getCookies();
	if (cookies != null) {
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals("loginId")) {
				id = cookie.getValue();
			}
		}
	}
%>