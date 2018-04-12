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
		int productID = Integer.parseInt(request.getParameter("productID"));
		String name = request.getParameter("name");
		String category = request.getParameter("category");
		String brand = request.getParameter("brand");
		String gender = request.getParameter("gender");
		float size = Float.parseFloat(request.getParameter("size"));
		String model = request.getParameter("model");
		String color = request.getParameter("color");
		String seller = request.getParameter("seller");
		float price = Float.parseFloat(request.getParameter("price"));
		boolean sold = Boolean.parseBoolean(request.getParameter("sold"));
		String startDate = request.getParameter("start_datetime");
		String endDate = request.getParameter("end_datetime");
		float reserve = Float.parseFloat(request.getParameter("min_price"));
		
		// Make sure all the fields are entered
		if(productID != 0
				&& name != null && !name.isEmpty()
				&& category != null  && !category.isEmpty()
				&& brand != null && !brand.isEmpty() 
				&& gender != null && !gender.isEmpty()
				&& size != 0.0f
				&& model != null && !model.isEmpty()
				&& color != null && !color.isEmpty()
				&& seller != null && !seller.isEmpty()
				&& price != 0.0f
				&& (sold == true || sold == false) 
				&& startDate != null && !startDate.isEmpty()
				&& endDate != null && !endDate.isEmpty()
				&& reserve != 0.0f) {
			
		// Build the SQL query with placeholders for parameters
			String insert = "INSERT INTO Product (productID, name, category, brand, gender, size, model, color, seller, price, sold, startDate, endDate)"
					+ "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			ps = conn.prepareStatement(insert);
		
			// Add parameters to query
			ps.setInt(1, productID);
			ps.setString(2, name);
			ps.setString(3, category);
			ps.setString(4, brand);
			ps.setString(5, gender);
			ps.setFloat(6, size);
			ps.setString(7, model);
			ps.setString(8, color);
			ps.setString(9, seller);
			ps.setFloat(10, price);
			ps.setBoolean(11, sold);
			ps.setString(12, startDate);
			ps.setString(13, endDate);
			

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