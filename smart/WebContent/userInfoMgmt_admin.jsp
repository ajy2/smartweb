<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<jsp:useBean id="userDB" class="JW0036.userDB"/>
<jsp:useBean id="user" class="JW0036.User"/>
<%
String userid = "";
userid = (String)session.getAttribute("userid");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
String requestedUser = request.getParameter("userid");
if("admin".equals(userid)){	
	user = userDB.showAUser(requestedUser);
}
%>
<%if(user != null){ %>
	<h2><%=userid %>회원의 정보수정 </h2><input type="button" value="홈으로 이동" onclick="location.href='foodList.jsp'"/>
	</table>
		<form action="userController" method="post">
		<table border=1>
		<tr>
			<th>Userid</th><td><input type="text" name="userid" value="<%=user.getUserid()%>">
			<input type="hidden" name="actionType" value="modify"></td>
		</tr>
		<tr>
			<th>이메일</th><td><input type="text" name="email" value="<%=user.getEmail()%>"></td>
		</tr>
		<tr>
			<th>패스워드</th><td><input type="password" name="passwd"></td>
		</tr>
		<tr>
			<td colspan=2 align="center"><input type="submit" value="수정"></td>
		</tr>
		</table>
		</form>
<%}else{%>
	<h3><a href="sessionLoginForm.html">로그인</a></h3>
<%}%>
</body>
</html>