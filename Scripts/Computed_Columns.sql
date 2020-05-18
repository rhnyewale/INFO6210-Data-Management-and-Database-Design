------------------------------------------------------------------------
----COMPUTED COLUMN USING FUNCTION-------CALCULATE AGE------------------
------------------------------------------------------------------------

USE e_commerce_database;

ALTER TABLE Customer ADD CurrentAge AS DATEDIFF(YEAR, DOB, GETDATE())

SELECT * FROM Customer

ALTER TABLE DeliveryBoy ADD CurrentAge AS DATEDIFF(YEAR, DOB, GETDATE())

SELECT * FROM DeliveryBoy

ALTER TABLE SupplierContact ADD CurrentAge AS DATEDIFF(YEAR, DOB, GETDATE())

SELECT * FROM SupplierContact