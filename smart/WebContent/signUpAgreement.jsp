<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	request.setCharacterEncoding("EUC-KR");
	String userid = request.getParameter("userid");
	String passwd = request.getParameter("passwd");
	String email = request.getParameter("email");
	
	session.setAttribute("userid", userid);
	session.setAttribute("passwd", passwd);
	session.setAttribute("email", email);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>ȸ������</title>
</head>
<body>
	<h3>���</h3>
	=============================================================================<Br/>
	1. ȸ�� ������ �� ����Ʈ�� ��� ���ؼ��� ���˴ϴ�.<br/>
	2. �� ����Ʈ�� ���� ��� �����ϴ� ȸ���� Ż�� ó���˴ϴ�.<br/>
	=============================================================================<Br/>
	
	<form action="signUp.jsp" method="post">
		���� ����� �����Ͻʴϱ�?<br/>
		<input type="radio" name="agree" value="yes">������<br/>
		<input type="radio" name="agree" value="no">�������� ����<br/>
		<input type="submit" value="Ȯ��">
	</form>
</body>
</html>