<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.util.*, JW0036.*"%>
<%
String userid= (String) session.getAttribute("userid");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>List of Users</title>
<script>
	function userModify(username){
		document.getElementById("username1").value= username;
		document.userModify.submit();
	}

	function userDelete(username){
		document.getElementById("username2").value= username;
		document.userDelete.submit();
	}
</script>
<body>
<input type="button" value="홈으로 이동" onclick="location.href='foodList.jsp'"/>
<%
if(userid.equals("admin")){
%>
<form name="modify" method="post">
<table id="list">
	<tr>
		<th>Username</th>
		<th>Email</th>
		<th>lastLogin</th>
		<th></th>
	</tr>
<%
	ArrayList<User> users = userDB.showUsers();
	for(User u: users){
%>
<tr>
	<td width="20%"><%=u.getUserid()%></td>
	<td width="20%"><%=u.getEmail()%></td>
	<td width="20%"><%=u.getLastLogin()%></td>
	<td width="20%">
		<a href="javascript:userModify('<%=u.getUserid()%>');">[modify]</a>
		<a href="javascript:userDelete('<%=u.getUserid()%>');">[delete]</a>
	</td>
</tr>
<%
	}
%>
</table>
</form>
<form name="userModify" method="post" action="userInfoMgmt_admin.jsp">
<input type="hidden" name="userid" id="username1">
</form>
<form name="userDelete" method="post" action="userController">
<input type="hidden" name="userid" id="username2">
<input type="hidden" name="actionType" value="delete">
</form>
<%} %>
</body>
</html>