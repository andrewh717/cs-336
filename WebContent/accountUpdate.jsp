<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
	String url = "jdbc:mysql://buyme.cas20dm0rabg.us-east-1.rds.amazonaws.com:3306/buyMe";
	Connection conn = null;			
	PreparedStatement ps = null;
	PreparedStatement pwPs = null;
	ResultSet rs = null;
	try {
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		conn = DriverManager.getConnection(url, "cs336admin", "cs336password");
		
		String user = (session.getAttribute("user")).toString();
		String firstName = request.getParameter("first_name");
		String lastName = request.getParameter("last_name");
		String email = request.getParameter("email");
		String address = request.getParameter("address");
		String oldPassword = request.getParameter("old_password");
		String newPassword = request.getParameter("new_password");
		String confirmNewPassword = request.getParameter("confirm_new_password");
		
		String validation = "SELECT password FROM Account WHERE username=?";
		pwPs = conn.prepareStatement(validation);
		pwPs.setString(1, user);
		rs = pwPs.executeQuery();
		
		if (rs.next()) {
			String db_password = rs.getString("password");
			//System.out.println("DB password: " + db_password);
			//System.out.println("Old password enterd: " + oldPassword);
			if (!oldPassword.equals(db_password)) { %>
				<jsp:include page="accountSettings.jsp" flush="true"/>
				<div class="content center">
					<h1>Error: Old password is incorrect.</h1>
				</div>
	    <%    	return;
			}
		} else {
			// No account found with the current user's username
			// Should never happen
			response.sendRedirect("error.jsp");
			return;
		}
		
		if (!newPassword.equals(confirmNewPassword)) { %>
			<jsp:include page="accountSettings.jsp" flush="true"/>
			<div class="content center">
				<h1>Error: Failed to confirm new password. <br> Make sure you enter it correctly in both fields.</h1>
			</div>
	<%		return;
		} %>
	
	<%	
		String updateAccount = "UPDATE Account " 
				+ "SET first_name=?, last_name=?, email=?, address=?, password=? "
				+ "WHERE username=?";
		ps = conn.prepareStatement(updateAccount);
		ps.setString(1, firstName);
		ps.setString(2, lastName);
		ps.setString(3, email);
		ps.setString(4, address);
		ps.setString(5, newPassword);
		ps.setString(6, user);
		int updateResult = 0;
		updateResult = ps.executeUpdate();
		if (updateResult < 1) {
			// Failed to execute the update statement
			response.sendRedirect("error.jsp");
			return;
		} else { 
	%>
			<jsp:include page="account.jsp" flush="true"/>
			<div class="content center">
				<h1>Successfully updated your account settings.</h1>
			</div>
	<% 	}
		
		
	} catch(Exception e) {
		out.print("<p>Error connecting to MYSQL server.</p>");
	    e.printStackTrace();
	} finally {
		try { rs.close(); } catch (Exception e) {}
		try { ps.close(); } catch (Exception e) {}
		try { pwPs.close(); } catch (Exception e) {}
        try { conn.close(); } catch (Exception e) {}
	}
%>