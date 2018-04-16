<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
	if(session.getAttribute("user") == null) { 
		response.sendRedirect("login.jsp");
	} else {
		String url = "jdbc:mysql://buyme.cas20dm0rabg.us-east-1.rds.amazonaws.com:3306/buyMe";
		Connection conn = null;			
		PreparedStatement ps = null;
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			conn = DriverManager.getConnection(url, "cs336admin", "cs336password");
			
			System.out.println(request.getParameter("messageId"));
			int messageId = Integer.parseInt(request.getParameter("messageId"));
			String updateSeen = "UPDATE Alerts SET seen=true WHERE messageId=?";
			ps = conn.prepareStatement(updateSeen);
			ps.setInt(1, messageId);
			
			int updateResult = 0;
			updateResult = ps.executeUpdate();
			if (updateResult < 1) {
				response.sendRedirect("error.jsp");	
			} else {
				// Alert was successfully marked as read
				response.sendRedirect("index.jsp");
			}
		} catch(Exception e) {
			out.print("<p>Error connecting to MYSQL server.</p>");
		    e.printStackTrace();
		} finally {
			try { ps.close(); } catch (Exception e) {}
		    try { conn.close(); } catch (Exception e) {}
		}
	}
%>