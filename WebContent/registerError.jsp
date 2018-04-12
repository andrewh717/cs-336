<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuyMe - Register Error</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="content center">
    	<h2>Error: Registration failed. Please enter the correct information and try again.</h2>
        <form action="registerHandler.jsp" method="POST">
            <label for="first_name">First Name</label>
            <input type="text" name="first_name" id="first_name" placeholder="First Name"> <br>
    
            <label>Last Name</label>
            <input type="text" name="last_name" placeholder="Last Name"> <br>
    
            <label>Email</label>
            <input type="text" name="email" placeholder="Email"> <br>
    
            <label for="Address">Address</label>
            <input type="text" name="address" placeholder="Address"> <br>
            
            <label for="username">Username</label>
            <input type="text" name="username" id="username" placeholder="Username"> <br>
    
            <label>Password</label>
            <input type="password" name="password" placeholder="Password"> <br>
    
            <label>Confirm Password</label>
            <input type="password" name="confirm_password" placeholder="Confirm Password"> <br>
    
            <input type="submit" value="Register">
        </form>
    </div>
	
</body>
</html>