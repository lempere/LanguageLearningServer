<%@page import="edu.cmu.sphinx.frontend.util.Microphone"%>
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

			  <!-- swfobject load local for improve speed -->
			  <script type="text/javascript" src="js/swfobject.js"></script>			
			  <!-- Setup the recorder interface -->
			  <script src="js/recorder-insideBody.js"></script>
			  <!-- GUI code... take it or leave it -->
			  <script type="text/javascript" src="js/gui.js"></script>
			  <script type="text/javascript" src="js/wami-insideBody.js"></script>
			  
  <script src="js/jquery-1.7.2.min.js"></script>
  <script src="js/Audio.js"></script>
  
  
 <script>
 //Wami.js start loadScore and tries = 7 
 var lastPhrase, itAudio, tries = 7, testData, dtw = 0 ;
 function loadScore(){
	 if(lastPhrase == null) return;
	 $.getJSON('\RecordExistScore', function(data) {
		 
		 //if nothing return 
		 if(!data || data == "" ) return;
		 testData = data;
		 if(tries == 0 ){
			 if(dtw){
				 $('#text-item').children('#showdata').html("<p>Dtw can recognise your sound.. please try again.</p>");
			 }else{
				$('#text-item').children('#showdata').html("<p>Not found try again.</p>");
			 }
			 dtw=0;
			
				return;
			}
		 
         if(data.score > 0){
         	$('#text-item').children('#showdata').html("<p>Score: "+ pointScore(data.score)+ " points: " +data.score+"</p>");         	
         	
         	document.getElementById("audioImgUser").style.backgroundImage = "url(\""+data.img_url +"\")";
         	document.getElementById("audioImgUser").style.visibility = 'visible';
         	//
         	player = document.getElementById("audioPlayerUser"); 
         	player.style.visibility = 'visible';
         	player.src = "";
         	player.src = "/img_audio/audio/"+user+".wav";
         	
         	data = null;
         	
     		//Select next phrase 
     		//selectorPhrase(lastPhrase+1);
     		return;
           }
		 
         if(data.score == -2){
        	 $('#text-item').children('#showdata').html("<p>Your sound is too large, try to speak the same length than the original.</p>");
        	 tries=0;
        	 return;
         }
		 if(data.score == -1){
			 hidePlayer();
			 dtw = 1;
			 tries=0;
			 if(tries == 0){
				 $('#text-item').children('#showdata').html("<p>The sound is too different in comparison with the main voice.</p>");
				 return;
			 }
		 }
		 if(data.score == 0 ){
			 string = "<p>Loading.... Try: "+tries+"</p>";
			$('#text-item').children('#showdata').html(string);				
			}				
         if(data.score == "Processing" || data.score == "Warping in progress ..."){
            	$('#text-item').children('#showdata').html("<p>Processing...</p>");
        		//Add Timer for reload when the information is processed             
				
          }
         window.setTimeout("loadScore()", 1500);
 		tries--;
		
     });
 }
 function hidePlayer(){

	document.getElementById("audioImgUser").style.backgroundImage = "";
 	document.getElementById("audioImgUser").style.visibility = 'hidden';
 	//
 	player = document.getElementById("audioPlayerUser"); 
 	player.style.visibility = 'hidden';
 	player.src = "";
 }
 function updateTrackTime(track, id){	  

	  var currTime = track.currentTime; 
	  var duration = track.duration;

	  //currTimeDiv.innerHTML = formatSecondsAsTime(currTime);

	  console.debug("Try ");

	  if (isNaN(duration))
	  	return;

	  var timelapse = currTime / duration;
	  var size = Math.floor(650 * timelapse) ;
 	  id.style.width = size+'px';
	  
	    console.debug(size + " c:" +currTime + " d:"+duration);
	  
	}
 function runCountDown(){
	 player = document.getElementById("audioPhrase"); 
	 var duration = player.duration*2/100;
	 counter = document.getElementById("counter");
	 counter.value +=1;
	 setInterval(runCountDown, duration);
	 
 }
 function pointScore(score){
	 player = document.getElementById("audioPhrase"); 
	 var pointsForDuration = score/player.duration;
	 
	 if(pointsForDuration < 1) pointsForDuration =score/(player.duration+1);
	 console.debug(pointsForDuration);
	 
	 if(pointsForDuration < 30000 ){
		 return "Very Good!!";
	 }
	 if(pointsForDuration < 50000 ){
		 return "Very Good!!";
	 }
	 return "You can do Better, try again.";
 }
 </script>

</head>
<body>
<% HttpSession sessio = request.getSession();%>
<% String user = (String)sessio.getAttribute("user");%>
<% String role = (String)sessio.getAttribute("role");%>
<% String userMur = (String)sessio.getAttribute("murName");%>
<% String editar = (String)sessio.getAttribute("adminMur");%>
<% HashMap< Integer, Audio> audios = (HashMap< Integer, Audio>) sessio.getAttribute("audios");%>
<% String microphone = "false"; %>
	
	  <script>
	  var lengthAudios, arrayAudios, a;
	  var user = "<%=user%>";
  window.onload = function(){
	  setupRecorder();
	  
	  firstselect();
  };

	function firstselect(){
	<%if(audios!=null){ %>
		arrayAudios = [];//new Array();
		
		<%for (Audio a : audios.values() ) {
			%>
			var js_a = new jsAudio();
			js_a.id = <%=a.getId_audio()%>;
			js_a.text = "<%=a.getText()%>";
			js_a.path = "<%=a.getNameAudioSrc()%>";
			arrayAudios.push(js_a);
			<%
		}%>
		lengthAudios = <%=audios.size()%> ;
	<%}%>
		itAudio = 0;
		selectorPhrase(arrayAudios[0].id);
		
	}
	 function selectorPhrase(id){		
			//document.getElementById(id).style.background='#FFFFFF';
			lastPhrase = id;
			
			a = new jsAudio(); 
			a = arrayAudios[itAudio];
			idAudio = a.id;
			//document.getElementById(lastPhrase).style.background='ghostWhite';
			//document.getElementById(lastPhrase).removeAttribute('style');
			//document.getElementById(lastPhrase).onMouseOver = function() { this.className = '.phrase'; } ;   
			//document.getElementById(lastPhrase).className = 'phrase';   
			//document.getElementById(lastPhrase).style.hover='yellow'
			
			//change the elements 
			var t = document.getElementById("phrases-text");
			t.textContent =a.text ;
			var audio = document.getElementById("audioPhrase");			
			audio.src = "/img_audio/Audio_Class/"+a.path +".ogg";
			audio.autoplay = true;
			
			//background-image: url('/img_audio/class_img/'+arraysAudio[itAudio]. +');
					document.getElementById("imgClass").style.backgroundImage = "url(\"/img_audio/class_img/"+a.path +".jpg\")";
			document.getElementById("showdata").innerHTML = "";
			
			itAudio++;
			
			//Hide the player is used in the last phrase 
			hidePlayer();
		}
	
  </script>
	
	<%
	//if(audios!=null)
	// for (Audio a : audios.values() ) {
		  %>	 

	<div id="text-item" class="phrase" style="text-align: left; margin-left: 10em; margin-right: 4em;" >
	<FORM ACTION = "Class" METHOD = "POST">

	<p id="phrases-text" >Hello</p>			
	
	
	<div id="imgClass" style="width: 650px; height: 100px; background-size:650px 100px;" >
       		<div id="audioClass" style="width: 650px; height: 100px; background-color: grey; opacity:0.4; " ></div>
	</div>
		<audio id="audioPhrase" style=" width: 650px;" controls="controls" ontimeupdate="updateTrackTime(this, audioClass);" >		  
		  Your browser does not support the audio tag.
		</audio>		 	
		<input TYPE="HIDDEN"  NAME="user" VALUE="<%=user%>"/>
		  <input TYPE="HIDDEN"  NAME="id_chapters" VALUE="5" />
	</FORM>			
		<div id="showdata"></div>
		
				<div id="audioImgUser" style="width: 650px; height: 100px; background-size:650px 100px; visibility: hidden; " >
       					<div id="audioUser" style="width: 650px; height: 100px; background-color: grey; opacity:0.4; " ></div>
				</div>
				<audio id="audioPlayerUser" controls="controls" style=" width: 650px; visibility: hidden;" autoplay ontimeupdate="updateTrackTime(this, audioUser);" >
      		  	</audio>
	<br>
</div>

<!--  <p style="display: inline-block; float:left; margin-left: 10em;"> Last </p>   class="phrase" --> 
<div style="text-align: left; margin-left: 10em; width: 200px; height: 130px; margin-right: 4em;" >
			
			<!-- At the wami-recorder part you can see more http:/code.google.com/p/wami-recorder -->
	      	<div id="wami-things" style="margin: 0em 25em; ">
		    <div id="recordDiv" style="display:inline-block; margin-left: 28em" ></div>
		  
		    <div id="wami-container" style="float: left; width: 200px; height: 130px;"><div id="wami"></div></div>
		  	</div>
  		  <noscript>WAMI requires Javascript</noscript>
  		  
</div>
<div style="display: inline-block; float: center; margin-left: 20em; margin-right: 1em; visibility: hidden;" >
  		  		<a style="display: inline-block; float:left;" > Time left for recording: </a>
	  		  <progress id="counter" max="100" style="display: inline-block; float:right; ">
			  <strong>Progress: 60% done.</strong>
			  </progress>
</div>
<a style="display: inline-block; float:right; margin-right: 10em;" onclick="selectorPhrase(lastPhrase+1);" href="#"> Next </a>



	<%
	//}
if(audios == null){%>
	<p id="inform"> It's like at the moment we don't have any phrases. You can be the first to put one </p>	
<%} %>
</body>
</html>