<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<title>내가 리뷰한 제품</title>
	</head>
	
	<body>
		<h2>FOOD INFO</h2>
		<form action="updateBook" method="post">
			 <ul>
				<li>
					<table border=1>
						<tr><th>productId</th><th>txt</th></tr>
	
						<%
							request.setCharacterEncoding("EUC-KR");
							
							try{
								String dbURL = "jdbc:mysql://localhost:3306/food";
								String dbUser = "food";
								String dbPass = "ghwns233";
								String userid = (String)session.getAttribute("userid");
								
								Class.forName("com.mysql.jdbc.Driver");
								Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);
								
								String query = "select productId, txt from review where userid=?";
								PreparedStatement pstmt = con.prepareStatement(query);
								pstmt.setString(1, userid);
								//pstmt.setString(2, redirected_code);
								ResultSet rs= pstmt.executeQuery();
								
								while(rs.next()){%>
									<tr>
										<td><%=rs.getString(1)%></td>
										<td><%=rs.getString(2)%></td>
									</tr>
					<%			}
		
								con.close();
								pstmt.close();
								rs.close();
							}catch(Exception e){
								e.printStackTrace();
							}
					%>
					</table>
					</li>
					</ul>
			</form>
	
			
	</body>
</html>