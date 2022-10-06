package filters;

import jakarta.servlet.http.HttpFilter;
import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class LogoutFilter
 */
@WebFilter(filterName = "admin/*", urlPatterns = { "/admin/*" })
public class LogoutFilter implements Filter {
       
    /**
     * @see HttpFilter#HttpFilter()
     */
    public LogoutFilter() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        String loginURI = req.getContextPath() + "/login";

        // System.out.println(loginURI);

        boolean loggedIn = session != null && session.getAttribute("user") != null;
        boolean loginRequest = req.getRequestURI().equals(loginURI);
        
        if (loggedIn || loginRequest) {
            chain.doFilter(req, res);
        } else {
            res.sendRedirect(loginURI);
        }
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
