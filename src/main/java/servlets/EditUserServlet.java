package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mypackage.*;

/**
 * Servlet implementation class EditUserServlet
 */
@WebServlet(name = "admin/users/editUser", urlPatterns = { "/admin/users/editUser" })
public class EditUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	UserDaoAbstract UserDaoAbstract = null;
	RoleDaoAbstract RoleDaoAbstract = null;
	String userName_ = null;
	public static Boolean al = false;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public EditUserServlet() {
		super();
		UserDaoAbstract = new UserDaoClass();
		RoleDaoAbstract = new RoleDaoClass();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		String userName = request.getParameter("username");
		userName_ = userName;
		
		System.out.println(request.getAttribute("err"));
		String err = "";
		if(request.getAttribute("err") != null) {
			err = request.getAttribute("err").toString();
			userName_ = request.getAttribute("userName").toString();
			
		
		}
		response.setContentType("text/html");
		String css1 = "<link rel='stylesheet' type='text/css' href='/RI601-projekat-aminajukic-lejlahrustic/admin.css'>";
		String css2 = "<link rel='stylesheet' type='text/css' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css'>";
		String css3 ="<link rel=\"stylesheet\" type=\"text/css\" href=\"https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.css\">";
		PrintWriter out = response.getWriter();
		out.println("<html style='background:#f5deb8;'>");
		out.println("<head><title>Quiz game</title>" + css1 + css2 + css3 + "</head>");
		out.println("<body style='margin: 0px; padding: 0px; background:#f5deb3;'>");
		out.print("<header style='padding:10px'>");
		out.print("<nav>");
		out.println("<button class=\"ui massive animated button\" tabindex=\"0\" onclick=\"location.href='/RI601-projekat-aminajukic-lejlahrustic/admin/users'\"\n"
				+ "	style=\"color:indianred; background:#f5deb8;\">\n"
				+ "			<div class=\"hidden content\">Back</div>\n"
				+ "			<div class=\"visible content\">\n"
				+ "			<i class =\"left arrow icon\"></i>\n"
				+ "			</button>");
		out.print("</nav>");
		out.println("</header>");
		User user = UserDaoAbstract.get(userName_);
		List<Role> roles = RoleDaoAbstract.getRoles();
		System.out.println("roles size: " + roles.size());
		out.print("<div class=\"ui form error\">");
		out.print("<main style='width:32%; text-align:center; margin-top:10%;'>");
		out.println("<h2 style='font-size:30px; color:bisque;'>Edit user information</h2>");
		/*out.print("<form action='/RI601-projekat-aminajukic-lejlahrustic/signup' method='post'>");
		
		out.print("<div class=\"field\">");
		out.print("<select class='user outline icon'  name='role'  >");
		out.print("<i class=\"filter icon\"></i>");
		out.print("<option value='-1' selected>Choose your role</option>");
		for (Role role : roles) {
			if (!(role.getRole()).equals("Choose your role"))
				out.print("<option value='" + role.getId() + "'>" + role.getRole() + "</option>");
		}

		out.print("</select></div>");

		out.print("<a href='/RI601-projekat-aminajukic-lejlahrustic/home'>"
				+ "<button type='submit' style='color:indianred; font-family: \\\"Lucida Console\\\", \\\"Courier New\\\", monospace; font-size: 30px; border-radius: 10px; margin-left:30%; width:35%; margin-top:5%; background:#f5deb3; box-shadow: 3px 3px 6px 3px #f5deb2; border: none; padding: 2%; cursor:pointer;'>"
				+ "Save" + "</a></button>");
		
		out.print("</div>");

		out.print("</form>");
		if(!err.equals("")) {
		out.print("<p id='err'>"+err+"</p>");
		}
		out.print("</div>");
		out.println("</main>");
		out.println("</form>");
		out.println("</body></html>");

		out.close();*/
		out.print("<form action='/RI601-projekat-aminajukic-lejlahrustic/admin/users/editUser' method='post'>");
		out.print("<table id='edit'>");
		out.print("<tr><div class='ui fluid left icon input'><i class='envelope icon'></i><input type='text' autocomplete=\"off\" placeholder='Username' name='username' value='" + user.getUserName() +"'</div></tr>");
		out.print("<div style='padding:5px;'>");
		out.print("<tr><div class='ui fluid left icon input'><i class='lock icon'></i><input type='text' autocomplete=\"off\" placeholder='Password' name='password' value='" + user.getPassword() + "' </div></tr>");
		out.print("</div>");
		out.print("<div style='padding:5px;'>");
		
		String roleUser = user.checkRole(user.getRole());
		System.out.println("role" + roleUser);
		out.print("<tr>" + "<select class='user outline icon'  name='role'  >");
		out.print("<option value='" + user.getRole() +  "'selected>" + (roleUser) + "</option>");
		
		for (Role role : roles) {
			if (!(role.getRole()).equals(roleUser))
				out.print("<option value='" + role.getId() + "'>" + role.getRole() + "</option>");
		}
		out.print("</div>");
		out.print("</select></tr>");
		out.print("<tr><button type='submit' style=' font-family: \"Lucida Console\", \"Courier New\", monospace; width:30px; font-size: 30px; display: block; color: indianred; border-radius: 10px; margin-left:30%; width:35%; margin-top:5%; background:#f5deb3; box-shadow: 3px 5px 6px 5px ; border: #f5deb4; padding: 2%; cursor:pointer'>Save</button>");
		out.print("<a href='/RI601-projekat-aminajukic-lejlahrustic/admin/users'>");
		out.print("</table>");
		out.print("</form>");
		if(!err.equals("")) {
		out.print("<p id='err' style='color:indianred; text-align:center'>"+err+"</p>");
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
		int role = Integer.parseInt(request.getParameter("role"));
		
		if (userName.equals("") || password.equals("") || (role<=0)) {
			String errorMessage = "Please fill in all the fields.";
			request.setAttribute("err", errorMessage);
			request.setAttribute("userName", userName);
			doGet(request, response);
		} else {
			User userAccount = new User(userName, password, role);
			UserDaoAbstract.update(userAccount, userName_);
			response.sendRedirect("/RI601-projekat-aminajukic-lejlahrustic/admin/users");
				}
		}

}
