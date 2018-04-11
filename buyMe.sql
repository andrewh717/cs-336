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
	category VARCHAR(50) NOT NULL,
	brand VARCHAR(25),
	gender VARCHAR(10) NOT NULL,
    size INT,
    model VARCHAR(50),
    color VARCHAR(20),
	seller VARCHAR(50) NOT NULL,
	price DECIMAL(20,2) NOT NULL,
	sold BOOLEAN,
	PRIMARY KEY(productId, seller)
);

CREATE TABLE Bid(
	currentBid DECIMAL(20,2),
	buyer VARCHAR(50),
	productId INT,
	FOREIGN KEY (buyer) REFERENCES Account(username)
		ON DELETE CASCADE,
	FOREIGN KEY (productId) REFERENCES Product(productId)
		ON DELETE CASCADE,
	PRIMARY KEY (currentBid, buyer, productId)
);

CREATE TABLE BuyingHistory(
	price DECIMAL(20,2) NOT NULL,
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
	price DECIMAL(20,2) NOT NULL,
	date DATETIME,
	FOREIGN KEY (productId, seller) REFERENCES Product(productId, seller)
		ON DELETE CASCADE,
	FOREIGN KEY (price) REFERENCES Bid(currentBid),
	PRIMARY KEY (seller, productId)
);

CREATE TABLE Email(
	messageId INT AUTO_INCREMENT,
	to_username VARCHAR(50),
    from_username VARCHAR(50),
    message VARCHAR(200) NOT NULL,
    FOREIGN KEY (to_username) REFERENCES Account(username),
    FOREIGN KEY (from_username) REFERENCES Account(username),
    PRIMARY KEY (messageId, to_username, from_username)
);

DROP TABLE IF EXISTS BadPrice;
CREATE TABLE BadPrice(
	productId INT,
    name VARCHAR(50) NOT NULL,
	category VARCHAR(50) NOT NULL,
	brand VARCHAR(25),
	gender VARCHAR(10) NOT NULL,
    size INT,
    model VARCHAR(50),
    color VARCHAR(20),
	seller VARCHAR(50) NOT NULL,
	price DECIMAL(20,2) NOT NULL,
    FOREIGN KEY (productId) REFERENCES Product(productId),
	PRIMARY KEY(productId)
);

DELIMITER $$
	CREATE TRIGGER PriceCheck AFTER INSERT ON Product
	FOR EACH ROW
	BEGIN
	IF NEW.price<0
	THEN
		BEGIN
			INSERT INTO BadPrice VALUES(NEW.productId,NEW.name,NEW.category,NEW.brand,NEW.gender,NEW.size,NEW.model,NEW.color,NEW.seller,NEW.price);
			DELETE FROM Product P WHERE P.productId=NEW.productId;
		END;
	END IF;
delimiter ;


#DROP TABLE Shoes;
/*CREATE TABLE Shoes(
	productId INT,
	category VARCHAR(50) NOT NULL,
    brand VARCHAR(50),
    size INT,
    model VARCHAR(50),
    color VARCHAR(50),
    FOREIGN KEY (productId) REFERENCES Product(productId)
		ON DELETE CASCADE,
	PRIMARY KEY(productId)
);*/
