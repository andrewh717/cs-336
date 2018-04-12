<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuyMe - Creating Auction Error</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
	<% if(session.getAttribute("user") == null) {
    	 	response.sendRedirect("login.jsp");
       } else { %>
       	<%@ include file="navbar.jsp" %>
	    <div class="content">
	    	<h2>Error: Failed to create auction.</h2>
	    	<p>Be sure to fill out the fields correctly, including a Minimum Bid Price > 0.</p>	    	
	    	<a href="createAuction.jsp">Click here to try again.</a>        
	    </div>
	    
	<% } %>
</body>
</html>