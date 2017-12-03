<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<title>Insert title here</title>
	</head>
	
	<body>
		<h2>FOOD INFO</h2>
		<form action="updateBook" method="post">
			 <ul>
				<%
					String code = request.getParameter("code");
					String redirected_code=(String)request.getAttribute("code");				
					String name ="";
					String price="";
					String query = "";
					Connection con = null;
					try{
						String dbURL = "jdbc:mysql://localhost:3306/food";
						String dbUser = "food";
						String dbPass = "ghwns233";
						
						Class.forName("com.mysql.jdbc.Driver");
						con = DriverManager.getConnection(dbURL, dbUser, dbPass);
						
						query = "select name, price from product where productId=? or productId=?";
						PreparedStatement pstmt = con.prepareStatement(query);
						pstmt.setString(1, code);
						pstmt.setString(2, redirected_code);
						ResultSet rs= pstmt.executeQuery();
						
						while(rs.next()){
							name = rs.getString(1);
							price = rs.getString(2);
						}
					}catch(Exception e){
						e.printStackTrace();
					}		
				%>
			 	<li><b>PRODUCTID : </b><input type="text" name="productId" value="<%=code%>" readonly></li>
			 	<li><b>FOODNAME : </b><input type="text" name="name" value="<%=name%>" readonly></li>
			 	<li><b>PRICE : </b><input type="text" name="price" value="<%=price%>" readonly></li>
				<li>
					<table border=1>
						<tr><th>profileName</th><th>helpfulness</th><th>score</th><th>date</th><th>text</th></tr>
	
						<%
							request.setCharacterEncoding("EUC-KR");
	
							try{
								String dbURL = "jdbc:mysql://localhost:3306/food";
								String dbUser = "food";
								String dbPass = "ghwns233";
								
								Class.forName("com.mysql.jdbc.Driver");
								con = DriverManager.getConnection(dbURL, dbUser, dbPass);
								
								query = "select profileName, helpfulness, score, time, txt from review where productId=? or productId=?";
								PreparedStatement pstmt = con.prepareStatement(query);
								pstmt.setString(1, code);
								pstmt.setString(2, redirected_code);
								ResultSet rs= pstmt.executeQuery();
								
								while(rs.next()){%>
									<tr>
										<td><%=rs.getString(1)%></td>
										<td><%=rs.getString(2)%></td>
										<td><%=rs.getString(3)%></td>
										<td><%=rs.getString(4)%></td>
										<td><%=rs.getString(5)%></td>
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
	
			<form action="insertReview" method="post">
				<%
					String userid = (String)session.getAttribute("userid");
					if(userid != null){%>
						<li>
							profileName : <input type='textarea' name='profileName'><br/>
							helpfulness : <input type='helpfulness' name='helpfulness' placeholder="ex) 5/8"><br/>
							score : 
							<select name='score'>
								<option value='0'>0</option>
								<option value='1'>1</option>
								<option value='2'>2</option>
								<option value='3'>3</option>
								<option value='4'>4</option>
								<option value='5'>5</option>
							</select><br/>
							summary : <input type='textarea' name='summary'><br/>
							txt : <input type='textarea' name='txt'>
							<INPUT TYPE="hidden" name="hiddenvalue" value=<%=code%>>
							<input type='submit' value='제출'/>
						</li>
				<%}%>
			</form>
	</body>
</html>