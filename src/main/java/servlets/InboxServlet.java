package servlets;


import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import mypackage.Quiz;
import mypackage.QuizDaoAbstract;
import mypackage.QuizDaoClass;
/**
 * Servlet implementation class InboxServlet
 */
@WebServlet(name = "admin/inbox/*", urlPatterns = { "/admin/inbox/*" })
public class InboxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	QuizDaoAbstract QuizDaoAbstract = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InboxServlet() {
        super();
        QuizDaoAbstract = new QuizDaoClass();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int quizId = getIdFromPath(request.getPathInfo());
		Quiz quiz = QuizDaoAbstract.getQuiz(quizId);
		request.setAttribute("quiz", quiz);
		request.getRequestDispatcher("/quizInbox.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	Integer getIdFromPath(String path) {
		if (path == null) {
			return null;
		}
		return Integer.parseInt(path.substring(1));
	}

}

