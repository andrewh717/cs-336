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
		String currPassword = request.getParameter("curr_password");
		String newPassword = request.getParameter("new_password");
		String confirmNewPassword = request.getParameter("confirm_new_password");
	
		// Get the user's row from Account table
		String validation = "SELECT password FROM Account WHERE username=?";
		pwPs = conn.prepareStatement(validation);
		pwPs.setString(1, user);
		rs = pwPs.executeQuery();
		
		// Make sure the user entered the correct current password
		if (rs.next()) {
			String db_password = rs.getString("password");
			if (!currPassword.equals(db_password)) { %>
				<jsp:include page="accountSettings.jsp" flush="true"/>
				<div class="content center">
					<h1>
						<br>Error: Current password is incorrect.<br>
						You must enter your correct password to make changes to your account.
					</h1>
				</div>
	    <%    	return;
			} else if (currPassword.equals(newPassword)) { %>
				<jsp:include page="accountSettings.jsp" flush="true"/>
				<div class="content center">
					<h1>
						<br>Error: New password cannot be the same as current password.
					</h1>
				</div>
		<%	}
		} else {
			// No account found with the current user's username
			// Should never happen
			response.sendRedirect("error.jsp");
			return;
		}
		
		// Make sure the new password is entered correctly in the confirm box
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
		// Change password if the new password is different and is not empty/null
		if (newPassword.isEmpty() || newPassword == null) {
			ps.setString(5, currPassword);
		} else {
			ps.setString(5, newPassword);
		}
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