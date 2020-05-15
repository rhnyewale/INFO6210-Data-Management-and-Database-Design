
----------------------------------------------------------------
-----TRIGGER----------------------------------------------------
----------------------------------------------------------------

USE e_commerce_database;

----------------------------------------------------------------
---BackUp TABLE - ProductAudit----------------------------------
----------------------------------------------------------------

CREATE TABLE ProductAudit(

	ProductAuditId INT PRIMARY KEY IDENTITY(1,1),
	ProductId INT NOT NULL,
	ManufactureId INT NOT NULL,
	CategoryId INT NOT NULL,
	ProductName VARCHAR (45),
	ProductDescription VARCHAR(45),
	DiscountAvailable VARCHAR(45),
	Color VARCHAR(45),
	Price Decimal(12,2),
	Availability VARCHAR(45),
	Action VARCHAR(3),
	ActionDate Datetime

)

---------------------------------------------------------------
---TRIGGER - ProductAuditTable---------------------------------
--have created 2 triggers in which I will be able take---------
-- a backup of the table product_details on update by ---------
--any user. The old data will be stored on a separate table.---
---------------------------------------------------------------

CREATE TRIGGER ProductAuditTable ON Product
AFTER UPDATE
AS BEGIN
	Declare @action VARCHAR(3)
	SET @action = 'U'

	INSERT INTO ProductAudit(
		ProductId,
		ManufactureId,
		CategoryId,
		ProductName,
		ProductDescription,
		DiscountAvailable,
		Color,
		Price,
		Availability,
		Action,
		ActionDate
	)
	SELECT 
		ProductId,
		ManufactureId,
		CategoryId,
		ProductName,
		ProductDescription,
		DiscountAvailable,
		Color,
		Price,
		Availability,
		@action,
		GETDATE()
	FROM deleted

END

SELECT * FROM ProductAudit

---------------------------------------------------------
---TRIGGER- CUSTOMER AUDIT-------------------------------
--------------------------------------------------------- 

CREATE TABLE CustomerAudit(
  CustomerAuditId INT PRIMARY KEY IDENTITY(1,1),
  CustomerId INT NOT NULL,
  FirstName	 VARCHAR(45) NOT NULL,
  LastName	 VARCHAR(45) NOT NULL,
  DOB		 DATE NOT NULL,
  Gender	 VARCHAR(6) NOT NULL,
  PhoneId	 VARCHAR(15) NULL DEFAULT NULL,
  EmailId	 VARCHAR(45) NULL DEFAULT NULL,
  updated_at DATETIME NOT NULL,
  operation VARCHAR(8) NOT NULL,
    CHECK(operation = 'INSERT' or operation='DELETE'));
  
  select * from CustomerAudit

---------------------------------------------------------------------
--Creating Trigger for insert and delete operations------------------
---------------------------------------------------------------------

 CREATE TRIGGER CustomerBackup
   ON  Customer
   AFTER INSERT,DELETE,UPDATE
AS 
BEGIN
	INSERT INTO CustomerAudit (
	CustomerId,
	FirstName,
	LastName,
	DOB,
	Gender,	
	PhoneId,
	EmailId,
	updated_at,
	operation 
	  )
	  SELECT 
	  i.CustomerId,
	  FirstName,
	  LastName,
	  DOB,
	  Gender,
	  PhoneId,
	  EmailId,
	  GETDATE(),
	  'INSERT'
	  from 
	  inserted as i 
	  UNION ALL
SELECT 
	  d.CustomerId,
	  FirstName,
	  LastName,
	  DOB,
	  Gender,
	  PhoneId,
	  EmailId,
	  getdate(),
	  'DELETE'
	  FROM deleted as d;

END

INSERT INTO Customer(CustomerId,FirstName,LastName,DOB,Gender,PhoneId,EmailId) VALUES (9999,'ADISH','JOSHI','1997-11-26','Male','6179562274','adish@instagram.com');

SELECT * FROM Customer
WHERE CustomerId = 9999

SELECT * FROM CustomerAudit
