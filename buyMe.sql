DROP DATABASE IF EXISTS buyMe;
CREATE DATABASE IF NOT EXISTS buyMe;
USE buyMe;

DROP TABLE IF EXISTS Account;
CREATE TABLE Account(
	username VARCHAR(50),
    password VARCHAR(128) BINARY NOT NULL,
    email VARCHAR(128) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    address VARCHAR(128) NOT NULL,
    active BOOLEAN NOT NULL,
    access_level INT NOT NULL,
    PRIMARY KEY (username)
);

SET foreign_key_checks = 0;
DROP TABLE IF EXISTS Product;
CREATE TABLE Product(
	productId INT AUTO_INCREMENT,
	category VARCHAR(50) NOT NULL,
	brand VARCHAR(25),
	model VARCHAR(50) NOT NULL,
	gender VARCHAR(10) NOT NULL,
    size INT,
    color VARCHAR(20),
	seller VARCHAR(50) NOT NULL,
    min_price DECIMAL (20,2) NOT NULL,
	price DECIMAL(20,2) NOT NULL,
	sold BOOLEAN,
    startDate DATETIME,
    endDate DATETIME,
	PRIMARY KEY(productId, seller)
);
SET foreign_key_checks = 1;

DROP TABLE IF EXISTS Bid;
CREATE TABLE Bid(
	productId INT,
	buyer VARCHAR(50),
	currentBid DECIMAL(20,2),
    date DATETIME,
	FOREIGN KEY (buyer) REFERENCES Account(username)
		ON DELETE CASCADE,
	FOREIGN KEY (productId) REFERENCES Product(productId)
		ON DELETE CASCADE,
	PRIMARY KEY (productId)
);

DROP TABLE IF EXISTS BuyingHistory;
CREATE TABLE BuyingHistory(
	productId INT,
	price DECIMAL(20,2) NOT NULL,
	buyer VARCHAR(50),
	date DATETIME,
	FOREIGN KEY (buyer) REFERENCES Account(username)
		ON DELETE CASCADE,
	PRIMARY KEY (productId)
);

DROP TABLE IF EXISTS SellingHistory;
CREATE TABLE SellingHistory(
	productId INT,
	seller VARCHAR(50),
	price DECIMAL(20,2) NOT NULL,
	date DATETIME,
	FOREIGN KEY (seller) REFERENCES Account(username)
		ON DELETE CASCADE,
	PRIMARY KEY (productId)
);

DROP TABLE IF EXISTS Email;
CREATE TABLE Email(
	messageId INT AUTO_INCREMENT,
	to_username VARCHAR(50),
    from_username VARCHAR(50),
    message VARCHAR(200) NOT NULL,
    PRIMARY KEY (messageId)
);

DROP TABLE IF EXISTS BidHistory;
CREATE TABLE BidHistory(
    productId INT,
    buyer VARCHAR(50),
	bid DECIMAL(20,2),
    date DATETIME,
    PRIMARY KEY(bid, productId)
);

DROP TABLE IF EXISTS Alerts;
CREATE TABLE Alerts(
	productId INT,
    seller VARCHAR(50) NOT NULL,
    buyer VARCHAR(50) NOT NULL,
    min_price DECIMAL(20,2) NOT NULL,
    current_price DECIMAL(20,2),
    sold BOOLEAN NOT NULL,
    seen BOOLEAN DEFAULT FALSE,
    PRIMARY KEY(productId)
);

# Does not allow negative prices and checks for duplicate productId's
DROP TRIGGER IF EXISTS PriceCheck;
DELIMITER $$
	CREATE TRIGGER PriceCheck BEFORE INSERT ON Product
	FOR EACH ROW
	BEGIN
		IF NEW.price<0
		THEN
			BEGIN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Price cannot be negative';
			END;
		ELSEIF (EXISTS(
			SELECT P.productId
			FROM Product P
			WHERE P.productId=NEW.productId
		))THEN
			BEGIN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='ProductId already exists';
			END;
		ELSEIF (NEW.startDate>NEW.endDate)
		THEN
			BEGIN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='The end date cannot be before the start date';
            END;
		END IF; 
	END; $$
DELIMITER ;

# After the item gets sold, places it in the buying/selling history tables and deletes it from bid table
DROP TRIGGER IF EXISTS SoldItems;
DELIMITER $$
	CREATE TRIGGER SoldItems AFTER UPDATE ON Product
    FOR EACH ROW 
    BEGIN
		IF NEW.sold=true
		THEN
			BEGIN
				INSERT INTO BuyingHistory (price, buyer, productId, date)
				SELECT B.currentBid, B.buyer, B.productId, NOW()
				FROM Bid B
				WHERE B.productId=NEW.productId;
				
				INSERT INTO SellingHistory (productId, seller, price, date)
				SELECT P.productId, P.seller, P.price, NOW()
				FROM Product P
				WHERE P.productId=NEW.productId;
				
				DELETE FROM Bid WHERE productId=NEW.productId;
			END;
		END IF; 
	END; $$
DELIMITER ;

# Updates the price after a new bid, and prevents placing bid lower than existing bid
DROP TRIGGER IF EXISTS UpdatingPrice;
DELIMITER $$
	CREATE TRIGGER UpdatingPrice AFTER UPDATE ON Bid
    FOR EACH ROW
    BEGIN
		IF (NEW.currentBid>OLD.currentBid)
		THEN 
			BEGIN
				UPDATE Product
				SET price=NEW.currentBid
				WHERE NEW.productId=productId;
			END;
		ELSEIF (NEW.currentBid<=OLD.currentBid)
		THEN
			BEGIN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='The new bid is lower than the current bid';
			END;
		END IF;
	END; $$
DELIMITER ;

# Prevents from starting a bid for lower than the min_bid and updates the price in Product if the new bid is higher
DROP TRIGGER IF EXISTS NewBid;
DELIMITER $$
	CREATE TRIGGER NewBid BEFORE INSERT ON Bid
    FOR EACH ROW
    BEGIN
		IF (NEW.currentBid<(SELECT P.price
							FROM Product P
                            WHERE P.productId=NEW.productId))
        THEN 
			BEGIN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='The new bid is lower than the current bid';
			END;
		ELSEIF(NEW.currentBid>(SELECT P.price
								FROM Product P
								WHERE P.productId=NEW.productId))
		THEN
			BEGIN
				UPDATE Product
				SET price=NEW.currentBid
				WHERE NEW.productId=productId;
                
                INSERT INTO BidHistory VALUES(NEW.currentBid, NEW.buyer, NEW.productId, NOW());
            END;
		END IF;
	END; $$
DELIMITER ;

# Prevents deleting an admin account
DROP TRIGGER IF EXISTS AdminAccount;
DELIMITER $$
	CREATE TRIGGER AdminAccount BEFORE DELETE ON Account
    FOR EACH ROW
    BEGIN
		IF OLD.access_level=3
        THEN
			BEGIN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Cannot delete an admin account';
            END;
		END IF; 
	END; $$
DELIMITER ;

# Adds all the expired auctions into Alerts table in order to notify the users 
# about the end of the auction they were involved in.
DROP TRIGGER IF EXISTS Alert;
DELIMITER $$
	CREATE TRIGGER Alert BEFORE DELETE ON Bid
    FOR EACH ROW
    BEGIN
		INSERT INTO Alerts (productId,seller,buyer,min_price,current_price,sold,seen)
		SELECT P.productId, P.seller, OLD.buyer, P.min_price, P.price, P.sold, false
		FROM Product P
		WHERE P.productId=OLD.productId;
    END; $$
DELIMITER ;

# An event that goes on once a day and removes the bids that are pastdue
DROP EVENT IF EXISTS PastDue;
DELIMITER $$
	CREATE EVENT PastDue 
	ON SCHEDULE EVERY 1 MINUTE STARTS NOW()
	COMMENT 'Delets pastdue bids'
	DO
		BEGIN
            UPDATE Product SET sold=true WHERE NOW()>endDate AND price>min_price;
			DELETE FROM Product WHERE NOW()>endDate AND price<min_price;
		END; $$
DELIMITER ;

# For testing purposes
/*
# Testing tuples
INSERT INTO Product VALUES(3,'testboot','shoe','ra','M',4,'black','roslan',25,false,'2018-03-05 01:00:00','2018-03-04 05:00:00');
INSERT INTO Bid VALUES(30,'test',1);

# To clean up
DELETE FROM Product WHERE productId=21;
DELETE FROM SellingHistory WHERE productId=1 AND seller='roslan';
DELETE FROM BuyingHistory WHERE productId=1 AND buyer='test';
DELETE FROM Account WHERE username='roslan';
DELETE FROM BidHistory WHERE productId=6;

# Testing the triggers
UPDATE Product
SET sold=true
WHERE productId=1;

UPDATE Bid
SET currentBid=50
WHERE productId=1;

SELECT *
FROM Product;

SELECT NOW();
SET @@session.time_zone = '-04:00';
SELECT @@session.time_zone;
SELECT @@global.time_zone;

SELECT *
FROM Bid;

SELECT *
FROM BidHistory;

SELECT *
FROM BuyingHistory;

SELECT *
FROM SellingHistory;

SELECT *
FROM Account;

UPDATE Account SET access_level=3 WHERE username='test';
*/