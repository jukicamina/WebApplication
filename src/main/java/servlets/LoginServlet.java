package servlets;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import mypackage.User;
import mypackage.UserDaoAbstract;
import mypackage.UserDaoClass;
/**
 * Servlet implementation class LoginServlet
 */
@WebServlet(name = "login", urlPatterns = { "/login" })
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	RequestDispatcher dispatcher = null;
	UserDaoAbstract UserDaoAbstract = null;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginServlet() {
		super();
		UserDaoAbstract = new UserDaoClass();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		dispatcher = request.getRequestDispatcher("/login.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String userName = request.getParameter("username");
		String password = request.getParameter("password");

		User user = UserDaoAbstract.get(userName, password);

		if((userName == "") || (password == "")) {
			String errorMessage = "Please fill in all the fields.";
			request.setAttribute("err", errorMessage);
			dispatcher = request.getRequestDispatcher("/login.jsp");
			dispatcher.forward(request, response);
			return;
		}

	
		else if (user == null) {
			String errorMessage = "Your username and password didn't match. Please try again.";
			request.setAttribute("err", errorMessage);
			dispatcher = request.getRequestDispatcher("/login.jsp");
			dispatcher.forward(request, response);

			return;
		}
		int role = user.getRole();
		if (role == 0) {
			request.getSession().setAttribute("user", user);
			response.sendRedirect("/RI601-projekat-aminajukic-lejlahrustic/user");
		} else if(role == 1) {
			request.getSession().setAttribute("user", user);
			response.sendRedirect("/RI601-projekat-aminajukic-lejlahrustic/admin");
		}
		else if(role == 2){
			request.getSession().setAttribute("user", user);
			response.sendRedirect("/RI601-projekat-aminajukic-lejlahrustic/editor");

		}
	}
}
