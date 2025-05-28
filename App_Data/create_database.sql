-- Create database
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'OnlineShoppingSite')
BEGIN
    CREATE DATABASE OnlineShoppingSite;
END
GO

USE OnlineShoppingSite;
GO

-- Create Users table
CREATE TABLE Users (
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    Password NVARCHAR(100) NOT NULL,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    IsAdmin BIT NOT NULL DEFAULT 0
);

-- Create Categories table
CREATE TABLE Categories (
    CategoryId INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(50) NOT NULL,
    Description NVARCHAR(500)
);

-- Create Products table
CREATE TABLE Products (
    ProductId INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(1000),
    Price DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL DEFAULT 0,
    CategoryId INT,
    ImageUrl NVARCHAR(200),
    FOREIGN KEY (CategoryId) REFERENCES Categories(CategoryId)
);

-- Create Orders table
CREATE TABLE Orders (
    OrderId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,
    ProductId INT NOT NULL,
    Quantity INT NOT NULL,
    OrderDate DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (UserId) REFERENCES Users(UserId),
    FOREIGN KEY (ProductId) REFERENCES Products(ProductId)
);

-- Create Reviews table
CREATE TABLE Reviews (
    ReviewId INT IDENTITY(1,1) PRIMARY KEY,
    ProductId INT NOT NULL,
    UserId INT NOT NULL,
    Rating INT NOT NULL CHECK (Rating BETWEEN 1 AND 5),
    ReviewText NVARCHAR(1000) NOT NULL,
    ReviewDate DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (ProductId) REFERENCES Products(ProductId),
    FOREIGN KEY (UserId) REFERENCES Users(UserId)
);

-- Create Wishlist table
CREATE TABLE Wishlist (
    WishlistId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,
    ProductId INT NOT NULL,
    DateAdded DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (UserId) REFERENCES Users(UserId),
    FOREIGN KEY (ProductId) REFERENCES Products(ProductId),
    CONSTRAINT UQ_UserProduct UNIQUE (UserId, ProductId)
);

-- Insert sample data
-- Create admin user (password: Admin@123)
INSERT INTO Users (Email, Password, FirstName, LastName, IsAdmin)
VALUES ('admin@example.com', 'jGl25bVBBBW96Qi9Te4V37Fnqchz/Eu4qB9vKrRIqRg=', 'Admin', 'User', 1);

-- Create categories
INSERT INTO Categories (CategoryName, Description) VALUES
('Electronics', 'Electronic devices and accessories'),
('Books', 'Physical and digital books'),
('Clothing', 'Men''s and women''s clothing'),
('Home & Kitchen', 'Home appliances and kitchen items');

-- Create products
INSERT INTO Products (ProductName, Description, Price, Stock, CategoryId) VALUES
('Smartphone', 'Latest model smartphone with advanced features', 699.99, 50, 1),
('Laptop', 'High-performance laptop for work and gaming', 1299.99, 30, 1),
('Novel', 'Bestselling fiction novel', 19.99, 100, 2),
('T-Shirt', 'Cotton casual t-shirt', 24.99, 200, 3),
('Coffee Maker', 'Automatic drip coffee maker', 79.99, 40, 4);

-- Create indexes for performance
CREATE INDEX IX_Products_CategoryId ON Products(CategoryId);
CREATE INDEX IX_Orders_UserId ON Orders(UserId);
CREATE INDEX IX_Orders_ProductId ON Orders(ProductId);
CREATE INDEX IX_Reviews_ProductId ON Reviews(ProductId);
CREATE INDEX IX_Reviews_UserId ON Reviews(UserId);
CREATE INDEX IX_Wishlist_UserId ON Wishlist(UserId);
CREATE INDEX IX_Wishlist_ProductId ON Wishlist(ProductId); 