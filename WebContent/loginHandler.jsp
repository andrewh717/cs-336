<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
	String url = "jdbc:mysql://buyme.cas20dm0rabg.us-east-1.rds.amazonaws.com:3306/buyMe";
	Connection conn = null;
	
	try {
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		conn = DriverManager.getConnection(url, "cs336admin", "cs336password");
	} catch (Exception e) {
        out.print("<p>Could not connect to MYSQL server.</p>");
        e.printStackTrace();
        return;
    }
	
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	System.out.println(username);
	System.out.println(password);
	
	if (username != null && password != null) {
		String validation = "SELECT password FROM account WHERE username=?";
		PreparedStatement ps = conn.prepareStatement(validation);
		ps.setString(1, username);
		
		ResultSet rs = ps.executeQuery();
		
		if (rs.next()) {
			String db_password = rs.getString("password");
			if (password.equals(db_password)) {
				response.sendRedirect("loginSuccess.jsp");
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

%>