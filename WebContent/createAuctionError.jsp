<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuyMe - Creating Auction Error</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="content center">
    	<h2>Error: Creating auction failed. Please enter the correct information and try again.</h2>
        <form action="createAuctionHandler.jsp" method="POST">
            <label for="category">Category</label>
            <input type="text" name="category" id="category" placeholder="Category"> <br>
    
            <label>Brand</label>
            <input type="text" name="brand" placeholder="Brand"> <br>
    
            <label>Gender</label>
            <input type="text" name="gender" placeholder="Gender"> <br>
    
            <label for="Size">Size</label>
            <input type="text" name="size" placeholder="Size"> <br>
            
            <label for="model">Model</label>
            <input type="text" name="model" id="model" placeholder="Model"> <br>
    
            <label>color</label>
            <input type="text" name="color" placeholder="Color"> <br>
    
            <label>endDateTime</label>
            <input type="text" name="endDateTime" placeholder="End Date Time"> <br>
            
            <label>endDateTime</label>
            <input type="text" name="reserve" placeholder="Reserve"> <br>
    
            <input type="submit" value="Create Auction">
        </form>
    </div>
	
</body>
</html>