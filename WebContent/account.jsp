<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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
   		response.sendRedirect("index.jsp");
    <% } else { %>
    	<%@ include file="navbar.jsp" %>
    	<h1>Hello, <%=session.getAttribute("user")%></h1>
    	<ul>
            <li><a href="#">View your bidding history</a></li>
            <li><a href="#">View your selling history</a></li>
            <li><a href="#">Change account settings</a></li>
    	</ul>   
    <% } %>
    </div>
</body>
</html>