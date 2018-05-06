<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>BuyMe - Create Auction</title>
<link rel="stylesheet" href="style.css?v=1.0" />
</head>
<body>
	<% if(session.getAttribute("user") == null) {
    	 	response.sendRedirect("login.jsp");
        } else { %>
	<%@ include file="navbar.jsp"%>
	<div class="content">
		<%
<<<<<<< HEAD
    		String url = "jdbc:mysql://buyme.cas20dm0rabg.us-east-1.rds.amazonaws.com:3306/buyMe";
=======
    		String url = "jdbc:mysql://aws_rds_endpoint/db_name";
>>>>>>> 228ffd95b0d2d07697dc2a8fb929e6d00761449d
    		Connection conn = null;
    		PreparedStatement ps = null;
    		ResultSet rs = null;
    		try {
				Class.forName("com.mysql.jdbc.Driver").newInstance();
<<<<<<< HEAD
				conn = DriverManager.getConnection(url, "cs336admin", "cs336password");
=======
				conn = DriverManager.getConnection(url, "rds_username", "rds_password");
>>>>>>> 228ffd95b0d2d07697dc2a8fb929e6d00761449d
				String query = "SELECT * FROM WishList WHERE user=?";
				String user = (session.getAttribute("user")).toString();
				Locale locale = new Locale("en", "US");
				NumberFormat currency = NumberFormat.getCurrencyInstance(locale);
				
				ps = conn.prepareStatement(query);
				ps.setString(1, user);
				rs = ps.executeQuery();
				if (rs.next()) { %>
					<h2>Your wishlist</h2>
	    			<table>
	    				<tr>
	    					<th>Category</th>
	    					<th>Brand</th>
	    					<th>Model</th>
	    					<th>Gender</th>
	    					<th>Size</th>
	    					<th>Color</th>
	    					<th>Max Price</th>
	    				</tr>	
				<%	do { %>
						<tr>
							<td><%= rs.getString("category") %></td>
							<td><%= rs.getString("brand") %></td>
							<td><%= rs.getString("model") %></td>
							<td><%= rs.getString("gender") %></td>
							<td><%= rs.getString("size") %></td>
							<td><%= rs.getString("color") %></td>
							<td><%= currency.format(rs.getFloat("max_price")) %></td>
						</tr>
				<%	} while (rs.next()); %>
					<table>
			<%	} else { %>
					<h2>You have no items in your wishlist.</h2>
			<%	}
    		} catch (SQLException e) {
    			out.print("<p>Error connecting to MYSQL server.</p>");
			    e.printStackTrace();
    		} finally {
    			try { rs.close(); } catch (Exception e) {} 
    			try { ps.close(); } catch (Exception e) {} 
				try { conn.close(); } catch (Exception e) {}
    		} %> 
	</div>
	<% } %>
</body>
</html>