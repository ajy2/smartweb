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
 * Servlet implementation class foodInsert
 */
@WebServlet("/foodInsert")
public class foodInsert extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public foodInsert() {
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
			String productId = request.getParameter("productId");
			String name = request.getParameter("name");
			String price = request.getParameter("price");
			
			query = "insert into product(productId, name, price) values(?, ?, ?)";
			
			PreparedStatement stmt = con.prepareStatement(query);
			stmt.setString(1, productId);
			stmt.setString(2, name);
			stmt.setString(3, price);
			
			int resultCnt = stmt.executeUpdate();

			if(resultCnt > 0) {
				//RequestDispatcher dispatcher = request.getRequestDispatcher("foodList.jsp");
				//dispatcher.forward(request, response);
				response.sendRedirect("foodList.jsp");
			}
			con.close();
			stmt.close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}

}

