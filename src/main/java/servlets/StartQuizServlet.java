package servlets;

import java.io.IOException;
import java.util.List;

import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mypackage.QuizDaoAbstract;
import mypackage.QuizDaoClass;
import mypackage.Quiz;
import mypackage.Inbox;
import mypackage.InboxDaoAbstract;
import mypackage.InboxDaoClass;
import servlets.WebSockGameServlet;
/**
 * Servlet implementation class StartQuizServlet
 */
@WebServlet(name = "start/*", urlPatterns = { "/start/*" })
public class StartQuizServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

		RequestDispatcher dispatcher = null;
		QuizDaoAbstract QuizDaoAbstract = null;
		InboxDaoAbstract InboxDaoAbstract = null;
		private ObjectMapper objectMapper;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public StartQuizServlet() {
		super();
		QuizDaoAbstract = new QuizDaoClass();
		InboxDaoAbstract = new InboxDaoClass();
		objectMapper = new ObjectMapper();  



	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		dispatcher = request.getRequestDispatcher("/startQuiz.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		String description_ = request.getParameter("pin");
		String firstName = request.getParameter("firstname");//dobro
		String lastName = request.getParameter("lastname");//dobro
		int score = 0;
		
		//System.out.println(firstName);
		Quiz quiz = QuizDaoAbstract.getQuiz(description_);
		int id = quiz.getId();

		Inbox inbox = new Inbox();
		inbox.setFirstName(firstName);
		inbox.setLastName(lastName);
		inbox.setScore(score);
		inbox.setQuizId(id);
		InboxDaoAbstract.save(inbox);

		request.setAttribute("quiz", quiz);

		
		if (description_ == "" || firstName == "" || lastName == "") {
			String errorMessage = "Please fill in all the fields.";
			request.setAttribute("err", errorMessage);
			dispatcher = request.getRequestDispatcher("/startQuiz.jsp");
			dispatcher.forward(request, response);
			return;
		}
		if(id == 0) {
			String errorMessage = "Quiz with that PIN doesn't exist.";
			request.setAttribute("err", errorMessage);
			dispatcher = request.getRequestDispatcher("/startQuiz.jsp");
			dispatcher.forward(request, response);
			return;
		}
		
		List<Inbox> inbox_ = (List<Inbox>)InboxDaoAbstract.getInboxesForQuiz(id);
		
		request.setAttribute("firstName", firstName);
		request.setAttribute("lastName", lastName);
		request.setAttribute("quizJson", objectMapper.writeValueAsString(quiz));		
		request.setAttribute("quiz", quiz);
		request.setAttribute("quizId", id);
		request.setAttribute("inbox_", inbox_);
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/playOneQuiz.jsp");
		dispatcher.forward(request, response);
		//response.sendRedirect("/RI601-projekat-aminajukic-lejlahrustic/play/" + id);
		
	}
}
