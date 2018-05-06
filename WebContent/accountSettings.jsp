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
    	<%
			String url = "jdbc:mysql://buyme.cas20dm0rabg.us-east-1.rds.amazonaws.com:3306/buyMe";
    		Connection conn = null;
    		PreparedStatement ps = null;
    		ResultSet rs = null;
			
    		String firstName = null;
    		String lastName = null;
    		String email = null;
    		String address = null;
    		String oldPassword = null;
    		
    		try {
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				conn = DriverManager.getConnection(url, "cs336admin", "cs336password");
				String accountQuery = "SELECT * FROM Account WHERE username=?";
				ps = conn.prepareStatement(accountQuery);
				ps.setString(1, (session.getAttribute("user")).toString());
				rs = ps.executeQuery();
				
				if (rs.next()) {
					firstName = rs.getString("first_name");
					lastName = rs.getString("last_name");
					email = rs.getString("email");
					address = rs.getString("address");
					oldPassword = rs.getString("password");
				} else {
					// Occurs if no row has username = current session's username
					// Should never happen, but just in case
					response.sendRedirect("error.jsp");
					return;
				}
				
    		} catch(SQLException e) {
				out.print("<p>Error connecting to MYSQL server.</p>");
		        e.printStackTrace();
			} finally {
				try { rs.close(); } catch (Exception e) {}
				try { ps.close(); } catch (Exception e) {}
				try { conn.close(); } catch (Exception e) {}
			}
    	%>
    	
    	
    	<div class="content">
    		<form action="accountUpdate.jsp" method="POST">
    			<label>First Name</label>
           		<input type="text" name="first_name" value="<%= firstName %>" placeholder="First Name"> <br>
    
            	<label>Last Name</label>
            	<input type="text" name="last_name" value="<%= lastName %>" placeholder="Last Name"> <br>
    
            	<label>Email</label>
            	<input type="text" name="email" value="<%= email %>" placeholder="Email"> <br>
    
            	<label>Address</label>
            	<input type="text" name="address" value="<%= address %>" placeholder="Address"> <br>
            	
            	<label>Current Password</label>
            	<input type="password" name="curr_password" placeholder="Current Password" required> <br>
            	
            	<label>New Password</label>
            	<input type="password" name="new_password" placeholder="New Password"> <br>
            	
            	<label>Confirm New Password</label>
            	<input type="password" name="confirm_new_password" placeholder="Confirm Password"> <br>
    			
    			<input type="submit" value="Update Account Settings">
    		</form>
    	
    	
    	</div>
    <% } %>
</body>
</html>