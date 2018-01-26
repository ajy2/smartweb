<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%
String userid = "";
userid = (String)session.getAttribute("userid");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>회원가입</title>
</head>
<body>
	<h3>안내사항</h3>
	=============================================================================<Br/>
	1. 회원 정보는 웹 사이트의 운영을 위해서만 사용됩니다.<br/>
	2. 탈퇴하시면 고객님의 모든 정보가 모두 삭제됩니다.<br/>
	=============================================================================<Br/>
	
	<form action="deleteUser.jsp" method="post">
		그래도 탈퇴하시겠습니까?<br/>
		<input type="radio" name="agree" value="yes">탈퇴를 원함<br/>
		<input type="radio" name="agree" value="no">탈퇴를 원하지 않음<br/>
		탈퇴를 원하시면 비밀번호를 입력해주세요<input type="password" name="passwd"><br/>
		<input type="submit" value="확인">
	</form>
</body>
</html>