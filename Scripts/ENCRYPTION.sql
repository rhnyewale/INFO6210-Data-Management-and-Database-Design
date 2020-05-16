USE e_commerce_database

SELECT *
FROM sys.symmetric_keys
WHERE name = '##MS_ServiceMasterKey##';

-- Create database Key
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Password123';

-- Create self signed certificate
CREATE CERTIFICATE Certificate1
WITH SUBJECT = 'Protect Data';
GO

-- Create symmetric Key
CREATE SYMMETRIC KEY SymmetricKey1 
 WITH ALGORITHM = AES_128 
 ENCRYPTION BY CERTIFICATE Certificate1;


ALTER TABLE PaymentDetails
ADD Credit_card_number_encrypt varbinary(MAX) NULL

-- Populating encrypted data into new column

-- Opens the symmetric key for use
OPEN SYMMETRIC KEY SymmetricKey1
DECRYPTION BY CERTIFICATE Certificate1;


UPDATE PaymentDetails
SET Credit_card_number_encrypt = EncryptByKey (Key_GUID('SymmetricKey1'),CardNumber)
FROM Payment;

-- Closes the symmetric key
CLOSE SYMMETRIC KEY SymmetricKey1;

SELECT * FROM PaymentDetails