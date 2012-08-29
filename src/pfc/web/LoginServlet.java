package pfc.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import pfc.web.Entities.UserData;

/**
 * Servlet implementation class LoginServlet
 */
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sessio = request.getSession();
		sessio.setAttribute("titol", "titol");
		//*
		sessio.removeAttribute("role");
		sessio.removeAttribute("adminMur");
		sessio.removeAttribute("murName");
		sessio.removeAttribute("VectorTweets");
		sessio.removeAttribute("data");
		sessio.removeAttribute("dataIncorrecta");
		sessio.removeAttribute("adminUsers");
		sessio.removeAttribute("VectorUsers");
		sessio.removeAttribute("urlAvatar");
		sessio.removeAttribute("userName");  //*/

		response.sendRedirect("./index.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String userName =request.getParameter("user");
		String pass=request.getParameter("pass");
		System.out.println("DataPost "+userName+ " " + pass + "\n");
		HttpSession sessio= request.getSession();

		boolean welcomePage = true;

		if( empty(userName) || empty(pass)){
			errorLogin(request, response);
			return;
		}
		
		sessio.setAttribute("microphone", "true");
		try{
			String type= "usuari";
			DAO dao = new DAO();
			if ( dao.existeixUser(userName, pass) ){
				sessio.setAttribute("titol", "titol");
				UserData usuariDades = dao.getAllInformationAbout(userName);
				sessio.setAttribute("urlAvatar", usuariDades.getPhoto());
				
				if(! usuariDades.getExperience().equals("0") ){
					sessio.setAttribute("titol", "courses");
					welcomePage = false;
					sessio.setAttribute("microphone", "false");
				}
				sessio.setAttribute("score", 0.0f);
			}else{
				errorLogin(request, response);
				return;
			}
			if( dao.isAdmin(userName)){
				System.out.println("Usuari registrat Administrador");
				type = "admin";
			}

			sessio.setAttribute("user", userName);
			sessio.setAttribute("role",type);
			
			
		}catch (Exception e) {
			System.out.print("Problemas con la base de datos;");
			//errorLogin(request, response);
		}
		if(! welcomePage){
			response.sendRedirect("ListCourses");
			return;
		}
		response.sendRedirect("./SelectorPage.jsp");
	}


	private boolean empty(String name){
		if(name==null || name.equals("") )
			return true;
		return false;
	}
	private void errorLogin(HttpServletRequest request, HttpServletResponse response) throws IOException{
		HttpSession sessio= request.getSession();
		sessio.setAttribute("titol", "loginError");
		response.sendRedirect("./index.jsp");

	}
}
