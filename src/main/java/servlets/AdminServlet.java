package servlets;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import mypackage.UserDaoAbstract;
import mypackage.UserDaoClass;
/**
 * Servlet implementation class AdminServlet
 */
@WebServlet(name = "admin", urlPatterns = { "/admin" })
public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	RequestDispatcher dispatcher = null;
	UserDaoAbstract UserDaoAbstract = null;
//	VideoDaoAbstract VideoDaoAbstract = null;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminServlet() {
		super();
		UserDaoAbstract = new UserDaoClass();
//		VideoDaoAbstract = new VideoDaoClass();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		dispatcher = request.getRequestDispatcher("/admin.jsp");
		dispatcher.forward(request, response);
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		String user = session.getAttribute("user").toString();
		//System.out.println("USER: " + user);
		if(!user.contains("admin")) {
			String errorMessage = "You don't have permission to access this page. Super admins only.";
			request.setAttribute("err", errorMessage);
			dispatcher = request.getRequestDispatcher("/admin.jsp");
			dispatcher.forward(request, response);
		} else {
			request.getSession().setAttribute("user", user);
			//response.sendRedirect("/RI601-projekat-aminajukic-lejlahrustic/admin/users");
		}
	}
	
}

