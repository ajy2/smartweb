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
			alert("Userid나 이메일이 이미 존재합니다.");
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
		alert("약관에 동의해야만 회원가입이 됩니다.");
		window.location.href="signUpForm.html";
	</script>
<%		return;
}
response.sendRedirect("foodList.jsp");
%>