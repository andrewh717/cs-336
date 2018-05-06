<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
		
	<% 
		String url = "jdbc:mysql://buyme.cas20dm0rabg.us-east-1.rds.amazonaws.com:3306/buyMe";
		Connection conn = null;
		PreparedStatement ps = null;
			
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			conn = DriverManager.getConnection(url, "cs336admin", "cs336password");
			
			String username = (session.getAttribute("user")).toString();
			String question = request.getParameter("Question");

			if(username != null && !username.isEmpty() && question != null && !question.isEmpty()){
				
				String insert = "INSERT INTO Questions (user, question, answer)" + "VALUES (?, ?, ?)";
				
				ps = conn.prepareStatement(insert);
				
				ps.setString(1, username);
				ps.setString(2, question);
				ps.setString(3, "Awaiting answer from customer representative");
				
				int result = 0;
		        result = ps.executeUpdate();
		        if (result < 1) {
		        	out.println("Error: Question failed.");
		        } else {
		        	response.sendRedirect("questions.jsp?submit=success");
		        	return;
		        }
			} else {
				response.sendRedirect("questionError.jsp");
				return;
			}    
		} catch(Exception e) {
	        out.print("<p>Error connecting to MYSQL server.</p>" + e);
	        e.printStackTrace();
	    } finally {
	        try { ps.close(); } catch (Exception e) {}
	        try { conn.close(); } catch (Exception e) {}
	    }
		        
		        
	%>
