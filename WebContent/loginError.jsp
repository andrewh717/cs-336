<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>BuyMe - Login Error</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
	<div class="content center">
        <h2>Error: Login failed. Username or password is incorrect.</h2>
        <form action="loginHandler.jsp" method="POST">
        	<input type="text" name="username" placeholder="Username"> <br>
        	<input type="password" name="password" placeholder="Password"> <br>
        	<input type="submit" value="Login">
        </form>
        <a href="register.jsp">Don't have an account? Register here.</a>
    </div>
</body>
</html>