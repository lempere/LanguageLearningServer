<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

    <link href="Estil.css" rel="stylesheet" type="text/css"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<script type="text/javascript"> var idAudio, getScore = false;</script>
 
  <script>

	  window.onload = function(){
		  	setupRecorder();
		};
		function goIndex(){
			window.location.href="index.jsp";
		}

  </script>
<title>LanguageLearning : PFC</title>

</head>
<body>

	<%HttpSession sessio = request.getSession();%>
	<% String role = (String)sessio.getAttribute("role");%>
	<% String usuari = (String)sessio.getAttribute("user");%>
	<% String pg = (String)sessio.getAttribute("titol");
	   String microphone = (String)sessio.getAttribute("microphone");
		System.out.println(pg);
		if(usuari == null ){
			response.sendRedirect("index.jsp");
			return;
	 	}
	%>

<div id="main-container" style="padding-right:30em">

<div id="content" >

<div id="full-content">

		<!-- Login  -->
        <div id="logo-container">
			<h1 style="padding: 2em;display: inline; float: left;" >Language Learning</h1>
			<% //I need desactivate it when is not using at all .. %>
			<!-- Disable microphone for the screen doesn't use -->
			<%if(microphone.equals("true")){ %>
			 <!-- swfobject is a commonly used library to embed Flash content 
			  <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/swfobject/2.2/swfobject.js"></script>
			  -->
			  <!-- swfobject load local for improve speed -->
			  <script type="text/javascript" src="js/swfobject.js"></script>
			
			  <!-- Setup the recorder interface -->
			  <script type="text/javascript" src="js/recorder.js"></script>
			
			  <!-- GUI code... take it or leave it -->
			  <script type="text/javascript" src="js/gui.js"></script>
			  <script type="text/javascript" src="js/wami.js"></script>
  
			<!-- At the wami-recorder part you can see more http:/code.google.com/p/wami-recorder -->
	      	<div id="wami-things" style="margin: 0em 25em; ">
		    <div id="recordDiv" style="display:inline-block;" ></div>
		    <div id="playDiv" style="display:inline-block;"></div>
		    <div id="wami-container" style="float: left;"><div id="wami"></div></div>
		  	</div>
  		  <noscript>WAMI requires Javascript</noscript>
		<%}
			if(usuari == null){ %>
			<a id="login-hover-link"  onclick="javascript:showElement('login-hover-cont')">
			<img src="img/door_in.png" alt="" class="sprite s_door_in link-img" style=" float: left; padding: 2em;"/>Iniciar sesión </a>
		<%}else{ %>
			<div style=" float: right; padding: 2em;" >
				<a><%=usuari %></a>
			</div>
		<%} %>
	</div>
   
		

 <div id="contingut" style=" margin: 4em auto; min-height: 50em; text-align: center;">
	<% if(pg == null || pg.equals("welcome")) { %>
		<jsp:include page="welcome.jsp"></jsp:include>
	<%}else
		if(pg.equals("titol")) { %>
		<jsp:include page="welcome.jsp"></jsp:include>
	<% }else
		if(pg.equals("courses")) { %>
		<jsp:include page="ListCourses.jsp"></jsp:include>
		
	<% }else
		if(pg.equals("agenda")) { %>
		<jsp:include page="agenda.jsp"></jsp:include>
		
	<% }else
		if(pg.equals("class")) { %>
		<jsp:include page="Class.jsp"></jsp:include>
		
	<% }
	%>

</div>

	

</div>
	<jsp:include page="footer.jsp"></jsp:include>
</div>
</div>

</body>
</html>