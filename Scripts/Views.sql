----------------------------------------------------------------------------
--------VIEWS---------------------------------------------------------------
----------------------------------------------------------------------------


USE e_commerce_database;

-----------------------------------------------------------------------------
---------------------------VIEW--SupplierDetails-----------------------------
--This View provides the details of Supplier who has supplied----------------
--the products with the help of their Supplier_contact-----------------------
-----------------------------------------------------------------------------

CREATE VIEW SupplierDetails AS

SELECT s.CompanyName,sc.ContactFName,sc.ContactLName,sc.CurrentAge,sc.PhoneNumber,a.State,p.ProductName,
	   sp.Quantity,p.ProductDescription,c.CategoryName
		
FROM Supplier s
INNER JOIN SupplierContact sc
ON sc.SupplierId = s.SupplierId
INNER JOIN SupplierContactHasAddress sca
ON sc.SupplierContactId = sca.SupplierContactId
INNER JOIN Address a
ON a.AddressID = sca.AddressId
INNER JOIN Supply sp
ON sp.SupplierContactId = sc.SupplierContactId
INNER JOIN Product p
ON p.ProductId = sp.ProductId
INNER JOIN Category c
ON c.CategoryId = p.CategoryId;



Select * From SupplierDetails



-----------------------------------------------------------------------------------------------------------------
---VIEW--CUSTOMER_DETAILS----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-- In this view we are displaying all the details related to the Customer, we will be able to--------------------
--view the region from where the customer has ordered the product, we can also view the Payment Details----------
-- Card Details, Products Ordered by the Customer----------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------


CREATE VIEW CustomerDetails AS
SELECT (c.FirstName+ ' '+ c.LastName) as Fullname, a.State,a.City,a.Zip, p.PaymentId, pd.BankName,
	    pd.Credit_card_number_encrypt, o.OrderId, ol.OrderLineId,o.OrderDate,prd.ProductName,
		prd.ProductDescription, ctg.CategoryName,prd.Price ,ol.Quantity,ol.TotalPrice, o.Amount
FROM Customer c
INNER JOIN Payment p
ON p.CustomerId = c.CustomerId
INNER JOIN PaymentDetails pd
ON pd.PaymentId = p.PaymentId
INNER JOIN Orders o
ON o.OrderId = p.OrderId
INNER JOIN OrderLine ol
ON ol.OrderId = o.OrderId
INNER JOIN Product prd
ON prd.ProductId = ol.ProductId
INNER JOIN Category ctg
ON ctg.CategoryId = prd.CategoryId
INNER JOIN CustomerHasAddress cha
ON c.CustomerId = cha.CustomerId
INNER JOIN Address a
ON a.AddressID = cha.AddressId;





SELECT * FROM CustomerDetails;