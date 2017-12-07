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
			<input type="button" value="홈으로 이동" onclick="location.href='bookList.jsp'"/>
			<input type="button" value="추천받기" onclick="location.href='recommendation.jsp'"/>
		<form action="updateReview" method="post">
			 <ul>
				<li>
					<table border=1>
						<tr style="text-align:center"><th>productId</th><th>score</th><th>time</th><th>summary</th><th>txt</th></tr>
	
						<%
							request.setCharacterEncoding("EUC-KR");
							
							try{
								String dbURL = "jdbc:mysql://localhost:3306/food";
								String dbUser = "food";
								String dbPass = "ghwns233";
								String userid = (String)session.getAttribute("userid");
								String redirected_id=(String)request.getAttribute("userid");
								/*if(userid==null){
									userid = redirected_id;
								}*/
								
								Class.forName("com.mysql.jdbc.Driver");
								Connection con = DriverManager.getConnection(dbURL, dbUser, dbPass);
								
								String query = "select productId, score, time, txt from review where userid=?";
								PreparedStatement pstmt = con.prepareStatement(query);
								pstmt.setString(1, userid);
								ResultSet rs= pstmt.executeQuery();
								
								while(rs.next()){%>
									<tr>
										<td><a href="foodInfo.jsp?code=<%=rs.getString(1)%>"><input type="text" name="productId" value=<%=rs.getString(1)%> readonly></a></td>
										<td><input type="text" value=<%=rs.getString(2)%> name="score"></td>
										<td><input type="text" value=<%=rs.getString(3)%> name="time" readonly></td>
										<td><input type="text" value=<%=rs.getString(4)%> name="txt"></td>
											<input type="hidden" value=<%=userid%> name="userid">
										<td>
											<input type="submit" name="reviewUpdateButton" value="modify"> / <input type="submit" name="reviewUpdateButton" value="delete">
										</td>
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