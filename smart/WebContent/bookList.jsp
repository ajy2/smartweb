<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*, java.util.*, java.net.URLEncoder"%>
<%
String userid = (String)session.getAttribute("userid");
String passwd = (String)session.getAttribute("passwd");
String email = (String)session.getAttribute("email");

session.setAttribute("userid", userid);
session.setAttribute("passwd", passwd);
session.setAttribute("email", email);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h2>FOOD</h2>
<%if(userid != null && !userid.equals("")){ %>
	<h3><%=userid %>ȸ���� ȯ���մϴ�.
		<input type="button" value="�α׾ƿ�" onclick="location.href='sessionLogout.jsp'"/>
		<input type="button" value="ȸ����������" onclick="location.href='userInfoMgmt.jsp'"/>
		<input type="button" value="������ǰȮ��" onclick="location.href='userReview.jsp'"/>
		<%
			if("admin".equals(userid)){%>
				<input type="button" value="ȸ������" onclick="location.href='listUsers.jsp'"/>
			<%}
		%>
		
<%}else{%>
	<h3>
		<input type="button" value="�α���" onclick="location.href='sessionLoginForm.html'"/>
		<input type="button" value="ȸ������" onclick="location.href='signUpForm.html'"/>
	</h3>
<%}%>
	<h4><a href="bookForm.jsp">�� å ���</a></h4>
	
	<table border=1>
	<form action = "bookList.jsp" method="post">
	<ul>
		<li><b>�˻� </b><input type="text" name="search"></li>

		<tr>
			<th>productId</th><th>name</th><th>price</th>
		</tr>
		<%
				request.setCharacterEncoding("EUC-KR");
				String menu = request.getParameter("menu");
				String search = request.getParameter("search");
				String query = "";

				Connection con = null;
				try{
					String dbURL = "jdbc:mysql://localhost:3306/food";
					String dbUser = "food";
					String dbPass = "ghwns233";
					
					Class.forName("com.mysql.jdbc.Driver");
					con = DriverManager.getConnection(dbURL, dbUser, dbPass);
					Statement stmt = con.createStatement();
					query = "Select * from product";
					
					String cond = "";
					if(search != null && !search.equals("")){
						 cond= " where productId like '%"+search+"%' or name like '%"+search+"%'";
					}

					ResultSet rs= stmt.executeQuery(query+cond);
					while(rs.next()){
		%>
						<tr>
							<td><%=rs.getString(1)%></td>
							<td><a href="bookInfo.jsp?code=<%=rs.getString(1)%>"><%=rs.getString(2)%></a></td>
							<td><%=rs.getString(3)%></td>
							<%if("admin".equals(userid)){%>
								<td>
									<a href="updateBookForm.jsp?code=<%=rs.getString(1)%>">����</a>/<a href="deleteBook?code=<%=rs.getString(1)%>">����</a>
	                        	</td>
							<%}%>
						</tr>
		<%			}
				}catch(Exception e){
					e.printStackTrace();
				}
		%>
	</ul>
	</form>
	</table>
</body>
</html>