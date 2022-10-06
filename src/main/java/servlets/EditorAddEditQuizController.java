package servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.fasterxml.jackson.databind.ObjectMapper;

import mypackage.Question;
import mypackage.Answer;
import mypackage.User;
import mypackage.Quiz;
import mypackage.QuizDaoAbstract;
import mypackage.QuizDaoClass;
import mypackage.QuestionDaoAbstract;
import mypackage.QuestionDaoClass;
import mypackage.AnswerDaoAbstract;
import mypackage.AnswerDaoClass;

/**
 * Servlet implementation class EditorEditQuizController
 */
@WebServlet(name = "rest/editor/quizzes/*", urlPatterns = { "/rest/editor/quizzes/*" })
public class EditorAddEditQuizController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ObjectMapper objectMapper;
	QuizDaoAbstract QuizDaoAbstract = null;
	QuestionDaoAbstract QuestionDaoAbstract = null;
	AnswerDaoAbstract AnswerDaoAbstract = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditorAddEditQuizController() {
        super();
        QuizDaoAbstract = new QuizDaoClass();
    	QuestionDaoAbstract = new QuestionDaoClass();
    	AnswerDaoAbstract = new AnswerDaoClass();
        objectMapper = new ObjectMapper();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String path = request.getPathInfo();
		 if (path != null) {
			String json = null;
			try {
				if (path.equals("/list")) {
					json = getList();
				} else {
					int id = Integer.parseInt(request.getParameter("id"));
					json = getById(id);
                }
			} catch (Exception e) {
				e.printStackTrace();
			}
			 if (json == null) {
	               response.sendError(404);  
            }
            response.getWriter().append(json);
		 }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String body = request.getReader().lines().collect(Collectors.joining());
		Quiz quiz = objectMapper.readValue(body, Quiz.class);
		System.out.println("kviz: " + quiz.toString());
		HttpSession session = request.getSession(false);
		quiz.setCreator(((User)session.getAttribute("user")).getUserName());
		QuizDaoAbstract.save(quiz);
		int quizID = getLastQuizID();
		System.out.print("ID: " + quizID);
		int questID;
		for(Question question: quiz.getQuestions()) {
			System.out.println(question.getText());
			QuestionDaoAbstract.save(question, quizID);
			
			questID = getLastQuestionID(quizID);
			System.out.println("questID: " + questID);
			for(Answer answer:question.getAnswers()) {	
				AnswerDaoAbstract.save(answer, quizID, questID);
				System.out.println(answer.getAnswText());
				System.out.println(quizID + " " + questID);
			}
		}
		response.setStatus(200);
	}
	
	
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String body = request.getReader().lines().collect(Collectors.joining());
		Quiz quiz = objectMapper.readValue(body, Quiz.class);
		System.out.println("BODYYYYYY: " + body );
		
		try {
			int quizID = Integer.parseInt(request.getParameter("id"));
			List<Question> oldQ = QuestionDaoAbstract.get(quizID);
			int oldQsize = oldQ.size();
			int questID;
			QuizDaoAbstract.update(quiz, quizID);
			for(Question question: quiz.getQuestions()) {
				questID = question.getQuestId();
				List<Answer> oldA = AnswerDaoAbstract.get(questID, quizID);
				int oldAsize = oldA.size();
				QuestionDaoAbstract.update(question, questID);
				for(Answer answer: question.getAnswers()) {
					AnswerDaoAbstract.update(answer, answer.getAnswId());
				}
				
				//post new answers
				for(int i = oldAsize; i < question.getAnswers().size(); ++i) {
					AnswerDaoAbstract.save(question.getAnswers().get(i), quizID, questID);
				}
			}
			// post new questions in quiz
			for(int i = oldQsize; i < quiz.getQuestions().size(); ++i) {
				QuestionDaoAbstract.save(quiz.getQuestions().get(i), quizID);		
			}
			
		  response.setStatus(200);
    	} catch(Exception e) {
		  e.printStackTrace();  
    	}
	}

	String getById(int id) throws Exception {
		 try {
		 Quiz quiz = QuizDaoAbstract.getQuiz(id);
		 if (quiz == null) {
           return null;  
	     }
		 System.out.println(objectMapper.writeValueAsString(quiz));
	     return objectMapper.writeValueAsString(quiz);
		 } catch(Exception e) {
			e.printStackTrace();
			return null;
		 }
	 }
	
	String getList() throws Exception {
		 try {
		 List<Quiz> quizes = QuizDaoAbstract.get();
		 if (quizes == null) {
          return null;  
	     }
	     return objectMapper.writeValueAsString(quizes);
		 } catch(Exception e) {
			e.printStackTrace();
			return null;
		 }
	}
	
	int getLastQuizID() {
		List<Quiz> quizzes = QuizDaoAbstract.get();
		int size = quizzes.size();
		return quizzes.get(size-1).getId();
	}
	
	int getLastQuestionID(int quizID) {
		List<Question> quests = QuestionDaoAbstract.get(quizID);
		int sizee = quests.size();
		return quests.get(sizee-1).getQuestId();
	}

	@Override
	protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String body = req.getReader().lines().collect(Collectors.joining());
		System.out.println("BODI: " + body);
		Question question = objectMapper.readValue(body, Question.class);
		System.out.println("DELETING questiond: " + question.getQuestId());
		QuestionDaoAbstract.delete(question, question.getQuestId());
	}
	
}
