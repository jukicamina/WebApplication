package servlets;


import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mypackage.*;

import mypackage.QuizDaoAbstract;
import mypackage.QuizDaoClass;
/**
 * Servlet implementation class DeleteQuizServlet
 */
@WebServlet(name = "admin/quizzes/deleteQuiz", urlPatterns = { "/admin/quizzes/deleteQuiz" })
public class DeleteQuizServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	QuizDaoAbstract QuizDaoAbstract = null;
    RequestDispatcher dispatcher = null;
    int id;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteQuizServlet() {
    	QuizDaoAbstract = new QuizDaoClass();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		id = Integer.parseInt(request.getParameter("id"));
    	Quiz quiz = QuizDaoAbstract.getQuiz(id);
		request.setAttribute("quiz", quiz);

		dispatcher = request.getRequestDispatcher("/deleteQuiz.jsp");
		dispatcher.forward(request, response);		
		
		
		//QuizDaoAbstract.delete(id);
		//response.sendRedirect("/RI601-projekat-aminajukic-lejlahrustic/admin/quizzes");
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.print("Dosao sam da brisem kviz");
		QuizDaoAbstract.delete(id);
		response.sendRedirect("/RI601-projekat-aminajukic-lejlahrustic/admin/quizzes");
	}

}