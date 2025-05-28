-- Add Reviews table
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

-- Add Wishlist table
CREATE TABLE Wishlist (
    WishlistId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,
    ProductId INT NOT NULL,
    DateAdded DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (UserId) REFERENCES Users(UserId),
    FOREIGN KEY (ProductId) REFERENCES Products(ProductId),
    CONSTRAINT UQ_UserProduct UNIQUE (UserId, ProductId)
);

-- Add IsAdmin column to Users table
ALTER TABLE Users ADD IsAdmin BIT NOT NULL DEFAULT 0;

-- Create index for performance
CREATE INDEX IX_Reviews_ProductId ON Reviews(ProductId);
CREATE INDEX IX_Reviews_UserId ON Reviews(UserId);
CREATE INDEX IX_Wishlist_UserId ON Wishlist(UserId);
CREATE INDEX IX_Wishlist_ProductId ON Wishlist(ProductId); 