package servlets;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import mypackage.InboxDaoAbstract;
import mypackage.InboxDaoClass;
import mypackage.Inbox;
/**
 * Servlet implementation class InboxController
 */
@WebServlet(name = "rest/inbox/*", urlPatterns = { "/rest/inbox/*" })
public class InboxController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	InboxDaoAbstract InboxDaoAbstract = null;
	private ObjectMapper objectMapper;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public InboxController() {
		super();
		InboxDaoAbstract = new InboxDaoClass();
		objectMapper = new ObjectMapper();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		 String path = request.getPathInfo();
		 Integer id = getIdFromPath(path);
		 List<Inbox> results = InboxDaoAbstract.getInboxesForQuiz(id);
		 //System.out.println(results.size());
		 //String json = objectMapper.writeValueAsString(results);
		// response.setStatus(200);
		 //response.getWriter().append(json);
		 response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(new Gson().toJson(results));
			
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("INBOX POST");

		String body = request.getReader().lines().collect(Collectors.joining());
		String path = request.getPathInfo();
		if(path.contentEquals("/quizzes")) {
			List<Inbox> inboxes = objectMapper.readValue(body, new TypeReference<List<Inbox>>(){});
			for(Inbox inbox : inboxes) {
				
//				System.out.println(inbox);
				InboxDaoAbstract.save(inbox);
			}
			response.setStatus(200);
		} else {
		Inbox inbox = objectMapper.readValue(body, Inbox.class);
		InboxDaoAbstract.save(inbox);
//		HttpSession session = request.getSession(false);
		response.setStatus(200);
		}
	}

	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("INBOX UPDATE");
		List<Inbox> newInbox;
		String body = request.getReader().lines().collect(Collectors.joining());
		System.out.println(body);

		String path = request.getPathInfo();
		System.out.println(path);

		if(path.contentEquals("/quizzes")) {
			List<Inbox> inboxes = objectMapper.readValue(body, new TypeReference<List<Inbox>>(){});
			for(Inbox inbox : inboxes) {
				
				InboxDaoAbstract.update(inbox);
			}
			
			newInbox = InboxDaoAbstract.getInboxesForQuiz(inboxes.get(0).getQuizId());
			
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(new Gson().toJson(newInbox));
			
			//response.setStatus(200);
		} else {
		Inbox inbox = objectMapper.readValue(body, Inbox.class);
		InboxDaoAbstract.update(inbox);
//		HttpSession session = request.getSession(false);
		newInbox = InboxDaoAbstract.getInboxesForQuiz(inbox.getQuizId());

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(new Gson().toJson(newInbox));

		//response.setStatus(200);
		}
	}
	
	
	

	String getList(int quizId) throws Exception {
		try {
			List<Inbox> inboxes = InboxDaoAbstract.getInboxesForQuiz(quizId);
			if (inboxes == null) {
				return null;
			}
			return objectMapper.writeValueAsString(inboxes);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	int getIdFromPath(String path) {
		return Integer.parseInt(path.substring(1));
	}
}
