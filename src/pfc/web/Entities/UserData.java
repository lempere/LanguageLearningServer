package pfc.web.Entities;

import javax.servlet.http.HttpServletRequest;


public class UserData {

    private boolean login=false;
    private String userName;
    private String name;
    private String lastName;
    private String gender;
    private String data;
    private String email;
    private String experience;
    private String pass;   
	private String rePass;
    private String moreInfo;
    private String photo;
    
    private String type;
    private boolean isFriend;

    public UserData(){
    	userName="";
	    name="";
	    lastName="";
	    gender="";
	    data="";
	    email="";
	    pass="";
	    rePass="";
	    moreInfo="";
	    photo="";
	    isFriend=false;
    }
    public UserData(HttpServletRequest request){

		setUserName(request.getParameter("userName"));
		setName(request.getParameter("nom"));
		setLastName(request.getParameter("cognom"));
		setGender(request.getParameter("sexe"));
		setData(request.getParameter("data"));
		setEmail(request.getParameter("correuElectronic"));
		setPass(request.getParameter("contrassenya1"));
		setRePass(request.getParameter("contrassenya2"));
		setMoreInfo(request.getParameter("addicional"));
		
    }
    public UserData(String name){
        login=true;
        this.userName=name;
    }
    public boolean getLogin(){
        return login;
    }
    public String getUserName(){
        return userName;
    }
    public void setUserName(String name){
    	this.userName=name;
    }
    public String getName(){
        return name;
    }
    public void setName(String name){
    	this.name=name;
    }
    public String getLastName(){
        return lastName;
    }
    public void setLastName(String name){
    	this.lastName=name;
    }
    public String getGender(){
        return gender;
    }
    public void setGender(String name){
    	this.gender=name;
    }
    public String getData(){
        return data;
    }
    public void setData(String name){
    	this.data=name;
    }
    public String getEmail(){
        return email;
    }
    public void setEmail(String name){
    	this.email=name;
    }
    public String getPass(){
        return pass;
    }
    public void setPass(String name){
    	this.pass=name;
    }
    public String getRePass(){
        return rePass;
    }
    public void setRePass(String name){
    	this.rePass=name;
    }
    public String getMoreInfo(){
        return moreInfo;
    }
    public void setMoreInfo(String name){
    	this.moreInfo=name;
    }
    public String getPhoto(){
        return photo;
    }
    public void setPhoto(String name){
    	this.photo=name;
    }
    public String getType(){
        return type;
    }
    public void setType(String name){
    	this.type=name;
    }   
    public boolean isComplete(){
    	if( userName=="" &&
	    name=="" &&
	    lastName==""&&
	    gender==""&&
	    data==""&&
	    email==""&&
	    pass==""&&
	    rePass==""&&
	    moreInfo==""&&
	    photo=="" )
    		return false;
    	
    	return true;
    	
    }
    
    //if pass the minimum return true
    public boolean correctMintLength(String name, int length){
    	if(name.length() >length )
    		return true;
    	
    	return false;
    }
    //if is less than the max return true
    public boolean correctMaxtLength(String name, int length){
    	if(name.length() < length )
    		return true;
    	
    	return false;
    }
    private boolean correctLength(String name, int length){
    	if(name.length() == length )
    		return true;
    	
    	return false;
    }
    public boolean nameWithNumbers(String name){
    	CharSequence numbers = "0123456789";
    	if ( name.contains(numbers) )
    			return true;
	    return false;
    }
    public boolean stringIsNumeric(String num){
	    try{
	        Integer.parseInt(num);
	    } catch(NumberFormatException nfe) {
	        return false;
	    }
	    return true;
	
    }
    public boolean correctDataFormat(String data){
    	String cad[] = email.split("-");
    	if(cad.length <2)
    		return false;
    	return true;/*
    	try{
    		int dia = Integer.parseInt(cad[0]);
    		int mes = Integer.parseInt(cad[1]);
    		int any = Integer.parseInt(cad[2]);
    		
        	if(dia >0 && dia<31 && 
        			mes >0 && mes<13 &&
        			any >0 && any<31)
            		return true;    		
    	}catch (NumberFormatException nfe ){
			return false;
		}
    	return false;
*/
    }
    public boolean correctEmail(String email){
    	String cad[] = email.split("@");
    	if(cad.length !=2 )
    		return false;
    	String subCad[] = cad[1].split(".");
    	if( subCad.length >1 )
    		return false;
    	
    	return true;
    }
    public boolean isCorrect(){
    	int maxName = 20, minpass=3;
    	
    	if ( correctMintLength(userName, minpass) && 
    	correctMaxtLength(name, maxName) && !nameWithNumbers(name) &&
    	correctMaxtLength(lastName, maxName) && !nameWithNumbers(lastName) &&
    	pass.equals(rePass) && correctMintLength(pass, minpass) && 
    	correctLength(data, 8) && !correctDataFormat(data) &&
    	correctEmail(email) )
    		return true;
    	
    	return false;
    			
    }
    public boolean isCorrectTheChange(){
    	int maxName = 20, minpass=3;
    	
    	if ( correctMintLength(userName, minpass) && 
    	correctMaxtLength(name, maxName) && !nameWithNumbers(name) &&
    	correctMaxtLength(lastName, maxName) && !nameWithNumbers(lastName) &&
    	correctLength(data, 8) && !correctDataFormat(data) &&
    	correctEmail(email) )
    		return true;
    	
    	return false;
    			
    }
    public boolean equalto(UserData user){
    	if ( getUserName().equals(user.getUserName()) &&
    			getName().equals(user.getName()) &&
    			getLastName().equals(user.getLastName()) &&
    			getGender().equals(user.getGender()) &&
    			getData().equals(user.getData()) &&
    			getEmail().equals(user.getEmail()) &&
    			getMoreInfo().equals(user.getMoreInfo()) )
    		return true;
    	
    	return false;
    			
    }
    public boolean isFriend(){
    	return this.isFriend;
    }
    public void friend(){
    	isFriend = true;
    }
    public void noFriend(){
    	isFriend = false;
    }
    public String getExperience() {
		return experience;
	}
	public void setExperience(String experience) {
		this.experience = experience;
	}
}