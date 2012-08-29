<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Courses</title>

<%@page import="pfc.web.Entities.Course"%>
<%@page import="java.util.HashMap"%>

</head>
<body>
<% HttpSession sessio = request.getSession();%>
<% String user = (String)sessio.getAttribute("userName");%>
<% String role = (String)sessio.getAttribute("role");%>
<% String userMur = (String)sessio.getAttribute("murName");%>
<% String editar = (String)sessio.getAttribute("adminMur");%>
<% HashMap< Integer, Course> chapters = (HashMap< Integer, Course>) sessio.getAttribute("chapters");%>
	
	<% if(chapters!=null)
	 for (Course c : chapters.values() ) {
		  %>	 

	<div class="indentAnswer">
	<FORM ACTION = "Class" METHOD = "POST">

	<%=c.getCoursesName() %>		
		<INPUT TYPE="SUBMIT"  NAME="editar" VALUE="Learn"/><br>
		<input TYPE="HIDDEN"  NAME="user" VALUE="<%=user%>"/>
		<input TYPE="HIDDEN"  NAME="id_chapters" VALUE="<%=c.getId_courses()%>"	/>
	</FORM>
	<br>
</div>
	<%
}
if(chapters == null){%>
<p> It's like at the moment we don't have any chapter. You can be the first to put one </p>
	
<%} %>

</body>
</html>