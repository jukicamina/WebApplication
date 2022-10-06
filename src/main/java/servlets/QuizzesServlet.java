package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import mypackage.Quiz;
import mypackage.QuizDaoAbstract;
import mypackage.QuizDaoClass;
import mypackage.User;
/**
 * Servlet implementation class QuizzesServlet
 */
@WebServlet(name = "admin/quizzes", urlPatterns = { "/admin/quizzes" })
public class QuizzesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	QuizDaoAbstract QuizDaoAbstract = null;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QuizzesServlet() {
        QuizDaoAbstract = new QuizDaoClass();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		String css1 = "<link rel='stylesheet' type='text/css' href='/RI601-projekat-aminajukic-lejlahrustic/admin.css'>";
		String css2 = "<link rel='stylesheet' type='text/css' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css'>";
		String css3 ="<link rel=\"stylesheet\" type=\"text/css\" href=\"https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.css\">";
		PrintWriter out = response.getWriter();
		out.println("<html style=\"background: #f5deb3;\">");
		out.println("<head><title>Quiz game</title>" + css1 + css2 + css3 + "</head>");
		out.println("<body style='margin: 0px; padding: 0px; background:#f5deb3;'>");		
		out.print("<header style='padding:10px;'>");
		out.print("<nav>");
		out.println("<button class=\"ui massive animated button\" tabindex=\"0\" onclick=\"location.href='/RI601-projekat-aminajukic-lejlahrustic/admin'\"\n"
				+ "	style=\"color:indianred; background:#f5deb8;\">\n"
				+ "			<div class=\"hidden content\">Back</div>\n"
				+ "			<div class=\"visible content\">\n"
				+ "			<i class =\"left arrow icon\"></i>\n"
				+ "			</button>");
		out.println("<button class=\"ui massive animated button\" tabindex=\"0\" onclick=\"location.href='/RI601-projekat-aminajukic-lejlahrustic/admin/quizzes/addQuiz'\"\n"
				+ "	style='color:indianred; background:#f5deb8;'>\n"
				+ "			<div class=\"hidden content\">Add quiz</div>\n"
				+ "			<div class=\"visible content\">\n"
				+ "			<i class =\"plus icon\"></i>\n"
				+ "			</button>");		
		out.println("<button class=\"ui massive animated button\" tabindex=\"0\" onclick=\"location.href='/RI601-projekat-aminajukic-lejlahrustic/logout'\"\n"
				+ "	style=\"color:indianred; background:#f5deb8;\">\n"
				+ "			<div class=\"hidden content\">Logout</div>\n"
				+ "			<div class=\"visible content\">\n"
				+ "			<i class =\"sign-out alternate icon\"></i>\n"
				+ "			</button>");

		out.print("</nav>");
		out.print("</header>");

		HttpSession session = request.getSession(false);
		Object userObject = session.getAttribute("user");
		User user = (User)userObject;
		System.out.println("USER admin servlet: " + user);
		
		List<Quiz> allQuizzes = QuizDaoAbstract.get();
		List<Quiz> quizzesForCreator = QuizDaoAbstract.getQuizzesforCreator(user.getUserName());
		System.out.println("list size admin servlet: " + quizzesForCreator.size());

		out.print("<main>");
		out.println("<h2 style='font-size:30px; margin-top:5px; color:bisque;'>List of quizzes</h2>");
		out.print("<table width='100%' border='2' ");
		out.print("<tr style=\"color:indianred; background-color: bisque;\"><th>Quiz name</th><th>PIN</th><th>Edit</th><th>Delete</th><th>Inbox</th><th>Host Game</th></tr>");
		String roleStr = user.checkRole(user.getRole());
		if(roleStr.contains("admin")) {
			for (Quiz quiz : allQuizzes) {
		
						out.print("<tr><td style='color:indianred; text-align:center;'><div>" + quiz.getTitle() + "</div></td> "
						+ "<td style='color:indianred; text-align:center;'><div>" + quiz.getDescription() + "</div></td>"
						+ "<td style='height: 50px; color:indianred; text-align:center'; text-align:center; ><a href='/RI601-projekat-aminajukic-lejlahrustic/admin/quizzes/editQuiz?id=" + quiz.getId() + "'>"
						+ "<i style='color:indianred; font-weight:bold' class='fa fa-edit'></i>"
						+ "</a></td><td style='height: 50px; color:indianred; text-align:center';><a href='/RI601-projekat-aminajukic-lejlahrustic/admin/quizzes/deleteQuiz?id="+ quiz.getId() + "'>" + "<i style='color:indianred' class='fa fa-trash'></i>" + "</a></td>"
						+ "<td style='height: 50px; text-align:center; color:indianred;'><a href='/RI601-projekat-aminajukic-lejlahrustic/admin/inbox/"
						+ quiz.getId() + "'>" + "<i style='color:indianred' class='fa fa-inbox'></i>" + "</a></td>"
						+ "<td style='height: 50px; color:indianred; text-align:center';><a href='/RI601-projekat-aminajukic-lejlahrustic/admin/quizzes/quizpin?id=" + quiz.getId() + "'>"
						+ "<i style='color:indianred' class='fa fa-play'></i></a></td></tr>");
					}
		}
		out.print("</table>");
		out.print("</main>");
		out.print("</div>");
		out.println("</body></html>");

		out.close();
	}

}