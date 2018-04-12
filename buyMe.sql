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
    access_level INT NOT NULL,
    PRIMARY KEY (username)
);

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
	price DECIMAL(20,2) NOT NULL,
	sold BOOLEAN,
    startDate DATETIME,
    endDate DATETIME,
    FOREIGN KEY (seller) REFERENCES Account(username)
		ON DELETE CASCADE,
	PRIMARY KEY(productId, seller)
);

DROP TABLE IF EXISTS Bid;
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

DROP TABLE IF EXISTS BuyingHistory;
CREATE TABLE BuyingHistory(
	productId INT,
	price DECIMAL(20,2) NOT NULL,
	buyer VARCHAR(50),
	date DATETIME,
	FOREIGN KEY (productId) REFERENCES Product(productId)
		ON DELETE CASCADE,
	FOREIGN KEY (buyer) REFERENCES Account(username)
		ON DELETE CASCADE,
	PRIMARY KEY (buyer, productId)
);

DROP TABLE IF EXISTS SellingHistory;
CREATE TABLE SellingHistory(
	productId INT,
	seller VARCHAR(50),
	price DECIMAL(20,2) NOT NULL,
	date DATETIME,
	FOREIGN KEY (productId, seller) REFERENCES Product(productId, seller)
		ON DELETE CASCADE,
	PRIMARY KEY (seller, productId)
);

DROP TABLE IF EXISTS Email;
CREATE TABLE Email(
	messageId INT AUTO_INCREMENT,
	to_username VARCHAR(50),
    from_username VARCHAR(50),
    message VARCHAR(200) NOT NULL,
    FOREIGN KEY (to_username) REFERENCES Account(username),
    FOREIGN KEY (from_username) REFERENCES Account(username),
    PRIMARY KEY (messageId, to_username, from_username)
);


DROP TRIGGER IF EXISTS PriceCheck;
DELIMITER $$
	CREATE TRIGGER PriceCheck AFTER INSERT ON Product
	FOR EACH ROW
	BEGIN
	IF NEW.price<0
	THEN
		BEGIN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Price cannot be negative';
		END;
	END IF; 
END $$
DELIMITER ;

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
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS Checking;
DELIMITER $$
	CREATE TRIGGER Checking BEFORE INSERT ON Product
    FOR EACH ROW
    BEGIN
    IF (EXISTS(
		SELECT P.productId
		FROM Product P
        WHERE P.productId=NEW.productId
	))THEN
		BEGIN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='ProductId already exists';
		END;
	END IF; 
END $$
DELIMITER ;

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
	END IF;
END $$
DELIMITER ;

# For testing purposes
/*
INSERT INTO Product VALUES(1,'testboot','shoe','ra','M',4,'ras','black','roslan',5,false,'2018-03-05 01:01:01','2018-03-05 01:05:01');
INSERT INTO Bid VALUES(5,'test',1);

DELETE FROM Product WHERE productId=1;
DELETE FROM SellingHistory WHERE productId=1 AND seller='roslan';
DELETE FROM BuyingHistory WHERE productId=1 AND buyer='test';

UPDATE Product
SET sold=true
WHERE productId=1;

UPDATE Bid
SET currentBid=6
WHERE productId=1;

SELECT *
FROM Product;

SELECT *
FROM Bid;

SELECT *
FROM BuyingHistory;

SELECT *
FROM SellingHistory;

SELECT *
FROM Account;
*/