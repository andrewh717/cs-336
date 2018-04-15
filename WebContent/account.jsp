<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuyMe - Account Options</title>
    <link rel="stylesheet" href="style.css?v=1.0"/>
</head>
<body>
    <% if(session.getAttribute("user") == null) {
    		response.sendRedirect("login.jsp");
       } else { %>
    	<%@ include file="navbar.jsp" %>
    	<div class="content">
	    	<h1>Hello, <%=session.getAttribute("user")%></h1>
	    	<ul>
	            <li><a href="bidHistory.jsp">View your bidding history</a></li>
	            <li><a href="sellingHistory.jsp">View your selling history</a></li>
	            <li><a href="buyingHistory.jsp">View your purchase history</a></li>
	            <li><a href="accountSettings.jsp">Change account settings</a></li>
	    	</ul>
    	</div>
    <% } %>
</body>
</html>