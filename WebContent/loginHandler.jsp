<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
	String url = "jdbc:mysql://aws_rds_endpoint/db_name";
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	try {
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		conn = DriverManager.getConnection(url, "rds_username", "rds_password");
	
		// Get the parameters from the login request
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		if (username != null && password != null) {
			String validation = "SELECT * FROM Account WHERE username=?";
			ps = conn.prepareStatement(validation);
			ps.setString(1, username);
			
			rs = ps.executeQuery();
			
			if (rs.next()) {
				String db_password = rs.getString("password");
				if (password.equals(db_password)) {
					session.setAttribute("user", username);
					session.setAttribute("access_level", rs.getInt("access_level"));
					session.setAttribute("first_name", rs.getString("first_name"));
					response.sendRedirect("index.jsp");
		        	return;
				} else {
					response.sendRedirect("loginError.jsp");
		        	return;
				}
			} else {
				response.sendRedirect("loginError.jsp");
				return;
			}
		} else {
			response.sendRedirect("loginError.jsp");
			return;
		}
	
	} catch (Exception e) {
        out.print("<p>Error connecting to MYSQL server.</p>");
        e.printStackTrace();
    } finally {
    	try { rs.close(); } catch (Exception e) {}
        try { ps.close(); } catch (Exception e) {}
        try { conn.close(); } catch (Exception e) {}
    }

%>