<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*, JW0036.*" %>
<% 
	String userid = request.getParameter("userid");
	String passwd = request.getParameter("passwd");

	int no1 = userDB.checkUseridAvail(userid);
	
	if(no1 > 0){
		int no2 = userDB.checkUserPasswd(userid, passwd);
		if(no2 > 0){
			session.setAttribute("userid", userid);
			response.sendRedirect("foodList.jsp");
		}else{%>
			<script>
				alert("��й�ȣ�� ���� �ʽ��ϴ�.");
				window.location.href="sessionLoginForm.html";
			</script>
		<%}
	}else{%>
		<script>
			alert("���̵� �������� �ʽ��ϴ�.");
			window.location.href="signUpForm.html";
		</script>	
<%	}
%>
</body>
</html>