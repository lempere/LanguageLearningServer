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
		<img src="img/door_in.png" alt="" class="sprite s_door_in link-img" style="margin-right:1em"/>Iniciar sesi&oacute;n </a>
		<%}else{ %>
		<a><%=usuari %></a>
		<%} %>
		<!--    Login      -->
		
		<div id="login-hover-cover">
		<div id="login-hover-cont" class="offscreen" style="display:none" >
		    <form action="LoginServlet" method="post">
		     <input type="hidden" name="t" value="7eec60c91c" />
		        <p>
		            Correu electronic/user<br/>
		            <input id="login_email_elm" type="text" name="user" class="textinput" tabindex="1" />
		        </p>
		        <p style="margin-bottom: 0.25em;">
		            Contrasenya<br/>
		            <input type="password" name="pass" class="textinput" tabindex="2" />
		        </p>
		        <p style="margin-bottom: 0.5em;">
		            <input type="checkbox" class="no-border" name="remember_me" id="remember_me" style="vertical-align: middle; margin-left: 0;" tabindex="3">
		            <label for="remember_me" style="vertical-align: middle; cursor: pointer; ">Recordam</label>
		        </p>
		        <p style="margin-bottom: 0;">
		            <input type="submit" value="Iniciar sesión" class="welcome-submit button" style="float:right;" tabindex="4">
		            <a id="login-create-an-account" href="Registrar.jsp" style="margin: 0.5em;">Crear una compte</a>
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
			El projecte consisteix en un portal interactiu, per ajudar en l'aprenentatge d'un idioma,
			però sobretot es concentra en adquirir l'accent necessari i en treure la por de formar un dialeg
			en un idioma poc habitual.
			Per tan l'usuari podra parlar utilitzant el microfont de l'ordinador i obtindra un feedback de la seva
			interpretació un cop tingui dominat l'aprenentatge del tema podra pasar al següent tema, sinó el programa
			pretent localitzar quines son les dificultats de l'usuari i formular exercisis de repas.
			</p>
	        <span id="commoncraft">
	            <br /><br />
	            <a href="#" id="playvideo" onclick="play_screencast(); return false;" style="width: 500px; margin-left: 66%; margin-right: 20%;">
	                Veure el video
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
			El projecte consisteix en un portal interactiu, per ajudar en l'aprenentatge d'un idioma,
			però sobretot es concentra en adquirir l'accent necessari i en treure la por de formar un dialeg
			en un idioma poc habitual.
			Per tan l'usuari podra parlar utilitzant el microfont de l'ordinador i obtindra un feedback de la seva
			interpretació un cop tingui dominat l'aprenentatge del tema podra pasar al següent tema, sinó el programa
			pretent localitzar quines son les dificultats de l'usuari i formular exercisis de repas.
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
                    <li><a href="/">Inicio</a></li>
                    <li><a href="/install">Instalar</a></li>
                    <li><a href="/anywhere">Móvil</a></li>
                    <li><a href="/pricing">Precios</a></li>
                    <li><a href="/teams">Para empresas</a></li>
                    <li><a href="/features">Funciones</a></li>
                    <li><a href="/tour">Recorrido</a></li>
                </ul>
            </div>
            <div class="footer-col">
                <ul>
                    <li class="header">Sobre nosotros</li>
                    <li><a href="http://blog.language.com/">Blog de Language server</a></li>
                    <li><a href="/about">Nuestro equipo</a></li>
                    <li><a href="/press">Prensa</a></li>
                    <li><a href="/terms">Terminos</a></li>
                    <li><a href="/privacy">Privacidad</a></li>
                </ul>
            </div>

            <div class="footer-col">
                <ul>
                    <li class="header">Comunidad</li>
                    <li><a href="/referrals" onmouseup="javascript: MCLog.log('referrals_via_footer');">Recomendaciones</a></li>
                    <li><a href="http://twitter.com/language" target="_blank">Twitter</a></li>
                    <li><a href="http://facebook.com/language" target="_blank">Facebook</a></li>
                    <li><a href="/developers">Desarrolladores</a></li>
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