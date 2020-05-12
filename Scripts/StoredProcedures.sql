USE e_commerce_database


------------------------------------------------------------
-----------STORED PROCEDURE - GetHighestOrderByGender-------
------------------------------------------------------------
-----------------------------------------------------------
--In this Stored Procedure we have 1 INPUT Parameter and 2 OUTPUT 
--Parameters, we will pass the Gender of the Customer and the Procedure
---------------------------------------------------------------------------

ALTER PROCEDURE GetHighestOrderByGender
@Gender varchar(6),
@HighestOrder INT OUTPUT,
@CustomerName VARCHAR(45) OUTPUT
AS BEGIN 
	SELECT top 5 sum(Amount), c.FirstName, c.LastName
	FROM Orders o
	INNER JOIN Customer c
	ON c.CustomerId = o.CustomerId
	GROUP BY c.FirstName, c.LastName
	ORDER BY sum(o.Amount) DESC
	HAVING c.Gender = 
END

DECLARE @HighestOrderByGender INT, @FullName VARCHAR(45)
EXEC GetHighestOrderByGender 'Male', @HighestOrderByGender OUTPUT, @FullName OUTPUT
SELECT @HighestOrderByGender as Amount$, @FullName as FullName


-------------------------------------------------------------------------
--STORED PROCEDURE - CustomerOrderHistory--------------------------------
-------------------------------------------------------------------------
--The below stored procedure will give the Entire Order History of the--- 
--Customer when an Customer Id is Passed --------------------------------
-------------------------------------------------------------------------

CREATE PROCEDURE CustomerOrderHistory
@CustomerId INT
AS BEGIN
	
	SELECT c.CustomerId, c.FirstName, c.LastName, o.OrderId,o.Amount,
		   o.OrderDate, p.ProductId,p.ProductName
	FROM Customer c
	INNER JOIN Orders o
	ON c.CustomerId = o.CustomerId
	INNEr JOIN OrderLine ol
	ON ol.OrderId = o.OrderId
	INNER  JOIN Product p
	ON p.ProductId = ol.ProductId
	WHERE c.CustomerId = @CustomerId
	ORDER BY o.OrderDate

END

EXEC CustomerOrderHistory @CustomerId = 3000

-----------------------------------------------------------------------------------------
--STORED PROCEDURE - TotalSalesPerDay----------------------------------------------------
-----------------------------------------------------------------------------------------
--The below stored procedure can be used to find the total sales that are generated on a
--particular date. When we put the date into the input of the stored procedure ,the total
--sales we want to find gets displayed on the output.
-----------------------------------------------------------------------------------------
CREATE PROCEDURE TotalSalesPerDay
@OrderDate DATE
AS BEGIN

	SELECT o.OrderDate, sum((p.Price-(p.Price*p.DiscountAvailable ))*ol.Quantity ) as TotalSale$
	FROM Orders o
	INNER JOIN OrderLine ol
	ON ol.OrderId = o.OrderId
	INNER JOIN Product p
	ON p.ProductId = ol.ProductId
	WHERE o.OrderDate = @OrderDate
	GROUP BY o.OrderDate

END

EXEC TotalSalesPerDay @OrderDate = '2019-04-12'


---------------------------------------------------------------------------------
--STORED PROCEDURE-UpdateProductAvailibilty
---------------------------------------------------------------------------------
-- I have created a stored procedure in which if a enter an input which is
-- the id of the table ‘Product’, the attribute named ’availablity’ 
-- will be set to sold and the old details will be reflected on the back_up table 
-- since the stored procedure will also fire the trigger--------------------------.
----------------------------------------------------------------------------------
CREATE PROCEDURE UpdateProductAvailibilty
@ProductId INT
AS BEGIN
	
	UPDATE Product
	SET Availability = 'Sold'
	WHERE ProductId = @ProductId;

END

EXEC UpdateProductAvailibilty @ProductId = 133

SELECT * FROM Product WHERE Availability = 'Sold'

SELECT * FROM ProductAudit