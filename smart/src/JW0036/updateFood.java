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
 * Servlet implementation class updateFood
 */
@WebServlet("/updateFood")
public class updateFood extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public updateFood() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

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
			query = "update product set name = ?, price = ? where productId=?";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1, request.getParameter("name"));
			pstmt.setString(2, request.getParameter("price"));
			pstmt.setString(3, request.getParameter("productId"));
			int resultCnt = pstmt.executeUpdate();
			
			if(resultCnt > 0) {
				RequestDispatcher dispatcher = request.getRequestDispatcher("foodList.jsp");
				dispatcher.forward(request, response);
			}
			con.close();
			pstmt.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}

}
