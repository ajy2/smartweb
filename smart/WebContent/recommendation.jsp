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
		<h2>RECOMMENDATION<h2>
		<form action="updateFood" method="post">
			 <ul>
				<%
					request.setCharacterEncoding("EUC-KR");
					String code = request.getParameter("code");
					String redirected_code=(String)request.getAttribute("code");
					String name ="";
					String price="";
					String query = "";
					String cond = "";
					float average1 = 0;
					float count1 = 0;
					float sum1 = 0;
					float average2 = 0;
					float count2 = 0;
					float sum2 = 0;
					float average3 = 0;
					float count3 = 0;
					float sum3 = 0;
					float max = 0;
					float max2 = 0;
					float max3 = 0;

				%>
	
					<table border=1>
						<tr><th>productId</th><th>score</th><th>time</th><th>summary</th><th>txt</th></tr>
	
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
								
								query = "select productId, score, time, summary, txt from review where userid=?";
								PreparedStatement pstmt = con.prepareStatement(query);
								pstmt.setString(1, userid);
								ResultSet rs= pstmt.executeQuery();
								
								while(rs.next()){%>
									<tr>
										<td><input type="text" value=<%=rs.getString(1)%> name="productId" readonly></td>
										<td><input type="text" value=<%=rs.getString(2)%> name="score"></td>
										<td><input type="text" value=<%=rs.getString(3)%> name="time" readonly></td>
										<td><input type="text" value=<%=rs.getString(4)%> name="summary"></td>
										<td><input type="text" value=<%=rs.getString(5)%> name="txt"></td>
										<input type="hidden" value=<%=userid%> name="userid">
									
									</tr>
									
									<% 
									if(rs.getString(1).contains("han")){
										float score = Float.parseFloat(rs.getString(2));
										sum1 = sum1 + score;
										count1 ++;
									}
									if(rs.getString(1).contains("ill")){
										float score2 = Float.parseFloat(rs.getString(2));
										sum2 = sum2 + score2;
										count2 ++;
									}
									if(rs.getString(1).contains("jun")){
										float score3 = Float.parseFloat(rs.getString(2));
										sum3 = sum3 + score3;
										count3 ++;
									}
								
								}
								
								average1 = sum1 / count1 ;
								average2 = sum2 / count2 ;
								average3 = sum3 / count3 ;
								
								 if (average1 >= average2 && average1 >= average3) {
							            max = average1;
							        } else if (average2 >= average1 && average2 >= average3) {
							            max = average2;
							        } else {
							            max = average3;
							        }
								
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
			<%
				if(max == average1){
			%>  <h3>RECOMMENDATION _MENU_1</h3> 
				<li><b>한식 : </b><input type="text" name="average1" value="<%=average1%>" readonly></li>
				<li><b>NUMBER OF REVIEW : </b><input type="text" name="n_review1" value="<%=count1%>" readonly></li>
			<%
				if (average2 > average3) {
	            	max2 = average2;
	            	max3 = average3;
	            	%>
	            	<h3>RECOMMENDATION _MENU_2</h3> 
					<li><b>일식 : </b><input type="text" name="average2" value="<%=average2%>" readonly></li>
					<li><b>NUMBER OF REVIEW : </b><input type="text" name="n_review2" value="<%=count2%>" readonly></li>
					<h3>RECOMMENDATION _MENU_3</h3> 
					<li><b>중식 : </b><input type="text" name="average3" value="<%=average3%>" readonly></li>
					<li><b>NUMBER OF REVIEW : </b><input type="text" name="n_review3" value="<%=count3%>" readonly></li>
					<%
	        	} 
	       	 	 else {
	            	max2 = average3;
	            	max3 = average2;
	            	%>
	            	<h3>RECOMMENDATION _MENU_2</h3> 
					<li><b>중식 : </b><input type="text" name="average3" value="<%=average3%>" readonly></li>
					<li><b>NUMBER OF REVIEW : </b><input type="text" name="n_review3" value="<%=count3%>" readonly></li>
					<h3>RECOMMENDATION _MENU_3</h3> 
					<li><b>일식 : </b><input type="text" name="average2" value="<%=average2%>" readonly></li>
					<li><b>NUMBER OF REVIEW : </b><input type="text" name="n_review2" value="<%=count2%>" readonly></li>
					<%
	        	}
			
			}  
				else if(max == average2){
			%>	<h3>RECOMMENDATION _MENU_1</h3> 
				<li><b>일식 : </b><input type="text" name="average2" value="<%=average2%>" readonly></li>
			    <li><b>NUMBER OF REVIEW : </b><input type="text" name="n_review2" value="<%=count2%>" readonly></li>
			<%
				if (average1 > average3) {
            		max2 = average1;
            		max3 = average3;
            		%>
            		<h3>RECOMMENDATION _MENU_2</h3> 
					<li><b>한식 : </b><input type="text" name="average1" value="<%=average1%>" readonly></li>
					<li><b>NUMBER OF REVIEW : </b><input type="text" name="n_review1" value="<%=count2%>" readonly></li>
					<h3>RECOMMENDATION _MENU_3</h3> 
					<li><b>중식 : </b><input type="text" name="average3" value="<%=average3%>" readonly></li>
					<li><b>NUMBER OF REVIEW : </b><input type="text" name="n_review3" value="<%=count3%>" readonly></li>
					<%
        		} 
       	 	 	else {
            		max2 = average3;
            		max3 = average1;
            		%>
            		<h3>RECOMMENDATION _MENU_2</h3> 
					<li><b>중식 : </b><input type="text" name="average3" value="<%=average3%>" readonly></li>
					<li><b>NUMBER OF REVIEW : </b><input type="text" name="n_review2" value="<%=count3%>" readonly></li>
					<h3>RECOMMENDATION _MENU_3</h3> 
					<li><b>한식 : </b><input type="text" name="average1" value="<%=average1%>" readonly></li>
					<li><b>NUMBER OF REVIEW : </b><input type="text" name="n_review1" value="<%=count1%>" readonly></li>
					<%
        		}
			}
		
				else if(max == average3){
			%>	<h3>RECOMMENDATION _MENU_1</h3> 
				<li><b>중식 : </b><input type="text" name="average3" value="<%=average3%>" readonly></li>
				<li><b>NUMBER OF REVIEW : </b><input type="text" name="n_review3" value="<%=count3%>" readonly></li>
			<%
				if (average1 > average2) {
            		max2 = average1;
            		max3 = average2;
            		%>
            		<h3>RECOMMENDATION _MENU_2</h3> 
					<li><b>한식 : </b><input type="text" name="average1" value="<%=average1%>" readonly></li>
					<li><b>NUMBER OF REVIEW : </b><input type="text" name="n_review1" value="<%=count1%>" readonly></li>
					<h3>RECOMMENDATION _MENU_3</h3> 
					<li><b>일식 : </b><input type="text" name="average3" value="<%=average2%>" readonly></li>
					<li><b>NUMBER OF REVIEW : </b><input type="text" name="n_review2" value="<%=count2%>" readonly></li>
					<%
        		} 
       	 	 	else {
            		max2 = average2;
            		max3 = average1;
            		%>
            		<h3>RECOMMENDATION _MENU_2</h3> 
					<li><b>일식 : </b><input type="text" name="average2" value="<%=average2%>" readonly></li>
					<li><b>NUMBER OF REVIEW : </b><input type="text" name="n_review2" value="<%=count2%>" readonly></li>
					<h3>RECOMMENDATION _MENU_3</h3> 
					<li><b>한식 : </b><input type="text" name="average1" value="<%=average1%>" readonly></li>
					<li><b>NUMBER OF REVIEW : </b><input type="text" name="n_review1" value="<%=count1%>" readonly></li>
					<%
        		}
			}
			
			%>
		

	</body>
</html>
