<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Hello World</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
	<div class="content center">
        <h1>Hello World</h1> <br>
        <form action="login.jsp" method="POST">
        	<input type="text" placeholder="Username"> <br>
        	<input type="password" placeholder="Password"> <br>
        	<input type="submit" value="Login">
        </form>
        
        <input type="submit" value="Register">
    </div>
</body>
</html>