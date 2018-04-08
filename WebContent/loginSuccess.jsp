<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuyMe - Login Success</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="content center">
    <% if(session.getAttribute("user") == null) { %>
   		<h1>You are not logged in.</h1>
   		<a href="login.jsp">Click here to login.</a>
    <% } else { %>
    	<h1>Hello, <%=session.getAttribute("user")%></h1>
        <h2>You are now logged in.</h2> <br>
        <a href="logout.jsp"><button class="logout">Log Out</button></a>
    <% } %>
    </div>
	
</body>
</html>