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
<title>음식 정보 공유 사이트</title>
</head>
<body>
	<h2>FOOD</h2>
	<h3>
		<%if(userid != null && !userid.equals("")){ %>
			<%=userid %>회원님 환영합니다.
				<input type="button" value="로그아웃" onclick="location.href='sessionLogout.jsp'"/>
				<input type="button" value="회원정보수정" onclick="location.href='userInfoMgmt.jsp'"/>
				<input type="button" value="리뷰제품확인" onclick="location.href='userReview.jsp'"/>
				<%
					if("admin".equals(userid)){%>
						<input type="button" value="회원관리" onclick="location.href='listUsers.jsp'"/>
						<input type="button" value="새 품목 등록" onclick="location.href='foodInsertForm.jsp'"/>
					<%}
				%>
				
		<%}else{%>
				<input type="button" value="로그인" onclick="location.href='sessionLoginForm.html'"/>
				<input type="button" value="회원가입" onclick="location.href='signUpForm.html'"/>
		<%}%>
	</h3>
	<form action = "foodList.jsp" method="post">
	<ul>
		<li><b>검색 : </b><input type="text" name="search"></li>

		<table style="margin:auto; text-align:center" border="1px">
			<tr>
				<th width="100px">productId</th><th width="70px">name</th><th width="80px">price</th>
			</tr>
			<%		request.setCharacterEncoding("EUC-KR");
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
						while(rs.next()){%>
							<tr>
								<td><%=rs.getString(1)%></td>
								<td><a href="foodInfo.jsp?code=<%=rs.getString(1)%>"><%=rs.getString(2)%></a></td>
								<td><%=rs.getString(3)%></td>
								<%if("admin".equals(userid)){%>
									<td width="60px">
										<a href="updateFoodForm.jsp?code=<%=rs.getString(1)%>">수정</a>/<a href="deleteFood?code=<%=rs.getString(1)%>">삭제</a>
		                        	</td>
								<%}%>
							</tr>
			<%			}
					}catch(Exception e){
						e.printStackTrace();
					}%>
		</table>
	</ul>
	</form>
</body>
</html>