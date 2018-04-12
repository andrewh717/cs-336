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
		System.out.println(category);
		String brand = request.getParameter("brand");
		System.out.println(brand);
		String gender = request.getParameter("gender");
		System.out.println(gender);
		float size = Float.parseFloat(request.getParameter("size"));
		System.out.println(request.getParameter("size"));		
		String model = request.getParameter("model");
		System.out.println(model);
		String color = request.getParameter("color");
		System.out.println(color);
		String seller = (session.getAttribute("user")).toString();
		System.out.println(seller);		
		float minPrice = Float.parseFloat(request.getParameter("min_price"));
		System.out.println(minPrice);
		String startDate = request.getParameter("start_datetime");
		System.out.println(startDate);
		String endDate = request.getParameter("end_datetime");
		System.out.println(endDate);
		
		// Make sure all the fields are entered
		if(category != null  && !category.isEmpty()
				&& brand != null && !brand.isEmpty() 
				&& gender != null && !gender.isEmpty()
				&& size != 0.0f
				&& model != null && !model.isEmpty()
				&& color != null && !color.isEmpty()
				&& startDate != null && !startDate.isEmpty()
				&& endDate != null && !endDate.isEmpty()
				&& minPrice != 0.0f) {
			
		// Build the SQL query with placeholders for parameters
			String insert = "INSERT INTO Product (category, brand, model, gender, size, color, seller, price, sold, startDate, endDate)"
					+ "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			ps = conn.prepareStatement(insert);
		
			// Add parameters to query
			//ps.setString(1, name);
			ps.setString(1, category);
			ps.setString(2, brand);
			ps.setString(3, model);
			ps.setString(4, gender);
			ps.setFloat(5, size);
			ps.setString(6, color);
			ps.setString(7, seller);
			ps.setFloat(8, minPrice);
			ps.setBoolean(9, false);
			ps.setString(10, startDate);
			ps.setString(11, endDate);
			

			int result = 0;
	        result = ps.executeUpdate();
	        if (result < 1) {
	        	out.println("Error: Auction creation failed.");
	        } else {
	        	response.sendRedirect("createAuctionSuccess.jsp"); //success
	        	return;
	        }
		} else {
			response.sendRedirect("createAuctionError.jsp"); //error
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