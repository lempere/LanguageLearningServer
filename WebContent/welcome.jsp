<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<script>

	window.onload = function(){
		start();
	};

	function courses(){
		//sessio.setAttribute("titol","courses");
		//window.open("./SelectorPage.jsp");
		window.location.href="ListCourses";
	}
	function start(){
		var text = document.getElementById('text');
		text.innerHTML= "<p class=\"paragrafo\">" +
		"Welcome Page: Setup the system with few steps."+
		"I need you find the microphone of computer and connect it"+
		"If you have a laptop you have a better luck, normaly is embeded"+
		"When you find and one to get start click <a href=\"javascript:startMenu()\" >next<a></p>";
	}
	function startAudio(){
		var text = document.getElementById('text');
		text.innerHTML= "<p class=\"paragrafo\">" +
		"Well done!! We are in the last configuration step, you have to try the system." +
		"Remember to say something nice this is your first message!"+
			"Try the audio: Record a message and listen. Do you think is correct?</p>"+
				"<a href=\"javascript:courses()\">  Yeah! All was correct and I record a nice missage, continue please <a>";
	}
	function startMenu(){

		var text = document.getElementById('text');
		setupRecorder();
		text.innerHTML= "<p  class=\"paragrafo\">" +
		"Now you have a microphone, you have to click in the up flash message, to enable the audio conection with your computer"+
		"don't worry if the message say enable the webcam too, is the defaults settings to enable chat but we don't want to use your cam, only the microphone."+
		"If you click en remember you don't have to see this anoying flash message again, and in every moment you have the control to set up the microphone."+
		"We promise be good for Christmass don't want to use it in other things.</p>"+
		"<a href=\"javascript:startAudio()\"> I understand and want to use it</a>";		

		};
	</script>
<title>Insert title here</title>
</head>
<body>

		<br class="clear"/>
		<div id="text"></div>

</body>
</html>