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
 * Servlet implementation class EditorInboxServlet
 */
@WebServlet(name = "editor/inbox/*", urlPatterns = { "/editor/inbox/*" })
public class EditorInboxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	QuizDaoAbstract QuizDaoAbstract = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditorInboxServlet() {
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
		request.getRequestDispatcher("/editorQuizInbox.jsp").forward(request, response);
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

