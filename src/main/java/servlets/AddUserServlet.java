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
import mypackage.*;

/**
 * Servlet implementation class SignupServlet
 */
@WebServlet(name = "admin/users/addUser", urlPatterns = { "/admin/users/addUser" })
public class AddUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	UserDaoAbstract UserDaoAbstract = null;
	RoleDaoAbstract RoleDaoAbstract = null;
	String userName_ = null;
	RequestDispatcher dispatcher = null;
	public static Boolean al1 = false;
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddUserServlet() {
		super();
		UserDaoAbstract = new UserDaoClass();
		RoleDaoAbstract = new RoleDaoClass();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		System.out.println(request.getAttribute("err"));
		String err = "";
		if(request.getAttribute("err") != null) {
			err = request.getAttribute("err").toString();
		}
		response.setContentType("text/html");
		String css1 = "<link rel='stylesheet' type='text/css' href='/RI601-projekat-aminajukic-lejlahrustic/admin.css'>";
		String css2 = "<link rel='stylesheet' type='text/css' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css'>";
		String css3 ="<link rel=\"stylesheet\" type=\"text/css\" href=\"https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.css\">";
		PrintWriter out = response.getWriter();
		out.println("<html style='background:#f5deb8;'>");
		out.println("<head><title>Quiz game</title>" + css1 + css2 + css3 + "</head>");
		out.println("<body style='margin: 0px; padding: 0px; background:#f5deb3;'>");
		out.print("<header style='padding: 10px;'>");
		out.print("<nav>");
		out.println("<button class=\"ui massive animated button\" tabindex=\"0\" onclick=\"location.href='/RI601-projekat-aminajukic-lejlahrustic/admin/users'\"\n"
				+ "	style=\"color:indianred; background:#f5deb8;\">\n"
				+ "			<div class=\"hidden content\">Back</div>\n"
				+ "			<div class=\"visible content\">\n"
				+ "			<i class =\"left arrow icon\"></i>\n"
				+ "			</button>");
		out.print("</nav>");
		out.println("</header>");
		String userName = request.getParameter("username");
		userName_ = userName;
		User user = UserDaoAbstract.get(userName);
		List<Role> roles = RoleDaoAbstract.getRoles();
		System.out.println("roles size: " + roles.size());
		out.print("<div class=\"ui form error\">");
		out.print("<main style='width:32%; text-align:center; margin-top:10%;'>");
		out.println("<h2 style='font-size:30px; color:bisque;'>Create new account</h2>");
		out.print("<form action='/RI601-projekat-aminajukic-lejlahrustic/admin/users/addUser' method='post'>");
		out.print("<table id='edit'>");
		out.print("<tr><div class='ui fluid left icon input'><i class='envelope icon'></i><input type='text' autocomplete=\"off\" placeholder='Username' name='username' value='' required</div></tr>");
		out.print("<div style='padding:5px;'>");
		out.print("<tr><div class='ui fluid left icon input'><i class='lock icon'></i><input type='text' autocomplete=\"off\" placeholder='Password' name='password' value='' required</div></tr>");
		out.print("</div>");
		out.print("<div style='padding:5px;'>");
		out.print("<tr>" + "<select class='user outline icon'  name='role'  >");
		out.print("<option value='-1' selected>Choose your role</option>");
		
		for (Role role : roles) {
			if (!(role.getRole()).equals("Choose your role"))
				out.print("<option value='" + role.getId() + "'>" + role.getRole() + "</option>");
		}
		out.print("</div>");
		out.print("</select></tr>");
		out.print("<tr><button type='submit' style=' font-family: \"Lucida Console\", \"Courier New\", monospace; width:30px; font-size: 30px; display: block; color: indianred; border-radius: 10px; margin-left:30%; width:35%; margin-top:5%; background:#f5deb3; box-shadow: 3px 5px 6px 5px ; border: #f5deb4; padding: 2%; cursor:pointer'>Save</button></a>");

		out.print("</table>");
		out.print("</form>");
		if(!err.equals("")) {
		out.print("<p id='err' style='color:bisque; font-weight:bold; font-size:25 px'>"+err+"</p>");
		}
		out.println("</main>");
		out.println("</body></html>");
		out.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		String userName = request.getParameter("username");
		String password = request.getParameter("password");
		List<User> users = UserDaoAbstract.get();
		for(User u : users) {
			if((u.getUserName().equals(userName))) {
				String errorMessage = "Username already exists. Please try again.";
				request.setAttribute("err", errorMessage);
				doGet(request, response);
				return;
				}}

		int role = Integer.parseInt(request.getParameter("role"));
		if (userName.equals("") || password.equals("") || (role <= 0)) {
			String errorMessage = "Please fill in all the fields.";
			request.setAttribute("err", errorMessage);
			doGet(request, response);
		} 
		
		else {
			User newuser = new User(userName, password, role);
			UserDaoAbstract.save(newuser);
			response.sendRedirect("/RI601-projekat-aminajukic-lejlahrustic/admin/users");
				}
		}

}
