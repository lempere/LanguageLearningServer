<%@page import="edu.cmu.sphinx.demo.aligner.Global"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Class : Language Learning</title>
   <link href="css/Class.css" rel="stylesheet" type="text/css"/>
<%@page import="pfc.web.Entities.Audio"%>
<%@page import="java.util.HashMap"%>

  <script src="js/jquery-1.7.2.min.js"></script>
  <script src="js/Timer.js"></script>
 <script>
 var lastPhrase ;
 function loadScore(){
	 if(lastPhrase == null) return;
	 $.getJSON('\RecordExistScore', function(data) {
		 if(data.score == 0)
			$('#'+lastPhrase).children('#showdata').html("<p>No score available.</p>");				
         if(data.score == "Processing"){
            	$('#'+lastPhrase).children('#showdata').html("<p>Processing...</p>");
        		//Add Timer for reload when the information is processed 
            	CreateTimerEvent(loadScore(),2);
        		return;
          }
          if(data.score != 0){
        	$('#'+lastPhrase).children('#showdata').html("<p>Score: "+data.score+"</p>"
        		+"<img align=\"center\" width=\"650px\" height=\"100px\" src=\""+data.img_url+"\"</img>");

    		//Select next phrase 
    		selectorPhrase(lastPhrase+1);
          }
		
     });
 }
 function selectorPhrase(id){		
		document.getElementById(id).style.background='#FFFFFF';
		idAudio = id;		
		
		if(lastPhrase == null){
			lastPhrase = id;
			return;
		}
		//document.getElementById(lastPhrase).style.background='ghostWhite';
		document.getElementById(lastPhrase).removeAttribute('style');
		//document.getElementById(lastPhrase).onMouseOver = function() { this.className = '.phrase'; } ;   
		document.getElementById(lastPhrase).className = 'phrase';   
		//document.getElementById(lastPhrase).style.hover='yellow'
		lastPhrase = id;
	}
 </script>

</head>
<body>
<% HttpSession sessio = request.getSession();%>
<% String user = (String)sessio.getAttribute("userName");%>
<% String role = (String)sessio.getAttribute("role");%>
<% String userMur = (String)sessio.getAttribute("murName");%>
<% String editar = (String)sessio.getAttribute("adminMur");%>
<% HashMap< Integer, Audio> audios = (HashMap< Integer, Audio>) sessio.getAttribute("audios");%>
	
	  <script>
  window.onload = function(){
	  setupRecorder();
	  firstselect();
  };
	$(document).ready(function(){
	    //attach a jQuery live event to the button
	    $('#getdata-button').live('click', function(){
	        $.getJSON('\RecordExistScore', function(data) {
	            //alert(data); //uncomment this for debug
	            //alert (data.item1+" "+data.item2+" "+data.item3); //further debug 
	            
	            //Need a counter data 
	            if(lastPhrase == null){
	            	$('#showdata').html("<p>Score: "+data.score+"</p>");
	        	
	            }
	            else{
	            	if(data.score == "Processing"){
		            	$('#'+lastPhrase).children('#showdata').html("<p>Processing...</p>");
	            		//Add Timer for reload when the information is processed 
		            	CreateTimerEvent(loadScore(),2);
	            	}
	            	$('#'+lastPhrase).children('#showdata').html("<p>Score: "+data.score+"</p>"
	            		+"<img width=\"650px\" height=\"100px\" src=\""+data.img_url+"\"</img>");}
	        });
	    });
	});
	
	function firstselect(){
	<%if(audios!=null){ %>
		selectorPhrase( <%=audios.keySet().toArray()[0]%> );
		lastPhrase = <%=audios.keySet().toArray()[0]%> ;
	<%}%>
	}
	
  </script>
	
	<% if(audios!=null)
	 for (Audio a : audios.values() ) {
		  %>	 

	<div id="<%=a.getId_audio() %>" class="phrase" style="text-align: left; margin-left: 10em; margin-right: 4em;" onclick="selectorPhrase(<%=a.getId_audio()%>)">
	<FORM ACTION = "Class" METHOD = "POST">

	<p id="phrases-text" ><%=a.getText() %> </p>			
	
		<audio controls="controls">
		  <source src="<%="Audio_Class/ogg/"+a.getNameAudioSrc()%>.ogg" type="audio/ogg" />		 
		  <source src="<%="Audio_Class/"+a.getSrc()%>" type="audio/mp3" />
		  Your browser does not support the audio tag.
		</audio>		 	
		<input TYPE="HIDDEN"  NAME="user" VALUE="<%=user%>"/>
		<input TYPE="HIDDEN"  NAME="id_chapters" VALUE="<%=a.getId_audio()%>" />
		<!-- <INPUT TYPE="SUBMIT"  NAME="editar" VALUE="Practice"/><br-->  
	</FORM>
			
				<div id="showdata"></div>
	<br>
</div>
	<%
	}
if(audios == null){%>
<p> It's like at the moment we don't have any phrases. You can be the first to put one </p>
	
<%} %>
</body>
</html>