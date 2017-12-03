package JW0036;

import java.io.IOException;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class userController
 */
@WebServlet("/userController")
public class userController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public userController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String requestURI = request.getRequestURI();
		if(requestURI.endsWith("list")){
			showUserList(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String actionType= "";
		actionType = request.getParameter("actionType");
		String url = "";
		if(actionType.equals("register")){
			url = registerUser(request);
			response.sendRedirect(url);
		}else if(actionType.equals("modify")){
			url = modifyUser(request);
			response.sendRedirect(url);
		}else if(actionType.equals("modifyUser")){
			url = modifyUser1(request);
			response.sendRedirect(url);
		}else if(actionType.equals("delete")){
			url = deleteUser(request);
			response.sendRedirect(url);
		}else if(actionType.equals("cookie")){
			url = cookCookie(request);
			response.sendRedirect(url);
		}
	}
	
	private String registerUser(HttpServletRequest request){
		String url = "";
		String userid = request.getParameter("userid");
		String passwd = request.getParameter("passwd");
		String email = request.getParameter("email");
		
		int flag = 0;
		flag = userDB.checkUserAvail(userid, email);
		if(flag > 0){
			url = "/registerError.jsp";
		}else{
			User user = new User();
			
			user.setUserid(userid);
			user.setPasswd(passwd);
			user.setEmail(email);
			if(userDB.insertUser(user)){
				url = "/listUsers.jsp";
			}
		}
		return url;
	}
	
	private String modifyUser(HttpServletRequest request){
		String url = "";
		String userid = "";
		userid = request.getParameter("userid");
		if(userid == null) {
			HttpSession ses = request.getSession();
			userid = (String)ses.getAttribute("userid");
		}
		User user = new User();
		user.setUserid(userid);
		user.setPasswd(request.getParameter("passwd"));
		user.setEmail(request.getParameter("email"));
		int flag = 0;
		flag = userDB.modifyUser(user);
		if(flag > 0){
			url = "/smart/listUsers.jsp";
		}
		return url;
	}
	
	private String modifyUser1(HttpServletRequest request){
		String url = "";
		String userid = "";
		String oldPasswd = "";
		
		userid = request.getParameter("userid");
		if(userid == null) {
			HttpSession ses = request.getSession();
			userid = (String)ses.getAttribute("userid");
		}
		
		oldPasswd = request.getParameter("oldPasswd");
		if(userDB.checkUserPasswd(userid, oldPasswd) == 1) {
			
			User user = new User();
			user.setUserid(userid);
			user.setPasswd(request.getParameter("passwd"));
			user.setEmail(request.getParameter("email"));
			int flag = 0;
			flag = userDB.modifyUser(user);
			if(flag > 0){
				url = "bookList.jsp";
			}
		}else {
			url = "/smart/userInfoMgmt.jsp";
		}
		return url;
	}
	
	private String deleteUser(HttpServletRequest request){
		String url = "";
		String userid = request.getParameter("userid");
		int flag = 0;
		flag = userDB.deleteUser(userid);
		if(flag > 0){
			url = "/smart/listUsers.jsp";
		}
		return url;
	}
	
	private String cookCookie(HttpServletRequest request){
		String url = "";
		String userid = request.getParameter("userid");
		String passwd = request.getParameter("passwd");
		
		int flag = 0;
		flag = userDB.checkUserPasswd(userid, passwd);
		if(flag > 0){
			url = "../pattern2/CookieMemberLoginOK.jsp?userid="+userid;
		}else{
			url = "../pattern2/CookieLoginError.jsp";
		}
		return url;
	}
	
	private void showUserList(HttpServletRequest request, HttpServletResponse response) throws ServletException{
		response.setContentType("text/html");
		System.out.println("test");
		try{
			ArrayList<User> users = userDB.showUsers();
			request.setAttribute("users", users);
			System.out.println(users.size());
			RequestDispatcher rd = request.getRequestDispatcher("../listUsers_JSTL.jsp");
			rd.forward(request, response);
		}catch(Exception e){
			throw new ServletException(e);
		}
	}
}