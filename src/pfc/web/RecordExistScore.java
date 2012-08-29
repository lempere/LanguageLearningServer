package pfc.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class RecordExistScore
 */
public class RecordExistScore extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RecordExistScore() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sessio = request.getSession();
		String id_user =(String) sessio.getAttribute("user");
		Float score =(Float) sessio.getAttribute("score");
		String img_url = (String) sessio.getAttribute("audio_imgUrl");
		String toProcess = (String) sessio.getAttribute("processing");
		
		System.out.println("UserID: " + id_user + " score " + score);
		String json = "{ \"score\" : \"0\", \"img_url\" : \"You love jQuery4u\", \"item3\" : \"We love jQuery4u\" }";
		if( toProcess != null){
			json = "{ \"score\" : \"Processing\", \"img_url\" : \"You \", \"item3\" : \"We love jQuery4u\" }";
		}
			if(score != 0.0f){			
				json = "{ \"score\" : \""+score+"\", \"img_url\" : \""+img_url+"\", \"item3\" : \"We love jQuery4u\" }";
				sessio.removeAttribute("processing");
			}
		response.setContentType("application/json");		
		PrintWriter out = response.getWriter();
		out.print(json);
		out.flush();
		sessio.setAttribute("score", 0.0f);
		sessio.removeAttribute("audio_imgUrl");
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
