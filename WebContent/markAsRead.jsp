<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
	if(session.getAttribute("user") == null) { 
		response.sendRedirect("login.jsp");
	} else {
		String url = "jdbc:mysql://aws_rds_endpoint/db_name";
		Connection conn = null;			
		PreparedStatement ps = null;
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			conn = DriverManager.getConnection(url, "rds_username", "rds_password");
			
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