<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*, JW0036.*" %>
<%
String agree = request.getParameter("agree");
String result = null;
if(agree.equals("yes")){
	User user = new User();
	user.setUserid((String)session.getAttribute("userid"));
	user.setEmail((String)session.getAttribute("email"));
	user.setPasswd((String)session.getAttribute("passwd"));
	
	int no = userDB.checkUserAvail(user.getUserid(), user.getEmail());
	if(no > 0){%>
		<script>
			alert("Userid�� �̸����� �̹� �����մϴ�.");
			window.location.href="signUpForm.html";
		</script>
<%		return;
	}else{
		boolean flag = false;
		flag = userDB.insertUser(user);
	}
}else{
%>
	<script>
		alert("����� �����ؾ߸� ȸ�������� �˴ϴ�.");
		window.location.href="signUpForm.html";
	</script>
<%		return;
}
response.sendRedirect("foodList.jsp");
%>