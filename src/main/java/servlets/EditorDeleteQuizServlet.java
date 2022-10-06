package servlets;


import java.io.IOException;
import mypackage.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import mypackage.QuizDaoAbstract;
import mypackage.QuizDaoClass;
/**
 * Servlet implementation class EditorDeleteQuizServlet
 */
@WebServlet(name = "editor/quizzes/deleteQuiz", urlPatterns = { "/editor/quizzes/deleteQuiz" })
public class EditorDeleteQuizServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	QuizDaoAbstract QuizDaoAbstract = null;
    RequestDispatcher dispatcher = null;

	int id;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditorDeleteQuizServlet() {
    	QuizDaoAbstract = new QuizDaoClass();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		id = Integer.parseInt(request.getParameter("id"));
		Quiz quiz = QuizDaoAbstract.getQuiz(id);
		request.setAttribute("quiz", quiz);

		dispatcher = request.getRequestDispatcher("/editorDeleteQuiz.jsp");
		dispatcher.forward(request, response);		

		//QuizDaoAbstract.delete(id);
		//response.sendRedirect("/RI601-projekat-aminajukic-lejlahrustic/editor/quizzes");
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//System.out.print("Dosao sam da brisem kviz");
		QuizDaoAbstract.delete(id);
		response.sendRedirect("/RI601-projekat-aminajukic-lejlahrustic/editor/quizzes");
	}

}