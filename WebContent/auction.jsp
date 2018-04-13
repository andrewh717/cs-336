<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
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
				ResultSet bids = null;
				
				try {
					Class.forName("com.mysql.jdbc.Driver").newInstance();
					conn = DriverManager.getConnection(url, "cs336admin", "cs336password");
				} catch(Exception e) {
					out.print("<p>Error connecting to MYSQL server.</p>");
			        e.printStackTrace();
				}
				int productId = Integer.parseInt(request.getParameter("productId"));
				String productQuery = "SELECT * FROM Product WHERE productId=?";
				ps = conn.prepareStatement(productQuery);
				ps.setInt(1, productId);
				
				rs = ps.executeQuery();
				if (!rs.next()) {
					response.sendRedirect("error.jsp"); // Occurs if there is no row in Product table with the given productId
					return;
				}
			%>
			
			<!-- Let user know bid has been placed if redirected from bidHandler.jsp -->
			<% 
				Enumeration<String> params = request.getParameterNames();
				params.nextElement();
			if (params.hasMoreElements()) {
				params.nextElement();
				if ((request.getParameter("bid")).equals("success")) { %>
					<h2>Your bid has been placed successfully.</h2> <br>
			<% }
			} %>
			
			<h2>Auction Category: <%= rs.getString("category") %></h2> <br>
			Brand: <%= rs.getString("brand") %> <br>
			Model: <%= rs.getString("model") %> <br>
			Size: <%= rs.getString("gender") %> <%= rs.getFloat("size") %> <br>
			Color: <%= rs.getString("color") %> <br>
			Seller: <%= rs.getString("seller") %> <br>
			Current bid: $<%= rs.getFloat("price") %> <br>
			
			<!-- Provide option to place bid if current user is not the seller -->
			<% if (!session.getAttribute("user").equals(rs.getString("seller"))) { %>
					<form action="bidHandler.jsp?bidder=<%= session.getAttribute("user") %>&productId=<%= productId %>" method="POST">
						<input type="number" name="bid" placeholder="Bid $<%= rs.getFloat("price") + 1 %> or higher" min="<%= rs.getFloat("price") + 1 %>">
						<input type="submit" value="Place bid">
					</form>
			<% } %>
			
			<!-- Display bids if there are any -->
			<%
				String bidQuery = "SELECT * FROM Bid WHERE productId=?";
				ps = conn.prepareStatement(bidQuery);
				ps.setInt(1, productId);
				
				bids = ps.executeQuery();
				if (bids.next()) { %>
					<h2>Bid History</h2>
					<table>
						<tr>
							<th>Bidder</th>
							<th>Bid Amount</th>
						</tr>
				<%	do { %>
						<tr>
							<td><%= bids.getString("buyer") %></td>
							<td>$<%= bids.getFloat("currentBid") %></td>
						</tr>
				<%	} while (bids.next()); %>
					</table>		
			<%	} else { %>
					<h2>There are currently no bids for this auction.</h2> <br>
			<%	} %>
			
			<h2>Similar items on auction:</h2>
			<table>
				<tr>
					<th>Item</th>
					<th>Seller</th>
					<th>Current Bid</th>
					<th>End Date/Time</th>
				</tr>
				
			<%
				ResultSet similarItems = null;
				String similarQuery = "SELECT * FROM Product WHERE productId!=" + productId
						+ " AND (brand LIKE \'" + rs.getString("brand") + "\' OR model LIKE \'" + rs.getString("model") + "\')";
				Statement s = conn.createStatement();
				similarItems = s.executeQuery(similarQuery);
				while (similarItems.next()) { %>
					<tr>
						<td>
							<a href="auction.jsp?productId=<%= similarItems.getInt("productId") %>">
								<%= similarItems.getString("brand") + " " + similarItems.getString("model") + " " + similarItems.getString("gender") +  " " + similarItems.getFloat("size") %>
							</a>
						</td>
						<td><%= similarItems.getString("seller") %></td>
						<td><%= similarItems.getFloat("price") %></td>
						<td><%= similarItems.getString("endDate") %></td>
					</tr>
			 <%	} %>		
		
			</table>
    	</div> 	        
    <% } %>
</body>
</html>