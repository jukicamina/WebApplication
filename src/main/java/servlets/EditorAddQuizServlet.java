package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.stream.Collectors;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import mypackage.Question;
import mypackage.Quiz;
import mypackage.QuizDaoAbstract;
import mypackage.QuizDaoClass;
import mypackage.User;

import com.fasterxml.jackson.databind.ObjectMapper;


/**
 * Servlet implementation class EditorAddQuizServlet
 */
@WebServlet(name = "editor/quizzes/addQuiz", urlPatterns = { "/editor/quizzes/addQuiz" })
public class EditorAddQuizServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	RequestDispatcher dispatcher = null;
	QuizDaoAbstract QuizDaoAbstract = null;
	private ObjectMapper objectMapper;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public EditorAddQuizServlet() {
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
			Integer id = null;
				request.setAttribute("quiz", null);
				request.setAttribute("quizJson", "{id: null, questions: []}");

		} catch (Exception e) {
			e.printStackTrace();
		}
		request.getRequestDispatcher("/editorsEditQuiz.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		String body = request.getReader().lines().collect(Collectors.joining());
//		Quiz quiz = objectMapper.readValue(body, Quiz.class);
//		for(Question question: quiz.getQuestions()) {
//			question.setQuizId(quiz.getId());
//		}
//		HttpSession session = request.getSession(false);
//		quiz.setCreator((User)session.getAttribute("user"));
//		QuizDaoAbstract.save(quiz);
//		response.setStatus(200);
		doGet(request, response);
	}

}
