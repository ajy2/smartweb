<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
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
<%if(userid != null && !userid.equals("")){ 
	user = userDB.showAUser(userid);
%>
	<input type="button" value="홈으로 이동" onclick="location.href='foodList.jsp'"/>
	<h2><%=userid %>회원님 환영합니다.</h2><a href="sessionLogout.jsp">로그아웃</a>
	<h3>회원님의 상세정보는 다음과 같습니다.<a href="deleteUserConfirm.jsp">[회원탈퇴]</a></h3>
	</table>
		<form action="userController" method="post">
		<input type="hidden" name="actionType" value="modifyUser">
		<table border=1>
		<tr>
			<th>Userid</th><td><%=userid%></td>
		</tr>
		<tr>
			<th>이메일</th><td><input type="text" name="email" value="<%=user.getEmail()%>"></td>
		</tr>
		<tr>
			<td colspan=2><b>* 패스워드를 바꾸시려면 기존 패스워드와 새 패스워드 모두 입력하세요</b></td>
		</tr>
		<tr>
			<th>기존 사용자 패스워드 입력</th><td><input type="password" name="oldPasswd"></td>
		</tr>
		<tr>
			<th>새 사용자 패스워드 입력</th><td><input type="password" name="passwd"></td>
		</tr>
		<tr>
			<td colspan=2 align="center"><input type="submit" value="수정"></td>
		</tr>
		</table>
		</form>
<%
	}else{%>
	<h3><a href="sessionLoginForm.html">로그인</a></h3>
<%} %>
</body>
</html>