package JW0036;

import java.io.*;
import java.sql.*;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * Servlet implementation class bookInsertFile
 */
@WebServlet("/bookInsert1")
public class bookInsertFile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public bookInsertFile() {
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
		String realFolder="";
		String saveFolder="/files";
		String encType="euc-kr";
		int maxSize = 5*1024*1024; //maximum filesize 5MB
		
		String dbURL = "jdbc:mysql://localhost:3306/hojoon";
		String dbUser = "hojoon";
		String dbPass = "ghwns233";
		
		ServletContext context = getServletContext();
		realFolder = context.getRealPath(saveFolder);
		System.out.println(realFolder);
		
		String query = "";
		Connection con = null;
		try {
			MultipartRequest multi = null;
			
			multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
			
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(dbURL, dbUser, dbPass);
			
			query = "insert into bookinfo(bookcode, title, author, publisher, published, genre, price, filename) "
					+"values(?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement stmt = con.prepareStatement(query);
			
			Enumeration<?> params = multi.getParameterNames();
			while(params.hasMoreElements()) {
				String name=(String) params.nextElement();
				String value=multi.getParameter(name);
				switch(name){
		            case "code":  
		            	stmt.setString(1, value); break;
		            case "title":  
		            	stmt.setString(2, value); break;
		            case "author":  
		            	stmt.setString(3, value); break;
		            case "publisher":  
		            	stmt.setString(4, value); break;
		            case "published":  
		            	stmt.setString(5, value); break;
		            case "genre":  
		            	stmt.setString(6, value); break;
		            case "price":  
		            	stmt.setString(7, value); break;
				}
			}
			
			Enumeration<?> files = multi.getFileNames();
			if(files.hasMoreElements()) {
				String name=(String)files.nextElement();
				stmt.setString(8, multi.getFilesystemName(name));
			}
		
			int resultCnt = stmt.executeUpdate();
			if(resultCnt > 0) {
				RequestDispatcher dispatcher = request.getRequestDispatcher("bookList.jsp");
				dispatcher.forward(request, response);
			}
		}catch(IOException ioe) {
			System.out.println(ioe);
		}catch(Exception e) {
			System.out.println(e);
		}
	}
}
