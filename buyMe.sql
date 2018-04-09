DROP DATABASE IF EXISTS buyMe;
CREATE DATABASE IF NOT EXISTS buyMe;
USE buyMe;

CREATE TABLE Account (
	username VARCHAR(50) PRIMARY KEY,
    password VARCHAR(128) BINARY NOT NULL,
    email VARCHAR(128) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    address VARCHAR(128) NOT NULL,
    access_level INT NOT NULL
);

CREATE TABLE Product (
    productId INT AUTO_INCREMENT KEY,
    name VARCHAR(50) NOT NULL,
    brand VARCHAR(25),
    seller VARCHAR(50) NOT NULL,
    price DECIMAL(20,2) NOT NULL,
    sold BOOLEAN
);

CREATE TABLE Bid(
	currentBid DECIMAL(20,2) NOT NULL,
	buyer VARCHAR(50),
	productId INT,
	FOREIGN KEY (buyer) REFERENCES Account(username)
		ON DELETE CASCADE,
	FOREIGN KEY (productId) REFERENCES Product(productId)
		ON DELETE CASCADE,
	PRIMARY KEY (productId, currentBid)
);

CREATE TABLE BuyingHistory(
	price DECIMAL(20,2),
	buyer VARCHAR(50),
	productId INT,
	date DATETIME,
	FOREIGN KEY (price, buyer, productId) REFERENCES Bid(currentBid, buyer, productId)
		ON DELETE CASCADE,
	PRIMARY KEY (buyer, productId)
);

CREATE TABLE SellingHistory(
	seller VARCHAR(50),
	productId INT,
	price DECIMAL(20,2),
	date DATETIME,
	FOREIGN KEY (seller) REFERENCES Product(seller)
		ON DELETE CASCADE,
	FOREIGN KEY (price, productId) REFERENCES Bid(currentBid, productId),
	PRIMARY KEY (seller, productId)
);

