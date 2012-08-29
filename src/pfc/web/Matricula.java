package pfc.web;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Matricula
 */
public class Matricula extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Matricula() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest requests, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			
			HttpSession sessio = request.getSession();
			String user = (String) sessio.getAttribute("userName");

			String id_courses = request.getParameter("id_courses");
			//String course_name = request.getParameter("course_name");
//			String role = (String)sessio.getAttribute("role");
			DAOBuilder.signupCourse(user,id_courses);
			response.sendRedirect("./SelectorPage.jsp");
	}

}
