package pfc.web;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import pfc.web.Entities.Course;
import pfc.web.Entities.UserData;

/**
 * Servlet implementation class Courses
 */
public class Courses extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Courses() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*
		 * HttpSession sessio = request.getSession();
		String user = (String) sessio.getAttribute("userName");
		String id_class = (String) sessio.getAttribute("id_course");
		sessio.setAttribute("microphone", "false");
		response.sendRedirect("./SelectorPage.jsp");
		*/
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sessio = request.getSession();
		String id_user =(String) sessio.getAttribute("user");
		String id_courses =(String) request.getParameter("id_courses");
		System.out.println("Get user: "+ id_user +" courses " + id_courses);
		
		if(id_user == null ) { System.err.println("No agafa be el ide_user"); return;}
		UserData data = DAOBuilder.getUser(id_user);
		if(data == null ) { System.err.println("Dades de user no estan be"); return;}
		if(data.getExperience().equals("0")){
			data.setExperience("1");
			DAOBuilder.updateUser(data);
		}
		//if(id_user==null) response.sendRedirect("./index.jsp");
		HashMap< Integer, Course> courses = DAOBuilder.getChaptersFromCourse(id_courses);
		sessio.setAttribute("chapters", courses);
		sessio.setAttribute("titol", "agenda");
		sessio.setAttribute("microphone", "false");
		response.sendRedirect("./SelectorPage.jsp");	
	}

}
