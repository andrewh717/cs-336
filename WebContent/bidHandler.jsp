<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
	String url = "jdbc:mysql://buyme.cas20dm0rabg.us-east-1.rds.amazonaws.com:3306/buyMe";
	Connection conn = null;
	PreparedStatement ps = null;
			
	try {
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		conn = DriverManager.getConnection(url, "cs336admin", "cs336password");
	
		int productId = Integer.parseInt(request.getParameter("productId"));
		String bidInsert = "INSERT INTO Bid VALUES (?, ?, ?)";
		ps = conn.prepareStatement(bidInsert);
		ps.setFloat(1, Float.parseFloat(request.getParameter("bid")));
		ps.setString(2, request.getParameter("bidder"));
		ps.setInt(3, Integer.parseInt(request.getParameter("productId")));
		
		int result = 0;
		result = ps.executeUpdate();
		if (result < 1) {
			response.sendRedirect("error.jsp"); // This should never happen
		} else {
			response.sendRedirect("auction.jsp?productId=" + productId + "&bid=success"); // Bid placed successfully, redirect to auction page
		}	
	} catch(Exception e) {
		out.print("<p>Error connecting to MYSQL server.</p>");
	    e.printStackTrace();
	} finally {
		try { ps.close(); } catch (Exception e) {}
        try { conn.close(); } catch (Exception e) {}
	}
%>