package JW0036;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

/**
 * Servlet implementation class bookInsert
 */
@WebServlet("/updateReview")
public class updateReview extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public updateReview() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("euc-kr");
		response.setContentType("text/html;charset=euc-kr");
		
		String query = "";
		String status = request.getParameter("reviewUpdateButton");
		Connection con = null;
		PreparedStatement stmt = null;
		try{
			String dbURL = "jdbc:mysql://localhost:3306/food";
			String dbUser = "food";
			String dbPass = "ghwns233";
			
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(dbURL, dbUser, dbPass);
			String productId = request.getParameter("productId");
			String userid=request.getParameter("userid");
			String temp=request.getParameter("fromfoodInfo");
			float score = Float.parseFloat(request.getParameter("score"));
			String txt = request.getParameter("txt");

			if("modify".equals(status)) {
				query = "update review set score=?, txt=? where productId=? AND userid=?";
				stmt = con.prepareStatement(query);
				stmt.setFloat(1, score);
				stmt.setString(2, txt);
				stmt.setString(3, productId);
				stmt.setString(4, userid);
			}
			else {
				query = "delete from review where productId=? AND userid=?";
				stmt = con.prepareStatement(query);
				stmt.setString(1, productId);
				stmt.setString(2, userid);
			}

			int resultCnt = stmt.executeUpdate();
			RequestDispatcher dispatcher = null;
			if(resultCnt > 0){
				request.setAttribute("userid", userid);
				if("t".equals(temp)) {
					request.setAttribute("code", productId);
					dispatcher = request.getRequestDispatcher("foodInfo.jsp");
				}
				else {
					dispatcher = request.getRequestDispatcher("userReview.jsp");
				}
				dispatcher.forward(request, response);
			}
			con.close();
			stmt.close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}

}

