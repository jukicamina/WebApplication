package servlets;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import mypackage.QuizDaoAbstract;
import mypackage.QuizDaoClass;


/**
 * Servlet implementation class HomePageServlet
 */
@WebServlet(name = "home", urlPatterns = { "/home" })
public class HomePageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	RequestDispatcher dispatcher = null;
	QuizDaoAbstract QuizDaoAbstract = null;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public HomePageServlet() {
        super();
        QuizDaoAbstract = new QuizDaoClass();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		dispatcher = request.getRequestDispatcher("/index.jsp");
		dispatcher.forward(request, response);
	}

	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}