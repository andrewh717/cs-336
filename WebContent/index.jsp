<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuyMe</title>
    <link rel="stylesheet" href="style.css?v=1.0"/>
</head>
<body>
    <div class="content">
    <% if(session.getAttribute("user") == null) { %>
   		<h1>BuyMe</h1>
   		<a href="login.jsp">Click here to login.</a>
    <% } else { %>
    	<%@ include file="navbar.jsp" %>
    	<h1>Hello, <%=session.getAttribute("user")%></h1>        
    <% } %>
    </div>
	
</body>
</html>