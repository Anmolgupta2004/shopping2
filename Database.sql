-- Create Database
CREATE DATABASE OnlineShoppingSite
GO

USE OnlineShoppingSite
GO

-- Create Users Table
CREATE TABLE Users (
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    Password NVARCHAR(100) NOT NULL
)
GO

-- Create Categories Table
CREATE TABLE Categories (
    CategoryId INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(50) NOT NULL
)
GO

-- Create Products Table
CREATE TABLE Products (
    ProductId INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Description NVARCHAR(MAX),
    CategoryId INT FOREIGN KEY REFERENCES Categories(CategoryId)
)
GO

-- Create Orders Table
CREATE TABLE Orders (
    OrderId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT FOREIGN KEY REFERENCES Users(UserId),
    ProductId INT FOREIGN KEY REFERENCES Products(ProductId),
    Quantity INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE()
)
GO

-- Insert Sample Data
INSERT INTO Categories (CategoryName) VALUES 
('Electronics'),
('Books'),
('Clothing'),
('Home & Kitchen')
GO

INSERT INTO Products (ProductName, Price, Description, CategoryId) VALUES
('Smartphone', 599.99, 'Latest smartphone with amazing features', 1),
('Laptop', 999.99, 'High-performance laptop for professionals', 1),
('Programming Book', 49.99, 'Learn programming from scratch', 2),
('T-Shirt', 19.99, 'Comfortable cotton t-shirt', 3),
('Coffee Maker', 79.99, 'Automatic coffee maker with timer', 4)
GO 