package JW0036;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.*;

/**
 * Servlet implementation class deleteFood
 */
@WebServlet("/deleteFood")
public class deleteFood extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public deleteFood() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String query = "";
		Connection con = null;
		try{
			String dbURL = "jdbc:mysql://localhost:3306/food";
			String dbUser = "food";
			String dbPass = "ghwns233";
			
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(dbURL, dbUser, dbPass);
			
			query = "delete from review where productId=?";
			PreparedStatement pstmt1 = con.prepareStatement(query);
			pstmt1.setString(1, request.getParameter("code"));
			
			
			query = "delete from product where productId=?";
			PreparedStatement pstmt2 = con.prepareStatement(query);
			pstmt2.setString(1, request.getParameter("code"));
			
			
			
			int resultCnt1 = pstmt1.executeUpdate();
			int resultCnt2 = pstmt2.executeUpdate();
			if(resultCnt2 > 0) {
				RequestDispatcher dispatcher = request.getRequestDispatcher("foodList.jsp");
				dispatcher.forward(request, response);
				HttpSession session = request.getSession();
				session.setAttribute("duplicateCheckFlag","");
			}
			con.close();
			pstmt1.close();
			pstmt2.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
