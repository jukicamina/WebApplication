package servlets;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import mypackage.*;
/**
 * Servlet implementation class DeleteUserServlet
 */
@WebServlet(name = "admin/users/deleteUser", urlPatterns = { "/admin/users/deleteUser" })
public class DeleteUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    RequestDispatcher dispatcher = null;
    String userName;

	UserDaoAbstract UserDaoAbstract = null;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DeleteUserServlet() {
		super();
		UserDaoAbstract = new UserDaoClass();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		userName = request.getParameter("username");
		request.setAttribute("userName", userName);
		dispatcher = request.getRequestDispatcher("/deleteUser.jsp");
		dispatcher.forward(request, response);		
		
		//UserDaoAbstract.delete(userName);
		//response.sendRedirect("/RI601-projekat-aminajukic-lejlahrustic/admin/users");
		//dispatcher = request.getRequestDispatcher("/deleteUser.jsp");
		//dispatcher.forward(request, response);

	}


protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	System.out.print("Dosao sam da brisem");
	UserDaoAbstract.delete(userName);
	response.sendRedirect("/RI601-projekat-aminajukic-lejlahrustic/admin/users");
}
	
	

	Integer getIdFromPath(String path) {
		if (path == null) {
			return null;
		}
		return Integer.parseInt(path.substring(1));
	}
	
}

