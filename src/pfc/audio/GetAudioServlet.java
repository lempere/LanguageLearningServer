package pfc.audio;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import pfc.Global;
import pfc.render.audio.DTWGraphicRender;
import pfc.web.DAOBuilder;
import pfc.web.Entities.Audio;

import com.musicg.wave.Wave;


public class GetAudioServlet extends HttpServlet {

	/**
	 *
	 */
	private static final long serialVersionUID = 1L;
	private static final String folder_path =  Global.folder_path;	//"/home/cripto/Programas/WS_pfc/LanguageLearningServer/";
	//private String record_path;
	private String lastNameFile;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetAudioServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 * 	Read and transmit the audio
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String userName = (String) session.getAttribute("user");
		
		if(userName == null) userName = "johnDow";
		System.out.println("Get for Audio" );
		Date date = new Date();
		lastNameFile= Global.path + userName+"_"+ date.toString()+ ".wav";
		System.out.println("Folder for recods: " +lastNameFile );
		File file = new File(Global.path +userName);
		
		if(!file.exists()){
			System.out.println("The audio file is not here, maybe in the moon?" );
			return;
		}

		InputStream in = new FileInputStream(file);
		response.setHeader("Content-Length", String.valueOf(file.length()));
		response.setContentType("audio/x-wav");
		ServletOutputStream out = response.getOutputStream();

			byte[] buffer = new byte[1024];
			int len;
			while( (len = in.read(buffer)) != -1)
				out.write(buffer,0,len);

		out.close();
		in.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("resource")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String length = request.getHeader("content-length");

		HttpSession session = request.getSession();
		String userName = (String) session.getAttribute("user");
		if(userName == null) userName = "johnDow";
		String audioFile = userName;
		int l = request.getContentLength();
		
		System.out.println("Header size " + length + " " +l);
		File file = new File(folder_path + audioFile);
		InputStream in =  request.getInputStream();
		OutputStream out = new FileOutputStream(file);

		if(l<1){
			System.out.println("I don't have audio, do you have microphone? Is a cheap device."+l);
			return;
		}

		byte[] buffer = new byte[1024];
		int len;
		while( (len = in.read(buffer)) != -1){
			out.write(buffer,0,len);			
		}
		in.close();
		out.close();
		

		//Get information about what is processed?
		String idAudio = (String) request.getParameter("audio");
		System.out.println( " Audio id: " + idAudio ) ;
		if(idAudio != null){
			
			session.setAttribute("processing", "true");
			float score = processAudio(idAudio, folder_path + audioFile );
			session.setAttribute("score", score);
			
			if(score > 0.0f){
				if (file.length() == 0 )// sreadLine()) == null ) 
				{
					System.out.println("File is empty doen't receive the data.");
					return;
				}
				//Process graphics video
				Wave w = new Wave(folder_path + audioFile +".wav" );
				DTWGraphicRender g = new DTWGraphicRender();
				g.renderWaveform(w, 0.001f, folder_path+"img_audio/" + audioFile +".jpg");
				session.setAttribute("audio_imgUrl", "/img_audio/" + audioFile +".jpg");
			}
		}



	}
	


	private float processAudio(String id, String recordFile ){
		Audio a = DAOBuilder.getAudioId(id);		
		ExecuteCommands runDTW = new ExecuteCommands();
		float score = runDTW.dwtFile(a, recordFile);
		return score;
	}
}
