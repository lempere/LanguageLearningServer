<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">
<head>
    <title>Learn Languages
                - From house like you have been in the country
    </title>

    <link href="Estil.css" rel="stylesheet" type="text/css"/>
    <link href="estils/MenuLogin.css" rel="stylesheet" type="text/css"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

    <style type="text/css">
      .hny-lcm { display: none; }
    </style>
    <link href="format.css" rel='stylesheet' type="text/css"/>

<script type="text/javascript">
function showElement(layer){
	var myLayer = document.getElementById(layer);
	if(myLayer.style.display=="none"){
		myLayer.style.display="block";
		myLayer.backgroundPosition="top";
	} else {
		myLayer.style.display="none";
	}
}
</script>
</head>

<body class="es " >
		<%HttpSession sessio = request.getSession();%>
		<% String role = (String)sessio.getAttribute("role");%>
		<% String usuari = (String)sessio.getAttribute("userName");%>

    <div id="modal-behind" style="display: none;"></div>
    <div id="modal" style="display: none;">
        <div id="modal-box">
            <a onclick="javascript: Modal.hide(); Event.stop(event); return false;" href="#" style="float: right;">Click</a>
            <h2 id="modal-title"></h2>
            <div id="modal-content">
            </div>
        </div>
    </div>


<div id="main-container" style="padding:AUTO">


<div id="content" >

<div id="full-content">
	<div id="top-login-wrapper" style="position: absolute; top: 0; right: 0;">
		
		<%if(usuari == null){ %>
		<a id="login-hover-link"  onclick="javascript:showElement('login-hover-cont')">
		<img src="img/door_in.png" alt="" class="sprite s_door_in link-img" style="margin-right:1em"/>Sign in </a>
		<%}else{ %>
		<a><%=usuari %></a>
		<%} %>
		<!--    Login      -->
		
		<div id="login-hover-cover">
		<div id="login-hover-cont" class="offscreen" style="display:none" >
		    <form action="LoginServlet" method="post">
		     <input type="hidden" name="t" value="7eec60c91c" />
		        <p>
		            Email/user<br/>
		            <input id="login_email_elm" type="text" name="user" class="textinput" tabindex="1" />
		        </p>
		        <p style="margin-bottom: 0.25em;">
		            Pass<br/>
		            <input type="password" name="pass" class="textinput" tabindex="2" />
		        </p>
		        <p style="margin-bottom: 0.5em;">
		            <input type="checkbox" class="no-border" name="remember_me" id="remember_me" style="vertical-align: middle; margin-left: 0;" tabindex="3">
		            <label for="remember_me" style="vertical-align: middle; cursor: pointer; ">Remember</label>
		        </p>
		        <p style="margin-bottom: 0;">
		            <input type="submit" value="Iniciar sesión" class="welcome-submit button" style="float:right;" tabindex="4">
		            <a id="login-create-an-account" href="Registrar.jsp" style="margin: 0.5em;">SignUp</a>
		        </p>		
		    </form>
		  </div>
		</div>
	</div>

    <!--  Content  -->
 <div id="contingut">
	<div id="has_flash">
	    <div id="landing-page" style="position: relative;">
	        <div id="logo-container">
	        		<h1 style="margin-left:4.1em" >Language Learning</h1>

	        </div>
			<br class="clear"/>
			<p class="paragrafo">
			The project is a interactive portal to help you to learn a language in a different way.
			You can learn just by speaking the audio you listen and then the system let you check how good
			you pronounce that phrase. 
			The action of speaking is one of the best ways to learn a language, and to lose the fear to try.
			You are 5 minutes left to be able to learn the language you would want to.
			</p>
	        <span id="commoncraft">
	            <br /><br />
	            <a href="#" id="playvideo" onclick="play_screencast(); return false;" style="width: 500px; margin-left: 66%; margin-right: 20%;">
	                Watch a video
	            </a>
	        </span>

	    </div>
	</div>

	<div id="no_flash" style="display:none;">
	    <div id="landing-page">
	        <div id="logo-container">
				<h1 style="margin-left:4.1em" > Language Learning</h1>
	        </div>

	        <h1 id="tagline">Apren amb molta facilitat</h1>

        	<p class="paragrafo" style="text-align:right;line-height:25;text-indent:10px">
			The project is a interactive portal to help you learn language in different way.
			You can learn simple speaking the audio you listen and then the system let you see how good
			you make that phrase. 
			Speak is one of the best way to learn a language, and lose the afraid of trying.
			You are 5 minutes for practices you desired language.
			</p>
	    </div>
	    <div id="ifyou" style="text-align:left;">
	        <ul class="clearfix">
	        </ul>
	    </div>

	        </div>

    </div>
</div>

    <!-- Footer -->

    <div id="footer">

            <div class="footer-col">
                <ul>
                    <li class="header">LanguageServer</li>
                    
                </ul>
            </div>
            <div class="footer-col">
                <ul>
                    <li class="header">About us</li>
                </ul>
            </div>

            <div class="footer-col">
                <ul>
                    <li class="header">Community</li>
                </ul>
            </div>
            <div id="locale_selector_cont">
                <div id="locale_selector"></div>
            </div>
            <p id="copyright" style="float: right;" >
                 <img src="" alt="" class="sprite s_gray_logo text-img" />&copy; 2012 Language Server<br/>
            </p>
           <div class="clear"></div>
    </div>
</div>

</div>


</body>
</html>