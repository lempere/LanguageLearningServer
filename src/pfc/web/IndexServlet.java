package pfc.web;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class IndexServlet
 */
public class IndexServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IndexServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sessio = request.getSession();
		sessio.setAttribute("titol", "principal");
		response.sendRedirect("./Index.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sessio = request.getSession();
		
		String tria = request.getParameter("data");
		if ( tria == null)
			doGet(request,response);
		
		if(tria.equals("Index"))
			tria = "principal";
		if(tria.equals("Registrar"))
			tria = "registre";
		if(tria.equals("Login"))
			tria = "benvingut";
		
		sessio.setAttribute("titol", tria);
		response.sendRedirect("./Index.jsp");
	}

}
