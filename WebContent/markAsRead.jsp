<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
	if(session.getAttribute("user") == null) { 
		response.sendRedirect("login.jsp");
	} else {
<<<<<<< HEAD
		String url = "jdbc:mysql://buyme.cas20dm0rabg.us-east-1.rds.amazonaws.com:3306/buyMe";
=======
		String url = "jdbc:mysql://aws_rds_endpoint/db_name";
>>>>>>> 228ffd95b0d2d07697dc2a8fb929e6d00761449d
		Connection conn = null;			
		PreparedStatement ps = null;
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
<<<<<<< HEAD
			conn = DriverManager.getConnection(url, "cs336admin", "cs336password");
=======
			conn = DriverManager.getConnection(url, "rds_username", "rds_password");
>>>>>>> 228ffd95b0d2d07697dc2a8fb929e6d00761449d
			
			//System.out.println(request.getParameter("messageId"));
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