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
<title>ȸ������</title>
</head>
<body>
	<h3>�ȳ�����</h3>
	=============================================================================<Br/>
	1. ȸ�� ������ �� ����Ʈ�� ��� ���ؼ��� ���˴ϴ�.<br/>
	2. Ż���Ͻø� ������ ��� ������ ��� �����˴ϴ�.<br/>
	=============================================================================<Br/>
	
	<form action="deleteUser.jsp" method="post">
		�׷��� Ż���Ͻðڽ��ϱ�?<br/>
		<input type="radio" name="agree" value="yes">Ż�� ����<br/>
		<input type="radio" name="agree" value="no">Ż�� ������ ����<br/>
		Ż�� ���Ͻø� ��й�ȣ�� �Է����ּ���<input type="password" name="passwd"><br/>
		<input type="submit" value="Ȯ��">
	</form>
</body>
</html>