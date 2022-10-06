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
import jakarta.servlet.http.HttpSession;

import com.fasterxml.jackson.databind.ObjectMapper;

import mypackage.*;
/**
 * Servlet implementation class PlayQuizServlet
 */
@WebServlet(name = "play/*", urlPatterns = { "/play/*" })
public class PlayQuizServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    RequestDispatcher dispatcher = null;
    QuizDaoAbstract QuizDaoAbstract = null;
	private ObjectMapper objectMapper;
	WebSockGameServlet game = null;
	Inbox inbox = new Inbox();

       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PlayQuizServlet() {
        QuizDaoAbstract = new QuizDaoClass();
		objectMapper = new ObjectMapper();  
		game = new WebSockGameServlet();


    }
    
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer id = getIdFromPath(request.getPathInfo());
    	Quiz quiz = QuizDaoAbstract.getQuiz(id);
    	
		String firstName = (String) this.getServletContext().getAttribute("firstName");
		String lastName = (String) this.getServletContext().getAttribute("lastName");

    	
    	
    	/*HttpSession session = request.getSession(); 
		String firstName = (String) session.getAttribute("firstName");
		String lastName = (String)session.getAttribute("lastName");
*/

		request.setAttribute("quizJson", objectMapper.writeValueAsString(quiz));		
		request.setAttribute("quiz", quiz);
		request.setAttribute("quizId", id);
        this.getServletContext().setAttribute("firstName", firstName);
		this.getServletContext().setAttribute("lastName", lastName);

		//session.setAttribute("firstName", firstName);
		//session.setAttribute("lastName", lastName);

		//System.out.println(this.getServletConfig().getServletContext().getAttribute("firstName"));
		//System.out.println(request.getServletContext().getAttribute("firstName"));
		dispatcher = this.getServletContext().getRequestDispatcher("/playOneQuiz.jsp");
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
