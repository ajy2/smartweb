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
@WebServlet("/insertReview")
public class insertReview extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public insertReview() {
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
		Connection con = null;
		try{
			String dbURL = "jdbc:mysql://localhost:3306/food";
			String dbUser = "food";
			String dbPass = "ghwns233";
			
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(dbURL, dbUser, dbPass);
			String productId = request.getParameter("hiddenvalue");
			String profileName = request.getParameter("profileName");
			String helpfulness = request.getParameter("helpfulness");
			String score = request.getParameter("score");
			float float_score=Float.parseFloat(score);
			String summary = request.getParameter("summary");
			String txt = request.getParameter("txt");
			
			query = "insert into review(productId, userid, profileName, helpfulness, score, time, summary, txt) values(?, '', ?, ?, ?, NOW(), ?, ?)";
			
			PreparedStatement stmt = con.prepareStatement(query);
			stmt.setString(1, productId);
			stmt.setString(2, profileName);
			stmt.setString(3, helpfulness);
			stmt.setFloat(4, float_score);
			stmt.setString(5, summary);
			stmt.setString(6, txt);
			
			int resultCnt = stmt.executeUpdate();

			if(resultCnt > 0) {
				request.setAttribute("code", productId);
				RequestDispatcher dispatcher = request.getRequestDispatcher("bookInfo.jsp?");
				dispatcher.forward(request, response);
			}
			con.close();
			stmt.close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}

}

