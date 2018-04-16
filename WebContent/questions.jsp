<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title> Frequently Asked Questions </title>
<link rel="stylesheet" href="style.css?v=1.0" />
</head>
<body>	
	<%@ include file="navbar.jsp"%>
	<div class="main">
		<div class="wrap">
			<div class="content">
				<h1 style="color:blue;"> How can we assist you <%=session.getAttribute("user")%>  ? </h1>
				<form action="questionsHandler.jsp" method="post">
					<textarea style="font-size: 18pt" rows="1" cols="100" maxlength="250" id="msg" name="Question"></textarea> <br>
					<input type="submit" value="Search">					
				</form>
			</div>
		</div>
	
	</div>	
</body>
</html>
