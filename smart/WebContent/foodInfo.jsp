<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<title>음식 정보</title>
	</head>

	<body>
		<h2>FOOD INFO</h2>	<input type="button" value="홈으로 이동" onclick="location.href='bookList.jsp'"/>
		<form action="updateReview" method="post">
			 <ul>
				<%	request.setCharacterEncoding("EUC-KR");
					String name="", price="", query="";
					float average = 0, sum=0, score=0;
					int count = 0;
					Connection con = null;
					ResultSet rs = null, rs2 = null;
					PreparedStatement pstmt = null;
					String code = request.getParameter("code");
					String redirected_code=(String)request.getAttribute("code");
					
					if(code==null){
						code=redirected_code;
					}

					try{
						String dbURL = "jdbc:mysql://localhost:3306/food";
						String dbUser = "food";
						String dbPass = "ghwns233";

						Class.forName("com.mysql.jdbc.Driver");
						con = DriverManager.getConnection(dbURL, dbUser, dbPass);

						query = "select name, price from product where productId=? or productId=?";
						pstmt = con.prepareStatement(query);
						pstmt.setString(1, code);
						pstmt.setString(2, redirected_code);
						rs= pstmt.executeQuery();

						query = "select userid, score, time, txt from review where productId=? or productId=?";
						pstmt = con.prepareStatement(query);
						pstmt.setString(1, code);
						pstmt.setString(2, redirected_code);
						rs2= pstmt.executeQuery();
						
						while(rs.next()){
							name = rs.getString(1);
							price = rs.getString(2);
						}
						
						while(rs2.next()){
							score = Float.parseFloat(rs2.getString(2));
							sum = sum + score;
							count ++;
						}
						average = sum/(float)count;
						rs2.first();

					}catch(Exception e){
						e.printStackTrace();
					}%>
				<table border="1" width = "320px">
					<tr><td><b>PRODUCTID : </b></td><td style="text-align:center"><%=code%></td></tr>
					<tr><td><b>FOODNAME : </b></td><td style="text-align:center"><%=name%></td></tr>
					<tr><td><b>PRICE : </b></td><td style="text-align:center"><%=price%></td></tr>
					<tr><td><b>AVERAGE : </b></td><td style="text-align:center"><%=average%></td></tr>
					<tr><td><b>NUMBER OF REVIEW : </b></td><td style="text-align:center"><%=count%></td></tr>
			 	</table>
				<li>
					<table border="1">
						<tr style="text-align:center"><th>userid</th><th width="50px">score</th><th width="100px">date</th><th>text</th></tr>
						<%	String userid = (String)session.getAttribute("userid");
						
							String duplicateCheckFlag="";
							while(rs2.next()){%>
								<tr>
								<%if(rs2.getString(1).equals(userid)){%>
										<td style="text-align:center"><input type="text" name="userid" value=<%=rs2.getString(1)%> readonly></td>
										<td style="text-align:center"><input type="text" name="score" value=<%=rs2.getString(2)%>></td>
										<td style="text-align:center"><%=rs2.getString(3)%></td>
										<td><input type="text" name="txt" value=<%=rs2.getString(4)%>></td>
										<input type='hidden' name='productId' value=<%=code%>><input type='hidden' name='fromfoodInfo' value='t'>
										<td><input type="submit" name="reviewUpdateButton" value="modify"> / <input type="submit" name="reviewUpdateButton" value="delete"></td>
								<%}else{%>
									<td style="text-align:center"><%=rs2.getString(1)%></td>
									<td style="text-align:center"><%=rs2.getString(2)%></td>
									<td style="text-align:center"><%=rs2.getString(3)%></td>
									<td><%=rs2.getString(4)%></td>
								</tr>
								<%} %>
						<%String temp=rs2.getString(1);
							if(temp.equals(userid)){
								duplicateCheckFlag="1";
							}
						}
						con.close();
						pstmt.close();
						rs.close();
						rs2.close();%>
					</table>
				</li>
				</ul>
			</form>
			<form action="insertReview" method="post">
				<%if(userid != null){%>
							<table border='1'>
								<tr>
									<td>userid : </td><td><input type='textarea' name='userid' value=<%=userid%> readonly></td>
								</tr>
								<tr>
									<td>score : </td><td><select name='score'>
															<option value='0'>0</option>
															<option value='1'>1</option>
															<option value='2'>2</option>
															<option value='3'>3</option>
															<option value='4'>4</option>
															<option value='5'>5</option>
														</select></td>
								</tr>
								<tr>
									<td>summary : </td><td><input type='textarea' name='summary'></td>
								</tr>
								<tr>
									<td>text : </td><td><input type='textarea' name='txt'></td>
								</tr>
							</table>
							<input type='hidden' name='productId' value=<%=code%>>
							<input type='hidden' name='duplicateCheckFlag' value=<%=duplicateCheckFlag%>>
							<input type='submit' value='제출'>
				<%}%>
			</form>
	</body>
</html>
