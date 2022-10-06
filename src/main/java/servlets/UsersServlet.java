package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import mypackage.*;
import servlets.*;
/**
 * Servlet implementation class UsersServlet
 */
@WebServlet(name = "admin/users", urlPatterns = { "/admin/users" })
public class UsersServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	UserDaoAbstract UserDaoAbstract = null;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UsersServlet() {
		UserDaoAbstract = new UserDaoClass();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		String css1 = "<link rel='stylesheet' type='text/css' href='/RI601-projekat-aminajukic-lejlahrustic/admin.css'>";
		String css2 = "<link rel='stylesheet' type='text/css' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css'>";
		String css3 ="<link rel=\"stylesheet\" type=\"text/css\" href=\"https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.css\">";
		PrintWriter out = response.getWriter();
		out.println("<html style='background:#f5deb8;'>");		
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
		out.println("<button class=\"ui massive animated button\" tabindex=\"0\" onclick=\"location.href='/RI601-projekat-aminajukic-lejlahrustic/admin/users/addUser'\"\n"
				+ "	style='color:indianred; background:#f5deb8;'>\n"
				+ "			<div class=\"hidden content\">Add user</div>\n"
				+ "			<div class=\"visible content\">\n"
				+ "			<i class =\"user plus icon\"></i>\n"
				+ "			</button>");		
		out.println("<button class=\"ui massive animated button\" tabindex=\"0\" onclick=\"location.href='/RI601-projekat-aminajukic-lejlahrustic/logout'\"\n"
				+ "	style=\"color:indianred; background:#f5deb8;\">\n"
				+ "			<div class=\"hidden content\">Logout</div>\n"
				+ "			<div class=\"visible content\">\n"
				+ "			<i class =\"sign-out alternate icon\"></i>\n"
				+ "			</button>");

		out.print("</nav>");
		out.print("</header>");

		List<User> allUsers = UserDaoAbstract.get();

		out.print("<main>");
		out.println("<h2 style='font-size:30px; margin-top:5px; color:bisque;'>List of users</h2>");
		out.print("<table width='100%' border='2'  ");
		out.print("<tr style=\"color:indianred; background-color: bisque;\"><th >Username</th><th>Password</th><th>User roles</th><th>Edit</th><th>Delete</th></tr>");
		for (User user : allUsers) {
			
		
			 out.print("<tr><td style='color:indianred; text-align:center;'><div>" + user.getUserName() + "</div></td><td style='color:indianred; text-align:center;'><div>" + user.getPassword()
			 + "</div></td><td style='color:indianred; text-align:center;'><div>" + user.checkRole(user.getRole())+ "</div></td>"
			 + "<td style='height: 50px; text-align:center; color:indianred;'><a href='/RI601-projekat-aminajukic-lejlahrustic/admin/users/editUser?username=" + user.getUserName() + "'>"
			 + "<i style='color:indianred' class='edit icon'></i>"
			 + "</a></td><td style=\"text-align:center; color:indianred;\"><a href='/RI601-projekat-aminajukic-lejlahrustic/admin/users/deleteUser?username="
			 + user.getUserName() + "'>" + "<i style='color:indianred' class='trash alternate outline icon'></i>" + "</a></td></tr>");
			} 
			

		out.print("</table>");
		out.print("</main>");
		out.print("</div>");

		out.println("</body></html>");

		out.close();
	}
	
	

}
