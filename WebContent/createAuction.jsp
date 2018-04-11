<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>BuyMe - Create Auction</title>
	<link rel="stylesheet" href="style.css?v=1.0"/>
</head>
<body>
     <% if(session.getAttribute("user") == null) {
    	 	response.sendRedirect("login.jsp");
        } else { %>
    	<%@ include file="navbar.jsp" %>
    	<div class="content">
			<form action="createAuctionHandler.jsp" method="POST">
				<label for="category">Category</label>
				<select name="category" id="category" required>
					<option value="" disabled selected hidden="true">Select category</option>
					<option value="formal">Dress Shoes</option>
					<option value="sneakers">Sneakers</option>
					<option value="sandals">Sandals</option>
					<option value="boots">Boots</option>
				</select> <br>
				<label for="brand">Brand</label>
				<select name="brand" id="brand" required>
					<option value="" disabled selected hidden="true">Select brand</option>
					<option value="adidas">Adidas</option>
					<option value="asics">Asics</option>
					<option value="ecco">Ecco</option>
					<option value="newBalance">New Balance</option>
					<option value="nike">Nike</option>
					<option value="puma">Puma</option>
					<option value="reebok">Reebok</option>
					<option value="vans">Vans</option>
					<option value="other">Other</option>
				</select> <br>
				<input type="radio" name="gender" value="Men's"> Men's <br>
				<input type="radio" name="gender" value="Women's"> Women's <br>
				<input type="radio" name="gender" value="Boys'"> Boys' <br>
				<input type="radio" name="gender" value="Girls'"> Girls' <br>
				<label for="size">Size</label>
				<select name="size" id="size" required>
					<option value="" disabled selected hidden="true">Select size</option>
					<option value="">4</option>
					<option value="">4.5</option>
					<option value="">5</option>
					<option value="">5.5</option>
					<option value="">6</option>
					<option value="">6.5</option>
					<option value="">7</option>
					<option value="">7.5</option>
					<option value="">8</option>
					<option value="">8.5</option>
					<option value="">9</option>
					<option value="">9.5</option>
					<option value="">10</option>
					<option value="">10.5</option>
					<option value="">11</option>
					<option value="">11.5</option>
					<option value="">12</option>
					<option value="">12.5</option>
					<option value="">13</option>
				</select> <br>
				<label for="model">Model</label>
				<input type="text" name="model" id="model" placeholder="Enter model name" required> <br>
				<label for="color">Color</label>
				<input type="text" name="color" id="color" placeholder="Enter color(s)" required> <br>
				<label for="start_datetime">Start Date and Time</label>
				<input type="datetime-local" name="start_datetime" id="start_datetime" required> <br>
				<label for="end_datetime">End Date and Time</label>
				<input type="datetime-local" name="end_datetime" id="end_datetime" required> <br>
				<label for="min_price">Minimum Bid Price</label>
				<input type="number" name="min_price" placeholder="0.00" min="0.00" required> <br>
				<input type="submit" value="Submit">
			</form>
		</div>
    <% } %>
</body>
</html>