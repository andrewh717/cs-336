DROP DATABASE IF EXISTS buyMe;
CREATE DATABASE IF NOT EXISTS buyMe;
USE buyMe;

CREATE TABLE Account(
	username VARCHAR(50),
    password VARCHAR(128) BINARY NOT NULL,
    email VARCHAR(128) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    address VARCHAR(128) NOT NULL,
    access_level INT NOT NULL,
    PRIMARY KEY (username)
);

CREATE TABLE Product(
    productId INT AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    brand VARCHAR(25),
    seller VARCHAR(50),
    price DECIMAL(20,2) NOT NULL,
    sold BOOLEAN,
    PRIMARY KEY(productId, seller)
);

CREATE TABLE Bid(
	currentBid DECIMAL(20,2) NOT NULL,
	buyer VARCHAR(50),
	productId INT,
	FOREIGN KEY (buyer) REFERENCES Account(username)
		ON DELETE CASCADE,
	FOREIGN KEY (productId) REFERENCES Product(productId)
		ON DELETE CASCADE,
	PRIMARY KEY (currentBid, buyer, productId)
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
	productId INT,
	seller VARCHAR(50),
	price DECIMAL(20,2),
	date DATETIME,
	FOREIGN KEY (productId, seller) REFERENCES Product(productId, seller)
		ON DELETE CASCADE,
	FOREIGN KEY (price) REFERENCES Bid(currentBid),
    #FOREIGN KEY (productId) REFERENCES Bid(productId),
	PRIMARY KEY (seller, productId)
);

