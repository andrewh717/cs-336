<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuyMe - Register</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
	<% if (session.getAttribute("user") == null) { 
    		response.sendRedirect("login.jsp");
       } else { 
			String url = "jdbc:mysql://buyme.cas20dm0rabg.us-east-1.rds.amazonaws.com:3306/buyMe";
			Connection conn = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
		   	try {
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				conn = DriverManager.getConnection(url, "cs336admin", "cs336buyme5");
				
				String user = (session.getAttribute("user")).toString();
				String accountQuery = "SELECT * FROM Account WHERE username=?";
				
				ps = conn.prepareStatement(accountQuery);
				ps.setString(1, user);
				rs = ps.executeQuery();
				rs.next();
				
				if (rs.getInt("access_level") != 3) {
    				response.sendRedirect("index.jsp");
 	    			return;
    			} 
			} catch (SQLException e) {
				out.print("<p>Error connecting to MYSQL server.</p>");
			    e.printStackTrace();
			} finally {
				try { rs.close(); } catch (Exception e) {} 
				try { ps.close(); } catch (Exception e) {} 
				try { conn.close(); } catch (Exception e) {} 
			} %>
	    	<%@ include file="navbar.jsp" %>
		    <div class="content center">
		    	<h2>Create a Customer Rep account</h2>
		        <form action="customerRepHandler.jsp" method="POST">
		            <label for="first_name">First Name</label>
		            <input type="text" name="first_name" id="first_name" placeholder="First Name"> <br>
		    
		            <label>Last Name</label>
		            <input type="text" name="last_name" placeholder="Last Name"> <br>
		    
		            <label>Email</label>
		            <input type="text" name="email" placeholder="Email"> <br>
		    
		            <label for="Address">Address</label>
		            <input type="text" name="address" placeholder="Address"> <br>
		            
		            <label for="username">Username</label>
		            <input type="text" name="username" id="username" placeholder="Username"> <br>
		    
		            <label>Password</label>
		            <input type="password" name="password" placeholder="Password"> <br>
		    
		            <label>Confirm Password</label>
		            <input type="password" name="confirm_password" placeholder="Confirm Password"> <br>
		    
		            <input type="submit" value="Create Account">
		        </form>
	   		</div>
	<% } %>
</body>
</html>