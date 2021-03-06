<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuyMe - Your Bidding History</title>
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
			ResultSet rs1 = null;
			ResultSet rs2 = null;
			
   			try {   		
   				Class.forName("com.mysql.jdbc.Driver").newInstance();
   				conn = DriverManager.getConnection(url, "cs336admin", "cs336password");
   				
   				String user = (session.getAttribute("user")).toString(); 				
   				// Create formatter for US currency
   				Locale locale = new Locale("en", "US");
   				NumberFormat currency = NumberFormat.getCurrencyInstance(locale);
   				
   				//String bidQuery = "SELECT * FROM BidHistory WHERE buyer=? ORDER BY date DESC"; 
   				String bidQuery = "SELECT * FROM BidHistory WHERE buyer=?";
   				ps = conn.prepareStatement(bidQuery);
   				ps.setString(1, user);
   				rs1 = ps.executeQuery();
   				
   				if (rs1.next()) { %>
   					<h2>Your Bid History</h2>
   					<table>
   						<tr>
   							<th>Item Name</th>
   							<th>Bid Amount</th>
   							<!--<th>Date</th>-->
   						</tr>
   				<%	do { 
   						int productId = rs1.getInt("productId");
   						String itemName = null;
   						String productQuery = "SELECT brand, model, gender, size FROM Product WHERE productId=?";
   						ps = conn.prepareStatement(productQuery);
   						ps.setInt(1, productId);
   						rs2 = ps.executeQuery();
   						if (rs2.next()) {
   							itemName = rs2.getString("brand") + " " + rs2.getString("model") + " " + rs2.getString("gender") +  " " + rs2.getFloat("size");
   						} else {
   							itemName = "productId not found";
   						}
   					
   				%>
   						<tr>
   							<td><%= itemName %></td>
   							<td><%= currency.format(rs1.getDouble("bid")) %></td>
   							<!-- <td>rs1.getString("date")</td>-->
   						</tr>
   				<%	} while (rs1.next()); %>
   					</table>		
   			<%	} else { %>
   					<h2>You have not made any bids.</h2>
   			<%	} 		
   			} catch (SQLException e) {
   				response.sendRedirect("error.jsp");
   				out.print("<h1>Error connecting to MYSQL server.</h1>");
		        e.printStackTrace();
   			} finally {
   				try { rs1.close(); } catch (Exception e) {}
   				try { ps.close(); } catch (Exception e) {}   				
   				try { conn.close(); } catch (Exception e) {}
   			} %>   		
		</div>
	<% } %>
</body>
</html>		