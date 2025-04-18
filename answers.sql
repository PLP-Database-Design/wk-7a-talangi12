Qusetion 1 Create a new table to represent the data in 1NF
CREATE TABLE OrderProducts (
    OrderID INT,
    CustomerName VARCHAR(255),
    Product VARCHAR(255)
);
 ---Insert data into the OrderProducts table by splitting the Products column
INSERT INTO OrderProducts (OrderID, CustomerName, Product)
SELECT OrderID, CustomerName, SUBSTRING_INDEX(Products, ',', n) AS Product
FROM ProductDetail
CROSS JOIN (
    SELECT 1 AS n UNION ALL
    SELECT 2 UNION ALL
    SELECT 3 UNION ALL
    SELECT 4 -- Add more UNION ALL statements if you expect more than 4 products
) AS numbers
WHERE LENGTH(Products) - LENGTH(REPLACE(Products, ',', '')) >= n - 1;




Question 2
-- Create the Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

-- Insert data into the Orders table
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Create the OrderItems table
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    PRIMARY KEY (OrderID, Product), 
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) 
);

-- Insert data into the OrderItems table
INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;
