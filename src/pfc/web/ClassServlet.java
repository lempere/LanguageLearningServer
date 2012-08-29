package pfc.web;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import pfc.web.Entities.Audio;
import pfc.web.Entities.UserData;

/**
 * Servlet implementation class ClassServlet
 */
public class ClassServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ClassServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sessio = request.getSession();
		String id_user =(String) sessio.getAttribute("user");
		String chapter =(String) request.getParameter("id_chapters");
		
		System.out.println("Get user: "+ id_user);
		if(id_user == null ) { System.err.println("No agafa be el ide_user"); return;}
		UserData data = DAOBuilder.getUser(id_user);
		if(data == null ) { System.err.println("Dades de user no estan be"); return;}
		if(data.getExperience().equals("0")){
			data.setExperience("1");
			DAOBuilder.updateUser(data);
		}
		//if(id_user==null) response.sendRedirect("./index.jsp");
		HashMap< Integer, Audio> audios = DAOBuilder.getAudioFromChapter(chapter);
		sessio.setAttribute("audios", audios);
		sessio.setAttribute("titol", "class");
		//sessio.setAttribute("microphone", "true");
		sessio.setAttribute("microphone", "false");
		response.sendRedirect("./SelectorPage.jsp");
	}

}
