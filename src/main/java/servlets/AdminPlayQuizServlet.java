package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;

import mypackage.*;
/**
 * Servlet implementation class PlayQuizServlet
 */
@WebServlet(name = "admin/quizzes/quizpin/play/*", urlPatterns = { "/admin/quizzes/quizpin/play/*" })
public class AdminPlayQuizServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    RequestDispatcher dispatcher = null;
    QuizDaoAbstract QuizDaoAbstract = null;
    InboxDaoAbstract InboxDaoAbstract = null;
	private ObjectMapper objectMapper;

       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminPlayQuizServlet() {
        QuizDaoAbstract = new QuizDaoClass();
		objectMapper = new ObjectMapper();
		InboxDaoAbstract = new InboxDaoClass() ;

    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer id = getIdFromPath(request.getPathInfo());
    	Quiz quiz = QuizDaoAbstract.getQuiz(id);
		List<Inbox> inbox = (List<Inbox>)InboxDaoAbstract.getInboxesForQuiz(id);

    	
		request.setAttribute("quizJson", objectMapper.writeValueAsString(quiz));		
		request.setAttribute("quiz", quiz);
		request.setAttribute("quizId", id);
		request.setAttribute("inbox", inbox);
		
		
		dispatcher = request.getRequestDispatcher("/adminPlayQuiz.jsp");
		dispatcher.forward(request, response);
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	
	Integer getIdFromPath(String path) {
		if (path == null) {
			return null;
		}
		return Integer.parseInt(path.substring(1));
	}
	
	
	
}
