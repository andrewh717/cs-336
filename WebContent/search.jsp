<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>BuyMe - Search Results</title>
	<link rel="stylesheet" href="style.css?v=1.0"/>
</head>
<body>
	<div class="content">
    <% if(session.getAttribute("user") == null) { %>
   		<h1>BuyMe</h1>
   		<a href="login.jsp">Click here to login.</a>
    <% } else {
    	String searchParams = request.getParameter("searchParams"); 
    	if(searchParams == null || searchParams.isEmpty()) {
    		response.sendRedirect("index.jsp");
    	} %>
    	<%@ include file="navbar.jsp" %>
    	<h3>Search results for "<%=searchParams%>"</h3>        
    <% } %>
    </div>
</body>
</html>