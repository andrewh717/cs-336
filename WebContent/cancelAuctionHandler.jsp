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
	<% if (session.getAttribute("user") == null) { 
	    		response.sendRedirect("login.jsp");
	       } else { %>
	    	<%@ include file="navbar.jsp" %>
	    	<div class="content">
	    		<h1>Hello, <%=session.getAttribute("user")%></h1>
		<%
			String url = "jdbc:mysql://buyme.cas20dm0rabg.us-east-1.rds.amazonaws.com:3306/buyMe";
			Connection conn = null;			
			PreparedStatement ps = null;
			PreparedStatement pwPs = null;
			ResultSet rs = null;
			ResultSet rs2 = null;
			try {
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				conn = DriverManager.getConnection(url, "cs336admin", "cs336password");
				
				String user = (session.getAttribute("user")).toString();
				String seller = request.getParameter("seller");
				String yourPassword = request.getParameter("your_password");
				String confirmYourPassword = request.getParameter("confirm_your_password");
			
				// Get the user's row from Account table
				String validation = "SELECT password FROM Account WHERE username=?";
				pwPs = conn.prepareStatement(validation);
				pwPs.setString(1, user);
				rs = pwPs.executeQuery();
				
				// Make sure the user entered the correct current password
				if (rs.next()) {
					String db_password = rs.getString("password");
					if (!yourPassword.equals(db_password)) { %>
						<jsp:include page="cancelAuction.jsp" flush="true"/>
						<div class="content center">
							<h1>
								<br>Error: Current password is incorrect.<br>
								You must enter your correct password to make these changes.
							</h1>
						</div>
			    <%    	return;
					}
				} else {
					// No account found with the current user's username
					// Should never happen
					response.sendRedirect("error.jsp");
					return;
				}
				
				// Make sure the new password is entered correctly in the confirm box
				if (!yourPassword.equals(confirmYourPassword)) { 
				%>
					<jsp:include page="cancelAuction.jsp" flush="true"/>
					<div class="content center">
						<h1>Error: Failed to confirm new password. <br> Make sure you enter it correctly in both fields.</h1>
					</div>
			<%	return;
				}
			
				String query = "SELECT productId FROM Product WHERE seller=?";
				ps = conn.prepareStatement(query);
				ps.setString(1, seller);
				rs2 = pwPs.executeQuery();
		
				if(rs2.next()){
					int db_productId = rs2.getInt("productId");
			%>		
					<h2>Select the auction to cancel it:</h2>
					<table>
						<tr>
							<th>Item</th>
							<th>Seller</th>
							<th>End Date/Time</th>
						</tr>
				<% do { %>
						<tr>
							<td>
								<a href="auction.jsp?productId=<%=rs.getInt("productId")%>&sold=0">
									<%= rs.getString("brand") + " " + rs.getString("model") + " " + rs.getString("gender") +  " " + rs.getFloat("size") %>
								</a>
							</td>
							<td><%= rs.getString("seller") %></td>
							<td><%= rs.getString("endDate") %></td>
						</tr>
				<%	} while (rs.next()); %>
					</table>
			<%	} else{ %>
					<h2>The seller does not have any active auctions.</h2>
			<%	}
				
			} catch(Exception e) {
				out.print("<p>Error connecting to MYSQL server.</p>");
			    e.printStackTrace();
			} finally {
				try { rs.close(); } catch (Exception e) {}
				try { rs2.close(); } catch (Exception e) {}
				try { ps.close(); } catch (Exception e) {}
				try { pwPs.close(); } catch (Exception e) {}
		        try { conn.close(); } catch (Exception e) {}
			}
		%>
    	</div>
    <% } %>
</body>
</html>