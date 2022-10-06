package servlets;


import java.io.IOException;
import java.util.stream.Collectors;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;

import mypackage.Answer;
import mypackage.AnswerDaoAbstract;
import mypackage.AnswerDaoClass;
import mypackage.Question;
import mypackage.QuestionDaoAbstract;
import mypackage.QuestionDaoClass;
import mypackage.QuizDaoAbstract;
import mypackage.QuizDaoClass;
/**
 * Servlet implementation class DeleteAnswerController
 */
@WebServlet(name = "rest/admin/answers/*", urlPatterns = { "/rest/admin/answers/*" })
public class DeleteAnswerController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ObjectMapper objectMapper;
	AnswerDaoAbstract AnswerDaoAbstract = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteAnswerController() {
    	AnswerDaoAbstract = new AnswerDaoClass();
        objectMapper = new ObjectMapper();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

	@Override
	protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String body = req.getReader().lines().collect(Collectors.joining());
		System.out.println("BODI: " + body);
		Answer answer = objectMapper.readValue(body, Answer.class);
		System.out.println("DELETING answ: " + answer.getAnswId());
		AnswerDaoAbstract.delete(answer.getAnswId());
	}
}