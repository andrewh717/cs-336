<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
	String url = "jdbc:mysql://buyme.cas20dm0rabg.us-east-1.rds.amazonaws.com:3306/buyMe";
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
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
		String user = (session.getAttribute("user")).toString();
		float maxPrice = Float.parseFloat(request.getParameter("max_price"));
		
		// Make sure all the fields are entered
		if(category != null  && !category.isEmpty()
				&& brand != null && !brand.isEmpty() 
				&& gender != null && !gender.isEmpty()
				&& size != 0.0f
				&& model != null && !model.isEmpty()
				&& color != null && !color.isEmpty()
				&& maxPrice >= 0.0f) {
			
		// Build the SQL query with placeholders for parameters
			String insert = "INSERT INTO WishList (user, category, brand, model, gender, size, color, max_price)"
					+ "VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
			ps = conn.prepareStatement(insert);
		
			// Add parameters to query
			//ps.setString(1, name);
			ps.setString(1, user);
			ps.setString(2, category);
			ps.setString(3, brand);
			ps.setString(4, model);
			ps.setString(5, gender);
			ps.setFloat(6, size);
			ps.setString(7, color);
			ps.setFloat(8, maxPrice);
			
			int result = 0;
	        result = ps.executeUpdate();
	        if (result < 1) {
	        	out.println("Error: Failed to add item to wishlist.");
	        } else { %>
	        	<jsp:include page="wishListView.jsp"/>
	        	<div class="content">
	        		<h2>Successfully added item to wishlist.</h2>
	        	</div>
	       <% }
		} else {
			response.sendRedirect("createAuctionError.jsp"); //error
			return;
		}
	} catch(Exception e) {
        response.sendRedirect("createAuctionError.jsp"); // MySql error such as Start Date before End Date
        e.printStackTrace();
    } finally {
        try { ps.close(); } catch (Exception e) {}
        try { conn.close(); } catch (Exception e) {}
    }

%>