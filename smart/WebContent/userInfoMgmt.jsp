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
	<h2><%=userid %>ȸ���� ȯ���մϴ�.</h2><a href="sessionLogout.jsp">�α׾ƿ�</a>
	<h3>ȸ������ �������� ������ �����ϴ�.<a href="deleteUserConfirm.jsp">[ȸ��Ż��]</a></h3>
	</table>
		<form action="userController" method="post">
		<input type="hidden" name="actionType" value="modifyUser">
		<table border=1>
		<tr>
			<th>Userid</th><td><%=userid%></td>
		</tr>
		<tr>
			<th>�̸���</th><td><input type="text" name="email" value="<%=user.getEmail()%>"></td>
		</tr>
		<tr>
			<td colspan=2><b>* �н����带 �ٲٽ÷��� ���� �н������ �� �н����� ��� �Է��ϼ���</b></td>
		</tr>
		<tr>
			<th>���� ����� �н����� �Է�</th><td><input type="password" name="oldPasswd"></td>
		</tr>
		<tr>
			<th>�� ����� �н����� �Է�</th><td><input type="password" name="passwd"></td>
		</tr>
		<tr>
			<td colspan=2 align="center"><input type="submit" value="����"></td>
		</tr>
		</table>
		</form>
<%
	}else{%>
	<h3><a href="sessionLoginForm.html">�α���</a></h3>
<%} %>
</body>
</html>