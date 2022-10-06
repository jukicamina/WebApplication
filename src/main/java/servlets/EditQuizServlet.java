package servlets;


import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import mypackage.Quiz;
import mypackage.QuizDaoAbstract;
import mypackage.QuizDaoClass;

import com.fasterxml.jackson.databind.ObjectMapper;
/**
 * Servlet implementation class EditQuizServlet
 */
@WebServlet(name = "admin/quizzes/editQuiz", urlPatterns = { "/admin/quizzes/editQuiz" })
public class EditQuizServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	QuizDaoAbstract QuizDaoAbstract = null;
	RequestDispatcher dispatcher = null;
	ObjectMapper objectMapper = null;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public EditQuizServlet() {
		super();
		QuizDaoAbstract = new QuizDaoClass();
		objectMapper = new ObjectMapper();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			int id = Integer.parseInt(request.getParameter("id"));
			Quiz quiz = QuizDaoAbstract.getQuiz(id);
			request.setAttribute("quiz", quiz);
			request.setAttribute("quizJson", objectMapper.writeValueAsString(quiz));
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.getRequestDispatcher("/editQuiz.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	


}