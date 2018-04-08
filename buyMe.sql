DROP DATABASE IF EXISTS buyMe;
CREATE DATABASE IF NOT EXISTS buyMe;
USE buyMe;

CREATE TABLE account (
	username VARCHAR(50) PRIMARY KEY,
    password VARCHAR(128) NOT NULL,
    email VARCHAR(128) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    address VARCHAR(128) NOT NULL,
    access_level INT NOT NULL
);

CREATE TABLE product (
    productId INT AUTO_INCREMENT KEY,
    name VARCHAR(50) NOT NULL,
    brand VARCHAR(25),
    seller VARCHAR(25) NOT NULL,
    price DECIMAL(20,2) NOT NULL
)