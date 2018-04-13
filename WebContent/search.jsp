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
    			
    			try {
    				Class.forName("".com.mysql.jdbc.Driver").newInstance();
    				conn = DreverManager.getConnection(url, "cs336admin", "cs336password");
    			} catch(Exception e) {
    				out.print("<p> Error connecting to MYSql serverl. </p>" + e);
    				e.printStackTrace();
    			}
    			String search = request.getParameter("searchParams");
    			String searchQuery = "SELECT * FROM Product";
    			ps = conn.prepareStatement(searchQuery);
//    			ps.setString(1, search);
    			
    			rs = ps.executeQuery();
    			if (!rs.next()) {
    				response.sendRedirect("error.jsp");
    				return;
    			}
    		%>
    		<h2>Auction Category: <%= rs.getString("category") %></h2> <br>
			Brand: <%= rs.getString("brand") %> <br>
			Model: <%= rs.getString("model") %> <br>
			Gender: <%= rs.getString("gender") %> <br>
			Size: <%= rs.getFloat("size") %> <br>
			Color: <%= rs.getString("color") %> <br>
			Seller: <%= rs.getString("seller") %> <br>
			
			<h2> Similar items: </h2>
			<table>
				<tr>
					<th> Brand </th>
					<th> Model </th>
				</tr>
				
				
			<%
			//I think that the idea for the lines above is correct...
			//Basically I queried the entire table and then this I think should
			//Find any rows that have the same value as the one from searchParams, the value from teh search bar
			//
			ResultSet searchResult = null;
			String searchRes = "SELECT * FROM Product WHERE "
			
			%>	
			</table>    		
    		
    	
       
    	String searchParams = request.getParameter("searchParams"); 
    	if(searchParams == null || searchParams.isEmpty()) {
    		response.sendRedirect("index.jsp");
    	} %> */
    	
    		<h3>Search results for "<%=searchParams%>"</h3>        
	    </div> 
    <% } %>
</body>
</html>