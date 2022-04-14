CREATE DATABASE ECommerce

USE ECommerce

CREATE TABLE Category(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(50)
)

CREATE TABLE Product(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(50),
Model NVARCHAR(50),
CostPrice INT,
SalePrice INT,
CategoryId INT FOREIGN KEY REFERENCES Category(Id)
)

CREATE TABLE Cart(
    Id INT PRIMARY KEY IDENTITY,
    ProductId INT FOREIGN KEY REFERENCES Product(Id)
)

INSERT into Category
VALUES  ('Phone')

INSERT into Category
VALUES  ('Tablet'), ('Headphone')

INSERT into Category
VALUES  ('Notebook')

SELECT * FROM Product

INSERT into Product
VALUES  ('Apple', 'IPhone SE', 1000, 1700,1),
        ('Xiaomi', 'Mi 9 lite', 400,700,1),
        ('Samsung', 'A70', 500, 700,1),
        ('Nokia', '6300', 40, 60,2),
        ('LG', '46', 75, 567,2),
        ('Beats','Studio Buds', 100, 145,3),
        ('JBL', 'Tune 190BT', 70, 120,3),
        ('Honor', 'Magicbook', 1000,1300,4),
        ('Apple', 'MacBook', 1200,1500,4),
        ('HP','IdeaPad',700, 1000, 4)

INSERT into Cart
VALUES  (1),(2),(3)

drop TABLE Cart
SELECT * FROM Cart

CREATE VIEW ProductDetails
AS
Select 
        Product.Name,
        Product.Model,
        Product.CostPrice,
        Product.SalePrice
        
 from Cart
JOIN Product on Cart.ProductId = Product.Id



CREATE PROCEDURE SumOfPrice
AS
SELECT SUM(Product.CostPrice)
FROM Cart
JOIN Product on Cart.ProductId = Product.Id

EXEC SumOfPrice



DECLARE @InputId INT

CREATE PROCEDURE SetProductToCardWithId
(@InputId int = 1)
AS
BEGIN
SET NOCOUNT ON

SELECT  Product.Id,
        Product.Name,
        Product.CostPrice,
        Product.SalePrice,
        Cart.Id

FROM Cart
JOIN Product on Product.Id = Cart.ProductId
WHERE @InputId = Cart.ProductId
END

EXEC SetProductToCardWithId @InputId = 3




CREATE PROCEDURE DeleteProduct @InputId INT
AS
DELETE from Cart
WHERE ProductID = @InputId
GO


SELECT * from Cart

EXEC DeleteProduct @InputId = 2
EXEC DeleteProduct @InputId = 3


CREATE TRIGGER AddAndDeleteProductsFromCart 
ON Cart
After INSERT, DELETE
AS
BEGIN
SELECT  Product.Name,
        Product.SalePrice
FROM Cart
JOIN Product ON Cart.ProductId = Product (Id)





