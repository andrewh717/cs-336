<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuyMe - Sales Reports</title>
    <link rel="stylesheet" href="style.css?v=1.0"/>
</head>
<body>
    <% if(session.getAttribute("user") == null) {
    		response.sendRedirect("login.jsp");
       } else { 
    	   	int accessLevel = Integer.parseInt(session.getAttribute("access_level").toString());
    	   	if (accessLevel != 3) {
				response.sendRedirect("index.jsp");
				return;
    	   	}
    	   	String reportType = request.getParameter("type"); %>	
    	<%@ include file="navbar.jsp" %>
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
			
			Locale locale = new Locale("en", "US");
			NumberFormat currency = NumberFormat.getCurrencyInstance(locale);
			
			try {
				Class.forName("com.mysql.jdbc.Driver").newInstance();
<<<<<<< HEAD
				conn = DriverManager.getConnection(url, "cs336admin", "cs336password");
=======
				conn = DriverManager.getConnection(url, "rds_username", "rds_password");
>>>>>>> 228ffd95b0d2d07697dc2a8fb929e6d00761449d
				
				String query = null;
		    	if (reportType.equals("totalEarnings")) {
		    		query = "SELECT SUM(price) FROM Product WHERE sold=true";
		    		ps = conn.prepareStatement(query);
		    		rs = ps.executeQuery();
		    		if (rs.next()) { %>
		    			<h2>Sales Report:</h2>
		    			<table>
		    				<tr>
		    					<th>Total Earnings</th>
		    				</tr>	
		    		<%	do { %>
		    				<tr>
		    					<td><%= currency.format(rs.getDouble("SUM(price)")) %></td>
		    				</tr>
		    		<%	} while (rs.next()); %>
		    			</table>
		    			<br><a href="salesReports.jsp">Click here to generate more sales reports.</a>
		    	<%	}		    		
		    	} else if (reportType.equals("earningsPerItem")) {
		    		query = "SELECT model, SUM(price) FROM Product WHERE sold=true GROUP BY model";
		    		ps = conn.prepareStatement(query);
		    		rs = ps.executeQuery();
		    		if (rs.next()) { %>
		    			<h2>Sales Report:</h2>
		    			<table>
		    				<tr>
		    					<th>Model</th>
		    					<th>Earnings</th>
		    				</tr>
		    		<%	do { %>
		    				<tr>
		    					<td><%= rs.getString("model") %></td>
		    					<td><%= currency.format(rs.getDouble("SUM(price)")) %></td>
		    				</tr>
		    		<%	} while (rs.next()); %>
		    		</table>
		    		<br><a href="salesReports.jsp">Click here to generate more sales reports.</a>
		    	<%	}
		    	} else if (reportType.equals("earningsPerItemType")) {
		    		query = "SELECT category, SUM(price) FROM Product WHERE sold=true GROUP BY category";
		    		ps = conn.prepareStatement(query);
		    		rs = ps.executeQuery();
		    		if (rs.next()) { %>
		    			<h2>Sales Report:</h2>
		    			<table>
		    				<tr>
		    					<th>Category</th>
		    					<th>Earnings</th>
		    				</tr>
		    		<%	do { %>
		    				<tr>
		    					<td><%= rs.getString("category") %></td>
		    					<td><%= currency.format(rs.getDouble("SUM(price)")) %></td>
		    				</tr>
		    		<%	} while (rs.next()); %>
		    		</table>
		    		<br><a href="salesReports.jsp">Click here to generate more sales reports.</a>
		    	<%	}
		    	} else if (reportType.equals("earningsPerEndUser")) {
		    		query = "SELECT seller, SUM(price) FROM Product WHERE sold=true GROUP BY seller";
		    		ps = conn.prepareStatement(query);
		    		rs = ps.executeQuery();
		    		if (rs.next()) { %>
		    			<h2>Sales Report:</h2>
		    			<table>
		    				<tr>
		    					<th>User</th>
		    					<th>Earnings</th>
		    				</tr>
		    		<%	do { %>
		    				<tr>
		    					<td><%= rs.getString("seller") %></td>
		    					<td><%= currency.format(rs.getDouble("SUM(price)")) %></td>
		    				</tr>
		    		<%	} while (rs.next()); %>
		    		</table>
		    		<br><a href="salesReports.jsp">Click here to generate more sales reports.</a>
		    	<%	}
		    	} else if (reportType.equals("bestSelling")) {
		    		query = "SELECT model, COUNT(model), SUM(price) FROM Product WHERE sold=true GROUP BY model ORDER BY COUNT(model) DESC";
		    		ps = conn.prepareStatement(query);
		    		rs = ps.executeQuery();
		    		if (rs.next()) { %>
		    			<h2>Sales Report:</h2>
		    			<table>
		    				<tr>
		    					<th>Model</th>
		    					<th>Number Sold</th>
		    					<th>Earnings</th>
		    				</tr>
		    		<%	do { %>
		    				<tr>
		    					<td><%= rs.getString("model") %></td>
		    					<td><%= rs.getInt("COUNT(model)") %></td>
		    					<td><%= currency.format(rs.getDouble("SUM(price)")) %></td>
		    				</tr>
		    		<%	} while (rs.next()); %>
		    		</table>
		    		<br><a href="salesReports.jsp">Click here to generate more sales reports.</a>
		    	<%	}
		    	} else if (reportType.equals("bestBuyers")) {
		    		query = "SELECT buyer, COUNT(buyer), SUM(price) FROM BuyingHistory GROUP BY buyer ORDER BY COUNT(buyer) DESC";
		    		ps = conn.prepareStatement(query);
		    		rs = ps.executeQuery();
		    		if (rs.next()) { %>
		    			<h2>Sales Report:</h2>
		    			<table>
		    				<tr>
		    					<th>Buyer</th>
		    					<th>Number of purchases</th>
		    					<th>Total amount spent</th>
		    				</tr>
		    		<%	do { %>
		    				<tr>
		    					<td><%= rs.getString("buyer") %></td>
		    					<td><%= rs.getInt("COUNT(buyer)") %></td>
		    					<td><%= currency.format(rs.getDouble("SUM(price)")) %></td>
		    				</tr>
		    		<%	} while (rs.next()); %>
		    		</table>
		    		<br><a href="salesReports.jsp">Click here to generate more sales reports.</a>
		    	<% }
		    	} else {
		    		// Invalid sales report type
		    		response.sendRedirect("error.jsp");
		    		return;
		    	}
			} catch (SQLException e) {
				out.print("<p>Error connecting to MYSQL server.</p>");
			    e.printStackTrace();
			} finally {
				try { rs.close(); } catch (Exception e) {}
				try { ps.close(); } catch (Exception e) {}
		        try { conn.close(); } catch (Exception e) {}
			}
	    %>	
    	</div>
    <% } %>
</body>
</html>