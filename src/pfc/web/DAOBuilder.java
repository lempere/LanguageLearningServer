package pfc.web;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

import pfc.web.Entities.Audio;
import pfc.web.Entities.Chapter;
import pfc.web.Entities.Course;
import pfc.web.Entities.UserData;

public class DAOBuilder {

	public static ResultSet getCourses_text(String query){
		/*
		try{
    		DAO dao = new DAO();
    		ResultSet result =  dao.executeQuery(query);
    		dao.desconnectarBD();
    		return result;
    	}
    	catch(SQLException sql_e){ System.out.print("Problemas con la base de datos;");sql_e.printStackTrace(); }
    	catch (Exception e) {
    		System.out.print("SQL drivers problems;");
			e.printStackTrace();
		}
    	*/
        return null;
	}
	public static UserData getUser(String nick){
		try {    		
    		DAO dao = new DAO();
    		UserData user = dao.getAllInformationAbout(nick);
    		dao.desconnectarBD();
    		return user;
		} catch (SQLException e) {
			System.err.println("Error en el formato de vuelta DB");
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
    	return null;
	}
	public static void updateUser(UserData user){
		try {    		
    		DAO dao = new DAO();
    		dao.executarUpdateSQL("UPDATE Users SET name='"+user.getName()+"', lastname='"+user.getLastName()+"', gender='"+user.getGender()+"', date='"+user.getData()+"'," +
        			" mail='"+user.getEmail()+"', experience='"+user.getExperience()+"', nick='"+user.getUserName()+"', more_information='"+user.getMoreInfo()+"' WHERE nick='"+user.getUserName()+"';");;
    		dao.desconnectarBD();    		
		} catch (SQLException e) {
			System.err.println("Error en el formato de vuelta DB");
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}    	
	}
	 public static HashMap< Integer, Course> getCourses() {	
    	HashMap< Integer, Course> course = null;
    	try {
    		
    		DAO dao = new DAO();
    		ResultSet result = dao.executarSQL("Select id_courses,name,level FROM Courses");
    		course = new HashMap<Integer, Course>();
			while(result.next())
			{
				Course c = new Course();
				c.setId_courses(result.getInt("id_courses"));
				c.setCourseName(result.getString("name"));
				c.setLevel(result.getString("level"));
				course.put(c.getId_courses(), c);
			}
			result = dao.executarSQL("Select c.id_courses, id_matriculat, name,level FROM Courses as c, Matriculat as m WHERE c.id_courses=m.id_courses ;");
			while(result.next())
			{
				Integer course_matriculat = result.getInt("id_courses");
				course.get(course_matriculat).setMatriculat(true);
			}
			
			dao.desconnectarBD();
		} catch (SQLException e) {
			System.err.println("Error en el formato de vuelta DB");
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
    	return course;
    }
	 public static void signupCourse(String user,String id_courses){
	
		 try {	    		
	    		DAO dao = new DAO();
	    		dao.executarUpdateSQL("INSERT INTO Matriculat (nick,id_courses ) VALUES('"+user+"','"+id_courses+"'); ");
				dao.desconnectarBD();
			} catch (SQLException e) {
				System.err.println("Error en el formato de vuelta DB");
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}	 
	 }
	 public static HashMap< Integer, Course> getChaptersFromCourse(String id_course) {	
	    	HashMap< Integer, Course> chapters = null;
	    	try {
	    		
	    		DAO dao = new DAO();
	    		ResultSet result = dao.executarSQL("Select c.id_chapters,name,level FROM Chapters as c, Courses_Tiene as t Where t.id_courses='"+id_course+"' && t.id_chapters=c.id_chapters;");
	    		chapters = new HashMap<Integer, Course>();
				while(result.next())
				{
					Chapter c = new Chapter();
					c.setId_courses(result.getInt("id_chapters"));
					c.setCourseName(result.getString("name"));
					c.setLevel(result.getString("level"));
					chapters.put(c.getId_courses(), c);
				}
				dao.desconnectarBD();
			} catch (SQLException e) {
				System.err.println("Error en el formato de vuelta DB");
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
	    	return chapters;
	    }
	 public static HashMap< Integer, Audio> getAudioFromChapter(String id_chapter) {	
	    	HashMap< Integer, Audio> audios = null;
	    	try {
	    		
	    		DAO dao = new DAO();
	    		ResultSet result = dao.executarSQL("Select a.id_phrases, phrases, file_path from Phrases as a, Compost as com Where a.id_phrases=com.id_phrases && com.id_chapters='"+id_chapter+"' ;");
	    		audios = new HashMap<Integer, Audio>();
				while(result.next())
				{
					Audio a = new Audio();
					a.setId_audio(result.getInt("id_phrases"));
					a.setText(result.getString("phrases"));
					a.setSrc(result.getString("file_path"));
					audios.put((Integer)a.getId_audio(), a);
				}
				dao.desconnectarBD();
			} catch (SQLException e) {
				System.err.println("Error en el formato de vuelta DB");
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
	    	return audios;
	    }
	 
	 public static Audio getAudioId(String id_audio) {	
			Audio a = null;
	    	try {	    	
	    		DAO dao = new DAO();
	    		ResultSet result = dao.executarSQL("Select a.id_phrases, phrases, file_path from Phrases as a Where a.id_phrases='"+id_audio+"' ;");
	    		
				while(result.next())
				{
					a = new Audio();
					a.setId_audio(result.getInt("id_phrases"));
					a.setText(result.getString("phrases"));
					a.setSrc(result.getString("file_path"));					
				}
				dao.desconnectarBD();
			} catch (SQLException e) {
				System.err.println("Error en el formato de vuelta DB");
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
	    	return a;
	    }
	 
}
