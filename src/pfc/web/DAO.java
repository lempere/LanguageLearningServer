package pfc.web;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import pfc.Global;
import pfc.web.Entities.Course;
import pfc.web.Entities.UserData;

public class DAO {

    private Connection connexio;
    private Statement sentencia;
    private String urlPhoto = "photos/avatar_unknown.png";

    public DAO() throws Exception {

        Class.forName("com.mysql.jdbc.Driver").newInstance();
        connexio = DriverManager.getConnection("jdbc:mysql://127.0.0.1/"+Global.databaseName+"?user="+Global.user+"&password="+Global.password);
        sentencia = connexio.createStatement();
    }
    // Executa consultes
    public ResultSet executarSQL(String query) throws SQLException {
    	return sentencia.executeQuery(query);    	
    }
    //Executa updates
    public int executarUpdateSQL(String query) throws SQLException  {       
        return sentencia.executeUpdate(query);
    }
    public boolean existeixUser(String user, String pass) throws SQLException{
        ResultSet result = executarSQL("SELECT nick FROM Users WHERE nick='"+user+"' && pass='"+pass+"' ;");
        if(!result.first())
            return false;
        return true;
    }
    public void desconnectarBD() throws SQLException {
        sentencia.close();
        connexio.close();
    }
    private void addNewPerson(UserData user,String type) throws SQLException{
    	executarUpdateSQL("INSERT INTO Users (nick ,pass , type, name ,lastname ,gender ,mail,experience, date, more_information, path_photo)" +
    	" VALUES ('"+user.getUserName()+"','"+user.getPass()+"','"+type+"','"+user.getName()+"','"+user.getLastName()+"','"+user.getGender()+"','"+user.getEmail() +"','"+"','"+user.getExperience() +"','"+
    	user.getData()+"','"+ user.getMoreInfo() +"','"+urlPhoto+"');" );
    }
    public void addNewUser(UserData user) throws SQLException{
    	addNewPerson(user,"usuari");
    }
    public void addNewAdmin(UserData user) throws SQLException{
    	addNewPerson(user,"admin");
    }
    public boolean isAdmin(String name) throws SQLException{
    	ResultSet result = executarSQL("SELECT type FROM Users WHERE nick='"+name+"';");
    	if(result.next()){
    		String type = result.getString("type");
    		if( type.equals("admin") )
    			return true;
    	}
    	return false;
    }

    public UserData getAllInformationAbout(String name) throws SQLException{
    	UserData data = new UserData();
    	data.setUserName(name);
    	ResultSet result = executarSQL("SELECT name,pass, lastname,gender,date,mail,experience,more_information,path_photo FROM Users WHERE nick='"+name+"';");
    	if(result.next()){
    		data.setName((String)result.getString("name"));
    		data.setLastName((String)result.getString("lastname"));
    		data.setPass((String)result.getString("pass"));
    		data.setUserName(name);
    		data.setGender((String)result.getString("gender"));
    		data.setData((String)result.getString("date"));
    		data.setEmail((String)result.getString("mail"));
    		data.setExperience((String)result.getString("experience"));
    		data.setMoreInfo((String)result.getString("more_information"));
    		data.setPhoto((String)result.getString("path_photo"));
    	}
    	return data;
    }

    public void updateInformation(UserData user, String name) throws SQLException{
    	executarUpdateSQL("UPDATE Users SET name='"+user.getName()+"', lastname='"+user.getLastName()+"', gender='"+user.getGender()+"', date='"+user.getData()+"'," +
    			" mail='"+user.getEmail()+"', experience='"+user.getExperience()+"', nick='"+user.getUserName()+"', more_information='"+user.getMoreInfo()+"' WHERE nick='"+name+"';");
    	if(name.equals(user.getUserName())==false){
//	    	executarUpdateSQL("UPDATE Tweet SET nick='"+user.getName()+"' WHERE nick='"+name+"';");
//	    	executarUpdateSQL("UPDATE AnswerTweet SET autor='"+user.getName()+"' WHERE autor='"+name+"';");
//	    	executarUpdateSQL("UPDATE Contacts SET nick='"+user.getName()+"' WHERE nick='"+name+"';");
//	    	executarUpdateSQL("UPDATE Contacts SET contact_name='"+user.getName()+"' WHERE contact_name='"+name+"';");
    	}

    }

    protected Vector<UserData> getUsersFromQuery(String query) throws SQLException{
    	ResultSet result = executarSQL(query);
    	Vector<UserData> users = new Vector<UserData>();
    	while(result.next())
    	{
    		UserData userData = new UserData();
    		userData.setUserName(result.getString("nick"));
    		userData.setName(result.getString("name"));
    		userData.setLastName(result.getString("lastname"));
    		userData.setMoreInfo(result.getString("more_information"));
    		userData.setType(result.getString("type"));
    		userData.setPhoto(result.getString("path_photo"));
    		users.add(userData);
    	}
    	return users;
    }
    public Vector<UserData> getUsers(String user) throws SQLException{
    	return getUsersFromQuery("SELECT lastname,name,nick,more_information,type,path_photo FROM Users WHERE nick!='"+user+"' ORDER BY lastname;");
    }
    public Vector<UserData> getUsersContacts(String user) throws SQLException{
    	return getUsersFromQuery("SELECT lastname,name,nick,more_information,type,path_photo FROM Users WHERE nick IN (SELECT contact_name FROM Contacts WHERE nick='"+user+"');");
    }

    public void inserTweet(String user,String missatge, String comentar) throws SQLException{
    	executarUpdateSQL( "INSERT INTO Tweet (nick , text, answer) VALUES ('"+user+"','"+missatge+"','"+comentar+"');");
    }
    //CAUTIN
    public void updateTweet(int id,String user,String missatge, String comentar) throws SQLException{
    	executarUpdateSQL( "UPDATE Tweet SET text = '"+missatge+"', answer = '"+comentar +"'" +
    			" WHERE id_tweet='"+id+"' AND nick='"+user+"';");

    }
    public void updateAnswerTweet(int id,String user,String missatge) throws SQLException{
    	executarUpdateSQL( "UPDATE AnswerTweet SET missatge = '"+missatge+"' WHERE id_comentari='"+id+"' AND autor='"+user+"';");

    }

    public void deleteTweet(int id,String name) throws SQLException{
    	executarUpdateSQL( "DELETE FROM Tweet WHERE id_tweet='"+id+"' AND nick='"+name+"';");
    }
    public void nouComentariTweet(int id,String user,String missatge) throws SQLException{
    	executarUpdateSQL( "INSERT INTO AnswerTweet SET missatge= '"+missatge+"', id_tweet='"+id+"', autor='"+user+"';");

    }
    public void insertContacte(String user, String contacte) throws SQLException
    {
    	executarUpdateSQL("INSERT INTO Contacts (nick, contact_name) VALUES('"+user+"','"+contacte+"');");
    }
    public void deleteContacte(String user, String contacte) throws SQLException
    {
    	executarUpdateSQL("DELETE FROM Contacts WHERE nick='"+user+"' && contact_name='"+contacte+"';");
    }
    public Vector<UserData> getUsersWithContacts(String userName) throws SQLException{
    	Vector<UserData> users = getUsers(userName);
    	Vector<UserData> contacts = getUsersContacts(userName);

    	for( UserData user : users ){
    		for( UserData contact : contacts ){
    			if(user.getUserName().equals(contact.getUserName()))
    				user.friend();
    		}
    	}
    	return users;
    }
    public Vector<UserData> getAllUsers() throws SQLException{
    	return getUsersFromQuery("SELECT lastname,name,nick,more_information,type,path_photo FROM Users ORDER BY lastname; ");
    }

    public void deleteUser(String user) throws SQLException{
    	executarUpdateSQL("DELETE FROM Users WHERE nick='"+user+"';");
    	executarUpdateSQL("DELETE FROM Tweet WHERE nick='"+user+"';");
    	executarUpdateSQL("DELETE FROM AnswerTweet WHERE autor='"+user+"';");
    	executarUpdateSQL("DELETE FROM Contacts WHERE nick='"+user+"';");
    	executarUpdateSQL("DELETE FROM Contacts WHERE contact_name='"+user+"';");
    }

    //Si no hi ha cap usuari retorna true
    public boolean isEmpty() throws SQLException{
    	ResultSet result = executarSQL("SELECT nick FROM Users");

    	return (result.first() == false);
    }
    public void removeTweet(int id, String user) throws SQLException{
    	executarUpdateSQL("DELETE FROM Tweet WHERE id_tweet='"+id+"';");
    	executarUpdateSQL("DELETE FROM AnswerTweet WHERE id_tweet='"+id+"';");
    }
    public void notComentedTweet(int id, String user) throws SQLException{
    	executarUpdateSQL("UPDATE Tweet set answer='No' WHERE id_tweet='"+id+"' AND nick='"+user+"' ;");
    }
    public void comentedTweet(int id, String user) throws SQLException{
    	executarUpdateSQL("UPDATE Tweet set answer='Si' WHERE id_tweet='"+id+"' AND nick='"+user+"' ;");
    }
    public void makeAdmin(String user) throws SQLException{
    	executarUpdateSQL("UPDATE Users set type='admin' WHERE nick='"+user+"' ;");
    }
    public void firedAdmin(String user) throws SQLException{
    	executarUpdateSQL("UPDATE Users set type='usuari' WHERE nick='"+user+"' ;");
    }
    public void blankDB() throws SQLException {
    	executarUpdateSQL("TRUNCATE TABLE Tweet;");
    	executarUpdateSQL("TRUNCATE TABLE AnswerTweet;");
    	executarUpdateSQL("TRUNCATE TABLE Contacts;");
    	executarUpdateSQL("TRUNCATE TABLE Users;");
    }
    
    /*
     * Courses
     */
    public void addNewCourse(Course c) throws SQLException {
    	executarUpdateSQL("INSERT INTO Courses (name ,level)" +
    	" VALUES ('"+c.getCoursesName()+"','"+c.getLevel()+"');" );
    }
   
    
}


