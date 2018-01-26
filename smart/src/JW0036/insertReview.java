package JW0036;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.*;

/**
 * Servlet implementation class foodInsert
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
		String productId = request.getParameter("productId");
		String dbURL = "jdbc:mysql://localhost:3306/food";
		String dbUser = "food";
		String dbPass = "ghwns233";
		String userid=request.getParameter("userid");
		float score = Float.parseFloat(request.getParameter("score"));
		String summary = request.getParameter("summary");
		String txt = request.getParameter("txt");
		//String duplicateCheckFlag = request.getParameter("duplicateCheckFlag");
		HttpSession session = request.getSession();
		String duplicateCheckFlag=(String)session.getAttribute("duplicateCheckFlag");
		
		if(!"1".equals(duplicateCheckFlag)) {
			try{
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(dbURL, dbUser, dbPass);
				
					query = "insert into review(productId, userid, profileName, score, time, summary, txt) values(?, ?, '', ?, NOW(), ?, ?)";
					
					PreparedStatement stmt = con.prepareStatement(query);
					stmt.setString(1, productId);
					stmt.setString(2, userid);
					stmt.setFloat(3, score);
					stmt.setString(4, summary);
					stmt.setString(5, txt);
					
					int resultCnt = stmt.executeUpdate();
		
					if(resultCnt > 0) {
						request.setAttribute("code", productId);
						session.setAttribute("duplicateCheckFlag","1");
						RequestDispatcher dispatcher = request.getRequestDispatcher("foodInfo.jsp");
						dispatcher.forward(request, response);
					}
					con.close();
					stmt.close();
				
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		else {
			PrintWriter out=response.getWriter();
			out.println("<script>alert('∞Ê∞Ì√¢!');</script>");
			request.setAttribute("code", productId);
			RequestDispatcher dispatcher = request.getRequestDispatcher("foodInfo.jsp");
			dispatcher.forward(request, response);
			out.flush();
			out.close();
		}
	}
}

