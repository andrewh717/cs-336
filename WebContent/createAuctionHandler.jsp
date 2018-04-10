<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
	String url = "jdbc:mysql://buyme.cas20dm0rabg.us-east-1.rds.amazonaws.com:3306/buyMe";
	Connection conn = null;
	PreparedStatement ps = null;
	
	try {
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		conn = DriverManager.getConnection(url, "cs336admin", "cs336password");
		
		// Get the parameters from the createAuction request
		String category = request.getParameter("category");
		String brand = request.getParameter("brand");
		String gender = request.getParameter("gender");
		float size = Float.parseFloat(request.getParameter("size"));
		String model = request.getParameter("model");
		String color = request.getParameter("color");
		
		// Make sure all the fields are entered
		if(category != null  && !category.isEmpty()
				&& brand != null && !brand.isEmpty() 
				&& gender != null && !gender.isEmpty()
				&& size != 0.0f
				&& model != null && !model.isEmpty()
				&& color != null && !color.isEmpty()) {
			
			// Build the SQL query with placeholders for parameters
		/*	String insert = "INSERT INTO Product (username, password, email, first_name, last_name, address, access_level)"
					+ "VALUES(?, ?, ?, ?, ?, ?, ?)";
			ps = conn.prepareStatement(insert);
		*/
			// Add parameters to query
		/*	ps.setString(1, username);
			ps.setString(2, password);
			ps.setString(3, email);
			ps.setString(4, firstName);
			ps.setString(5, lastName);
			ps.setString(6, address);
			ps.setInt(7, accessLevel);
		*/	
			int result = 0;
	        result = ps.executeUpdate();
	        if (result < 1) {
	        	out.println("Error: Auction creation failed.");
	        } else {
	        	response.sendRedirect(""); //success
	        	return;
	        }
		} else {
			response.sendRedirect(""); //error
			return;
		}
	} catch(Exception e) {
        out.print("<p>Error connecting to MYSQL server.</p>");
        e.printStackTrace();
    } finally {
        try { ps.close(); } catch (Exception e) {}
        try { conn.close(); } catch (Exception e) {}
    }

%>