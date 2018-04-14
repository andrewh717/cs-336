<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuyMe</title>
    <link rel="stylesheet" href="style.css?v=1.0"/>
</head>
<body>
    <% if(session.getAttribute("user") == null) { 
    		response.sendRedirect("login.jsp");
       } else { %>
    	<%@ include file="navbar.jsp" %>
    	<div class="content">
    	
    	<%
			String url = "jdbc:mysql://buyme.cas20dm0rabg.us-east-1.rds.amazonaws.com:3306/buyMe";
    		Connection conn = null;
    		PreparedStatement ps = null;
    		ResultSet rs = null;
    		
    		float bid = null;
    		String buyer = null;
    		int productID = null;
    		
    		
    		try {
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				conn = DriverManager.getConnection(url, "cs336admin", "cs336password");
				String accountQuery = "SELECT * FROM Account WHERE username=?";
				ps = conn.prepareStatement(accountQuery);
				ps.setString(1, (session.getAttribute("user")).toString());
				rs = ps.executeQuery();
				
				<%=session.getAttribute("user")%>
				
		</div>		