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
<%
String agree = request.getParameter("agree");
if(agree.equals("yes")){
	int no1 = userDB.checkUserPasswd(userid, request.getParameter("passwd"));
	if(no1 == 1){
		int no2 = userDB.deleteUser(userid);
		if(no2 > 0){
			session.invalidate();
		%>
			<script>
				alert("정상적으로 탈퇴되었습니다");
				window.location.href="../bookList.jsp";
			</script>			
<%		}
}else{%>
	<script>
		window.history.go(-1);
	</script>
<%}}%>
</body>
</html>