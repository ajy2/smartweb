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
	<h2>INPUT NEW FOOD DATA</h2>
	<form action="bookInsert" method="post">
		 <ul>
		 	<li><b>PRODUCTID: </b><input type="text" name="productId"></li>
		 	<li><b>FOODNAME: </b><input type="text" name="name"></li>
		 	<li><b>PRICE: </b><input type="text" name="price"></li>
		 </ul>
		 <input type="submit" value="입력완료">
	</form>
</body>
</html>