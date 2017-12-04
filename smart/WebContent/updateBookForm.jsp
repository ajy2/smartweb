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
	<h2>수정하고자하는 제목, 저자, 가격, 출판일을 입력하세요.</h2>
	<form action="updateBook" method="post">
		 <ul>
<%
				String code = request.getParameter("code");
				String productId = "";
				String name = "";
				String price = "";
				String query = "";
				
				Connection con = null;
				try{
					String dbURL = "jdbc:mysql://localhost:3306/food";
					String dbUser = "food";
					String dbPass = "ghwns233";
					
					Class.forName("com.mysql.jdbc.Driver");
					con = DriverManager.getConnection(dbURL, dbUser, dbPass);
					
					query = "select name, price from product where productId=?";
					PreparedStatement pstmt = con.prepareStatement(query);
					pstmt.setString(1, code);
					ResultSet rs= pstmt.executeQuery();
					while(rs.next()){
						name = rs.getString(1);
						price = rs.getString(2);
					}
					
					con.close();
					//stmt.close();
					pstmt.close();
					rs.close();
				}catch(Exception e){
					e.printStackTrace();
				}		
%>
		 	<li><b>PRODUCTID : </b><input type="text" name="productId" value="<%=code%>" readonly></li>
		 	<li><b>FOODNAME : </b><input type="text" name="name" value="<%=name%>"></li>
		 	<li><b>PRICE : </b><input type="text" name="price" value="<%=price%>"></li>
		 </ul>
		 <input type="submit" value="입력완료">
	</form>
</body>
</html>