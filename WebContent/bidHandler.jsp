<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
	String url = "jdbc:mysql://buyme.cas20dm0rabg.us-east-1.rds.amazonaws.com:3306/buyMe";
	Connection conn = null;			
	PreparedStatement ps1 = null;
	PreparedStatement ps2 = null;
	PreparedStatement queryPs = null;
	PreparedStatement alertPs = null;
	PreparedStatement autoPs = null;
	
	ResultSet rs = null;
	ResultSet autoRs = null;
	try {
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		conn = DriverManager.getConnection(url, "cs336admin", "cs336password");
	
		int productId = Integer.parseInt(request.getParameter("productId"));
		String bidder = request.getParameter("bidder");
		float newBid = Float.parseFloat(request.getParameter("bid"));
		Timestamp date = new Timestamp(new java.util.Date().getTime());
		
		// Insert new bid
		String insertNewBid = "INSERT INTO Bid VALUES (?, ?, ?, ?)";
		ps1 = conn.prepareStatement(insertNewBid);
		ps1.setInt(1, productId);
		ps1.setString(2, bidder);
		ps1.setFloat(3, newBid);
		ps1.setTimestamp(4, date);
		int insertResult = 0;
		insertResult = ps1.executeUpdate();
		
		// Check if auto-bid was setup
		String auto = request.getParameter("auto");
		if (auto != null && auto.equals("true")) {
			float maxBid = Float.parseFloat(request.getParameter("maxBid"));
			//System.out.println("MaxBid = " + maxBid);
			float increment = Float.parseFloat(request.getParameter("bidIncrement"));
			//System.out.println("Increment = " + increment);
			String setupAutoBid = "INSERT INTO AutoBidding (user, productId, max_price, incremental) VALUES (?, ?, ?, ?)";
			autoPs = conn.prepareStatement(setupAutoBid);
			autoPs.setString(1, bidder);
			autoPs.setInt(2, productId);
			autoPs.setFloat(3, maxBid);
			autoPs.setFloat(4, increment);
			int insertAutoBidSetup = autoPs.executeUpdate();
		}
		
		if (insertResult < 1) {
			response.sendRedirect("error.jsp"); // This happens if the insert fails
		} else if (!Boolean.parseBoolean((request.getParameter("isStartingBid")))) {
			String prevBidder = null;
			float prevBid = 0;
			String queryOldBid = "SELECT * FROM Bid WHERE productId=? AND currentBid!=?";
			queryPs = conn.prepareStatement(queryOldBid);
			queryPs.setInt(1, productId);
			queryPs.setFloat(2, newBid);
			rs = queryPs.executeQuery();
			if (rs.next()) {
				prevBidder = rs.getString("buyer");
				prevBid = rs.getFloat("currentBid");
			}
			
			String deleteOldBid = "DELETE FROM Bid WHERE productId=? AND currentBid!=?";
			ps2 = conn.prepareStatement(deleteOldBid);
			ps2.setInt(1, productId);
			ps2.setFloat(2, newBid);
			int deleteResult = 0;
			deleteResult = ps2.executeUpdate();
			if (deleteResult < 1) {
				response.sendRedirect("error.jsp"); // This should never happen
			} else {
				// Query the AutoBidding table to see if prevBidder & productId appear in a tuple
				boolean prevHasAuto;
				float increment = 0;
				float maxPrice = 0;
				String queryAutoBid = "SELECT * FROM AutoBidding WHERE user=? AND productId=?";
				autoPs = conn.prepareStatement(queryAutoBid);
				autoPs.setString(1, prevBidder);
				autoPs.setInt(2, productId);
				autoRs = autoPs.executeQuery();
				if (autoRs.next()) {
					prevHasAuto = true;
					increment = autoRs.getFloat("incremental");
					maxPrice = autoRs.getFloat("max_price");
				} else {
					prevHasAuto = false;
				}
				
				// Automatically outbid this new bid if the prev bidder had auto-bid setup
				if (prevBidder!= null && !prevBidder.equals(bidder) && prevHasAuto == true) {
					String insertAutoBid = "INSERT INTO Bid VALUES (?, ?, ?, ?)";
					autoPs = conn.prepareStatement(insertNewBid);
					autoPs.setInt(1, productId);
					autoPs.setString(2, prevBidder);
					if (newBid + increment <= maxPrice) {
						newBid = newBid + increment;
					} else {
						newBid = maxPrice;
					}
					autoPs.setFloat(3, newBid);
					
					Timestamp dateAuto = new Timestamp(new java.util.Date().getTime());
					autoPs.setTimestamp(4, dateAuto);
					int autoInsertResult = 0;
					autoInsertResult = autoPs.executeUpdate();
					
					deleteOldBid = "DELETE FROM Bid WHERE productId=? AND currentBid!=?";
					ps2.close();
					ps2 = conn.prepareStatement(deleteOldBid);
					ps2.setInt(1, productId);
					ps2.setFloat(2, newBid);
					deleteResult = 0;
					deleteResult = ps2.executeUpdate();
					if (deleteResult < 1) {
						response.sendRedirect("error.jsp"); // This should never happen
					}					
					String outBidAlert = "INSERT INTO Alerts (user, message) VALUES (?, ?)";
					alertPs = conn.prepareStatement(outBidAlert);
					alertPs.setString(1, bidder);
					alertPs.setString(2, "You have been outbid. <a href=\"auction.jsp?productId=" +  productId + "  \">Click here to go to the auction page.</a>");
					int alertResult = 0;
					alertResult = alertPs.executeUpdate();
				}
				
				// Alert the person who got outbid (if that person is not the one who just placed the bid)
				if ((prevBidder!= null && !prevBidder.equals(bidder) && prevHasAuto == false) || 
					(prevBidder!= null && !prevBidder.equals(bidder) && prevHasAuto == true && prevBid == maxPrice)) {
					String outBidAlert = "INSERT INTO Alerts (user, message) VALUES (?, ?)";
					alertPs = conn.prepareStatement(outBidAlert);
					alertPs.setString(1, prevBidder);
					alertPs.setString(2, "You have been outbid. <a href=\"auction.jsp?productId=" +  productId + "  \">Click here to go to the auction page.</a>");
					int alertResult = 0;
					alertResult = alertPs.executeUpdate();
				}
				
				// Bid placed successfully, redirect to auction page
				response.sendRedirect("auction.jsp?productId=" + productId + "&bid=success");
			}			
		} else {
			// Bid placed successfully, redirect to auction page
			response.sendRedirect("auction.jsp?productId=" + productId + "&bid=success");
		}
	} catch(Exception e) {
		out.print("<p>Error connecting to MYSQL server.</p>");
	    e.printStackTrace();
	} finally {
		try { ps1.close(); } catch (Exception e) {}
		try { ps2.close(); } catch (Exception e) {}
        try { conn.close(); } catch (Exception e) {}
	}
%>