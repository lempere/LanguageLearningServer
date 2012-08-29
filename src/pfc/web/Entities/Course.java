package pfc.web.Entities;

import org.apache.catalina.ha.session.SerializablePrincipal;

public class Course extends SerializablePrincipal{

	/**
	 * 
	 */
	private static final long serialVersionUID = 2L;
	
	int id_courses;
	public int getId_courses() {
		return id_courses;
	}
	public void setId_courses(int id_courses) {
		this.id_courses = id_courses;
	}
	String Courses;
	String level;
	boolean matriculat;
	
	public String getCoursesName() {
		return Courses;
	}
	public void setCourseName(String courses) {
		Courses = courses;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public boolean isMatriculat() {
		return matriculat;
	}
	public void setMatriculat(boolean matriculat) {
		this.matriculat = matriculat;
	}
	
}
