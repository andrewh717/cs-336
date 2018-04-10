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
	<div class="content">
    <% if(session.getAttribute("user") == null) { %>
   		<h1>BuyMe</h1>
   		<a href="login.jsp">Click here to login.</a>
    <% } else { %>
		<%@ include file="navbar.jsp" %>
		<form action="createActionHandler.jsp" method="POST">
			<select name="category">
				<option value="" disabled selected hidden="true">Choose category</option>
				<option value="formal">Dress Shoes</option>
				<option value="sneakers">Sneakers</option>
				<option value="sandals">Sandals</option>
				<option value="boots">Boots</option>
			</select> <br>
			<input type="text" name="brand" placeholder="Brand"> <br>
			<input type="radio" name="gender" value="Men's"> Men's <br>
			<input type="radio" name="gender" value="Women's"> Women's <br>
			<input type="radio" name="gender" value="Boys'"> Boys' <br>
			<input type="radio" name="gender" value="Girls'"> Girls' <br>
			<select name="size">
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
			<input type="text" name="model" placeholder="Model"> <br>
			<input type="text" name="color" placeholder="Color"> <br>
			<input type="submit" value="Submit">
		</form>
    <% } %>
    </div>
</body>
</html>